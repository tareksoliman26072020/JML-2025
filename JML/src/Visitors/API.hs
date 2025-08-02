module Visitors.API where

import qualified Parser.Types as AST
import qualified CFG.Types as CFG

class ASTVisitor v where
  visitMethod :: AST.Method -> v
  visitStatement :: AST.Statement -> v

class CFGVisitor v where
  visitNode :: CFG.Node -> v
