{-# Language LambdaCase, MultiWayIf, ScopedTypeVariables #-}
module SymbolicExecution.Internal.LoopPattern where

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
  --
  let toReturn = mergePatternTags
        $ counterPatterns ++ boundPatterns
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferCounterPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferCounterPatterns loopSummary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferCounterPatterns"
      theLoopCounters = loopCounters loopSummary
      logContents = [("loopCounters",show theLoopCounters)]
  tellNextLog $ Log.Location loc
  toReturn <- foldM f [] theLoopCounters
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
  where
  f :: [(LoopPattern,[LoopSummaryTag])] -> String -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
  f acc aLoopCounter = do
    incrementLogEnumeration
    incrementLogDepth
    maybe_counterPattern <- inferCounterPattern loopSummary aLoopCounter
    decrementLogDepth
    return $ acc ++ case maybe_counterPattern of
      Just counterPattern -> [counterPattern]
      Nothing -> []

inferCounterPattern :: LoopSummary -> String -> SymbolicExecutionMonad (Maybe (LoopPattern,[LoopSummaryTag]))
inferCounterPattern loopSummary counterName = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferCounterPattern"
  let counterTags = counterPatternTags loopSummary counterName
  constructLog loc "inferCounterPattern" [("counterName",counterName),("counterTags",show counterTags)]
  let toReturn = case lookup counterName (loopFrameTargetsDevelopmentTrajectory loopSummary) of
        Just (Increasing step)
          | isOne step -> Just (CounterPattern CountingUp, counterTags)
          | otherwise -> Just (CounterPattern StridedCounting, counterTags)

        Just (Decreasing step)
          | isOne step -> Just (CounterPattern CountingDown, counterTags)
          | otherwise -> Just (CounterPattern StridedCounting, counterTags)

        Just (Mixed _) -> Just (
          CounterPattern ConditionalCounterMovement,
          [LoopCounters, LoopFrameTargetsDevelopmentTrajectory])

        Just ReadOnly -> Nothing

        Nothing -> error $ constructErrorMsg loc "won't happen" [("counterName",counterName)]
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
      inferGuardlessBoundPatterns loopSummary
      <* decrementLogDepth
  let toReturn = stableBoundPatterns ++ movingBoundPatterns ++ guardlessBoundPatterns
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-------------------
-------------------
-------------------

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
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
  where
    checkBound :: (SymExpr, String, SymExpr)
               -> [(LoopPattern, [LoopSummaryTag])]
    checkBound (_, counterName, upperBound)
      | isLoopCounterIncreasing counterName loopSummary
        && isReadOnlyBoundViaStabilityFacts upperBound loopSummary
        = [(BoundPattern StableBound, stableBoundTags loopSummary upperBound)]
    checkBound (lowerBound, counterName, _)
      | isLoopCounterDecreasing counterName loopSummary
        && isReadOnlyBoundViaStabilityFacts lowerBound loopSummary
        = [(BoundPattern StableBound, stableBoundTags loopSummary lowerBound)]
    checkBound _ = []

inferMovingBoundPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferMovingBoundPatterns _ = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferMovingBoundPatterns"
  tellNextLog $ Log.Location loc
  let toReturn :: [(LoopPattern,[LoopSummaryTag])] = []
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferGuardlessBoundPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferGuardlessBoundPatterns _ = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferGuardlessBoundPatterns"
  tellNextLog $ Log.Location loc
  let toReturn :: [(LoopPattern,[LoopSummaryTag])] = []
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-------------------
-------------------
-------------------

mergePatternTags :: [(LoopPattern, [LoopSummaryTag])]
                 -> [(LoopPattern, [LoopSummaryTag])]
mergePatternTags = foldl' f [] where
  f :: [(LoopPattern, [LoopSummaryTag])] -> (LoopPattern, [LoopSummaryTag])
      -> [(LoopPattern, [LoopSummaryTag])]
  f [] (pat, tags) = [(pat, nub tags)]
  f ((acc_pat, acc_tags) : rest) (pat, tags)
    | pat == acc_pat = (acc_pat, nub (tags ++ acc_tags)) : rest
    | otherwise = (acc_pat, acc_tags) : f rest (pat, tags)

-------------------
-------------------
-------------------

-- tags are needed to recognize the pattern, some are needed to instantiate the template, and some are mainly useful for validation/debugging/provenance.
counterPatternTags :: LoopSummary -> String -> [LoopSummaryTag]
counterPatternTags loopSummary counterName =
  concat
    [ [LoopCounters]
    , [LoopFrameTargetsDevelopmentTrajectory]

    , if initFactsHasCounter counterName loopSummary
        then [LoopInitFacts]
        else []

    , if loopGuardHasCounter counterName loopSummary
        then [LoopGuards]
        else []

    , if loopCounterBoundsHasCounter counterName loopSummary
        then [LoopCountersBounds]
        else []

    , if counterName `elem` loopAssignments loopSummary
        then [LoopAssignments]
        else []

    , if counterName `elem` loopFrameTargets loopSummary
        then [LoopFrameTargets]
        else []
    
    , if loopDecreasesCandidatesHasCounter counterName loopSummary
        then [LoopDecreasesCandidate]
        else []
    , -- When `CounterPattern StridedCounting`,
      -- then `LoopFrameTargets`, `LoopInitFacts` are relevant and needed
      case lookup counterName (loopFrameTargetsDevelopmentTrajectory loopSummary) of
        Just (Increasing step)
          | isOne step -> []
          | otherwise -> [LoopFrameTargets,LoopInitFacts]
        Nothing -> []
    ]

stableBoundTags :: LoopSummary -> SymExpr -> [LoopSummaryTag]
stableBoundTags loopSummary bound =
  concat
    [ [LoopCounters]
    , [LoopCountersBounds]
    , [LoopGuards]

    , if isReadOnlyBoundViaStabilityFacts bound loopSummary
        then [LoopBoundStabilityFacts]
        else []

    , if isReadOnlyBoundViaReadOnlyVars bound loopSummary
        then [LoopReadOnlyVars]
        else []

    ]

-------------------
-------------------
-------------------

run_inferLoopPatterns :: SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])] -> (String,Either String [(LoopPattern,[LoopSummaryTag])])
run_inferLoopPatterns = runMonad
