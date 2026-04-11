module Visitors.API where

import qualified Parser.Types as AST
import qualified CFG.Types as CFG
import qualified SymbolicExecution.Types as SY

class ASTVisitor v where
  visitMethod :: AST.Method -> v
  visitStatement :: AST.Statement -> v

class CFGVisitor v where
  visitNode :: CFG.Node -> v

class SymbolicExecutionVisitor v where
  visitSymExpr :: (SY.SymStateKey,SY.SymExpr) -> v
