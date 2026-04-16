{-# Language LambdaCase #-}
module JML.PrettyPrint where

import JML.Types (Behavior(..), Expr(..))
import Data.List (intercalate)
import Text.Printf (printf)

loc :: String
loc = "JML.PrettyPrint.ppBehavior"

list :: b -> ([a] -> b) -> [a] -> b
list ifEmpty ifFull = \case
  [] -> ifEmpty
  li -> ifFull li

ppBehavior :: Behavior -> String
ppBehavior behavior = case behavior of
  ExceptionalBehavior{} -> intercalate "\n  "
    $ filter (not . null) [
     -- ExceptionalBehavior
     "@ Exceptional Behavior"
    ,-- requires
      printf
     "@   requires %s;" $ maybe "true" ppExpr (requires behavior)
    ,-- signals
      printf
     "@   signals %s;" (signals behavior)
    ,-- assignable
      printf
     "@   assignable %s;" $ list "\\nothing"
       (intercalate ", " . map ppExpr) (assignable behavior)
    ,-- ensures
     intercalate "\n  " $ map (printf "@   ensures %s;" . ppExpr) (ensures behavior)
     {-case ensures behavior of
       Nothing -> ""
       Just expr -> printf
         "@   ensures \\result == %s;" (ppExpr expr)-}
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
     "@   requires %s;" $ maybe "true" ppExpr (requires behavior)
    ,-- assignable
      printf
     "@   assignable %s;" $ list "\\nothing"
       (intercalate ", " . map ppExpr) (assignable behavior)
    ,-- ensures
     intercalate "\n  " $ map (printf "@   ensures %s;" . ppExpr) (ensures behavior)
     {-case ensures behavior of
       Nothing -> ""
       Just expr -> printf
         "@   ensures \\result == %s;" (ppExpr expr)-}
    ]
  _ -> error $ "JML.PrettyPrint.ppBehavior ==> TODO: " ++ show behavior

ppExpr :: Expr -> String
ppExpr expr = case expr of
  Int num -> show num
  Double num -> show num
  Num num -> show num
  Var vn -> vn
  expr1 `Equals` expr2 -> printf "%s == %s" (ppExpr expr1) (ppExpr expr2)
  Old expr -> printf "\\old(%s)" (ppExpr expr)
  Result expr -> printf "\\result == %s" (ppExpr expr)
  _ -> error $ "JML.PrettyPrint.ppExpr ==> TODO: " ++ show expr

ppBehaviors :: [Behavior] -> String
ppBehaviors behaviors =
  let res = intercalate "\n  @ also\n" $ map ppBehavior behaviors
  in "/*" ++ res ++ "\n  @*/"
