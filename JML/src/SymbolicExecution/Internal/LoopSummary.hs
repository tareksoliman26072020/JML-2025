{-# Language LambdaCase, MultiWayIf, ScopedTypeVariables #-}
module SymbolicExecution.Internal.LoopSummary where

import Prelude hiding (negate)
import SymbolicExecution.Types
import qualified SymbolicExecution.Logs.Log as Log
import SymbolicExecution.Internal.Internal
import SymbolicExecution.Internal.Math.Calculator (numericCalculator, substitute, isSymExprGreaterThan)
import SymbolicExecution.Internal.Math.Isolator (isolate, run_isolate, IsolationFailureReason)
import qualified CFG.Internal as CFG (getExpression)
import qualified Data.Map as Map
import Control.Monad (forM, foldM)
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer
import Text.Printf (printf)
import Data.Functor (($>))
import qualified CFG.Types as CFGT
import qualified Parser.Types as AST
import Data.List ((\\), find, nub, nubBy)
import Data.Maybe (catMaybes, fromJust)

globalLoc = "SymbolicExecution.Internal.LoopSummary"

--------------------
--------------------
--------------------

-- finding `LoopInitFacts` in `LoopSummary`
getLoopInitFacts :: SymStateEnv -> (SymStateEnv,[ExecutionResult]) -> [String] -> CFGT.ScopeRange -> SymbolicExecutionMonad [(String,SymExpr)]
getLoopInitFacts origEnv (newEnv,newEnv_ers) loopFrameTargets branchRange = do
  let loc = globalLoc ++ ".getLoopInitFacts"
      logContents = [
        ("origEnv",show origEnv),
        ("newEnv",show newEnv),
        ("newEnv_ers",show newEnv_ers),
        ("loopFrameTargets",show loopFrameTargets)]
  constructLog loc "getLoopInitFacts" logContents
  let theVarNames = flip Map.foldMapWithKey (getVarNames origEnv) $ \(VarName vn) v ->
        helper vn v
        {-case v of
          SymVar _ vn2 _
            | vn2 `elem` loopFrameTargets -> [(vn,SymPreScope branchRange v)]
            | vn /= vn2 -> [(vn,v)]
            | otherwise -> []
          _ -> [(vn,SymPreScope branchRange v)]-}
  {-let theVarNames = let
        collecting = flip Map.filterWithKey (getVarNames origEnv) $ \(VarName vn) -> \case
          -- filter out uninitialized variables
          SymVar _ vn2 _ ->
            vn2 `elem` loopFrameTargets || vn /= vn2
          _ -> True
        in Map.toList
           $ Map.mapKeys (\(VarName vn) -> vn) collecting-}
  let forLoopCountersInitFacts :: [(String,SymExpr)]
      forLoopCountersInitFacts = case Map.lookup VarAssignments origEnv of
        Just (SVarAssignments li) -> [(vn,initVal)
            | (vn,(SymVar _ _ varInfos,_)) <- li
            , let relevant_varInfo = [initVal
                    | ForAccumulator br initVal <- varInfos
                    , br == branchRange
                    ]
            , case relevant_varInfo of
                [initVal] -> True
                [] -> False
                _ -> error $ constructErrorMsg loc "won't happen1" [("relevant_varInfo",show relevant_varInfo)]
            , let initVal = case relevant_varInfo of
                    [x] -> x
                    _ -> error $ constructErrorMsg loc "won't happen2" [("relevant_varInfo",show relevant_varInfo)]
            ]
        Nothing -> []
  let toReturn = theVarNames ++ forLoopCountersInitFacts
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn where
  helper :: String -> SymExpr -> [(String,SymExpr)]
  helper vn v = let
    loc = globalLoc ++ ".getLoopInitFacts.helper"
    logContents = [("vn",vn),("v",show v)] in case v of
    SymVar t vn2 _
      | vn2 `elem` loopFrameTargets -> [(vn,SymPreScope branchRange (t,vn2))]
      | vn /= vn2 -> [(vn,v)]
      | otherwise -> []
    SymNum _ -> [(vn,v)]
    SymInt _ -> [(vn,v)]
    SymDouble _ -> [(vn,v)]
    SymFloat _ -> [(vn,v)]
    SBool _ -> [(vn,v)]
    SymString _ -> [(vn,v)]
    -- this following pattern matches were written to shut up the tests for methods (2)
    SymUnknown _ _ -> [(vn,v)]
    SymArray _ _ _ -> [(vn,v)]
    SArrayIndexAccess _ _ _ -> [(vn,v)]
    SObjAcc _ -> [(vn,v)]
    SBin v1 _ v2 -> let
      rec1 = helper vn v1
      rec2 = helper vn v2
      in rec1 ++ rec2
    _ -> error $ constructErrorMsg "TODO" loc logContents

--------------------
--------------------
--------------------

getLoopGuard :: (SymStateEnv, SymStateEnv) -> SymExpr -> SymbolicExecutionMonad SymExpr
getLoopGuard (origEnv,newEnv) loopCondition = do
  let loc = globalLoc ++ ".getLoopGuard"
      logContents = [
         ("origEnv",show origEnv)
        ,("newEnv",show newEnv)
        ,("loopCondition",show loopCondition)
        ]
  constructLog loc "getLoopGuard" logContents
  tellNextLog (Log.Return loc (show loopCondition)) $> loopCondition

--------------------
--------------------
--------------------

getLoopExitingConditions :: Maybe SymExpr -> (SymStateEnv,[ExecutionResult]) -> SymbolicExecutionMonad [SymExpr]
getLoopExitingConditions loopGuard (breaksEnv,breaks_ers) = do
  let loc = globalLoc ++ ".getLoopExitingConditions"
      logContents = [
        ("loopGuard",show loopGuard),
        ("breaksEnv",show breaksEnv),
        ("breaks_ers",show breaks_ers)]
  constructLog loc "getLoopExitingConditions" logContents
      -- whether there's a break statement
  let unconditionalBreaks = case Map.lookup Break breaksEnv of
        Just SymBreak -> [SBool True]
        Nothing -> []
        _ -> error $ constructErrorMsg loc "won't happen" logContents
      breaksConditions :: [SymExpr]
      breaksConditions = Map.foldMapWithKey studyBreakSymExpr breaksEnv
      pickLoopGuards = case loopGuard of
        Just (SBool True) -> []
        Just guard -> [negate guard]
        Nothing -> []
      summary = [
        ("unconditionalBreaks",show unconditionalBreaks),
        ("breaksConditions",show breaksConditions)]
  constructLog loc "summary" summary
  let toReturn = pickLoopGuards ++ unconditionalBreaks ++ breaksConditions
  --throwError $ constructErrorMsg loc "W" $
  --  logContents ++ [("toReturn",show toReturn)]
  tellNextLog (Log.Return loc (show toReturn)) $> toReturn where
  -- if a `SymExpr` provides a break statement,
  -- then extract the path condition which makes it occur
  studyBreakSymExpr :: SymStateKey -> SymExpr -> [SymExpr]
  studyBreakSymExpr k v = let
    loc = globalLoc ++ ".getLoopExitingConditions.studyBreakSymExpr" in
    case (k,v) of
      (Break,SymBreak) -> [SBool True]
      (ScopeRange sr,SIte _ ifEnv maybe_elseEnv) -> let
        ifCond = case [ifCond
          | ER_IfExpr sr2 (ifCond,_) _ _ <- breaks_ers
          , sr == sr2
          ] of
          [cond] -> cond
          _ -> error $ constructErrorMsg loc "won't happen" [
            ("k",show k),
            ("v",show v)
            ]
        if_rec = addCond ifCond (Map.foldMapWithKey studyBreakSymExpr ifEnv)
        else_rec = addCond (negate ifCond) (maybe [] (Map.foldMapWithKey studyBreakSymExpr) maybe_elseEnv)
        in if_rec ++ else_rec
      (MethodHandle,_) -> []
      (GlobalVars,_) -> []
      (FormalParms,_) -> []
      (VarBindings,_) -> []
      (VarAssignments,_) -> []
      (VarName _,_) -> []
      _ -> error $ constructErrorMsg loc "TODO" [("k",show k),("v",show v)]
  addCond :: SymExpr -> [SymExpr] -> [SymExpr]
  addCond cond li = [res
    | symExpr <- li
    , let res = case symExpr of
            SBool True -> cond
            _ -> symExpr
    ]

--------------------
--------------------
--------------------

getLoopExitViaBreakConditions :: [ExecutionResult] -> SymbolicExecutionMonad [SymExpr]
getLoopExitViaBreakConditions forBody_forStep_ers = do
  let loc = globalLoc ++ ".getLoopExitViaBreakConditions"
  let logContents = [
        ("forBody_forStep_ers",show forBody_forStep_ers)]
  constructLog loc "getLoopExitViaBreakConditions" logContents
  -- the conditions which lead to a break statement
  let breakConds = concat [ifCond ++ elseCond
        | ER_IfExpr _ (cond,_) if_ers else_ers <- forBody_forStep_ers
        , let ifCond = if ER_Break `elem` if_ers
                then [cond]
                else []
        , let elseCond = if ER_Break `elem` else_ers
                then [negate cond]
                else []
        ]
  tellNextLog (Log.Return loc (show breakConds)) $> breakConds

--------------------
--------------------
--------------------

getLoopCounters :: (CFGT.ScopeRange, SymStateEnv, SymStateEnv)
                -> (Maybe SymExpr, [SymExpr])
                -> ([(String,SymExpr)], [String])
                -> SymbolicExecutionMonad [String]
getLoopCounters (branchRange,origEnv,newEnv)
                (loopGuard,loopExitingConditions)
                (loopInitFacts,loopFrameTargets) = do
  let loc = globalLoc ++ ".getLoopCounters"
      logContents = [
         ("branchRange",show branchRange)
        ,("origEnv",show origEnv)
        ,("newEnv",show newEnv)
        ,("loopInitFacts",show loopInitFacts)
        ,("loopGuard",show loopGuard)
        ,("loopExitingConditions",show loopExitingConditions)
        ,("loopFrameTargets",show loopFrameTargets)
        ]
  constructLog loc "getLoopCounters" logContents
  let conds_vns :: [String]
      conds_vns = [vn
        | vn <- nub $ concatMap getVarNames3
                    $ (maybe [] ((:[]) . id) loopGuard) ++ loopExitingConditions
        , vn `elem` loopFrameTargets
        ]
  let toReturn = conds_vns
  
  {-let loopGuard_vars = maybe [] getVarNames3 loopGuard

  toReturn <- case Map.lookup VarAssignments newEnv of
    Nothing -> return []
    Just (SVarAssignments li) -> let
      -- VarAssignments provides informations about variables which are re-assigned in the loop
      -- and I care about those who were caught in the branch range of the loop
      relevantVars :: [String]
      relevantVars = [vn
        | (vn,(symExpr,CFGT.Node_Coor _ (CFGT.SR begin end))) <- li
        , begin == CFGT.branchStart branchRange
        , end == CFGT.branchEnd branchRange
        , vn `elem` loopGuard_vars
        ]
      in return relevantVars-}
  {-throwError $ constructErrorMsg loc "Summary" $ logContents ++ [
    ("loopGuard_vars",show loopGuard_vars),
    ("toReturn",show toReturn)]-}
  tellNextLog (Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopFrameTargetsDevelopmentTrajectory :: [String] -> ([CFGT.Node], SymStateEnv, SymStateEnv) -> SymbolicExecutionMonad [(String, SymExprDevelopmentTrajectory)]
getLoopFrameTargetsDevelopmentTrajectory loopFrameTargets (forBody_forStep_path,orig_env,new_env) = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopFrameTargetsDevelopmentTrajectory"
  let logContents = [
        ("loopFrameTargets",show loopFrameTargets)
       ,("forBody_forStep_path",show forBody_forStep_path)
       ,("orig_env",show orig_env)
       ,("new_env",show new_env)]
  constructLog loc "getLoopFrameTargetsDevelopmentTrajectory" logContents
  let allScopeRanges = get_scopeRanges new_env
  toReturn <- if
    | null loopFrameTargets -> return []
    | otherwise -> forM loopFrameTargets $ \vn -> do
        let compare1 = Map.lookup (VarName vn) orig_env
            compare2 = Map.lookup (VarName vn) new_env
        constructLog loc "comparing" [("vn",vn),("compare1",show compare1),("compare2",show compare2)]
        incrementLogDepth
        loopFrameTargetRes <- study vn (compare1,compare2)
        decrementLogDepth
        return loopFrameTargetRes
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn where
  study :: String -> (Maybe SymExpr,Maybe SymExpr) -> SymbolicExecutionMonad (String,SymExprDevelopmentTrajectory)
  study vn (maybe_oldVal,maybe_newVal) = let
    loc = "SymbolicExecution.Internal.LoopSummary\
          \.getLoopFrameTargetsDevelopmentTrajectory.study" in
    case (maybe_oldVal,maybe_newVal) of
          (Nothing,Nothing) -> throwError $ constructErrorMsg loc "TODO1" []
          (Nothing,Just x) -> do
            let f = do
                  constructLog loc (printf "%s was Nothing, and became something" vn)
                    [("x",show x)]
                  return (vn,NewInScope x)
            -- it's possible that `vn` is a counter in a for loop
            -- in this case, the wished `oldVal` is in `SVarAssignments`
            case Map.lookup VarAssignments new_env of
              Just (SVarAssignments li) -> let
                -- filtering out any mention of SymVars which has VarInfos
                -- to avoid misinterpretations and conflicts
                li2 = [tu
                  | tu@(_,(symExpr,_)) <- li
                  , case symExpr of
                      SymVar _ _ varInfos -> case varInfos of
                        [] -> True
                        _ -> False
                      _ -> True
                  ]
                in case lookup vn li2 of
                     Just (oldVal2,_) -> do
                       constructLog loc "for-loop counter detected" [
                         ("vn",vn),
                         ("initial counter value",show oldVal2)]
                       incrementLogDepth *> study vn (Just oldVal2,maybe_newVal) <* decrementLogDepth
                     Nothing -> f
              Nothing -> f
          (x,Nothing) -> throwError $ constructErrorMsg loc "TODO2" [("x",show x)]
          (Just symExpr1,Just symExpr2)
            | symExpr1 == symExpr2 ->
                constructLog loc (printf "variable %s does not change" vn) [] $>
                (vn,ReadOnly)
          (Just symExpr1,Just symExpr2) -> let
            type1 = toSymType2 symExpr1
            type2 = toSymType2 symExpr2 in if
            | all isTypeNumeric [type1,type2] -> let
                calculating = numericCalculator $ SBin symExpr1 Sub symExpr2
                mathematical_induction :: SymExprDevelopmentTrajectory
                mathematical_induction = case calculating of
                  SymNum num
                    | num == 0 -> ReadOnly
                    | num > 0 -> Decreasing calculating
                    | num < 0 -> Increasing $ SymNum (abs num)
                  SymInt num
                    | num == 0 -> ReadOnly
                    | num > 0 -> Decreasing calculating
                    | num < 0 -> Increasing $ SymInt (abs num)
                  SymDouble num
                    | num == 0 -> ReadOnly
                    | num > 0 -> Decreasing calculating
                    | num < 0 -> Increasing $ SymDouble (abs num)
                  SymFloat num
                    | num == 0 -> ReadOnly
                    | num > 0 -> Decreasing calculating
                    | num < 0 -> Increasing $ SymFloat (abs num)
                  {-_ -> error $ constructErrorMsg loc "TODO3" [
                    ("vn",vn),
                    ("symExpr1",show symExpr1),
                    ("symExpr2",show symExpr2),
                    ("calculating",show calculating),
                    ("loopFrameTargets",show loopFrameTargets),
                    ("maybe_oldVal",show maybe_oldVal),
                    ("maybe_newVal",show maybe_newVal),
                    ("orig_env",show orig_env),
                    ("new_env",show new_env)]-}
                  _ -> Complicated symExpr1 symExpr2
                res = (vn,mathematical_induction)
                in constructLog loc (printf "Induction of <%s>" vn)
                     [("symExpr1",show symExpr1)
                     ,("symExpr2",show symExpr2)
                     ,("calculating",show calculating)
                     ,("mathematical_induction",show mathematical_induction)] $> res
            | otherwise -> constructLog loc "not numbers" [
                ("symExpr1",show symExpr1),
                ("symExpr2",show symExpr2)] $> (vn,NonNumeric symExpr1 symExpr2)

--------------------
--------------------
--------------------

{-
1) loopInitFacts: [("i",SymInt 0)]

2) loopGuards: [SBin (SymVar Int "i") Lt (SymVar Int "n")]

3) loopCountersDevelopmentTrajectory: [("i",Increasing (SymInt 1))]
 -}
-- [(SymInt 0,"i",SymVar Int "n")]
getLoopCountersBounds :: [(String,SymExpr)] -> [String] -> (Maybe SymExpr,[SymExpr]) -> [(String,SymExprDevelopmentTrajectory)] -> [String] -> SymbolicExecutionMonad [(SymExpr,String,SymExpr)]
getLoopCountersBounds
  loopInitFacts loopCounters (loopGuard,loopExitingConditions)
  loopFrameTargetsDevelopmentTrajectory loopReadOnlyVars = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopCountersBounds"
      logContents = [
         ("loopInitFacts",show loopInitFacts)
        ,("loopGuard",show loopGuard)
        ,("loopExitingConditions",show loopExitingConditions)
        ,("loopCounters",show loopCounters)
        ,("loopFrameTargetsDevelopmentTrajectory",show loopFrameTargetsDevelopmentTrajectory)
        ,("loopReadOnlyVars",show loopReadOnlyVars)
        ]
  constructLog loc "getLoopCountersBounds" logContents
  let f counterName = [negate condition
        | condition <- loopExitingConditions
        , counterName `existsIn` condition
        ]
  let toReturn :: [(SymExpr,String,SymExpr)]
      toReturn = [(newInitVal,counterName,newLastVal)
        | counterName <- loopCounters
--        , maybe False (counterName `existsIn`) loopGuard
        , let initVal = case lookup counterName loopInitFacts of
                Just x -> x
                Nothing -> error $ constructErrorMsg loc "won't happen1" $ logContents ++ [("counterName",counterName)]
        , let trajectory = case lookup counterName loopFrameTargetsDevelopmentTrajectory of
                Just x -> x
                Nothing -> error $ constructErrorMsg loc "won't happen2" $ logContents ++ [("counterName",counterName)]
        , let boundsWithCounter :: [SymExpr]
              boundsWithCounter = case loopGuard of
                Just lg
                  | counterName `existsIn` lg -> [lg]
                  | otherwise -> f counterName
                Nothing -> f counterName
        , let bound :: (SymBinOp,SymExpr)
              bound@(comparison,lastVal) = case boundsWithCounter of
                [b] -> studyBound counterName b
                _   -> error $ constructErrorMsg loc "won't happen3" $ logContents ++ [
                  ("counterName",counterName),
                  ("boundsWithCounter",show boundsWithCounter)]
        -- I decided to filter out some trajectories
        , case trajectory of
            Increasing _ -> True
            Decreasing _ -> True
            _ -> False
        , let (newInitVal,newLastVal) = studyLoopFrameTargetsDevelopmentTrajectory trajectory (initVal,comparison,lastVal)
        ]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
  where
  -- runs `isolate` to separate the bound from the counter
  studyBound :: String -> SymExpr -> (SymBinOp,SymExpr)
  studyBound counterName guard = let
    loc = "SymbolicExecution.Internal.LoopSummary.getLoopCountersBounds.studyBound"
    logContents = [
       ("counterName",counterName)
      ,("guard",show guard)
      ] in
    case snd $ run_isolate $ isolate counterName guard of
      ----------
      Left err -> error $ constructErrorMsg loc "TODO1"
        $ logContents ++ [("error",err)]
      ----------
      Right either_isolation -> case either_isolation of
        ----------
        Left (isolationFailureReason :: IsolationFailureReason) -> error
          $ constructErrorMsg loc "TODO2"
          $ logContents ++ [
               ("counterName",show counterName)
              ,("isolationFailureReason",show isolationFailureReason)]
        ----------
        Right (bound :: SymExpr) -> case bound of
          ----------
          SBin expr1 op expr2 ->
            case expr1 of
              ----------
              SymVar _ vn _
                | vn == counterName -> (op,expr2)
              ----------
              _  -> error $ constructErrorMsg loc
                "Won't happen because run_isolate returns Right\
                \ only when counter name exists in expr1"
                $ logContents
                ++ [("counterName",counterName)
                   ,("guard",show guard)
                   ,("bound <SBin expr1 op expr2>",show bound)
                   ,("expr1",show expr1)]
          ----------
          _ -> error
                 $ constructErrorMsg loc "TODO3"
                 $ logContents
                 ++ [("counterName",counterName)
                     ,("guard",show guard)
                     ,("bound",show bound)]
  ----------
  studyLoopFrameTargetsDevelopmentTrajectory :: SymExprDevelopmentTrajectory -> (SymExpr,SymBinOp,SymExpr) -> (SymExpr,SymExpr)
  studyLoopFrameTargetsDevelopmentTrajectory trajectory (initVal,comparison,lastVal) = let
    loc = "SymbolicExecution.Internal.LoopSummary\
          \.getLoopCountersBounds.studyLoopFrameTargetsDevelopmentTrajectory"
    logContents = [
   --  ("loopGuard",show loopGuard)
   -- ,("loopExitingConditions",show loopExitingConditions)
       ("trajectory",show trajectory)
      ,("comparison",show comparison)
      ,("initVal",show initVal)
      ,("lastVal",show lastVal)
      ,("loopReadOnlyVars",show loopReadOnlyVars)] in
    case (trajectory,comparison) of
      (Increasing num,Lt) -> (,) initVal $ numericCalculator
         $ SBin lastVal
                Add
                (SBin num Sub (cast (toSymType2 num) $ SymNum 1))
      (Increasing num,Le) -> (,) initVal
         $ SBin lastVal Add num
      (Decreasing num,Gt) -> (,) lastVal $ numericCalculator
         $ SBin initVal
                Add
                (SBin num Sub (cast (toSymType2 num) $ SymNum 1))
      (Decreasing num,Ge) -> (,) lastVal
         $ SBin initVal Add num
      _  -> error $ constructErrorMsg loc "TODO" logContents

--------------------
--------------------
--------------------

getLoopBoundStabilityFacts :: ([CFGT.Node],SymStateEnv,SymStateEnv) -> [(SymExpr, String, SymExpr)] -> [String] -> SymbolicExecutionMonad [(SymExpr, SymExprDevelopmentTrajectory)]
getLoopBoundStabilityFacts
  (forBody_forStep_path,orig_env,new_env) loopCounterBounds loopFrameTargets = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopBoundStabilityFacts"
      logContents = [
          ("forBody_forStep_path",show forBody_forStep_path)
         ,("orig_env",show orig_env)
         ,("new_env",show new_env)
         ,("loopCounterBounds",show loopCounterBounds)
         ,("loopFrameTargets",show loopFrameTargets)]
  constructLog loc "getLoopBoundStabilityFacts" logContents
  let exprs_2_study :: [SymExpr]
      exprs_2_study = let
        all_exprs = concat [exprs
          | (expr1,_,expr2) <- loopCounterBounds
          , let exprs = filter (not . isConstant) [expr1,expr2]
          ]
        nubbed = flip nubBy all_exprs $ \a b -> case (a,b) of
          (SymVar _ vn1 _,SymPreScope _ (_,vn2)) -> vn1 == vn2
          (SymPreScope _ (_,vn1), SymVar _ vn2 _) -> vn1 == vn2
          (SymVar _ vn1 _,SymVar _ vn2 _) -> vn1 == vn2
          (SymPreScope _ (_,vn1),SymPreScope _ (_,vn2)) -> vn1 == vn2
          (_,_) -> a == b
        in nubbed
          
  constructLog loc "Expressions to study"
    $ [(printf "expr%d" counter,show expr) | (counter,expr) <- zip [1::Int ..] exprs_2_study]
  incrementLogDepth
  toReturn <- concat <$> (flip mapM exprs_2_study $ \expr -> do
    constructLog loc "studying" [("expr",show expr)]
    let studied = study expr
    constructLog loc "done studying" [("studied",show studied)] $> studied)
  decrementLogDepth
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
  where
  ----------
  study :: SymExpr -> [(SymExpr,SymExprDevelopmentTrajectory)]
  study expr = let
    loc = "SymbolicExecution.Internal.LoopSummary.getLoopBoundStabilityFacts.study"
    logContents = [("expr",show expr),("loopCounterBounds",show loopCounterBounds)] in
    case expr of
      SymInt _ -> []
      SymVar _ vn _ -> case studyVarDevelopment vn of--[(expr,studyVarDevelopment vn)]
        Just trajectory -> [(expr,trajectory)]
        Nothing -> []
      SObjAcc [arrName,"length"] -> [(expr,studyArrSizeDevelopment arrName)]
      SBin expr1 _ expr2 -> let
        rec1 = study expr1
        rec2 = study expr2
        res0 = rec1 ++ rec2
        all_readOnly = all $ \(_,trajectory) -> trajectory == ReadOnly in if
        | all_readOnly rec1 && all_readOnly rec2 -> res0 ++ [(expr,ReadOnly)]
        | otherwise -> res0
      SymPreScope sr (_,vn) -> case studyVarDevelopment vn of
        Just trajectory -> [(expr,trajectory)]
        Nothing -> []
      _ -> error $ constructErrorMsg loc "TODO" logContents
  ----------
  studyVarDevelopment :: String -> Maybe SymExprDevelopmentTrajectory
  studyVarDevelopment vn = let
    loc = "SymbolicExecution.Internal.LoopSummary.getLoopBoundStabilityFacts.studyVarDevelopment"
    logContents :: (Int,Maybe SymExpr) -> [(String,String)]
    logContents (0,_) = [("vn",vn)]
    logContents (1,one) = [("vn",vn),("maybe symExpr1",show one)]
    logContents (2,two) = [("vn",vn),("maybe symExpr2",show two)] in
    if | vn `notElem` loopFrameTargets -> Just ReadOnly
       | otherwise -> case (Map.lookup (VarName vn) orig_env,Map.lookup (VarName vn) new_env) of
           (Just symExpr1,Just symExpr2)
             | symExpr1 == symExpr2 -> Just ReadOnly
             | isTypeNumeric (toSymType2 symExpr1) -> if
                 | symExpr1 `isSymExprGreaterThan` symExpr2 -> let
                     res = numericCalculator $ SBin symExpr1 Sub symExpr2
                     in Just $ Decreasing res
                 | otherwise -> let
                     res = numericCalculator $ SBin symExpr2 Sub symExpr1
                     in Just $ Increasing res
             | otherwise -> error $ constructErrorMsg loc "TODO1"
                 [("symExpr1",show symExpr1)
                 ,("symExpr2",show symExpr2)]
           (Nothing,Nothing) -> error $ constructErrorMsg loc "won't happen1"
             $ logContents (0,undefined)
           (one,Nothing) -> error $ constructErrorMsg loc "won't happen2"
             $ logContents (1,one)
           (Nothing,two) -> error $ constructErrorMsg loc "TODO2"
             $ [
               ("forBody_forStep_path",show forBody_forStep_path)
              ,("orig_env",show orig_env)
              ,("new_env",show new_env)
              ,("loopCounterBounds",show loopCounterBounds)] ++ logContents (2,two)
  ----------
  studyArrSizeDevelopment :: String -> SymExprDevelopmentTrajectory
  studyArrSizeDevelopment arrName = let
    loc = "SymbolicExecution.Internal.LoopSummary.\
          \getLoopBoundStabilityFacts.studyArrSizeDevelopment"
    logContents = [
       ("forBody_forStep_path",show forBody_forStep_path)
      ,("orig_env",show orig_env)
      ,("new_env",show new_env)
      ,("loopCounterBounds",show loopCounterBounds)
      ,("arrName",arrName)] in
    case Map.lookup VarAssignments new_env of
      Just (SVarAssignments li) -> case lookup arrName li of
        Nothing -> ReadOnly
        {-
        when an array is changed, this `new_env` doesn't provide informations
          on whether its size remain the same or not
          if the array is a formal parameter. Therefore `forBody_forStep_path` needs to be studied for that purpose.
        if it's not a formal parameter, then ......
        
         -}
        Just (symExpr,_) -> let
          -- exprs in which arrName is reassigned
          astExprs :: [AST.Expression]
          astExprs = concat [res
              | node <- forBody_forStep_path
              , let res = case CFG.getExpression node of
                            Nothing -> []
                            Just expr
                              | AST.isVarAssigned arrName expr -> [expr]
                              | otherwise -> []] in
          --
          if | null astExprs -> ReadOnly
             | otherwise -> error
                 $ constructErrorMsg loc "TODO2"
                 $ logContents ++ [("symExpr",show symExpr),("astExprs",show astExprs)]
      x -> error $ constructErrorMsg loc "TODO3" $ logContents ++ [("x",show x)]
--------------------
--------------------
--------------------

getLoopAssignments :: (CFGT.ScopeRange, SymStateEnv) -> SymbolicExecutionMonad [String]
getLoopAssignments (branchRange,new_env) = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopAssignments"
      logContents = [
         ("branchRange",show branchRange)
        ,("new_env",show new_env)
        ]
  constructLog loc "getLoopAssignments" logContents
  let allAssigns = Map.lookup VarAssignments new_env
      toReturn = case allAssigns of
        Just (SVarAssignments li) -> flip concatMap li
          $ \(vn,(_,CFGT.Node_Coor _ (CFGT.SR begin end))) -> if
              | begin == CFGT.branchStart branchRange &&
                end == CFGT.branchEnd branchRange -> [vn]
              | otherwise -> []
        Nothing -> error
          $ constructErrorMsg loc "won't happen" [("allAssigns",show allAssigns)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopReadOnlyVars :: [String] -> (CFGT.ScopeRange, SymStateEnv, SymStateEnv) -> SymbolicExecutionMonad [String]
getLoopReadOnlyVars loopVarNames (branchRange,origEnv,new_env) = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopReadOnlyVars"
      logContents = [
             ("loopVarNames",show loopVarNames)
            ,("branchRange",show branchRange)
            ,("new_env",show new_env)
            ]
  constructLog loc "getLoopReadOnlyVars" logContents
  let newAssignsEnv :: SymStateEnv
      newAssignsEnv = flip Map.filterWithKey new_env $ \case
        k@(VarName vn) -> case Map.lookup k origEnv of
          Just old_expr -> \case
            new_expr -> old_expr /= new_expr
          Nothing -> const True
        _ -> const False
      assigns :: [String]
      assigns = [vn | (VarName vn) <- Map.keys newAssignsEnv]
      toReturn = filter (`notElem` assigns) loopVarNames
  constructLog loc "Summary" [
    ("origEnv",show origEnv),
    ("assigns",show assigns)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopFrameTargets :: [String] -> [String] -> SymbolicExecutionMonad [String]
getLoopFrameTargets loopVarNames loopReadOnlyVars = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopFrameTargets"
      logContents = [
        ("loopVarNames",show loopVarNames),
        ("loopReadOnlyVars",show loopReadOnlyVars)]
  constructLog loc "getLoopFrameTargets" logContents
  let toReturn = loopVarNames \\ loopReadOnlyVars
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

type CounterInfos = (String,SymExprDevelopmentTrajectory)
type BoundInfos = (BoundPosition,SymExpr,SymExprDevelopmentTrajectory)

{-
loopCountersDevelopmentTrajectory = [("i",Increasing (SymInt 1))]
loopCountersBounds                = [(SymInt 0,"i",SymVar Int "n")]
lookBoundStabilityFacts           = [(SymVar Int "n",ReadOnly)]

observe `loopCountersDevelopmentTrajectory` and `loopBoundStabilityFacts`
  1) then decide with help of `loopCountersBounds`
       if the bounds mentioned in `loopBoundStabilityFacts`
       bigger or smaller than
       the counters mentioned in `loopCountersDevelopmentTrajectory`
  2) then see description before the helper `study`
 -}
getLoopDecreasesCandidate ::
  [(String,SymExprDevelopmentTrajectory)] ->
  [(SymExpr,String,SymExpr)] ->
  [(SymExpr,SymExprDevelopmentTrajectory)] ->
  SymbolicExecutionMonad [SymExpr]
getLoopDecreasesCandidate
  loopFrameTargetsDevelopmentTrajectory loopCountersBounds lookBoundStabilityFacts = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopDecreasesCandidate"
      logContents = [
         ("loopFrameTargetsDevelopmentTrajectory",show loopFrameTargetsDevelopmentTrajectory)
        ,("loopCountersBounds",show loopCountersBounds)
        ,("lookBoundStabilityFacts",show lookBoundStabilityFacts)
        ]
  constructLog loc "getLoopDecreasesCandidate" logContents
  {-
     loopCountersDevelopmentTrajectory = [("i",Increasing (SymInt 1))]
     loopCountersBounds                = [(SymInt 0,"i",SymVar Int "n")]
     lookBoundStabilityFacts           = [(SymVar Int "n",ReadOnly)]
   
     toStudy = [(("i",Increasing (SymInt 1)), (RightBound,SymVar Int "n",ReadOnly))]
   -}
  let toStudy :: [(CounterInfos,BoundInfos)]
      toStudy = concat [zip_counter_bounds--((counter,counterTrajectory),boundsStabilities)
        | (lowerBound,counter,upperBound) <- loopCountersBounds
        , let whichBounds :: [(BoundPosition,SymExpr)]
              whichBounds = getNonConstantBound (lowerBound,upperBound)
              
              counterTrajectory :: SymExprDevelopmentTrajectory
              counterTrajectory = getCounterTrajectory counter
              
              boundsStabilities :: [BoundInfos]
              boundsStabilities = getBoundsStabilities whichBounds
              
              zip_counter_bounds :: [(CounterInfos,BoundInfos)]
              zip_counter_bounds = zip (repeat (counter,counterTrajectory)) boundsStabilities
         ]
  constructLog loc "tuples to study" [(printf "tuple %d" num,show x)
    | (num,x) <- zip [1::Int ..] toStudy]
  incrementLogDepth
  toReturn <- foldM (\acc tu@(counterInfos,boundInfos) -> do
    let studyLogContents = [
          ("counterInfos", show counterInfos)
         ,("boundInfos", show boundInfos)]
    constructLog loc "studying" studyLogContents
    case study tu of
      Nothing -> do
        incrementLogDepth *>
          constructLog loc "no candidate for decreasing template" studyLogContents
            <* decrementLogDepth
        return acc
      Just res -> do
        let result
              | res `elem` acc = acc
              | otherwise = acc ++ [res]
        incrementLogDepth *>
          constructLog loc "candidate found" [("result",show result)]
            <* decrementLogDepth
        return result) [] toStudy
  decrementLogDepth
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
  where
  -- if `loopCountersBounds` gives a (SymInt 0,"i",SymVar Int "n")
  -- then it returns [SymVar Int "n"]`
  getNonConstantBound :: (SymExpr,SymExpr) -> [(BoundPosition,SymExpr)]
  getNonConstantBound (leftBound,rightBound) = let
    innerLoc = "SymbolicExecution.Internal.LoopSummary.\
               \getLoopDecreasesCandidate.getNonConstantBound" in
    [(position,symExpr)
       | (position,symExpr) <- [(LeftBound,leftBound),(RightBound,rightBound)]
       , (not . isConstant) symExpr]
  -- "i" [("i",Increasing (SymInt 1))] ==> Increasing (SymInt 1)
  getCounterTrajectory :: String -> SymExprDevelopmentTrajectory
  getCounterTrajectory counter = let
    innerLoc = "SymbolicExecution.Internal.LoopSummary.\
               \getLoopDecreasesCandidate.getCounterTrajectory" in
    case lookup counter loopFrameTargetsDevelopmentTrajectory of
      Nothing -> error $ constructErrorMsg innerLoc "TODO"
        [("counter",counter)
        ,("loopFrameTargetsDevelopmentTrajectory",show loopFrameTargetsDevelopmentTrajectory)]
      Just res -> res
  -- SymVar Int "n" ==> ReadOnly
  -- returns list because the bound may look something like this: `SBin expr1 _ expr2` 
  getBoundsStabilities :: [(BoundPosition,SymExpr)] -> [BoundInfos]
  getBoundsStabilities bounds = let
    innerLoc = "SymbolicExecution.Internal.\
               \LoopSummary.getLoopDecreasesCandidate.getBoundsStabilities" in
    [res
      | (pos,boundSymExpr) <- bounds
      , let res = getBoundStability pos boundSymExpr]{-
      , let res = case lookup boundSymExpr lookBoundStabilityFacts of
              Nothing -> error $ constructErrorMsg innerLoc "TODO"
                [("boundSymExpr",show boundSymExpr)
                ,("lookBoundStabilityFacts",show lookBoundStabilityFacts)]
              Just trajectory -> (pos,boundSymExpr,trajectory)]-}
  getBoundStability :: BoundPosition -> SymExpr -> BoundInfos
  getBoundStability pos bound = let
    innerLoc = "SymbolicExecution.Internal.\
               \LoopSummary.getLoopDecreasesCandidate.getBoundStability"
    logContents = [("pos",show pos)
                  ,("bound",show bound)]
    bound2 = case bound of
      SymPreScope _ (_,vn) -> let
        finding = flip find lookBoundStabilityFacts $ \(symExpr,_) -> case symExpr of
          SymVar _ vn2 _ -> vn == vn2
          _ -> False
        in case finding of
             Just (b,_) -> b
             Nothing -> error $ constructErrorMsg innerLoc "TODO1" [
               ("bound",show bound),
               ("lookBoundStabilityFacts",show lookBoundStabilityFacts)
               ]
      _ -> bound
    in case lookup bound2 lookBoundStabilityFacts of
      Just trajectory -> (pos,bound,trajectory)
      Nothing -> case bound2 of
        SymInt _ -> (pos,bound2,ReadOnly)
        SBin expr1 _ expr2 -> let
          maybe_trajectory1 = lookup expr1 lookBoundStabilityFacts
          maybe_trajectory2 = lookup expr2 lookBoundStabilityFacts
          logContents2 = logContents ++ [
              ("maybe_trajectory1",show maybe_trajectory1),
              ("maybe_trajectory2",show maybe_trajectory2)] in
          case (maybe_trajectory1,maybe_trajectory2) of
            (Just trajectory1,Just trajectory2) -> let
              newTrajectory = compareTrajectories trajectory1 trajectory2
              in (pos,bound2,newTrajectory)
            (Just trajectory1,Nothing) -> let
              (_,_,expr2_trajectory) = getBoundStability pos expr2
              newTrajectory = compareTrajectories trajectory1 expr2_trajectory
              in (pos,bound2,newTrajectory)
            (Nothing,Just trajectory2) -> error $ constructErrorMsg innerLoc "TODO2" logContents2
            (Nothing,Nothing) -> error $ constructErrorMsg innerLoc "TODO3" logContents2
        _ -> error $ constructErrorMsg innerLoc "TODO4" $ [
          ("bound",show bound),
          ("bound2",show bound2),
          ("loopFrameTargetsDevelopmentTrajectory",show loopFrameTargetsDevelopmentTrajectory),
          ("loopCountersBounds",show loopCountersBounds),
          ("loopBoundStabilityFacts",show lookBoundStabilityFacts)
          ]
  compareTrajectories :: SymExprDevelopmentTrajectory -> SymExprDevelopmentTrajectory
    -> SymExprDevelopmentTrajectory
  compareTrajectories trajectory1 trajectory2 = let
    innerLoc = "SymbolicExecution.Internal.\
               \LoopSummary.getLoopDecreasesCandidate.compareTrajectories"
    logContents = [("trajectory1",show trajectory1)
                  ,("trajectory2",show trajectory2)] in
    case (trajectory1,trajectory2) of
      (ReadOnly,ReadOnly) -> ReadOnly
      (Increasing step1,Increasing step2) -> let
        newTrajectory = Increasing $ numericCalculator $ SBin step1 Add step2
        in newTrajectory
      (Decreasing step1,Decreasing step2) -> let
        newTrajectory = Increasing $ numericCalculator $ SBin step1 Add step2
        in newTrajectory
      _ -> error $ constructErrorMsg innerLoc "TODO1" logContents
  -- (("i",Increasing (SymInt 1)), [(RightBound,SymVar Int "n",ReadOnly)])
  --   ==> SBin (SymInt "n") Sub (SymVar Int "i")
{-
       if counter <= bound `loopCountersBounds` ==>
         1) bound ReadOnly, counter Increasing YES
         2) bound ReadOnly, counter Decreasing NO
         3) bound Increasing, counter Increasing (only if trajectory of counter bigger than trajectory of bound)
         4) bound Increasing, counter Decreasing NO
         5) bound Decreasing, counter Increasing YES
         6) bound Decreasing, counter Decreasing (only if trajectory of bound bigger than trajectory of counter)
         7) counter ReadOnly (won't happen)
         8) counter mixed NO
         9) bound mixed NO
       if bound <= counter
         1) bound ReadOnly, counter Decreasing YES
         2) bound ReadOnly, counter Increasing NO
         3) bound Increasing, counter Decreasing YES
         4) bound Increasing, counter Increasing (only if trajectory of bound bigger than trajectory of counter)
         5) bound Decreasing, counter Decreasing (only if trajectory of counter bigger than trajectory of bound)
         6) bound Decreasing, counter Increasing NO
         7) counter ReadOnly (won't happen)
         8) counter mixed NO
         9) bound mixed NO
 -}
  study :: (CounterInfos,BoundInfos) -> Maybe SymExpr
  study ((counterName,counterTrajectory),(boundPosition,boundSymExpr,boundTrajectory)) = let
    innerLoc = "SymbolicExecution.Internal.LoopSummary.\
               \getLoopDecreasesCandidate.study"
    logContents = [
      ("counterName",counterName)
     ,("counterTrajectory",show counterTrajectory)
     ,("boundPosition",show boundPosition)
     ,("boundSymExpr",show boundSymExpr)
     ,("boundTrajectory",show boundTrajectory)
       ] in
    case boundPosition of
      RightBound -> case (boundTrajectory,counterTrajectory) of
   {-1-}(ReadOnly, Increasing developmentSpeed) -> let
          counterSymExpr = SymVar (toSymType2 developmentSpeed) counterName []
          in Just $ SBin boundSymExpr Sub counterSymExpr
   {-2-}(ReadOnly, Decreasing _) -> Nothing
   -- bound Increasing, counter Increasing (only if trajectory of counter bigger than trajectory of bound)
        (Increasing boundDevelopmentSpeed, Increasing counterDevelopmentSpeed)
   {-3-}  | counterDevelopmentSpeed `isSymExprGreaterThan` boundDevelopmentSpeed -> let
              counterSymExpr = SymVar (toSymType2 counterDevelopmentSpeed) counterName []
              in Just $ SBin boundSymExpr Sub counterSymExpr
          | otherwise -> Nothing
   {-4-}(Increasing _, Decreasing _) -> Nothing
   {-5-}(Decreasing _, Increasing developmentSpeed) -> let
          counterSymExpr = SymVar (toSymType2 developmentSpeed) counterName []
          in Just $ SBin boundSymExpr Sub counterSymExpr
        (Decreasing boundDevelopmentSpeed, Decreasing counterDevelopmentSpeed)
   {-6-}  | boundDevelopmentSpeed `isSymExprGreaterThan` counterDevelopmentSpeed -> let
              counterSymExpr = SymVar (toSymType2 counterDevelopmentSpeed) counterName []
              in Just $ SBin boundSymExpr Sub counterSymExpr
          | otherwise -> Nothing
         {- | otherwise -> error $ constructErrorMsg innerLoc "TODO" $ logContents
              ++ [("boundDevelopmentSpeed",show boundDevelopmentSpeed)
                 ,("counterDevelopmentSpeed",show counterDevelopmentSpeed)]-}
   {-7-}(_,ReadOnly) -> error $ constructErrorMsg innerLoc "won't happen1" logContents
   {-8-}(_,Mixed _) -> Nothing
   {-9-}(Mixed _,_) -> Nothing

      LeftBound -> case (boundTrajectory,counterTrajectory) of
   {-1-}(ReadOnly, Decreasing developmentSpeed) -> let
          counterSymExpr = SymVar (toSymType2 developmentSpeed) counterName [] in
          Just $ SBin counterSymExpr Sub boundSymExpr
   {-2-}(ReadOnly, Increasing _) -> Nothing
   {-3-}(Increasing _, Decreasing developmentSpeed) -> let
          counterSymExpr = SymVar (toSymType2 developmentSpeed) counterName [] in
          Just $ SBin counterSymExpr Sub boundSymExpr
   {-4-}(Increasing boundDevelopmentSpeed, Increasing counterDevelopmentSpeed)
          | boundDevelopmentSpeed `isSymExprGreaterThan` counterDevelopmentSpeed -> let
              counterSymExpr = SymVar (toSymType2 counterDevelopmentSpeed) counterName []
              in Just $ SBin counterSymExpr Sub boundSymExpr
          | otherwise -> Nothing
   {-5-}(Decreasing boundDevelopmentSpeed, Decreasing counterDevelopmentSpeed)
          | counterDevelopmentSpeed `isSymExprGreaterThan` boundDevelopmentSpeed -> let
              counterSymExpr = SymVar (toSymType2 counterDevelopmentSpeed) counterName []
              in Just $ SBin counterSymExpr Sub boundSymExpr
          | otherwise -> Nothing
   {-6-}(Decreasing _, Increasing _) -> Nothing
   {-7-}(_,ReadOnly) -> error $ constructErrorMsg innerLoc "won't happen2" logContents
   {-8-}(_,Mixed _) -> Nothing
   {-9-}(Mixed _,_) -> Nothing

--------------------
--------------------
--------------------

getLoopEnteringCondition :: [(String,SymExpr)] -> Maybe SymExpr -> SymbolicExecutionMonad (Maybe SymExpr)
getLoopEnteringCondition loopInitFacts loopGuard = do
  let loc = globalLoc ++ ".getLoopEnteringCondition"
      logContents = [
         ("loopInitFacts",show loopInitFacts)
        ,("loopGuard",show loopGuard)]
  constructLog loc "getLoopEnteringCondition" logContents
  let loopGuard_vns :: [String]
      loopGuard_vns = maybe [] getVarNames3 loopGuard
      relevant_loopGuard_vns :: [String]
      relevant_loopGuard_vns = [vn
        | vn <- loopGuard_vns
        , case lookup vn loopInitFacts of
            Nothing -> False
            Just _ -> True]
      relevant_loopInitFacts :: [(String,SymExpr)]
      relevant_loopInitFacts = [initFact
        | initFact@(vn,_) <- loopInitFacts
        , vn `elem` relevant_loopGuard_vns
        ]
  constructLog loc "summary" [
     ("loopGuard_vns",show loopGuard_vns)
    ,("relevant_loopGuard_vns",show relevant_loopGuard_vns)
    ,("relevant_loopInitFacts",show relevant_loopInitFacts)]
  let toReturn = case relevant_loopInitFacts of
        [] -> case loopGuard of
          Just (SBool _) -> loopGuard
          _ -> Nothing
        _ -> substitute relevant_loopInitFacts <$> (loopGuard :: Maybe SymExpr)
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopSkipCondition :: Maybe SymExpr -> SymbolicExecutionMonad (Maybe SymExpr)
getLoopSkipCondition loopEnteringCondition = do
  let loc = globalLoc ++ ".getLoopSkipCondition"
      logContents = [("loopEnteringCondition",show loopEnteringCondition)]
  constructLog loc "getLoopSkipCondition" logContents
  let toReturn = negate <$> loopEnteringCondition
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopExitFacts :: (Maybe SymExpr,[SymExpr]) -> [(String,SymExprDevelopmentTrajectory)] -> SymbolicExecutionMonad [LoopExitFact]
getLoopExitFacts (loopGuard,loopExitingConditions) loopFrameTargetsDevelopmentTrajectory = do
  let loc = globalLoc ++ ".getLoopExitFacts"
      logContents = [
         ("loopGuard",show loopGuard)
        ,("loopExitingConditions",show loopExitingConditions)
        ,("loopFrameTargetsDevelopmentTrajectory",show loopFrameTargetsDevelopmentTrajectory)
        ]
  constructLog loc "getLoopExitFacts" logContents
  let toReturn :: [LoopExitFact]
      toReturn = let
        exitConds_vns = concatMap getVarNames3 loopExitingConditions
        vns = maybe exitConds_vns (\lg -> getVarNames3 lg ++ exitConds_vns) loopGuard
        guards = map negate loopExitingConditions
        finding = [tu | tu@(vn,_) <- loopFrameTargetsDevelopmentTrajectory, vn `elem` vns]
        in flip concatMap guards $ \guard -> case finding of
            {-[(vn,trajectory)] -> let
              maybe_Res = symExprNextStep vn (isolate_vr vn guard) trajectory
              in case maybe_Res of
                Nothing -> error $ constructErrorMsg loc "TODO1" $ logContents ++
                  [("vn",vn)
                  ,("guard",show guard)
                  ,("trajectory",show trajectory)]
                Just loopExitFact -> [loopExitFact]-}
            _ -> [res
              | (vn,trajectory) <- finding
              , let maybe_Res = symExprNextStep vn (isolate_vr vn guard) trajectory
              , let res = case maybe_Res of
                      Nothing -> error $ constructErrorMsg loc "TODO1" $ logContents ++
                        [("vn",vn)
                        ,("guard",show guard)
                        ,("trajectory",show trajectory)]
                      Just loopExitFact -> loopExitFact 
              ]
            --_ -> error $ constructErrorMsg loc "TODO1" $ logContents ++ [("finding",show finding)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn where
  -- isolate `vr` in `guard`
  isolate_vr :: String -> SymExpr -> SymExpr
  isolate_vr vn guard = let
    loc = globalLoc ++ ".getLoopExitFacts.isolate_vr"
    logContents = [("vn",vn),("guard",show guard)] in
    case snd $ run_isolate $ isolate vn guard of
      Left err -> error $ constructErrorMsg loc "TODO1"
        $ logContents ++ [("error",err)]
      ----------
      Right either_isolation -> case either_isolation of
        Left (isolationFailureReason :: IsolationFailureReason) -> error
            $ constructErrorMsg loc "TODO2"
            $ logContents ++ [
                ("isolationFailureReason",show isolationFailureReason)]
        ----------
        Right guard -> guard
  --
  symExprNextStep :: String -> SymExpr -> SymExprDevelopmentTrajectory -> Maybe LoopExitFact
  symExprNextStep vn guard trajectory = let
    loc = globalLoc ++ ".getLoopExitFacts.symExprNextStep"
    logContents = [
       ("vn",vn)
      ,("guard",show guard)
      ,("trajectory",show trajectory)] in
    case (trajectory,guard) of
      (Increasing step,SBin expr1@(SymVar _ vn2 _) op expr2) -> let
        step_type = toSymType2 step in if
        | vn == vn2 && isTypeNumeric step_type -> case op of
          Lt -> let
            left = expr2
            expr_r = SBin expr2 Add (SBin step Sub (cast step_type $ SymNum 1))
            right = numericCalculator expr_r
            in if | isOne step -> Just $ LoopExitFactValue vn left
                  | otherwise  -> Just $ LoopExitFactRange vn left right
          Le -> let
            left = SBin expr2 Add (cast step_type $ SymNum 1)
            right = numericCalculator $ SBin expr2 Add step
            in if | isOne step -> Just $ LoopExitFactValue vn left
                  | otherwise  -> Just $ LoopExitFactRange vn left right
          _ -> error $ constructErrorMsg loc "TODO1" logContents
    
        | otherwise -> error $ constructErrorMsg loc "TODO2" logContents
      (Decreasing step,SBin expr1@(SymVar _ vn2 _) op expr2) -> let
        step_type = toSymType2 step in if
        | vn == vn2 && isTypeNumeric step_type -> case op of
          Gt -> let
            right = expr2
            left = numericCalculator $ SBin expr2 Sub step
            in if | isOne step -> Just $ LoopExitFactValue vn right
                  | otherwise  -> Just $ LoopExitFactRange vn left right
          Ge -> let
            right = SBin expr2 Sub (cast step_type $ SymNum 1)
            left = SBin right Sub step
            in if | isOne step -> Just $ LoopExitFactValue vn right
                  | otherwise  -> Just $ LoopExitFactRange vn left right
          _ -> error $ constructErrorMsg loc "TODO3" logContents
      _ -> error $ constructErrorMsg loc "TODO4" logContents
