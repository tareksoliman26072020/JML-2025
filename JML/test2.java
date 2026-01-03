/*
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "sum1"}, funArgs = [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]}},
  throws = Nothing,
  funBody = CompStmt {
    statements = [
      AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}},
      ForStmt {acc = AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}, cond = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0}, step = AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}}, forBody = CompStmt {statements = [AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}]}},
      ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "res"})}
    ]
  }
}
*/
public int sum1(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    res += i;
  }
  return res;
}
