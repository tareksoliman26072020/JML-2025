/*
CFG {
  nodes = [
    Entry,
    End {id = 1, mExpr = Just (NumberLiteral 5.0)}],
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
public int boo21(){
  return 5;
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
public int boo22(){
  return boo21();
}

///////////////////////////////////////////////////

/*
CFG {
  nodes = [
    Entry,
    Node {
      id = 1,
      nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}}}),
      parent = 0
    },
    End {id = 2, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}
  ],
  edges = [(0,[1]),(1,[2])]
}
*/
/*
  Entry
----------
  0 -> 1:
        Int x = boo21()
----------
  End: 0 -> 2:
        x
========================
  (0,[1])
  (1,[2])
*/
public int boo22_2(){
  int x = boo21();
  return x;
}

///////////////////////////////////////////////////

/*
CFG {
  nodes = [
    Entry,
    Node {
      id = 1,
      nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}}}}),
      parent = 0
    },
    End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}],
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
public int boo23(){
  int x = 3 + boo21();
  return x;
}

///////////////////////////////////////////////////

/*
CFG {
  nodes = [
    Entry,
    Node {
      id = 1,
      nodeData = Statement (VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}}),
      parent = 0
    },
    Node {
      id = 2,
      nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}}}}),
      parent = 0
    },
    End {id = 3, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}],
  edges = [(0,[1]),(1,[2]),(2,[3])]
}
*/
/*
  Entry
----------
  0 -> 1:
        Int x
----------
  0 -> 2:
        x = 3.0 + boo21()
----------
  End: 0 -> 3:
        x
========================
  (0,[1])
  (1,[2])
  (2,[3])
*/
public int boo23_2(){
  int x;
  x = 3 + boo21();
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
CFG {
  nodes = [
    Entry,
    Node {id = 1, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}), parent = 0},
    End {id = 2, parent = 1, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "not found"})},
    Node {id = 3, nodeData = Meet If, parent = 0},
    End {id = 4, parent = 0, mExpr = Just (ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})})}
  ],
  edges = [(0,[1]),(1,[2]),(2,[3]),(1,[3]),(3,[4])]
}
*/
/*
  Entry
----------
  0 -> 1:
        If: arr.length <= pos
----------
  End: 1 -> 2:
        Exception(not found)
----------
  0 -> 3:
        Meet: If
----------
  End: 0 -> 4:
        arr[pos]
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
CFG {
  nodes = [
    Entry,
    Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "sum"}, assEright = NumberLiteral 0.0}}), parent = 0},
    Node {id = 2, nodeData = BooleanExpression For (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}), parent = 0},
    Node {id = 3, nodeData = BooleanExpression If (BinOpExpr {expr1 = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0}), parent = 2},
    Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = +, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 3},
    Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = -, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 3},
    Node {id = 6, nodeData = Meet If, parent = 2},
    Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 6},
    Node {id = 8, nodeData = Meet For, parent = 0},
    End {id = 9, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "sum"})}
  ],
  edges = [(0,[1]),(2,[3]),(3,[4,5]),(4,[6]),(5,[6]),(6,[7]),(7,[2]),(2,[8]),(8,[9])]
}
*/
/*
  Entry
----------
  0 -> 1:
        Int sum = 0.0
----------
  0 -> 2:
        For: i < arr.length
----------
  2 -> 3:
        If: arr[i] % 2.0 == 0.0
----------
  3 -> 4:
        sum = sum + arr[i]
----------
  3 -> 5:
        sum = sum - arr[i]
----------
  2 -> 6:
        Meet: If
----------
  6 -> 7:
        i = i + 1.0
----------
  0 -> 8:
        Meet: For
----------
  End: 0 -> 9:
        sum
========================
  (0,[1])
  (2,[3])
  (3,[4,5])
  (4,[6])
  (5,[6])
  (6,[7])
  (7,[2])
  (2,[8])
  (8,[9])
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
