/*
FunDef {
  funModifier = [Public], 
  isPureFlag = False, 
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "boo21"}, funArgs = []}}, 
  throws = Nothing, 
  funBody = CompStmt {
    statements = [ReturnStmt {returnS = Just (IntLiteral 5)}]
  }
}

public int boo21(){
  return 5;
}
*/

///////////////////////////////////////////////////

/*
FunDef {
  funModifier = [Public], 
  isPureFlag = False, 
  funDecl = FunCallStmt {
    funCall = FunCallExpr {
      funName = VarExpr {
        varType = Just (BuiltInType Int),
          varObj = [], 
          varName = "boo22"
      },
      funArgs = []
    }
  }, 
  throws = Nothing, 
  funBody = CompStmt {
    statements = [
      ReturnStmt {
        returnS = Just (
          FunCallExpr {
            funName = VarExpr {
              varType = Nothing, 
              varObj = [], 
              varName = "boo21"
            }, funArgs = []
          }
        )
      }
    ]
  }
}

public int boo22(){
  return boo21();
}
*/

///////////////////////////////////////////////////

/*
FunDef {
  funModifier = [Public], 
  isPureFlag = False, 
  funDecl = FunCallStmt {
    funCall = FunCallExpr {
      funName = VarExpr {
        varType = Just (BuiltInType Int),
         varObj = [], 
         varName = "boo22_2"
      },
      funArgs = []
    }
  }, 
  throws = Nothing, 
  funBody = CompStmt {
    statements = [
      AssignStmt {
        varModifier = [], 
        assign = AssignExpr {
          assEleft = VarExpr {varType = Just (BuiltInType Int),varObj = [],varName = "x"},
          assEright = FunCallExpr {
            funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"},
            funArgs = []
          }
        }
      },
      ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
    ]
  }
}

public int boo22_2(){
  int x = boo21();
  return x;
}
*/

///////////////////////////////////////////////////

/*
FunDef {
  funModifier = [Public], 
  isPureFlag = False, 
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "boo23"}, funArgs = []}},
   throws = Nothing, 
   funBody = CompStmt {
     statements = [
       AssignStmt {
         varModifier = [], 
         assign = AssignExpr {
           assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"},
           assEright = BinOpExpr {
             expr1 = IntLiteral 3, 
             binOp = +,
             expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}
           }
         }
       },
       ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
     ]
   }
}

public int boo23(){
  int x = 3 + boo21();
  return x;
}
*/

///////////////////////////////////////////////////

/*
FunDef {
  funModifier = [Public], 
  isPureFlag = False, 
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "boo24"}, funArgs = []}}, 
  throws = Nothing, 
  funBody = CompStmt {
    statements = [
      AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = IntLiteral 3, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo25"}, funArgs = [IntLiteral 5]}}}},
      ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
    ]
  }
}

public int boo24(){
  int x = 3 + boo25(5);
  return x;
}
*/

///////////////////////////////////////////////////

public int boo25(int i){
  if(i>10){
    throw new Exception("meow");
  }
  else{
    return 6;
  }
}

///////////////////////////////////////////////////

public int boo26(){
  return boo27(5);
}

///////////////////////////////////////////////////

public int boo26_2(){
  return boo27(-1);
}

///////////////////////////////////////////////////

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

///////////////////////////////////////////////////

public boolean boo29(){
  if(true){
    return false;
  }
  else{
    return true;
  }
}

///////////////////////////////////////////////////

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

public int boo32(){
  int x = y1 + y2 + y3;
  return x;
}

///////////////////////////////////////////////////

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
