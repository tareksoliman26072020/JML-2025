module SymbolTable.Types where

import Parser.Types (Expression)

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

data Kind = For Expression | While Expression | Try | Catch | Finally | If Expression | Else

data Variable = Variable {
  name    :: String,
  varType :: Maybe Type,
  val     :: Maybe Expression
}

type Pos = Int

data Method = Method {
  methodName :: String,
  methodType :: Type,
  scope      :: Scope
}

data Scope = Scope {
  outsiderVars :: [Variable],
  size         :: Int,
  vars         :: [(Pos,Variable)],
  scopes       :: [(Pos,Kind,Scope)]
}

----------
