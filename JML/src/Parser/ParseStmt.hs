module Parser.ParseStmt where

import Data.Char (toLower)
import Data.Maybe (isJust)
import Data.List (nub)

import Parser.ParseExpr
import Parser.Types

import Text.ParserCombinators.Parsec

parseBlock :: Parser Statement
parseBlock = CompStmt <$>
  (skipChar '{' *> many (parseStmt <* many (skipChar ';')) <* skipChar '}')

modifiers :: [Modifier]
modifiers =
  [ Static
  , Public
  , Private
  , Protected
  , Final
  , Abstract ]

parseModifiers :: Parser [Modifier]
parseModifiers = nub <$> many
  (choice $ map (\ m -> m <$ keyword (map toLower $ show m)) modifiers)

parseCompoundAssignment :: Parser Statement
parseCompoundAssignment = do
  e1 <- parseVar_or_FunCall_or_Array
  o  <- choice $ map skipString ["+=","-=","*=","/="]
  e2 <- parseExpr
  let op = case o of
        "+=" -> Plus
        "-=" -> Minus
        "*=" -> Mult
        "/=" -> Div
        _    -> undefined
  return $ AssignStmt [] $ AssignExpr e1 (BinOpExpr e1 op e2)

parseDeclOrFunCall :: Parser Statement
parseDeclOrFunCall = do
  mAssignExpr <- optionMaybe $ try $ parseAssignExpr1 <|> parseAssignExpr2
  case mAssignExpr of
    Just ae@AssignExpr{} -> return $ AssignStmt [] ae
    Nothing -> try parseCompoundAssignment <|> do
      l <- parseModifiers
      e <- parseVar_or_FunCall_or_Array
      m <- optionMaybe $ skipChar '=' *> parseExpr
      return $ case m of
        Just v -> AssignStmt l (AssignExpr e v)
        _ -> case e of -- ignore modifiers
          FunCallExpr {} -> FunCallStmt e
          _ -> VarStmt e -- could be an array
    _ -> undefined

parseIf :: Parser Statement
parseIf = do
  i <- keyword "if" *> parenExpr
  t <- parseStmt
  m <- optionMaybe $ keyword "else" *> parseStmt
  pure . CondStmt i t $ case m of
    Just e -> e
    _ -> CompStmt []

parseFor :: Parser Statement
parseFor = do
  i <- keyword "for" *> skipChar '(' *> parseStmt <* skipChar ';'
  c <- parseExpr <* skipChar ';'
  s <- parseStmt <* skipChar ')'
  ForStmt i c s <$> parseStmt

parseWhile :: Parser Statement
parseWhile = do
  i <- keyword "while" *> skipChar '(' *> parseExpr <* skipChar ')'
  WhileStmt i <$> parseStmt

parseTry :: Parser Statement
parseTry = do
  t <- keyword "try" *> parseStmt
  e <- keyword "catch" *> skipChar '(' *> ident
  v <- ident
  b <- skipChar ')' *> parseStmt
  m <- optionMaybe $ keyword "finally" *> parseStmt
  pure . TryCatchStmt t (AnyType e . Just $ AnyType v Nothing) b $ case m of
    Just f -> f
    _ -> CompStmt []

parseReturn :: Parser Statement
parseReturn = keyword "return" *> (ReturnStmt <$> optionMaybe parseExpr)

parseExcp :: Parser Statement
parseExcp = do
  i <- keyword "throw" *> keyword "new" *> ident
  ReturnStmt . Just . ExcpExpr (Exception i) <$> optionMaybe
    (skipChar '(' *> skip stringLit <* skipChar ')')

parseStmt :: Parser Statement
parseStmt = parseBlock <|> parseIf <|> parseFor <|> parseWhile <|> parseTry
  <|> parseReturn <|> parseExcp <|> parseDeclOrFunCall

parseComment :: Parser ()
parseComment = choice [
    (try $ string "/*" *> manyTill anyChar (try $ string "*/") <* many space),
    (try $ string "//" *> manyTill anyChar (char '\n') <* many space),
    (try $ string "//" *> manyTill anyChar eof <* many space)
  ] *> return ()
  

parseExtDecl :: Parser Method
parseExtDecl = many parseComment *> do
  l <- parseModifiers
  b <- optionMaybe $ keyword "/*@" *> keyword "pure" <* keyword "@*/"
  t <- parseVar_or_FunCall -- arguments are obligatory here
  e <- optionMaybe $ keyword "throws" *> (Exception <$> ident)
  FunDef l (isJust b) (FunCallStmt t) e <$> parseStmt

parseDeclList :: Parser [Method]
parseDeclList = spaces *> many (try parseExtDecl) <* many parseComment <* eof
