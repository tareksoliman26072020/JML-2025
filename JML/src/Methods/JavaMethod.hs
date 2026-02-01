module Methods.JavaMethod (javaMethodInputs) where


-- when you add a method, add it also to
-- 1) `javaMethodInputs`
-- 2) `test.SymbolicExecution.TargetState`
-- 3) `allTargets` in `test.SymbolicExecution.TargetState`

javaMethodInputs :: [(String, String)]
javaMethodInputs = [
  ("ifFun", ifFun),
  ("ifFunCall", ifFunCall),
  ("ifFun2", ifFun2),
  ("ifFun2Call", ifFun2Call),
  ("ifFun2Call2", ifFun2Call2),
  ("ifFun3", ifFun3),
  ("ifFun4", ifFun4),
  ("ifFun5", ifFun5),
  ("ifFun5Call1", ifFun5Call1),
  ("ifFun5Call2",ifFun5Call2),
  ("ifFun6", ifFun6),
  ("ifFun7", ifFun7),
  ("ifFun7Call", ifFun7Call),
  ("ifFun7Call2", ifFun7Call2),
  ("ifFun7Call3", ifFun7Call3),
  ("ifFun8", ifFun8),
  ("ifFun8Call", ifFun8Call),
  ("ifFun9", ifFun9),
  ("ifFun10", ifFun10),
  ("ifFun11", ifFun11),
  ("ifFun12", ifFun12),
  ("succFun", succFun)
  ]

ifFun :: String
ifFun = "public int ifFun(int n) {\n\
        \  int res = 0;\n\
        \  int m = 0;\n\
        \  int x = 1;\n\
        \  if(n>=0) {\n\
        \    res += n;\n\
        \    m += 2*n;\n\
        \  }\n\
        \  return res+1;\n\
        \}"

ifFunCall :: String
ifFunCall = "public int ifFunCall() {\n\
            \  return 4+ifFun(3);\n\
            \}"

ifFun2 :: String
ifFun2 = "public int ifFun2(int n) {\n\
         \  int res = y;\n\
         \  int m = 0;\n\
         \  int x = 1;\n\
         \  if(n>=0) {\n\
         \    res += n;\n\
         \    m += 2*n;\n\
         \  }\n\
         \  return res+1;\n\
         \}"

ifFun2Call :: String
ifFun2Call = "public int ifFun2Call() {\n\
             \  return ifFun2(10);\n\
             \}"

ifFun2Call2 :: String
ifFun2Call2 = "public int ifFun2Call2() {\n\
              \  return ifFun2(-10);\n\
              \}"

ifFun3 :: String
ifFun3 = "public int ifFun3(int n) {\n\
         \  int res = 0;\n\
         \  int m = 0;\n\
         \  int x = 1;\n\
         \  if(y>=0) {\n\
         \    res += n;\n\
         \    m += 2*n;\n\
         \  }\n\
         \  return res+1;\n\
         \}"

ifFun4 :: String
ifFun4 = "public int ifFun4(int n) {\n\
         \  if(y>=0) {\n\
         \    y += n;\n\
         \  }\n\
         \  return y;\n\
         \}"

ifFun5 :: String
ifFun5 = "public int ifFun5(int n) {\n\
         \  y = n;\n\
         \  if(y>=0) {\n\
         \    y += n;\n\
         \  }\n\
         \  return y;\n\
         \}"

ifFun5Call1 :: String
ifFun5Call1 = "public int ifFun5Call1() {\n\
              \  return ifFun5(10);\n\
              \}"

ifFun5Call2 :: String
ifFun5Call2 = "public int ifFun5Call2() {\n\
              \  return ifFun5(-10);\n\
              \}"

ifFun6 :: String
ifFun6 = "public String ifFun6(int n) {\n\
         \  if(y>=0) {\n\
         \    m += n;\n\
         \  }\n\
         \  s = \"something\";\n\
         \  return c;\n\
         \}"

ifFun7 :: String
ifFun7 = "public void ifFun7(int n) {\n\
         \  if(n % 2 == 0) {\n\
         \    v = \"hi\";\n\
         \  }\n\
         \  else {\n\
         \    w = \"bye\";\n\
         \  }\n\
         \}"

ifFun7Call :: String
ifFun7Call = "public void ifFun7Call() {\n\
             \  ifFun7(4);\n\
             \}"

ifFun7Call2 :: String
ifFun7Call2 = "public void ifFun7Call2() {\n\
              \  ifFun7(4);\n\
              \  ifFun7(5);\n\
              \}"

{-
[
 (MethodName "ifFun7Call3",SMethodType Void),
 (GlobalVars,SGlobalVars ["t","v","w"]),
 (VarName "t",SymVar UnknownGlobalVarSymType "t"),
 (VarName "v",SymVar String "v"),
 (VarName "w",SymVar String "w")
]
 -}
ifFun7Call3 :: String
ifFun7Call3 = "public void ifFun7Call3() {\n\
              \  ifFun7(t);\n\
              \}"

ifFun8 :: String
ifFun8 = "public void ifFun8(int n) {\n\
         \  if(n % 2 == 0) {\n\
         \    v = \"hi\";\n\
         \    println(v);\n\
         \  }\n\
         \  else {\n\
         \    w = \"bye\";\n\
         \    println(w);\n\
         \  }\n\
         \}"

ifFun8Call :: String
ifFun8Call = "public void ifFun8Call() {\n\
             \  ifFun8(4);\n\
             \  ifFun8(5);\n\
             \  ifFun8(6);\n\
             \}"

ifFun9 :: String
ifFun9 = "public void ifFun9(int n) {\n\
         \  if(n % 2 == 0) {\n\
         \    v = \"hi\";\n\
         \    int z = 3;\n\
         \    v += \" zu\";\n\
         \  }\n\
         \  else {\n\
         \    w = \"bye\";\n\
         \  }\n\
         \}"

ifFun10 :: String
ifFun10 = "public int ifFun10() {\n\
          \  int res = 0;\n\
          \  if(v == \"bye\") {\n\
          \    v = \"hi\";\n\
          \    res += 1;\n\
          \    v = \"zuzu\";\n\
          \  }\n\
          \  res = 0;\n\
          \  t = i;\n\
          \  return res;\n\
          \}"

ifFun11 :: String
ifFun11 = "public int ifFun11() {\n\
          \  int res = 0;\n\
          \  if(false) {\n\
          \    res += 1;\n\
          \  }\n\
          \  return res;\n\
          \}"

ifFun12 :: String
ifFun12 = "public int ifFun12(int n) {\n\
          \  int res = 0;\n\
          \  if(n >= 0) {\n\
          \    res += 1;\n\
          \  }\n\
          \  return res;\n\
          \}"

succFun :: String
succFun = "public void succFun(int i) {\n\
       \  i += 1;\n\
       \}"
