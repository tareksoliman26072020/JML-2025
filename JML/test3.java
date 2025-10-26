//DONE
public int boo21(){
  return 5;
}

////////////////////////////////////////

//DONE
public int boo21_2(){
  int i;
  return 5;
}

////////////////////////////////////////

//DONE
public int boo22(){
  return boo21();
}

////////////////////////////////////////

//DONE
public int boo22_2(){
  int x = boo21();
  return x;
}

////////////////////////////////////////

//DONE
public int boo23_3(){
  int x = 3 + boo21();
  return 5;
}

////////////////////////////////////////

//DONE
public int boo23_4(){
  return 3 + boo21();
}

////////////////////////////////////////

//DONE
public int boo23_5(){
  return 8;
}

////////////////////////////////////////

//DONE
public double boo23_6(){
  return 8;
}

////////////////////////////////////////

//DONE
public double boo23_7(){
  return 3+5;
}

////////////////////////////////////////

//DONE
public int boo23_8(){
  return 3+5;
}

////////////////////////////////////////

//DONE
public int boo23_9(){
  int x;
  x = 3 + boo21();
  return x;
}

////////////////////////////////////////

//DONE
public int boo23_10(){
  int x = 3+5;
  return x;
}

////////////////////////////////////////

//DONE
public int boo23_11(){
  int x = 3+5;
  x = 10-1;
  return x;
}

////////////////////////////////////////

//DONE
public int boo23_12(){
  int x = 3 + boo21();
  return x;
}

////////////////////////////////////////

//DONE
public double boo33_3(){
  double x = 1;
  x+=0.1;
  return x;
}

////////////////////////////////////////

//DONE
public double boo33_4(){
  double x = 1;
  x = x + 0.1;
  return x;
}

////////////////////////////////////////

//DONE
public double boo33_5(){
  double x = 1;
  int y;
  x = x + 0.1;
  return x;
}

////////////////////////////////////////






















//DONE
public int boo21_i(int i){
  return i;
}

////////////////////////////////////////

//DONE
public int boo21_2_i(int i){
  i = 5;
  return i;
}

////////////////////////////////////////

//DONE
public int boo21_3_i(int i){
  i += 2;
  return i;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymFormalParam Int "i" Nothing)
  ], pc = []
}
*/
public int boo22_i(int i){
  return boo21_i(i);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 4)) Add (SymInt 1))
  ], pc = []
}
*/
public int boo22_i_2(int i){
  return boo21_i(i+4) + 1;
}

////////////////////////////////////////

//TODO
public int boo22_i_3(int i){
  return boo21_3_i(i+4) * 5;
}

////////////////////////////////////////

//TODO
public int boo22_2_i(int i){
  int x = boo21_i(i*2);
  return x;
}

////////////////////////////////////////

//TODO
/*
FunCallExpr {
  funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"},
  funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}]
}
*/
public int boo23_3_i(int i){
  int x = 3 + boo21_i(i+i);
  return 5;
}

////////////////////////////////////////

//TODO
/*
FunCallExpr {
  funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "boo23_4_i"},
  funArgs = [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]
}
*/
/*
FunCallExpr {
  funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"},
  funArgs = [NumberLiteral 0.0]
}
*/
public int boo23_4_i(int i){
  return 3 + boo21_i(0);
}

////////////////////////////////////////

//TODO
public int boo23_5_i(int i){
  return 8;
}

////////////////////////////////////////

//TODO
public double boo23_6_i(int i){
  return 8;
}

////////////////////////////////////////

//TODO
public double boo23_7_i(int i){
  return 3+5+i;
}

////////////////////////////////////////

//TODO
public int boo23_8_i(int i){
  return 3+5*i;
}

////////////////////////////////////////

//TODO
public int boo23_9_i(int i){
  int x;
  x = 3 + boo21_i(i+2) - i;
  return x;
}

////////////////////////////////////////

//TODO
public int boo23_10_i(int i){
  int x = 3+5+i;
  return x;
}

////////////////////////////////////////

//TODO
public int boo23_11_i(int i){
  int x = 3+5;
  x = 10-1;
  return x*i;
}

////////////////////////////////////////

//TODO
public int boo23_12_i(int i){
  int x = 3 + boo21_i(i);
  return x;
}

////////////////////////////////////////

//TODO
public double boo33_3_i(int i){
  double x = 1 + i;
  x+=0.1;
  return x;
}

////////////////////////////////////////

//TODO
public double boo33_4_i(int i, int j){
  double x = 1 + i;
  x = x + 0.1 + j;
  return x;
}



























//TODO
public int boo24(){
  int x = 3 + boo25(5);
  return x;
}

////////////////////////////////////////

//TODO
public int boo25(int i){
  if(i>10){
    throw new Exception("meow");
  }
  else{
    return 6;
  }
}

////////////////////////////////////////

//TODO
public int boo26(){
  return boo27(5);
}

////////////////////////////////////////

//TODO
public int boo26_2(){
  return boo27(-1);
}

////////////////////////////////////////

//TODO
/*
CFG {
  nodes = [
    Entry Int "boo27",
    Node {id = 1, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}), parent = 0},
    End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})},
    Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = NumberLiteral (-1.0), binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 1},
    End {id = 4, parent = 1, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "res"})},
    Node {id = 5, nodeData = Meet If, parent = 0}
  ],
  edges = [(0,[1]),(1,[2,3]),(3,[4]),(2,[5]),(4,[5])]
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
