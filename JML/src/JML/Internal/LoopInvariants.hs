{-# Language MultiWayIf, LambdaCase, ScopedTypeVariables #-}
module JML.Internal.LoopInvariants where

import Control.Monad.State (get)
import Control.Monad.Except (throwError)
import Text.Printf (printf)
import Data.List
import Data.Functor (($>))
import qualified Data.Map as Map (Map)

import JML.Types
import JML.Internal.Internal
import qualified JML.Logs.Log as Log

import qualified CFG.Types as CFGT (ScopeRange)

import qualified SymbolicExecution.Types as SYT
import qualified SymbolicExecution.Internal.Internal as SY.Internal

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
  -----------
  -- toReturn
  -----------
  let toReturn =
        theCounterBoundsTemplates ++
        theStridedCounterTemplates
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
        [_] -> [res
          | (l,c,u) <- SYT.loopCountersBounds loopSummary
          , let res = Maintaining $ CounterBoundsTemplate
                  (symExprToExpr2 l) c (symExprToExpr2 u)
          ]
        _ -> error $ constructErrorMsg loc "won't happen" $ logContents
          ++ [("checkPatterns",show checkPatterns)]
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
  
