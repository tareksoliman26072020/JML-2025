{-# Language LambdaCase, ScopedTypeVariables #-}
module JML.PrettyPrint where

import JML.Types
import Data.List (intercalate, foldl',(\\))
import Text.Printf (printf)
import qualified CFG.Types as CFGT (CFG(..), Node(..), NodeData(..), Kind(..), ScopeRange(..))
import qualified CFG.Internal as CFG (ppNode,getEdge)

loc :: String
loc = "JML.PrettyPrint.ppBehavior"

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

list :: b -> ([a] -> b) -> [a] -> b
list ifEmpty ifFull = \case
  [] -> ifEmpty
  li -> ifFull li

-- the point is to display pre-conditions in different lines.
unflattenPreConditions :: Expr -> [Expr]
unflattenPreConditions expr = let
  loc = "JML.PrettyPrint.unflattenPreConditions" in
  case expr of
    JMLBin pre1 And pre2 -> pre1 : unflattenPreConditions pre2
    JMLBin _ NonFlattableAnd _ -> [expr]
    _ -> [expr]

ppBehavior :: Behavior -> String
ppBehavior behavior = let
  ppRequires = maybe "@   requires true;"
    (intercalate "\n  "
     . map (printf "@   requires %s;" . ppExpr)
     . unflattenPreConditions)
    (requires behavior)
  --ppRequires = printf "@   requires %s;" $ maybe "true" ppExpr (requires behavior)
  ppAssignable = printf
    "@   assignable %s;" $ list "\\nothing"
      (intercalate ", ") (assignable behavior)
  ppEnsures = intercalate "\n  "
    $ map (printf "@   ensures %s;" . ppExpr)
    $ filter (\case JMLResult JMLVoid -> False
                    _ -> True)
    $ ensures behavior
  in case behavior of
       ExceptionalBehavior{} -> intercalate "\n  "
         $ filter (not . null) [
             -- ExceptionalBehavior
             "@ exceptional_behavior"
           ,-- requires
             ppRequires
           ,-- signals
             printf "@   signals %s;" (signals behavior)
           ,-- assignable
             ppAssignable
           ,-- ensures
             ppEnsures
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
             ppRequires
           ,-- assignable
             ppAssignable
           ,-- ensures
             ppEnsures
         ]
       _ -> ""--error $ "JML.PrettyPrint.ppBehavior ==> TODO: " ++ show behavior

ppColoredClause :: Clause -> String
ppColoredClause (Requires (one,two) three) = printf
  "%s: %s\n\
  \%s: %s\n\
  \%s:\n\
  \    %s"
  (yellow "Scope Range") (show one)
  (yellow "Pre Condition") (show two)
  (yellow "Values")
  (intercalate "\n    "
   $ map (\(counter,value) -> printf
      "%s %s" (yellow $ printf "%d)" counter) (show value))
   $ zip [1::Int ..] three
  )

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
  JMLVarUnknown _ _ str _ -> "JMLVarUnknown " ++ str
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
  SymFun ToString expr -> printf "toString(%s)" (ppExpr expr)
  JMLNull _ -> "null"
--JMLBin (JMLInt 0) Lt (JMLVar Int_Type "n") `JMLImplies` JMLVar Int_Type "i"
  expr1 `JMLImplies` expr2 -> printf "(%s ==> %s)" (ppExpr expr1) (ppExpr expr2)
  JMLRange vn from to -> printf
    "%s <= %s <= %s" (ppExpr from) vn (ppExpr to)
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
  Mod -> "%"
  And -> "&&"
  NonFlattableAnd -> "&&"
  Or -> "||"
  _ -> error $ printf "JML.PrettyPrint.ppOp: TODO: %s" (show op)

ppBehaviors :: [Behavior] -> String
ppBehaviors behaviors = 
  let res = intercalate "\n  @ also\n  " $ map ppBehavior behaviors
  in "/*" ++ res ++ "\n  @*/"

ppLoopInvariantTemplate :: LoopInvariantTemplate -> String
ppLoopInvariantTemplate template = let
  loc = "JML.PrettyPrint" in
  case template of
  --CounterBoundsTemplate Expr String Expr
    CounterBoundsTemplate fromExpr counterName toExpr -> printf
      "maintaining %s <= %s && %s <= %s"
      (ppExpr fromExpr) counterName
      counterName (ppExpr toExpr)
  --StridedCounterTemplate
    StridedCounterTemplate counter stride residue -> printf
      "maintaining %s %% %s == %s"
      counter (ppExpr stride) (ppExpr residue)
  --LoopFrameTemplate [String]
    LoopFrameTemplate vars -> "loop_assigns " ++ (intercalate ", " vars)
  --DecreasesTemplate Expr
    DecreasesTemplate expr -> "decreases " ++ ppExpr expr

pp_CFG_JML :: CFGT.CFG -> [JMLSpecification] -> String
pp_CFG_JML cfg jmlSpecifications = let
  innerLoc = loc ++ ".pp_CFG_JML.helper"
  ppBehs = ppBehaviors [behavior | MethodSpecification behavior <- jmlSpecifications]
  (_,_,_,pp) = foldl' (helper innerLoc) (0,Nothing,[],"") (CFGT.nodes cfg)
  in ppBehs ++ "\n" ++ pp where
  ---
  getLoopInvariants :: [JMLSpecification] -> [LoopInvariants]
  getLoopInvariants li = [loopInvariants | LoopSpecification loopInvariants <- li]
  ---
  findLoopInvariant :: Int -> [JMLSpecification] -> [LoopInvariantTemplate]
  findLoopInvariant branchStart li = let
    loc = "JML.PrettyPrint.findLoopInvariant"
    x = [loopInvariantTemplates
          | LoopInvariants (CFGT.SR num _) loopInvariantTemplates <- getLoopInvariants li
          , num == branchStart
        ] in
    case x of
      [y] -> y
      _ -> error $ printf "TODO in %s ==> %s" loc (show x)
  helper :: String -> (Int,Maybe (CFGT.Node),[Int],String) -> CFGT.Node -> (Int,Maybe (CFGT.Node),[Int],String)
  helper innerLoc tu@(indent,maybe_last_node,else_ids,acc) node = case node of
  --Entry (AST.Type AST.Types) String [AST.Expression]
    CFGT.Entry _ _ _ -> (indent+2,Just node,else_ids,acc ++ CFG.ppNode node ++ " {\n")
    CFGT.Node id nodeData _ -> case nodeData of
      ---
      CFGT.Statement _
        | id `elem` else_ids -> (
            indent,
            Just node,
            else_ids \\ [id],
            acc ++ replicate (indent - 2) ' ' ++ "else {\n"
                ++ replicate indent ' ' ++ CFG.ppNode node ++ ";\n")
            
        | otherwise -> (indent,Just node,else_ids,acc ++ replicate indent ' ' ++ CFG.ppNode node ++ ";\n")
      ---
      CFGT.Meet _ -> let
        newIndent = indent - 2
        in (newIndent,Just node,else_ids,acc ++ replicate newIndent ' ' ++ "}\n")
      ---
      CFGT.BooleanExpression CFGT.While _ -> let
        newIndent = indent + 2
        spaces = replicate indent ' '
        new_maybe_last_node = Just node
        pp_invariants = intercalate "\n"
          $ [res | invariant <- findLoopInvariant id jmlSpecifications
                 , let res = spaces ++ "//@ " ++ ppLoopInvariantTemplate invariant ++ ";"]
        newAcc = acc ++ pp_invariants ++ "\n" ++
                 replicate indent ' ' ++ CFG.ppNode node ++ " {\n"
        in (newIndent,new_maybe_last_node,else_ids,newAcc)
      ---
      CFGT.BooleanExpression CFGT.If _ -> let
        newIndent = indent + 2
        spaces = replicate indent ' '
        new_maybe_last_node = Just node
        newAcc = acc ++
                 replicate indent ' ' ++ CFG.ppNode node ++ " {\n"
        edge :: [Int]
        edge = case CFG.getEdge cfg id of
          Just tu -> tu
          Nothing -> error $ printf "TODO1 in %s: %d" innerLoc id
        else_id :: [Int] = case edge of
          [_,x] -> [x]
          [_] -> []
        in (newIndent,new_maybe_last_node,else_ids ++ else_id,newAcc)
      ---
    CFGT.End _ _ _ -> let
      newIndent = indent - 2
      ppNode = CFG.ppNode node
      semicolon = case ppNode of
        "" -> ""
        _ -> ";"
      newAcc = acc ++ replicate indent ' ' ++ ppNode ++ semicolon ++ "\n" ++ replicate newIndent ' ' ++ "}\n"
      in (indent,Just node,else_ids,newAcc)
    _ -> error $ printf "TODO2 in %s:\n  %s\n  %s" innerLoc (show cfg) (show jmlSpecifications)
