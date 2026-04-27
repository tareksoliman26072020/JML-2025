{-# Language LambdaCase #-}
module JML.PrettyPrint where

import JML.Types (Behavior(..), Expr(..), Op(..), DefinedFun(..))
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
     "@ exceptional_behavior"
    ,-- requires
      printf
     "@   requires %s;" $ maybe "true" ppExpr (requires behavior)
    ,-- signals
      printf
     "@   signals %s;" (signals behavior)
    ,-- assignable
      printf
     "@   assignable %s;" $ list "\\nothing"
       (intercalate ", ") (assignable behavior)
    ,-- ensures
     intercalate "\n  "
     $ map (printf "@   ensures %s;" . ppExpr)
     $ filter (\case JMLResult JMLVoid -> False
                     _ -> True)
     $ ensures behavior
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
     "@ normal_behavior"
    ,-- requires
      printf
     "@   requires %s;" $ maybe "true" ppExpr (requires behavior)
    ,-- assignable
      printf
     "@   assignable %s;" $ list "\\nothing"
       (intercalate ", ") (assignable behavior)
    ,-- ensures
     intercalate "\n  "
     $ map (printf "@   ensures %s;" . ppExpr)
     $ filter (\case JMLResult JMLVoid -> False
                     _ -> True)
     $ ensures behavior
     {-case ensures behavior of
       Nothing -> ""
       Just expr -> printf
         "@   ensures \\result == %s;" (ppExpr expr)-}
    ]
  _ -> error $ "JML.PrettyPrint.ppBehavior ==> TODO: " ++ show behavior

ppExpr :: Expr -> String
ppExpr expr = case expr of
  JMLInt num -> show num
  JMLDouble num -> show num
  JMLNum num -> show num
  JMLVar _ vn -> vn
  expr1 `JMLEquals` expr2 -> printf "%s == %s" (ppExpr expr1) (ppExpr expr2)
  JMLOld expr -> printf "\\old(%s)" (ppExpr expr)
  JMLResult expr -> printf "\\result == %s" (ppExpr expr)
  JMLBin expr1 op expr2 -> case (expr1,expr2) of
    (JMLBin _ _ _,JMLBin _ _ _) -> printf "(%s) %s (%s)" (ppExpr expr1) (ppOp op) (ppExpr expr2)
    (JMLBin _ _ _,_) -> printf "(%s) %s %s" (ppExpr expr1) (ppOp op) (ppExpr expr2)
    (_,JMLBin _ _ _) -> printf "%s %s (%s)" (ppExpr expr1) (ppOp op) (ppExpr expr2)
    _ -> printf "%s %s %s" (ppExpr expr1) (ppOp op) (ppExpr expr2)
  JMLString str -> printf "\"%s\"" str
  JMLVarUnknown _ str -> "JMLVarUnknown " ++ str
  JMLBool b
    | b -> "true"
    | not b -> "false"
  JMLObjAcc li
    | null li -> error $ "JML.PrettyPrint.ppExpr ==> TODO1: JMLObjAcc []"
    | last li == "length" -> intercalate "." li
    | otherwise -> printf "JMLObjAcc [%s]" (intercalate ", " li)
  JMLArrayIndexAccess _ arrName arrIndexExpr -> printf "%s[%s]" arrName (ppExpr arrIndexExpr)
--JMLArray (Just Int_Type) (Just (JMLInt 2)) [JMLInt 99,JMLInt 5]
  JMLArray _ _ elems -> printf "[%s]" (intercalate ", " $ map ppExpr elems)
  expr1 `JMLAnd` expr2 -> printf "%s && %s" (ppExpr expr1) (ppExpr expr2)
  SymFun ToString expr -> printf "toString(%s)" (ppExpr expr)
  _ -> error $ "JML.PrettyPrint.ppExpr ==> TODO2: " ++ show expr

ppOp :: Op -> String
ppOp op = case op of
  Add -> "+"
  Mul -> "*"
  Sub -> "-"
  Gt -> ">"
  Le -> "<="
  Ge -> ">="
  Lt -> "<"
  Eq -> "=="
  Neq -> "!="
  _ -> error $ printf "JML.PrettyPrint.ppOp: TODO: %s" (show op)

ppBehaviors :: [Behavior] -> String
ppBehaviors behaviors = 
  let res = intercalate "\n  @ also\n  " $ map ppBehavior behaviors
  in "/*" ++ res ++ "\n  @*/"
