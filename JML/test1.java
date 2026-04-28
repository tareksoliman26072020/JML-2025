//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21"),
    (Return,SymInt 5)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo21(){
  return 5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_2"),
    (VarBindings,SVarBindings (fromList [
        ("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarName "i",SymVar Int "i"),
    (Return,SymInt 5)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo21_2(){
  int i;
  return 5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo22"),
    (Return,SymInt 5)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo22(){
  return boo21();
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo22_2"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 5,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 5),
    (Return,SymInt 5)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo22_2(){
  int x = boo21();
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_3"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 8,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 8),
    (Return,SymInt 5)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo23_3(){
  int x = 3 + boo21();
  return 5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_3_1"),
    (Return,SymInt 8)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8;
  @*/
public int boo23_3_1() {
  return 3 + 5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_4"),
    (Return,SymInt 8)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8;
  @*/
public int boo23_4(){
  return 3 + boo21();
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_9"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 8,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "x",SymInt 8),
    (Return,SymInt 8)
  ]
 */
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8;
  @*/
public int boo23_9(){
  int x;
  x = 3 + boo21();
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo33_3"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymDouble 1.0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),
        ("x",(SymDouble 1.1,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "x",SymDouble 1.1),
    (Return,SymDouble 1.1)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 1.1;
  @*/
public double boo33_3(){
  double x = 1;
  x+=0.1;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo33_4"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymDouble 1.0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),
        ("x",(SymDouble 1.1,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "x",SymDouble 1.1),
    (Return,SymDouble 1.1)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 1.1;
  @*/
public double boo33_4(){
  double x = 1;
  x = x + 0.1;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo33_5"),
    (GlobalVars,SGlobalVars ["z","t"]),
    (FormalParms,SFormalParms ["str"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymDouble 1.0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("z",(SymVar UnknownGlobalVarSymType "t",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymDouble 1.1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "str",SymVar String "str"),
    (VarName "t",SymVar UnknownGlobalVarSymType "t"),
    (VarName "x",SymDouble 1.1),
    (VarName "y",SymVar Int "y"),
    (VarName "z",SymVar UnknownGlobalVarSymType "t"),
    (Return,SymDouble 1.1)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 1.1;
  @   ensures z == t;
  @*/
public double boo33_5(String str){
  double x = 1;
  int y;
  z = t;
  x = x + 0.1;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo33_6"),
    (GlobalVars,SGlobalVars ["z","t"]),
    (FormalParms,SFormalParms ["str"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}}),
        ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymDouble 1.0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})),
        ("z",(SymVar UnknownNumSymType "t",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 6}})),
        ("x",(SymDouble 1.1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 6}})),
        ("z",(SymNum 1.0,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}}))]),
    (VarName "str",SymVar String "str"),
    (VarName "t",SymVar UnknownNumSymType "t"),
    (VarName "x",SymDouble 1.1),
    (VarName "y",SymVar Int "y"),
    (VarName "z",SymNum 1.0),
    (Return,SymDouble 1.1)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 1.1;
  @   ensures z == 1.0;
  @*/
public double boo33_6(String str){
  double x = 1;
  int y;
  z = t;
  x = x + 0.1;
  z = 1;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo33_7"),
    (GlobalVars,SGlobalVars ["c"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymVar Double "c",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "c",SymVar Double "c"),
    (VarName "x",SymVar Double "c"),
    (Return,SymVar Double "c")
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == c;
  @*/
public double boo33_7(){
  double x;
  x = c;
  return x;
}

////////////////////////////////////////


















//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SymVar Int "i")
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i;
  @*/
public int boo21_i(int i){
  return i;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_2_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [
        ("i",(SymInt 5,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymInt 5),
    (Return,SymInt 5)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo21_2_i(int i){
  i = 5;
  return i;
}

////////////////////////////////////////

//DONE
/*
Map.fromList [
    (MethodHandle,SMethodHandle SYT.Double "boo33_5_2"),
    (GlobalVars,SGlobalVars ["z"]),
    (FormalParms,SFormalParms ["str"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymDouble 1.0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("z",(SymVar String "str",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymDouble 1.1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "str",SymVar SYT.String "str"),
    (VarName "x",SymDouble 1.1),
    (VarName "y",SymVar SYT.Int "y"),
    (VarName "z",SymVar SYT.String "str"),
    (Return,SymDouble 1.1)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 1.1;
  @   ensures z == str;
  @*/
public double boo33_5_2(String str){
  double x = 1;
  int y;
  z = str;
  x = x + 0.1;
  return x;
}

////////////////////////////////////////

//DONE
/*
[
    (MethodHandle,SMethodHandle Double "boo33_5_3"),
    (GlobalVars,SGlobalVars ["z"]),
    (FormalParms,SFormalParms ["str"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [("x",(SymDouble 1.0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})),("str",(SBin (SymVar String "str") Add (SymString "1"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 6}})),("z",(SBin (SymVar String "str") Add (SymString "1"),Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 6}})),("x",(SymDouble 1.1,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}}))]),
    (VarName "str",SBin (SymVar String "str") Add (SymString "1")),
    (VarName "x",SymDouble 1.1),
    (VarName "y",SymVar Int "y"),
    (VarName "z",SBin (SymVar String "str") Add (SymString "1")),
    (Return,SymDouble 1.1)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 1.1;
  @   ensures z == \old(str) + 1;
  @*/
public double boo33_5_3(String str){
  double x = 1;
  int y;
  str = str + "1";
  z = str;
  x = x + 0.1;
  return x;
}

////////////////////////////////////////

//DONE
/*
[
    (MethodHandle,SMethodHandle SYT.Double "boo33_5_4"),
    (GlobalVars,SGlobalVars ["z"]),
    (FormalParms,SFormalParms ["str"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}}),
        ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymDouble 1.0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})),
        ("z",(SymVar SYT.String "str",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 6}})),
        ("str",(SBin (SymVar SYT.String "str") SYT.Add (SymString "1"),Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 6}})),
        ("x",(SymDouble 1.1,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}}))]),
    (VarName "str",SBin (SymVar SYT.String "str") SYT.Add (SymString "1")),
    (VarName "x",SymDouble 1.1),
    (VarName "y",SymVar SYT.Int "y"),
    (VarName "z",SymVar SYT.String "str"),
    (Return,SymDouble 1.1)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 1.1;
  @   ensures z == \old(str);
  @*/
public double boo33_5_4(String str){
  double x = 1;
  int y;
  z = str;
  str = str + "1";
  x = x + 0.1;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [
        ("i",(SBin (SymVar Int "i") Add (SymInt 2),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),
    (Return,SBin (SymVar Int "i") Add (SymInt 2))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == \old(i) + 2;
  @*/
public int boo21_3_i(int i){
  i += 2;
  return i;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i_1"),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [
        ("i",(SBin (SymVar Int "i") Add (SymInt 2),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),
    (Return,SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymInt 4))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2 * \old(i) + 4;
  @*/
public int boo21_3_i_1(int i){
  i += 2;
  return i+i;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i_2"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("i",(SBin (SymVar Int "i") Add (SymInt 2),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),
        ("x",(SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymInt 9),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),
    (VarName "x",SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymInt 9)),
    (Return,SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymInt 9))
  ]
*/

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2 * \old(i) + 9;
  @*/
public int boo21_3_i_2(int i){
  i += 2;
  int x = i + 5 + i;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i_3"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [("i",(SBin (SymVar Int "i") Add (SymInt 2),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),("x",(SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymInt 9),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),
    (VarName "x",SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymInt 9)),
    (Return,SBin (SBin (SymInt 5) Mul (SymVar Int "i")) Add (SymInt 20))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5 * \old(i) + 20;
  @*/
public int boo21_3_i_3(int i){
  i += 2;
  int x = i + 5 + i;
  return x + i + x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i_4"),
    (GlobalVars,SGlobalVars ["x"]),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [
        ("x",(SBin (SymVar Int "x") Add (SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymInt 2)),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymVar Int "x") Add (SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymInt 2))),
    (Return,SBin (SymVar Int "x") Add (SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymInt 2)))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2 * i + 2;
  @   ensures x == \old(x) + 2 * i + 2;
  @*/
public int boo21_3_i_4(int i){
  x += i + 2 + i;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i_5"),
    (GlobalVars,SGlobalVars ["x"]),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [("x",(SBin (SymVar Int "x") Add (SBin (SymInt 2) Sub (SymVar Int "i")),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymVar Int "x") Add (SBin (SymInt 2) Sub (SymVar Int "i"))),
    (Return,SBin (SymVar Int "x") Add (SBin (SymInt 2) Sub (SymVar Int "i")))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2 - i;
  @   ensures x == \old(x) + 2 - i;
  @*/
public int boo21_3_i_5(int i){
  x += i + 2 - 2*i;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i_6"),
    (GlobalVars,SGlobalVars ["x"]),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [("x",(SBin (SymVar Int "x") Add (SBin (SymInt 2) Add (SymVar Int "i")),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymVar Int "x") Add (SBin (SymInt 2) Add (SymVar Int "i"))),
    (Return,SBin (SymVar Int "x") Add (SBin (SymInt 2) Add (SymVar Int "i")))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2 + i;
  @   ensures x == \old(x) + 2 + i;
  @*/
public int boo21_3_i_6(int i){
  x += 2 + 3*i - 2*i;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i_7"),
    (GlobalVars,SGlobalVars ["x"]),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [("x",(SBin (SymVar Int "x") Add (SymInt 2),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymVar Int "x") Add (SymInt 2)),
    (Return,SBin (SymVar Int "x") Add (SymInt 2))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2;
  @   ensures x == \old(x) + 2;
  @*/
public int boo21_3_i_7(int i){
  x += 2 + 3*i - 2*i - i;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i_8"),
    (GlobalVars,SGlobalVars ["x"]),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [
        ("x",(SBin (SymVar Int "x") Add (SBin (SymInt 2) Add (SBin (SymInt 4) Mul (SymVar Int "i"))),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymVar Int "x") Add (SBin (SymInt 2) Add (SBin (SymInt 4) Mul (SymVar Int "i")))),
    (Return,SBin (SymVar Int "x") Add (SBin (SymInt 2) Add (SBin (SymInt 4) Mul (SymVar Int "i"))))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2 + 4 * i;
  @   ensures x == \old(x) + 2 + 4 * i;
  @*/
public int boo21_3_i_8(int i){
  x += i + 2 + 3*i;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo21_3_i_9"),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [("i",(SBin (SymInt 2) Mul (SymVar Int "i"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SBin (SymInt 2) Mul (SymVar Int "i")),
    (Return,SBin (SymInt 2) Mul (SymVar Int "i"))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2 * \old(i);
  @*/
public int boo21_3_i_9(int i){
  i += i;
  return i;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo22_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SymVar Int "i")
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i;
  @*/
public int boo22_i(int i){
  return boo21_i(i);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo22_i_2"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SBin (SymVar Int "i") Add (SymInt 5))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i + 5;
  @*/
public int boo22_i_2(int i){
  return boo21_i(i+4) + 1;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo22_i_3"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SBin (SymVar Int "i") Add (SymInt 2))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i + 2;
  @*/
public int boo22_i_3(int i){
  return boo21_3_i(i);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo22_i_4"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SBin (SBin (SymVar Int "i") Add (SymInt 6)) Mul (SymInt 5))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i + 6 * 5;
  @*/
/*@ public normal_behavior
  @   requires -429496735 <= i && i <= 429496723;
  @   assignable \nothing;
  @   ensures \result == 5 * (\old(i) + 6);
  @*/
public int boo22_i_4(int i){
  return boo21_3_i(i+4) * 5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo22_i_5"),
    (GlobalVars,SGlobalVars ["j"]),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (VarName "j",SymVar Int "j"),
    (Return,SBin (SymVar Int "j") Add (SymInt 2))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == j + 2;
  @*/
public int boo22_i_5(int i){
  return boo21_3_i(j);
}

/*
[
    (MethodHandle,SMethodHandle Void "boo22_i_5_call"),
    (GlobalVars,SGlobalVars ["j"]),
    (VarAssignments,SVarAssignments [("j",(SymInt 9,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "j",SymInt 9),
    (Return,SymReturnVoid),
    (Actions,SActions [
        SymString "9.0\n",
        SymString "11\n",
        SymString "9\n"])
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable j;
  @   ensures j == 9;
  @*/
public void boo22_i_5_call() {
  j = 9;
  println(toString(j));
  println(toString(boo22_i_5(666)));
  println(toString(j));
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo22_2_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("x",(SBin (SymVar Int "i") Mul (SymInt 2),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymVar Int "i") Mul (SymInt 2)),
    (Return,SBin (SymVar Int "i") Mul (SymInt 2))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i * 2;
  @*/
public int boo22_2_i(int i){
  int x = boo21_i(i*2);
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo22_2_i_2"),
    (VarBindings,SVarBindings (fromList [
        ("i",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),
        ("j",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),
        ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("j",(SymInt 6,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("i",(SymInt 9,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("x",(SymInt 18,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "i",SymInt 9),
    (VarName "j",SymInt 6),
    (VarName "x",SymInt 18),
    (Return,SymInt 33)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 33;
  @*/
public int boo22_2_i_2(){
  int j = 6;
  int i = 3 + j;
  int x = boo21_i(i*2);
  return x + i + j;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_3_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("x",(SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i")),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i"))),
    (Return,SymInt 5)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo23_3_i(int i){
  int x = 3 + boo21_i(i+i);
  return 5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_3_i_2"),
    (VarBindings,SVarBindings (fromList [
        ("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),
        ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("i",(SymInt 4,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),
        ("x",(SymInt 11,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "i",SymInt 4),
    (VarName "x",SymInt 11),
    (Return,SymInt 16)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 16;
  @*/
public int boo23_3_i_2(){
  int i = 4;
  int x = 3 + boo21_i(i+i);
  return x+5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_4_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SymInt 3)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 3;
  @*/
public int boo23_4_i(int i){
  return 3 + boo21_i(0);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_4_i_2"),
    (Return,SymInt 10)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 10;
  @*/
public int boo23_4_i_2(){
  return 5 * boo21_i(0*4+2);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_4_i_3"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SymInt 10)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 10;
  @*/
public int boo23_4_i_3(int i){
  return 5 * boo21_i(0*i+2);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_4_i_4"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SBin (SymInt 15) Mul (SBin (SBin (SymInt 3) Mul (SymVar Int "i")) Add (SymInt 2)))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 15 * ((3 * i) + 2);
  @*/
public int boo23_4_i_4(int i){
  return 15 * boo21_i(3*i+2);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_4_i_4_1"),
    (Return,SymInt 255)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 255;
  @*/
public int boo23_4_i_4_1(){
  return boo23_4_i_4(5);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_4_i_5"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SBin (SymInt 15) Mul (SBin (SymVar Int "i") Add (SymInt 2)))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 15 * (i + 2);
  @*/
public int boo23_4_i_5(int i){
  return 15 * boo21_i(1*i+2);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_5_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SymInt 8)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8;
  @*/
public int boo23_5_i(int i){
  return 8;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo23_6_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SymDouble 8.0)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8.0;
  @*/
public double boo23_6_i(int i){
  return 8;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo23_7_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Double "i"),
    (Return,SBin (SymDouble 8.0) Add (SymVar Double "i"))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8.0 + i;
  @*/
public double boo23_7_i(double i){
  return 3+5+i;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_8_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarName "i",SymVar Int "i"),
    (Return,SBin (SymInt 3) Add (SBin (SymInt 5) Mul (SymVar Int "i")))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 3 + (5 * i);
  @*/
public int boo23_8_i(int i){
  return 3+5*i;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_9_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 5,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymInt 5),
    (Return,SymInt 5)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo23_9_i(int i){
  int x;
  x = 3 + boo21_i(i+2) - i;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_9_i_2"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [("x",(SBin (SymInt 5) Sub (SymVar Int "i"),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymInt 5) Sub (SymVar Int "i")),
    (Return,SBin (SymInt 5) Sub (SymVar Int "i"))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5 - i;
  @*/
public int boo23_9_i_2(int i){
  int x;
  x = 3 + boo21_i(i+2) - 2*i;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_10_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SBin (SymInt 8) Add (SymVar Int "i"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymInt 8) Add (SymVar Int "i")),
    (Return,SBin (SymInt 8) Add (SymVar Int "i"))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8 + i;
  @*/
public int boo23_10_i(int i){
  int x = 3+5+i;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_10_i_2"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("x",(SBin (SymInt 8) Add (SymVar Int "i"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymInt 8) Add (SymVar Int "i")),
    (Return,SBin (SymInt 8) Add (SymVar Int "i"))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8 + i;
  @*/
public int boo23_10_i_2(int i){
  int x = 3+i+5;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_11_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 8,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),("x",(SymInt 9,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymInt 9),
    (Return,SBin (SymInt 9) Mul (SymVar Int "i"))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 9 * i;
  @*/
public int boo23_11_i(int i){
  int x = 3+5;
  x = 10-1;
  return x*i;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo23_12_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("x",(SBin (SymInt 3) Add (SymVar Int "i"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SBin (SymInt 3) Add (SymVar Int "i")),
    (Return,SBin (SymInt 3) Add (SymVar Int "i"))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 3 + i;
  @*/
public int boo23_12_i(int i){
  int x = 3 + boo21_i(i);
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo33_3_i"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [("x",(SBin (SymDouble 1.0) Add (SymVar Double "i"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),("x",(SBin (SymDouble 1.1) Add (SymVar Double "i"),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "i",SymVar Double "i"),
    (VarName "x",SBin (SymDouble 1.1) Add (SymVar Double "i")),
    (Return,SBin (SymDouble 1.1) Add (SymVar Double "i"))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 1.1 + i;
  @*/
public double boo33_3_i(double i){
  double x = 1 + i;
  x+=0.1;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo33_4_i"),
    (FormalParms,SFormalParms ["i","j"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SBin (SymDouble 1.0) Add (SymVar Double "i"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),
        ("x",(SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j"),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "i",SymVar Double "i"),
    (VarName "j",SymVar Double "j"),
    (VarName "x",SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")),
    (Return,SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j"))
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == (1.1 + i) + j;
  @*/
public double boo33_4_i(double i, double j){
  double x = 1 + i;
  x = x + 0.1 + j;
  return x;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Double "boo33_4_i_call"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymDouble 18.5,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymDouble 18.5),
    (Return,SymDouble 18.5)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 18.5;
  @*/
public double boo33_4_i_call(){
  double x = 1 + boo33_4_i(8.8,7.6);
  return x;
}

////////////////////////////////////////


























//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo24"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 9,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 9),
    (Return,SymInt 9)
  ]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 9;
  @*/
public int boo24(){
  int x = 3 + boo25(5);
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo24_2"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SException Int "Exception" "meow",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SException Int "Exception" "meow"),
    (Return,SException Int "Exception" "meow"),
    (Actions,SActions [SymString "Oopsie\n"])
  ]
*/
/*@ Exceptional Behavior
  @   requires true;
  @   signals Exception;
  @   assignable \nothing;
  @*/
public int boo24_2(){
  int x = 3 + boo25(11);
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "exceptionFun"),
    (Return,SException Int "Exception" "thee")
  ]
*/
/*@ exceptional_behavior
  @   requires true;
  @   assignable \nothing;
  @   signals Exception;
  @*/
public int exceptionFun() throws Exception {
  throw new Exception("thee");
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo25"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments []),
    (VarName "i",SymVar Int "i"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 5}),
     SIte (SBin (SymVar Int "i") Gt (SymInt 10))
          (fromList [(MethodHandle,SMethodHandle Int "boo25"),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions [SymString "Oopsie\n"])])
          (Just (fromList [(MethodHandle,SMethodHandle Int "boo25"),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)])))
  ]
*/
/*@ Exceptional Behavior
  @   requires i > 10;
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ Normal Behavior
  @   requires i <= 10;
  @   assignable \nothing;
  @   ensures \result == 6;
  @*/
public int boo25(int i){
  if(i>10){
    println("Oopsie");
    throw new Exception("meow");
  }
  else{
    return 6;
  }
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[(MethodHandle,SMethodHandle Int "boo26_2"),(Return,SymInt 5)]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo26_2(){
  return boo27(-5);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo27"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments []),
    (VarName "i",SymVar Int "i"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 5}),
     SIte (SBin (SymVar Int "i") Ge (SymInt 0))
          (fromList [(MethodHandle,SMethodHandle Int "boo27"),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")])
          (Just (fromList [(MethodHandle,SMethodHandle Int "boo27"),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",(SBin (SymInt (-1)) Mul (SymVar Int "i"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}}))]),(VarName "i",SymVar Int "i"),(VarName "res",SBin (SymInt (-1)) Mul (SymVar Int "i")),(Return,SBin (SymInt (-1)) Mul (SymVar Int "i"))])))
  ]
*/
/*@ Normal Behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i;
  @ also
  @ Normal Behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == -1 * i;
  @*/
public int boo27(int i){
  if(i >= 0){
    return i;
  }
  else{
    int res = -1 * i;
    return res;
  }
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[(MethodHandle,SMethodHandle Int "boo27_2"),(Return,SymInt 5)]
*/
/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo27_2() {
  return boo27(5);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 5})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),
     SIte (SBin (SymVar Int "i") Ge (SymInt 0))
          (fromList [(MethodHandle,SMethodHandle Int "boo28"),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")])
          Nothing),
    (Return,SymInt 5)
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28(int i){
  int x = 1;
  if(i >= 0){
    x++;
    return i;
  }
  return 5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo282"),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
    (VarName "x",SymInt 2),
    (Return,SymInt 2),
    (Actions,SActions [])
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public int boo282(){
  int x = 1;
  if(x >= 0){
    x++;
    return x;
  }
  return 5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo283"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "x",SymInt 1),
    (Return,SymInt 5)
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo283(){
  int x = 1;
  if(x < 0){
    x++;
    return x;
  }
  return 5;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[(MethodHandle,SMethodHandle Int "boo28_p"),(Return,SymInt 10)]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 10;
  @*/
public int boo28_p() {
  return boo28(10);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[(MethodHandle,SMethodHandle Int "boo28_m"),(Return,SymInt 5)]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28_m() {
  return boo28(-10);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 6})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SIte (SBin (SymVar Int "i") Ge (SymInt 0))
          (fromList [(MethodHandle,SMethodHandle Int "boo28_2"),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})),("y",(SymInt 0,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(VarName "y",SymInt 0),(Return,SymVar Int "i")])
          Nothing),
    (Return,SymInt 5)
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
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

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_2_1"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("y",(SymInt 0,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "x",SymInt 2),
    (Return,SymInt 4),
    (Actions,SActions [])
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
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

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_4"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (fromList [(MethodHandle,SMethodHandle Int "boo28_4"),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymVar Int "i")]) (Just (fromList [(MethodHandle,SMethodHandle Int "boo28_4"),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)]))),
    (Return,SymInt 5)
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
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

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_4_1"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymInt 1),
    (Return,SymVar Int "i"),
    (Actions,SActions [])
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i;
  @*/
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
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_4_2"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymInt 2),
    (Return,SymInt 5),
    (Actions,SActions [])
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
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

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_4_p"),
    (Return,SymInt 10)
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 10;
  @*/
public int boo28_4_p() {
  return boo28_4(10);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_4_m"),
    (Return,SymInt 5)
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28_4_m() {
  return boo28_4(-10);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_5"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 7})],6)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 7}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (fromList [(MethodHandle,SMethodHandle Int "boo28_5"),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})),("y",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymVar Int "i") Add (SymInt 1))]) (Just (fromList [(MethodHandle,SMethodHandle Int "boo28_5"),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)]))),
    (Return,SymInt 5)
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
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

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_6"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})),
        ("y",(SymInt 2,Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 7})],6)]),
    (VarName "y",SymInt 2),
    (ScopeRange (SR {branchStart = 2, branchEnd = 7}),
     SIte (SBin (SymVar Int "i") Ge (SymInt 0))
          (fromList [
              (MethodHandle,SMethodHandle Int "boo28_6"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),
              (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})),("y",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
              (VarName "i",SymVar Int "i"),
              (VarName "x",SymInt 1),
              (VarName "y",SymInt 1),
              (Return,SBin (SymVar Int "i") Add (SymInt 1))])
          (Just (fromList [
              (MethodHandle,SMethodHandle Int "boo28_6"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
              (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
              (VarName "i",SymVar Int "i"),
              (VarName "x",SymInt 2)]))),
    (Return,SymInt 7)
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 7;
  @*/
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

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_6_2"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})),
        ("y",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymInt 1),
    (Return,SBin (SymVar Int "i") Add (SymInt 1)),
    (Actions,SActions [])
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @*/
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

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_6_3"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})),("y",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),("y",(SymInt 2,Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 8}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymInt 1),
    (VarName "y",SymInt 2),
    (Return,SymInt 7),
    (Actions,SActions [])
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 7;
  @*/
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

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "boo28_6_4",SMethodType Int),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",CFG_Coor {varDeclAt = 1, varFrame = 0}),("y",CFG_Coor {varDeclAt = 7, varFrame = 0})])),
    (VarAssignments,SVarAssignments [
      ("x",CFG_Coor {varDeclAt = 1, varFrame = 0}),
      ("x",CFG_Coor {varDeclAt = 5, varFrame = 2}),
      ("y",CFG_Coor {varDeclAt = 7, varFrame = 0})
    ]),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 2),
    (VarName "y",SymInt 2),
    (Return,SymInt 7),
    (Actions,SActions [])
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 7;
  @*/
public static int boo28_6_4(int i){
  int x = 1;
  if(x < 0){
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

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "boo28_6_5",SMethodType Int),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = 0})])),
    (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = 0}),("x",Node_Coor {varDeclAt = 5, varFrame = 2})]),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 2),
    (Return,SymInt 2),
    (Actions,SActions [])
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public static int boo28_6_5(int i){
  int x = 1;
  if(x < 0){
    int y = 0;
    y++;
  }
  else {
    x++;
  }
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle SYT.Int "boo28_6_6"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 7})],6)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 7}),
     SIte (SBin (SymVar SYT.Int "i") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo28_6_6"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
                  ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
                  ("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})),
                  ("y",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "x",SymInt 1),
              (VarName "y",SymInt 1),
              (Return,SBin (SymVar SYT.Int "i") SYT.Add (SymInt 1))])
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo28_6_6"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
              (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "x",SymInt 2)]))),
    (Return,SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 7})],6)])
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public static int boo28_6_6(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_6_6_2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})),
        ("x",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymUnknown ("x",SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),
     SIte (SBin (SymVar Int "i") Ge (SymInt 0))
          (fromList [
              (MethodHandle,SMethodHandle Int "boo28_6_6_2"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
              (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})),("x",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
              (VarName "i",SymVar Int "i"),
              (VarName "x",SymInt 0)])
          (Just (fromList [
              (MethodHandle,SMethodHandle Int "boo28_6_6_2"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
              (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})),("x",(SymInt 2,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
              (VarName "i",SymVar Int "i"),
              (VarName "x",SymInt 2)]))),
    (Return,SBin (SymVar Int "i") Add (SymUnknown ("x",SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4)]))
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 0;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == i + 2;
  @*/
public static int boo28_6_6_2(int i){
  int x = 1;
  if(i >= 0){
    x = 0;
  }
  else {
    x++;
  }
  return i+x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_6_6_3"),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("x",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})),
        ("y",(SBool True,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 7}})),
        ("y",(SBool False,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymUnknown ("x",SymInt 1) [
        ([(If,SR {branchStart = 2, branchEnd = 7})],3),
        ([(If,SR {branchStart = 2, branchEnd = 7})],5)]),
    (VarName "y",SymUnknown ("y",SymVar Bool "y") [
        ([(If,SR {branchStart = 2, branchEnd = 7})],4),
        ([(If,SR {branchStart = 2, branchEnd = 7})],6)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 7}),
     SIte (SBin (SymVar Int "i") Ge (SymInt 0))
          (fromList [
              (MethodHandle,SMethodHandle Int "boo28_6_6_3"),
              (GlobalVars,SGlobalVars ["y"]),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),("x",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})),("y",(SBool True,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
              (VarName "i",SymVar Int "i"),
              (VarName "x",SymInt 0),
              (VarName "y",SBool True)])
          (Just (fromList [
              (MethodHandle,SMethodHandle Int "boo28_6_6_3"),
              (GlobalVars,SGlobalVars ["y"]),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 7}})),("y",(SBool False,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
              (VarName "i",SymVar Int "i"),
              (VarName "x",SymInt 2),
              (VarName "y",SBool False)]))),
    (Return,SBin (SymVar Int "i") Add (SymUnknown ("x",SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 7})],3),([(If,SR {branchStart = 2, branchEnd = 7})],5)]))
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable y;
  @   ensures \result == i + 0;
  @   ensures y == true;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable y;
  @   ensures \result == i + 2;
  @   ensures y == false;
  @*/
public static int boo28_6_6_3(int i){
  int x = 1;
  if(i >= 0){
    x = 0;
    y = true;
  }
  else {
    x++;
    y = false;
  }
  return i+x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_6_6_4"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 2, branchEnd = 8}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymUnknown ("x",SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 8})],7)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),
     SIte (SBin (SymVar Int "i") Ge (SymInt 0))
          (fromList [
              (MethodHandle,SMethodHandle Int "boo28_6_6_4"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 8}})),("y",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 8}}))]),
              (VarName "i",SymVar Int "i"),
              (VarName "x",SymInt 1),
              (VarName "y",SymInt 1),
              (Return,SBin (SymVar Int "i") Add (SymInt 1))])
          (Just (fromList [
              (MethodHandle,SMethodHandle Int "boo28_6_6_4"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("z",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("z",(SymInt 9,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 8}})),("x",(SymInt 2,Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 2, branchEnd = 8}}))]),
              (VarName "i",SymVar Int "i"),
              (VarName "x",SymInt 2),
              (VarName "z",SymInt 9)]))),
    (Return,SymUnknown ("x",SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 8})],7)])
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public static int boo28_6_6_4(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    int z = 9;
    x++;
  }
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_6_7"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})),("x",(SymInt 5,Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "i",SymVar Int "i"),
    (VarName "x",SymInt 5),
    (ScopeRange (SR {branchStart = 2, branchEnd = 7}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (fromList [(MethodHandle,SMethodHandle Int "boo28_6_7"),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})),("y",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymVar Int "i") Add (SymInt 1))]) (Just (fromList [(MethodHandle,SMethodHandle Int "boo28_6_7"),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)]))),
    (Return,SymInt 5)
  ]
*/
/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public static int boo28_6_7(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  x = 5;
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "boo28_6_p"),
    (Return,SymInt 11)
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 11;
  @*/
public int boo28_6_p() {
  return boo28_6(10);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Bool "boo29"),
    (Return,SBool False),
    (Actions,SActions [])
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == false;
  @*/
public boolean boo29(){
  if(true){
    return false;
  }
  else{
    return true;
  }
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "boo30",SMethodType Int),
    (GlobalVars,SGlobalVars ["y","y1","y2","t1","t2"]),
    (FormalParms,SFormalParms ["z"]),
    (VarBindings,SVarBindings (fromList [
      ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
      ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
      ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
      ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),
      ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),
      ("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),
      ("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),
      ("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}}),
      ("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),
    (VarName "t1",SymUnknown (SymVar Int "t1") [([(If,SR {branchStart = 6, branchEnd = 11})],7)]),
    (VarName "t2",SymUnknown (SymVar Int "t2") [([(If,SR {branchStart = 6, branchEnd = 11})],9)]),
    (VarName "x1",SymInt 0),
    (VarName "x2",SymInt 0),
    (VarName "y",SymNum 0.0),
    (VarName "y1",SymNum 0.0),
    (VarName "y2",SymNum 0.0),
    (VarName "z",SymVar Int "z"),
    (ScopeRange (SR {branchStart = 6, branchEnd = 11}),
     SIte (SBin (SymVar Int "z") Ge (SymInt 0))
          (SymState {env = fromList [
              (MethodName "boo30",SMethodType Int),
              (GlobalVars,SGlobalVars ["y","y1","y2","t1"]),
              (FormalParms,SFormalParms ["z"]),
              (VarBindings,SVarBindings (fromList [
                  ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [
                  ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}})]),
              (VarName "t1",SymInt 7),
              (VarName "x1",SymInt 0),
              (VarName "x2",SymInt 0),
              (VarName "y",SymNum 0.0),
              (VarName "y1",SymNum 0.0),
              (VarName "y2",SymNum 0.0),
              (VarName "z",SymVar Int "z"),
              (Return,SymInt 7)
          ], pc = []})
          (Just (SymState {env = fromList [
              (MethodName "boo30",SMethodType Int),
              (GlobalVars,SGlobalVars ["y","y1","y2","t2"]),
              (FormalParms,SFormalParms ["z"]),
              (VarBindings,SVarBindings (fromList [
                  ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [
                  ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),
              (VarName "t2",SymInt 17),
              (VarName "x1",SymInt 0),
              (VarName "x2",SymInt 0),
              (VarName "y",SymNum 0.0),
              (VarName "y1",SymNum 0.0),
              (VarName "y2",SymNum 0.0),
              (VarName "z",SymVar Int "z"),
              (Return,SymInt 17)
          ], pc = []})))
  ], pc = []}
*/
/*@ normal_behavior
  @   requires z >= 0;
  @   assignable t1, y, y1, y2;
  @   ensures \result == 7;
  @   ensures t1 == 7;
  @   ensures y == 0.0;
  @   ensures y1 == 0.0;
  @   ensures y2 == 0.0;
  @ also
  @ normal_behavior
  @   requires z < 0;
  @   assignable t2, y, y1, y2;
  @   ensures \result == 17;
  @   ensures t2 == 17;
  @   ensures y == 0.0;
  @   ensures y1 == 0.0;
  @   ensures y2 == 0.0;
  @*/
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

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "boo31",SMethodType Int),
    (GlobalVars,SGlobalVars ["z"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [("z",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
    (VarName "x",SymInt 0),
    (VarName "z",SymInt 0),
    (Return,SymInt 0)
  ], pc = []}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 0;
  @   ensures z == 0;
  @*/
public int boo31(){
  z = 0;
  int x = z;
  return x;
}

///////////////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "boo31_2",SMethodType Int),
    (GlobalVars,SGlobalVars ["z","y","y1","y2","t1"]),
    (VarBindings,SVarBindings (fromList [
      ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
      ("z",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),
      ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
    (VarName "t1",SymInt 7),
    (VarName "x",SymInt 0),
    (VarName "y",SymNum 0.0),
    (VarName "y1",SymNum 0.0),
    (VarName "y2",SymNum 0.0),
    (VarName "z",SymInt 0),
    (Return,SymInt 7)
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable t1, y, y1, y2, z;
  @   ensures \result == 7;
  @   ensures t1 == 7;
  @   ensures y == 0.0;
  @   ensures y1 == 0.0;
  @   ensures y2 == 0.0;
  @   ensures z == 0;
  @*/
public int boo31_2(){
  z = 0;
  int x = z;
  return boo30(1);
}

///////////////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "boo31_3",SMethodType Int),
    (GlobalVars,SGlobalVars ["z","y","y1","y2","t2"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("z",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
    (VarName "t2",SymInt 17),
    (VarName "x",SymInt 0),
    (VarName "y",SymNum 0.0),
    (VarName "y1",SymNum 0.0),
    (VarName "y2",SymNum 0.0),
    (VarName "z",SymInt 0),
    (Return,SymInt 0)
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable t2, y, y1, y2, z;
  @   ensures \result == 0;
  @   ensures t2 == 17;
  @   ensures y == 0.0;
  @   ensures y1 == 0.0;
  @   ensures y2 == 0.0;
  @   ensures z == 0;
  @*/
public int boo31_3(){
  z = 0;
  int x = z;
  boo30(-1);
  return z;
}

///////////////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "boo32",SMethodType Int),
    (GlobalVars,SGlobalVars ["y1","y2","y3"]),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
    (VarName "x",SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")),
    (VarName "y1",SymVar Int "y1"),
    (VarName "y2",SymVar Int "y2"),
    (VarName "y3",SymVar Int "y3"),
    (Return,SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3"))
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == (y1 + y2) + y3;
  @*/
public int boo32(){
  int x = y1 + y2 + y3;
  return x;
}

///////////////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "boo32Call",SMethodType Int),
    (GlobalVars,SGlobalVars ["y1","y2","y3"]),
    (VarAssignments,SVarAssignments [("y1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
    (VarName "y1",SymNum 1.0),
    (VarName "y2",SymNum 2.0),
    (VarName "y3",SymNum 3.0),
    (Return,SymInt 6)
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable y1, y2, y3;
  @   ensures \result == 6;
  @   ensures y1 == 1.0;
  @   ensures y2 == 2.0;
  @   ensures y3 == 3.0;
  @*/
public int boo32Call(){
  y1 = 1;
  y2 = 2;
  y3 = 3;
  return boo32();
}

///////////////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "elemAt",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr","pos"]),
    (VarAssignments,SVarAssignments []),
    (VarName "arr",SymVar (Array Int) "arr"),
    (VarName "pos",SymVar Int "pos"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 3}),
     SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos"))
          (SymState {
             env = fromList [
               (MethodName "elemAt",SMethodType Int),
               (FormalParms,SFormalParms ["arr","pos"]),
               (VarName "arr",SymVar (Array Int) "arr"),
               (VarName "pos",SymVar Int "pos"),
               (Return,SException Int "Exception" "not found")
             ], pc = []})
          Nothing),
    (Return,SArrayIndexAccess "arr" (SymVar Int "pos"))
  ], pc = []
}
*/
/*@ exceptional_behavior
  @   requires arr.length <= pos;
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ normal_behavior
  @   requires arr.length > pos;
  @   assignable \nothing;
  @   ensures \result == arr[pos];
  @*/
public int elemAt(int[] arr, int pos) throws Exception {
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "elemAtCall",SMethodType Int),
    (Return,SymInt 4)
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
public int elemAtCall() throws Exception {
  return elemAt(new int[]{6,5,4,7,8},2);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "elemAt2",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["pos"]),
    (VarBindings,SVarBindings (fromList [
      ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
      ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
    (VarName "arr",SymArray (Just Int) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (VarName "pos",SymVar Int "pos"),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),
     SIte (SBin (SymInt 5) Le (SymVar Int "pos"))
          (SymState {
             env = fromList [
               (MethodName "elemAt2",SMethodType Int),
               (FormalParms,SFormalParms ["pos"]),
               (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
               (VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
               (VarName "arr",SymArray (Just Int) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
               (VarName "pos",SymVar Int "pos"),
               (Return,SException Int "Exception" "not found")
             ], pc = []})
          Nothing),
    (Return,SArrayIndexAccess "arr" (SymVar Int "pos"))
  ], pc = []
}
*/
/*@ exceptional_behavior
  @   requires 5 <= pos;
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ normal_behavior
  @   requires 5 > pos;
  @   assignable \nothing;
  @   ensures \result == arr[pos];
  @*/
public int elemAt2(int pos) throws Exception {
  int[] arr = new int[]{6,5,4,7,8};
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "elemAt2Call",SMethodType Int),
    (Return,SymInt 4)
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
public int elemAt2Call() {
  return elemAt2(2);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "elemAt2Call2",SMethodType Int),
    (Return,SException Int "Exception" "not found")
  ], pc = []
}
*/
/*@ exceptional_behavior
  @   requires true;
  @   signals Exception;
  @   assignable \nothing;
  @*/
public int elemAt2Call2() {
  return elemAt2(5);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "elemAt3"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["pos"]),
    (VarAssignments,SVarAssignments []),
    (VarName "pos",SymVar Int "pos"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 8}),
     SIte (SBin (SymVar Int "pos") Lt (SymInt 0))
          (fromList [(MethodHandle,SMethodHandle Int "elemAt3"),(FormalParms,SFormalParms ["pos"]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "too small")]) 
          (Just (fromList [
              (MethodHandle,SMethodHandle Int "elemAt3"),
              (GlobalVars,SGlobalVars []),
              (FormalParms,SFormalParms ["pos"]),
              (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [("arr",(SymArray (Just Int) (Just (SymInt 5)) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8],Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 8}}))]),
              (VarName "arr",SymArray (Just Int) (Just (SymInt 5)) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
              (VarName "pos",SymVar Int "pos"),
              (ScopeRange (SR {branchStart = 4, branchEnd = 2}),
               SIte (SBin (SymInt 5) Le (SymVar Int "pos"))
                    (fromList [(MethodHandle,SMethodHandle Int "elemAt3"),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("arr",(SymArray (Just Int) (Just (SymInt 5)) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8],Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 8}}))]),(VarName "arr",SymArray (Just Int) (Just (SymInt 5)) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")]) Nothing),
              (Return,SArrayIndexAccess (Array Int) "arr" (SymVar Int "pos"))])
          )
    )
  ]
*/
/*@ exceptional_behavior
  @   requires pos < 0;
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ exceptional_behavior
  @   requires pos >= 0 && 5 <= pos;
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ normal_behavior
  @   requires pos >= 0 && 5 > pos;
  @   assignable \nothing;
  @   ensures \result == arr[pos];
  @*/
public int elemAt3(int pos) throws Exception {
  if(pos<0) {
    throw new Exception("too small");
  }
  else {
    int[] arr = new int[]{6,5,4,7,8};
    if(arr.length<=pos) {
      throw new Exception("not found");
    }
    return arr[pos];
  }
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "elemAt4",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
    (VarName "arr",SymArray (Just Int) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (Return,SymInt 7)
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 7;
  @*/
public int elemAt4() {
  int[] arr = {6,5,4,7,8};
  return arr[3];
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "strFun",SMethodType String),
    (VarBindings,SVarBindings (fromList [("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
    (VarName "firstName",SymString "Tarek"),
    (VarName "lastName",SymString "Soliman"),
    (Return,SymString "Tarek Soliman")
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == Tarek Soliman;
  @*/
public String strFun() {
  String firstName = "Tarek";
  String lastName = "Soliman";
  return firstName + " " + lastName;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "voidFun1",SMethodType Void),
    (Return,SymReturnVoid)
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun1() {
  return;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "voidFun2",SMethodType Void)
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun2() {
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "voidFun3",SMethodType Void),
    (GlobalVars,SGlobalVars ["y2","z"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}}),
        ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 10}}),
        ("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 10}}),
        ("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 10}}),
        ("z",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 9}}),
        ("z",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 6, branchEnd = 9}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "x",SBin (SymInt 1) Add (SymVar Int "n")),
    (VarName "y",SymString "is one"),
    (VarName "y2",SymString "is not one"),
    (VarName "z",SymUnknown (String,"z",Nothing) [
        ([(If,SR {branchStart = 6, branchEnd = 9})],7),
        ([(If,SR {branchStart = 6, branchEnd = 9})],8)]),
    (ScopeRange (SR {branchStart = 6, branchEnd = 9}),
     SIte (SBin (SBin (SymInt 1) Add (SymVar Int "n")) Eq (SymInt 1))
          (SymState {env = fromList [
              (MethodName "voidFun3",SMethodType Void),
              (GlobalVars,SGlobalVars ["y2","z"]),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}}),
                  ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
              (VarAssignments,SVarAssignments [
                  ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 10}}),
                  ("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 10}}),
                  ("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 10}}),
                  ("z",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 9}})]),
              (VarName "n",SymVar Int "n"),
              (VarName "x",SBin (SymInt 1) Add (SymVar Int "n")),
              (VarName "y",SymString "is one"),
              (VarName "y2",SymString "is not one"),
              (VarName "z",SBin (SBin (SymFun ToString (SBin (SymInt 1) Add (SymVar Int "n"))) Add (SymString " ")) Add (SymString "is one"))
          ], pc = []}) 
          (Just (SymState {env = fromList [
              (MethodName "voidFun3",SMethodType Void),
              (GlobalVars,SGlobalVars ["y2","z"]),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}}),
                  ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
              (VarAssignments,SVarAssignments [
                  ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 10}}),
                  ("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 10}}),
                  ("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 10}}),
                  ("z",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 6, branchEnd = 9}})]),
              (VarName "n",SymVar Int "n"),
              (VarName "x",SBin (SymInt 1) Add (SymVar Int "n")),
              (VarName "y",SymString "is one"),
              (VarName "y2",SymString "is not one"),
              (VarName "z",SBin (SBin (SymFun ToString (SBin (SymInt 1) Add (SymVar Int "n"))) Add (SymString " ")) Add (SymString "is not one"))
          ], pc = []})))
  ], pc = []}
*/
/*@ normal_behavior
  @   requires (1 + n) == 1;
  @   assignable y2, z;
  @   ensures y2 == "is not one";
  @   ensures z == (toString(1 + n) + " ") + "is one";
  @ also
  @ normal_behavior
  @   requires (1 + n) != 1;
  @   assignable y2, z;
  @   ensures y2 == "is not one";
  @   ensures z == (toString(1 + n) + " ") + "is not one";
  @*/
public void voidFun3(int n) {
  int x;
  String y;
  x = 1 + n;
  y = "is one";
  y2 = "is not one";
  if(x == 1) {
    z = toString(x) + " " + y;
  }
  else {
    z = toString(x) + " " + y2;
  }
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "voidFun3Call",SMethodType Void),
    (GlobalVars,SGlobalVars ["y2","z"]),
    (VarName "y2",SymString "is not one"),
    (VarName "z",SymString "11 is not one"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "11 is not one\n"])
  ], pc = []}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable y2, z;
  @   ensures y2 == "is not one";
  @   ensures z == "11 is not one";
  @*/
public void voidFun3Call() {
  voidFun3(10);
  println(z);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "voidFun4",SMethodType Void),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 2, varFrame = 0}),("z",VarBinding {varDeclAt = 5, varFrame = 0})])),
    (VarName "x",SymInt 1),
    (VarName "y",SymString "is one"),
    (VarName "z",SymString "1 is one"),
    (Actions,SActions ["1 is one\n"])
  ], pc = []
}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun4() {
  int x;
  String y;
  x = 1;
  y = "is one";
  String z = toString(x) + " " + y;
  println(z);
}

////////////////////////////////////////

//DONE
/*
[
    (MethodHandle,SMethodHandle Void "voidFun5"),
    (Actions,SActions [SymString "Before\n",SymString "1 is one\n",SymString "After\n"]),
    (Return,SymReturnVoid)
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun5() {
  println("Before");
  voidFun4();
  println("After");
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "voidFun6"),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SBin (SymVar Int "n") Add (SymInt 1),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "n",SymVar Int "n"),
    (VarName "x",SBin (SymVar Int "n") Add (SymInt 1)),
    (Actions,SActions [
        SymFun Println (SymFun ToString (SymVar Int "n")),
        SymFun Println (SymFun ToString (SBin (SymVar Int "n") Add (SymInt 1))),
        SymFun Println (SymFun ToString (SBin (SymVar Int "n") Add (SymInt 1)))]),
    (Return,SymReturnVoid)
  ]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun6(int n) {
  println(toString(n));
  println(toString(n+1));
  int x = n+1;
  println(toString(x));
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "manyArrs",SMethodType Void),
    (VarBindings,SVarBindings (fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}),("numbers",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 5}})]),
    (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[99, 5]\n"])
  ], pc = []}
*/
public void manyArrs() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  println(numbers);
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "manyArrs2",SMethodType Void),
    (VarBindings,SVarBindings (fromList [("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})])),
    (VarAssignments,SVarAssignments [("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 29}}),("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 11, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 15, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 16, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 17, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 18, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 19, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 20, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 21, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 22, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 23, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 24, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 25, varFrame = SR {branchStart = 0, branchEnd = 29}})]),
    (VarName "brand",SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),
    (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]),
    (VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]),
    (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]),
    (VarName "strs",SymArray (Just (Array String)) (Just 3) [SymNull String,SymString "meow",SymNull String]),
    (Return,SymReturnVoid),
    (Actions,SActions ["[86, 57, 80, 34, 50, 48, 94]\n","[51, 84, 92, 87, 81]\n","[5, 75, 34, 10, 6]\n"])
  ], pc = []}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void manyArrs2() {
  int[] numbers1 = new int[7];
  int[] numbers2 = {40, 55, 63, 17, 22};
  int[] numbers3;
  numbers3 = new int[5];
  String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
  String[] strs = new String[3];
  strs[1] = "meow";
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
  numbers3[4] = 43;
  numbers3[3] = 10;
  numbers3[2] = 34;
  numbers3[1] = 75;
  numbers3[4] = 6;
  numbers3[0] = 5;
  println(numbers1);
  println(numbers2);
  println(numbers3);
}

///////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "manyArrs3",SMethodType (Array Int)),
    (VarBindings,SVarBindings (fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
    (VarName "numbers",SymArray (Just Int) (Just 2) [SymInt 99,SymInt 5]),
    (Return,SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5])
  ], pc = []}
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == [99, 5];
  @*/
public int[] manyArrs3() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  return numbers;
}

///////////////////

//DONE
//JavaMethod
/*
[
 (MethodName "manyArrs4",SMethodType Void),
 (VarBindings,SVarBindings (fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
 (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
 (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]),
 (Return,SymReturnVoid),
 (Actions,SActions ["[99, 0]\n"])
]
*/
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void manyArrs4() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  println(numbers);
}

///////////////////

//DONE
//JavaMethod
/*
fromList [
    (MethodHandle,SMethodHandle SYT.Void "manyArrs5"),
    (VarBindings,SVarBindings (Map.fromList [
        ("brand",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("brand",(SymArray (Just SYT.String) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("brand",(SymArray (Just SYT.String) (Just 5) [SymString "1. Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("brand",(SymArray (Just SYT.String) (Just 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("brand",(SymArray (Just SYT.String) (Just 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("brand",(SymArray (Just SYT.String) (Just 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",SymString "4. Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("brand",(SymArray (Just SYT.String) (Just 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",SymString "4. Volkswagen",SymString "5. Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "brand",SymArray (Just SYT.String) (Just 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",SymString "4. Volkswagen",SymString "5. Skoda"]),
    (LoopConditions (SR {branchStart = 2, branchEnd = 6}),
     SLoopConditions [
         fromList [("brand.length",SymInt 5),("i",SymInt 1)],
         fromList [("brand.length",SymInt 5),("i",SymInt 2)],
         fromList [("brand.length",SymInt 5),("i",SymInt 3)],
         fromList [("brand.length",SymInt 5),("i",SymInt 4)],
         fromList [("brand.length",SymInt 5),("i",SymInt 5)]]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[1. Toyota, 2. Mercedes, 3. BMW, 4. Volkswagen, 5. Skoda]\n"])
  ]
*/
public void manyArrs5() {
  String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
  for(int i=0; i<brand.length; i++) {
    brand[i] = toString(i+1) + ". " + brand[i];
  }
  println(brand);
}

///////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodHandle,SMethodHandle Void "manyArrs6"),
    (VarBindings,SVarBindings (fromList [
        ("brand",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("brand",(SymArray (Just String) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}))]),
    (VarName "brand",SymArray (Just String) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),
    (LoopConditions (SR {branchStart = 2, branchEnd = 6}),
     SLoopConditions [
         fromList [("brand.length",SymInt 5),("i",SymInt 0)],
         fromList [("brand.length",SymInt 5),("i",SymInt 1)],
         fromList [("brand.length",SymInt 5),("i",SymInt 2)],
         fromList [("brand.length",SymInt 5),("i",SymInt 3)],
         fromList [("brand.length",SymInt 5),("i",SymInt 4)]]),
    (Return,SymReturnVoid),
    (Actions,
     SActions [
         SymString "1. Toyota\n",
         SymString "2. Mercedes\n",
         SymString "3. BMW\n",
         SymString "4. Volkswagen\n",
         SymString "5. Skoda\n",
         SymString "[Toyota, Mercedes, BMW, Volkswagen, Skoda]\n"])
  ], logHeader = Header {logScopeDepth = 1, logCounter = [5,3]}
}
*/
public void manyArrs6() {
  String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
  for(int i=0; i<brand.length; i++) {
    println(toString(i+1) + ". " + brand[i]);
  }
  println(brand);
}

///////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "manyArrs7"),
 (GlobalVars,SGlobalVars ["length"]),
 (FormalParms,SFormalParms ["meow"]),
 (VarAssignments,SVarAssignments [("meow",(SymVar (Array String) "meow",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}}))]),
 (VarName "meow",SymVar (Array String) "meow"),
 (ScopeRange (SR {branchStart = 1, branchEnd = 5}),SLoop (Just (Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["meow"], varName = "length"}})) [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "meow"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}]}, binOp = +, expr2 = StringLiteral ". "}, binOp = +, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "meow"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 1},Node {id = 4, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 1}]),
 (Actions,SActions [SymFun Println (SymVar (Array String) "meow")])
]
*/
public void manyArrs7(String[] meow) {
  for(int i=0; i<meow.length; i++) {
    meow[i] = toString(i+1) + ". " + meow[i];
  }
  println(meow);
}

///////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "manyArrs7Call1"),
 (Return,SymReturnVoid),
 (Actions,SActions [SymString "[1. Toyota, 2. Mercedes, 3. BMW, 4. Volkswagen, 5. Skoda]\n"])
]
*/
public void manyArrs7Call1() {
  manyArrs7(new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"});
}

///////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "manyArrs7Call2"),
 (VarBindings,SVarBindings (fromList [("brand",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [("brand",(SymArray (Just String) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
 (VarName "brand",SymArray (Just String) (Just 5) [
     SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",SymString "4. Volkswagen",SymString "5. Skoda"]),
 (Return,SymReturnVoid),
 (Actions,SActions [SymString "[1. Toyota, 2. Mercedes, 3. BMW, 4. Volkswagen, 5. Skoda]\n"])
]
*/
public static void manyArrs7Call2() {
    String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
    manyArrs7(brand);
}

///////////////////

//DONE
//JavaMethod
/*
[
 (MethodName "ifFun",SMethodType Int),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["n"]),
 (VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
 (VarAssignments,SVarAssignments [
     ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
     ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),
     ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),
     ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),
     ("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
 (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
 (VarName "n",SymVar Int "n"),
 (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
 (VarName "x",SymInt 1),
 (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing),
 (Return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))]
*/
/*@ normal_behavior
  @   requires n >= 0;
  @   assignable \nothing;
  @   ensures \result == n + 1;
  @ also
  @ normal_behavior
  @   requires n < 0;
  @   assignable \nothing;
  @   ensures \result == 0 + 1;
  @*/
public int ifFun(int n) {
  int res = 0;
  int m = 0;
  int x = 1;
  if(n>=0) {
    res += n;
    m += 2*n;
  }
  return res+1;
}

/////////////////////

//DONE
//JavaMethod
/*
[
  (MethodName "ifFunCall",SMethodType Int),
  (Return,SymInt 8)
]
*/
public int ifFunCall() {
  return 4+ifFun(3);
}


/////////////////////

//DONE
//JavaMethods
/*
[
 (MethodName "ifFun2",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (FormalParms,SFormalParms ["n"]),
 (VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
 (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
 (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
 (VarName "n",SymVar Int "n"),
 (VarName "res",SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
 (VarName "x",SymInt 1),
 (VarName "y",SymVar Int "y"),
 (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing),
 (Return,SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))
]
*/
public int ifFun2(int n) {
  int res = y;
  int m = 0;
  int x = 1;
  if(n>=0) {
    res += n;
    m += 2*n;
  }
  return res+1;
}

/////////////////////

//DONE
//JavaMethods
/*
[
 (MethodName "ifFun2Call",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (VarName "y",SymGlobalVar Int "y" Nothing),
 (Return,SBin (SymGlobalVar Int "y" Nothing) Add (SymInt 11))
]
*/
public int ifFun2Call() {
  return ifFun2(10);
}

/////////////////////

//DONE
//JavaMethods
/*
[
 (MethodName "ifFun2Call2",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (VarName "y",SymGlobalVar Int "y" Nothing),
 (Return,SBin (SymGlobalVar Int "y" Nothing) Add (SymInt 1))
]
*/
public int ifFun2Call2() {
  return ifFun2(-10);
}

/////////////////////

//DONE
//JavaMethods
/*
SymState {
  env = fromList [
    (MethodName "ifFun3",SMethodType Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [
        ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
        ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
        ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),
        ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),
        ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),
        ("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [
        ([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [
        ([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (VarName "y",SymVar UnknownGlobalVarSymType "y"),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),
     SIte (SBin (SymVar UnknownGlobalVarSymType "y") Ge (SymNum 0.0))
          (SymState {env = fromList [(MethodName "ifFun3",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1),(VarName "y",SymVar UnknownGlobalVarSymType "y")], pc = []})
          Nothing),
    (Return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [
        ([(If,SR {branchStart = 4, branchEnd = 7})],5)])
                 Add
                 (SymInt 1))
  ], pc = []}
*/
public int ifFun3(int n) {
  int res = 0;
  int m = 0;
  int x = 1;
  if(y>=0) {
    res += n;
    m += 2*n;
  }
  return res+1;
}

/////////////////////

//DONE
//JavaMethods
/*
SymState {
  env = fromList [
    (MethodName "ifFun4",SMethodType Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "y",SymUnknown (Int,"y",Just (SymVar Int "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 3}),SIte (SBin (SymVar Int "y") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun4",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymVar Int "y") Add (SymVar Int "n"))], pc = []}) Nothing),
    (Return,SymUnknown (Int,"y",Just (SymVar Int "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)])
  ], pc = []}
*/
public int ifFun4(int n) {
  if(y>=0) {
    y += n;
  }
  return y;
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "ifFun4Call"),
    (GlobalVars,SGlobalVars ["y","z"]),
    (VarAssignments,SVarAssignments [
        ("y",(SymInt 2,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}})),
        ("z",(SymInt 3,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}})),
        ("y",(SymInt (-1),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 13}})),
        ("z",(SymInt (-1),Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 13}})),
        ("y",(SymInt 3,Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 13}})),
        ("z",(SymInt 12,Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 0, branchEnd = 13}}))]),
    (VarName "y",SymInt 12),
    (VarName "z",SymInt 12),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "3\n",SymString "3\n",SymString "-1\n",SymString "-1\n",SymString "12\n",SymString "12\n"])
  ]
*/
public void ifFun4Call() {
  y = 2;
  z = ifFun4(1);
  println(toString(y));
  println(toString(z));
  y = -1;
  z = ifFun4(10);
  println(toString(y));
  println(toString(z));
  y = 3;
  z = ifFun4(9);
  println(toString(y));
  println(toString(z));
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodName "ifFun5",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (FormalParms,SFormalParms ["n"]),
 (VarAssignments,SVarAssignments [
     ("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
     ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),
 (VarName "n",SymVar Int "n"),
 (VarName "y",SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
 (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing),
 (Return,SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])
]
*/
public int ifFun5(int n) {
  y = n;
  if(y>=0) {
    y += n;
  }
  return y;
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodName "ifFun5Call1",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (VarName "y",SymInt 20),
 (Return,SymInt 20)
]
*/
public int ifFun5Call1() {
  return ifFun5(10);
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodName "ifFun5Call2",SMethodType Int),
 (GlobalVars,SGlobalVars ["y"]),
 (VarName "y",SymInt (-10)),
 (Return,SymInt (-10))
]
*/
public int ifFun5Call2() {
  return ifFun5(-10);
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "ifFun6",SMethodType String),
    (GlobalVars,SGlobalVars ["y","m","s","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}}),("s",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
    (VarName "c",SymVar String "c"),
    (VarName "m",SymUnknown (Int,"m",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "n",SymVar Int "n"),
    (VarName "s",SymString "something"),
    (VarName "y",SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownGlobalVarSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 4}),SIte (SBin (SymVar UnknownGlobalVarSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun6",SMethodType String),(GlobalVars,SGlobalVars ["y","m"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "m",SBin (SymVar Int "m") Add (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymNum (-1.0)) Mul (SymVar UnknownGlobalVarSymType "y"))], pc = []}) Nothing),
    (Return,SymVar String "c")], pc = []}
*/
public String ifFun6(int n) {
  if(y>=0) {
    m += n;
    y = (-1) * y;
  }
  s = "something";
  return c;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodHandle,SMethodHandle String "ifFun6Call"),
    (GlobalVars,SGlobalVars ["y","m","c","s"]),
    (VarAssignments,SVarAssignments [
        ("y",(SymInt 5,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("m",(SymInt 1,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("c",(SymString "dangerous",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "c",SymString "dangerous"),
    (VarName "m",SymInt 11),
    (VarName "s",SymString "something"),
    (VarName "y",SymInt (-5)),
    (Return,SymString "6.0 dangerous something6")
  ], logHeader = Header {logScopeDepth = 1, logCounter = [5,7]}
}
*/
public String ifFun6Call() {
  y = 5;
  m = 1;
  c = "dangerous";
  return toString(m+y) + " " + ifFun6(10) + " " + s + toString(m+y);
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle String "ifFun6Call2"),
    (GlobalVars,SGlobalVars ["y","m","c","s"]),
    (VarAssignments,SVarAssignments [
        ("y",(SymNum 5.0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("m",(SymInt 1,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("c",(SymString "dangerous",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "c",SymString "dangerous"),
    (VarName "m",SymInt 11),
    (VarName "s",SymString "something"),
    (VarName "y",SymNum (-5.0)),
    (Return,SymString "dangerous 11")
  ]
*/
public String ifFun6Call2() {
  y = 5;
  m = 1;
  c = "dangerous";
  return ifFun6(10) + " " + toString(m);
}

/////////////////////

//DONE
//JavaMethod
/*
fromList [
  (MethodHandle,SMethodHandle Void "ifFun7"),
  (GlobalVars,SGlobalVars ["v","w","s"]),
  (FormalParms,SFormalParms ["n"]),
  (VarAssignments,SVarAssignments [
      ("v",(SymString "hi",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})),
      ("w",(SymString "bye",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})),
      ("s",(SymString "something",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}}))]),
  (VarName "n",SymVar Int "n"),
  (VarName "s",SymString "something"),
  (VarName "v",SymUnknown (SymVar String "v") [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
  (VarName "w",SymUnknown (SymVar String "w") [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
  (ScopeRange (SR {branchStart = 1, branchEnd = 4}),
   SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0))
        (fromList [
            (MethodHandle,SMethodHandle Void "ifFun7"),
            (GlobalVars,SGlobalVars ["v"]),
            (FormalParms,SFormalParms ["n"]),
            (VarAssignments,SVarAssignments [("v",(SymString "hi",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}))]),
            (VarName "n",SymVar Int "n"),
            (VarName "v",SymString "hi")])
        (Just (fromList [
            (MethodHandle,SMethodHandle Void "ifFun7"),
            (GlobalVars,SGlobalVars ["w"]),
            (FormalParms,SFormalParms ["n"]),
            (VarAssignments,SVarAssignments [("w",(SymString "bye",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}}))]),
            (VarName "n",SymVar Int "n"),
            (VarName "w",SymString "bye")]))),
            (Return,SymReturnVoid)]
*/
public void ifFun7(int n) {
  if(n % 2 == 0) {
    v = "hi";
  }
  else {
    w = "bye";
  }
  s = "something";
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodName "ifFun7Call",SMethodType Void),
 (GlobalVars,SGlobalVars ["v"]),
 (VarName "v",SymString "hi"),
 (Return,SymReturnVoid)
]
*/
public void ifFun7Call() {
  ifFun7(4);
}

/////////////////////

//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "ifFun7Call2",SMethodType Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye"),
    (Return,SymReturnVoid)
  ], pc = []
}
*/
public void ifFun7Call2() {
  ifFun7(4);
  ifFun7(5);
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodName "ifFun7Call3",SMethodType Void),
 (GlobalVars,SGlobalVars ["t","v","w"]),
 (VarName "t",SymVar Int "t"),
 (VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
 (VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
 (Return,SymReturnVoid)
]
*/
public void ifFun7Call3() {
  ifFun7(t);
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodName "ifFun8",SMethodType Void),
 (GlobalVars,SGlobalVars ["v","w"]),
 (FormalParms,SFormalParms ["n"]),
 (VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),
 (VarName "n",SymVar Int "n"),
 (VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 6})],2)]),
 (VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
 (ScopeRange (SR {branchStart = 1, branchEnd = 6}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun8",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi"),(Actions,SActions ["hi\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun8",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye"),(Actions,SActions ["bye\n"])], pc = []})))
]
*/
public void ifFun8(int n) {
  if(n % 2 == 0) {
    v = "hi";
    println(v);
  }
  else {
    w = "bye";
    println(w);
  }
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "ifFun8Call",SMethodType Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye"),
    (Return,SymReturnVoid),
    (Actions,SActions ["hi\n","bye\n","hi\n"])
  ], pc = []
}
*/
public void ifFun8Call() {
  ifFun8(4);
  ifFun8(5);
  ifFun8(6);
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodName "ifFun9",SMethodType Void),
 (GlobalVars,SGlobalVars ["v","w"]),
 (FormalParms,SFormalParms ["n"]),
 (VarAssignments,SVarAssignments [
     ("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),
     ("v",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}}),
     ("w",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}})]),
 (VarName "n",SymVar Int "n"),
 (VarName "v",SymUnknown (String,"v",Nothing) [
     ([(If,SR {branchStart = 1, branchEnd = 6})],2)]),
 (VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 6})],5)]),
 (ScopeRange (SR {branchStart = 1, branchEnd = 6}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun9",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi zu"),(VarName "z",SymInt 3)], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun9",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))
]
*/
public void ifFun9(int n) {
  if(n % 2 == 0) {
    v = "hi";
    int z = 3;
    v += " zu";
  }
  else {
    w = "bye";
  }
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "ifFun10",SMethodType Int),
    (GlobalVars,SGlobalVars ["v","t","i"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}}),
        ("v",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}),
        ("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),
        ("v",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}),
        ("res",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 9}}),
        ("t",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 9}})]),
    (VarName "i",SymVar UnknownGlobalVarSymType "i"),
    (VarName "res",SymInt 0),
    (VarName "t",SymVar UnknownGlobalVarSymType "i"),
    (VarName "v",SymUnknown (String,"v",Just (SymVar String "v")) [
        ([(If,SR {branchStart = 2, branchEnd = 6})],3),
        ([(If,SR {branchStart = 2, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SIte (SBin (SymVar String "v") Eq (SymString "bye")) (SymState {env = fromList [(MethodName "ifFun10",SMethodType Int),(GlobalVars,SGlobalVars ["v"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}}),("v",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "res",SymInt 1),(VarName "v",SymString "zuzu")], pc = []}) Nothing),
    (Return,SymInt 0)
  ], pc = []}
*/
public int ifFun10() {
  int res = 0;
  if(v == "bye") {
    v = "hi";
    res += 1;
    v = "zuzu";
  }
  res = 0;
  t = i;
  return res;
}

/////////////////////

//JavaMethod
/*
[
 (MethodName "ifFun11",SMethodType Int),
 (VarBindings,SVarBindings (fromList [
     ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [
     ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})]),
 (VarName "res",SymInt 0),
 (Return,SymInt 0)
]
*/
public int ifFun11() {
  int res = 0;
  if(false) {
    res += 1;
  }
  return res;
}

/////////////////////

//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "ifFun12",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun12",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "res",SymInt 1)], pc = []}) Nothing),
    (Return,SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])], pc = []}
*/
public int ifFun12(int n) {
  int res = 0;
  if(n >= 0) {
    res += 1;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "succFun",SMethodType Void),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
    (VarName "i",SBin (SymVar Int "i") Add (SymInt 1)),
    (Return,SymReturnVoid)
  ], pc = []
}
*/
public void succFun(int i) {
  i += 1;
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "succFunCall"),
 (VarBindings,SVarBindings (fromList [("n",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
 (VarAssignments,SVarAssignments [("n",(SymInt 2,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
 (VarName "n",SymInt 2),
 (Return,SymReturnVoid),
 (Actions,SActions [SymString "2\n"])
]
*/
public void succFunCall() {
  int n = 2;
  succFun(n);
  println(toString(n));
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "callSuccFun",SMethodType Int),
    (FormalParms,SFormalParms ["n"]),
    (VarName "n",SBin (SymVar Int "n") Add (SymInt 1)),
    (Return,SBin (SymVar Int "n") Add (SymInt 1))
  ], pc = []
}
*/
/*
[
 (MethodHandle,SMethodHandle Int "callSuccFun"),
 (FormalParms,SFormalParms ["n"]),
 (VarName "n",SBin (SymVar Int "n") Add (SymInt 1)),
 (Return,SBin (SymVar Int "n") Add (SymInt 1))
]
*/
public int callSuccFun(int n) {
  succFun(n);
  return n;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {env = fromList [(MethodName "callCallSuccFun",SMethodType Int),(Return,SymInt 5)], pc = []}
*/
public int callCallSuccFun() {
  return callSuccFun(5);
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "wrongSum1",SMethodType Int),
    (GlobalVars,SGlobalVars ["w","t","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}}),("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 3, branchEnd = 12}}),("t",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 3, branchEnd = 12}}),("j",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 3, branchEnd = 12}})]),
    (VarName "j",SymUnknown (Int,"j",Just (SymVar Int "w")) [([(For,SR {branchStart = 3, branchEnd = 12})],10)]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (UnknownGlobalVarSymType,"t",Nothing) [([(For,SR {branchStart = 3, branchEnd = 12})],9)]),
    (VarName "w",SymVar Int "w"),
    (ScopeRange (SR {branchStart = 3, branchEnd = 12}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 3},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 3},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 3},Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 10, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "c"}}}), parent = 3},Node {id = 11, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SymInt 0)
  ], pc = []}
*/
public int wrongSum1(int n) {
  int res = 0;
  int j = w;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    res = 0;
    t = i;
    j = c;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "wrongSum2",SMethodType Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),
        ("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),
        ("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),
        ("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (VarName "v",SymUnknown (String,"v",Nothing) [
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],8),
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral True)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}
*/
public int wrongSum2(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(true) {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    res = 0;
    t = i;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "wrongSum3",SMethodType Int),
    (GlobalVars,SGlobalVars ["t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral False)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}
*/
public int wrongSum3(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(false) {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    res = 0;
    t = i;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "wrongSum4",SMethodType Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (VarName "v",SymUnknown (String,"v",Nothing) [
      ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],8),
      ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "v"}, binOp = ==, expr2 = StringLiteral "bye"})), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}
*/
public int wrongSum4(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(v == "bye") {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    res = 0;
    t = i;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "wrongSum5",SMethodType Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}}),
        ("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 14}}),
        ("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("t",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 14}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [
        ([(For,SR {branchStart = 2, branchEnd = 14})],4),
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],9)]),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 14})],12)]),
    (VarName "v",SymUnknown (String,"v",Nothing) [
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],8),
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 14}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "v"}, binOp = ==, expr2 = StringLiteral "bye"})), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 13, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 14})],4),([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],9)])
  ], pc = []}
*/
public int wrongSum5(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(v == "bye") {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    t = i;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "for1",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)], pc = []}
*/
public int for1(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "for2",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),
        ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),
        ("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [
        ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),
        ([(If,SR {branchStart = 9, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (ScopeRange (SR {branchStart = 9, branchEnd = 11}),SIte (SBin (SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) Mod (SymInt 3)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "for2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) Mul (SymInt 3)),(ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}])], pc = []}) Nothing),
    (Return,SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),([(If,SR {branchStart = 9, branchEnd = 11})],10)])], pc = []}
*/
public int for2(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
    if(i % 2 == 0) {
      res += 1;
    }
  }
  if(res % 3 == 0) {
    res *= 3;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodHandle,SMethodHandle Int "for3"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [
        ("a",(SymInt 10,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})),
        ("a",(SymInt 20,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}})),
        ("a",(SBin (SymUnknown (SymVar Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4)]) Add (SymInt 5),Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 8, branchEnd = 10}})),
        ("a",(SBin (SymUnknown (SymVar Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9)]) Mul (SymInt 3),Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 13, branchEnd = 15}}))]),
    (VarName "a",SymUnknown (SymVar Int "a") [
     ([(If,SR {branchStart = 2, branchEnd = 5})],3),
     ([(If,SR {branchStart = 2, branchEnd = 5})],4),
     ([(For,SR {branchStart = 6, branchEnd = 12}),
       (If,SR {branchStart = 8, branchEnd = 10})],9),
     ([(If,SR {branchStart = 13, branchEnd = 15})],14)]),
    (VarName "n",SymVar Int "n"),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (fromList [(MethodHandle,SMethodHandle Int "for3"),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 10,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),(VarName "a",SymInt 10),(VarName "n",SymVar Int "n")]) (Just (fromList [(MethodHandle,SMethodHandle Int "for3"),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 20,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),(VarName "a",SymInt 20),(VarName "n",SymVar Int "n")]))),
    (ScopeRange (SR {branchStart = 6, branchEnd = 12}),SLoop (Just (Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 8, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 6},Node {id = 11, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 6}]),
    (ScopeRange (SR {branchStart = 13, branchEnd = 15}),SIte (SBin (SBin (SymUnknown (SymVar Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9)]) Mod (SymInt 3)) Eq (SymInt 0)) (fromList [(MethodHandle,SMethodHandle Int "for3"),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 10,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})),("a",(SymInt 20,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}})),("a",(SBin (SymUnknown (SymVar Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4)]) Add (SymInt 5),Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 8, branchEnd = 10}})),("a",(SBin (SymUnknown (SymVar Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9)]) Mul (SymInt 3),Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 13, branchEnd = 15}}))]),(VarName "a",SBin (SymUnknown (SymVar Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9)]) Mul (SymInt 3)),(VarName "n",SymVar Int "n"),(ScopeRange (SR {branchStart = 2, branchEnd = 5}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (fromList [(MethodHandle,SMethodHandle Int "for3"),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 10,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),(VarName "a",SymInt 10),(VarName "n",SymVar Int "n")]) (Just (fromList [(MethodHandle,SMethodHandle Int "for3"),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 20,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),(VarName "a",SymInt 20),(VarName "n",SymVar Int "n")]))),(ScopeRange (SR {branchStart = 6, branchEnd = 12}),SLoop (Just (Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 8, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 6},Node {id = 11, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 6}])]) Nothing),
    (Return,SymUnknown (SymVar Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9),([(If,SR {branchStart = 13, branchEnd = 15})],14)])
  ], logHeader = Header {logScopeDepth = 1, logCounter = [6,7]}}
*/
public int for3(int n) {
  int a;
  if(n % 2 == 0) {
    a = 10;
  }
  else {
    a = 20;
  }
  
  for(int i=n; i>0; i--) {
    if(i % 2 == 0) {
      a += 5;
    }
  }
  
  if(a % 3 == 0) {
    a *= 3;
  }
  
  return a;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodName "sum1",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),("n",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),
    (VarName "n",SymUnknown (Int,"n",Just (SymVar Int "n")) [([(For,SR {branchStart = 2, branchEnd = 6})],5)]),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])], pc = []
}
*/
public int sum1(int n) {
  int res = 0;
  for(; n>0; n--) {
    res += n;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
SymState {
  env = fromList [
    (MethodHandle,SMethodHandle Int "sum4"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),("res",(SymVar Int "n",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})),("n",(SBin (SymVar Int "n") Sub (SymInt 1),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
    (VarName "n",SymUnknown (SymVar Int "n") [([(For,SR {branchStart = 2, branchEnd = 7})],5)]),
    (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 7})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 7}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = -, expr2 = NumberLiteral 1.0}}}), parent = 2},Node {id = 6, nodeData = ForStep Nothing, parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 7})],4)])], logHeader = Header {logScopeDepth = 1, logCounter = [4,7]}
}
*/
public int sum4(int n) {
  int res = 0;
  for(;n>0;) {
    res += n;
     n--;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Int "sum4Call"),
 (Return,SymInt 6)
]
*/
public int sum4Call() {
  return sum4(3);
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle String "sum1Call1"),
 (Return,SymFun
   (UserDefined "sum1Call1")
   (SLoopFailure (SR {branchStart = 2, branchEnd = 6}) 20))
]
*/
public String sum1Call1() {
  return toString(sum1(21));
}

/////////////////////

//DONE
//JavaMethod
/*
[
  (MethodHandle,SMethodHandle String "sum1Call2"),
  (GlobalVars,SGlobalVars ["x"]),
  (VarName "x",SymVar SYT.Int "x"),
  (Return,SymFun ToString (
     (SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])))
  ]
*/
public String sum1Call2() {
  return toString(sum1(x));
}

/////////////////////

//DONE
//JavaMethod
/*
[
  (MethodHandle,SMethodHandle String "sum1Call3"),
  (GlobalVars,SGlobalVars ["x"]),
  (VarAssignments,SVarAssignments [("x",(SymInt 3,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
  (VarName "x",SymInt 3),
  (Return,SymString "6")
  ]
*/
public String sum1Call3() {
  x = 3;
  return toString(sum1(x));
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Int "sum2"),
 (GlobalVars,SGlobalVars []),
 (VarBindings,SVarBindings (fromList [
     ("n",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),
     ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
 (VarAssignments,SVarAssignments [
     ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
     ("n",(SymInt 21,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
     ("res",(SymInt 21,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 7}})),
     ("n",(SymInt 20,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 3, branchEnd = 7}}))]),
 (VarName "n",SymUnknown (SymInt 21) [([(For,SR {branchStart = 3, branchEnd = 7})],6)]),
 (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 3, branchEnd = 7})],5)]),
 (ScopeRange (SR {branchStart = 3, branchEnd = 7}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 3},Node {id = 6, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
 (LoopFailure,SLoopFailure (SR {branchStart = 3, branchEnd = 7}) 20),
 (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 3, branchEnd = 7})],5)])
]
*/
public int sum2() {
  int res = 0;
  int n = 21;
  for(int i=0; n>0; n--) {
    res += n;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Int "getMax"),
 (GlobalVars,SGlobalVars ["length"]),
 (FormalParms,SFormalParms ["arr"]),
 (VarAssignments,SVarAssignments []),
 (VarName "arr",SymVar (Array Int) "arr"),
 (ScopeRange (SR {branchStart = 1, branchEnd = 12}),
  SIte (SBin (SObjAcc ["arr","length"]) Eq (SymInt 0))
       (fromList [
           (MethodHandle,SMethodHandle Int "getMax"),
           (FormalParms,SFormalParms ["arr"]),
           (VarName "arr",SymVar (Array Int) "arr"),
           (Return,SException Int "Exception" "empty array")]) 
       (Just (fromList [
           (MethodHandle,SMethodHandle Int "getMax"),
           (GlobalVars,SGlobalVars ["length"]),
           (FormalParms,SFormalParms ["arr"]),
           (VarBindings,SVarBindings (fromList [
               ("max",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 12}})])),
           (VarAssignments,SVarAssignments [
               ("max",(SArrayIndexAccess (Array Int) "arr" (SymInt 0),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 12}})),
               ("max",(SArrayIndexAccess (Array Int) "arr" (SymInt 1),Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 2}}))]),
           (VarName "arr",SymVar (Array Int) "arr"),
           (VarName "max",SymUnknown (SArrayIndexAccess (Array Int) "arr" (SymInt 0)) [
               ([(If,SR {branchStart = 1, branchEnd = 12}),
                 (For,SR {branchStart = 4, branchEnd = 10}),
                 (If,SR {branchStart = 6, branchEnd = 8})],7)]),
           (ScopeRange (SR {branchStart = 4, branchEnd = 10}),
            SLoop (Just (Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 1.0}}), parent = 1}))
                  (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}})) 
                  [Node {id = 6, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = >, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "max"}})), parent = 4},Node {id = 9, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 4}]),
           (Return,SymUnknown (SArrayIndexAccess (Array Int) "arr" (SymInt 0)) [
               ([(If,SR {branchStart = 1, branchEnd = 12}),
                 (For,SR {branchStart = 4, branchEnd = 10}),
                 (If,SR {branchStart = 6, branchEnd = 8})],7)])]))
 )
]
*/
public static int getMax(int[] arr) throws Exception {
  if(arr.length == 0) {
    throw new Exception("empty array");
  }
  else {
    int max = arr[0];
    for(int i=1; i<arr.length; i++) {
      if(arr[i] > max) {
        max = arr[i];
      }
    }
    return max;
  }
}

/////////////////////

//DONE
//JavaMethod
/*
fromList [(MethodHandle,SMethodHandle Int "getMaxCall"),(Return,SymInt 9)]
*/
public static int getMaxCall() {
  return getMax(new int[] {5,4,6,4,7,8,9,0,1});
}

/////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Bool "arrayBoolean"),
 (FormalParms,SFormalParms ["arr"]),
 (VarName "arr",SymVar (Array Int) "arr"),
 (Return,SBin (SBin (SymVar (Array Int) "arr")
                    Eq
                    (SymNull (Array Int)))
              Or
              (SBin (SObjAcc ["arr","length"]) Le (SymInt 1)))
]
*/
public static boolean arrayBoolean(int[] arr) {
  return arr == null || arr.length <= 1;
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "arrayBooleanCall"),
 (Actions,SActions [SymString "true\n",SymString "false\n",SymString "null"])
]
*/
public static void arrayBooleanCall() {
  println(toString(arrayBoolean(new int[] {5})));
  println(toString(arrayBoolean(new int[] {5,6})));
  println(toString(arrayBoolean(null)));
}

/////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle (Array Int) "tail"),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["arr"]),
 (VarAssignments,SVarAssignments []),
 (VarName "arr",SymVar (Array Int) "arr"),
 (ScopeRange (SR {branchStart = 1, branchEnd = 12}),
  SIte (SBin (SBin (SymVar (Array Int) "arr") Eq (SymNull (Array Int))) Or (SBin (SObjAcc ["arr","length"]) Le (SymInt 1)))
       (fromList [(MethodHandle,SMethodHandle (Array Int) "tail"),(FormalParms,SFormalParms ["arr"]),(VarName "arr",SymVar (Array Int) "arr"),(Return,SException (Array Int) "Exception" "array is too small")])
       (Just (fromList [
           (MethodHandle,SMethodHandle (Array Int) "tail"),
           (GlobalVars,SGlobalVars []),
           (FormalParms,SFormalParms ["arr"]),
           (VarBindings,SVarBindings (fromList [("arr2",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 12}}),("j",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 12}})])),
           (VarAssignments,SVarAssignments [("arr2",(SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Sub (SymInt 1))) [],Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 12}})),("j",(SymInt 0,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 12}})),("arr2",(SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Sub (SymInt 1))) [SArrayIndexAccess (Array Int) "arr" (SymInt 1)],Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 5, branchEnd = 2}})),("j",(SymInt 1,Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 5, branchEnd = 2}}))]),
           (VarName "arr",SymVar (Array Int) "arr"),
           (VarName "arr2",SymUnknown (SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Sub (SymInt 1))) []) [([(If,SR {branchStart = 1, branchEnd = 12}),(For,SR {branchStart = 5, branchEnd = 10})],7)]),
           (VarName "j",SymUnknown (SymInt 0) [([(If,SR {branchStart = 1, branchEnd = 12}),(For,SR {branchStart = 5, branchEnd = 10})],8)]),
           (ScopeRange (SR {branchStart = 5, branchEnd = 10}),SLoop (Just (Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 1.0}}), parent = 1})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}})) [Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr2"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "j"})}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 5},Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 5},Node {id = 9, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 5}]),
 (Return,SymUnknown (SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Sub (SymInt 1))) []) [
     ([(If,SR {branchStart = 1, branchEnd = 12}),(For,SR {branchStart = 5, branchEnd = 10})],7)])])))
]
*/
public static int[] tail(int[] arr) {
  if (arr == null || arr.length <= 1) {
    throw new Exception("array is too small");
  }
  else {
    int[] arr2 = new int[arr.length-1];
    int j = 0;
    for (int i = 1; i<arr.length; i++) {
      arr2[j] = arr[i];
      j++;
    }
    return arr2;
  }
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "tailCall1"),
 (Actions,SActions [SException (Array Int) "Exception" "array is too small"])
]
*/
public static void tailCall1() {
    println(tail(null));
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "tailCall2"),
 (Actions,SActions [SException (Array Int) "Exception" "array is too small"])
]
*/
public static void tailCall2() {
    println(tail(new int[]{}));
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "tailCall3"),
 (Actions,SActions [SymString "[9]\n"])
]
*/
public static void tailCall3() {
    println(tail(new int[]{4, 9}));
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "tailCall4"),
 (Actions,SActions [SymString "[9, 2]\n"])
]
*/
public static void tailCall4() {
    println(tail(new int[]{4, 9, 2}));
}

/////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle (Array Int) "quickSortCall1"),
    (VarBindings,SVarBindings (fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymNull (Array Int),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymNull (Array Int)),
    (Return,SymNull (Array Int))
  ]
*/
public static int[] quickSortCall1() {
  int[] arr = null;
  quickSort(arr);
  return arr;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle (Array Int) "quickSortCall2"),
    (VarBindings,SVarBindings (fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just Int) (Just (SymInt 1)) [SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just Int) (Just (SymInt 1)) [SymInt 7]),
    (Return,SymArray (Just Int) (Just (SymInt 1)) [SymInt 7])
  ]
*/
public static int[] quickSortCall2() {
  int[] arr = new int[] {7};
  quickSort(arr);
  return arr;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle (Array Int) "quickSortCall3"),
    (VarBindings,SVarBindings (fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just Int) (Just (SymInt 5)) [SymInt 1,SymInt 5,SymInt 2,SymInt 4,SymInt 3],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just Int) (Just (SymInt 5)) [SymInt 1,SymInt 2,SymInt 3,SymInt 4,SymInt 5]),
    (Return,SymArray (Just Int) (Just (SymInt 5)) [SymInt 1,SymInt 2,SymInt 3,SymInt 4,SymInt 5])
  ]
*/
public static int[] quickSortCall3() {
  int[] arr = new int[] {1,5,2,4,3};
  quickSort(arr);
  return arr;
}


//DONE
//JavaMethod
public static void quickSort(int[] arr) {
  if (arr == null || arr.length <= 1) {
    return;
  }

  int[] stack = new int[arr.length * 2];
  int top = -1;

  top++;
  stack[top] = 0;
  top++;
  stack[top] = arr.length - 1;

  while (top >= 1) {
    int high = stack[top];
    top--;
    int low = stack[top];
    top--;

    int pivotIndex = partition(arr, low, high);

    if (pivotIndex - 1 > low) {
      top++;
      stack[top] = low;
      top++;
      stack[top] = pivotIndex - 1;
    }

    if (pivotIndex + 1 < high) {
      top++;
      stack[top] = pivotIndex + 1;
      top++;
      stack[top] = high;
    }
  }
}

/////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "doubleArrayElems"),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["arr"]),
 (VarAssignments,SVarAssignments [
     ("arr",(SymVar (Array Int) "arr",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
 (VarName "arr",SymVar (Array Int) "arr"),
 (ScopeRange (SR {branchStart = 1, branchEnd = 6}),
  SLoop (Just (Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
        (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
        [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 1},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "x"}}}}), parent = 1},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 1}]),
 (Actions,SActions [SymFun Println (SymVar (Array Int) "arr")])
]
*/
public static void doubleArrayElems(int[] arr) {
  for(int i=0; i<arr.length; i++) {
    int x = arr[i];
    arr[i] += x;
  }
  println(arr);
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "doubleArrayElemsCall"),
 (Actions,SActions [SymString "[2, 4, 6]\n"])
]
*/
public static void doubleArrayElemsCall() {
  doubleArrayElems(new int[]{1,2,3});
}

/////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "doubleArrayElems2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (fromList [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("i",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),("arr",(SymVar (Array Int) "arr",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),("i",(SymInt 1,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "arr",SymVar (Array Int) "arr"),
    (VarName "i",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}})) [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 2},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "x"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}]),
    (Actions,SActions [SymFun Println (SymVar (Array Int) "arr")])
]
*/
public static void doubleArrayElems2(int[] arr) {
  int i = 0;
  while(i<arr.length) {
    int x = arr[i];
    arr[i] += x;
    i++;
  }
  println(arr);
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "doubleArrayElems2Call"),
    (Actions,SActions [SymString "[2, 4, 6]\n"])
  ]
*/
public static void doubleArrayElems2Call() {
  doubleArrayElems2(new int[]{1,2,3});
}

/////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "partition"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr","low","high"]),
    (VarBindings,SVarBindings (fromList [
        ("i",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 12}}),
        ("pivot",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("pivot",(SArrayIndexAccess (Array Int) "arr" (SymVar Int "high"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})),
        ("i",(SBin (SymVar Int "low") Sub (SymInt 1),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 12}})),
        ("i",(SymVar Int "low",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 5, branchEnd = 8}}))]),
    (VarName "arr",SymVar (Array Int) "arr"),
    (VarName "high",SymVar Int "high"),
    (VarName "i",SymUnknown (SBin (SymVar Int "low") Sub (SymInt 1)) [
        ([(For,SR {branchStart = 3, branchEnd = 10}),(If,SR {branchStart = 5, branchEnd = 8})],6)]),
    (VarName "low",SymVar Int "low"),
    (VarName "pivot",SArrayIndexAccess (Array Int) "arr" (SymVar Int "high")),
    (ScopeRange (SR {branchStart = 3, branchEnd = 10}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "j"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "low"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "high"}})) [Node {id = 5, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "j"})}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pivot"}})), parent = 3},Node {id = 9, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SBin (SymUnknown (SBin (SymVar Int "low") Sub (SymInt 1)) [([(For,SR {branchStart = 3, branchEnd = 10}),(If,SR {branchStart = 5, branchEnd = 8})],6)]) Add (SymInt 1))
]
*/
private static int partition(int[] arr, int low, int high) {
  int pivot = arr[high];
  int i = low - 1;
  for (int j = low; j < high; j++) {
    if (arr[j] < pivot) {
      i++;
      swap(arr, i, j);
    }
  }
  swap(arr, i + 1, high);
  return i + 1;
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "partitionCall1"),
 (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("arr",(SymArray (Just Int) (Just 1) [SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
 (VarName "arr",SymArray (Just Int) (Just 1) [SymInt 7]),
 (VarName "x",SymInt 0),
 (Actions,SActions [SymString "[7]\n",SymString "0\n"])
]
*/
private static void partitionCall1() {
  int[] arr = {7};
  int x = partition(arr,0,0);
  println(arr);
  println(toString(x));
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "partitionCall2"),
 (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("arr",(SymArray (Just Int) (Just 2) [SymInt 9,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
 (VarName "arr",SymArray (Just Int) (Just 2) [SymInt 7,SymInt 9]),
 (VarName "x",SymInt 0),
 (Actions,SActions [SymString "[7, 9]\n",SymString "0\n"])
]
*/
private static void partitionCall2() {
  int[] arr = {9,7};
  int x = partition(arr,0,1);
  println(arr);
  println(toString(x));
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "partitionCall3"),
 (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("arr",(SymArray (Just Int) (Just 2) [SymInt 3,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 1,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
 (VarName "arr",SymArray (Just Int) (Just 2) [SymInt 3,SymInt 7]),
 (VarName "x",SymInt 1),
 (Actions,SActions [SymString "[3, 7]\n",SymString "1\n"])
]
*/
private static void partitionCall3() {
  int[] arr = {3,7};
  int x = partition(arr,0,1);
  println(arr);
  println(toString(x));
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "partitionCall4"),
 (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("arr",(SymArray (Just Int) (Just 3) [SymInt 9,SymInt 3,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 1,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
 (VarName "arr",SymArray (Just Int) (Just 3) [SymInt 3,SymInt 7,SymInt 9]),
 (VarName "x",SymInt 1),
 (Actions,SActions [SymString "[3, 7, 9]\n",SymString "1\n"])
]
*/
private static void partitionCall4() {
  int[] arr = {9,3,7};
  int x = partition(arr,0,2);
  println(arr);
  println(toString(x));
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "partitionCall5"),
 (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("arr",(SymArray (Just Int) (Just 3) [SymInt 1,SymInt 2,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 2,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
 (VarName "arr",SymArray (Just Int) (Just 3) [SymInt 1,SymInt 2,SymInt 7]),
 (VarName "x",SymInt 2),
 (Actions,SActions [SymString "[1, 2, 7]\n",SymString "2\n"])
]
*/
private static void partitionCall5() {
  int[] arr = {1,2,7};
  int x = partition(arr,0,2);
  println(arr);
  println(toString(x));
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "partitionCall6"),
 (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [("arr",(SymArray (Just Int) (Just 3) [SymInt 9,SymInt 8,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("x",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
 (VarName "arr",SymArray (Just Int) (Just 3) [SymInt 7,SymInt 8,SymInt 9]),
 (VarName "x",SymInt 0),
 (Actions,SActions [SymString "[7, 8, 9]\n",SymString "0\n"])
]
*/
private static void partitionCall6() {
  int[] arr = {9,8,7};
  int x = partition(arr,0,2);
  println(arr);
  println(toString(x));
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "swap"),
 (FormalParms,SFormalParms ["arr","i","j"]),
 (VarBindings,SVarBindings (fromList [("temp",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
 (VarAssignments,SVarAssignments [
     ("temp",(SArrayIndexAccess (Array Int) "arr" (SymVar Int "i"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
     ("arr",(SymVar (Array Int) "arr",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})),
     ("arr",(SymVar (Array Int) "arr",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
 (VarName "arr",SymVar (Array Int) "arr"),
 (VarName "i",SymVar Int "i"),
 (VarName "j",SymVar Int "j"),
 (VarName "temp",SArrayIndexAccess (Array Int) "arr" (SymVar Int "i"))
]
*/
private static void swap(int[] arr, int i, int j) {
  int temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "swapCall"),
 (VarBindings,SVarBindings (fromList [
     ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [
     ("arr",(SymArray (Just Int) (Just 9) [SymInt 5,SymInt 4,SymInt 6,SymInt 4,SymInt 7,SymInt 8,SymInt 9,SymInt 0,SymInt 1],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
 (VarName "arr",SymArray (Just Int) (Just 9) [SymInt 4,SymInt 5,SymInt 6,SymInt 4,SymInt 7,SymInt 8,SymInt 9,SymInt 0,SymInt 1])
]
*/
private static void swapCall() {
  int[] arr = new int[] {5,4,6,4,7,8,9,0,1};
  swap(arr,0,1);
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "bubbleSortCall"),
 (VarBindings,SVarBindings (fromList [
     ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
 (VarAssignments,SVarAssignments [
     ("arr",(SymArray (Just Int) (Just 9) [SymInt 5,SymInt 4,SymInt 6,SymInt 4,SymInt 7,SymInt 8,SymInt 9,SymInt 0,SymInt 1],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
 (VarName "arr",SymArray (Just Int) (Just 9) [SymInt 0,SymInt 1,SymInt 4,SymInt 4,SymInt 5,SymInt 6,SymInt 7,SymInt 8,SymInt 9]),
 (Return,SymArray (Just Int) (Just 9) [SymInt 0,SymInt 1,SymInt 4,SymInt 4,SymInt 5,SymInt 6,SymInt 7,SymInt 8,SymInt 9])
]
*/
public static void bubbleSortCall() {
  int[] arr = new int[] {5,4,6,4,7,8,9,0,1};
  bubbleSort(arr);
  return arr;
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Void "bubbleSort"),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["arr"]),
 (VarBindings,SVarBindings (fromList [
     ("n",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})])),
 (VarAssignments,SVarAssignments [
     ("n",(SObjAcc ["arr","length"],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})),
     ("arr",(SymVar (Array Int) "arr",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 6, branchEnd = 10}})),
     ("arr",(SymVar (Array Int) "arr",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 10}}))]),
 (VarName "arr",SymUnknown (SymVar (Array Int) "arr") [
     ([(For,SR {branchStart = 2, branchEnd = 14}),(For,SR {branchStart = 4, branchEnd = 12}),(If,SR {branchStart = 6, branchEnd = 10})],8),
     ([(For,SR {branchStart = 2, branchEnd = 14}),(For,SR {branchStart = 4, branchEnd = 12}),(If,SR {branchStart = 6, branchEnd = 10})],9)]),
 (VarName "n",SObjAcc ["arr","length"]),
 (ScopeRange (SR {branchStart = 2, branchEnd = 14}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = -, expr2 = NumberLiteral 1.0}})) [Node {id = 4, nodeData = ForInitialization (Just (AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "j"}, assEright = NumberLiteral 0.0})), parent = 2},Node {id = 13, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 2}])
]
*/
public static void bubbleSort(int[] arr) {
  int n = arr.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Bool "isAscending1"),
 (GlobalVars,SGlobalVars ["length"]),
 (FormalParms,SFormalParms ["arr"]),
 (VarBindings,SVarBindings (fromList [
     ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),
 (VarAssignments,SVarAssignments [
     ("res",(SBool True,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})),
     ("res",(SBool False,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}))]),
 (VarName "arr",SymVar (Array Int) "arr"),
 (VarName "res",SymUnknown (SBool True) [
     ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]),
 (ScopeRange (SR {branchStart = 2, branchEnd = 8}),
  SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
        (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = -, expr2 = NumberLiteral 1.0}}))
        [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = >, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0})}})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
 (Return,SymUnknown (SBool True) [
     ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)])
]
*/
public boolean isAscending1(int[] arr) {
  boolean res = true;
  for(int i = 0; i<arr.length-1; i++) {
    if(arr[i] > arr[i+1]) {
      res = false;
    }
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Bool "isAscending2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarAssignments,SVarAssignments []),
    (VarName "arr",SymVar (Array Int) "arr"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 7}),
     SLoop (Just (Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = -, expr2 = NumberLiteral 1.0}}))
           [Node {id = 3, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = >, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0})}})), parent = 1},Node {id = 6, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 1}]),
    (Return,SBool True)
  ]
*/
public boolean isAscending2(int[] arr) {
  for(int i = 0; i<arr.length-1; i++) {
    if(arr[i] > arr[i+1]) {
      return false;
    }
  }
  return true;
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "isAscending1Call"),
    (VarBindings,SVarBindings (fromList [("arr1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("arr2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("arr1",(SymArray (Just Int) (Just 6) [SymInt 1,SymInt 2,SymInt 4,SymInt 6,SymInt 7,SymInt 99],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("arr2",(SymArray (Just Int) (Just 6) [SymInt 1,SymInt 2,SymInt 4,SymInt 7,SymInt 6,SymInt 99],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr1",SymArray (Just Int) (Just 6) [SymInt 1,SymInt 2,SymInt 4,SymInt 6,SymInt 7,SymInt 99]),
    (VarName "arr2",SymArray (Just Int) (Just 6) [SymInt 1,SymInt 2,SymInt 4,SymInt 7,SymInt 6,SymInt 99]),
    (Actions,SActions [SymString "true\n",SymString "false\n"])
  ]
*/
public void isAscending1Call() {
  int[] arr1 = new int[]{1,2,4,6,7,99};
  int[] arr2 = new int[]{1,2,4,7,6,99};
  println(toString(isAscending1(arr1)));
  println(toString(isAscending1(arr2)));
}

/////////////////////

//DONE
/*
[
    (MethodHandle,SMethodHandle Void "isAscending2Call"),
    (VarBindings,SVarBindings (fromList [
        ("arr1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("arr2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("arr1",(SymArray (Just Int) (Just (SymInt 6)) [SymInt 1,SymInt 2,SymInt 4,SymInt 6,SymInt 7,SymInt 99],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("arr2",(SymArray (Just Int) (Just (SymInt 6)) [SymInt 1,SymInt 2,SymInt 4,SymInt 7,SymInt 6,SymInt 99],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr1",SymArray (Just Int) (Just (SymInt 6)) [SymInt 1,SymInt 2,SymInt 4,SymInt 6,SymInt 7,SymInt 99]),
    (VarName "arr2",SymArray (Just Int) (Just (SymInt 6)) [SymInt 1,SymInt 2,SymInt 4,SymInt 7,SymInt 6,SymInt 99]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "true\n",SymString "false\n"])
  ]
*/
public void isAscending2Call() {
  int[] arr1 = new int[]{1,2,4,6,7,99};
  int[] arr2 = new int[]{1,2,4,7,6,99};
  println(toString(isAscending2(arr1)));
  println(toString(isAscending2(arr2)));
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle (Array Int) "copyArray"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (fromList [("copy",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [("copy",(SymArray (Just Int) (Just (SObjAcc ["arr","length"])) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})),("copy",(SymArray (Just Int) (Just (SObjAcc ["arr","length"])) [SArrayIndexAccess (Array Int) "arr" (SymInt 0)],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "arr",SymVar (Array Int) "arr"),
    (VarName "copy",SymUnknown (SymArray (Just Int) (Just (SObjAcc ["arr","length"])) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "copy"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymArray (Just Int) (Just (SObjAcc ["arr","length"])) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])
  ]
*/
public int[] copyArray(int[] arr) {
  int[] copy = new int[arr.length];
  for(int i=0; i<arr.length; i++) {
    copy[i] = arr[i];
  }
  return copy;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "copyArrayCall"),
    (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("c",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("arr",(SymArray (Just Int) (Just (SymInt 4)) [SymInt 1,SymInt 4,SymInt 6,SymInt 8],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),("c",(SymArray (Just Int) (Just (SymInt 4)) [SymInt 1,SymInt 4,SymInt 6,SymInt 8],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr",SymArray (Just Int) (Just (SymInt 4)) [SymInt 1,SymInt 4,SymInt 6,SymInt 8]),
    (VarName "c",SymArray (Just Int) (Just (SymInt 4)) [SymInt 1,SymInt 4,SymInt 6,SymInt 8]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[1, 4, 6, 8]\n",SymString "[1, 4, 6, 8]\n"])
  ]
*/
public void copyArrayCall() {
  int[] arr = new int[]{1,4,6,8};
  int[] c = copyArray(arr);
  println(arr);
  println(c);
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle (Array Int) "addElemRight"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr","elem"]),
    (VarBindings,SVarBindings (fromList [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Add (SymInt 1))) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("res",(SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Add (SymInt 1))) [SArrayIndexAccess (Array Int) "arr" (SymInt 0)],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("res",(SymUnknown (SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Add (SymInt 1))) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)],Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 8}}))]),
    (VarName "arr",SymVar (Array Int) "arr"),
    (VarName "elem",SymVar Int "elem"),
    (VarName "res",SymUnknown (SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Add (SymInt 1))) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "res"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Add (SymInt 1))) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])
  ]
*/
public int[] addElemRight(int[] arr, int elem) {
  int[] res = new int[arr.length + 1];
  for(int i=0; i<arr.length; i++) {
    res[i] = arr[i];
  }
  res[arr.length] = elem;
  return res;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "addElemRightCall"),
    (VarBindings,SVarBindings (fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just Int) (Just (SymInt 4)) [SymInt 1,SymInt 2,SymInt 3,SymInt 4],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just Int) (Just (SymInt 4)) [SymInt 1,SymInt 2,SymInt 3,SymInt 4]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[1, 2, 3, 4]\n"])
  ]
*/
public void addElemRightCall() {
  int[] arr = addElemRight(new int[]{1,2,3},4);
  println(arr);
}

/////////////////////

public boolean asd(int[] arr) {
  int[] res = new int[0];
  for(int i=0; i<arr.length; i++) {
    if(arr[i] % 2 == 0) {
      int[] temp = new int[res.length+1];
      for(int j=0; j<=i; j++) {}
      return true;
    }
  }
  return false;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle (Array Int) "removeAtPos"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr","pos"]),
    (VarBindings,SVarBindings (fromList [
        ("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 12}}),
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Sub (SymInt 1))) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})),
        ("j",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 12}})),
        ("res",(SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Sub (SymInt 1))) [SArrayIndexAccess (Array Int) "arr" (SymInt 0)],Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 3, branchEnd = 11}})),
        ("j",(SymInt 1,Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 3, branchEnd = 11}}))]),
    (VarName "arr",SymVar (Array Int) "arr"),
    (VarName "j",SymUnknown (SymInt 0) [([(For,SR {branchStart = 3, branchEnd = 11})],9)]),
    
    (VarName "pos",SymVar Int "pos"),
    (VarName "res",SymUnknown (SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Sub (SymInt 1))) []) [([(For,SR {branchStart = 3, branchEnd = 11})],8)]),
    (ScopeRange (SR {branchStart = 3, branchEnd = 11}),
     SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 5, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = ==, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}})), parent = 3},Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "res"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "j"})}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 3},Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 3},Node {id = 10, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SymUnknown (SymArray (Just Int) (Just (SBin (SObjAcc ["arr","length"]) Sub (SymInt 1))) []) [([(For,SR {branchStart = 3, branchEnd = 11})],8)])
  ]
*/
public int[] removeAtPos(int[] arr, int pos) {
  int[] res = new int[arr.length-1];
  int j = 0;
  for(int i=0; i<arr.length; i++) {
    if(i == pos) {
      continue;
    }
    res[j] = arr[i];
    j++;
  }
  return res;
}

//DONE
//JavaMethod
/*
[
  (MethodHandle,SMethodHandle Void "removeAtPosCall1"),
  (VarBindings,SVarBindings (fromList [
      ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
  (VarAssignments,SVarAssignments [
      ("arr",(SymArray (Just Int) (Just (SymInt 2)) [SymInt 1,SymInt 3],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
  (VarName "arr",SymArray (Just Int) (Just (SymInt 2)) [SymInt 1,SymInt 3]),
  (Return,SymReturnVoid),
  (Actions,SActions [SymString "[1, 3]\n"])
  ]
*/
public void removeAtPosCall1() {
  int[] arr = removeAtPos(new int[]{1,2,3},1);
  println(arr);
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "removeAtPosCall2"),
    (VarBindings,SVarBindings (fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just Int) (Just (SymInt 1)) [SymInt 9],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just Int) (Just (SymInt 1)) [SymInt 9]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[9]\n"])
  ]
*/
public void removeAtPosCall2() {
  int[] arr = removeAtPos(new int[]{4,9},0);
  println(arr);
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle (Array Int) "takeWhileAsLongAsEven"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (fromList [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymArray (Just Int) (Just (SymInt 0)) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})),
        ("res",(SymArray (Just Int) (Just (SymInt 1)) [SArrayIndexAccess (Array Int) "arr" (SymInt 0)],Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 4, branchEnd = 16}}))]),
    (VarName "arr",SymVar (Array Int) "arr"),
    (VarName "res",SymUnknown (SymArray (Just Int) (Just (SymInt 0)) []) [([(For,SR {branchStart = 2, branchEnd = 18}),(If,SR {branchStart = 4, branchEnd = 16})],14)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 18}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 17, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymArray (Just Int) (Just (SymInt 0)) []) [([(For,SR {branchStart = 2, branchEnd = 18}),(If,SR {branchStart = 4, branchEnd = 16})],14)])
  ]
*/
public int[] takeWhileAsLongAsEven(int[] arr) {
  int[] res = new int[0];
  for(int i=0; i<arr.length; i++) {
    if(arr[i] % 2 == 0) {
      int[] temp = new int[res.length+1];
      for(int j=0; j<=i; j++) {
        if(j<i) {
         temp[j] = res[j];
        }
        else {
          temp[j] = arr[i];
        }
      }
      res = temp;
    }
    else {
      return res;
    }
  }
  return res;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "takeWhileAsLongAsEvenCall1"),
    (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just Int) (Just (SymInt 4)) [SymInt 2,SymInt 4,SymInt 6,SymInt 8],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just Int) (Just (SymInt 4)) [SymInt 2,SymInt 4,SymInt 6,SymInt 8]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[2, 4, 6, 8]\n"])
  ]
*/
public void takeWhileAsLongAsEvenCall1() {
  int[] arr = takeWhileAsLongAsEven(new int[]{2,4,6,8});
  println(arr);
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "takeWhileAsLongAsEvenCall2"),
    (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just Int) (Just (SymInt 2)) [SymInt 2,SymInt 4],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just Int) (Just (SymInt 2)) [SymInt 2,SymInt 4]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[2, 4]\n"])
  ]
*/
public void takeWhileAsLongAsEvenCall2() {
  int[] arr = takeWhileAsLongAsEven(new int[]{2,4,7,6,8});
  println(arr);
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle String "replicate"),
 (GlobalVars,SGlobalVars []),
 (FormalParms,SFormalParms ["n","v"]),
 (VarBindings,SVarBindings (fromList [
     ("core",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
     ("res",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
 (VarAssignments,SVarAssignments [
     ("core",(SymVar String "v",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
     ("res",(SymString "",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
     ("res",(SBin (SymString "") Add (SymVar String "v"),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 7}}))]),
 (VarName "core",SymVar String "v"),
 (VarName "n",SymVar Int "n"),
 (VarName "res",SymUnknown (SymString "") [
     ([(For,SR {branchStart = 3, branchEnd = 7})],5)]),
 (VarName "v",SymVar String "v"),
 (ScopeRange (SR {branchStart = 3, branchEnd = 7}),
  SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "core"}}}}), parent = 3},Node {id = 6, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
 (Return,SymUnknown (SymString "") [([(For,SR {branchStart = 3, branchEnd = 7})],5)])
]
*/
public String replicate(int n,String v) {
  String core = v;
  String res = "";
  for(int i=n; i>0; i--) {
    res += core;
  }
  return res;
}

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle String "replicateCall"),
 (VarBindings,SVarBindings (fromList [
     ("str",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
 (VarAssignments,SVarAssignments [
     ("str",(SymString "qwqwqwqwqw",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
 (VarName "str",SymString "qwqwqwqwqw"),
 (Return,SymString "qwqwqwqwqw")
]
*/
public String replicateCall() {
  String str = replicate(5,"qw");
  return str;
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sum3"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("res",(SymVar Int "n",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 2, branchEnd = 9}})),
        ("n",(SBin (SymVar Int "n") Sub (SymInt 1),Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 2, branchEnd = 9}}))]),
    (VarName "n",SymUnknown (SymVar Int "n") [([(For,SR {branchStart = 2, branchEnd = 9})],8)]),
    (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 9}),
     SLoop Nothing
           Nothing
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = <=, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 8, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)])
  ]
*/
public int sum3(int n) {
  int res = 0;
  for(;; n--) {
    if (n<=0) {
      break;
    }
    res += n;
  }
  return res;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sum3Call1"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 0),
    (Return,SymInt 0)
  ]
*/
public int sum3Call1() {
  int x = sum3(0);
  return x;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sum3Call2"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 6,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 6),
    (Return,SymInt 6)
  ]
*/
public int sum3Call2() {
  int x = sum3(3);
  return x;
}

/////////////////////

//DONE
//JavaMethod
/*
fromList [
  (MethodHandle,SMethodHandle Int "sum1_While"),
  (GlobalVars,SGlobalVars []),
  (FormalParms,SFormalParms ["n"]),
  (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
  (VarAssignments,SVarAssignments [("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})),("res",(SymVar Int "n",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})),("n",(SBin (SymVar Int "n") Sub (SymInt 1),Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
  (VarName "n",SymUnknown (SymVar Int "n") [([(For,SR {branchStart = 2, branchEnd = 5})],4)]),
  (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 5})],3)]),
  (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = -, expr2 = NumberLiteral 1.0}}}), parent = 2}]),
  (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 5})],3)])
]
*/
public int sum1_While(int n) {
  int res = 0;
  while(n>0) {
    res += n;
    n--;
  }
  return res;
}

/////////////////////

//DONE
//JavaMethod
/*
[
 (MethodHandle,SMethodHandle Int "sum1_WhileCall"),
 (Return,SymInt 6)
]
*/
public int sum1_WhileCall() {
  return sum1_While(3);
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sum1_While2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),
    (VarAssignments,SVarAssignments [("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})),("res",(SymVar Int "n",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 8}})),("n",(SBin (SymVar Int "n") Sub (SymInt 1),Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 8}}))]),
    (VarName "n",SymUnknown (SymVar Int "n") [([(For,SR {branchStart = 2, branchEnd = 8})],4)]),
    (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop Nothing (Just (BoolLiteral True)) [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = -, expr2 = NumberLiteral 1.0}}}), parent = 2},Node {id = 5, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = <=, expr2 = NumberLiteral 0.0})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8})],3)])
  ]
*/
public int sum1_While2(int n) {
  int res = 0;
  while(true) {
    res += n;
    n--;
    if(n<=0) {
      break;
    }
  }
  return res;
}

//DONE
//JavaMethod
/*
[(MethodHandle,SMethodHandle Int "sum1_While2Call1"),(Return,SymInt 0)]
*/
public int sum1_While2Call1() {
  return sum1_While2(0);
}

//DONE
//JavaMethod
/*
[(MethodHandle,SMethodHandle Int "sum1_While2Call2"),(Return,SymInt 6)]
*/
public int sum1_While2Call2() {
  return sum1_While2(3);
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sumOddNums"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["nums"]),
    (VarBindings,SVarBindings (fromList [
        ("sum",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("sum",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("sum",(SArrayIndexAccess (Array Int) "nums" (SymInt 0),Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 2, branchEnd = 9}}))]),
    (VarName "nums",SymVar (Array Int) "nums"),
    (VarName "sum",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 9}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["nums"], varName = "length"}}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "nums"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = +, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "nums"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 2},Node {id = 8, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)])
  ]
*/
public int sumOddNums(int[] nums) {
  int sum = 0;
  for (int i=0; i<nums.length; i++) {
      if (nums[i] % 2 == 0) {
          continue;
      }
      sum += nums[i];
  }
  return sum;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sumOddNumsCall1"),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 4,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 4),
    (Return,SymInt 4)
  ]
*/
public int sumOddNumsCall1() {
  int x = sumOddNums(new int[]{1,2,3,4});
  return x;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sumOddNumsCall2"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 4,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 4),
    (Return,SymInt 4)
  ]
*/
public int sumOddNumsCall2() {
  int x = sumOddNums(new int[]{1,3});
  return x;
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sumUntilNegative"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["nums"]),
    (VarBindings,SVarBindings (fromList [
        ("sum",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("sum",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("sum",(SArrayIndexAccess (Array Int) "nums" (SymInt 0),Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 2, branchEnd = 9}}))]),
    (VarName "nums",SymVar (Array Int) "nums"),
    (VarName "sum",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 9}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["nums"], varName = "length"}}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "nums"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = <, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = +, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "nums"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 2},Node {id = 8, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)])
  ]
*/
public int sumUntilNegative(int[] nums) {
    int sum = 0;
    for (int i=0; i<nums.length; i++) {
        if (nums[i] < 0) {
            break;
        }
        sum += nums[i];
    }
    return sum;
}

//DONE
//JavaMethod
/*
[(MethodHandle,SMethodHandle Int "sumUntilNegativeCall1"),(Return,SymInt 0)]
*/
public int sumUntilNegativeCall1() {
  return sumUntilNegative(new int[]{});
}

//DONE
//JavaMethod
/*
[(MethodHandle,SMethodHandle Int "sumUntilNegativeCall2"),(Return,SymInt 5)]
*/
public int sumUntilNegativeCall2() {
  return sumUntilNegative(new int[]{4,1,-2,1});
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "processArray1"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (fromList [
        ("sum",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("sum",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("sum",(SArrayIndexAccess (Array Int) "arr" (SymInt 0),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})),
        ("sum",(SBin (SymInt (-1)) Mul (SArrayIndexAccess (Array Int) "arr" (SymInt 0)),Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}}))]),
    (VarName "arr",SymVar (Array Int) "arr"),
    (VarName "sum",SymUnknown (SymInt 0) [
        ([(For,SR {branchStart = 2, branchEnd = 9}),(If,SR {branchStart = 4, branchEnd = 7})],5),
        ([(For,SR {branchStart = 2, branchEnd = 9}),(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 9}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 8, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [
        ([(For,SR {branchStart = 2, branchEnd = 9}),(If,SR {branchStart = 4, branchEnd = 7})],5),
        ([(For,SR {branchStart = 2, branchEnd = 9}),(If,SR {branchStart = 4, branchEnd = 7})],6)])
  ]
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

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "processArray1Call"),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 2,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 2),
    (Return,SymInt 2)
  ]
*/
public int processArray1Call() {
  int x = processArray1(new int[]{1,2,3,4});
  return x;
}

/////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Bool "isEmpty"),
    (FormalParms,SFormalParms ["arr"]),
    (VarName "arr",SymVar (Array Int) "arr"),
    (Return,SBin (SObjAcc ["arr","length"]) Eq (SymInt 0))
  ]
*/
public boolean isEmpty(int[] arr) {
  return arr.length == 0;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Bool "callIsEmpty"),
    (Return,SBool True)
  ]
*/
public boolean callIsEmpty() {
  return isEmpty(new int[]{});
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Bool "callIsNotEmpty"),
    (Return,SBool False)
  ]
*/
public boolean callIsNotEmpty() {
  return isEmpty(new int[]{1,2,3});
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle (Array Int) "fillArray"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["size","elem"]),
    (VarBindings,SVarBindings (fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just Int) (Just (SymVar Int "size")) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})),
        ("arr",(SymArray (Just Int) (Just (SymVar Int "size")) [SymVar Int "elem"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "arr",SymUnknown (SymArray (Just Int) (Just (SymVar Int "size")) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (VarName "elem",SymVar Int "elem"),
    (VarName "size",SymVar Int "size"),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "size"}}))
           [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "elem"}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymArray (Just Int) (Just (SymVar Int "size")) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])
  ]
*/
public int[] fillArray(int size, int elem) {
  int[] arr = new int[size];
  for(int i=0; i<size; i++) {
    arr[i] = elem;
  }
  return arr;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "fillArrayCall"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[10, 10, 10, 10, 10]\n"])
  ]
*/
public void fillArrayCall() {
  println(fillArray(5,10));
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sqrt"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["y"]),
    (VarAssignments,SVarAssignments []),
    (VarName "y",SymVar Int "y"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 11}),
     SLoop (Just (Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}))
           [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 1},Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = ==, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}})), parent = 1},Node {id = 10, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}})), parent = 1}])
  ]
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
    }
  }
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sqrtCall1"),
    (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("x",(SymInt 3,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 3),
    (Return,SymInt 3)
  ]
*/
public static int sqrtCall1() {
  int x = sqrt(9);
  return x;
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Int "sqrtCall2"),
    (VarBindings,SVarBindings (fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SException Int "Exception" "not found",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SException Int "Exception" "not found"),
    (Return,SException Int "Exception" "not found")
  ]
*/
public static int sqrtCall2() {
  int x = sqrt(8);
  return x;
}

////////////////////////////////////////

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "boo34"),
    (GlobalVars,SGlobalVars ["status"]),
    (FormalParms,SFormalParms ["input"]),
    (VarAssignments,SVarAssignments [
        ("status",(SymString "non-empty",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}})),
        ("status",(SymString "empty",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
    (VarName "input",SymVar String "input"),
    (VarName "status",SymUnknown (SymVar String "status") [
        ([(If,SR {branchStart = 1, branchEnd = 6})],3),
        ([(If,SR {branchStart = 1, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),
     SIte (SBin (SObjAcc ["input","length"]) Gt (SymInt 0))
          (fromList [
              (MethodHandle,SMethodHandle Void "boo34"),
              (GlobalVars,SGlobalVars ["status"]),
              (FormalParms,SFormalParms ["input"]),
              (VarBindings,SVarBindings (fromList [
                  ("msg",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})])),
              (VarAssignments,SVarAssignments [
                  ("msg",(SymString "non-empty",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})),
                  ("status",(SymString "non-empty",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
              (VarName "input",SymVar String "input"),
              (VarName "msg",SymString "non-empty"),
              (VarName "status",SymString "non-empty")]) 
          (Just (fromList [
              (MethodHandle,SMethodHandle Void "boo34"),
              (GlobalVars,SGlobalVars ["status"]),
              (FormalParms,SFormalParms ["input"]),
              (VarBindings,SVarBindings (fromList [
                  ("msg",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})])),
              (VarAssignments,SVarAssignments [
                  ("msg",(SymString "empty",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})),
                  ("status",(SymString "empty",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
              (VarName "input",SymVar String "input"),
              (VarName "msg",SymString "empty"),
              (VarName "status",SymString "empty")]))),
              (Return,SymReturnVoid)
  ]
*/
public void boo34(String input){
  if (input.length > 0) {
    String msg = "non-empty";
    status = msg;
  } else {
    String msg = "empty";
    status = msg;
  }
}

//DONE
//JavaMethod
/*
[
    (MethodHandle,SMethodHandle Void "boo34Call"),
    (GlobalVars,SGlobalVars ["status"]),
    (VarName "status",SymString "empty"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "non-empty\n",SymString "empty\n"])
  ]
*/
public void boo34Call() {
  boo34("Hello");
  println(status);
  boo34("");
  println(status);
}

////////////////////////////////////////

/*
public static int rest(int a, int b) {
  while(a > 0) {
    a -= b;
  }
  return a<0 ? a+b : a;
}

////////////////////////////////////////

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

*/
