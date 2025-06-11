module SymbolTable.Impl.Internal where

import SymbolTable.API.Visitor
import Data.List(foldl')
--import SymbolTable.API.SymbolTable

visitMethod :: (Expression e, Statement s e, Visitor sc, Method m s e) => m -> [sc]
visitMethod m = undefined

visitStatement :: (Expression e, Visitor sc, Statement s e) => st -> s -> [sc]
visitStatement st s
  | isBranch s = error "TODO"
  | otherwise = case getExpression s of
                  Nothing   -> error "TODO"
                  Just expr -> undefined--visitExpression st expr

visitExpression :: (Expression e, Visitor st) => st -> e -> st
visitExpression st e = undefined
