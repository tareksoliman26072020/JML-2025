module Internal.LoopPattern where

import SymbolicExecution.Types

-- testing the output of `inferLoopPatterns` in SymbolicExecution.Internal.LoopPattern
allTargets :: [(String,[[(LoopPattern,[LoopSummaryTag])]])]
allTargets = [
  ("idByLoop",idByLoop),
  ("idByLoopStride3",idByLoopStride3),
  ("idByLoop2",idByLoop2)
  ]

idByLoop :: [[(LoopPattern, [LoopSummaryTag])]]
idByLoop =
  [
   [
    (CounterPattern (CountingUp "i"),
     [LoopCounters,LoopFrameTargetsDevelopmentTrajectory,LoopCountersBounds]
    ),
    (BoundPattern (StableBound (SymVar Int "n" [])),
     [LoopCounters,LoopCountersBounds,LoopGuard,LoopBoundStabilityFacts,LoopReadOnlyVars]
    )
   ]
  ]

idByLoopStride3 :: [[(LoopPattern, [LoopSummaryTag])]]
idByLoopStride3 =
  [
   [
    (CounterPattern (CountingUp "i"),[LoopCounters,LoopFrameTargetsDevelopmentTrajectory,LoopCountersBounds]),
    (CounterPattern (StridedCounting "i"),[LoopCounters,LoopFrameTargetsDevelopmentTrajectory]),
    (BoundPattern (StableBound (SBin (SymVar Int "n" []) Add (SymInt 2))),
     [LoopCounters
     ,LoopCountersBounds
     ,LoopGuard
     ,LoopBoundStabilityFacts
     ,LoopReadOnlyVars
     ])
   ]
  ]

idByLoop2 :: [[(LoopPattern, [LoopSummaryTag])]]
idByLoop2 =
  [
   [
    (CounterPattern (CountingUp "i"),
     [LoopCounters
     ,LoopFrameTargetsDevelopmentTrajectory,LoopCountersBounds
     ]
    ),
    (BoundPattern $ StableBound (SymVar Int "n" []),
     [LoopCounters
     ,LoopCountersBounds
     ,LoopGuard
     ,LoopBoundStabilityFacts
     ,LoopReadOnlyVars
     ]
    ),
    (BoundPattern $ GuardlessWithInternalExit (SBin (SymVar Int "i" []) Ge (SymVar Int "n" [])),
     [LoopGuard
     ,LoopExitingConditions
     ]
    ),
    (ControlFlowPattern $ BreakExit (SBin (SymVar Int "i" []) Ge (SymVar Int "n" [])),
     [LoopExitViaBreakConditions])
   ]
  ]

