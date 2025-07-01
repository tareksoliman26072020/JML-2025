public int boo21(){
  return 5;
}

///////////////////////////////////////////////////

public float boo21_2(){
  return 5.4;
}

///////////////////////////////////////////////////

public int boo22(){
  return boo21();
}

///////////////////////////////////////////////////

public int boo22_2(){
  int x = boo21();
  return x;
}

///////////////////////////////////////////////////

public int boo23(){
  int x = 3 + boo21();
  return x;
}

///////////////////////////////////////////////////

/*
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "boo23_2"}, funArgs = []}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}},
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}}}},
    ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}]
  }
}
*/
public int boo23_2(){
  int x;
  x = 3 + boo21();
  return x;
}

///////////////////////////////////////////////////

public int boo24(){
  int x = 3 + boo25(5);
  return x;
}

///////////////////////////////////////////////////

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
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "boo28"}, funArgs = []}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    TryCatchStmt {
      tryBody = CompStmt {statements = [AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 3.0}},CondStmt {condition = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = ==, expr2 = NumberLiteral 3.0}, siff = CompStmt {statements = [ReturnStmt {returnS = Just (ExcpExpr {excpName = Exception, excpmsg = Just "something"})}]}, selsee = CompStmt {statements = [ReturnStmt {returnS = Just (NumberLiteral 1.0)}]}}]},
      catchExcp = AnyType {typee = "Exception", generic = Just (AnyType {typee = "e", generic = Nothing})},
      catchBody = CompStmt {statements = [ReturnStmt {returnS = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo27"}, funArgs = [NumberLiteral 5.0]})}]},
      finallyBody = CompStmt {statements = []}
    }
  ]}
}
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

/*
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "boo33_3"}, funArgs = []}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}},
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}}},
    ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}]
  }
}
*/
public double boo33_3(){
  double x = 1;
  x+=0.1;
  return x;
}

///////////////////////////////////////////////////

/*
FunDef {
    funModifier = [Public],
    isPureFlag = False,
    funDecl = FunCallStmt {
        funCall = FunCallExpr {
            funName = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "elemAt"},
            funArgs = [
                VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"},
                VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}
            ]
        }
    },
    throws = Nothing,
    funBody = CompStmt {statements = [
        CondStmt {
            condition = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}},
            siff = CompStmt {statements = [ReturnStmt {returnS = Just (ExcpExpr {excpName = Exception, excpmsg = Just "not found"})}]},
            selsee = CompStmt {statements = []}},
        ReturnStmt {returnS = Just (ArrayExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})})
        }
    ]}
}
*/
public int[] elemAt(int[] arr, int pos){
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
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
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "processArray1"}, funArgs = [VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}]}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "sum"}, assEright = NumberLiteral 0.0}},
    ForStmt {
      acc = AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}},
      cond = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}},
      step = AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}},
      forBody = CompStmt {statements = [
        CondStmt {
          condition = BinOpExpr {expr1 = BinOpExpr {expr1 = ArrayExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0},
          siff = CompStmt {statements = [
            AssignStmt {
              varModifier = [],
              assign = AssignExpr {
                assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"},
                assEright = BinOpExpr {
                  expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"},
                  binOp = +,
                  expr2 = ArrayExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})
                  }
                }
              }
            }]
          },
          selsee = CompStmt {statements = [
            AssignStmt {
              varModifier = [],
              assign = AssignExpr {
                assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"},
                assEright = BinOpExpr {
                  expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"},
                  binOp = -,
                  expr2 = ArrayExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})
                  }
                }
              }
            }]
          }}
      ]}
    },
    ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "sum"})}]
  }
}
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
FunDef {
  funModifier = [Public,Static],
  isPureFlag = False,
  funDecl = FunCallStmt {
    funCall = FunCallExpr {
      funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "rest"},
      funArgs = [
        VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "a"},
        VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "b"}
      ]
    }
  },
  throws = Nothing,
  funBody = CompStmt {statements = [
    WhileStmt {
      condition = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = >, expr2 = NumberLiteral 0.0},
      whileBody = CompStmt {statements = [
        AssignStmt {
          varModifier = [],
          assign = AssignExpr {
            assEleft = VarExpr {varType = Nothing, varObj = [], varName = "a"},
            assEright = BinOpExpr {
              expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"},
              binOp = -,
              expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}
            }
          }
        }
      ]
      }},
    ReturnStmt {
      returnS = Just (
        CondExpr {
          eiff = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = <, expr2 = NumberLiteral 0.0},
          ethenn = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}},
          eelsee = VarExpr {varType = Nothing, varObj = [], varName = "a"}
        }
      )
    }
  ]}
}
*/
public static int rest(int a, int b) {
  while(a > 0) {
    a -= b;
  }
  return a<0 ? a+b : a;
}

////////////////////

/*
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Boolean), varObj = [], varName = "isEmpty"}, funArgs = [VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}]}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    ReturnStmt {returnS = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = ==, expr2 = NumberLiteral 0.0})}
  ]
  }
}
*/
public boolean isEmpty(int[] arr) {
  return arr.length == 0;
}

/*
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Boolean), varObj = [], varName = "callIsEmpty"}, funArgs = []}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    ReturnStmt {
      returnS = Just (
        FunCallExpr {
          funName = VarExpr {varType = Nothing, varObj = [], varName = "isEmpty"},
          funArgs = [
            ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = []}
          ]
        })
    }
  ]}
}
*/
public boolean callIsEmpty() {
  return isEmpty(new int[]{});
}

////////////////////

/*
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "fillArray"}, funArgs = [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "size"},VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "elem"}]}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (VarExpr {varType = Nothing, varObj = [], varName = "size"}), arrElems = []}}},
    ForStmt {acc = AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}, cond = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "size"}}, step = AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}, forBody = CompStmt {statements = [AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "elem"}}}]}},
    ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "arr"})}
  ]}
}
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
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "boo35"}, funArgs = [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "a"},VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "b"}]}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}}},
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}}},
    WhileStmt {condition = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >, expr2 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}}, whileBody = CompStmt {statements = [AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "a"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = NumberLiteral 1.0}}},AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}}}}]}
    },
    ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
  ]}
}
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
