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
/*
SymState {
  env = fromList [
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),
    ("boo23_3",SMethodType Int),
    ("return",SymInt 5),
    ("x",SymInt 8)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0}),
                                 ("y",VarBinding {varDeclAt = 2, varFrame = 0})]),
    ("boo33_5",SMethodType Double),
    ("return",SymDouble 1.1),
    ("x",SymDouble 1.1),
    ("y",SymNull Int)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2))))
    ("return",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2))))
  ], pc = []
}
*/
public int boo21_3_i(int i){
  i += 2;
  return i;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)))),
    ("return",SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 4))
  ], pc = []
}
*/
public int boo21_3_i_1(int i){
  i += 2;
  return i+i;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo21_3_i_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "i",SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)),
    (VarName "x",SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9)),
    (Return,SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9))
  ], pc = []
}
*/
public int boo21_3_i_2(int i){
  i += 2;
  int x = i + 5 + i;
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo21_3_i_3",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "i",SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)),
    (VarName "x",SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9)),
    (Return,SBin (SBin (SymInt 5) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 20))
  ], pc = []
}
*/
public int boo21_3_i_3(int i){
  i += 2;
  int x = i + 5 + i;
  return x + i + x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo21_3_i_4",SMethodType Int),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 2))),
    (Return,SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 2)))
  ], pc = []
}
*/
public int boo21_3_i_4(int i){
  x += i + 2 + i;
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("boo21_3_i_5",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Sub (SymFormalParam Int "i" Nothing))))),
    ("x",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Sub (SymFormalParam Int "i" Nothing)))))
  ], pc = []
}
*/
public int boo21_3_i_5(int i){
  x += i + 2 - 2*i;
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("boo21_3_i_6",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Add (SymFormalParam Int "i" Nothing))))),
    ("x",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Add (SymFormalParam Int "i" Nothing)))))
  ], pc = []
}
*/
public int boo21_3_i_6(int i){
  x += 2 + 3*i - 2*i;
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("boo21_3_i_7",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SymInt 2)))),
    ("x",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SymInt 2))))
  ], pc = []
}
*/
public int boo21_3_i_7(int i){
  x += 2 + 3*i - 2*i - i;
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("boo21_3_i_8",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Add (SBin (SymInt 4) Mul (SymFormalParam Int "i" Nothing)))))),
    ("x",SymGlobalVar Int "x" (Just (SBin (SymGlobalVar Int "x" Nothing) Add (SBin (SymInt 2) Add (SBin (SymInt 4) Mul (SymFormalParam Int "i" Nothing))))))
  ], pc = []
}
*/
public int boo21_3_i_8(int i){
  x += i + 2 + 3*i;
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" (Just (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)))),
    ("return",SymFormalParam Int "i" (Just (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing))))
  ], pc = []
}
*/
public int boo21_3_i_9(int i){
  i += i;
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
    ("return",SBin (SymFormalParam Int "i" Nothing) Add (SymInt 5))
  ], pc = []
}
*/
public int boo22_i_2(int i){
  return boo21_i(i+4) + 1;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2))))
  ], pc = []}

SymState {
  env = fromList [
    (MethodName "boo22_i_3",SMethodType Int),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (Return,SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2))
  ], pc = []
}
*/
public int boo22_i_3(int i){
  return boo21_3_i(i);
}

////////////////////////////////////////

//DONE
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

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("boo22_i_5",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymFormalParam Int "i" (Just (SBin (SymGlobalVar Int "j" Nothing) Add (SymInt 2))))
  ], pc = []
}
*/
public int boo22_i_5(int i){
  return boo21_3_i(j);
}

////////////////////////////////////////

//DONE
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

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("Var Bindings",VarBindings [
        ("j",VarBinding {varDeclAt = 1, varFrame = 0}),
        ("i",VarBinding {varDeclAt = 2, varFrame = 0}),
        ("x",VarBinding {varDeclAt = 3, varFrame = 0})]),
    ("boo22_2_i_2",SMethodType Int),
    ("i",SymInt 9),
    ("j",SymInt 6),
    ("return",SymInt 33),
    ("x",SymInt 18)
  ], pc = []
}
*/
public int boo22_2_i_2(){
  int j = 6;
  int i = 3 + j;
  int x = boo21_i(i*2);
  return x + i + j;
}

////////////////////////////////////////

//DONE
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

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo23_3_i_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("i",VarBinding {varDeclAt = 1, varFrame = 0}),("x",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "i",SymInt 4),
    (VarName "x",SymInt 11),
    (Return,SymInt 16)
  ], pc = []
}
*/
public int boo23_3_i_2(){
  int i = 4;
  int x = 3 + boo21_i(i+i);
  return x+5;
}

////////////////////////////////////////

//DONE
/*
SymState {env = fromList [("i",SymFormalParam Int "i" Nothing),("return",SymInt 3)], pc = []}
*/
public int boo23_4_i(int i){
  return 3 + boo21_i(0);
}

////////////////////////////////////////

//DONE
//SymState {env = fromList [("return",SymInt 10)], pc = []}
public int boo23_4_i_2(){
  return 5 * boo21_i(0*4+2);
}

////////////////////////////////////////

//DONE
/*
SymState {env = fromList [("i",SymFormalParam Int "i" Nothing),("return",SymInt 10)], pc = []}
*/
public int boo23_4_i_3(int i){
  return 5 * boo21_i(0*i+2);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 15) Mul (SBin (SBin (SymInt 3) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 2)))
  ], pc = []
}
*/
public int boo23_4_i_4(int i){
  return 15 * boo21_i(3*i+2);
}

////////////////////////////////////////

//DONE
//SymState {env = fromList [("return",SymInt 255)], pc = []}
public int boo23_4_i_4_1(){
  return boo23_4_i_4(5);
}

////////////////////////////////////////

//DONE
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

//DONE
//SymState {env = fromList [("i",SymFormalParam Int "i" Nothing),("return",SymInt 8)], pc = []}
public int boo23_5_i(int i){
  return 8;
}

////////////////////////////////////////

//DONE
//SymState {env = fromList [("i",SymFormalParam Int "i" Nothing),("return",SymDouble 8.0)], pc = []}
public double boo23_6_i(int i){
  return 8;
}

////////////////////////////////////////

//DONE
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

//DONE
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

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo23_9_i",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 5),
    (Return,SymInt 5)
  ], pc = []
}
*/
public int boo23_9_i(int i){
  int x;
  x = 3 + boo21_i(i+2) - i;
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SBin (SymInt 5) Add (SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing))),
    ("x",SBin (SymInt 5) Add (SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing)))
  ], pc = []
}
*/
public int boo23_9_i_2(int i){
  int x;
  x = 3 + boo21_i(i+2) - 2*i;
  return x;
}

////////////////////////////////////////

//DONE
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

//DONE
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

//DONE
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

//DONE
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

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo33_3_i",SMethodType Double),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Double "i" Nothing),
    (VarName "x",SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing)),
    (Return,SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing))
  ], pc = []
}
*/
public double boo33_3_i(double i){
  double x = 1 + i;
  x+=0.1;
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo33_4_i",SMethodType Double),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Double "i" Nothing),
    (VarName "j",SymFormalParam Double "j" Nothing),
    (VarName "x",SBin (SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing)) Add (SymFormalParam Double "j" Nothing)),
    (Return,SBin (SBin (SymDouble 1.1) Add (SymFormalParam Double "i" Nothing)) Add (SymFormalParam Double "j" Nothing))
  ], pc = []
}
*/
public double boo33_4_i(double i, double j){
  double x = 1 + i;
  x = x + 0.1 + j;
  return x;
}

////////////////////////////////////////


























//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo24",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "x",SymInt 9),
    (Return,SymInt 9)
  ], pc = []
}
*/
public int boo24(){
  int x = 3 + boo25(5);
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo24_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "x",SException "Exception" "meow"),
    (Return,SException "Exception" "meow"),
    (Actions,SActions ["Oopsie\n"])
  ], pc = []
}
*/
public int boo24_2(){
  int x = 3 + boo25(11);
  return x;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo25",SMethodType Int),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (NodeNr 1,SIte (SBin (SymFormalParam Int "i" Nothing) Gt (SymInt 10))
                   (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(VarName "i",SymFormalParam Int "i" Nothing),(Return,SException "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []})
                   (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(VarName "i",SymFormalParam Int "i" Nothing),(Return,SymInt 6)], pc = []})))
  ], pc = []
}
*/
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
/*
SymState {env = fromList [("boo26_2",SMethodType Int),("return",SymInt 5)], pc = []}
*/
public int boo26_2(){
  return boo27(-5);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo27",SMethodType Int),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (NodeNr 1,SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
                   (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(VarName "i",SymFormalParam Int "i" Nothing),(Return,SymFormalParam Int "i" Nothing)], pc = []})
                   (Just (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(VarBindings,SVarBindings (fromList [("res",VarBinding {varDeclAt = 3, varFrame = 1})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "res",SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing)),(Return,SBin (SymInt (-1)) Mul (SymFormalParam Int "i" Nothing))], pc = []})))
  ], pc = []
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

////////////////////////////////////////

//DONE
/*
SymState {env = fromList [("boo27_2",SMethodType Int),("return",SymInt 5)], pc = []}
*/
public int boo27_2() {
  return boo27(5);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    ("2",SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0)) (SymState {env = fromList [("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),("boo28",SMethodType Int),("i",SymFormalParam Int "i" Nothing),("return",SymFormalParam Int "i" Nothing),("x",SymInt 2)], pc = []}) Nothing),
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),
    ("boo28",SMethodType Int),
    ("i",SymFormalParam Int "i" Nothing),
    ("return",SymInt 5),
    ("x",SymInt 1)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    ("Var Bindings",VarBindings [("x",VarBinding {varDeclAt = 1, varFrame = 0})]),
    ("boo282",SMethodType Int),
    ("return",SymInt 2),
    ("x",SymInt 2)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    ("boo283",SMethodType Int),
    ("return",SymInt 5),
    ("x",SymInt 1)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [("boo28_p",SMethodType Int),("return",SymInt 10)], pc = []
}
*/
public int boo28_p() {
  return boo28(10);
}

////////////////////////////////////////

//DONE
/*
SymState {env = fromList [("boo28_m",SMethodType Int),("return",SymInt 5)], pc = []}
*/
public int boo28_m() {
  return boo28(-10);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo28_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (NodeNr 2,SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
                   (SymState {env = fromList [(MethodName "boo28_2",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 4, varFrame = 2})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 2),(VarName "y",SymInt 0),(Return,SymFormalParam Int "i" Nothing)], pc = []})
                   Nothing),
    (Return,SymInt 5)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo28_2_1",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "x",SymInt 2),
    (Return,SymInt 4)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo28_4",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (NodeNr 2,SIte 
       (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
       (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 3, varFrame = 2})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymFormalParam Int "i" Nothing)], pc = []})
       (Just (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 2)], pc = []}))),
    (Return,SymInt 5)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo28_4_1",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (Return,SymFormalParam Int "i" Nothing)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo28_4_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 2),
    (Return,SymInt 5)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo28_4_p",SMethodType Int),
    (Return,SymInt 10)
  ], pc = []
}
*/
public int boo28_4_p() {
  return boo28_4(10);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo28_4_m",SMethodType Int),
    (Return,SymInt 5)
  ], pc = []
}
*/
public int boo28_4_m() {
  return boo28_4(-10);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo28_5",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (NodeNr 2,SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
                   (SymState {env = fromList [(MethodName "boo28_5",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 3, varFrame = 2})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymFormalParam Int "i" Nothing) Add (SymInt 1))], pc = []})
                   (Just (SymState {env = fromList [(MethodName "boo28_5",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 2)], pc = []}))),
    (Return,SymInt 5)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo28_6",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 8, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (VarName "y",SymInt 2),
    (NodeNr 2,SIte (SBin (SymFormalParam Int "i" Nothing) Ge (SymInt 0))
                   (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 3, varFrame = 2})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymFormalParam Int "i" Nothing) Add (SymInt 1))], pc = []})
                   (Just (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),(VarName "i",SymFormalParam Int "i" Nothing),(VarName "x",SymInt 2)], pc = []}))),
    (Return,SymInt 7)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo28_6_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (Return,SBin (SymFormalParam Int "i" Nothing) Add (SymInt 1))
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo28_6_3",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 7, varFrame = 0})])),
    (VarName "i",SymFormalParam Int "i" Nothing),
    (VarName "x",SymInt 1),
    (VarName "y",SymInt 2),
    (Return,SymInt 7)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo28_6_p",SMethodType Int),
    (Return,SymInt 11)
  ], pc = []
}
*/
public int boo28_6_p() {
  return boo28_6(10);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo29",SMethodType Bool),
    (Return,SBool False)
  ], pc = []
}
*/
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
/*
SymState {
  env = fromList [
    (MethodName "boo30",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x1",VarBinding {varDeclAt = 1, varFrame = 0}),("x2",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "x1",SymInt 0),
    (VarName "x2",SymInt 0),
    (VarName "y",SymGlobalVar Int "y" (Just (SymInt 0))),
    (VarName "y1",SymGlobalVar Int "y1" (Just (SymInt 0))),
    (VarName "y2",SymGlobalVar Int "y2" (Just (SymInt 0))),
    (VarName "z",SymFormalParam Int "z" Nothing),
    (NodeNr 6,SIte (SBin (SymFormalParam Int "z" Nothing) Ge (SymInt 0))
                   (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(VarBindings,SVarBindings (fromList [("x1",VarBinding {varDeclAt = 1, varFrame = 0}),("x2",VarBinding {varDeclAt = 2, varFrame = 0})])),(VarName "t1",SymGlobalVar Int "t1" (Just (SymInt 7))),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymGlobalVar Int "y" (Just (SymInt 0))),(VarName "y1",SymGlobalVar Int "y1" (Just (SymInt 0))),(VarName "y2",SymGlobalVar Int "y2" (Just (SymInt 0))),(VarName "z",SymFormalParam Int "z" Nothing),(Return,SymGlobalVar Int "t1" (Just (SymInt 7)))], pc = []})
                   (Just (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(VarBindings,SVarBindings (fromList [("x1",VarBinding {varDeclAt = 1, varFrame = 0}),("x2",VarBinding {varDeclAt = 2, varFrame = 0})])),(VarName "t2",SymGlobalVar Int "t2" (Just (SymInt 17))),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymGlobalVar Int "y" (Just (SymInt 0))),(VarName "y1",SymGlobalVar Int "y1" (Just (SymInt 0))),(VarName "y2",SymGlobalVar Int "y2" (Just (SymInt 0))),(VarName "z",SymFormalParam Int "z" Nothing),(Return,SymGlobalVar Int "t2" (Just (SymInt 17)))], pc = []})))
  ], pc = []
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

////////////////////////////////////////

/*
SymState {
  env = fromList [
    (MethodName "boo31",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "x",SymGlobalVar Int "z" (Just (SymInt 0))),
    (VarName "z",SymGlobalVar Int "z" (Just (SymInt 0))),
    (Return,SymGlobalVar Int "z" (Just (SymInt 0)))
  ], pc = []
}
*/
public int boo31(){
  z = 0;
  int x = z;
  return x;
}

///////////////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo31_2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "x",SymInt 0),
    (VarName "z",SymInt 0),
    (Return,SymInt 7)
  ], pc = []
}
*/
public int boo31_2(){
  z = 0;
  int x = z;
  return boo30(1);
}

///////////////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "boo32",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "x",SBin (SBin (SymGlobalVar Int "y1" Nothing) Add (SymGlobalVar Int "y2" Nothing)) Add (SymGlobalVar Int "y3" Nothing)),
    (Return,SBin (SBin (SymGlobalVar Int "y1" Nothing) Add (SymGlobalVar Int "y2" Nothing)) Add (SymGlobalVar Int "y3" Nothing))
  ], pc = []
}
*/
public int boo32(){
  int x = y1 + y2 + y3;
  return x;
}

///////////////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "elemAt",SMethodType Int),
    (VarName "arr",SymFormalParam (Array Int) "arr" Nothing),
    (VarName "pos",SymFormalParam Int "pos" Nothing),
    (NodeNr 1,SIte (SBin (SObjAcc ["arr","length"]) Le (SymFormalParam Int "pos" Nothing)) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(VarName "arr",SymFormalParam (Array Int) "arr" Nothing),(VarName "pos",SymFormalParam Int "pos" Nothing),(Return,SException "Exception" "not found")], pc = []}) Nothing),
    (Return,SArrayIndexAccess "arr" (SymFormalParam Int "pos" Nothing))
  ], pc = []
}


SymState {
  env = fromList [
    (MethodName "elemAt",SMethodType Int),
    (VarName "arr",SymFormalParam (Array Int) "arr" Nothing),
    (VarName "pos",SymFormalParam Int "pos" Nothing),
    (NodeNr 1,SIte (SBin (SObjAcc ["arr","length"]) Le (SymFormalParam Int "pos" Nothing)) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(VarName "arr",SymFormalParam (Array Int) "arr" Nothing),(VarName "pos",SymFormalParam Int "pos" Nothing),(Return,SException "Exception" "not found")], pc = []}) Nothing),
    (Return,SArrayIndexAccess "arr" (SymFormalParam Int "pos" Nothing))
  ], pc = []
}
*/
public int elemAt(int[] arr, int pos) throws Exception {
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "elemAtCall",SMethodType Int),
    (Return,SymInt 4)
  ], pc = []
}
*/
public int elemAtCall() throws Exception {
  return elemAt(new int[]{6,5,4,7,8},2);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "elemAt2",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("arr",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (VarName "pos",SymFormalParam Int "pos" Nothing),
    (NodeNr 2,SIte (SBin (SymInt 5) Le (SymFormalParam Int "pos" Nothing)) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(VarBindings,SVarBindings (fromList [("arr",VarBinding {varDeclAt = 1, varFrame = 0})])),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymFormalParam Int "pos" Nothing),(Return,SException "Exception" "not found")], pc = []}) Nothing),
    (Return,SArrayIndexAccess "arr" (SymFormalParam Int "pos" Nothing))
  ], pc = []
}
*/
public int elemAt2(int pos) throws Exception {
  int[] arr = new int[]{6,5,4,7,8};
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "elemAt2call",SMethodType Int),
    (Return,SymInt 4)
  ], pc = []
}
*/
public int elemAt2call() {
  return elemAt2(2);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "elemAt2call2",SMethodType Int),
    (Return,SException "Exception" "not found")
  ], pc = []
}
*/
public int elemAt2call2() {
  return elemAt2(5);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "elemAt3",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("arr",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (VarName "pos",SymFormalParam Int "pos" Nothing),
    (NodeNr 2,SIte (SBin (SymInt 5) Le (SymFormalParam Int "pos" Nothing))
                   (SymState {env = fromList [(MethodName "elemAt3",SMethodType Int),(VarBindings,SVarBindings (fromList [("arr",VarBinding {varDeclAt = 1, varFrame = 0})])),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymFormalParam Int "pos" Nothing),(Return,SException "Exception" "not found")], pc = []})
                   Nothing),
    (Return,SArrayIndexAccess "arr" (SymFormalParam Int "pos" Nothing))
  ], pc = []
}
*/
public static int elemAt3(int pos) throws Exception {
  int[] arr = {6,5,4,7,8};
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "elemAt4",SMethodType Int),
    (VarBindings,SVarBindings (fromList [("arr",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (Return,SymInt 7)
  ], pc = []
}
*/
public int elemAt4() {
  int[] arr = {6,5,4,7,8};
  return arr[3];
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "strFun",SMethodType String),
    (VarBindings,SVarBindings (fromList [("firstName",VarBinding {varDeclAt = 1, varFrame = 0}),("lastName",VarBinding {varDeclAt = 2, varFrame = 0})])),
    (VarName "firstName",SymString "Tarek"),
    (VarName "lastName",SymString "Soliman"),
    (Return,SymString "Tarek Soliman")
  ], pc = []
}
*/
public String strFun() {
  String firstName = "Tarek";
  String lastName = "Soliman";
  return firstName + " " + lastName;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "voidFun1",SMethodType Void)
  ], pc = []
}
*/
public void voidFun1() {
  return;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "voidFun2",SMethodType Void)
  ], pc = []
}
*/
public void voidFun2() {
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "voidFun3",SMethodType Void),
    (VarBindings,SVarBindings (fromList [("x",VarBinding {varDeclAt = 1, varFrame = 0}),("y",VarBinding {varDeclAt = 2, varFrame = 0}),("z",VarBinding {varDeclAt = 5, varFrame = 0})])),
    (VarName "x",SymInt 1),
    (VarName "y",SymString "is one"),
    (VarName "z",SymString "1 is one")
  ], pc = []
}
*/
public void voidFun3() {
  int x;
  String y;
  x = 1;
  y = "is one";
  String z = toString(x) + " " + y;
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
SymState {
  env = fromList [
    (MethodName "voidFun5",SMethodType Void),
    (Actions,SActions ["Before\n","1 is one\n","After\n"])
  ], pc = []
}
*/
public void voidFun5() {
  println("Before");
  voidFun4();
  println("After");
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "manyArrs",SMethodType Void),
    (VarBindings,SVarBindings (fromList [("numbers",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]),
    (Actions,SActions ["[99, 5]\n"])
  ], pc = []
}
*/
public void manyArrs() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  println(numbers);
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "manyArrs3",SMethodType (Array Int)),
    (VarBindings,SVarBindings (fromList [("numbers",VarBinding {varDeclAt = 1, varFrame = 0})])),
    (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]),
    (Return,SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5])
  ], pc = []
}
*/
public int[] manyArrs3() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  return numbers;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "manyArrs2",SMethodType Void),
    (VarBindings,SVarBindings (fromList [("brand",VarBinding {varDeclAt = 5, varFrame = 0}),("numbers1",VarBinding {varDeclAt = 1, varFrame = 0}),("numbers2",VarBinding {varDeclAt = 2, varFrame = 0}),("numbers3",VarBinding {varDeclAt = 3, varFrame = 0}),("strs",VarBinding {varDeclAt = 6, varFrame = 0})])),
    (VarName "brand",SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),
    (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]),
    (VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]),
    (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]),
    (VarName "strs",SymArray (Just (Array String)) (Just 3) [SymNull String,SymString "meow",SymNull String]),
    (Actions,SActions ["[86, 57, 80, 34, 50, 48, 94]\n","[51, 84, 92, 87, 81]\n","[5, 75, 34, 10, 6]\n"])
  ], pc = []
}
*/
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

/////////////////////

//TODO
/*
FunDef {
  funModifier = [Public],
  isPureFlag = False,
  funDecl = FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "sum1"}, funArgs = [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]}},
  throws = Nothing,
  funBody = CompStmt {statements = [
    AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}},
    ForStmt {acc = AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}, cond = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0}, step = AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}}, forBody = CompStmt {statements = [AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}]}},
    ReturnStmt {returnS = Just (VarExpr {varType = Nothing, varObj = [], varName = "res"})}]
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

/////////////////////

//TODO
/*
public int sum2(int n) {
  int res = 0;
  for(; n>0; n--) {
    res += n;
  }
  return res;
}
*/

/////////////////////


//TODO
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

/////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "isEmpty",SMethodType Bool),
    (VarName "arr",SymFormalParam (Array Int) "arr" Nothing),
    (Return,SBin (SObjAcc ["arr","length"]) Eq (SymInt 0))
  ], pc = []
}
*/
public boolean isEmpty(int[] arr) {
  return arr.length == 0;
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "callIsEmpty",SMethodType Bool),
    (Return,SBool True)
  ], pc = []
}
*/
public boolean callIsEmpty() {
  return isEmpty(new int[]{});
}

////////////////////////////////////////

//DONE
/*
SymState {
  env = fromList [
    (MethodName "callIsNotEmpty",SMethodType Bool),
    (Return,SBool False)
  ], pc = []
}
*/
public boolean callIsNotEmpty() {
  return isEmpty(new int[]{1,2,3});
}

////////////////////////////////////////

//TODO
public int[] fillArray(int size, int elem) {
  int[] arr = new int[size];
  for(int i=0; i<size; i++) {
    arr[i] = elem;
  }
  return arr;
}

////////////////////////////////////////

//TODO
/*
CFG {
  nodes = [
    Entry (BuiltInType Int) "sqrt" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}],
    Node {id = 1, nodeData = ForInitialization (AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}), parent = 0},
    Node {id = 2, nodeData = BooleanExpression For (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}), parent = 0},
    Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 0},
    Node {id = 4, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = ==, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}), parent = 0},
    End {id = 5, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})},
    Node {id = 6, nodeData = BooleanExpression If (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = ==, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}), parent = 4},
    End {id = 7, parent = 4, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "not found"})},
    Node {id = 8, nodeData = Meet If, parent = 4},
    Node {id = 9, nodeData = Meet If, parent = 0},
    Node {id = 10, nodeData = ForStep (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 0},
    Node {id = 11, nodeData = Meet For, parent = 0}
  ],
  edges = [(0,[1]),(1,[2]),(2,[3]),(3,[4]),(4,[5,6]),(6,[7,8]),(7,[8]),(5,[9]),(8,[9]),(9,[10]),(10,[2]),(2,[11])]
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
