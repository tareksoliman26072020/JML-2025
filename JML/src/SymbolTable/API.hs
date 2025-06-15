module SymbolTable.API where

import Parser.Types

class ASTVisitor v where
  visitMethod :: v -> ExternalDeclaration -> v
  visitStatement :: v -> Statement -> v
  visitExpression :: v -> Expression -> v
