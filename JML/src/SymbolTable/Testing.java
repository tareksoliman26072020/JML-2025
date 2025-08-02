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
Scope {outsiderVars = [Variable {name = "i", varType = Just Int, val = Nothing}], size = 1, vars = [], scopes = [(1,If,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(1,Else,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "res", varType = Just Int, val = Just (BinOpExpr {expr1 = NumberLiteral (-1.0), binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}})})], scopes = []})]}
*/
/*
{1
    Outsider Vars:
      Int i
    1: If scope: {1
    }
    1: Else scope: {2
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
Scope {outsiderVars = [], size = 2, vars = [], scopes = [(1,Try,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "x", varType = Just Int, val = Just (NumberLiteral 3.0)})], scopes = [(2,If,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(2,Else,Scope {outsiderVars = [], size = 1, vars = [], scopes = []})]}),(1,Catch,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(1,Finally,Scope {outsiderVars = [], size = 0, vars = [], scopes = []})]}
*/
/*
{2
    1: Try scope: {2
        Vars:
          1: Int x
        2: If scope: {1
        }
        2: Else scope: {1
        }
    }
    1: Catch scope: {1
    }
    1: Finally scope: {0
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
Scope {outsiderVars = [Variable {name = "z", varType = Just Int, val = Nothing}], size = 6, vars = [(1,Variable {name = "x1", varType = Just Int, val = Just (NumberLiteral 0.0)}),(2,Variable {name = "x2", varType = Just Int, val = Just (NumberLiteral 0.0)}),(3,Variable {name = "y", varType = Nothing, val = Just (NumberLiteral 0.0)}),(4,Variable {name = "y1", varType = Nothing, val = Just (NumberLiteral 0.0)}),(5,Variable {name = "y2", varType = Nothing, val = Just (NumberLiteral 0.0)})], scopes = [(6,If,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "t1", varType = Nothing, val = Just (NumberLiteral 7.0)})], scopes = []}),(6,Else,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "t2", varType = Nothing, val = Just (NumberLiteral 17.0)})], scopes = []})]}
*/
/*
{6
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
    6: Else scope: {2
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
Scope {outsiderVars = [Variable {name = "arr", varType = Just Int[], val = Nothing},Variable {name = "pos", varType = Just Int, val = Nothing}], size = 2, vars = [], scopes = [(1,If,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(1,Else,Scope {outsiderVars = [], size = 0, vars = [], scopes = []})]}
*/
/*
{2
    Outsider Vars:
      Int[] arr
      Int pos
    1: If scope: {1
    }
    1: Else scope: {0
    }
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
Scope {outsiderVars = [Variable {name = "y", varType = Just Int, val = Nothing}], size = 1, vars = [], scopes = [(1,For,Scope {outsiderVars = [Variable {name = "i", varType = Just Int, val = Just (NumberLiteral 0.0)}], size = 3, vars = [(1,Variable {name = "j", varType = Just Int, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}})}),(3,Variable {name = "i", varType = Nothing, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0})})], scopes = [(2,If,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(2,Else,Scope {outsiderVars = [], size = 1, vars = [], scopes = [(1,If,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(1,Else,Scope {outsiderVars = [], size = 0, vars = [], scopes = []})]})]})]}
*/
/*
{1
    Outsider Vars:
      Int y
    1: For scope: {3
        Outsider Vars:
          Int i
        Vars:
          1: Int j
          3: i
        2: If scope: {1
        }
        2: Else scope: {1
            1: If scope: {1
            }
            1: Else scope: {0
            }
        }
    }
}
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

/*
Scope {outsiderVars = [Variable {name = "arr", varType = Just Int[], val = Nothing}], size = 3, vars = [(1,Variable {name = "sum", varType = Just Int, val = Just (NumberLiteral 0.0)})], scopes = [(2,For,Scope {outsiderVars = [Variable {name = "i", varType = Just Int, val = Just (NumberLiteral 0.0)}], size = 2, vars = [(2,Variable {name = "i", varType = Nothing, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0})})], scopes = [(1,If,Scope {outsiderVars = [], size = 1, vars = [(1,Variable {name = "sum", varType = Nothing, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = +, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}})})], scopes = []}),(1,Else,Scope {outsiderVars = [], size = 1, vars = [(1,Variable {name = "sum", varType = Nothing, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = -, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}})})], scopes = []})]})]}
*/
/*
{3
    Outsider Vars:
      Int[] arr
    Vars:
      1: Int sum
    2: For scope: {2
        Outsider Vars:
          Int i
        Vars:
          2: i
        1: If scope: {1
            Vars:
              1: sum
        }
        1: Else scope: {1
            Vars:
              1: sum
        }
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

///////////////////////////////////////////////////

/*
Scope {outsiderVars = [Variable {name = "a", varType = Just Int, val = Nothing},Variable {name = "b", varType = Just Int, val = Nothing}], size = 2, vars = [], scopes = [(1,While,Scope {outsiderVars = [], size = 1, vars = [(1,Variable {name = "a", varType = Nothing, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = -, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}})})], scopes = []})]}
*/
/*
{2
    Outsider Vars:
      Int a
    1: While scope: {1
        Vars:
          1: a
    }
}
*/
public static int rest(int a, int b) {
  while(a > 0) {
    a -= b;
  }
  return a<0 ? a+b : a;
}

///////////////////////////////////////////////////

/*
Scope {outsiderVars = [Variable {name = "size", varType = Just Int, val = Nothing},Variable {name = "elem", varType = Just Int, val = Nothing}], size = 3, vars = [(1,Variable {name = "arr", varType = Just Int[], val = Just (ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (VarExpr {varType = Nothing, varObj = [], varName = "size"}), arrElems = []})})], scopes = [(2,For,Scope {outsiderVars = [Variable {name = "i", varType = Just Int, val = Just (NumberLiteral 0.0)}], size = 2, vars = [(1,Variable {name = "arr", varType = Nothing, val = Just (VarExpr {varType = Nothing, varObj = [], varName = "elem"})}),(2,Variable {name = "i", varType = Nothing, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0})})], scopes = []})]}
*/
/*
{3
    Outsider Vars:
      Int size
      Int elem
    Vars:
      1: Int[] arr
    2: For scope: {2
        Outsider Vars:
          Int i
        Vars:
          1: arr
          2: i
    }
}
*/
public int[] fillArray(int size, int elem) {
  int[] arr = new int[size];
  for(int i=0; i<size; i++) {
    arr[i] = elem;
  }
  return arr;
}

///////////////////////////////////////////////////

/*
Scope {outsiderVars = [Variable {name = "input", varType = Just String, val = Nothing}], size = 1, vars = [], scopes = [(1,If,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "msg", varType = Just String, val = Just (StringLiteral "non-empty")}),(2,Variable {name = "status", varType = Nothing, val = Just (VarExpr {varType = Nothing, varObj = [], varName = "msg"})})], scopes = []}),(1,Else,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "msg", varType = Just String, val = Just (StringLiteral "empty")}),(2,Variable {name = "status", varType = Nothing, val = Just (VarExpr {varType = Nothing, varObj = [], varName = "msg"})})], scopes = []})]}
*/
/*
{1
    Outsider Vars:
      String input
    1: If scope: {2
        Vars:
          1: String msg
          2: status
    }
    1: Else scope: {2
        Vars:
          1: String msg
          2: status
    }
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

///////////////////////////////////////////////////

/*
Scope {outsiderVars = [Variable {name = "a", varType = Just Int, val = Nothing},Variable {name = "b", varType = Just Int, val = Nothing}], size = 4, vars = [(1,Variable {name = "x", varType = Just Int, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}})}),(2,Variable {name = "y", varType = Just Int, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}})})], scopes = [(3,While,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "a", varType = Nothing, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = NumberLiteral 1.0})}),(2,Variable {name = "x", varType = Nothing, val = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "a"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "b"}})})], scopes = []})]}
*/
/*
{4
    Outsider Vars:
      Int a
      Int b
    Vars:
      1: Int x
      2: Int y
    3: While scope: {2
        Vars:
          1: a
          2: x
    }
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

///////////////////////////////////////////////////

/*
Scope {outsiderVars = [], size = 2, vars = [], scopes = [(1,Try,Scope {outsiderVars = [], size = 2, vars = [(1,Variable {name = "myNumbers", varType = Just Int[], val = Just (ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 1.0,NumberLiteral 2.0,NumberLiteral 3.0]})})], scopes = []}),(1,Catch,Scope {outsiderVars = [], size = 1, vars = [], scopes = []}),(1,Finally,Scope {outsiderVars = [], size = 1, vars = [], scopes = []})]}
*/
/*
{2
    1: Try scope: {2
        Vars:
          1: Int[] myNumbers
    }
    1: Catch scope: {1
    }
    1: Finally scope: {1
    }
}
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
