module Internal.LoopPattern where

import SymbolicExecution.Types

-- testing the output of `inferLoopPatterns` in SymbolicExecution.Internal.LoopPattern
allTargets :: [(String,[[(LoopPattern,[LoopSummaryTag])]])]
allTargets = [
  ("idByLoop",idByLoop)
  ]

idByLoop :: [[(LoopPattern, [LoopSummaryTag])]]
idByLoop = [
  [
    (CounterPattern CountingUp,
      [LoopCounters
      ,LoopFrameTargetsDevelopmentTrajectory
      ,LoopInitFacts
      ,LoopGuards
      ,LoopCountersBounds
      ,LoopAssignments
      ,LoopFrameTargets
      ,LoopDecreasesCandidate]),
    (BoundPattern StableBound,
      [LoopCounters
      ,LoopCountersBounds
      ,LoopGuards
      ,LoopBoundStabilityFacts
      ,LoopReadOnlyVars])
  ]]
