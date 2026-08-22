{-# Language LambdaCase, MultiWayIf, ScopedTypeVariables #-}
module SymbolicExecution.Internal.LoopPattern where

import Prelude hiding (negate)
import qualified CFG.Types as CFGT
import SymbolicExecution.Types
import SymbolicExecution.Internal.Internal
import SymbolicExecution.Internal.LoopSummary
import qualified SymbolicExecution.Logs.Log as Log
import qualified Data.Map as Map (empty)
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer
import Data.Functor (($>))
import Data.List
import Control.Monad (foldM)
import Data.Maybe (catMaybes)

inferLoopPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferLoopPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferLoopPatterns"
  constructLog loc "inferLoopPatterns" [("loopSummary",show loopSummary)]
  -- counterPatterns
  counterPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferCounterPatterns loopSummary
      <* decrementLogDepth
  constructLog loc "Counter Patterns" [("CounterPatterns",show counterPatterns)]
  -- boundPatterns
  boundPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferBoundPatterns loopSummary
      <* decrementLogDepth
  constructLog loc "Bound Patterns" [("BoundPatterns",show boundPatterns)]
  -- controlFlowPatterns
  controlFlowPattern <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferControlFlowPatterns loopSummary
      <* decrementLogDepth
  constructLog loc "Control Flow Patterns" [("BoundPatterns",show boundPatterns)]
  
  --
  let toReturn = counterPatterns ++ boundPatterns ++ controlFlowPattern
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-------------------------------------------------

inferCounterPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferCounterPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferCounterPatterns"
      theLoopCounters = loopCounters loopSummary
      logContents = [("loopCounters",show theLoopCounters)]
  tellNextLog $ Log.Location loc
  -- countingUpPatterns
  countingUpPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferCountingUpPatterns loopSummary
      <* decrementLogDepth
  -- countingDownPatterns
  countingDownPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferCountingDownPatterns loopSummary
      <* decrementLogDepth
  -- stridedCountingPatterns
  stridedCountingPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferStridedCountingPatterns loopSummary
      <* decrementLogDepth
  let toReturn = countingUpPatterns ++ countingDownPatterns ++ stridedCountingPatterns
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferBoundPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferBoundPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferBoundPatterns"
  tellNextLog $ Log.Location loc
  -- stableBoundPatterns
  stableBoundPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferStableBoundPatterns loopSummary
      <* decrementLogDepth
  -- movingBoundPatterns
  movingBoundPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferMovingBoundPatterns loopSummary
      <* decrementLogDepth
  -- guardlessBoundPatterns
  guardlessBoundPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferGuardlessWithInternalExitBoundPatterns loopSummary
      <* decrementLogDepth
  let toReturn = stableBoundPatterns ++ movingBoundPatterns ++ guardlessBoundPatterns
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferControlFlowPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferControlFlowPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferControlFlowPatterns"
  tellNextLog $ Log.Location loc
  -- breakExitPatterns
  breakExitPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferBreakExitPatterns loopSummary
      <* decrementLogDepth
  let toReturn = breakExitPatterns
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-------------------
-------------------
-------------------

inferCountingUpPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferCountingUpPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferCountingUpPatterns"
      allLoopCounters = loopCounters loopSummary
      allTrajectories = loopFrameTargetsDevelopmentTrajectory loopSummary
  constructLog loc "inferCountingUpPatterns" [
    ("allLoopCounters",show allLoopCounters),
    ("allTrajectories",show allTrajectories)]
  let toReturn = catMaybes [res
        | loopCounter <- allLoopCounters
        , let res = case lookup loopCounter allTrajectories of
                Just (Increasing step) -> Just (CounterPattern $ CountingUp loopCounter, countingUpPatternTags)
                _ -> Nothing
        ]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferCountingDownPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferCountingDownPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferCountingDownPatterns"
      allLoopCounters = loopCounters loopSummary
      allTrajectories = loopFrameTargetsDevelopmentTrajectory loopSummary
  constructLog loc "inferCountingDownPatterns" [
    ("allLoopCounters",show allLoopCounters),
    ("allTrajectories",show allTrajectories)]
  let toReturn = catMaybes [res
        | loopCounter <- allLoopCounters
        , let res = case lookup loopCounter allTrajectories of
                Just (Decreasing step) -> Just (CounterPattern $ CountingDown loopCounter, countingDownPatternTags)
                _ -> Nothing
        ]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferStridedCountingPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferStridedCountingPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferStridedCountingPatterns"
      allLoopCounters = loopCounters loopSummary
      allTrajectories = loopFrameTargetsDevelopmentTrajectory loopSummary
  constructLog loc "inferStridedCountingPatterns" [
    ("allLoopCounters",show allLoopCounters),
    ("allTrajectories",show allTrajectories)]
  let toReturn = catMaybes [res
        | loopCounter <- allLoopCounters
        , let res = case lookup loopCounter allTrajectories of
                Just (Increasing step)
                  | isOne step -> Nothing
                  | otherwise -> Just (CounterPattern $ StridedCounting loopCounter, stridedCountingPatternTags)
                Just (Decreasing step)
                  | isOne step -> Nothing
                  | otherwise -> Just (CounterPattern $ StridedCounting loopCounter, stridedCountingPatternTags)
                _ -> Nothing
        ]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-- if bound is stable, and counter „heads“ towards it,
-- then record the BoundPattern `StableBound`
inferStableBoundPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferStableBoundPatterns loopSummary = do
  let loc = "SymbolicEecution.Internal.LoopPattern.inferStableBoundPatterns"
      theLoopCountersBounds = loopCountersBounds loopSummary
  constructLog loc "inferStableBoundPatterns"
    $ [("loopSummary",show loopSummary)
      ,("loopCountersBounds",show theLoopCountersBounds)]
  let toReturn = concatMap checkBound theLoopCountersBounds
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn where
  checkBound :: (SymExpr, String, SymExpr) -> [(LoopPattern, [LoopSummaryTag])]
  checkBound (_, counterName, upperBound)
    | isLoopCounterIncreasing counterName loopSummary
      && isReadOnlyBoundViaStabilityFacts upperBound loopSummary
      = [(BoundPattern $ StableBound upperBound, stableBoundTags loopSummary upperBound)]
  checkBound (lowerBound, counterName, _)
    | isLoopCounterDecreasing counterName loopSummary
      && isReadOnlyBoundViaStabilityFacts lowerBound loopSummary
      = [(BoundPattern $ StableBound lowerBound, stableBoundTags loopSummary lowerBound)]
  checkBound _ = []

inferMovingBoundPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferMovingBoundPatterns _ = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferMovingBoundPatterns"
  tellNextLog $ Log.Location loc
  let toReturn :: [(LoopPattern,[LoopSummaryTag])] = []
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferGuardlessWithInternalExitBoundPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferGuardlessWithInternalExitBoundPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferGuardlessWithInternalExitBoundPatterns"
  tellNextLog $ Log.Location loc
  -- if there are guards in `loopExitingConditions` which are not derived from `loopGuard`
  -- then these conditions are to be processed
  let relevant_loopExitingConditions :: [SymExpr]
      relevant_loopExitingConditions = maybe (loopExitingConditions loopSummary)
        (\theLoopGuard -> [condition
          | condition <- loopExitingConditions loopSummary
          , negate condition /= theLoopGuard
          ]
        ) (loopGuard loopSummary)
  constructLog loc "Summary" [("relevant_loopExitingConditions",show relevant_loopExitingConditions)]
  let toReturn :: [(LoopPattern,[LoopSummaryTag])]
      toReturn = [(one,two)
        | cond <- relevant_loopExitingConditions
        , let one = BoundPattern $ GuardlessWithInternalExit cond
              two = guardlessWithInternalExitTags
        ]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferBreakExitPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferBreakExitPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferBreakExitPatterns"
  tellNextLog $ Log.Location loc
  let toReturn = [(one,two)
        | breakCond <- loopExitViaBreakConditions loopSummary
        , let one = ControlFlowPattern $ BreakExit breakCond
        , let two = breakExitPatternsTags
        ]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-------------------
-------------------
-------------------

countingUpPatternTags :: [LoopSummaryTag]
countingUpPatternTags = [LoopCounters, LoopFrameTargetsDevelopmentTrajectory, LoopCountersBounds]

countingDownPatternTags :: [LoopSummaryTag]
countingDownPatternTags = [LoopCounters, LoopFrameTargetsDevelopmentTrajectory, LoopCountersBounds]

stridedCountingPatternTags :: [LoopSummaryTag]
stridedCountingPatternTags = [LoopCounters, LoopFrameTargetsDevelopmentTrajectory]

stableBoundTags :: LoopSummary -> SymExpr -> [LoopSummaryTag]
stableBoundTags loopSummary bound =
  concat
    [ [LoopCounters]
    , [LoopCountersBounds]
    , [LoopGuard]

    , if isReadOnlyBoundViaStabilityFacts bound loopSummary
        then [LoopBoundStabilityFacts]
        else []

    , if isReadOnlyBoundViaReadOnlyVars bound loopSummary
        then [LoopReadOnlyVars]
        else []
    ]

guardlessWithInternalExitTags :: [LoopSummaryTag]
guardlessWithInternalExitTags = [LoopGuard,LoopExitingConditions]

breakExitPatternsTags :: [LoopSummaryTag]
breakExitPatternsTags = [LoopExitViaBreakConditions]

-------------------
-------------------
-------------------

run_inferLoopPatterns :: SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])] -> (String,Either String [(LoopPattern,[LoopSummaryTag])])
run_inferLoopPatterns = runMonad
