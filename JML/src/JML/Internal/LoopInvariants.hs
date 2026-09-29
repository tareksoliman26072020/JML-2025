{-# Language MultiWayIf, LambdaCase, ScopedTypeVariables #-}
module JML.Internal.LoopInvariants where

import Prelude hiding (negate)
import Control.Monad.State (get)
import Control.Monad.Except (throwError)
import Text.Printf (printf)
import Data.List
import Data.Functor (($>))
import qualified Data.Map as Map (Map)
import Data.Maybe (catMaybes)

import JML.Types
import JML.Internal.Internal
import qualified JML.Logs.Log as Log

import qualified CFG.Types as CFGT (ScopeRange)

import qualified SymbolicExecution.Types as SYT
import qualified SymbolicExecution.Internal.Internal as SY.Internal
import qualified SymbolicExecution.Internal.Math.Calculator as SY.Calculator (substitute)

globalLoc = "JML.Internal.LoopInvariants"

inferLoopInvariantTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferLoopInvariantTemplates loopSummary allLoopPatternsInfos = do
  let loc = globalLoc ++ ".inferLoopInvariantTemplates"
      logContents = [
        ("loopSummary",show loopSummary),
        ("allLoopPatternsInfos",show allLoopPatternsInfos)]
  constructLog loc "inferLoopInvariantTemplates" logContents
  --------------------------
  -- theMaintainingTemplates
  --------------------------
  theMaintainingTemplates <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferMaintainingTemplates loopSummary allLoopPatternsInfos
        <* decrementLogDepth
  --------------------------
  -- theLoopAssignsTemplates
  --------------------------
  theLoopAssignsTemplates <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferLoopAssignsTemplates loopSummary allLoopPatternsInfos
        <* decrementLogDepth
  ------------------------
  -- theDecreasesTemplates
  ------------------------
  theDecreasesTemplates <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferDecreasesTemplates loopSummary
        <* decrementLogDepth
  -----------
  -- toReturn
  -----------
  let toReturn =
        theMaintainingTemplates ++
        theLoopAssignsTemplates ++
        theDecreasesTemplates
  constructLog loc "Summary" $ logContents ++
    [("theMaintainingTemplates",show theMaintainingTemplates)
    ,("theLoopAssignsTemplates",show theLoopAssignsTemplates)
    ,("theDecreasesTemplates",show theDecreasesTemplates)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferMaintainingTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferMaintainingTemplates loopSummary allLoopPatternsInfos = do
  let loc = globalLoc ++ ".inferMaintainingTemplates"
      logContents = [
        ("loopSummary",show loopSummary),
        ("allLoopPatternsInfos",show allLoopPatternsInfos)]
  constructLog loc "inferMaintainingTemplates" logContents
  ----------------------------
  -- theCounterBoundsTemplates
  ----------------------------
  theCounterBoundsTemplates <- let
    relevantLoopPatternsInfos = SY.Internal.filterLoopPatterns
      isCounterBoundsTemplatePattern isCounterBoundsTemplateTag allLoopPatternsInfos
    in do
    incrementLogEnumeration
    incrementLogDepth *>
      inferCounterBoundsTemplates loopSummary relevantLoopPatternsInfos
        <* decrementLogDepth
  -----------------------------
  -- theStridedCounterTemplates
  -----------------------------
  theStridedCounterTemplates <- let
    relevantLoopPatternsInfos = SY.Internal.filterLoopPatterns
      isStridedCounterTemplatePattern isStridedCounterTemplateTag allLoopPatternsInfos
    in do
    incrementLogEnumeration
    incrementLogDepth *>
      inferStridedCounterTemplates loopSummary relevantLoopPatternsInfos
        <* decrementLogDepth
  ------------------------------
  -- theSearchExclusionTemplates
  ------------------------------
  theSearchExclusionTemplates <- let
    relevantLoopPatternsInfos = SY.Internal.filterLoopPatterns
      istheSearchExclusionTemplatePattern istheSearchExclusionTemplateTag allLoopPatternsInfos
    in do
    incrementLogEnumeration
    incrementLogDepth *>
      inferSearchExclusionTemplates loopSummary relevantLoopPatternsInfos
        <* decrementLogDepth
  -----------
  -- toReturn
  -----------
  let toReturn =
        theCounterBoundsTemplates  ++
        theStridedCounterTemplates ++
        theSearchExclusionTemplates
  constructLog loc "Summary" $ logContents ++
    [("theCounterBoundsTemplates",show theCounterBoundsTemplates)
    ,("theStridedCounterTemplates",show theStridedCounterTemplates)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferLoopAssignsTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferLoopAssignsTemplates loopSummary allLoopPatternsInfos = do
  let loc = globalLoc ++ ".inferLoopAssignsTemplates"
      logContents = [
        ("loopSummary",show loopSummary),
        ("allLoopPatternsInfos",show allLoopPatternsInfos)]
  constructLog loc "inferLoopAssignsTemplates" logContents
  ------------------------
  -- theLoopFrameTemplates
  ------------------------
  theLoopFrameTemplates <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferLoopFrameTemplates loopSummary
        <* decrementLogDepth
  let toReturn = theLoopFrameTemplates
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

{-
data LoopPattern
  = CounterPattern CounterPattern
  | BoundPattern BoundPattern
  | TraversalPattern TraversalPattern
  | MutationPattern MutationPattern
  | AccumulatorPattern AccumulatorPattern
  | SearchPattern SearchPattern
  | ControlFlowPattern ControlFlowPattern
  | HelperCallPattern
  | TwoFrontierPattern
  | UnknownPattern
 -}
-- CounterPattern ==> loopCountersBounds ==> CounterBoundsTemplate
inferCounterBoundsTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferCounterBoundsTemplates loopSummary loopPatternsInfos = do
  let loc = globalLoc ++ ".inferCounterBoundsTemplates"
      logContents = [("loopPatternsInfos",show loopPatternsInfos)]
  constructLog loc "inferCounterBoundsTemplates" logContents
  let checkPatterns = [tu
        | tu@(SYT.CounterPattern _,[SYT.LoopCountersBounds]) <- loopPatternsInfos
        ]
  let toReturn :: [LoopInvariantTemplate]
      toReturn = case checkPatterns of
        [] -> []
        _ -> [res
          | (l,(_,c),u) <- SYT.loopCountersBounds loopSummary
          , let res = Maintaining $ CounterBoundsTemplate
                  (symExprToExpr2 l) c (symExprToExpr2 u)
          ]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-- CounterPattern StridedCounting ==> [LoopFrameTargets, LoopInitFacts, LoopFrameTargetsDevelopmentTrajectory]
inferStridedCounterTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferStridedCounterTemplates loopSummary loopPatternsInfos = do
  let loc = globalLoc ++ ".inferStridedCounterTemplates"
      logContents = [("loopPatternsInfos",show loopPatternsInfos)]
  constructLog loc "inferStridedCounterTemplates" logContents
  let relevantVarTrajectories :: [(String,SYT.SymExprDevelopmentTrajectory)]
      relevantVarTrajectories = flip filter (SYT.loopFrameTargetsDevelopmentTrajectory loopSummary)
        $ \(_,trajectory) -> case trajectory of
          SYT.Increasing step -> not (SY.Internal.isOne step)
          SYT.Decreasing step -> not (SY.Internal.isOne step)
          _ -> False
      relevantLoopInitFacts :: [(String,SYT.SymbolicExecutionValue)]
      relevantLoopInitFacts = flip filter (SYT.loopInitFacts loopSummary)
        $ \(vn,_) -> maybe False (const True) (lookup vn relevantVarTrajectories)
      toReturn = [ Maintaining $ StridedCounterTemplate vn1 stride (symExprToExpr2 initVal)
        | (vn1,trajectory) <- relevantVarTrajectories
        , (vn2,initVal) <- relevantLoopInitFacts
        , vn1 == vn2
        , let stride = symExprToExpr2 $ case trajectory of
                SYT.Increasing step -> step
                SYT.Decreasing step -> step
        ]
  constructLog loc "Summary" [
    ("relevantVarTrajectories",show relevantVarTrajectories),
    ("relevantLoopInitFacts",show relevantLoopInitFacts),
    ("toReturn",show toReturn)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferSearchExclusionTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferSearchExclusionTemplates loopSummary loopPatternsInfos = do
  let loc = globalLoc ++ ".inferSearchExclusionTemplates"
      logContents = [("loopPatternsInfos",show loopPatternsInfos)]
  constructLog loc "inferSearchExclusionTemplates" logContents
  let from_loopPatterns :: [(SYT.StateChangingConditions,Maybe SYT.SymbolicExecutionValue)]
      from_loopPatterns = SY.Internal.getSimilar_linearSearch_earlyReturn loopPatternsInfos
      -- convert the conditions in `from_loopPatterns` to SymExprs
      symExprs :: [SYT.SymbolicExecutionValue]
      symExprs = concat [res
        | (conds,_) <- from_loopPatterns
        , let res :: [SYT.SymbolicExecutionValue] = concat [res
                | (_,cond) <- conds
                , let condSymType = studyCondSymType cond
                , let res = SY.Internal.stateChangingCondition_2_symExprs condSymType cond
                ]
        ]
      {-
      [(
        [(SymInt 0,("i",Increasing (SymInt 1)),SObjAcc ["a","length"])]
       ,SBin (SArrayIndexAccess (Array Int) "a" (SymVar Int "i" [])) Eq (SymVar Int "x" [])
       )
      ]
       -}
      infos :: [([(SYT.SymbolicExecutionValue,(SYT.SymType,String,SYT.SymExprDevelopmentTrajectory),SYT.SymbolicExecutionValue)]
                ,SYT.SymbolicExecutionValue)]
      infos = [(with_bounds,symExpr)
        | symExpr <- symExprs
        , let vns = SY.Internal.getVarNames3 symExpr
        , let relevant_vns_trajectories :: [(String,SYT.SymExprDevelopmentTrajectory)]
              relevant_vns_trajectories = [ a
                | a@(vn,_) <- SYT.loopFrameTargetsDevelopmentTrajectory loopSummary
                , vn `elem` vns
                ]
        , let with_bounds :: [(SYT.SymbolicExecutionValue
                             ,(SYT.SymType,String,SYT.SymExprDevelopmentTrajectory)
                             ,SYT.SymbolicExecutionValue)]
              with_bounds = catMaybes [res
                | (lower,(vnType,vn),upper) <- SYT.loopCountersBounds loopSummary
                , let res = flip fmap (lookup vn relevant_vns_trajectories)
                        $ \trajectory -> (lower,(vnType,vn,trajectory),upper)
                ]
        ]
  let toReturn = studyInfos infos
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
  {-throwError $ constructErrorMsg loc "MEOW:Summary" $ logContents ++ [
    ("from_loopPatterns",show from_loopPatterns),
    ("symExprs",show symExprs),
    ("infos",show infos)] -}where
  -- get the SymType of the array mentioned in the condition
  studyCondSymType :: SYT.StateChangingCondition -> SYT.SymType
  studyCondSymType cond = let
    loc = globalLoc ++ ".inferSearchExclusionTemplates.studyCondSymType"
    logContents = [("cond",show cond)] in
    case cond of
      -- you get array type from LoopSummary: `dynamicallyAccessedArrays`
      SYT.ElemInArray arrName _ _ -> let
        finding = flip find (SYT.dynamicallyAccessedArrays loopSummary)
          $ \(_,arrName2,_) -> arrName == arrName2 in
        case finding of
          Just (arrType,_,_) -> arrType
          _ -> error $ constructErrorMsg loc "TODO1" logContents
      _ -> error $ constructErrorMsg loc "TODO2" $ logContents
             ++ [("logContents",show logContents)
                 ,("cond",show cond)]
  --
  studyInfos :: [([(SYT.SymbolicExecutionValue,(SYT.SymType,String,SYT.SymExprDevelopmentTrajectory),SYT.SymbolicExecutionValue)]
                 ,SYT.SymbolicExecutionValue)] -> [LoopInvariantTemplate] = \infos -> let
    loc = globalLoc ++ ".inferSearchExclusionTemplates.studyInfos" in [Maintaining res
    | (predicateInformations,predicate) <- infos
    , (lowerBoundSymExpr,(counterType,counterName,counterTrajectory),upperBoundSymExpr) <- predicateInformations
    , let logContents = [
            ("predicate",show predicate),
            ("lowerBoundSymExpr",show lowerBoundSymExpr),
            ("counterName",counterName),
            ("counterTrajectory",show counterTrajectory),
            ("upperBoundSymExpr",show upperBoundSymExpr)]
    {-
      SearchExclusionTemplate
      1)  (String     -- quantified variable name
      2)  ,JMLType)   -- type of quantified variable
      3)  Expr        -- counterLowerBound
      4)  (String     -- counter
      5)  ,SymExpr)   -- counter init fact
      6)  Expr        -- counterTrajectoryStride
      7)  Expr        -- counterUpperBound
      8)  Expr        -- metPredicate
   -}
    , let one   :: String = "k"
          two   :: JMLType = toJMLType counterType
          three :: Expr = symExprToExpr2 lowerBoundSymExpr
          five  :: Expr = case lookup counterName (SYT.loopInitFacts loopSummary) of
            Just counterInitFact -> symExprToExpr2 counterInitFact
            Nothing -> error $ constructErrorMsg loc "TODO1" logContents
          six   :: Expr = case counterTrajectory of
            SYT.Increasing symExpr -> symExprToExpr2 symExpr
            SYT.Decreasing symExpr -> symExprToExpr2 symExpr
            _ -> error $ constructErrorMsg loc "TODO2" logContents
          seven :: Expr = symExprToExpr2 upperBoundSymExpr
          eight :: Expr = negate
            $ symExprToExpr2 
            $ SY.Calculator.substitute [(counterName,SYT.SymVar counterType one [])] predicate
          nine  :: Bool = case counterTrajectory of
            SYT.Increasing symExpr -> SY.Internal.isOne symExpr
            SYT.Decreasing symExpr -> SY.Internal.isOne symExpr
            _ -> error $ constructErrorMsg loc "TODO3" logContents
          res = SearchExclusionTemplate (one,two) three (counterName,five) six seven eight nine
    ]

-- CounterPattern ==> LoopFrameTargets ==> LoopFrameTemplate
inferLoopFrameTemplates :: SYT.LoopSummary -> JMLMonad [LoopInvariantTemplate]
inferLoopFrameTemplates loopSummary = do
  let loc = globalLoc ++ ".inferLoopFrameTemplates"
  constructLog loc "inferLoopFrameTemplates" []
  let toReturn = [LoopAssigns $ LoopFrameTemplate $ SYT.loopFrameTargets loopSummary]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-- CounterPattern ==> LoopDecreasesCandidate ==> DecreasesTemplate
inferDecreasesTemplates :: SYT.LoopSummary -> JMLMonad [LoopInvariantTemplate]
inferDecreasesTemplates loopSummary = do
  let loc = globalLoc ++ ".inferDecreasesTemplates"
  constructLog loc "inferDecreasesTemplates" []
  let toReturn = [res
          | candidate <- SYT.loopDecreasesCandidate loopSummary
          , let res = DecreasesTemplate $ symExprToExpr2 candidate
          ]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-----------
-----------
-----------

run_inferLoopInvariantTemplates :: Map.Map String SYT.SymbolicExecution -> String -> JMLMonad [LoopInvariantTemplate] -> (Either String [LoopInvariantTemplate],[Log.Log],JMLState)
run_inferLoopInvariantTemplates = runMonad
  
