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
    ("i",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)))),
    ("return",SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9)),
    ("x",SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9))
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
    ("boo21_3_i_3",SMethodType Int),
    ("i",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)))),
    ("return",SBin (SBin (SymInt 5) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 20)),
    ("x",SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9))
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
    ("boo21_3_i_4",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 2))))),
    ("x",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 2)))))
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
SymState {
  env = fromList [("i",SymFormalParam Int "i"),("return",SymFormalParam Int "i")],
  pc = []
}
*/
public int boo22_i(int i){
  return boo21_i(i);
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymFormalParam Int "i" Nothing) Add (SymInt 5))
  ], pc = []
}
*/
public int boo22_i_2(int i){
  return boo21_i(i+4) + 1;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2))))
  ], pc = []}
*/
public int boo22_i_3(int i){
  return boo21_3_i(i);
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 6)) Mul (SymInt 5))
  ], pc = []
}
*/
public int boo22_i_4(int i){
  return boo21_3_i(i+4) * 5;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("boo22_i_5",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymFormalParam Int "i" (Just (SBin (SymGlobalVar Int "j" Nothing) Add (SymInt 2))))
  ], pc = []
}
*/
public int boo22_i_5(int i){
  return boo21_3_i(j);
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymFormalParam Int "i" Nothing) Mul (SymInt 2)),
    ("x",SBin (SymFormalParam Int "i" Nothing) Mul (SymInt 2))
  ], pc = []
}
*/
public int boo22_2_i(int i){
  int x = boo21_i(i*2);
  return x;
}

///////////////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("Var Bindings",VarBindings [
        ("j",VarBinding {varDeclAt = 1, varFrame = 0}),
        ("i",VarBinding {varDeclAt = 2, varFrame = 0}),
        ("x",VarBinding {varDeclAt = 3, varFrame = 0})]),
    ("boo22_2_i_2",SMethodType Int),
    ("i",SymInt 9),
    ("j",SymInt 6),
    ("return",SymInt 33),
    ("x",SymInt 18)
  ], pc = []
}
*/
public int boo22_2_i_2(){
  int j = 6;
  int i = 3 + j;
  int x = boo21_i(i*2);
  return x + i + j;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymInt 5),
    ("x",SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)))
  ], pc = []
}
*/
public int boo23_3_i(int i){
  int x = 3 + boo21_i(i+i);
  return 5;
}

///////////////////////////////////////////////////

//SymState {env = fromList [("i",SymInt 4),("return",SymInt 16),("x",SymInt 11)], pc = []}
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

/*SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 8) Add (SymFormalParam Int "i" Nothing))
  ], pc = []
}
*/
public double boo23_7_i(int i){
  return 3+5+i;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 3) Add (SBin (SymInt 5) Mul (SymFormalParam Int "i" Nothing)))
  ], pc = []
}
*/
public int boo23_8_i(int i){
  return 3+5*i;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymInt 5),
    ("x",SymInt 5)
  ], pc = []
}
*/
public int boo23_9_i(int i){
  int x;
  x = 3 + boo21_i(i+2) - i;
  return x;
}

////////////////////////////////////////

/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 5) Add (SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing))),
    ("x",SBin (SymInt 5) Add (SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing)))
  ], pc = []
}
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
    ("i",SymFormalParam Double "i" Nothing),
    ("j",SymFormalParam Double "j" Nothing),
    ("return",SBin (SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing)) Add (SymFormalParam Double "j" Nothing)),
    ("x",SBin (SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing)) Add (SymFormalParam Double "j" Nothing))
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
    ("i",SymFormalParam Double "i" Nothing),
    ("return",SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing)),
    ("x",SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing))
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
CFG {
  nodes = [
    Entry Int "boo23",
    Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}}}}), parent = 0}
    ,End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
  ],
  edges = [(0,[1]),(1,[2])]
}
*/
/*
  Entry
----------
  0 -> 1:
        Int x = 3.0 + boo21()
----------
  End: 0 -> 2:
        x
========================
  (0,[1])
  (1,[2])

*/
//SymState {env = fromList [("return",SymInt 8),("x",SymInt 8)], pc = []}
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
CFG {
  nodes = [
    Entry Int "boo23_9",
    Node {id = 1, nodeData = Statement (VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}}), parent = 0},
    Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}}}}), parent = 0},
    End {id = 3, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
  ],
  edges = [(0,[1]),(1,[2]),(2,[3])]
}
*/
//SymState {env = fromList [("return",SymInt 8),("x",SymInt 8)], pc = []}
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
CFG {
  nodes = [
    Entry,
    Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo25"}, funArgs = [NumberLiteral 5.0]}}}}), parent = 0},
    End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
  ],
  edges = [(0,[1]),(1,[2])]
}
*/
/*
  Entry
----------
  0 -> 1:
        Int x = 3.0 + boo25(5.0)
----------
  End: 0 -> 2:
        x
========================
  (0,[1])
  (1,[2])
*/
public int boo24(){
  int x = 3 + boo25(5);
  return x;
}

///////////////////////////////////////////////////

/*
CFG {
  nodes = [
    Entry,
    Node {id = 1, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 10.0}), parent = 0},
    End {id = 2, parent = 1, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "meow"})},
    End {id = 3, parent = 1, mExpr = Just (NumberLiteral 6.0)},
    Node {id = 4, nodeData = Meet If, parent = 0}
  ],
  edges = [(0,[1]),(1,[2,3]),(2,[4]),(3,[4])]
}
*/
/*
  Entry
----------
  0 -> 1:
        If: i > 10.0
----------
  End: 1 -> 2:
        Exception(meow)
----------
  End: 1 -> 3:
        6.0
----------
  0 -> 4:
        Meet: If
========================
  (0,[1])
  (1,[2,3])
  (2,[4])
  (3,[4])
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
    ("1",SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
              (SymState {env = fromList [("boo27",SMethodType Int),("i",SymFormalParam Int "i" Nothing),("return",SymFormalParam Int "i" Nothing)], pc = []})
              (Just (SymState {env = fromList [("Var Bindings",VarBindings [("res",VarBinding {varDeclAt = 3, varFrame = 1})]),("boo27",SMethodType Int),("i",SymFormalParam Int "i" Nothing),("res",SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing)),("return",SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing))], pc = []}))),
    ("boo27",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing)
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
SymState {
  env = fromList [
    ("2",SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0)) (SymState {env = fromList [("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),("boo28",SMethodType Int),("i",SymFormalParam Int "i" Nothing),("return",SymFormalParam Int "i" Nothing),("x",SymInt 2)], pc = []}) Nothing),
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),
    ("boo28",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymInt 5),
    ("x",SymInt 1)
  ], pc = []
}
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
SymState {
  env = fromList [
    ("2",SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0)) (SymState {env = fromList [("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 4, varFrame = 2})]),("boo28_2",SMethodType Int),("i",SymFormalParam Int "i" Nothing),("return",SymFormalParam Int "i" Nothing),("x",SymInt 2),("y",SymInt 0)], pc = []}) Nothing),
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),
    ("boo28_2",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymInt 5),
    ("x",SymInt 1)
  ], pc = []
}
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
SymState {
  env = fromList [
    (MethodName "boo30",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x1",VarBinding {varDeclAt = 1, varFrame = 0}),("x2",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "x1",SymInt 0),
    (VarName "x2",SymInt 0),
    (VarName "y",SymGlobalVar Int "y" (Just (SymInt 0))),
    (VarName "y1",SymGlobalVar Int "y1" (Just (SymInt 0))),
    (VarName "y2",SymGlobalVar Int "y2" (Just (SymInt 0))),
    (VarName "z",SymFormalParam Int "z" Nothing),
    (NodeNr 6,SIte (SBin (SymFormalParam Int "z" Nothing) Ge (SymInt 0))
                   (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(VarBindings,SVarBindings (fromList [("x1",VarBinding {varDeclAt = 1, varFrame = 0}),("x2",VarBinding {varDeclAt = 2, varFrame = 0})])),(VarName "t1",SymGlobalVar Int "t1" (Just (SymInt 7))),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymGlobalVar Int "y" (Just (SymInt 0))),(VarName "y1",SymGlobalVar Int "y1" (Just (SymInt 0))),(VarName "y2",SymGlobalVar Int "y2" (Just (SymInt 0))),(VarName "z",SymFormalParam Int "z" Nothing),(Return,SymGlobalVar Int "t1" (Just (SymInt 7)))], pc = []})
                   (Just (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(VarBindings,SVarBindings (fromList [("x1",VarBinding {varDeclAt = 1, varFrame = 0}),("x2",VarBinding {varDeclAt = 2, varFrame = 0})])),(VarName "t2",SymGlobalVar Int "t2" (Just (SymInt 17))),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymGlobalVar Int "y" (Just (SymInt 0))),(VarName "y1",SymGlobalVar Int "y1" (Just (SymInt 0))),(VarName "y2",SymGlobalVar Int "y2" (Just (SymInt 0))),(VarName "z",SymFormalParam Int "z" Nothing),(Return,SymGlobalVar Int "t2" (Just (SymInt 17)))], pc = []})))
  ], pc = []
}
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
SymState {
  env = fromList [
    (MethodName "boo31",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "x",SymGlobalVar Int "z" (Just (SymInt 0))),
    (VarName "z",SymGlobalVar Int "z" (Just (SymInt 0))),
    (Return,SymGlobalVar Int "z" (Just (SymInt 0)))
  ], pc = []
}
*/
public int boo31(){
  z = 0;
  int x = z;
  return x;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo31_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "x",SymGlobalVar Int "z" (Just (SymInt 0))),
    (VarName "z",SymGlobalVar Int "z" (Just (SymInt 0))),
    (Return,SymInt 7)
  ], pc = []
}
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
SymState {
  env = fromList [
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0}),
                                 ("y",VarBinding {varDeclAt = 2, varFrame = 0})]),
    ("boo33_5",SMethodType Double),
    ("return",SymDouble 1.1),
    ("x",SymDouble 1.1),
    ("y",SymNull Int)
  ], pc = []
}
*/
public double boo33_5(){
  double x = 1;
  int y;
  x = x + 0.1;
  return x;
}

///////////////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "elemAt",SMethodType (Array Int)),
    (VarName "arr",SymFormalParam (Array Int) "arr" Nothing),
    (VarName "pos",SymFormalParam Int "pos" Nothing),
    (NodeNr 1,SIte (SBin (SObjAcc ["arr","length"]) Le (SymFormalParam Int "pos" Nothing)) 
                   (SymState {env = fromList [(MethodName "elemAt",SMethodType (Array Int)),(VarName "arr",SymFormalParam (Array Int) "arr" Nothing),(VarName "pos",SymFormalParam Int "pos" Nothing),(Return,SException "Exception" "not found")], pc = []})
                   Nothing),
    (Return,SArrayIndexAccess "arr" (SymFormalParam Int "pos" Nothing))
  ], pc = []
}
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
    (MethodName "strFun",SMethodType String),
    (VarBindings,SVarBindings (fromList [("firstName",VarBinding {varDeclAt = 1, varFrame = 0}),("lastName",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "firstName",SymString "Tarek"),
    (VarName "lastName",SymString "Soliman"),
    (Return,SymString "Tarek Soliman")
  ], pc = []
}
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
SymState {
  env = fromList [
    (MethodName "voidFun3",SMethodType Void),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 2, varFrame = 0}),("z",VarBinding {varDeclAt = 5, varFrame = 0})])),
    (VarName "x",SymInt 1),
    (VarName "y",SymString "is one"),
    (VarName "z",SymString "1 is one")
  ], pc = []
}
*/
public void voidFun3() {
  int x;
  String y;
  x = 1;
  y = "is one";
  String z = toString(x) + " " + y;
}

////////////////////////////////////////

//TODO
public void manyArrs() {
  int[] numbers1 = new int[7];
  int[] numbers2 = {40, 55, 63, 17, 22};
  int[] numbers3;
  numbers3 = new int[5];
  String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
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
}

///////////////////////////////////////////////////

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
CFG {
  nodes = [
    Entry,
    End {id = 1, parent = 0, mExpr = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = ==, expr2 = NumberLiteral 0.0})}
  ],
  edges = [(0,[1])]
}
*/
/*
  Entry
----------
  End: 0 -> 1:
        arr.length == 0.0
========================
  (0,[1])
*/
public boolean isEmpty(int[] arr) {
  return arr.length == 0;
}

/*
CFG {
  nodes = [
    Entry,
    End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "isEmpty"}, funArgs = [ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = []}]})}
  ],
  edges = [(0,[1])]
}
*/
/*
  Entry
----------
  End: 0 -> 1:
        isEmpty(new Int[]{})
========================
  (0,[1])
*/
public boolean callIsEmpty() {
  return isEmpty(new int[]{});
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
