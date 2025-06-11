module SymbolTable.API.SymbolTable where

import qualified Data.Map as Map

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
  deriving Show

data ExplanationTag =
    Enter ExplanationTag
  | Exit ExplanationTag
  | Parameter
  | Variable
  | Update
  | MethodScope
  | IfScope
  | WhileScope
  | ForScope
  deriving Show

type Scope = Map.Map String (Maybe SymbolType,ExplanationTag)

type SymbolTable = [Scope]
