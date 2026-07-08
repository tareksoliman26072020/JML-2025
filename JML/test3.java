/*
[
 (MethodHandle,SMethodHandle Int "idByLoop"),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["n"]),
 (VarBindings,SVarBindings (fromList [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("i",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("i",(SymInt 1,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}}))]),
 (VarName "i",SymUnknown ("i",SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 4})],3)]),
 (VarName "n",SymVar Int "n"),
 (ScopeRange (SR {branchStart = 2, branchEnd = 4}),
  SLoop Nothing
        (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}))
        [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}]
        (Just (LoopSummary {loopSyntax = WhileSyntax, loopReadOnlyVars = ["n"], loopFrameTargets = ["i"], loopInitFacts = [("i",SymInt 0)], loopGuards = [SBin (SymVar Int "i") Lt (SymVar Int "n")], loopInitialGuardCondition = Just (SBin (SymInt 0) Lt (SymVar Int "n")), loopSkipCondition = Just (SBin (SymInt 0) Ge (SymVar Int "n")), loopExitConditions = [SBin (SymVar Int "i") Ge (SymVar Int "n")], loopCounters = ["i"], loopAssignments = ["i"], loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 1))], loopCountersBounds = [(SymInt 0,"i",SymVar Int "n")], loopBoundStabilityFacts = [(SymVar Int "n",ReadOnly)], loopDecreasesCandidate = [SBin (SymVar Int "n") Sub (SymVar Int "i")], loopExitFacts = [LoopExitFactValue (SBin (SymVar Int "i") Eq (SymVar Int "n"))]}))
        [(CounterPattern CountingUp,[LoopCounters,LoopFrameTargetsDevelopmentTrajectory,LoopInitFacts,LoopGuards,LoopCountersBounds,LoopAssignments,LoopFrameTargets,LoopDecreasesCandidate]),(BoundPattern StableBound,[LoopCounters,LoopCountersBounds,LoopGuards,LoopBoundStabilityFacts,LoopReadOnlyVars])]),
 (Return,SymUnknown ("i",SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 4})],3)])
]
*/
/*
loopSyntax = WhileSyntax
loopReadOnlyVars = ["n"]
loopFrameTargets = ["i"]
loopInitFacts = [("i",SymInt 0)]
loopGuards = [SBin (SymVar Int "i") Lt (SymVar Int "n")]
loopInitialGuardCondition = Just (SBin (SymInt 0) Lt (SymVar Int "n"))
loopSkipCondition = Just (SBin (SymInt 0) Ge (SymVar Int "n"))
loopExitConditions = [SBin (SymVar Int "i") Ge (SymVar Int "n")]
loopCounters = ["i"]
loopAssignments = ["i"]
loopFrameTargetsDevelopmentTrajectory = [("i",Increasing (SymInt 1))]
loopCountersBounds = [(SymInt 0,"i",SymVar Int "n")]
loopBoundStabilityFacts = [(SymVar Int "n",ReadOnly)]
loopDecreasesCandidate = [SBin (SymVar Int "n") Sub (SymVar Int "i")]
loopExitFacts = [LoopExitFactValue (SBin (SymVar Int "i") Eq (SymVar Int "n"))]
*/
/*
[
 (CounterPattern CountingUp,
  [LoopCounters
  ,LoopFrameTargetsDevelopmentTrajectory
  ,LoopInitFacts
  ,LoopGuards
  ,LoopCountersBounds
  ,LoopAssignments
  ,LoopFrameTargets
  ,LoopDecreasesCandidate
  ]
 ),
 (BoundPattern StableBound,
  [LoopCounters
  ,LoopCountersBounds
  ,LoopGuards
  ,LoopBoundStabilityFacts
  ,LoopReadOnlyVars
  ]
 )
]
*/
//////////////////////////////

//@ maintaining 0 <= i && i <= n;
//@ loop_assigns i;
//@ decreases n - i;
public static int idByLoop(int n) {
    int i = 0;
    while (i < n) {
        i++;
    }
    return i;
}
