module SymbolTable.Types where

import qualified Parser.Types as AST (Expression, Type, Exception)
import Data.Char (isSpace)

data Type
  = Array Type
  | Int
  | Void
  | Char
  | String
  | Boolean
  | Double
  | Short
  | Float
  | Long
  | Byte
instance Show Type where
  show (Array t) = show t ++ "[]"
  show Int = "Int"
  show Void = "Void"
  show Char = "Char"
  show String = "String"
  show Boolean = "Boolean"
  show Double = "Double"
  show Short = "Short"
  show Float = "Float"
  show Long = "Long"
  show Byte = "Byte"

data Kind = For AST.Expression | While AST.Expression | Try | Catch (AST.Type AST.Exception) | Finally | If AST.Expression | Else

instance Show Kind where
  show (For _) = "For"
  show (While _) = "While"
  show Try = "Try"
  show (Catch _) = "Catch"
  show Finally = "Finally"
  show (If _) = "If"
  show Else = "Else"

list :: b -> ([a] -> b) -> [a] -> b
list empty _ [] = empty
list _ f li = f li

type Pos = Int

data Entry = Scope {
  outsiderVars :: [Entry],           -- Variable
  size         :: Int,
  vars         :: [(Pos,Entry)],     -- Variable
  scopes       :: [(Pos,Kind,Entry)] -- Scope
} | Variable {
  name    :: String,
  varType :: Maybe Type,
  val     :: Maybe AST.Expression
} deriving Show


showEntry :: Entry -> String
showEntry = pp 0

pp :: Int -> Entry -> String
pp indent a@Scope{} =
  replicate indent ' ' ++ "{" ++ show (size a) ++ "\n" ++
  (case outsiderVars a of
     [] -> ""
     al -> replicate (indent+4) ' ' ++ "Outsider Vars:" ++ "\n" ++
           unlines (map (pp (indent+6)) al)
  ) ++
  (case vars a of
     [] -> ""
     al -> replicate (indent+4) ' ' ++ "Vars:" ++ "\n" ++
           unlines (map (\(pos,v) -> replicate (indent+6) ' ' ++ show pos ++ ": " ++ pp 0 v) al)
  ) ++
  (case scopes a of
     [] -> ""
     al -> unlines (map (\(pos,kind,entry) -> replicate (indent+4) ' ' ++ show pos ++ ": " ++ show kind ++ " scope:" ++ let str = pp (indent+4) entry in " " ++ dropWhile isSpace str) al)
  ) ++
  replicate indent ' ' ++ "}"
pp indent a@Variable{} =
  replicate indent ' ' ++ maybe "" ((++ " ") . show) (varType a) ++ name a
----------
