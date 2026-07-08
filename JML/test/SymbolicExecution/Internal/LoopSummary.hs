module Internal.LoopSummary where

import SymbolicExecution.Types

-- testing the output of `createLoopSummary` in SymbolicExecution.Method
allTargets :: [(String,[LoopSummary])]
allTargets = [
  ("idByLoop",idByLoop)
  ]

idByLoop :: [LoopSummary]
idByLoop = [LoopSummary {
  loopSyntax = WhileSyntax,
  loopReadOnlyVars = ["n"],
  loopFrameTargets = ["i"],
  loopInitFacts = [("i",SymInt 0)],
  loopGuards = [SBin (SymVar Int "i") Lt (SymVar Int "n")],
  loopInitialGuardCondition = Just $ SBin (SymInt 0) Lt (SymVar Int "n"),
  loopSkipCondition = Just (SBin (SymInt 0) Ge (SymVar Int "n")),
  loopExitConditions = [SBin (SymVar Int "i") Ge (SymVar Int "n")],
  loopCounters = ["i"],
  loopAssignments = ["i"],
  loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 1))],
  loopCountersBounds = [(SymInt 0,"i",SymVar Int "n")],
  loopBoundStabilityFacts = [(SymVar Int "n",ReadOnly)],
  loopDecreasesCandidate = [SBin (SymVar Int "n") Sub (SymVar Int "i")],
  loopExitFacts = [LoopExitFactValue "i" (SBin (SymVar Int "i") Eq (SymVar Int "n"))]
}]
