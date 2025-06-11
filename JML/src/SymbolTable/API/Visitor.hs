{-# Language MultiParamTypeClasses, FunctionalDependencies #-}
module SymbolTable.API.Visitor where

import qualified Parser.Types as AST (ExternalDeclaration(..), Statement, Expression)

class Visitor v where
  visitMethod     :: Method m s => v -> m -> v
  visitStatement  :: Statement s => v -> s -> v
  visitExpression :: Expression e => v -> e -> v

------------------------------

class Expression e where
class Statement s where
class Method m s | m -> s where
  getMethodBlock :: m -> s

------------------------------

instance Expression AST.Expression where
instance Statement AST.Statement where
instance Method AST.ExternalDeclaration AST.Statement where
  getMethodBlock m = AST.funBody m


