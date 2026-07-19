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
import Data.List ((\\), find)
import Data.Maybe (catMaybes)

globalLoc = "SymbolicExecution.Internal.LoopSummary"

--------------------
--------------------
--------------------

-- finding `LoopInitFacts` in `LoopSummary`
getLoopInitFacts :: SymStateEnv -> [String] -> SymbolicExecutionMonad [(String,SymExpr)]
getLoopInitFacts origEnv loopFrameTargets = do
  let loc = globalLoc ++ ".getLoopInitFacts"
      logContents = [("origEnv",show origEnv)
                    ,("loopFrameTargets",show loopFrameTargets)]
  constructLog loc "getLoopInitFacts" logContents
  let theVarNames = flip Map.filterWithKey (getVarNames origEnv) $ \(VarName vn) -> \case
        -- filter out uninitialized variables
        SymVar _ vn2 ->
          vn2 `elem` loopFrameTargets || vn /= vn2
        _ -> True
  let toReturn = Map.toList
        $ Map.mapKeys (\(VarName vn) -> vn) theVarNames
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopGuard :: (SymStateEnv, SymStateEnv) -> SymExpr -> SymbolicExecutionMonad [SymExpr]
getLoopGuard (origEnv,newEnv) loopCondition = do
  let loc = globalLoc ++ ".getLoopGuard"
      logContents = [
         ("origEnv",show origEnv)
        ,("newEnv",show newEnv)
        ,("loopCondition",show loopCondition)
        ]
  constructLog loc "getLoopGuard" logContents
  tellNextLog (Log.Return loc (show [loopCondition])) $> [loopCondition]

--------------------
--------------------
--------------------

getLoopExitConditions :: [SymExpr] -> SymbolicExecutionMonad [SymExpr]
getLoopExitConditions loopGuards = do
  let loc = globalLoc ++ ".getLoopExitConditions"
      logContents = [("loopGuards",show loopGuards)]
  constructLog loc "getLoopExitConditions" logContents
  let toReturn = map negate loopGuards
  tellNextLog (Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopCounters :: (CFGT.ScopeRange, SymStateEnv, SymStateEnv)
                -> ([(String,SymExpr)], [SymExpr])
                -> SymbolicExecutionMonad [String]
getLoopCounters (branchRange,origEnv,newEnv) (theLoopInitFacts,theLoopGuards) = do
  let loc = globalLoc ++ ".getLoopCounters"
      logContents = [
         ("branchRange",show branchRange)
        ,("origEnv",show origEnv)
        ,("newEnv",show newEnv)
        ,("theLoopInitFacts",show theLoopInitFacts)
        ,("theLoopGuards",show theLoopGuards)
        ]
  constructLog loc "getLoopCounters" logContents
  let loopGuard_vars = case theLoopGuards of
        [theLoopGuard] -> getVarNames3 theLoopGuard
        [] -> []
        _ -> error $ constructErrorMsg loc "TODO" logContents
  toReturn <- case Map.lookup VarAssignments newEnv of
    Nothing -> return []
    Just (SVarAssignments li) -> let
      -- VarAssignments provides informations about variables which are re-assigned in the loop
      -- and I care about those who were caught in the branch range of the loop
      -- 
      relevantVars :: [String]
      relevantVars = [vn
        | (vn,(symExpr,CFGT.Node_Coor _ (CFGT.SR begin end))) <- li
        , begin == CFGT.branchStart branchRange
        , end == CFGT.branchEnd branchRange
        , vn `elem` loopGuard_vars
        ]
      in return relevantVars
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
        loopFrameTargetRes <- case (compare1,compare2) of
          (Nothing,Nothing) -> throwError $ constructErrorMsg loc "TODO1" []
          (Nothing,Just x) -> do
            constructLog loc (printf "%s was Nothing, and became something" vn) [("x",show x)]
            return (vn,NewInScope x)
          (x,Nothing) -> throwError $ constructErrorMsg loc "TODO3" [("x",show x)]
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
        decrementLogDepth
        return loopFrameTargetRes
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

{-
1) loopInitFacts: [("i",SymInt 0)]

2) loopGuards: [SBin (SymVar Int "i") Lt (SymVar Int "n")]

3) loopCountersDevelopmentTrajectory: [("i",Increasing (SymInt 1))]
 -}
-- [(SymInt 0,"i",SymVar Int "n")]
getLoopCountersBounds :: [(String,SymExpr)] -> [String] -> [SymExpr] -> [(String,SymExprDevelopmentTrajectory)] -> SymbolicExecutionMonad [(SymExpr,String,SymExpr)]
getLoopCountersBounds
  loopInitFacts loopCounters loopGuards loopFrameTargetsDevelopmentTrajectory = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopCountersBounds"
      logContents = [
         ("loopInitFacts",show loopInitFacts)
        ,("loopGuards",show loopGuards)
        ,("loopCounters",show loopCounters)
        ,("loopFrameTargetsDevelopmentTrajectory",show loopFrameTargetsDevelopmentTrajectory)
        ]
  constructLog loc "getLoopCountersBounds" logContents
  let toReturn :: [(SymExpr,String,SymExpr)]
      toReturn = [(newInitVal,counterName,newLastVal)
        | counterName <- loopCounters
        , guard <- loopGuards
        , let initVal = case lookup counterName loopInitFacts of
                Just x -> x
                Nothing -> error $ constructErrorMsg loc "won't happen1" $ logContents ++ [("counterName",counterName)]
        , let trajectory = case lookup counterName loopFrameTargetsDevelopmentTrajectory of
                Just x -> x
                Nothing -> error $ constructErrorMsg loc "won't happen2" $ logContents ++ [("counterName",counterName)]
        , counterName `existsIn` guard
        , let bound :: (SymBinOp,SymExpr)
              bound@(comparison,lastVal) = studyBound counterName guard
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
              SymVar _ vn
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
       ("trajectory",show trajectory)
      ,("comparison",show comparison)
      ,("initVal",show initVal)
      ,("lastVal",show lastVal)] in
    case (trajectory,comparison) of
      {-(Increasing _,Lt) -> (initVal,lastVal)
      (Increasing _,Le) -> (initVal,lastVal)
      (Decreasing _,Gt) -> (lastVal,initVal)
      (Decreasing _,Ge) -> (lastVal,initVal)-}
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

getLoopBoundStabilityFacts :: ([CFGT.Node],SymStateEnv,SymStateEnv) -> [(SymExpr, String, SymExpr)] -> SymbolicExecutionMonad [(SymExpr, SymExprDevelopmentTrajectory)]
getLoopBoundStabilityFacts (forBody_forStep_path,orig_env,new_env) loopCounterBounds = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopBoundStabilityFacts"
      logContents = [
          ("forBody_forStep_path",show forBody_forStep_path)
         ,("orig_env",show orig_env)
         ,("new_env",show new_env)
         ,("loopCounterBounds",show loopCounterBounds)]
  constructLog loc "getLoopBoundStabilityFacts" logContents
  let exprs_2_study :: [SymExpr]
      exprs_2_study = concat [exprs
        | (expr1,_,expr2) <- loopCounterBounds
        , let exprs = filter (not . isConstant) [expr1,expr2]]
  constructLog loc "Expressions to study"
    $ [(printf "expr%d" counter,show expr) | (counter,expr) <- zip [1::Int ..] exprs_2_study]
  incrementLogDepth
  toReturn <- concat <$> (flip mapM exprs_2_study $ \expr -> do
    constructLog loc "studying" [("expr",show expr)]
    let studied = study expr
    constructLog loc "done studying" [("studied",show studied)] $> studied)
  decrementLogDepth
      {-
      toReturn = concat [res
        | expr <- exprs_2_study
        , if | any (\f -> f expr) [hasSymVar,isSObjAcc] -> True
             | otherwise -> error $ constructErrorMsg loc "TODO1"
                 $ logContents
                 ++ [("exprs_2_study",show exprs_2_study),("expr",show expr)]
        , let res :: [(SymExpr,SymExprDevelopmentTrajectory)]
              res = case expr of
                SymVar _ vn -> [(expr,studyVarDevelopment vn)]
                SObjAcc [arrName,"length"] -> [(expr,studyArrSizeDevelopment arrName)]]
              --SBin (SymVar Int "n") Add (SymInt 2)
                SBin expr1 _ expr2 -> nub $ -}
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
  where
  ----------
  study :: SymExpr -> [(SymExpr,SymExprDevelopmentTrajectory)]
  study expr = let
    loc = "SymbolicExecution.Internal.LoopSummary.getLoopBoundStabilityFacts.infer"
    logContents = [("expr",show expr)] in
    case expr of
      SymInt _ -> []
      SymVar _ vn -> [(expr,studyVarDevelopment vn)]
      SObjAcc [arrName,"length"] -> [(expr,studyArrSizeDevelopment arrName)]
      SBin expr1 _ expr2 -> let
        rec1 = study expr1
        rec2 = study expr2
        res0 = rec1 ++ rec2
        all_readOnly = all $ \(_,trajectory) -> trajectory == ReadOnly in if
        | all_readOnly rec1 && all_readOnly rec2 -> res0 ++ [(expr,ReadOnly)]
        | otherwise -> res0
      _ -> error $ constructErrorMsg loc "TODO" logContents
  ----------
  studyVarDevelopment :: String -> SymExprDevelopmentTrajectory
  studyVarDevelopment vn = let
    loc = "SymbolicExecution.Internal.LoopSummary.getLoopBoundStabilityFacts.studyVarDevelopment"
    logContents :: (Int,Maybe SymExpr) -> [(String,String)]
    logContents (0,_) = [("vn",vn)]
    logContents (1,one) = [("vn",vn),("maybe symExpr1",show one)]
    logContents (2,two) = [("vn",vn),("maybe symExpr2",show two)] in
    case (Map.lookup (VarName vn) orig_env,Map.lookup (VarName vn)  new_env) of
      (Just symExpr1,Just symExpr2)
        | symExpr1 == symExpr2 -> ReadOnly
        | isTypeNumeric (toSymType2 symExpr1) -> if
            | symExpr1 `isSymExprGreaterThan` symExpr2 -> let
                res = numericCalculator $ SBin symExpr1 Sub symExpr2
                in Decreasing res
            | otherwise -> let
                res = numericCalculator $ SBin symExpr2 Sub symExpr1
                in Increasing res
        | otherwise -> error $ constructErrorMsg loc "TODO1"
            [("symExpr1",show symExpr1)
            ,("symExpr2",show symExpr2)]
      (Nothing,Nothing) -> error $ constructErrorMsg loc "won't happen1"
        $ logContents (0,undefined)
      (one,Nothing) -> error $ constructErrorMsg loc "won't happen2"
        $ logContents (1,one)
      (Nothing,two) -> error $ constructErrorMsg loc "TODO2"
        $ logContents (2,two)
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

getLoopReadOnlyVars :: [String] -> (CFGT.ScopeRange, SymStateEnv) -> SymbolicExecutionMonad [String]
getLoopReadOnlyVars loopVarNames (branchRange,new_env) = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopReadOnlyVars"
      logContents = [
             ("loopVarNames",show loopVarNames)
            ,("branchRange",show branchRange)
            ,("new_env",show new_env)
            ]
  constructLog loc "getLoopReadOnlyVars" logContents
  let allAssigns = Map.lookup VarAssignments new_env
      assigns :: [String]
      assigns = case allAssigns of
        Just (SVarAssignments li) -> flip concatMap li
          $ \(vn,(_,CFGT.Node_Coor _ (CFGT.SR begin end))) -> if
              | begin == CFGT.branchStart branchRange &&
                end == CFGT.branchEnd branchRange -> [vn]
              | otherwise -> []
        Nothing -> []
      toReturn = filter (`notElem` assigns) loopVarNames
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopFrameTargets :: [String] -> [String] -> SymbolicExecutionMonad [String]
getLoopFrameTargets loopVarNames loopReadOnlyVars = do
  let loc = "SymbolicExecution.Internal.LoopSummary.getLoopFrameTargets"
      logContents = [("loopReadOnlyVars",show loopReadOnlyVars)]
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
  toReturn <- foldM (\acc tu@(counterInfos,boundInfos) -> do
    let studyLogContents = [
          ("counterInfos", show counterInfos)
         ,("boundInfos", show boundInfos)]
    constructLog loc "studying" studyLogContents
    case study tu of
      Nothing -> do
        constructLog loc "no candidate for decreasing template" studyLogContents
        return acc
      Just res -> return $ acc ++ [res]) [] toStudy
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
                  ,("bound",show bound)] in
    case lookup bound lookBoundStabilityFacts of
      Just trajectory -> (pos,bound,trajectory)
      Nothing -> case bound of
        SymInt _ -> (pos,bound,ReadOnly)
        SBin expr1 _ expr2 -> let
          maybe_trajectory1 = lookup expr1 lookBoundStabilityFacts
          maybe_trajectory2 = lookup expr2 lookBoundStabilityFacts
          logContents2 = logContents ++ [
              ("maybe_trajectory1",show maybe_trajectory1),
              ("maybe_trajectory2",show maybe_trajectory2)] in
          case (maybe_trajectory1,maybe_trajectory2) of
            (Just trajectory1,Just trajectory2) -> let
              newTrajectory = compareTrajectories trajectory1 trajectory2
              in (pos,bound,newTrajectory)
            (Just trajectory1,Nothing) -> let
              (_,_,expr2_trajectory) = getBoundStability pos expr2
              newTrajectory = compareTrajectories trajectory1 expr2_trajectory
              in (pos,bound,newTrajectory)
            (Nothing,Just trajectory2) -> error $ constructErrorMsg innerLoc "TODO1" logContents2
            (Nothing,Nothing) -> error $ constructErrorMsg innerLoc "TODO2" logContents2
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
          counterSymExpr = SymVar (toSymType2 developmentSpeed) counterName
          in Just $ SBin boundSymExpr Sub counterSymExpr
   {-2-}(ReadOnly, Decreasing _) -> Nothing
   -- bound Increasing, counter Increasing (only if trajectory of counter bigger than trajectory of bound)
        (Increasing boundDevelopmentSpeed, Increasing counterDevelopmentSpeed)
   {-3-}  | counterDevelopmentSpeed `isSymExprGreaterThan` boundDevelopmentSpeed -> let
              counterSymExpr = SymVar (toSymType2 counterDevelopmentSpeed) counterName
              in Just $ SBin boundSymExpr Sub counterSymExpr
          | otherwise -> Nothing
   {-4-}(Increasing _, Decreasing _) -> Nothing
   {-5-}(Decreasing _, Increasing developmentSpeed) -> let
          counterSymExpr = SymVar (toSymType2 developmentSpeed) counterName
          in Just $ SBin boundSymExpr Sub counterSymExpr
        (Decreasing boundDevelopmentSpeed, Decreasing counterDevelopmentSpeed)
   {-6-}  | boundDevelopmentSpeed `isSymExprGreaterThan` counterDevelopmentSpeed -> let
              counterSymExpr = SymVar (toSymType2 counterDevelopmentSpeed) counterName
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
          counterSymExpr = SymVar (toSymType2 developmentSpeed) counterName in
          Just $ SBin counterSymExpr Sub boundSymExpr
   {-2-}(ReadOnly, Increasing _) -> Nothing
   {-3-}(Increasing _, Decreasing developmentSpeed) -> let
          counterSymExpr = SymVar (toSymType2 developmentSpeed) counterName in
          Just $ SBin counterSymExpr Sub boundSymExpr
   {-4-}(Increasing boundDevelopmentSpeed, Increasing counterDevelopmentSpeed)
          | boundDevelopmentSpeed `isSymExprGreaterThan` counterDevelopmentSpeed -> let
              counterSymExpr = SymVar (toSymType2 counterDevelopmentSpeed) counterName
              in Just $ SBin counterSymExpr Sub boundSymExpr
          | otherwise -> Nothing
   {-5-}(Decreasing boundDevelopmentSpeed, Decreasing counterDevelopmentSpeed)
          | counterDevelopmentSpeed `isSymExprGreaterThan` boundDevelopmentSpeed -> let
              counterSymExpr = SymVar (toSymType2 counterDevelopmentSpeed) counterName
              in Just $ SBin counterSymExpr Sub boundSymExpr
          | otherwise -> Nothing
   {-6-}(Decreasing _, Increasing _) -> Nothing
   {-7-}(_,ReadOnly) -> error $ constructErrorMsg innerLoc "won't happen2" logContents
   {-8-}(_,Mixed _) -> Nothing
   {-9-}(Mixed _,_) -> Nothing

--------------------
--------------------
--------------------

getLoopInitialGuardCondition :: [(String,SymExpr)] -> [SymExpr] -> SymbolicExecutionMonad (Maybe SymExpr)
getLoopInitialGuardCondition loopInitFacts loopGuards = do
  let loc = globalLoc ++ ".getLoopInitialGuardCondition"
      logContents = [
         ("loopInitFacts",show loopInitFacts)
        ,("loopGuards",show loopGuards)]
  constructLog loc "getLoopInitialGuardCondition" logContents
  let maybe_loopGuard :: Maybe SymExpr
      maybe_loopGuard = case loopGuards of
        [expr] -> Just expr
        [] -> Nothing
        _ -> error $ constructErrorMsg loc "TODO1" logContents
      loopGuard_vns :: [String]
      loopGuard_vns = maybe [] getVarNames3 maybe_loopGuard
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
     ("maybe_loopGuard",show maybe_loopGuard)
    ,("loopGuard_vns",show loopGuard_vns)
    ,("relevant_loopGuard_vns",show relevant_loopGuard_vns)
    ,("relevant_loopInitFacts",show relevant_loopInitFacts)]
  let toReturn = case relevant_loopInitFacts of
        [] -> Nothing
        _  -> substitute relevant_loopInitFacts <$> maybe_loopGuard
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopSkipCondition :: Maybe SymExpr -> SymbolicExecutionMonad (Maybe SymExpr)
getLoopSkipCondition loopInitialGuardCondition = do
  let loc = globalLoc ++ ".getLoopSkipCondition"
      logContents = [("loopInitialGuardCondition",show loopInitialGuardCondition)]
  constructLog loc "getLoopSkipCondition" logContents
  let toReturn = negate <$> loopInitialGuardCondition
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

--------------------
--------------------
--------------------

getLoopExitFacts :: [SymExpr] -> [(String,SymExprDevelopmentTrajectory)] -> SymbolicExecutionMonad [LoopExitFact]
getLoopExitFacts loopGuards loopFrameTargetsDevelopmentTrajectory = do
  let loc = globalLoc ++ ".getLoopExitFacts"
      logContents = [
         ("loopGuards",show loopGuards)
        ,("loopFrameTargetsDevelopmentTrajectory",show loopFrameTargetsDevelopmentTrajectory)
        ]
  constructLog loc "getLoopExitFacts" logContents
  let combining :: [(String,SymExpr,SymExprDevelopmentTrajectory)]
      combining = [res
        | loopGuard <- loopGuards
        , let vns = getVarNames3 loopGuard
        , let finding = [tu | tu@(vn,_) <- loopFrameTargetsDevelopmentTrajectory, vn `elem` vns]
        , let res = case finding of
                [(vn,trajectory)] -> (vn,loopGuard,trajectory)
                -- if there is an entry in loopFrameTargetsDevelopmentTrajectory
                -- which matches with multiple loop guards, then:
                _ -> error $ constructErrorMsg loc "TODO1" $ logContents ++ [
                  ("loopGuard",show loopGuard),
                  ("vns",show vns),
                  ("finding",show finding)]
        ]
  constructLog loc "summary" [("combining",show combining)]
  let toReturn = [res
        | (vn,loopGuard,trajectory) <- combining
        , let maybe_Res = symExprNextStep vn (isolate_vr vn loopGuard) trajectory
        , let res = case maybe_Res of
                Nothing -> error $ constructErrorMsg loc "TODO2" $ logContents ++
                  [("vn",vn)
                  ,("loopGuard",show loopGuard)
                  ,("trajectory",show trajectory)]
                Just loopExitFact -> loopExitFact
        ]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn where
  -- isolate `vr` in `loopGuard`
  isolate_vr :: String -> SymExpr -> SymExpr
  isolate_vr vn loopGuard = let
    loc = globalLoc ++ ".getLoopExitFacts.isolate_vr"
    logContents = [("vn",vn),("loopGuard",show loopGuard)] in
    case snd $ run_isolate $ isolate vn loopGuard of
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
      (Increasing step,SBin expr1@(SymVar _ vn2) op expr2) -> let
        step_type = toSymType2 step in if
        | vn == vn2 && isTypeNumeric step_type -> case op of
          Lt -> let
            left = expr2
            expr_r = SBin expr2 Add (SBin step Sub (cast step_type $ SymNum 1))
            right = numericCalculator expr_r
--          in error $ constructErrorMsg loc "ME" [("expr_r",show expr_r),("right",show right)]
            in if | isOne step -> Just $ LoopExitFactValue vn left
                  | otherwise  -> Just $ LoopExitFactRange vn left right
          Le -> let
            left = SBin expr2 Add (cast step_type $ SymNum 1)
            right = numericCalculator $ SBin expr2 Add step
            in if | isOne step -> Just $ LoopExitFactValue vn left
                  | otherwise  -> Just $ LoopExitFactRange vn left right
          _ -> error $ constructErrorMsg loc "TODO1" logContents
    
        | otherwise -> error $ constructErrorMsg loc "TODO2" logContents
      _ -> error $ constructErrorMsg loc "TODO3" logContents
