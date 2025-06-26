module SymbolTable.API where

import Parser.Types

class ASTVisitor v where
  visitMethod :: Method -> v
  visitStatement :: Statement -> v

