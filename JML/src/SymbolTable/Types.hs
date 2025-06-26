module SymbolTable.Types where

import Parser.Types (Expression)
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
  deriving Show

data Kind = For Expression | While Expression | Try | Catch | Finally | If Expression | Else

instance Show Kind where
  show (For _) = "For"
  show (While _) = "While"
  show Try = "Try"
  show Catch = "Catch"
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
  val     :: Maybe Expression
}

instance Show Entry where
  show entry = pp 0 entry

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
