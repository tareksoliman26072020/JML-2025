/*
Scope {outsiderVars = [], size = 1, vars = [], scopes = []}
*/
/*
{1
}
*/

public int boo21(){
  return 5;
}

///////////////////////////////////////////////////

/*
Scope {outsiderVars = [], size = 1, vars = [], scopes = []}
*/
/*
{1
}
*/
public float boo21_2(){
  return 5.4;
}

///////////////////////////////////////////////////

/*
Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "x", varType = Just Int, val = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []})})], scopes = []}
*/
/*
{2
    Vars:
      1: Int x
}
*/
public int boo22_2(){
  int x = boo21();
  return x;
}

///////////////////////////////////////////////////

/*
Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "x", varType = Just Int, val = Just (BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}})})], scopes = []}
*/
/*
{2
    Vars:
      1: Int x
}
*/
public int boo23(){
  int x = 3 + boo21();
  return x;
}

///////////////////////////////////////////////////

/*
Scope {
  outsiderVars = [],
  size = 3,
  vars = [
    (1,Variable {name = "x", varType = Just Int, val = Nothing}),
    (2,Variable {name = "x", varType = Nothing, val = Just (BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}})})
  ],
  scopes = []
}
*/
/*
{3
    Vars:
      1: Int x
      2: x
}
*/
public int boo23_2(){
  int x;
  x = 3 + boo21();
  return x;
}

///////////////////////////////////////////////////

/*
Scope {outsiderVars = [Variable {name = "i", varType = Just Int, val = Nothing}], size = 2, vars = [], scopes = [(1,If,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(2,Else,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "res", varType = Just Int, val = Just (BinOpExpr {expr1 = NumberLiteral (-1.0), binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}})})], scopes = []})]}
*/
/*
{2
    Outsider Vars:
      Int i
    1: If scope: {1
    }
    2: Else scope: {2
        Vars:
          1: Int res
    }
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
Scope {outsiderVars = [], size = 3, vars = [], scopes = [(1,Try,Scope {outsiderVars = [], size = 3, vars = [(1,Variable {name = "x", varType = Just Int, val = Just (NumberLiteral 3.0)})], scopes = [(2,If,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(3,Else,Scope {outsiderVars = [], size = 1, vars = [], scopes = []})]}),(2,Catch,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(3,Finally,Scope {outsiderVars = [], size = 0, vars = [], scopes = []})]}
*/
/*
{3
    1: Try scope: {3
        Vars:
          1: Int x
        2: If scope: {1
        }
        3: Else scope: {1
        }
    }
    2: Catch scope: {1
    }
    3: Finally scope: {0
    }
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

/*
Scope {outsiderVars = [Variable {name = "z", varType = Just Int, val = Nothing}], size = 7, vars = [(1,Variable {name = "x1", varType = Just Int, val = Just (NumberLiteral 0.0)}),(2,Variable {name = "x2", varType = Just Int, val = Just (NumberLiteral 0.0)}),(3,Variable {name = "y", varType = Nothing, val = Just (NumberLiteral 0.0)}),(4,Variable {name = "y1", varType = Nothing, val = Just (NumberLiteral 0.0)}),(5,Variable {name = "y2", varType = Nothing, val = Just (NumberLiteral 0.0)})], scopes = [(6,If,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "t1", varType = Nothing, val = Just (NumberLiteral 7.0)})], scopes = []}),(7,Else,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "t2", varType = Nothing, val = Just (NumberLiteral 17.0)})], scopes = []})]}
*/
/*
{7
    Outsider Vars:
      Int z
    Vars:
      1: Int x1
      2: Int x2
      3: y
      4: y1
      5: y2
    6: If scope: {2
        Vars:
          1: t1
    }
    7: Else scope: {2
        Vars:
          1: t2
    }
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
Scope {outsiderVars = [Variable {name = "arr", varType = Just (Array Int), val = Nothing},Variable {name = "pos", varType = Just Int, val = Nothing}], size = 3, vars = [], scopes = [(1,If,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(2,Else,Scope {outsiderVars = [], size = 0, vars = [], scopes = []})]}
*/
/*
{3
    Outsider Vars:
      Int[] arr
      Int pos
    1: If scope: {1
    }
    2: Else scope: {0
    }
}
*/
public int[] elemAt(int[] arr, int pos){
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}
