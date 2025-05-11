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
    funDecl = FunCallStmt {
        funCall = FunCallExpr {
            funName = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "fill"},
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
public int[] fill(int[] arr, int pos){
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
// example.js
var x = 10;                   // (1)
function foo(a, b) {          // (2)
  var y = a + b;              // (3)

  function bar(c) {           // (4)
    let z = y + c;            // (5)
    return z;                 // (6)
  }

  return bar;                 // (7)
}

const result = foo(1, 2)(3);  // (8)
console.log(result);          // 16
*/

////////////////////////////////////////////////////

/*
// example-with-branches.js

// ─── Global Declarations ───────────────────────────────────────
const input = [1, 2, 3, 4, 5];
var status;

function processArray(arr) {
  // ─── processArray Scope ────────────────────────────────────
  let sum = 0;
  // ─── for-loop Block Scope ─────────────────────────────────
  for (let i = 0; i < arr.length; i++) {
    if (arr[i] % 2 === 0) {
      sum += arr[i];
    } else {
      sum -= arr[i];
    }
  }
  // ─── while-loop Block Scope ───────────────────────────────
  while (sum > 10) {
    sum -= 5;
  }
  return sum;
}

// ─── Global Control Flow ──────────────────────────────────────
if (input.length > 0) {
  let msg = "non-empty";
  status = msg;
} else {
  let msg = "empty";
  status = msg;
}

const result = processArray(input);
console.log("Status:", status);
console.log("Result:", result);

*/
////
