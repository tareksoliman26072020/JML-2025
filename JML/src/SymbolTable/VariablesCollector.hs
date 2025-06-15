module SymbolTable.VariablesCollector where

import Parser.Types as AST
import SymbolTable.Types

newtype VariablesCollector = VariablesCollector Method

{-
instance ASTVisitor VariablesCollector where
  visitMethod :: v -> ExternalDeclaration -> v
  visitStatement :: v -> Statement -> v
  visitExpression :: v -> Expression -> v
-}
