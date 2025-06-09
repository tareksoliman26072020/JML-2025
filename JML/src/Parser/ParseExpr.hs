module Parser.ParseExpr where

import Data.Char
import Parser.Types

import Text.ParserCombinators.Parsec

skip :: Parser a -> Parser a
skip = (<* spaces)

signs :: String
signs = "!%&*+-./:<=>?@|"

keyword :: String -> Parser String
keyword s = skip . try $ string s <* notFollowedBy
  (if all idCh s then idChar else oneOf signs)

idCh :: Char -> Bool
idCh c = isAlphaNum c || c `elem` "$_"

idChar :: Parser Char
idChar = satisfy idCh

keywords :: [String]
keywords = words
   $ "abstract   continue   for          new         switch"
  ++ " assert     default    if           package     synchronized"
  ++ " boolean    do         goto         private     this"
  ++ " break      double     implements   protected   throw"
  ++ " byte       else       import       public      throws"
  ++ " case       enum       instanceof   return      transient"
  ++ " catch      extends    int          short       try"
  ++ " char       final      interface    static      void"
  ++ " class      finally    long         strictfp    volatile"
  ++ " const      float      native       super       while"

ident :: Parser String
ident = try $ do
  c <- satisfy (\ c -> isLetter c || c == '_')
  r <- many idChar
  let i = c : r
  if i `elem` keywords then unexpected $ "keyword: " ++ i else skip (return i)

numberLit :: Parser Float
numberLit = do
  m1  <- optionMaybe $ char '-'
  i1  <- many1 digit
  mi2 <- optionMaybe $ char '.' *> many1 digit
  let left  = maybe i1 (const $  '-' : i1) m1
      right = maybe ".0" ("." ++) mi2
  return $ read $ left ++ right

charLit :: Parser Char
charLit = char '\'' *> ((char '\\' *> oneOf "\\'") <|> noneOf "'") <* char '\''

stringLit :: Parser String
stringLit =
  char '"' *> many ((char '\\' *> oneOf "\\\"") <|> noneOf "\"") <* char '"'

javaLit :: Parser Expression
javaLit =
      NumberLiteral <$> numberLit
  <|> CharLiteral   <$> charLit
  <|> StringLiteral <$> stringLit

skipChar :: Char -> Parser Char
skipChar = skip . char

skipString :: String -> Parser String
skipString = skip . string

parenExpr :: Parser Expression
parenExpr = skipChar '(' *> parseExpr <* skipChar ')'

primExpr :: Parser Expression
primExpr = skip javaLit
  <|> UnOpExpr NotOp <$> (skipChar '!' *> primExpr)
  <|> parenExpr
  <|> Null <$ keyword "null"
  <|> BoolLiteral True <$ keyword "true"
  <|> BoolLiteral False <$ keyword "false"
  <|> parseVar_or_FunCall_or_Array

parseVar :: Parser Expression
parseVar = parseArrayInstantiation <|> do
  t <- parseArrType
  (mt, i) <- case t of
    AnyType i Nothing -> do -- i may be the variable not a type
      m <- optionMaybe ident
      case m of
        Just j -> pure (Just t, j)
        Nothing -> pure (Nothing, i)
    _ -> do
      i <- ident
      pure (Just t, i)
  q <- many $ skipChar '.' *> ident
  let l = i : q
  pure . VarExpr mt (init l) $ last l

parseVar_or_FunCall :: Parser Expression
parseVar_or_FunCall = do
  v <- parseVar
  l <- optionMaybe
    $ skipChar '(' *> sepBy parseExpr (skipChar ',') <* skipChar ')'
  pure $ case l of
    Just args -> FunCallExpr v args
    _ -> v

parseVar_or_FunCall_or_Array :: Parser Expression
parseVar_or_FunCall_or_Array = do
  e <- parseVar_or_FunCall
  l <- optionMaybe
    $ skipChar '[' *> parseExpr <* skipChar ']'
  pure $ case l of
    Nothing -> e
    _ -> ArrayCallExpr e l

binOps :: [BinOp]
binOps = [ Plus, Mult, Minus, Div, Mod, Less, LessEq, Greater, GreaterEq
  , Eq, Neq, And, Or ]

parseBinOp :: Prec -> Parser BinOp
parseBinOp p =
  choice . map (\ a -> a <$ keyword (show a)) $ filter ((== p) . prec) binOps

parseBinExpr :: Prec -> Parser Expression
parseBinExpr p =
  let q = if p == PMul then primExpr else parseBinExpr (pred p)
      o = flip BinOpExpr <$> parseBinOp p
  in case assoc p of
       ALeft -> chainl1 q o
       ARight -> chainr1 q o
       ANon -> do
         e <- q
         m <- optionMaybe $ parseBinOp p
         case m of
           Nothing -> pure e
           Just b -> BinOpExpr e b <$> q

parseAssignExpr1 :: Parser Expression
parseAssignExpr1 = do
  e <- parseBinExpr POr
  op <- skipString "++" <|> skipString "--"
  return $ AssignExpr {
      assEleft  = e,
      assEright = BinOpExpr {
        expr1 = e, 
        binOp = case op of
          "++" -> Plus
          "--" -> Minus
          _    -> undefined, 
        expr2 = NumberLiteral 1
      }
    }

parseAssignExpr2 :: Parser Expression
parseAssignExpr2 = do
  op <- skipString "++" <|> skipString "--"
  e <- parseBinExpr POr
  return $ AssignExpr {
      assEleft  = e,
      assEright = BinOpExpr {
        expr1 = e, 
        binOp = case op of
          "++" -> Plus
          "--" -> Minus
          _    -> undefined, 
        expr2 = NumberLiteral 1
      }
    }

parseExpr :: Parser Expression
parseExpr = do
  e1 <- try (parseAssignExpr1 <|> parseAssignExpr2) <|> parseBinExpr POr
  m <- optionMaybe $ skipChar '?'
  case m of
    Just _ -> do
      e2 <- parseExpr <* skipChar ':'
      CondExpr e1 e2 <$> parseExpr
    _ -> pure e1

baseTypes :: [Types]
baseTypes = [Int, Void, Char, Double, Short, Float, Long, Boolean, Byte]

parseBaseType :: Parser Types
parseBaseType =
  choice $ map (\ a -> a <$ keyword (map toLower $ show a)) baseTypes

refType :: Parser (Type Types)
refType = do
  i <- ident
  AnyType i <$> optionMaybe (try $ skipChar '<' *> refType <* skipChar '>')

parseType :: Parser (Type Types)
parseType = BuiltInType <$> parseBaseType <|> refType

parseArrType :: Parser (Type Types)
parseArrType = do
  t <- parseType
  l <- many . try $ skipChar '[' *> skipChar ']'
  pure $ foldr (\ _ r -> ArrayType r) t l

parseArrayInstantiation :: Parser Expression
parseArrayInstantiation = choice $ map try
  [parseArrayInstantiation1,parseArrayInstantiation2,parseArrayInstantiation3]

-- in `parseArrayInstantiation1` I used `parseBaseType` to denote the fact
-- that I'm only considering base types 
-- expressions of form `new int[5]` are being parsed here
parseArrayInstantiation1 :: Parser Expression
parseArrayInstantiation1 = skipString "new" *> do
  bt <- parseBaseType <|> const String <$> keyword "String"
  size <- skipChar '[' *> parseExpr <* skipChar ']'
  return $ ArrayInstantiationExpr {
    arrType = Just $ ArrayType (BuiltInType bt),
    arrSize = Just size,
    arrElems = []
  }

-- expressions of form `new int[]{11,22,33,44,55}` are being parsed here
parseArrayInstantiation2 :: Parser Expression
parseArrayInstantiation2 = skipString "new" *> do
  bt <- parseBaseType <|> const String <$> keyword "String"
  arr <- skipString "[]" *> parseArrayInstantiation3
  return $ ArrayInstantiationExpr {
    arrType = Just $ ArrayType (BuiltInType bt),
    arrSize = Nothing,
    arrElems = arrElems arr
  }

-- expressions of form `{11,22,33,44,55}` are being parsed here
parseArrayInstantiation3 :: Parser Expression
parseArrayInstantiation3 = do
  elems <- skipChar '{' *> sepBy javaLit (skipChar ',') <* skipChar '}'
  return $ ArrayInstantiationExpr {
    arrType = Nothing,
    arrSize = Nothing,
    arrElems = elems
  }
