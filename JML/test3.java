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

//////////////////////////////

/*
Your current LoopSummary is sufficient for the counter structure, but it does not directly represent two facts that matter particularly for contains:

1. a loop exit caused by return, together with its returned value;
2. the semantic search-exclusion fact from which the quantified invariant is generated.

The older report contains these concepts informally as earlyExits and semanticPrefixFact.

data StateChangingCondition
  = ExcludeElemInArray
      SymExpr   -- counter
      String   -- array
      SymExpr  -- searched value
  deriving (Show, Eq)

Then extend `LoopSummary` with:

data LoopSummary = LoopSummary {
    loopSyntax :: LoopSyntax
  , loopReadOnlyVars :: [String]
  , loopFrameTargets :: [String]
  , loopInitFacts :: [(String,SymExpr)]
  , loopGuard :: Maybe SymExpr
  , loopEnteringCondition :: Maybe SymExpr
  , loopSkipCondition :: Maybe SymExpr
  , loopExitingConditions :: [SymExpr]
  , loopExitViaBreakConditions :: [SymExpr]

  , loopCounters :: [String]
  , loopAssignments :: [String]
  , loopFrameTargetsDevelopmentTrajectory
      :: [(String,SymExprDevelopmentTrajectory)]
  , loopExitFacts :: [LoopExitFact]
  , loopCountersBounds :: [(SymExpr,String,SymExpr)]
  , loopBoundStabilityFacts
      :: [(SymExpr,SymExprDevelopmentTrajectory)]

  -- NEW:
  , loopExitViaReturnFacts :: [(StateChangingCondition,SymExpr)]

  , loopDecreasesCandidate :: [SymExpr]
} deriving (Show,Eq)

/*
Complete LoopSummary for contains:
For readability, define:
iE =
  SymVar Int "i" []

xE =
  SymVar Int "x" []

aLenE =
  SObjAcc ["a","length"]

aAtIE =
  SArrayIndexAccess Int "a" iE

foundE =
  SBin aAtIE Eq xE
*/

/*
LoopSummary {
    loopSyntax =
      WhileSyntax

  , loopReadOnlyVars =
      ["a","x"]

  , loopFrameTargets =
      ["i"]

  , loopInitFacts =
      [("i", SymInt 0)]

  , loopGuard =
      Just $
        SBin iE Lt aLenE

  , loopEnteringCondition =
      Just $
        SBin (SymInt 0) Lt aLenE

  , loopSkipCondition =
      Just $
        SBin (SymInt 0) Ge aLenE

  , loopExitingConditions =
      [SBin iE Ge aLenE]

  , loopExitViaBreakConditions =
      []

  , loopExitViaReturnFacts =
      [(ExcludeElemInArray "a" "i" xE,SBool True)]

  , loopCounters =
      ["i"]

  , loopAssignments =
      ["i"]

  , loopFrameTargetsDevelopmentTrajectory =
      [("i", Increasing (SymInt 1))]

  , loopExitFacts =
      [LoopExitFactValue "i" aLenE]

  , loopCountersBounds =
      [(SymInt 0, "i", aLenE)]

  , loopBoundStabilityFacts =
      [(aLenE, ReadOnly)]

  , loopDecreasesCandidate =
      [SBin aLenE Sub iE]
}
*/

/*
EarlyReturn is important for control-flow analysis and postcondition validation:
[
  ( CounterPattern (CountingUp "i")
  , [ LoopCounters
    , LoopFrameTargetsDevelopmentTrajectory
    , LoopCountersBounds
    ]
  ),

  ( BoundPattern (StableBound aLenE)
  , [ LoopGuard
    , LoopCountersBounds
    , LoopBoundStabilityFacts
    , LoopReadOnlyVars
    ]
  ),

  ( TraversalPattern ArrayScan  -- ArrayScan because
                                --   1) because the counters "i" increases or decreases monotonically
                                --   2) and because The guard or another proven invariant keeps the index within a logical array range, typically: i < a.length
                                --   3) and because there is a StateChangingFact which is related to an array that leads to a return or break (StateChangingFact records array accesses).
  , [ LoopGuard
    , LoopCounters
    , LoopCountersBounds
    , LoopReadOnlyVars
    ]
  ),

  ( SearchPattern LinearSearch  -- LinearSearch because (CounterPattern (CountingUp "i"))
                                -- and because a.length does not change
                                --             (BoundPattern (StableBound aLenE))
                                -- and because the value of `loopExitViaReturnFacts`
  , [ LoopCounters
    , LoopGuard
    , loopExitViaReturnFacts
    ]
  ),

  ( ControlFlowPattern EarlyReturn -- because the value of `loopExitViaReturnFacts`
  , [ LoopExitViaReturnFacts
    ]
  )
]
*/

/*
`LoopInvariantTemplate` needs one new maintaining template:
```
data Maintaining_LoopInvariantTemplate =
  -- NEW:
  ArrayFilterTemplate
    String   -- counter
    String   -- array
    Expr     -- searched value

  deriving (Show, Eq)
```

ArrayFilterTemplate counter array target  ===>
```
//@ maintaining
//@   (\forall int k;
//       0 <= k && k < counter;
//       array[k] != target);
```
let:
aLen =
  -- your JML Expr representation of a.length

Then the complete generated template set is:
[
  Maintaining $
    CounterBoundsTemplate
      (JMLInt 0)
      "i"
      aLen

, Maintaining $
    ArrayFilterTemplate
      "i"
      "a"
      (JMLVar Int_Type "x")

, LoopAssigns $
    LoopFrameTemplate
      ["i"]

, DecreasesTemplate $
    JMLBin
      aLen
      Sub
      (JMLVar Int_Type "i")
]
*/

/*
1)
CounterPattern (CountingUp "i")
  ==> Maintaining $ CounterBoundsTemplate (JMLInt 0) "i" (SObjAcc ["a","length"])
    ==> maintaining 0 <= i && i <= (SObjAcc ["a","length"])

2)
SearchPattern LinearSearch, ControlFlowPattern EarlyReturn
  ==> Maintaining $ ArrayFilterTemplate "i" "a" (JMLVar Int_Type "x")
    ==> maintaining (\forall int k; 0 <= k && k < i; a[k] != x)

3)
LoopAssigns $ LoopFrameTemplate ["i"]
  ==> loop_assigns i

4)
DecreasesTemplate $ JMLBin (SObjAcc ["a","length"]) Sub (JMLVar Int_Type "i")
  ==> decreases a.length - i
*/

/*@ normal_behavior
  @   requires a != null;
  @   assignable \nothing;
  @   ensures \result <==>
  @       (\exists int k; 0 <= k && k < a.length; a[k] == x);
  @*/
public static boolean contains(int[] a, int x) {
  int i = 0;
  //@ maintaining 0 <= i && i <= a.length;
  //@ maintaining (\forall int k; 0 <= k && k < i; a[k] != x);
  //@ loop_assigns i;
  //@ decreases a.length - i;
  while (i < a.length) {
    if (a[i] == x) {
      return true;
    }
    i++;
  }
  return false;
}

//////////////////////////////

/*
fromList [
  (MethodHandle,SMethodHandle Bool "contains"),
  (GlobalVars,SGlobalVars []),
  (FormalParms,SFormalParms ["a","x"]),
  (VarBindings,SVarBindings (fromList [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
  (VarAssignments,SVarAssignments [("i",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),("i",(SymInt 1,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
  (VarName "a",SymVar (Array Int) "a" []),
  (VarName "i",SymUnknown ("i",SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 7})],6)]),
  (VarName "x",SymVar Int "x" []),
  (ScopeRange (SR {branchStart = 2, branchEnd = 7}),
   SLoop Nothing
         (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["a"], varName = "length"}}))
         [Node {id = 3, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "a"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = ==, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "x"}})), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}]
         (Just (LoopSummary {
             loopSyntax = WhileSyntax,
             loopReadOnlyVars = ["a","x"],
             loopFrameTargets = ["i"],
             loopInitFacts = [("i",SymInt 0)],
             loopGuard = Just (SBin (SymVar Int "i" []) Lt (SObjAcc ["a","length"])),
             loopEnteringCondition = Just (SBin (SymInt 0) Lt (SObjAcc ["a","length"])),
             loopSkipCondition = Just (SBin (SymInt 0) Ge (SObjAcc ["a","length"])),
             loopExitingConditions = [
               SBin (SymVar Int "i" [])
                    Ge
                    (SObjAcc ["a","length"]),
               SBin (SArrayIndexAccess (Array Int) "a" (SymVar Int "i" []))
                    Eq
                    (SymVar Int "x" [])],
             loopExitViaBreakConditions = [],
             loopExitViaReturnFacts = [([ElemInArray "a" (SymVar Int "i" []) (SymVar Int "x" [])],Just (SBool True))],
             loopCounters = ["i"],
             loopAssignments = ["i"],
             loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 1))],
             loopExitFacts = [
               LoopExitFactValue "i" (SObjAcc ["a","length"]),
               LoopExitFactArrayAccessValue "a" (SymVar Int "i" []) (SymVar Int "x" [])],
             loopCountersBounds = [(SymInt 0,"i",SObjAcc ["a","length"])],
             loopBoundStabilityFacts = [(SObjAcc ["a","length"],ReadOnly)],
             loopDecreasesCandidate = [SBin (SObjAcc ["a","length"]) Sub (SymVar Int "i" [])]})) 
         [(CounterPattern (CountingUp "i"),
           [LoopCounters
           ,LoopFrameTargetsDevelopmentTrajectory
           ,LoopCountersBounds
           ]
          ),
          (BoundPattern (StableBound (SObjAcc ["a","length"])),
           [LoopCounters
           ,LoopCountersBounds
           ,LoopGuard
           ,LoopBoundStabilityFacts
           ,LoopReadOnlyVars
           ]
          )
         ]),
  (Return,SBool False)]
 */
public static boolean contains(int[] a, int x) {
  int i = 0;
  while (i < a.length) {
    if (a[i] == x) {
      return true;
    }
    i++;
  }
  return false;
}

//////////////////////////////
