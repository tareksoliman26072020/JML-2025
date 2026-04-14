{-# Language LambdaCase #-}
module JML.PrettyPrint where

import JML.Types (Clause(..), Expr(..))
import Data.List (intercalate)
import Text.Printf (printf)

loc :: String
loc = "JML.PrettyPrint.ppClause"

list :: b -> ([a] -> b) -> [a] -> b
list ifEmpty ifFull = \case
  [] -> ifEmpty
  li -> ifFull li

ppClause :: Clause -> String
ppClause clause = case clause of
  ExceptionalBehavior{} -> intercalate "\n  "
    $ filter (not . null) [
     -- ExceptionalBehavior
     "@ Exceptional Behavior"
    ,-- requires
      printf
     "@   requires %s;" $ maybe "true" ppExpr (requires clause)
    ,-- signals
      printf
     "@   signals %s;" (signals clause)
    ,-- assignable
      printf
     "@   assignable %s;" $ list "\\nothing"
       (intercalate ", " . map (show . ppExpr)) (assignable clause)
    ,-- ensures
     case ensures clause of
       Nothing -> ""
       Just expr -> printf
         "@   ensures \\result == %s;" (ppExpr expr)
    ]
{-
NormalBehavior {requires = Nothing, assignable = [], ensures = Just (Int 5)}
/*@ normal behavior
  @ requires true;
  @ assignable \nothing;
  @ ensures \result == 5;
  @*/
 -}
  NormalBehavior{} -> intercalate "\n  "
    $ filter (not . null) [
     -- Normal Behavior
     "@ Normal Behavior"
    ,-- requires
      printf
     "@   requires %s;" $ maybe "true" ppExpr (requires clause)
    ,-- assignable
      printf
     "@   assignable %s;" $ list "\\nothing"
       (intercalate ", " . map (show . ppExpr)) (assignable clause)
    ,-- ensures
     case ensures clause of
       Nothing -> ""
       Just expr -> printf
         "@   ensures \\result == %s;" (ppExpr expr)
    ]
  _ -> error $ "JML.PrettyPrint.ppClause ==> TODO: " ++ show clause

ppExpr :: Expr -> String
ppExpr expr = case expr of
  Int num -> show num
  Double num -> show num
  _ -> error $ "JML.PrettyPrint.ppExpr ==> TODO: " ++ show expr

ppClauses :: [Clause] -> String
ppClauses clauses =
  let res = intercalate "\n  @ also\n" $ map ppClause clauses
  in "/*" ++ res ++ "\n  @*/"
