/*
LoopSummary:
  loopSyntax = WhileSyntax,
  loopReadOnlyVars = ["n"],
  loopFrameTargets = ["i"],
  loopInitFacts = [("i",SymInt 0)],
  loopGuard = Just $ SBin (SymVar Int "i" []) Lt (SymVar Int "n" []),
  loopEnteringCondition = Just $ SBin (SymInt 0) Lt (SymVar Int "n" []),
  loopSkipCondition = Just (SBin (SymInt 0) Ge (SymVar Int "n" [])),
  loopExitingConditions = [SBin (SymVar Int "i" []) Ge (SymVar Int "n" [])],
  loopExitViaBreakConditions = [],
  loopCounters = ["i"],
  loopAssignments = ["i"],
  loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 1))],
  loopCountersBounds = [(SymInt 0,"i",SymVar Int "n" [])],
  loopBoundStabilityFacts = [(SymVar Int "n" [],ReadOnly)],
  loopDecreasesCandidate = [SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])],
  loopExitFacts = [LoopExitFactValue "i" (SymVar Int "n" [])]
*/

/*
LoopPattern:
   [
    (CounterPattern (CountingUp "i"),
     [LoopCounters,LoopFrameTargetsDevelopmentTrajectory,LoopCountersBounds]
    ),
    (BoundPattern (StableBound (SymVar Int "n" [])),
     [LoopCounters,LoopCountersBounds,LoopGuard,LoopBoundStabilityFacts,LoopReadOnlyVars]
    )
   ]
*/

/*
LoopInvariantTemplate:
  Maintaining $ CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n")
  LoopAssigns $ LoopFrameTemplate ["i"]
  Decreases $ DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))
*/

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures 0 < n ==> \result == n;
  @   ensures 0 >= n ==> \result == 0;
  @*/
int idByLoop (int n) {
  int i = 0;
  //@ maintaining 0 <= i && i <= n;
  //@ loop_assigns i;
  //@ decreases n - i;
  while(i<n) {
    i++;
  }
  return i;
}

//////////////////////////////

/*
LoopSummary:
  loopSyntax = WhileSyntax,
  loopReadOnlyVars = ["n"],
  loopFrameTargets = ["i"],
  loopInitFacts = [("i",SymInt 0)],
  loopGuard = Just $ SBin (SymVar Int "i" []) Lt (SymVar Int "n" []),
  loopEnteringCondition = Just (SBin (SymInt 0) Lt (SymVar Int "n" [])),
  loopSkipCondition = Just (SBin (SymInt 0) Ge (SymVar Int "n" [])),
  loopExitingConditions = [SBin (SymVar Int "i" []) Ge (SymVar Int "n" [])],
  loopExitViaBreakConditions = [],
  loopCounters = ["i"],
  loopAssignments = ["i"],
  loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 3))],
  loopCountersBounds = [(SymInt 0,"i",SBin (SymVar Int "n" []) Add (SymInt 2))],
  loopBoundStabilityFacts = [(SymVar Int "n" [],ReadOnly),(SBin (SymVar Int "n" []) Add (SymInt 2),ReadOnly)],
  loopDecreasesCandidate = [SBin (SBin (SymVar Int "n" []) Add (SymInt 2)) Sub (SymVar Int "i" [])],
  loopExitFacts = [LoopExitFactRange "i" (SymVar Int "n" []) (SBin (SymVar Int "n" []) Add (SymInt 2))]
*/

/*
LoopPattern:
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
*/

/*
LoopInvariantTemplate:
  Maintaining $ CounterBoundsTemplate (JMLInt 0) "i" (JMLBin (JMLVar Int_Type "n") Add (JMLInt 2))
  StridedCounterTemplate "i" (JMLInt 3) (JMLInt 0)
  LoopAssigns $ LoopFrameTemplate ["i"]
  Decreases $ DecreasesTemplate $ JMLBin (JMLBin (JMLVar Int_Type "n") Add (JMLInt 2)) Sub (JMLVar Int_Type "i")
*/

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures 0 < n ==> n <= \result <= n + 2;
  @   ensures 0 >= n ==> \result == 0;
  @*/
int idByLoopStride3 (int n) {
  int i = 0;
  //@ maintaining 0 <= i && i <= n + 2;
  //@ maintaining i % 3 == 0;
  //@ loop_assigns i;
  //@ decreases (n + 2) - i;
  while(i<n) {
    i+=3;
  }
  return i;
}

//////////////////////////////

/* LoopSummary:
  loopSyntax = WhileSyntax,
  loopReadOnlyVars = ["n"],
  loopFrameTargets = ["i"],
  loopInitFacts = [("i",SymInt 0)],
  loopGuard = Just (SBool True),
  loopEnteringCondition = Just (SBool True),
  loopSkipCondition = Just (SBool False),
  loopExitingConditions = [SBin (SymVar Int "i" []) Ge (SymVar Int "n" [])],
  loopExitViaBreakConditions = [SBin (SymVar Int "i" []) Ge (SymVar Int "n" [])],
  loopCounters = ["i"],
  loopAssignments = ["i"],
  loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 1))],
  loopExitFacts = [LoopExitFactValue "i" (SymVar Int "n" [])],
  loopCountersBounds = [(SymInt 0,"i",SymVar Int "n" [])],
  loopBoundStabilityFacts = [(SymVar Int "n" [],ReadOnly)],
  loopDecreasesCandidate = [SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])]
*/

/* LoopPattern:
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
*/
/*
LoopInvariantTemplate:
  Maintaining $ CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n"),
  LoopAssigns $ LoopFrameTemplate ["i"],
  Decreases $ DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures 0 < n ==> \result == n;
  @   ensures 0 >= n ==> \result == 0;
  @*/
int idByLoop2 (int n) {
  int i = 0;
  //@ maintaining 0 <= i && i <= n;
  //@ loop_assigns i;
  //@ decreases n - i;
  while(true) {
    if(i>=n) {
      break;
    }
    i++;
  }
  return i;
}

//////////////////////////////

/* LoopSummary:
loopSyntax = WhileSyntax
loopReadOnlyVars = []
loopFrameTargets = ["n","i"]
loopInitFacts = [("i",SymInt 0),("n",SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))]
loopGuard = Just (SBin (SymVar Int "i" []) Lt (SymVar Int "n" []))
loopEnteringCondition = Just (SBin (SymInt 0) Lt (SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n")))
loopSkipCondition = Just (SBin (SymInt 0) Ge (SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n")))
loopExitingConditions = [SBin (SymVar Int "i" []) Ge (SymVar Int "n" [])]
loopExitViaBreakConditions = []
loopCounters = ["i","n"]
loopAssignments = ["n","i"]
loopFrameTargetsDevelopmentTrajectory = [("n",Decreasing (SymInt 1)),("i",Increasing (SymInt 1))]
loopExitFacts = [LoopExitFactRange "n" (SBin (SymVar Int "i" []) Sub (SymInt 1)) (SymVar Int "i" []),LoopExitFactRange "i" (SymVar Int "n" []) (SBin (SymVar Int "n" []) Add (SymInt 1))]
loopCountersBounds = [(SymInt 0,"i",SymVar Int "n" []),(SymVar Int "i" [],"n",SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))]
loopBoundStabilityFacts = [(SymVar Int "n" [],Decreasing (SymInt 1)),(SymVar Int "i" [],Increasing (SymInt 1))]
loopDecreasesCandidate = [SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])]
*/
/* LoopPattern:
[
 (CounterPattern (CountingUp "i"),
  [LoopCounters,LoopFrameTargetsDevelopmentTrajectory,LoopCountersBounds]
 ),
 (CounterPattern (CountingDown "n"),
  [LoopCounters,LoopFrameTargetsDevelopmentTrajectory,LoopCountersBounds]
 ),
 (BoundPattern (MovingBound "n"),
  [LoopFrameTargets,LoopBoundStabilityFacts]
 ),
 (BoundPattern (MovingBound "i"),
  [LoopFrameTargets,LoopBoundStabilityFacts]
 )
]
*/
/* LoopInvariantTemplate:
Maintaining (CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n")),
Maintaining (CounterBoundsTemplate (JMLVar Int_Type "i") "n" (JMLOld (JMLVar Int_Type "n"))),
LoopAssigns (LoopFrameTemplate ["n","i"]),
DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures 0 < \old(n) ==> n <= \result <= n + 1;
  @   ensures 0 >= \old(n) ==> \result == 0;
  @*/
int halving (int n) {
  int i = 0;
  //@ maintaining 0 <= i && i <= n;
  //@ maintaining i <= n && n <= \old(n);
  //@ loop_assigns n, i;
  //@ decreases n - i;
  while(i<n) {
    n--;
    i++;
  }
  return i;
}
