/*
method: idByLoop

CFG:
  nodes:
    Entry (BuiltInType Int) "idByLoop" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]
    Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}
    Node {id = 2, nodeData = BooleanExpression While (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}})), parent = 0}
    Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}
    Node {id = 4, nodeData = Meet While, parent = 0}
    End {id = 5, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}
  edges:
    (0,[1])
    (1,[2])
    (2,[3,4])
    (3,[2])
    (4,[5])


LoopSummary:
  loopSyntax: WhileSyntax
  loopReadOnlyVars: ["n"]
  loopFrameTargets: ["i"]
  loopInitFacts:
    ("i",SymInt 0)
  loopGuard: Just (SBin (SymVar Int "i" []) Lt (SymVar Int "n" []))
  loopEnteringCondition: Just (SBin (SymInt 0) Lt (SymVar Int "n" []))
  loopSkipCondition: Just (SBin (SymInt 0) Ge (SymVar Int "n" []))
  loopExitingConditions:
    (Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}},
     SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))
  loopExitViaBreakFacts:
    NONE
  loopExitViaReturnFacts:
    NONE
  loopCounters: ["i"]
  dynamicallyAccessedArrays:
    NONE
  loopAssignments: ["i"]
  loopFrameTargetsDevelopmentTrajectory:
    ("i",Increasing (SymInt 1))
  loopExitFacts:
    (Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}},
     LoopExitFactValue "i" (SymVar Int "n" []))
  loopCountersBounds:
    (SymInt 0,(Int,"i"),SymVar Int "n" [])
  loopBoundStabilityFacts:
    (SymVar Int "n" [],ReadOnly)
  loopDecreasesCandidate:
    SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])


LoopPatterns:
  (CounterPattern (CountingUp "i"),
   [LoopCounters
   ,LoopFrameTargetsDevelopmentTrajectory
   ,LoopCountersBounds])
  (BoundPattern (StableBound (SymVar Int "n" [])),
   [LoopCounters
   ,LoopCountersBounds
   ,LoopGuard
   ,LoopBoundStabilityFacts
   ,LoopReadOnlyVars])


LoopInvariants:
  loopScopeRange: SR {branchStart = 2, branchEnd = 4}
  loopClauses:
    Maintaining (CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n"))
    LoopAssigns (LoopFrameTemplate ["i"])
    DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))
*/


/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures (0 < n ==> \result == n);
  @   ensures (0 >= n ==> \result == 0);
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


//////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////////////////////////////


/*
method: idByLoopStride3

CFG:
  nodes:
    Entry (BuiltInType Int) "idByLoopStride3" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]
    Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}
    Node {id = 2, nodeData = BooleanExpression While (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}})), parent = 0}
    Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 3.0}}}), parent = 2}
    Node {id = 4, nodeData = Meet While, parent = 0}
    End {id = 5, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}
  edges:
    (0,[1])
    (1,[2])
    (2,[3,4])
    (3,[2])
    (4,[5])


LoopSummary:
  loopSyntax: WhileSyntax
  loopReadOnlyVars: ["n"]
  loopFrameTargets: ["i"]
  loopInitFacts:
    ("i",SymInt 0)
  loopGuard: Just (SBin (SymVar Int "i" []) Lt (SymVar Int "n" []))
  loopEnteringCondition: Just (SBin (SymInt 0) Lt (SymVar Int "n" []))
  loopSkipCondition: Just (SBin (SymInt 0) Ge (SymVar Int "n" []))
  loopExitingConditions:
    (Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}},
     SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))
  loopExitViaBreakFacts:
    NONE
  loopExitViaReturnFacts:
    NONE
  loopCounters: ["i"]
  dynamicallyAccessedArrays:
    NONE
  loopAssignments: ["i"]
  loopFrameTargetsDevelopmentTrajectory:
    ("i",Increasing (SymInt 3))
  loopExitFacts:
    (Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}},
     LoopExitFactRange "i" (SymVar Int "n" []) (SBin (SymVar Int "n" []) Add (SymInt 2)))
  loopCountersBounds:
    (SymInt 0,(Int,"i"),SBin (SymVar Int "n" []) Add (SymInt 2))
  loopBoundStabilityFacts:
    (SymVar Int "n" [],ReadOnly)
    (SBin (SymVar Int "n" []) Add (SymInt 2),ReadOnly)
  loopDecreasesCandidate:
    SBin (SBin (SymVar Int "n" []) Add (SymInt 2)) Sub (SymVar Int "i" [])


LoopPatterns:
  (CounterPattern (CountingUp "i"),
   [LoopCounters
   ,LoopFrameTargetsDevelopmentTrajectory
   ,LoopCountersBounds])
  (CounterPattern (StridedCounting "i"),
   [LoopCounters
   ,LoopFrameTargetsDevelopmentTrajectory])
  (BoundPattern (StableBound (SBin (SymVar Int "n" []) Add (SymInt 2))),
   [LoopCounters
   ,LoopCountersBounds
   ,LoopGuard
   ,LoopBoundStabilityFacts
   ,LoopReadOnlyVars])


LoopInvariants:
  loopScopeRange: SR {branchStart = 2, branchEnd = 4}
  loopClauses:
    Maintaining (CounterBoundsTemplate (JMLInt 0) "i" (JMLBin (JMLVar Int_Type "n") Add (JMLInt 2)))
    Maintaining (StridedCounterTemplate "i" (JMLInt 3) (JMLInt 0))
    LoopAssigns (LoopFrameTemplate ["i"])
    DecreasesTemplate (JMLBin (JMLBin (JMLVar Int_Type "n") Add (JMLInt 2)) Sub (JMLVar Int_Type "i"))
*/


/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures (0 < n ==> n <= \result <= n + 2);
  @   ensures (0 >= n ==> \result == 0);
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


//////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////////////////////////////


/*
method: idByLoop2

CFG:
  nodes:
    Entry (BuiltInType Int) "idByLoop2" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]
    Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}
    Node {id = 2, nodeData = BooleanExpression While (Just (BoolLiteral True)), parent = 0}
    Node {id = 3, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}})), parent = 2}
    Node {id = 4, nodeData = Statement BreakStmt, parent = 3}
    Node {id = 5, nodeData = Meet If, parent = 2}
    Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}
    Node {id = 7, nodeData = Meet While, parent = 0}
    End {id = 8, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}
  edges:
    (0,[1])
    (1,[2])
    (2,[3,7])
    (3,[4,5])
    (4,[5])
    (5,[6])
    (6,[2])
    (7,[8])


LoopSummary:
  loopSyntax: WhileSyntax
  loopReadOnlyVars: ["n"]
  loopFrameTargets: ["i"]
  loopInitFacts:
    ("i",SymInt 0)
  loopGuard: Just (SBool True)
  loopEnteringCondition: Just (SBool True)
  loopSkipCondition: Just (SBool False)
  loopExitingConditions:
    (Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 3, branchEnd = 5}},
     SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))
  loopExitViaBreakFacts:
    [(Just (Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}}),Condition (SBin (SymVar Int "i" []) Ge (SymVar Int "n" [])))]
  loopExitViaReturnFacts:
    NONE
  loopCounters: ["i"]
  dynamicallyAccessedArrays:
    NONE
  loopAssignments: ["i"]
  loopFrameTargetsDevelopmentTrajectory:
    ("i",Increasing (SymInt 1))
  loopExitFacts:
    (Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 3, branchEnd = 5}},
     LoopExitFactValue "i" (SymVar Int "n" []))
  loopCountersBounds:
    (SymInt 0,(Int,"i"),SymVar Int "n" [])
  loopBoundStabilityFacts:
    (SymVar Int "n" [],ReadOnly)
  loopDecreasesCandidate:
    SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])


LoopPatterns:
  (CounterPattern (CountingUp "i"),
   [LoopCounters
   ,LoopFrameTargetsDevelopmentTrajectory
   ,LoopCountersBounds])
  (BoundPattern (StableBound (SymVar Int "n" [])),
   [LoopCounters
   ,LoopCountersBounds
   ,LoopGuard
   ,LoopBoundStabilityFacts
   ,LoopReadOnlyVars])
  (BoundPattern (GuardlessWithInternalExit (SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))),
   [LoopGuard
   ,LoopExitingConditions])
  (ControlFlowPattern (BreakExit (SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))),
   [LoopExitViaBreakFacts])


LoopInvariants:
  loopScopeRange: SR {branchStart = 2, branchEnd = 7}
  loopClauses:
    Maintaining (CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n"))
    LoopAssigns (LoopFrameTemplate ["i"])
    DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))
*/


/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures (0 < n ==> \result == n);
  @   ensures (0 >= n ==> \result == 0);
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


//////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////////////////////////////


/*
method: halving

CFG:
  nodes:
    Entry (BuiltInType Int) "halving" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]
    Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}
    Node {id = 2, nodeData = BooleanExpression While (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}})), parent = 0}
    Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = -, expr2 = NumberLiteral 1.0}}}), parent = 2}
    Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}
    Node {id = 5, nodeData = Meet While, parent = 0}
    End {id = 6, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}
  edges:
    (0,[1])
    (1,[2])
    (2,[3,5])
    (3,[4])
    (4,[2])
    (5,[6])


LoopSummary:
  loopSyntax: WhileSyntax
  loopReadOnlyVars: []
  loopFrameTargets: ["n","i"]
  loopInitFacts:
    ("i",SymInt 0)
    ("n",SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))
  loopGuard: Just (SBin (SymVar Int "i" []) Lt (SymVar Int "n" []))
  loopEnteringCondition: Just (SBin (SymInt 0) Lt (SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n")))
  loopSkipCondition: Just (SBin (SymInt 0) Ge (SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n")))
  loopExitingConditions:
    (Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}},
     SBin (SymVar Int "i" []) Ge (SymVar Int "n" []))
  loopExitViaBreakFacts:
    NONE
  loopExitViaReturnFacts:
    NONE
  loopCounters: ["i","n"]
  dynamicallyAccessedArrays:
    NONE
  loopAssignments: ["n","i"]
  loopFrameTargetsDevelopmentTrajectory:
    ("n",Decreasing (SymInt 1))
    ("i",Increasing (SymInt 1))
  loopExitFacts:
    (Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}},
     LoopExitFactRange "n" (SBin (SymVar Int "i" []) Sub (SymInt 1)) (SymVar Int "i" []))
    (Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}},
     LoopExitFactRange "i" (SymVar Int "n" []) (SBin (SymVar Int "n" []) Add (SymInt 1)))
  loopCountersBounds:
    (SymInt 0,(Int,"i"),SymVar Int "n" [])
    (SymVar Int "i" [],(Int,"n"),SymPreScope (SR {branchStart = 2, branchEnd = 5}) (Int,"n"))
  loopBoundStabilityFacts:
    (SymVar Int "n" [],Decreasing (SymInt 1))
    (SymVar Int "i" [],Increasing (SymInt 1))
  loopDecreasesCandidate:
    SBin (SymVar Int "n" []) Sub (SymVar Int "i" [])


LoopPatterns:
  (CounterPattern (CountingUp "i"),
   [LoopCounters
   ,LoopFrameTargetsDevelopmentTrajectory
   ,LoopCountersBounds])
  (CounterPattern (CountingDown "n"),
   [LoopCounters
   ,LoopFrameTargetsDevelopmentTrajectory
   ,LoopCountersBounds])
  (BoundPattern (MovingBound "n"),
   [LoopFrameTargets
   ,LoopBoundStabilityFacts])
  (BoundPattern (MovingBound "i"),
   [LoopFrameTargets
   ,LoopBoundStabilityFacts])


LoopInvariants:
  loopScopeRange: SR {branchStart = 2, branchEnd = 5}
  loopClauses:
    Maintaining (CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n"))
    Maintaining (CounterBoundsTemplate (JMLVar Int_Type "i") "n" (JMLOld (JMLVar Int_Type "n")))
    LoopAssigns (LoopFrameTemplate ["n","i"])
    DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))
*/


/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures (0 < \old(n) ==> n <= \result <= n + 1);
  @   ensures (0 >= \old(n) ==> \result == 0);
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


//////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////////////////////////////


/*
method: contains

CFG:
  nodes:
    Entry (BuiltInType Boolean) "contains" [VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "a"},VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}]
    Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}
    Node {id = 2, nodeData = BooleanExpression While (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["a"], varName = "length"}})), parent = 0}
    Node {id = 3, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "a"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = ==, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "x"}})), parent = 2}
    End {id = 4, parent = 3, mExpr = Just (BoolLiteral True)}
    Node {id = 5, nodeData = Meet If, parent = 2}
    Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}
    Node {id = 7, nodeData = Meet While, parent = 0}
    End {id = 8, parent = 0, mExpr = Just (BoolLiteral False)}
  edges:
    (0,[1])
    (1,[2])
    (2,[3,7])
    (3,[4,5])
    (4,[5])
    (5,[6])
    (6,[2])
    (7,[8])


LoopSummary:
  loopSyntax: WhileSyntax
  loopReadOnlyVars: ["a","x"]
  loopFrameTargets: ["i"]
  loopInitFacts:
    ("i",SymInt 0)
  loopGuard: Just (SBin (SymVar Int "i" []) Lt (SObjAcc ["a","length"]))
  loopEnteringCondition: Just (SBin (SymInt 0) Lt (SObjAcc ["a","length"]))
  loopSkipCondition: Just (SBin (SymInt 0) Ge (SObjAcc ["a","length"]))
  loopExitingConditions:
    (Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}},
     SBin (SymVar Int "i" []) Ge (SObjAcc ["a","length"]))
    (Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 3, branchEnd = 5}},
     SBin (SArrayIndexAccess (Array Int) "a" (SymVar Int "i" [])) Eq (SymVar Int "x" []))
  loopExitViaBreakFacts:
    NONE
  loopExitViaReturnFacts:
    ([(Just (Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}}),ElemInArray "a" (SymVar Int "i" []) (SymVar Int "x" []))],(Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 3, branchEnd = 5}},Just (SBool True)))
  loopCounters: ["i"]
  dynamicallyAccessedArrays:
    (Array Int,"a",[(Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}},"i")])
  loopAssignments: ["i"]
  loopFrameTargetsDevelopmentTrajectory:
    ("i",Increasing (SymInt 1))
  loopExitFacts:
    (Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}},
     LoopExitFactValue "i" (SObjAcc ["a","length"]))
    (Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 3, branchEnd = 5}},
     LoopExitFactArrayAccessValue "a" (SymVar Int "i" []) (SymVar Int "x" []))
  loopCountersBounds:
    (SymInt 0,(Int,"i"),SObjAcc ["a","length"])
  loopBoundStabilityFacts:
    (SObjAcc ["a","length"],ReadOnly)
  loopDecreasesCandidate:
    SBin (SObjAcc ["a","length"]) Sub (SymVar Int "i" [])


LoopPatterns:
  (CounterPattern (CountingUp "i"),
   [LoopCounters
   ,LoopFrameTargetsDevelopmentTrajectory
   ,LoopCountersBounds])
  (BoundPattern (StableBound (SObjAcc ["a","length"])),
   [LoopCounters
   ,LoopCountersBounds
   ,LoopGuard
   ,LoopBoundStabilityFacts
   ,LoopReadOnlyVars])
  (TraversalPattern (ArrayScan ("a",["i"])),
   [DynamicallyAccessedArrays
   ,LoopFrameTargetsDevelopmentTrajectory])
  (SearchPattern (LinearSearch ([(Just (Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}}),ElemInArray "a" (SymVar Int "i" []) (SymVar Int "x" []))],(Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 3, branchEnd = 5}},Just (SBool True)))),
   [DynamicallyAccessedArrays
   ,LoopExitViaBreakFacts
   ,LoopExitViaReturnFacts])
  (ControlFlowPattern (EarlyReturn ([(Just (Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}}),ElemInArray "a" (SymVar Int "i" []) (SymVar Int "x" []))],(Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 3, branchEnd = 5}},Just (SBool True)))),
   [LoopExitViaReturnFacts])


LoopInvariants:
  loopScopeRange: SR {branchStart = 2, branchEnd = 7}
  loopClauses:
    Maintaining (CounterBoundsTemplate (JMLInt 0) "i" (JMLObjAcc ["a","length"]))
    Maintaining (SearchExclusionTemplate (Universal,[("k1",(JMLInt 0,(Int_Type,"i",JMLInt 0,(JMLInt 1,True)),JMLObjAcc ["a","length"]))],(Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}},JMLBin (JMLArrayIndexAccess (Array_Type Int_Type) "a" (JMLVar Int_Type "k1")) Neq (JMLVar Int_Type "x"))) (Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 3, branchEnd = 5}},Just (JMLBool True)))
    LoopAssigns (LoopFrameTemplate ["i"])
    DecreasesTemplate (JMLBin (JMLObjAcc ["a","length"]) Sub (JMLVar Int_Type "i"))
*/


/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures ((\\forall int k1;
        0 <= k1 && k1 < i && k1 < a.length;
          a[k1] != x) ==> \result == false);
  @   ensures ((\\exists int k1;
        0 <= k1 && k1 < i && k1 < a.length;
          a[k1] == x) ==> \result == true);
  @*/
boolean contains (int[] a, int x) {
  int i = 0;
  //@ maintaining 0 <= i && i <= a.length;
  //@ maintaining (\\forall int k1;
  //    0 <= k1 && k1 < i && k1 < a.length;
  //      a[k1] != x);
  //@ loop_assigns i;
  //@ decreases a.length - i;
  while(i<a.length) {
    if(a[i]==x) {
      return true;
    }
    i++;
  }
  return false;
}


//////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////////////////////////////


