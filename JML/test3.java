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
  @   ensures \result == (0 < n ==> n);
  @   ensures \result == (0 >= n ==> 0);
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
  @   ensures \result == (0 < n ==> n <= i <= n + 2);
  @   ensures \result == (0 >= n ==> 0);
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
  @   ensures \result == (0 < n ==> n);
  @   ensures \result == (0 >= n ==> 0);
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

/* Useful symbolic definitions (To keep the complete LoopSummary readable):
 * halvingScope :: CFGT.ScopeRange
 * n0 = SymPreScope halvingScope (SymVar Int "n" [])
 * nCur = SymVar Int "n" []
 * iCur = SymVar Int "i" []
 * n0 = SymPreScope halvingScope nCur
 * The exact final value of i is:
    0                           if n0 <= 0
    ceil(n0 / 2)                if n0 > 0
 * For positive Java integers, without computing n0 + 1, we can represent that as:
    halfUp = SIte2 (SBin n0 Le (SymInt 0))
      (SymInt 0)
      (SBin (SBin n0 Div (SymInt 2))
            Add
            (SBin n0 Mod (SymInt 2)))
    finalN = SBin n0 Sub halfUp
*/
/*
LoopSummary:
  loopSyntax = WhileSyntax
  loopReadOnlyVars = []
  loopFrameTargets = ["n","i"]
  loopInitFacts = [("i",SymInt 0), ("n",n0)]
            ist:  [("i",SymInt 0),
                   ("n",SymPreScope (SR {branchStart = 2, branchEnd = 5}) (SymVar Int "n" []))]
  loopGuard = Just $ SBin iCur Lt nCur
        ist:  Just $ SBin (SymVar Int "i" []) Lt (SymVar Int "n" [])
  loopEnteringCondition = Just $ SBin (SymInt 0) Lt n0
                    ist:  Just $ SBin (SymInt 0) Lt (SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))
  loopSkipCondition = Just $ SBin (SymInt 0) Ge n0
                ist:  Just $ SBin (SymInt 0) Ge (SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))
  loopExitingConditions = [SBin iCur Ge nCur]
                    ist:  [SBin (SymVar Int "i" []) Ge (SymVar Int "n" [])]
  loopExitViaBreakConditions = []
  loopCounters = ["i","n"]
  loopAssignments = ["n","i"]
  loopFrameTargetsDevelopmentTrajectory = [
    ("n",Decreasing (SymInt 1)),
    ("i",Increasing (SymInt 1))]
                                    ist: dasselbe
  loopExitFacts = [
    LoopExitFactValue "i" halfUp,      -- i == ceil(n0 / 2)
    LoopExitFactValue "n" finalN]      -- n == floor(n0 / 2)
                                       -- And therefore also: i + n == n0
            ist:  [
    LoopExitFactRange "n" (SBin (SymVar Int "i" []) Sub (SymInt 1))
                          (SymVar Int "i" []),
    LoopExitFactRange "i" (SymVar Int "n" [])
                          (SBin (SymVar Int "n" []) Add (SymInt 1))]
  loopCountersBounds = [
    (SymInt 0,"i",halfUp),
    (finalN,"n",n0)]
                 ist:  [
    (SymInt 0,"i",SymVar Int "n" []),
    (SymVar Int "i" [],"n",SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))]
  loopBoundStabilityFacts = [
    (nCur, Decreasing (SymInt 1)), -- this should be enough honestly
    (n0, ReadOnly),
    (halfUp, ReadOnly),
    (finalN, ReadOnly)]
                      ist: [
    (SymVar Int "n" [],Decreasing (SymInt 1)),
    (SymVar Int "i" [],Increasing (SymInt 1))]
  loopDecreasesCandidate = [SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])]
                     ist: [SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])]
*/
/*
LoopPattern:
[
  (CounterPattern (CountingUp "i"),
   [LoopCounters
   ,LoopCountersBounds
   ,LoopFrameTargetsDevelopmentTrajectory
   ,LoopExitFact
   ]
  ),
  (CounterPattern (CountingDown "n"),
   [LoopCounters
   ,LoopCountersBounds
   ,LoopFrameTargetsDevelopmentTrajectory
   ,LoopExitFact
   ]
  ),
  (BoundPattern MovingBound
  ,[LoopInitFacts
   ,LoopGuard
   ,LoopCounters
   ,LoopCountersBounds
   ,LoopFrameTargets
   ,LoopFrameTargetsDevelopmentTrajectory
   ,LoopBoundStabilityFacts
   ,LoopDecreasesCandidate
   ,LoopEnteringCondition
   ,LoopSkipCondition
   ,LoopExitingConditions
   ,LoopExitFact
   ]
  )
]
*/
/*
data LoopInvariantTemplate
  = -- A one-sided counter bound when inventing a second bound
    -- would be artificial or unnecessarily strong.
    CounterLowerBoundTemplate
      Expr
      String

    -- Exact inductive relationship involving a moving bound.
    -- MovingBoundRelationTemplate x rhs
    -- emits:
    --   maintaining x == rhs;
  | MovingBoundRelationTemplate
      String
      Expr

  -- Conditional invariant.
  -- GuardedInvariantTemplate condition fact
  -- emits:
  --   maintaining condition ==> fact;
  | GuardedInvariantTemplate
      Expr
      Expr

MovingBoundRelationTemplate  ==>  //@ maintaining n == \old(n) - i;
CounterLowerBoundTemplate    ==>  //@ maintaining 0 <= i;
GuardedInvariantTemplate     ==>  //@ maintaining \old(n) <= 0 ==> i == 0;
                                  //@ maintaining \old(n) > 0 ==> i <= n + 1;

LoopAssigns $ LoopFrameTemplate ["n","i"]
Decreases $ DecreasesTemplate
  (JMLBin
    (JMLVar Int_Type "n")
    Sub
    (JMLVar Int_Type "i"))
Maintaining $ MovingBoundRelationTemplate (for n == \old(n) - i)
*/
/*
LoopInvariantTemplate:
[
  Maintaining $ CounterLowerBoundTemplate
    (JMLInt 0)
    "i",

  Maintaining $ MovingBoundRelationTemplate
    "n"
    (JMLBin
      (JMLPreScope
        halvingScope
        (JMLVar Int_Type "n"))
      Sub
      (JMLVar Int_Type "i")),

  GuardedInvariantTemplate
    (JMLBin
      (JMLPreScope
        halvingScope
        (JMLVar Int_Type "n"))
      Le
      (JMLInt 0))
    (JMLBin
      (JMLVar Int_Type "i")
      Eq
      (JMLInt 0)),

  GuardedInvariantTemplate
    (JMLBin
      (JMLPreScope
        halvingScope
        (JMLVar Int_Type "n"))
      Gt
      (JMLInt 0))
    (JMLBin
      (JMLVar Int_Type "i")
      Le
      (JMLBin
        (JMLVar Int_Type "n")
        Add
        (JMLInt 1))),

  LoopAssigns $ LoopFrameTemplate
    ["n","i"],

  Decreases $ DecreasesTemplate
    (JMLBin
      (JMLVar Int_Type "n")
      Sub
      (JMLVar Int_Type "i"))
]
*/
//TODO
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \old(n) <= 0 ==> \result == 0;
  @   ensures \old(n) > 0 ==>
  @       \result == \old(n) / 2 + \old(n) % 2;
  @*/
public static int halving(int n) {
    int i = 0;

    //@ maintaining 0 <= i;
    //@ maintaining n == \old(n) - i;
    //@ maintaining \old(n) <= 0 ==> i == 0;
    //@ maintaining \old(n) > 0 ==> i <= n + 1;
    //@ loop_assigns n, i;
    //@ decreases n - i;
    while (i < n) {
        n--;
        i++;
    }

    return i;
}

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
/*
*/
public static int halving(int n) {
  int i = 0;
  while (i < n) {
    n--;
    i++;
  }
  return i;
}
