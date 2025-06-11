module SymbolTable.API.SymbolTable where

import Data.Map.Ordered (OMap)

data SymbolType =
    Int
  | Void
  | Char
  | String
  | Boolean
  | Double
  | Short
  | Float
  | Long
  | Byte
  | Array SymbolType
  deriving Show

data ExplanationTag =
    Enter ExplanationTag
  | Exit ExplanationTag
  | Parameter
  | Variable
  | Update
  | MethodScope
  | IfScope
  | ElseScope
  | WhileScope
  | ForScope
  | TryScope
  | CatchScope
  deriving Show

type Scope = OMap (Int,Maybe String) (Maybe SymbolType,ExplanationTag)

type SymbolTable = [Scope]

