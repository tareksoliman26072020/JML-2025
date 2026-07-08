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
inferLoopPatterns summary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferLoopPatterns"
  constructLog loc "inferLoopPatterns" [("summary",show summary)]
  -- counterPatterns
  counterPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferCounterPatterns summary
      <* decrementLogDepth
  constructLog loc "Counter Patterns" [("CounterPatterns",show counterPatterns)]
  -- boundPatterns
  boundPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferBoundPatterns summary
      <* decrementLogDepth
  constructLog loc "Bound Patterns" [("BoundPatterns",show boundPatterns)]
  --
  let toReturn = mergePatternTags
        $ counterPatterns ++ boundPatterns
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

inferCounterPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferCounterPatterns summary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferCounterPatterns"
      theLoopCounters = loopCounters summary
      logContents = [("loopCounters",show theLoopCounters)]
  tellNextLog $ Log.Location loc
  toReturn <- foldM f [] theLoopCounters
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
  --concatMap (inferCounterPattern summary) theLoopCounters
  where
  f :: [(LoopPattern,[LoopSummaryTag])] -> String -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
  f acc aLoopCounter = do
    incrementLogEnumeration
    incrementLogDepth
    maybe_counterPattern <- inferCounterPattern summary aLoopCounter
    decrementLogDepth
    return $ acc ++ case maybe_counterPattern of
      Just counterPattern -> [counterPattern]
      Nothing -> []

inferCounterPattern :: LoopSummary -> String -> SymbolicExecutionMonad (Maybe (LoopPattern,[LoopSummaryTag]))
inferCounterPattern summary counterName = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferCounterPattern"
  let counterTags = counterPatternTags summary counterName
  constructLog loc "inferCounterPattern" [("counterName",counterName),("counterTags",show counterTags)]
  let toReturn = case lookup counterName (loopFrameTargetsDevelopmentTrajectory summary) of
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
inferBoundPatterns summary = do
  let loc = "SymbolicExecution.Internal.LoopPattern.inferBoundPatterns"
  tellNextLog $ Log.Location loc
  -- stableBoundPatterns
  stableBoundPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferStableBoundPatterns summary
      <* decrementLogDepth
  -- movingBoundPatterns
  movingBoundPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferMovingBoundPatterns summary
      <* decrementLogDepth
  -- guardlessBoundPatterns
  guardlessBoundPatterns <- do
    incrementLogEnumeration
    incrementLogDepth *>
      inferGuardlessBoundPatterns summary
      <* decrementLogDepth
  let toReturn = stableBoundPatterns ++ movingBoundPatterns ++ guardlessBoundPatterns
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-------------------
-------------------
-------------------

-- if bound is stable, and counter „heads“ towards it,
-- then record the BoundPattern `StableBound`
inferStableBoundPatterns :: LoopSummary -> SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])]
inferStableBoundPatterns summary = do
  let loc = "SymbolicEecution.Internal.LoopPattern.inferStableBoundPatterns"
      theLoopCountersBounds = loopCountersBounds summary
  constructLog loc "inferStableBoundPatterns"
    $ [("summary",show summary),("loopCountersBounds",show theLoopCountersBounds)]
  let toReturn = concatMap checkBound theLoopCountersBounds
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
  where
    checkBound :: (SymExpr, String, SymExpr)
               -> [(LoopPattern, [LoopSummaryTag])]
    checkBound (_, counterName, upperBound)
      | isLoopCounterIncreasing counterName summary
        && isReadOnlyBoundViaStabilityFacts upperBound summary
        = [(BoundPattern StableBound, stableBoundTags summary upperBound)]
    checkBound (lowerBound, counterName, _)
      | isLoopCounterDecreasing counterName summary
        && isReadOnlyBoundViaStabilityFacts lowerBound summary
        = [(BoundPattern StableBound, stableBoundTags summary lowerBound)]
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
counterPatternTags summary counterName =
  concat
    [ [LoopCounters]
    , [LoopFrameTargetsDevelopmentTrajectory]

    , if initFactsHasCounter counterName summary
        then [LoopInitFacts]
        else []

    , if loopGuardHasCounter counterName summary
        then [LoopGuards]
        else []

    , if loopCounterBoundsHasCounter counterName summary
        then [LoopCountersBounds]
        else []

    , if counterName `elem` loopAssignments summary
        then [LoopAssignments]
        else []

    , if counterName `elem` loopFrameTargets summary
        then [LoopFrameTargets]
        else []
    
    , if loopDecreasesCandidatesHasCounter counterName summary
        then [LoopDecreasesCandidate]
        else []
    ]

stableBoundTags :: LoopSummary -> SymExpr -> [LoopSummaryTag]
stableBoundTags summary bound =
  concat
    [ [LoopCounters]
    , [LoopCountersBounds]
    , [LoopGuards]

    , if isReadOnlyBoundViaStabilityFacts bound summary
        then [LoopBoundStabilityFacts]
        else []

    , if isReadOnlyBoundViaReadOnlyVars bound summary
        then [LoopReadOnlyVars]
        else []

    ]

-------------------
-------------------
-------------------

run_inferLoopPatterns :: SymbolicExecutionMonad [(LoopPattern,[LoopSummaryTag])] -> (String,Either String [(LoopPattern,[LoopSummaryTag])])
run_inferLoopPatterns = runMonad
