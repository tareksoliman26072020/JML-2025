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
    ("return",SBin (SymInt 2) Mul (SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)))))
  ], pc = []
}
*/
public int boo21_3_i_1(int i){
  i += 2;
  return i+i;
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
    ("i",SymInt 9),
    ("j",SymInt 6),
    ("return",SymInt 33),
    ("x",SymInt 18)
  ],
  pc = []
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
    ("return",SBin (SBin (SymInt 5) Add (SymFormalParam Int "i" Nothing)) Sub (SymFormalParam Int "i" Nothing)),
    ("x",SBin (SBin (SymInt 5) Add (SymFormalParam Int "i" Nothing)) Sub (SymFormalParam Int "i" Nothing))
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
SymState {env = fromList [("return",SymInt 5),("x",SymInt 8)], pc = []}
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

//SymState {env = fromList [("return",SymInt 9),("x",SymInt 9)], pc = []}
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
public int boo26(){
  return boo27(5);
}
public int boo26_2(){
  return boo27(-1);
}

///////////////////////////////////////////////////

/*
CFG {
  nodes = [
    Entry,
    Node {id = 1, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}), parent = 0},
    End {id = 2, parent = 1, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})},
    Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = NumberLiteral (-1.0), binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 1},
    End {id = 4, parent = 1, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "res"})},
    Node {id = 5, nodeData = Meet If, parent = 0}
  ],
  edges = [(0,[1]),(1,[2,3]),(3,[4]),(2,[5]),(4,[5])]
}
*/
/*
  Entry
----------
  0 -> 1:
        If: i >= 0.0
----------
  End: 1 -> 2:
        i
----------
  1 -> 3:
        Int res = -1.0 * i
----------
  End: 1 -> 4:
        res
----------
  0 -> 5:
        Meet: If
========================
  (0,[1])
  (1,[2,3])
  (3,[4])
  (2,[5])
  (4,[5])
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
public int boo28(){
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

public int boo28_2(){
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
CFG {nodes = [Entry,Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x1"}, assEright = NumberLiteral 0.0}}), parent = 0},Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x2"}, assEright = NumberLiteral 0.0}}), parent = 0},Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}}), parent = 0},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, assEright = NumberLiteral 0.0}}), parent = 0},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y2"}, assEright = NumberLiteral 0.0}}), parent = 0},Node {id = 6, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "z"}, binOp = >=, expr2 = NumberLiteral 0.0}), parent = 0},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t1"}, assEright = NumberLiteral 7.0}}), parent = 0},End {id = 8, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "t1"})},Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t2"}, assEright = NumberLiteral 17.0}}), parent = 6},End {id = 10, parent = 6, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "t2"})},Node {id = 11, nodeData = Meet If, parent = 0}], edges = [(0,[1]),(1,[2]),(2,[3]),(3,[4]),(4,[5]),(5,[6]),(6,[7,9]),(7,[8]),(9,[10]),(8,[11]),(10,[11])]}
*/
/*
  Entry
----------
  0 -> 1:
        Int x1 = 0.0
----------
  0 -> 2:
        Int x2 = 0.0
----------
  0 -> 3:
        y = 0.0
----------
  0 -> 4:
        y1 = 0.0
----------
  0 -> 5:
        y2 = 0.0
----------
  0 -> 6:
        If: cond: z >= 0.0
----------
  0 -> 7:
        t1 = 7.0
----------
  End: 0 -> 8:
        return: t1
----------
  6 -> 9:
        t2 = 17.0
----------
  End: 6 -> 10:
        return: t2
----------
  0 -> 11:
        Meet: If
========================
  (0,[1])
  (1,[2])
  (2,[3])
  (3,[4])
  (4,[5])
  (5,[6])
  (6,[7,9])
  (7,[8])
  (9,[10])
  (8,[11])
  (10,[11])
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

public int boo31(){
  z = 0;
  int x = z;
  return x;
}

///////////////////////////////////////////////////

public int boo31_2(){
  z = 0;
  int x = z;
  return boo30(1);
}

///////////////////////////////////////////////////

/*
CFG {nodes = [Entry,Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y2"}}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y3"}}}}), parent = 0},End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}], edges = [(0,[1]),(1,[2])]}
*/
/*
  Entry
----------
  0 -> 1:
        Int x = y1 + y2 + y3
----------
  End: 0 -> 2:
        return: x
========================
  (0,[1])
  (1,[2])
*/
/*
env_final = 
  { "y1" ↦ SVar "y1₀"
  , "y2" ↦ SVar "y2₀"
  , "y3" ↦ SVar "y3₀"
  , "x"  ↦ SBin Add (SBin Add (SVar "y1₀") (SVar "y2₀")) (SVar "y3₀")
  }
pc_final = []
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

//SymState {env = fromList [("return",SymDouble 1.1),("x",SymDouble 1.1),("y",SymNull Int)], pc = []}
public double boo33_5(){
  double x = 1;
  int y;
  x = x + 0.1;
  return x;
}

///////////////////////////////////////////////////

/*
CFG {nodes = [Entry,Node {id = 1, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}), parent = 0},End {id = 2, parent = 0, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "not found"})},Node {id = 3, nodeData = Meet If, parent = 0},End {id = 4, parent = 0, mExpr = Just (ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})})}], edges = [(0,[1]),(1,[2]),(2,[3]),(1,[3]),(3,[4])]}
*/
/*
  Entry
----------
  0 -> 1:
        If: cond: arr.length <= pos
----------
  End: 0 -> 2:
        return: Exception(not found)
----------
  0 -> 3:
        Meet: If
----------
  End: 0 -> 4:
        return: arr[pos]
========================
  (0,[1])
  (1,[2])
  (2,[3])
  (1,[3])
  (3,[4])
*/
public int[] elemAt(int[] arr, int pos){
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
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
