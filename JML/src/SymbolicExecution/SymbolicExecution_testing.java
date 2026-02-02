/*
CFG {
  nodes = [
    Entry Int,
    End {id = 1, parent = 0, mExpr = Just (NumberLiteral 5.0)}
  ],
  edges = [(0,[1])]
}
*/
/*
  Entry
----------
  End: 0 -> 1:
        5.0
========================
  (0,[1])
*/
/*
SymState {
  env = fromList [("return",SymInt 5)],
  methodType = Int,
  pc = []
}
*/
public int boo21(){
  return 5;
}

///////////////////////////////////////////////////

//SymState {env = fromList [("i",SymFormalParam Int "i"),("return",SymFormalParam Int "i")], pc = []}
public int boo21_i(int i){
  return i;
}

///////////////////////////////////////////////////

//SymState {env = fromList [("i",SymNull Int),("return",SymInt 5)], pc = []}
public int boo21_2(){
  int i;
  return 5;
}

///////////////////////////////////////////////////

/*
SymState {env = fromList [
  ("i",SymFormalParam Int "i" (Just (SymInt 5))),
  ("return",SymFormalParam Int "i" (Just (SymInt 5)))
 ], pc = []}
*/
public int boo21_2_i(int i){
  i = 5;
  return i;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SBin (SymParm Int "i") Add (SymInt 2)),
    ("return",SBin (SymParm Int "i") Add (SymInt 2))
  ], pc = []
}
*/
/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)))),
    ("return",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2))))
  ],
  pc = []
}

*/
public int boo21_3_i(int i){
  i += 2;
  return i;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)))),
    ("return",SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 4))
  ], pc = []
}
*/
public int boo21_3_i_1(int i){
  i += 2;
  return i+i;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo21_3_i_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "i",SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)),
    (VarName "x",SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9)),
    (Return,SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9))
  ], pc = []
}
*/
public int boo21_3_i_2(int i){
  i += 2;
  int x = i + 5 + i;
  return x;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo21_3_i_3",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "i",SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)),
    (VarName "x",SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9)),
    (Return,SBin (SBin (SymInt 5) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 20))
  ], pc = []
}
*/
public int boo21_3_i_3(int i){
  i += 2;
  int x = i + 5 + i;
  return x + i + x;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo21_3_i_4",SMethodType Int),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 2))),
    (Return,SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 2)))
  ], pc = []
}
*/
public int boo21_3_i_4(int i){
  x += i + 2 + i;
  return x;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("boo21_3_i_5",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Sub (SymFormalParam Int "i" Nothing))))),
    ("x",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Sub (SymFormalParam Int "i" Nothing)))))
  ], pc = []
}
*/
public int boo21_3_i_5(int i){
  x += i + 2 - 2*i;
  return x;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("boo21_3_i_6",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Add (SymFormalParam Int "i" Nothing))))),
    ("x",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Add (SymFormalParam Int "i" Nothing)))))
  ], pc = []
}
*/
public int boo21_3_i_6(int i){
  x += 2 + 3*i - 2*i;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("boo21_3_i_7",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SymInt 2)))),
    ("x",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SymInt 2))))
  ], pc = []
}
*/
public int boo21_3_i_7(int i){
  x += 2 + 3*i - 2*i - i;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("boo21_3_i_8",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Add (SBin (SymInt 4) Mul (SymFormalParam Int "i" Nothing)))))),
    ("x",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Add (SBin (SymInt 4) Mul (SymFormalParam Int "i" Nothing))))))
  ], pc = []
}
*/
public int boo21_3_i_8(int i){
  x += i + 2 + 3*i;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" (Just (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)))),
    ("return",SymFormalParam Int "i" (Just (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing))))
  ], pc = []
}
*/
public int boo21_3_i_9(int i){
  i += i;
  return i;
}

///////////////////////////////////////////////////

/*
CFG {
  nodes = [
    Entry,
    End {id = 1, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []})
    }
  ], 
  edges = [(0,[1])]
}
*/
/*
  Entry
----------
  End: 0 -> 1:
        boo21()
========================
  (0,[1])
*/
/*
SymState {
  env = fromList [("return",SymInt 5)],
  methodType = Int,
  pc = []
}
*/
public int boo22(){
  return boo21();
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo22_i",SMethodType Int),
 (FormalParms,SFormalParms ["i"]),
 (VarName "i",SymVar Int "i"),
 (Return,SymVar Int "i")
]
*/
public int boo22_i(int i){
  return boo21_i(i);
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo22_i_2",SMethodType Int),
 (FormalParms,SFormalParms ["i"]),
 (VarName "i",SymVar Int "i"),
 (Return,SBin (SymVar Int "i") Add (SymInt 5))
]
*/
public int boo22_i_2(int i){
  return boo21_i(i+4) + 1;
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo22_i_3",SMethodType Int),
 (FormalParms,SFormalParms ["i"]),
 (VarName "i",SymVar Int "i"),
 (Return,SBin (SymVar Int "i") Add (SymInt 2))
]
*/
public int boo22_i_3(int i){
  return boo21_3_i(i);
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo22_i_4",SMethodType Int),
 (FormalParms,SFormalParms ["i"]),
 (VarName "i",SymVar Int "i"),
 (Return,SBin (SBin (SymVar Int "i") Add (SymInt 6)) Mul (SymInt 5))
]
*/
public int boo22_i_4(int i){
  return boo21_3_i(i+4) * 5;
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo22_i_5",SMethodType Int),
 (GlobalVars,SGlobalVars ["j"]),
 (FormalParms,SFormalParms ["i"]),
 (VarName "i",SymVar Int "i"),
 (VarName "j",SymVar UnknownGlobalVarSymType "j"),
 (Return,SBin (SymVar Int "j") Add (SymInt 2))
]
*/
public int boo22_i_5(int i){
  return boo21_3_i(j);
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo22_2_i",SMethodType Int),
 (FormalParms,SFormalParms ["i"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
 (VarName "i",SymVar Int "i"),
 (VarName "x",SBin (SymVar Int "i") Mul (SymInt 2)),
 (Return,SBin (SymVar Int "i") Mul (SymInt 2))
]
*/
public int boo22_2_i(int i){
  int x = boo21_i(i*2);
  return x;
}

///////////////////////////////////////////////////

//DONE
/*
[
 (MethodName "boo22_2_i_2",SMethodType Int),
 (VarBindings,SVarBindings (fromList [
     ("i",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),
     ("j",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),
     ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
 (VarAssignments,SVarAssignments [
     ("j",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),
     ("i",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),
     ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
 (VarName "i",SymInt 9),
 (VarName "j",SymInt 6),
 (VarName "x",SymInt 18),
 (Return,SymInt 33)
]
*/
public int boo22_2_i_2(){
  int j = 6;
  int i = 3 + j;
  int x = boo21_i(i*2);
  return x + i + j;
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo23_3_i",SMethodType Int),
 (FormalParms,SFormalParms ["i"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
 (VarName "i",SymVar Int "i"),
 (VarName "x",SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i"))),
 (Return,SymInt 5)
]
*/
public int boo23_3_i(int i){
  int x = 3 + boo21_i(i+i);
  return 5;
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo23_3_i_2",SMethodType Int),
 (VarBindings,SVarBindings (fromList [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
 (VarName "i",SymInt 4),
 (VarName "x",SymInt 11),
 (Return,SymInt 16)
]
*/
public int boo23_3_i_2(){
  int i = 4;
  int x = 3 + boo21_i(i+i);
  return x+5;
}

///////////////////////////////////////////////////

/*
SymState {env = fromList [("i",SymFormalParam Int "i" Nothing),("return",SymInt 3)], pc = []}
*/
public int boo23_4_i(int i){
  return 3 + boo21_i(0);
}

///////////////////////////////////////////////////

//SymState {env = fromList [("return",SymInt 10)], pc = []}
public int boo23_4_i_2(){
  return 5 * boo21_i(0*4+2);
}

////////////////////////////////////////

/*
SymState {env = fromList [("i",SymFormalParam Int "i" Nothing),("return",SymInt 10)], pc = []}
*/
public int boo23_4_i_3(int i){
  return 5 * boo21_i(0*i+2);
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymNum 15.0) Mul (SBin (SBin (SymInt 3) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 2)))
  ], pc = []
}
*/
public int boo23_4_i_4(int i){
  return 15 * boo21_i(3*i+2);
}

////////////////////////////////////////

//SymState {env = fromList [("return",SymInt 255)], pc = []}
public int boo23_4_i_4_1(){
  return boo23_4_i_4(5);
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 15) Mul (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)))
  ], pc = []
}
*/
public int boo23_4_i_5(int i){
  return 15 * boo21_i(1*i+2);
}

////////////////////////////////////////

//SymState {env = fromList [("i",SymFormalParam Int "i" Nothing),("return",SymInt 8)], pc = []}
public int boo23_5_i(int i){
  return 8;
}

////////////////////////////////////////

//SymState {env = fromList [("i",SymFormalParam Int "i" Nothing),("return",SymDouble 8.0)], pc = []}
public double boo23_6_i(int i){
  return 8;
}

////////////////////////////////////////

/*
[
 (MethodName "boo23_7_i",SMethodType Double),
 (FormalParms,SFormalParms ["i"]),
 (VarName "i",SymVar Int "i"),
 (Return,SBin (SymInt 8) Add (SymVar Double "i"))
]
*/
public double boo23_7_i(int i){
  return 3+5+i;
}

////////////////////////////////////////

/*
[
 (MethodName "boo23_8_i",SMethodType Int),
 (FormalParms,SFormalParms ["i"]),
 (VarName "i",SymVar Int "i"),
 (Return,SBin (SymInt 3) Add (SBin (SymInt 5) Mul (SymVar Int "i")))
]
*/
public int boo23_8_i(int i){
  return 3+5*i;
}

////////////////////////////////////////

/*
[
 (MethodName "boo23_9_i",SMethodType Int),
 (FormalParms,SFormalParms ["i"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
 (VarName "i",SymVar Int "i"),
 (VarName "x",SymInt 5),
 (Return,SymInt 5)
]
*/
public int boo23_9_i(int i){
  int x;
  x = 3 + boo21_i(i+2) - i;
  return x;
}

////////////////////////////////////////

/*
[
 (MethodName "boo23_9_i_2",SMethodType Int),
 (FormalParms,SFormalParms ["i"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
 (VarName "i",SymVar Int "i"),
 (VarName "x",SBin (SymInt 5) Sub (SymVar Int "i")),
 (Return,SBin (SymInt 5) Sub (SymVar Int "i"))
]
*/
public int boo23_9_i_2(int i){
  int x;
  x = 3 + boo21_i(i+2) - 2*i;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 8) Add (SymFormalParam Int "i" Nothing)),
    ("x",SBin (SymInt 8) Add (SymFormalParam Int "i" Nothing))
  ], pc = []
}
*/
public int boo23_10_i(int i){
  int x = 3+5+i;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 8) Add (SymFormalParam Int "i" Nothing)),
    ("x",SBin (SymInt 8) Add (SymFormalParam Int "i" Nothing))
  ], pc = []
}
*/
public int boo23_10_i_2(int i){
  int x = 3+i+5;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 9) Mul (SymFormalParam Int "i" Nothing)),
    ("x",SymInt 9)
  ], pc = []
}
*/
public int boo23_11_i(int i){
  int x = 3+5;
  x = 10-1;
  return x*i;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 3) Add (SymFormalParam Int "i" Nothing)),
    ("x",SBin (SymInt 3) Add (SymFormalParam Int "i" Nothing))
  ], pc = []
}
*/
public int boo23_12_i(int i){
  int x = 3 + boo21_i(i);
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo33_4_i",SMethodType Double),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Double "i" Nothing),
    (VarName "j",SymFormalParam Double "j" Nothing),
    (VarName "x",SBin (SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing)) Add (SymFormalParam Double "j" Nothing)),
    (Return,SBin (SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing)) Add (SymFormalParam Double "j" Nothing))
  ], pc = []
}
*/
public double boo33_4_i(double i, double j){
  double x = 1 + i;
  x = x + 0.1 + j;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo33_3_i",SMethodType Double),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Double "i" Nothing),
    (VarName "x",SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing)),
    (Return,SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing))
  ], pc = []
}
*/
public double boo33_3_i(double i){
  double x = 1 + i;
  x+=0.1;
  return x;
}

////////////////////////////////////////

/*
CFG {
  nodes = [
    Entry Int "boo22_2",
    Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}}}), parent = 0},
    End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
  ],
  edges = [(0,[1]),(1,[2])]
}
*/
/*
  Entry boo22_2: method type: Int
----------
  0 -> 1:
        Int x = boo21()
----------
  End: 0 -> 2:
        return: x
========================
  (0,[1])
  (1,[2])
*/
/*
SymState {
  env = fromList [("return",SymInt 5),("x",SymInt 5)],
  pc = []
}
*/
public int boo22_2(){
  int x = boo21();
  return x;
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo23_12",SMethodType Int),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 2}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 2}})]),
 (VarName "x",SymInt 8),
 (Return,SymInt 8)
]
*/
public int boo23_12(){
  int x = 3 + boo21();
  return x;
}

///////////////////////////////////////////////////

/*
CFG {
  nodes = [
    Entry Int "boo23_2",
    End {
      id = 1,
      parent = 0,
      mExpr = Just (
        BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}
        }
      )
    }
  ],
  edges = [(0,[1])]
}
*/
/*
SymState {env = fromList [("return",SymInt 8)], methodType = Int, pc = []}
*/
public int boo23_2(){
  return 3 + boo21();
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),
    ("boo23_3",SMethodType Int),
    ("return",SymInt 5),
    ("x",SymInt 8)
  ], pc = []
}
*/
public int boo23_3(){
  int x = 3 + boo21();
  return 5;
}

///////////////////////////////////////////////////

//SymState {env = fromList [("return",SymInt 8)], pc = []}
public int boo23_8(){
  return 8;
}

////////////////////////////////////////

//SymState {env = fromList [("return",SymInt 8)], pc = []}
public int boo23_4(){
  return 3 + boo21();
}

////////////////////////////////////////

//SymState {env = fromList [("return",SymInt 8)], pc = []}
public int boo23_5(){
  return 8;
}

////////////////////////////////////////

//SymState {env = fromList [("return",SymDouble 8.0)], pc = []}
public double boo23_6(){
  return 8;
}

////////////////////////////////////////

//SymState {env = fromList [("return",SymDouble 8.0)], pc = []}
public double boo23_7(){
  return 3+5;
}

////////////////////////////////////////

//SymState {env = fromList [("return",SymInt 8)], pc = []}
public int boo23_8(){
  return 3+5;
}

////////////////////////////////////////

/*
[
 (MethodName "boo23_9",SMethodType Int),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 0, branchEnd = 3}})]),
 (VarName "x",SymInt 8),
 (Return,SymInt 8)
]
*/
public int boo23_9(){
  int x;
  x = 3 + boo21();
  return x;
}

////////////////////////////////////////

/*
SymState {env = fromList [("return",SymInt 8),("x",SymInt 8)], pc = []}
*/
public int boo23_10(){
  int x = 3+5;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),
    ("boo23_11",SMethodType Int),
    ("return",SymInt 9),
    ("x",SymInt 9)
  ], pc = []
}
*/
public int boo23_11(){
  int x = 3+5;
  x = 10-1;
  return x;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo24",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "x",SymInt 9),
    (Return,SymInt 9)
  ], pc = []
}
*/
public int boo24(){
  int x = 3 + boo25(5);
  return x;
}

/////////////////////

/*
[
 (MethodName "boo24_2",SMethodType Int),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
 (VarName "x",SException Int "Exception" "meow"),
 (Return,SException Int "Exception" "meow"),
 (Actions,SActions ["Oopsie\n"])
]
*/
public int boo24_2(){
  int x = 3 + boo25(11);
  return x;
}

/////////////////////

/*
[
 (MethodName "boo25",SMethodType Int),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["i"]),
 (VarAssignments,SVarAssignments []),
 (VarName "i",SymVar Int "i"),
 (ScopeRange (SR {branchStart = 1, branchEnd = 5}),SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []})))
]
*/
public int boo25(int i){
  if(i>10){
    throw new Exception("meow");
  }
  else{
    return 6;
  }
}

///////////////////////////////////////////////////

/*
SymState {env = fromList [("boo26_2",SMethodType Int),("return",SymInt 5)], pc = []}
*/
public int boo26_2(){
  return boo27(-5);
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo27",SMethodType Int),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (NodeNr 1,SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
                   (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(VarName "i",SymFormalParam Int "i" Nothing),(Return,SymFormalParam Int "i" Nothing)], pc = []})
                   (Just (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(VarBindings,SVarBindings (fromList [("res",VarBinding {varDeclAt = 3, varFrame = 1})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "res",SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing)),(Return,SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing))], pc = []})))
  ], pc = []
}
*/
public int boo27(int i){
  if(i >= 0){
    return i;
  }
  else{
    int res = -1 * i;
    return res;
  }
}

///////////////////////////////////////////////////

/*
SymState {env = fromList [("boo27_2",SMethodType Int),("return",SymInt 5)], pc = []}
*/
public int boo27_2() {
  return boo27(5);
}

////////////////////////////////////////

/*
[
 (MethodName "boo28",SMethodType Int),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["i"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),
 (VarName "i",SymVar Int "i"),
 (VarName "x",SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 5})],3)]),
 (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")], pc = []}) Nothing),
 (Return,SymInt 5)
]
*/
public int boo28(int i){
  int x = 1;
  if(i >= 0){
    x++;
    return i;
  }
  return 5;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),
    ("boo282",SMethodType Int),
    ("return",SymInt 2),
    ("x",SymInt 2)
  ], pc = []
}
*/
public int boo282(){
  int x = 1;
  if(x >= 0){
    x++;
    return x;
  }
  return 5;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("boo283",SMethodType Int),
    ("return",SymInt 5),
    ("x",SymInt 1)
  ], pc = []
}
*/
public int boo283(){
  int x = 1;
  if(x < 0){
    x++;
    return x;
  }
  return 5;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [("boo28_p",SMethodType Int),("return",SymInt 10)], pc = []
}
*/
public int boo28_p() {
  return boo28(10);
}

////////////////////////////////////////

/*
SymState {env = fromList [("boo28_m",SMethodType Int),("return",SymInt 5)], pc = []}
*/
public int boo28_m() {
  return boo28(-10);
}

////////////////////////////////////////

/*
[
 (MethodName "boo28_2",SMethodType Int),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["i"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),
 (VarName "i",SymVar Int "i"),
 (VarName "x",SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 6})],3)]),
 (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_2",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(VarName "y",SymInt 0),(Return,SymVar Int "i")], pc = []}) Nothing),
 (Return,SymInt 5)
]
*/
public int boo28_2(int i){
  int x = 1;
  if(i >= 0){
    x++;
    int y = 0;
    return i;
  }
  return 5;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_2_1",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "x",SymInt 2),
    (Return,SymInt 4)
  ], pc = []
}
*/
public int boo28_2_1(){
  int x = 1;
  if(x >= 0){
    x++;
    int y = 0;
    return 1+x+1;
  }
  return 5;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("2",SIte (SBin (SymFormalParam Int "i" Nothing) Gt (SymInt 0)) (SymState {env = fromList [("boo28_3",SMethodType Int),("i",SymFormalParam Int "i" Nothing),("return",SymFormalParam Int "i" Nothing),("x",SymInt 1),("y",SymInt 0)], pc = []}) Nothing),
    ("boo28_3",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymInt 5),
    ("x",SymInt 1)
  ], pc = []
}
*/
public int boo28_3(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    return i;
  }
  return 5;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_4",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (NodeNr 2,SIte 
       (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
       (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 3, varFrame = 2})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymFormalParam Int "i" Nothing)], pc = []})
       (Just (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 2)], pc = []}))),
    (Return,SymInt 5)
  ], pc = []
}
*/
public int boo28_4(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    return i;
  }
  else {
   x++;
  }
  return 5;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_4_1",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (Return,SymFormalParam Int "i" Nothing)
  ], pc = []
}
*/
public int boo28_4_1(int i){
  int x = 1;
  if(true){
    int y = 0;
    return i;
  }
  else {
   x++;
  }
  return 5;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo28_4_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 2),
    (Return,SymInt 5)
  ], pc = []
}
*/
public int boo28_4_2(int i){
  int x = 1;
  if(false){
    int y = 0;
    return i;
  }
  else {
   x++;
  }
  return 5;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_4_p",SMethodType Int),
    (Return,SymInt 10)
  ], pc = []
}
*/
public int boo28_4_p() {
  return boo28_4(10);
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_4_m",SMethodType Int),
    (Return,SymInt 5)
  ], pc = []
}
*/
public int boo28_4_m() {
  return boo28_4(-10);
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_5",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (NodeNr 2,SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
                   (SymState {env = fromList [(MethodName "boo28_5",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 3, varFrame = 2})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymFormalParam Int "i" Nothing) Add (SymInt 1))], pc = []})
                   (Just (SymState {env = fromList [(MethodName "boo28_5",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 2)], pc = []}))),
    (Return,SymInt 5)
  ], pc = []
}
*/
public int boo28_5(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
   x++;
  }
  return 5;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_6",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 8, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (VarName "y",SymInt 2),
    (NodeNr 2,SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
                   (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 3, varFrame = 2})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymFormalParam Int "i" Nothing) Add (SymInt 1))], pc = []})
                   (Just (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 2)], pc = []}))),
    (Return,SymInt 7)
  ], pc = []
}
*/
public static int boo28_6(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  int y = 2;
  return 5+y;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_6_p",SMethodType Int),
    (Return,SymInt 11)
  ], pc = []
}
*/
public int boo28_6_p() {
  return boo28_6(10);
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_6_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (Return,SBin (SymFormalParam Int "i" Nothing) Add (SymInt 1))
  ], pc = []
}
*/
public static int boo28_6_2(int i){
  int x = 1;
  if(x >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  int y = 2;
  return 5+y;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_6_3",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 7, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (VarName "y",SymInt 2),
    (Return,SymInt 7)
  ], pc = []
}
*/
public static int boo28_6_3(int i){
  int x = 1;
  if(x >= 0){
    int y = 0;
    y++;
  }
  else {
    x++;
  }
  int y = 2;
  return 5+y;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_6_4",SMethodType Int),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",CFG_Coor {varDeclAt = 1, varFrame = 0}),("y",CFG_Coor {varDeclAt = 7, varFrame = 0})])),
    (VarAssignments,SVarAssignments [
      ("x",CFG_Coor {varDeclAt = 1, varFrame = 0}),
      ("x",CFG_Coor {varDeclAt = 5, varFrame = 2}),
      ("y",CFG_Coor {varDeclAt = 7, varFrame = 0})
    ]),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 2),
    (VarName "y",SymInt 2),
    (Return,SymInt 7),
    (Actions,SActions [])
  ], pc = []
}
*/
public static int boo28_6_4(int i){
  int x = 1;
  if(x < 0){
    int y = 0;
    y++;
  }
  else {
    x++;
  }
  int y = 2;
  return 5+y;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_6_5",SMethodType Int),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",CFG_Coor {varDeclAt = 1, varFrame = 0})])),
    (VarAssignments,SVarAssignments [("x",CFG_Coor {varDeclAt = 1, varFrame = 0}),("x",CFG_Coor {varDeclAt = 5, varFrame = 2})]),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 2),
    (Return,SymInt 2),
    (Actions,SActions [])
  ], pc = []
}
*/
public static int boo28_6_5(int i){
  int x = 1;
  if(x < 0){
    int y = 0;
    y++;
  }
  else {
    x++;
  }
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_6_6",SMethodType Int),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = 0})])),
    (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("x",Node_Coor {varDeclAt = 6, varFrame = 2})]),
    (BranchRange (BR {branchStart = 2, branchEnd = 7}),SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_6_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("y",Node_Coor {varDeclAt = 3, varFrame = 2})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("y",Node_Coor {varDeclAt = 3, varFrame = 2}),("y",Node_Coor {varDeclAt = 4, varFrame = 2})]),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymFormalParam Int "i" Nothing) Add (SymInt 1))], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_6_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = 0})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("x",Node_Coor {varDeclAt = 6, varFrame = 2})]),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 2)], pc = []}))),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymUnknown ("x",Int)
    (IfBranchingReason (BR {branchStart = 2, branchEnd = 7}))),
    (Return,SymUnknown ("x",Int) (IfBranchingReason (BR {branchStart = 2, branchEnd = 7})))
  ], pc = []
}
*/
public static int boo28_6_6(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo28_6_7",SMethodType Int),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = 0})])),
    (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("x",Node_Coor {varDeclAt = 6, varFrame = 2}),("x",Node_Coor {varDeclAt = 8, varFrame = 0})]),
    (BranchRange (BR {branchStart = 2, branchEnd = 7}),SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_6_7",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("y",Node_Coor {varDeclAt = 3, varFrame = 2})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("y",Node_Coor {varDeclAt = 3, varFrame = 2}),("y",Node_Coor {varDeclAt = 4, varFrame = 2})]),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymFormalParam Int "i" Nothing) Add (SymInt 1))], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_6_7",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = 0})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("x",Node_Coor {varDeclAt = 6, varFrame = 2})]),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 2)], pc = []}))),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 5),
    (Return,SymInt 5)
  ], pc = []
}
*/
public static int boo28_6_7(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  x = 5;
  return x;
}

/////////////////////

/*
CFG {
  nodes = [
    Entry,
    Node {id = 1, nodeData = TryNode, parent = 0},
    Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 3.0}}), parent = 0},
    Node {id = 3, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = ==, expr2 = NumberLiteral 3.0}), parent = 0},
    End {id = 4, parent = 3, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "something"})},
    End {id = 5, parent = 3, mExpr = Just (NumberLiteral 1.0)},
    Node {id = 6, nodeData = Meet If, parent = 0},
    Node {id = 7, nodeData = CatchNode (AnyType {typee = "Exception", generic = Just (AnyType {typee = "e", generic = Nothing})}), parent = 0},
    End {id = 8, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo27"}, funArgs = [NumberLiteral 5.0]})}
  ],
  edges = [(0,[1]),(1,[2]),(2,[3]),(3,[4,5]),(4,[6]),(5,[6]),(6,[7]),(7,[8])]}
*/
/*
  Entry
----------
  0 -> 1:
        Try Node
----------
  0 -> 2:
        Int x = 3.0
----------
  0 -> 3:
        If: x == 3.0
----------
  End: 3 -> 4:
        Exception(something)
----------
  End: 3 -> 5:
        1.0
----------
  0 -> 6:
        Meet: If
----------
  0 -> 7:
        Catch Node: Exception
----------
  End: 0 -> 8:
        boo27(5.0)
========================
  (0,[1])
  (1,[2])
  (2,[3])
  (3,[4,5])
  (4,[6])
  (5,[6])
  (6,[7])
  (7,[8])
*/
public int boo29(){
  try{
    int x = 3;
    if(x == 3){
      throw new Exception("something");
    }
    else{
      return 1;
    }
  }
  catch(Exception e){
    return boo27(5);
  }
}

///////////////////////////////////////////////////

public int boo29_2(){
  try{
    int x = 0;
    if(x == 3){
      throw new Exception("something");
    }
    else{
      return 1;
    }
  }
  catch(Exception e){
    return boo27(-5);
  }
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo29",SMethodType Bool),
    (Return,SBool False)
  ], pc = []
}
*/
public boolean boo29(){
  if(true){
    return false;
  }
  else{
    return true;
  }
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo30",SMethodType Int),
 (GlobalVars,SGlobalVars ["y","y1","y2","t1","t2"]),
 (FormalParms,SFormalParms ["z"]),
 (VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
 (VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}}),("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),
 (VarName "t1",SymUnknown (UnknownNumSymType,"t1",Nothing) [([(If,SR {branchStart = 6, branchEnd = 11})],7)]),
 (VarName "t2",SymUnknown (UnknownNumSymType,"t2",Nothing) [([(If,SR {branchStart = 6, branchEnd = 11})],9)]),
 (VarName "x1",SymInt 0),
 (VarName "x2",SymInt 0),
 (VarName "y",SymNum 0.0),
 (VarName "y1",SymNum 0.0),
 (VarName "y2",SymNum 0.0),
 (VarName "z",SymVar Int "z"),
 (ScopeRange (SR {branchStart = 6, branchEnd = 11}),SIte (SBin (SymVar Int "z") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t1"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t1",SymNum 7.0),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 7)], pc = []}) (Just (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t2"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t2",SymNum 17.0),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 17)], pc = []})))
]
*/
public int boo30(int z){
  int x1 = 0;
  int x2 = 0;
  y = 0;
  y1 = 0;
  y2 = 0;
  if(z>=0){
    t1 = 7;
    return t1;
  }
  else{
    t2 = 17;
    return t2;
  }
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo31",SMethodType Int),
 (GlobalVars,SGlobalVars ["z"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [("z",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
 (VarName "x",SymInt 0),
 (VarName "z",SymInt 0),
 (Return,SymInt 0)
]
*/
public int boo31(){
  z = 0;
  int x = z;
  return x;
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo31_2",SMethodType Int),
 (GlobalVars,SGlobalVars ["z","y","y1","y2","t1"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [("z",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
 (VarName "t1",SymInt 7),
 (VarName "x",SymInt 0),
 (VarName "y",SymNum 0.0),
 (VarName "y1",SymNum 0.0),
 (VarName "y2",SymNum 0.0),
 (VarName "z",SymInt 0),
 (Return,SymInt 7)
]
*/
public int boo31_2(){
  z = 0;
  int x = z;
  return boo30(1);
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo32",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "x",SBin (SBin (SymGlobalVar Int "y1" Nothing) Add (SymGlobalVar Int "y2" Nothing)) Add (SymGlobalVar Int "y3" Nothing)),
    (Return,SBin (SBin (SymGlobalVar Int "y1" Nothing) Add (SymGlobalVar Int "y2" Nothing)) Add (SymGlobalVar Int "y3" Nothing))
  ], pc = []
}
*/
public int boo32(){
  int x = y1 + y2 + y3;
  return x;
}

///////////////////////////////////////////////////

/*
FunDef {
  funModifier = [Public], 
  isPureFlag = False, 
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "boo33"}, funArgs = []}},
   throws = Nothing, 
   funBody = CompStmt {
     statements = [
       AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}},
       AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}},
       ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
     ]
   }
}
*/

public int boo33(){
  int x = 1;
  x++;
  return x;
}

///////////////////////////////////////////////////

/*
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "boo33_2"}, funArgs = []}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}},
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 2.0}}},
    ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
  ]}
}
*/
public int boo33_2(){
  int x = 1;
  x+=2;
  return x;
}

///////////////////////////////////////////////////

//SymState {env = fromList [("return",SymDouble 1.1),("x",SymDouble 1.1)], pc = []}
public double boo33_3(){
  double x = 1;
  x+=0.1;
  return x;
}

///////////////////////////////////////////////////

//SymState {env = fromList [("return",SymDouble 1.1),("x",SymDouble 1.1)], pc = []}
public double boo33_4(){
  double x = 1;
  x = x + 0.1;
  return x;
}

///////////////////////////////////////////////////

/*
[
 (MethodName "boo33_5",SMethodType Double),
 (GlobalVars,SGlobalVars ["z","t"]),
 (FormalParms,SFormalParms ["str"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 0, branchEnd = 5}}),("z",Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 4, varFrame = BR {branchStart = 0, branchEnd = 5}})]),
 (VarName "str",SymVar String "str"),
 (VarName "t",SymVar UnknownGlobalVarSymType "t"),
 (VarName "x",SymDouble 1.1),
 (VarName "y",SymNull Int),
 (VarName "z",SymVar UnknownGlobalVarSymType "t"),
 (Return,SymDouble 1.1)
]
*/
public double boo33_5(){
  double x = 1;
  int y;
  x = x + 0.1;
  return x;
}

////////////////////////////////////////

/*
[
 (MethodName "boo33_6",SMethodType Double),
 (GlobalVars,SGlobalVars ["z","t"]),
 (FormalParms,SFormalParms ["str"]),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 6}}),("y",Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 0, branchEnd = 6}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 6}}),("y",Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 0, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 0, branchEnd = 6}}),("x",Node_Coor {varDeclAt = 4, varFrame = BR {branchStart = 0, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 5, varFrame = BR {branchStart = 0, branchEnd = 6}})]),
 (VarName "str",SymVar String "str"),
 (VarName "t",SymVar UnknownNumSymType "t"),
 (VarName "x",SymDouble 1.1),
 (VarName "y",SymNull Int),
 (VarName "z",SymNum 1.0),
 (Return,SymDouble 1.1)
]
*/
public double boo33_6(String str){
  double x = 1;
  int y;
  z = t;
  x = x + 0.1;
  z = 1;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo33_7",SMethodType Double),
    (GlobalVars,SGlobalVars ["c"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = 0})])),
    (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("x",Node_Coor {varDeclAt = 2, varFrame = 0})]),
    (VarName "c",SymGlobalVar Double "c" Nothing),
    (VarName "x",SymGlobalVar Double "c" Nothing),
    (Return,SymGlobalVar Double "c" Nothing)
  ], pc = []
}
*/
public double boo33_7(){
  double x;
  x = c;
  return x;
}

////////////////////////////////////////

/*
[
 (MethodName "elemAt",SMethodType Int),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["arr","pos"]),
 (VarAssignments,SVarAssignments []),
 (VarName "arr",SymVar (Array Int) "arr"),
 (VarName "pos",SymVar Int "pos"),
 (ScopeRange (SR {branchStart = 1, branchEnd = 3}),SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing),
 (Return,SArrayIndexAccess "arr" (SymVar Int "pos"))
]
*/
public int[] elemAt(int[] arr, int pos){
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "elemAtCall",SMethodType Int),
    (Return,SymInt 4)
  ], pc = []
}
*/
public int elemAtCall() throws Exception {
  return elemAt(new int[]{6,5,4,7,8},2);
}

////////////////////////////////////////

/*
[
 (MethodName "elemAt2",SMethodType Int),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["pos"]),
 (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
 (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
 (VarName "pos",SymVar Int "pos"),
 (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymInt 5) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing),
 (Return,SArrayIndexAccess "arr" (SymVar Int "pos"))
]
*/
public int elemAt2(int pos) throws Exception {
  int[] arr = new int[]{6,5,4,7,8};
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "elemAt2call",SMethodType Int),
    (Return,SymInt 4)
  ], pc = []
}
*/
public int elemAt2call() {
  return elemAt2(2);
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "elemAt2call2",SMethodType Int),
    (Return,SException "Exception" "not found")
  ], pc = []
}
*/
public int elemAt2call2() {
  return elemAt2(5);
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "elemAt4",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("arr",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (Return,SymInt 7)
  ], pc = []
}
*/
public int elemAt4() {
  int[] arr = {6,5,4,7,8};
  return arr[3];
}

////////////////////////////////////////

/*
[
 (MethodName "strFun",SMethodType String),
 (VarBindings,SVarBindings (fromList [("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
 (VarName "firstName",SymString "Tarek"),
 (VarName "lastName",SymString "Soliman"),
 (Return,SymString "Tarek Soliman")
]
*/
public String strFun() {
  String firstName = "Tarek";
  String lastName = "Soliman";
  return firstName + " " + lastName;
}
////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "voidFun1",SMethodType Void)
  ], pc = []
}
*/
public void voidFun1() {
  return;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "voidFun2",SMethodType Void)
  ], pc = []
}
*/
public void voidFun2() {
}

////////////////////////////////////////

/*
[
 (MethodName "voidFun3",SMethodType Void),
 (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
 (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 6}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
 (VarName "x",SymInt 1),
 (VarName "y",SymString "is one"),
 (VarName "z",SymString "1 is one")
]
*/
public void voidFun3() {
  int x;
  String y;
  x = 1;
  y = "is one";
  String z = toString(x) + " " + y;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "voidFun4",SMethodType Void),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 2, varFrame = 0}),("z",VarBinding {varDeclAt = 5, varFrame = 0})])),
    (VarName "x",SymInt 1),
    (VarName "y",SymString "is one"),
    (VarName "z",SymString "1 is one"),
    (Actions,SActions ["1 is one\n"])
  ], pc = []
}
*/
public void voidFun4() {
  int x;
  String y;
  x = 1;
  y = "is one";
  String z = toString(x) + " " + y;
  println(z);
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "voidFun5",SMethodType Void),
    (Actions,SActions ["Before\n","1 is one\n","After\n"])
  ], pc = []
}
*/
public void voidFun5() {
  println("Before");
  voidFun4();
  println("After");
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "manyArrs",SMethodType Void),
    (VarBindings,SVarBindings (fromList [("numbers",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]),
    (Actions,SActions ["[99, 5]\n"])
  ], pc = []
}
*/
public void manyArrs() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  println(numbers);
}

////////////////////////////////////////

/*
[
 (MethodName "manyArrs2",SMethodType Void),
 (VarBindings,SVarBindings (fromList [("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})])),
 (VarAssignments,SVarAssignments [("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 29}}),("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 11, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 15, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 16, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 17, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 18, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 19, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 20, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 21, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 22, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 23, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 24, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 25, varFrame = SR {branchStart = 0, branchEnd = 29}})]),
 (VarName "brand",SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),
 (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]),
 (VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]),
 (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]),
 (VarName "strs",SymArray (Just (Array String)) (Just 3) [SymNull String,SymString "meow",SymNull String]),
 (Actions,SActions ["[86, 57, 80, 34, 50, 48, 94]\n","[51, 84, 92, 87, 81]\n","[5, 75, 34, 10, 6]\n"])
]
*/
public void manyArrs2() {
  int[] numbers1 = new int[7];
  int[] numbers2 = {40, 55, 63, 17, 22};
  int[] numbers3;
  numbers3 = new int[5];
  String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
  String[] strs = new String[3];
  strs[1] = "meow";
  numbers1[0] = 86;
  numbers1[2] = 80;
  numbers1[1] = 57;
  numbers1[3] = 34;
  numbers1[4] = 50;
  numbers1[5] = 48;
  numbers1[6] = 94;
  numbers2[0] = 51;
  numbers2[1] = 84;
  numbers2[2] = 92;
  numbers2[3] = 87;
  numbers2[4] = 81;
  numbers3[4] = 43;
  numbers3[3] = 10;
  numbers3[2] = 34;
  numbers3[1] = 75;
  numbers3[4] = 6;
  numbers3[0] = 5;
  println(numbers1);
  println(numbers2);
  println(numbers3);
}

/////////////////////

/*
[
 (MethodName "ifFun",SMethodType Int),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["n"]),
 (VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
 (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
 (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
 (VarName "n",SymVar Int "n"),
 (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
 (VarName "x",SymInt 1),
 (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing),
 (Return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))
]
*/
public int ifFun(int n) {
  int res = 0;
  int m = 0;
  int x = 1;
  if(n>=0) {
    res += n;
    m += 2*n;
  }
  return res+1;
}

/////////////////////

/*
[
  (MethodName "ifFunCall",SMethodType Int),
  (Return,SymInt 8)
]
*/
public int ifFunCall() {
  return 4+ifFun(3);
}


/////////////////////

/*
[
 (MethodName "ifFun2",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (FormalParms,SFormalParms ["n"]),
 (VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
 (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
 (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
 (VarName "n",SymVar Int "n"),
 (VarName "res",SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
 (VarName "x",SymInt 1),
 (VarName "y",SymVar Int "y"),
 (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing),
 (Return,SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))
]
*/
public int ifFun2(int n) {
  int res = y;
  int m = 0;
  int x = 1;
  if(n>=0) {
    res += n;
    m += 2*n;
  }
  return res+1;
}

/////////////////////

/*
[
 (MethodName "ifFun2Call",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (VarName "y",SymGlobalVar Int "y" Nothing),
 (Return,SBin (SymGlobalVar Int "y" Nothing) Add (SymInt 11))
]
*/
public int ifFun2Call() {
  return ifFun2(10);
}

/////////////////////

/*
[
 (MethodName "ifFun2Call2",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (VarName "y",SymGlobalVar Int "y" Nothing),
 (Return,SBin (SymGlobalVar Int "y" Nothing) Add (SymInt 1))
]
*/
public int ifFun2Call2() {
  return ifFun2(-10);
}

/////////////////////

/*
[
 (MethodName "ifFun3",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (FormalParms,SFormalParms ["n"]),
 (VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
 (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
 (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
 (VarName "n",SymVar Int "n"),
 (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
 (VarName "x",SymInt 1),
 (VarName "y",SymVar UnknownNumSymType "y"),
 (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun3",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1),(VarName "y",SymVar UnknownNumSymType "y")], pc = []}) Nothing),
 (Return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))
]
*/
public int ifFun3(int n) {
  int res = 0;
  int m = 0;
  int x = 1;
  if(y>=0) {
    res += n;
    m += 2*n;
  }
  return res+1;
}

/////////////////////

/*
[
 (MethodName "ifFun4",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (FormalParms,SFormalParms ["n"]),
 (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),
 (VarName "n",SymVar Int "n"),
 (VarName "y",SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]),
 (ScopeRange (SR {branchStart = 1, branchEnd = 3}),SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun4",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymVar Int "y") Add (SymVar Int "n"))], pc = []}) Nothing),
 (Return,SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)])
]
*/
public int ifFun4(int n) {
  if(y>=0) {
    y += n;
  }
  return y;
}

/////////////////////

/*
[
 (MethodName "ifFun5",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (FormalParms,SFormalParms ["n"]),
 (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),
 (VarName "n",SymVar Int "n"),
 (VarName "y",SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
 (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing),
 (Return,SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])
]
*/
public int ifFun5(int n) {
  y = n;
  if(y>=0) {
    y += n;
  }
  return y;
}

/////////////////////

/*
[
 (MethodName "ifFun5Call1",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (VarName "y",SymInt 20),
 (Return,SymInt 20)
]
*/
public int ifFun5Call1() {
  return ifFun5(10);
}

/////////////////////

/*
[
 (MethodName "ifFun5Call2",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (VarName "y",SymInt (-10)),
 (Return,SymInt (-10))
]
*/
public int ifFun5Call2() {
  return ifFun5(-10);
}

/////////////////////

/*
[
 (MethodName "ifFun6",SMethodType String),
 (GlobalVars,SGlobalVars ["y","m","s","c"]),
 (FormalParms,SFormalParms ["n"]),
 (VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 1, branchEnd = 3}}),("s",Node_Coor {varDeclAt = 4, varFrame = BR {branchStart = 0, branchEnd = 5}})]),
 (VarName "c",SymGlobalVar String "c" Nothing),
 (VarName "m",SymUnknown (Int,"m",Nothing) [IfBranchingReason [Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 1, branchEnd = 3}}]]),
 (VarName "n",SymFormalParam Int "n" Nothing),
 (VarName "s",SymString "something"),
 (VarName "y",SymGlobalVar UnknownNumSymType "y" Nothing),
 (BranchRange (BR {branchStart = 1, branchEnd = 3}),SIte (SBin (SymGlobalVar UnknownNumSymType "y" Nothing) Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun6",SMethodType String),(GlobalVars,SGlobalVars ["y","m"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 1, branchEnd = 3}})]),(VarName "m",SBin (SymGlobalVar Int "m" Nothing) Add (SymFormalParam Int "n" Nothing)),(VarName "n",SymFormalParam Int "n" Nothing),(VarName "y",SymGlobalVar UnknownNumSymType "y" Nothing)], pc = []}) Nothing),
 (Return,SymGlobalVar String "c" Nothing)
]
*/
public String ifFun6(int n) {
  if(y>=0) {
    m += n;
  }
  s = "something";
  return c;
}

/////////////////////

/*
[
 (MethodName "ifFun7",SMethodType Void),
 (GlobalVars,SGlobalVars ["v","w"]),
 (FormalParms,SFormalParms ["n"]),
 (VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),
 (VarName "n",SymVar Int "n"),
 (VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
 (VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
 (ScopeRange (SR {branchStart = 1, branchEnd = 4}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))
]
*/
public void ifFun7(int n) {
  if(n % 2 == 0) {
    v = "hi";
  }
  else {
    w = "bye";
  }
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "ifFun7Call",SMethodType Void),
    (GlobalVars,SGlobalVars ["v"]),
    (VarName "v",SymString "hi")
  ], pc = []
}
*/
public void ifFun7Call() {
  ifFun7(4);
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "ifFun7Call2",SMethodType Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye")
  ], pc = []
}
*/
public void ifFun7Call2() {
  ifFun7(4);
  ifFun7(5);
}

/////////////////////

/*
[
 (MethodName "ifFun7Call3",SMethodType Void),
 (GlobalVars,SGlobalVars ["t","v","w"]),
 (VarName "t",SymGlobalVar UnknownGlobalVarSymType "t" Nothing),
 (VarName "v",SymNull String),
 (VarName "w",SymNull String)
]
*/
public void ifFun7Call3() {
  ifFun7(t);
}

/////////////////////

/*
[
 (MethodName "ifFun8",SMethodType Void),
 (GlobalVars,SGlobalVars ["v","w"]),
 (FormalParms,SFormalParms ["n"]),
 (VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),
 (VarName "n",SymVar Int "n"),
 (VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 6})],2)]),
 (VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
 (ScopeRange (SR {branchStart = 1, branchEnd = 6}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun8",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi"),(Actions,SActions ["hi\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun8",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye"),(Actions,SActions ["bye\n"])], pc = []})))
]
*/
public void ifFun8(int n) {
  if(n % 2 == 0) {
    v = "hi";
    println(v);
  }
  else {
    w = "bye";
    println(w);
  }
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "ifFun8Call",SMethodType Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye"),
    (Actions,SActions ["hi\n","bye\n","hi\n"])
  ], pc = []
}
*/
public void ifFun8Call() {
  ifFun8(4);
  ifFun8(5);
  ifFun8(6);
}

/////////////////////

/*
[
 (MethodName "ifFun9",SMethodType Void),
 (GlobalVars,SGlobalVars ["v","w"]),
 (FormalParms,SFormalParms ["n"]),
 (VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 1, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 4, varFrame = BR {branchStart = 1, branchEnd = 6}}),("w",Node_Coor {varDeclAt = 5, varFrame = BR {branchStart = 1, branchEnd = 6}})]),
 (VarName "n",SymFormalParam Int "n" Nothing),
 (VarName "v",SymUnknown (String,"v",Nothing) [IfBranchingReason [Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 1, branchEnd = 6}}]]),
 (VarName "w",SymUnknown (String,"w",Nothing) [IfBranchingReason [Node_Coor {varDeclAt = 5, varFrame = BR {branchStart = 1, branchEnd = 6}}]]),
 (BranchRange (BR {branchStart = 1, branchEnd = 6}),SIte (SBin (SBin (SymFormalParam Int "n" Nothing) Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun9",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("z",Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 1, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = BR {branchStart = 1, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 1, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 4, varFrame = BR {branchStart = 1, branchEnd = 6}})]),(VarName "hi",SymGlobalVar String "hi" Nothing),(VarName "n",SymFormalParam Int "n" Nothing),(VarName "v",SymString "hi zu"),(VarName "z",SymInt 3)], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun9",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 5, varFrame = BR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymFormalParam Int "n" Nothing),(VarName "w",SymString "bye")], pc = []})))
]
*/
public void ifFun9(int n) {
  if(n % 2 == 0) {
    v = "hi";
    int z = 3;
    v += " zu";
  }
  else {
    w = "bye";
  }
}

/////////////////////

//DONE
/*
[
 (MethodName "ifFun10",SMethodType Int),
 (GlobalVars,SGlobalVars ["v","bye","t","i"]),
 (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 9}})])),
 (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 9}}),("v",Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 2, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 4, varFrame = BR {branchStart = 2, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 5, varFrame = BR {branchStart = 2, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 7, varFrame = BR {branchStart = 0, branchEnd = 9}}),("t",Node_Coor {varDeclAt = 8, varFrame = BR {branchStart = 0, branchEnd = 9}})]),
 (VarName "i",SymGlobalVar UnknownGlobalVarSymType "i" Nothing),
 (VarName "res",SymInt 0),
 (VarName "t",SymGlobalVar UnknownGlobalVarSymType "i" Nothing),
 (VarName "v",SymUnknown (String,"v",Just (SymGlobalVar String "v" Nothing)) [IfBranchingReason [Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 2, branchEnd = 6}},Node_Coor {varDeclAt = 5, varFrame = BR {branchStart = 2, branchEnd = 6}}]]),
 (BranchRange (BR {branchStart = 2, branchEnd = 6}),SIte (SBin (SymGlobalVar String "v" Nothing) Eq (SymString "bye")) (SymState {env = fromList [(MethodName "ifFun10",SMethodType Int),(GlobalVars,SGlobalVars ["v"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 9}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 9}}),("v",Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 2, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 4, varFrame = BR {branchStart = 2, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 5, varFrame = BR {branchStart = 2, branchEnd = 6}})]),(VarName "hi",SymGlobalVar String "hi" Nothing),(VarName "res",SymInt 1),(VarName "v",SymString "zuzu")], pc = []}) Nothing),
 (Return,SymInt 0)
]
*/
public int ifFun10() {
  int res = 0;
  if(v == "bye") {
    v = "hi";
    res += 1;
    v = "zuzu";
  }
  res = 0;
  t = i;
  return res;
}

/////////////////////

/*
[
 (MethodName "ifFun11",SMethodType Int),
 (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 5}})]),
 (VarName "res",SymInt 0),
 (Return,SymInt 0)
]
*/
public int ifFun11() {
  int res = 0;
  if(false) {
    res += 1;
  }
  return res;
}

/////////////////////

/*
[
 (MethodName "ifFun12",SMethodType Int),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["n"]),
 (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 2, branchEnd = 4}})]),
 (VarName "n",SymFormalParam Int "n" Nothing),
 (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [IfBranchingReason [Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 2, branchEnd = 4}}]]),
 (BranchRange (BR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymFormalParam Int "n" Nothing) Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun12",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = BR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymFormalParam Int "n" Nothing),(VarName "res",SymInt 1)], pc = []}) Nothing),
 (Return,SymUnknown (Int,"res",Just (SymInt 0)) [IfBranchingReason [Node_Coor {varDeclAt = 3, varFrame = BR {branchStart = 2, branchEnd = 4}}]])
]
*/
public int ifFun12(int n) {
  int res = 0;
  if(n >= 0) {
    res += 1;
  }
  return res;
}

/////////////////////

/*
SymState {env = fromList [(MethodName "callCallSuccFun",SMethodType Int),(Return,SymInt 6)], pc = []}
*/
public int callCallSuccFun() {
  return callSuccFun(5);
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "succFun",SMethodType Void),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
    (VarName "i",SBin (SymVar Int "i") Add (SymInt 1))
  ], pc = []
}
*/
public void succFun(int i) {
  i += 1;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "callSuccFun",SMethodType Int),
    (FormalParms,SFormalParms ["n"]),
    (VarName "n",SBin (SymVar Int "n") Add (SymInt 1)),
    (Return,SBin (SymVar Int "n") Add (SymInt 1))
  ], pc = []
}
*/
public int callSuccFun(int n) {
  succFun(n);
  return n;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "wrongSum1",SMethodType Int),
    (GlobalVars,SGlobalVars ["w","t","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}}),("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 3, branchEnd = 12}}),("t",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 3, branchEnd = 12}}),("j",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 3, branchEnd = 12}})]),
    (VarName "j",SymUnknown (Int,"j",Just (SymVar Int "w")) [([(For,SR {branchStart = 3, branchEnd = 12})],10)]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 3, branchEnd = 12})],9)]),
    (VarName "w",SymVar Int "w"),
    (ScopeRange (SR {branchStart = 3, branchEnd = 12}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 3},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 3},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 3},Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 10, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "c"}}}), parent = 3},Node {id = 11, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SymInt 0)
  ], pc = []}
*/
public int wrongSum1(int n) {
  int res = 0;
  int j = w;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    res = 0;
    t = i;
    j = c;
  }
  return res;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "wrongSum2",SMethodType Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),
        ("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),
        ("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),
        ("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (VarName "v",SymUnknown (String,"v",Nothing) [
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],8),
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral True)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}
*/
public int wrongSum2(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(true) {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    res = 0;
    t = i;
  }
  return res;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "wrongSum3",SMethodType Int),
    (GlobalVars,SGlobalVars ["t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral False)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}
*/
public int wrongSum3(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(false) {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    res = 0;
    t = i;
  }
  return res;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "wrongSum4",SMethodType Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (VarName "v",SymUnknown (String,"v",Nothing) [
      ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],8),
      ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "v"}, binOp = ==, expr2 = StringLiteral "bye"})), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}
*/
public int wrongSum4(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(v == "bye") {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    res = 0;
    t = i;
  }
  return res;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "wrongSum5",SMethodType Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}}),
        ("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 14}}),
        ("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("t",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 14}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [
        ([(For,SR {branchStart = 2, branchEnd = 14})],4),
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],9)]),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 14})],12)]),
    (VarName "v",SymUnknown (String,"v",Nothing) [
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],8),
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 14}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "v"}, binOp = ==, expr2 = StringLiteral "bye"})), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 13, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 14})],4),([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],9)])
  ], pc = []}
*/
public int wrongSum5(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(v == "bye") {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    t = i;
  }
  return res;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "for1",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)], pc = []}
*/
public int for1(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
  }
  return res;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "for2",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),
        ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),
        ("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [
        ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),
        ([(If,SR {branchStart = 9, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (ScopeRange (SR {branchStart = 9, branchEnd = 11}),SIte (SBin (SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) Mod (SymInt 3)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "for2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) Mul (SymInt 3)),(ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}])], pc = []}) Nothing),
    (Return,SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),([(If,SR {branchStart = 9, branchEnd = 11})],10)])], pc = []}
*/
public int for2(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    if(i % 2 == 0) {
      res += 1;
    }
  }
  if(res % 3 == 0) {
    res *= 3;
  }
  return res;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "sum1",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),("n",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),
    (VarName "n",SymUnknown (Int,"n",Just (SymVar Int "n")) [([(For,SR {branchStart = 2, branchEnd = 6})],5)]),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])], pc = []
}
*/
public int sum1(int n) {
  int res = 0;
  for(; n>0; n--) {
    res += n;
  }
  return res;
}

/////////////////////

/*
SymState {
  env = fromList [
    (MethodName "replicate",SMethodType String),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n","v"]),
    (VarBindings,SVarBindings (fromList [("core",Node_Coor {varDeclAt = 1, varFrame = 0}),("res",Node_Coor {varDeclAt = 2, varFrame = 0})])),
    (VarAssignments,SVarAssignments [("core",Node_Coor {varDeclAt = 1, varFrame = 0}),("res",Node_Coor {varDeclAt = 2, varFrame = 0}),("res",Node_Coor {varDeclAt = 5, varFrame = 3})]),
    (BranchRange (BR {branchStart = 3, branchEnd = 7}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "core"}}}}), parent = 3},Node {id = 6, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (VarName "core",SymFormalParam String "v" Nothing),
    (VarName "n",SymFormalParam Int "n" Nothing),
    (VarName "res",SymUnknown (String,"res",Just (SymString "")) (ForBranchingReason (BR {branchStart = 3, branchEnd = 7}))),
    (VarName "v",SymFormalParam String "v" Nothing),
    (Return,SymUnknown (String,"res",Just (SymString "")) (ForBranchingReason (BR {branchStart = 3, branchEnd = 7})))
  ], pc = []
}
*/
public String replicate(int n,String v) {
  String core = v;
  String res = "";
  for(int i=n; i>0; i--) {
    res += core;
  }
  return res;
}

/////////////////////

/*
[
 (MethodName "manyArrs3",SMethodType (Array Int)),
 (VarBindings,SVarBindings (fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
 (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
 (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]),
 (Return,SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5])
]
*/
public int[] manyArrs3() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  return numbers;
}

/////////////////////

/*
[
 (MethodName "manyArrs4",SMethodType Void),
 (VarBindings,SVarBindings (fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
 (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
 (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]),
 (Actions,SActions ["[99, 0]\n"])
]
*/
public void manyArrs4() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  println(numbers);
}

///////////////////

/*
CFG {nodes = [Entry,Node {id = 1, nodeData = ForInitialization (AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}), parent = 0},Node {id = 2, nodeData = BooleanExpression For (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}), parent = 0},Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 0},Node {id = 4, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = ==, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}), parent = 0},End {id = 5, parent = 4, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})},Node {id = 6, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = ==, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}), parent = 4},End {id = 7, parent = 6, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "not found"})},Node {id = 8, nodeData = Meet If, parent = 4},Node {id = 9, nodeData = Meet If, parent = 0},Node {id = 10, nodeData = ForStep (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 0},Node {id = 11, nodeData = Meet For, parent = 0}], edges = [(0,[1]),(1,[2]),(2,[3]),(3,[4]),(4,[5,6]),(6,[7,8]),(7,[8]),(5,[9]),(8,[9]),(9,[10]),(10,[2]),(2,[11])]}
*/
/*
  Entry
----------
  0 -> 1:
        For: init: Int i = 0.0
----------
  0 -> 2:
        For: cond: i <= y
----------
  0 -> 3:
        Int j = i * i
----------
  0 -> 4:
        If: cond: j == y
----------
  End: return 4 -> 5:
        i
----------
  4 -> 6:
        If: cond: i == y
----------
  End: return 6 -> 7:
        Exception(not found)
----------
  4 -> 8:
        Meet: If
----------
  0 -> 9:
        Meet: If
----------
  0 -> 10:
        For: step: i = i + 1.0
----------
  0 -> 11:
        Meet: For
========================
  (0,[1])
  (1,[2])
  (2,[3])
  (3,[4])
  (4,[5,6])
  (6,[7,8])
  (7,[8])
  (5,[9])
  (8,[9])
  (9,[10])
  (10,[2])
  (2,[11])
*/
public static int sqrt(int y) throws Exception{
  for(int i=0; i<=y; i=i+1){
    int j = i*i;
    if(j==y){
      return i;
    }
    else{
      if(i==y){
	throw new Exception("not found");
      }
      else{}
    }
  }
}

///////////////////////////////////////////////////

public static int sqrt2(int y) throws Exception{
  for(int i=0; i<=y; i++){
    int j = i*i;
    if(j==y){
      return i;
    }
    else{
      if(i==y){
	throw new Exception("not found");
      }
      else{}
    }
  }
}

////////////////////////////////////////////////////

/*
CFG {nodes = [Entry,Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "sum"}, assEright = NumberLiteral 0.0}}), parent = 0},Node {id = 2, nodeData = ForInitialization (AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}), parent = 0},Node {id = 3, nodeData = BooleanExpression For (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}), parent = 0},Node {id = 4, nodeData = BooleanExpression If (BinOpExpr {expr1 = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0}), parent = 0},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = +, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 0},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = -, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 4},Node {id = 7, nodeData = Meet If, parent = 0},Node {id = 8, nodeData = ForStep (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 0},Node {id = 9, nodeData = Meet For, parent = 0},End {id = 10, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "sum"})}], edges = [(0,[1]),(1,[2]),(2,[3]),(3,[4]),(4,[5,6]),(5,[7]),(6,[7]),(7,[8]),(8,[3]),(3,[9]),(9,[10])]}
*/
/*
  Entry
----------
  0 -> 1:
        Int sum = 0.0
----------
  0 -> 2:
        For: init: Int i = 0.0
----------
  0 -> 3:
        For: cond: i < arr.length
----------
  0 -> 4:
        If: cond: arr[i] % 2.0 == 0.0
----------
  0 -> 5:
        sum = sum + arr[i]
----------
  4 -> 6:
        sum = sum - arr[i]
----------
  0 -> 7:
        Meet: If
----------
  0 -> 8:
        For: step: i = i + 1.0
----------
  0 -> 9:
        Meet: For
----------
  End: 0 -> 10:
        return: sum
========================
  (0,[1])
  (1,[2])
  (2,[3])
  (3,[4])
  (4,[5,6])
  (5,[7])
  (6,[7])
  (7,[8])
  (8,[3])
  (3,[9])
  (9,[10])
*/
public int processArray1(int[] arr) {
  int sum = 0;
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] % 2 == 0) {
      sum += arr[i];
    } else {
      sum -= arr[i];
    }
  }
  return sum;
}

//////////////////////////////

/*
CFG {nodes = [Entry,Node {id = 1, nodeData = BooleanExpression While (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = >, expr2 = NumberLiteral 0.0}), parent = 0},Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "a"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = -, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}}}), parent = 0},Node {id = 3, nodeData = Meet While, parent = 0},End {id = 4, parent = 0, mExpr = Just (CondExpr {eiff = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = <, expr2 = NumberLiteral 0.0}, ethenn = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}, eelsee = VarExpr {varType = Nothing, varObj = [], varName = "a"}})}], edges = [(0,[1]),(1,[2]),(2,[1]),(1,[3]),(3,[4])]}
*/
/*
  Entry
----------
  0 -> 1:
        While: cond: a > 0.0
----------
  0 -> 2:
        a = a - b
----------
  0 -> 3:
        Meet: While
----------
  End: 0 -> 4:
        return: a < 0.0 ? a + b : a
========================
  (0,[1])
  (1,[2])
  (2,[1])
  (1,[3])
  (3,[4])
*/
public static int rest(int a, int b) {
  while(a > 0) {
    a -= b;
  }
  return a<0 ? a+b : a;
}

////////////////////

/*
SymState {
  env = fromList [
    (MethodName "isEmpty",SMethodType Bool),
    (VarName "arr",SymFormalParam (Array Int) "arr" Nothing),
    (Return,SBin (SObjAcc ["arr","length"]) Eq (SymInt 0))
  ], pc = []
}
*/
public boolean isEmpty(int[] arr) {
  return arr.length == 0;
}

////////////////////

/*
SymState {
  env = fromList [
    (MethodName "callIsEmpty",SMethodType Bool),
    (Return,SBool True)
  ], pc = []
}
*/
public boolean callIsEmpty() {
  return isEmpty(new int[]{});
}

////////////////////

/*
SymState {
  env = fromList [
    (MethodName "callIsNotEmpty",SMethodType Bool),
    (Return,SBool False)
  ], pc = []
}
*/
public boolean callIsNotEmpty() {
  return isEmpty(new int[]{1,2,3});
}

////////////////////

/*
CFG {nodes = [Entry,Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (VarExpr {varType = Nothing, varObj = [], varName = "size"}), arrElems = []}}}), parent = 0},Node {id = 2, nodeData = ForInitialization (AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}), parent = 0},Node {id = 3, nodeData = BooleanExpression For (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "size"}}), parent = 0},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "elem"}}}), parent = 0},Node {id = 5, nodeData = ForStep (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 0},Node {id = 6, nodeData = Meet For, parent = 0},End {id = 7, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "arr"})}], edges = [(0,[1]),(1,[2]),(2,[3]),(3,[4]),(4,[5]),(5,[3]),(3,[6]),(6,[7])]}
*/
/*
  Entry
----------
  0 -> 1:
        Int[] arr = new Int[size]
----------
  0 -> 2:
        For: init: Int i = 0.0
----------
  0 -> 3:
        For: cond: i < size
----------
  0 -> 4:
        arr[i] = elem
----------
  0 -> 5:
        For: step: i = i + 1.0
----------
  0 -> 6:
        Meet: For
----------
  End: return 0 -> 7:
        arr
========================
  (0,[1])
  (1,[2])
  (2,[3])
  (3,[4])
  (4,[5])
  (5,[3])
  (3,[6])
  (6,[7])
*/
public int[] fillArray(int size, int elem) {
  int[] arr = new int[size];
  for(int i=0; i<size; i++) {
    arr[i] = elem;
  }
  return arr;
}

////////////////////

/*
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Void), varObj = [], varName = "boo34"}, funArgs = [VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "input"}]}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    CondStmt {
      condition = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = ["input"], varName = "length"}, funArgs = []}, binOp = >, expr2 = NumberLiteral 0.0},
      siff = CompStmt {statements = [AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "msg"}, assEright = StringLiteral "non-empty"}},AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "status"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "msg"}}}]},
      selsee = CompStmt {statements = [AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "msg"}, assEright = StringLiteral "empty"}},AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "status"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "msg"}}}]}
    }
  ]}
}
*/
public void boo34(String input){
  if (input.length() > 0) {
    String msg = "non-empty";
    status = msg;
  } else {
    String msg = "empty";
    status = msg;
  }
}

////////////////////

/*
CFG {nodes = [Entry,Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}}}), parent = 0},Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}}}), parent = 0},Node {id = 3, nodeData = BooleanExpression While (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >, expr2 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}}), parent = 0},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "a"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 0},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}}}), parent = 0},Node {id = 6, nodeData = Meet While, parent = 0},End {id = 7, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}], edges = [(0,[1]),(1,[2]),(2,[3]),(3,[4]),(4,[5]),(5,[3]),(3,[6]),(6,[7])]}
*/
/*
  Entry
----------
  0 -> 1:
        Int x = a + b
----------
  0 -> 2:
        Int y = a * b
----------
  0 -> 3:
        While: cond: y > a + b
----------
  0 -> 4:
        a = a + 1.0
----------
  0 -> 5:
        x = a + b
----------
  0 -> 6:
        Meet: While
----------
  End: 0 -> 7:
        return: x
========================
  (0,[1])
  (1,[2])
  (2,[3])
  (3,[4])
  (4,[5])
  (5,[3])
  (3,[6])
  (6,[7])
*/
public int boo35(int a, int b) {
  int x=a+b;
  int y=a*b;
  while (y>a+b) {
    a=a+1;
    x=a+b;
  }
  return x;
}

////////////////////////////

/*
CFG {
  nodes = [
    Entry,
    Node {id = 1, nodeData = TryNode, parent = 0},
    Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "myNumbers"}, assEright = ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 1.0,NumberLiteral 2.0,NumberLiteral 3.0]}}}), parent = 0},
    Node {id = 3, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = ["System","out"], varName = "println"}, funArgs = [ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "myNumbers"}, index = Just (NumberLiteral 10.0)}]}}), parent = 0},
    Node {id = 4, nodeData = CatchNode (AnyType {typee = "Exception", generic = Just (AnyType {typee = "e", generic = Nothing})}), parent = 0},
    Node {id = 5, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = ["System","out"], varName = "println"}, funArgs = [StringLiteral "Something went wrong."]}}), parent = 0},
    Node {id = 6, nodeData = FinallyNode, parent = 0},
    Node {id = 7, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = ["System","out"], varName = "println"}, funArgs = [StringLiteral "The 'try catch' is finished."]}}), parent = 0}
  ],
  edges = [(0,[1]),(1,[2]),(2,[3]),(3,[4]),(4,[5]),(5,[6]),(6,[7])]
}
*/
/*
  Entry
----------
  0 -> 1:
        Try Node
----------
  0 -> 2:
        Int[] myNumbers = {1.0, 2.0, 3.0}
----------
  0 -> 3:
        System.out.println(myNumbers[10.0])
----------
  0 -> 4:
        Catch Node: Exception
----------
  0 -> 5:
        System.out.println(Something went wrong.)
----------
  0 -> 6:
        Finally Node
----------
  0 -> 7:
        System.out.println(The 'try catch' is finished.)
========================
  (0,[1])
  (1,[2])
  (2,[3])
  (3,[4])
  (4,[5])
  (5,[6])
  (6,[7])
*/
public void boo36() {
  try {
    int[] myNumbers = {1, 2, 3};
    System.out.println(myNumbers[10]);
  } catch (Exception e) {
    System.out.println("Something went wrong.");
  } finally {
    System.out.println("The 'try catch' is finished.");
  }
}
