module Internal.LoopSummary where

import SymbolicExecution.Types
import CFG.Types (ScopeRange(..), Node_Coor(..))

-- testing the output of `createLoopSummary` in SymbolicExecution.Method
allTargets :: [(String,[LoopSummary])]
allTargets = [
  ("idByLoop",idByLoop),
  ("idByLoopStride3",idByLoopStride3),
  ("idByLoop2",idByLoop2),
  ("halving",halving),
  ("contains",contains)
  ]

idByLoop :: [LoopSummary]
idByLoop = [LoopSummary {
  loopSyntax = WhileSyntax,
  loopReadOnlyVars = ["n"],
  loopFrameTargets = ["i"],
  loopInitFacts = [("i",SymInt 0)],
  loopGuard = Just $ SBin (SymVar Int "i" []) Lt (SymVar Int "n" []),
  loopEnteringCondition = Just $ SBin (SymInt 0) Lt (SymVar Int "n" []),
  loopSkipCondition = Just (SBin (SymInt 0) Ge (SymVar Int "n" [])),
  loopExitingConditions = [([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}],SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))],
  loopExitViaBreakFacts = [],
  loopExitViaReturnFacts = [],
  loopCounters = ["i"],
  dynamicallyAccessedArrays = [],
  loopAssignments = ["i"],
  loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 1))],
  loopCountersBounds = [(SymInt 0,(Int,"i"),SymVar Int "n" [])],
  loopBoundStabilityFacts = [(SymVar Int "n" [],ReadOnly)],
  loopDecreasesCandidate = [SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])],
  loopExitFacts = [
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}],
     LoopExitFactValue "i" (SymVar Int "n" []))]
}]

idByLoopStride3 :: [LoopSummary]
idByLoopStride3 = [LoopSummary {
  loopSyntax = WhileSyntax,
  loopReadOnlyVars = ["n"],
  loopFrameTargets = ["i"],
  loopInitFacts = [("i",SymInt 0)],
  loopGuard = Just $ SBin (SymVar Int "i" []) Lt (SymVar Int "n" []),
  loopEnteringCondition = Just (SBin (SymInt 0) Lt (SymVar Int "n" [])),
  loopSkipCondition = Just (SBin (SymInt 0) Ge (SymVar Int "n" [])),
  loopExitingConditions = [
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}],
     SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))],
  loopExitViaBreakFacts = [],
  loopExitViaReturnFacts = [],
  loopCounters = ["i"],
  dynamicallyAccessedArrays = [],
  loopAssignments = ["i"],
  loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 3))],
  loopCountersBounds = [(SymInt 0,(Int,"i"),SBin (SymVar Int "n" []) Add (SymInt 2))],
  loopBoundStabilityFacts = [(SymVar Int "n" [],ReadOnly),(SBin (SymVar Int "n" []) Add (SymInt 2),ReadOnly)],
  loopDecreasesCandidate = [SBin (SBin (SymVar Int "n" []) Add (SymInt 2)) Sub (SymVar Int "i" [])],
  loopExitFacts = [
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}],
     LoopExitFactRange "i" (SymVar Int "n" []) (SBin (SymVar Int "n" []) Add (SymInt 2)))]
}]


idByLoop2 :: [LoopSummary]
idByLoop2 = [LoopSummary {
  loopSyntax = WhileSyntax,
  loopReadOnlyVars = ["n"],
  loopFrameTargets = ["i"],
  loopInitFacts = [("i",SymInt 0)],
  loopGuard = Just (SBool True),
  loopEnteringCondition = Just (SBool True),
  loopSkipCondition = Just (SBool False),
  loopExitingConditions = [
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 2, branchEnd = 7}},Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}}],
     SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))],
  loopExitViaBreakFacts = [
    [
      (Just $ Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}},
       Condition $ SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))
    ]
  ],
  loopExitViaReturnFacts = [],
  loopCounters = ["i"],
  dynamicallyAccessedArrays = [],
  loopAssignments = ["i"],
  loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 1))],
  loopExitFacts = [
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 2, branchEnd = 7}},Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}}],
     LoopExitFactValue "i" (SymVar Int "n" []))],
  loopCountersBounds = [(SymInt 0,(Int,"i"),SymVar Int "n" [])],
  loopBoundStabilityFacts = [(SymVar Int "n" [],ReadOnly)],
  loopDecreasesCandidate = [SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])]
}]

halving :: [LoopSummary]
halving = [LoopSummary {
  loopSyntax = WhileSyntax,
  loopReadOnlyVars = [],
  loopFrameTargets = ["n","i"],
  loopInitFacts = [("i",SymInt 0),("n",SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))],
  loopGuard = Just (SBin (SymVar Int "i" []) Lt (SymVar Int "n" [])),
  loopEnteringCondition = Just (SBin (SymInt 0) Lt (SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))),
  loopSkipCondition = Just (SBin (SymInt 0) Ge (SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))),
  loopExitingConditions = [
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}}],
     SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))],
  loopExitViaBreakFacts = [],
  loopExitViaReturnFacts = [],
  loopCounters = ["i","n"],
  dynamicallyAccessedArrays = [],
  loopAssignments = ["n","i"],
  loopFrameTargetsDevelopmentTrajectory = [("n",Decreasing (SymInt 1)),("i",Increasing (SymInt 1))],
  loopExitFacts = [
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}}],
     LoopExitFactRange "n" (SBin (SymVar Int "i" []) Sub (SymInt 1))
                           (SymVar Int "i" [])),
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}}],
     LoopExitFactRange "i" (SymVar Int "n" [])
                           (SBin (SymVar Int "n" []) Add (SymInt 1)))],
  loopCountersBounds = [
    (SymInt 0,(Int,"i"),SymVar Int "n" []),
    (SymVar Int "i" [],(Int,"n"),SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))],
  loopBoundStabilityFacts = [
    (SymVar Int "n" [],Decreasing (SymInt 1)),
    (SymVar Int "i" [],Increasing (SymInt 1))],
  loopDecreasesCandidate = [SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])]
}]

contains :: [LoopSummary]
contains = [LoopSummary {
  loopSyntax = WhileSyntax,
  loopReadOnlyVars = ["a","x"],
  loopFrameTargets = ["i"],
  loopInitFacts = [("i",SymInt 0)],
  loopGuard = Just (SBin (SymVar Int "i" []) Lt (SObjAcc ["a","length"])),
  loopEnteringCondition = Just (SBin (SymInt 0) Lt (SObjAcc ["a","length"])),
  loopSkipCondition = Just (SBin (SymInt 0) Ge (SObjAcc ["a","length"])),
  loopExitingConditions = [
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}],
     SBin (SymVar Int "i" []) Ge (SObjAcc ["a","length"])),
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 2, branchEnd = 7}},
      Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}}],
     SBin (SArrayIndexAccess (Array Int) "a" (SymVar Int "i" [])) Eq (SymVar Int "x" []))],
  loopExitViaBreakFacts = [],
  loopExitViaReturnFacts = [
    ([(Just $ Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}},ElemInArray "a" (SymVar Int "i" []) (SymVar Int "x" []))],
     Just (SBool True))],
  loopCounters = ["i"],
  dynamicallyAccessedArrays = [(Array Int,"a",["i"])],
  loopAssignments = ["i"],
  loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 1))],
  loopExitFacts = [
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}],
     LoopExitFactValue "i" (SObjAcc ["a","length"])),
    ([Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 2, branchEnd = 7}},
      Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}}],
     LoopExitFactArrayAccessValue "a" (SymVar Int "i" []) (SymVar Int "x" []))],
  loopCountersBounds = [(SymInt 0,(Int,"i"),SObjAcc ["a","length"])],
  loopBoundStabilityFacts = [(SObjAcc ["a","length"],ReadOnly)],
  loopDecreasesCandidate = [SBin (SObjAcc ["a","length"]) Sub (SymVar Int "i" [])]
}]

