module SymbolTable.Impl.Internal where

import SymbolTable.API.Visitor
import Data.List(foldl')
import Data.Map.Ordered (OMap(..),(>|),assocs)
import SymbolTable.API.SymbolTable
import Parser.ParseStmt
import Text.ParserCombinators.Parsec

-- type Scope = OMap (Int,Maybe String) (Maybe SymbolType,ExplanationTag)
visitMethod :: (Expression e, Statement s e, Visitor k v e, Method m s e) => m -> [OMap k v]
visitMethod m =
  let --scope_with_parameters :: OMap k v
      scope_with_parameters =
        foldl' (\sc (num,expr) -> addToScope sc num expr) (enterMethod (getMethodName m))
               $ zip [(2 :: Int) ..] (getParameters m)
      scope_with_block_statements = undefined-- $ zip [length scope_with_parameters + 1 ..] (getBlock m)
  in [scope_with_parameters]

visitStatement :: (Expression e, Visitor k v e, Statement s e) => OMap k v -> (Int,s) -> [OMap k v]
visitStatement st (num,s)
  | isBranch s = error "TODO"
  | otherwise = case getExpression s of
                  Nothing   -> error "TODO"
                  Just expr -> undefined--visitExpression st expr

visitExpression :: (Expression e, Visitor k v e) => OMap k v -> e -> OMap k v
visitExpression st e = undefined

------------------------------
------------------------------
------------------------------
-- Testing: 

{-
fromList [
    ((1,Nothing),(Nothing,Enter MethodScope))
    ,((2,Just "arr"),(Just (Array Int),Parameter))
    ,((3,Just "pos"),(Just Int,Parameter))
]
-}
str :: String
str = "public int[] elemAt(int[] arr, int pos){\
      \  if(arr.length<=pos) {\
      \    throw new Exception(\"not found\");\
      \  }\
      \  return arr[pos];\
      \}"

omap_prettyprint :: (Show k1, Show k2, Show v1, Show v2) => [OMap (k1,k2) (v1,v2)] -> String
omap_prettyprint = foldl' f "" . zip [1 :: Int ..]
  where
--f :: String -> (Int,OMap (k1,k2) (v1,v2)) -> String
  f s (num,m) = s ++ "\n" ++ "Scope " ++ show num ++ ":\n" ++
    foldl' (\res (k,v) -> res ++ show k ++ "\t====>\t" ++ show v ++ "\n") "" (assocs m)

testing :: Either ParseError SymbolTable
testing = fmap visitMethod $ parse parseExtDecl "" str

testing_output :: IO()
testing_output = either (const (return ())) (putStrLn . omap_prettyprint) testing

