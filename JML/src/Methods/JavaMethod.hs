module Methods.JavaMethod (javaMethodInputs) where


-- when you add a method, add it also to
-- 1) `javaMethodInputs`
-- 2) `test.SymbolicExecution.TargetState`
-- 3) `allTargets` in `test.SymbolicExecution.TargetState`

javaMethodInputs :: [(String, String)]
javaMethodInputs = [
  ("boo30", boo30),
  ("boo31", boo31),
  ("boo31_2", boo31_2),
  ("boo31_3", boo31_3),
  ("boo32", boo32), ("boo32Call", boo32Call),
  ("elemAt", elemAt), ("elemAtCall", elemAtCall),
  ("elemAt2", elemAt2), ("elemAt2Call", elemAt2Call), ("elemAt2Call2", elemAt2Call2),
  ("elemAt4", elemAt4),
  ("strFun", strFun),
  ("voidFun1", voidFun1),
  ("voidFun2", voidFun2),
  ("voidFun3", voidFun3),
  ("manyArrs", manyArrs),
  ("manyArrs2", manyArrs2),
  ("manyArrs3", manyArrs3),
  ("manyArrs4", manyArrs4),
  ("manyArrs5", manyArrs5),
  ("manyArrs6", manyArrs6),
  ("ifFun", ifFun),
  ("ifFunCall", ifFunCall),
  ("ifFun2", ifFun2),
  ("ifFun2Call", ifFun2Call),
  ("ifFun2Call2", ifFun2Call2),
  ("ifFun3", ifFun3), ("voidFun3Call", voidFun3Call),
  ("ifFun4", ifFun4),
  ("ifFun5", ifFun5),
  ("ifFun5Call1", ifFun5Call1),
  ("ifFun5Call2",ifFun5Call2),
  ("ifFun6", ifFun6), ("ifFun6Call", ifFun6Call),
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
  ("succFun", succFun), ("callSuccFun", callSuccFun), ("callCallSuccFun", callCallSuccFun),
  ("wrongSum1", wrongSum1),
  ("wrongSum2", wrongSum2),
  ("wrongSum3", wrongSum3),
  ("wrongSum4", wrongSum4),
  ("wrongSum5", wrongSum5),
  ("for1", for1),
  ("for2", for2),
  ("for3", for3),
  ("sum1", sum1)
  ]

boo30 :: String
boo30 = "public int boo30(int z){\n\
        \  int x1 = 0;\n\
        \  int x2 = 0;\n\
        \  y = 0;\n\
        \  y1 = 0;\n\
        \  y2 = 0;\n\
        \  if(z>=0){\n\
        \    t1 = 7;\n\
        \    return t1;\n\
        \  }\n\
        \  else{\n\
        \    t2 = 17;\n\
        \    return t2;\n\
        \  }\n\
        \}"

boo31 :: String
boo31 = "public int boo31(){\n\
        \  z = 0;\n\
        \  int x = z;\n\
        \  return x;\n\
        \}"

boo31_2 :: String
boo31_2 = "public int boo31_2(){\n\
          \  z = 0;\n\
          \  int x = z;\n\
          \  return boo30(1);\n\
          \}"

boo31_3 :: String
boo31_3 = "public int boo31_3(){\n\
          \  z = 0;\n\
          \  int x = z;\n\
          \  boo30(-1);\n\
          \  return z;\n\
          \}"

boo32 :: String
boo32 = "public int boo32(){\n\
        \  int x = y1 + y2 + y3;\n\
        \  return x;\n\
        \}"

boo32Call :: String
boo32Call = "public int boo32Call(){\n\
            \  y1 = 1;\n\
            \  y2 = 2;\n\
            \  y3 = 3;\n\
            \  return boo32();\n\
            \}"

elemAt :: String
elemAt = "public int elemAt(int[] arr, int pos) throws Exception {\n\
         \  if(arr.length<=pos) {\n\
         \    throw new Exception(\"not found\");\n\
         \  }\n\
         \  return arr[pos];\n\
         \}"

elemAtCall :: String
elemAtCall = "public int elemAtCall() throws Exception {\n\
             \  return elemAt(new int[]{6,5,4,7,8},2);\n\
             \}"

elemAt2 :: String
elemAt2 = "public int elemAt2(int pos) throws Exception {\n\
          \  int[] arr = new int[]{6,5,4,7,8};\n\
          \  if(arr.length<=pos) {\n\
          \    throw new Exception(\"not found\");\n\
          \  }\n\
          \  return arr[pos];\n\
          \}"

elemAt2Call :: String
elemAt2Call = "public int elemAt2Call() {\n\
              \  return elemAt2(2);\n\
              \}"

elemAt2Call2 :: String
elemAt2Call2 = "public int elemAt2Call2() {\n\
               \  return elemAt2(5);\n\
               \}"

elemAt4 :: String
elemAt4 = "public int elemAt4() {\n\
          \  int[] arr = {6,5,4,7,8};\n\
          \  return arr[3];\n\
          \}"

strFun :: String
strFun = "public String strFun() {\n\
         \  String firstName = \"Tarek\";\n\
         \  String lastName = \"Soliman\";\n\
         \  return firstName + \" \" + lastName;\n\
         \}"

voidFun1 :: String
voidFun1 = "public void voidFun1() {\n\
           \  return;\n\
           \}"

voidFun2 :: String
voidFun2 = "public void voidFun2() {\n\
           \}"

voidFun3 :: String
voidFun3 = "public void voidFun3(int n) {\n\
           \  int x;\n\
           \  String y;\n\
           \  x = 1 + n;\n\
           \  y = \"is one\";\n\
           \  y2 = \"is not one\";\n\
           \  if(x == 1) {\n\
           \    z = toString(x) + \" \" + y;\n\
           \  }\n\
           \  else {\n\
           \    z = toString(x) + \" \" + y2;\n\
           \  }\n\
           \}"

voidFun3Call :: String
voidFun3Call = "public void voidFun3Call() {\n\
               \  voidFun3(10);\n\
               \  println(z);\n\
               \}"

manyArrs :: String
manyArrs = "public void manyArrs() {\n\
           \  int[] numbers = new int[2];\n\
           \  numbers[0] = 99;\n\
           \  numbers[1] = 5;\n\
           \  println(numbers);\n\
           \}"

manyArrs2 :: String
manyArrs2 = "public void manyArrs2() {\n\
            \  int[] numbers1 = new int[7];\n\
            \  int[] numbers2 = {40, 55, 63, 17, 22};\n\
            \  int[] numbers3;\n\
            \  numbers3 = new int[5];\n\
            \  String[] brand = new String[] {\"Toyota\",\"Mercedes\",\"BMW\",\"Volkswagen\",\"Skoda\"};\n\
            \  String[] strs = new String[3];\n\
            \  strs[1] = \"meow\";\n\
            \  numbers1[0] = 86;\n\
            \  numbers1[2] = 80;\n\
            \  numbers1[1] = 57;\n\
            \  numbers1[3] = 34;\n\
            \  numbers1[4] = 50;\n\
            \  numbers1[5] = 48;\n\
            \  numbers1[6] = 94;\n\
            \  numbers2[0] = 51;\n\
            \  numbers2[1] = 84;\n\
            \  numbers2[2] = 92;\n\
            \  numbers2[3] = 87;\n\
            \  numbers2[4] = 81;\n\
            \  numbers3[4] = 43;\n\
            \  numbers3[3] = 10;\n\
            \  numbers3[2] = 34;\n\
            \  numbers3[1] = 75;\n\
            \  numbers3[4] = 6;\n\
            \  numbers3[0] = 5;\n\
            \  println(numbers1);\n\
            \  println(numbers2);\n\
            \  println(numbers3);\n\
            \}"

manyArrs3 :: String
manyArrs3 = "public int[] manyArrs3() {\n\
            \  int[] numbers = new int[2];\n\
            \  numbers[0] = 99;\n\
            \  numbers[1] = 5;\n\
            \  return numbers;\n\
            \}"

manyArrs4 :: String
manyArrs4 = "public void manyArrs4() {\n\
            \  int[] numbers = new int[2];\n\
            \  numbers[0] = 99;\n\
            \  println(numbers);\n\
            \}"

manyArrs5 :: String
manyArrs5 = "public void manyArrs5() {\n\
            \  String[] brand = new String[] {\"Toyota\",\"Mercedes\",\"BMW\",\"Volkswagen\",\"Skoda\"};\n\
            \  for(int i=0; i<brand.length; i++) {\n\
            \    brand[i] = toString(i+1) + \". \" + brand[i];\n\
            \  }\n\
            \  println(brand);\n\
            \}"

manyArrs6 :: String
manyArrs6 = "public void manyArrs6() {\n\
            \  String[] brand = new String[] {\"Toyota\",\"Mercedes\",\"BMW\",\"Volkswagen\",\"Skoda\"};\n\
            \  for(int i=0; i<brand.length; i++) {\n\
            \    println(toString(i+1) + \". \" + brand[i]);\n\
            \  }\n\
            \  println(brand);\n\
            \}"

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
         \    y = (-1) * y;\n\
         \  }\n\
         \  s = \"something\";\n\
         \  return c;\n\
         \}"

ifFun6Call :: String
ifFun6Call = "public String ifFun6Call() {\n\
             \  y = 5;\n\
             \  m = 1;\n\
             \  c = \"dangerous\";\n\
             \  return toString(m+y) + \" \" + ifFun6(10) + \" \" + s + toString(m+y);\n\
             \}"

ifFun7 :: String
ifFun7 = "public void ifFun7(int n) {\n\
         \  if(n % 2 == 0) {\n\
         \    v = \"hi\";\n\
         \  }\n\
         \  else {\n\
         \    w = \"bye\";\n\
         \  }\n\
         \  s = \"something\";\n\
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

callSuccFun :: String
callSuccFun = "public int callSuccFun(int n) {\n\
              \  succFun(n);\n\
              \  return n;\n\
              \}"

callCallSuccFun :: String
callCallSuccFun = "public int callCallSuccFun() {\n\
                  \  return callSuccFun(5);\n\
                  \}"

wrongSum1 :: String
wrongSum1 = "public int wrongSum1(int n) {\n\
            \  int res = 0;\n\
            \  int j = w;\n\
            \  for(int i=n; i>0; i--) {\n\
            \    res += i;\n\
            \    int z = 9;\n\
            \    z = i;\n\
            \    res = 0;\n\
            \    t = i;\n\
            \    j = c;\n\
            \  }\n\
            \  return res;\n\
            \}"

wrongSum2 :: String
wrongSum2 = "public int wrongSum2(int n) {\n\
            \  int res = 0;\n\
            \  for(int i=n; i>0; i--) {\n\
            \    res += i;\n\
            \    int z = 9;\n\
            \    z = i;\n\
            \    if(true) {\n\
            \      v = \"hi\";\n\
            \      res += 1;\n\
            \      v = \"zuzu\";\n\
            \    }\n\
            \    res = 0;\n\
            \    t = i;\n\
            \  }\n\
            \  return res;\n\
            \}"

wrongSum3 :: String
wrongSum3 = "public int wrongSum3(int n) {\n\
            \  int res = 0;\n\
            \  for(int i=n; i>0; i--) {\n\
            \    res += i;\n\
            \    int z = 9;\n\
            \    z = i;\n\
            \    if(false) {\n\
            \      v = \"hi\";\n\
            \      res += 1;\n\
            \      v = \"zuzu\";\n\
            \    }\n\
            \    res = 0;\n\
            \    t = i;\n\
            \  }\n\
            \  return res;\n\
            \}"

wrongSum4 :: String
wrongSum4 = "public int wrongSum4(int n) {\n\
            \  int res = 0;\n\
            \  for(int i=n; i>0; i--) {\n\
            \    res += i;\n\
            \    int z = 9;\n\
            \    z = i;\n\
            \    if(v == \"bye\") {\n\
            \      v = \"hi\";\n\
            \      res += 1;\n\
            \      v = \"zuzu\";\n\
            \    }\n\
            \    res = 0;\n\
            \    t = i;\n\
            \  }\n\
            \  return res;\n\
            \}"

wrongSum5 :: String
wrongSum5 = "public int wrongSum5(int n) {\n\
            \  int res = 0;\n\
            \  for(int i=n; i>0; i--) {\n\
            \    res += i;\n\
            \    int z = 9;\n\
            \    z = i;\n\
            \    if(v == \"bye\") {\n\
            \      v = \"hi\";\n\
            \      res += 1;\n\
            \      v = \"zuzu\";\n\
            \    }\n\
            \    t = i;\n\
            \  }\n\
            \  return res;\n\
            \}"

for1 :: String
for1 = "public int for1(int n) {\n\
       \  int res = 0;\n\
       \  for(int i=n; i>0; i--) {\n\
       \  }\n\
       \  return res;\n\
       \}"

for2 :: String
for2 = "public int for2(int n) {\n\
       \  int res = 0;\n\
       \  for(int i=n; i>0; i--) {\n\
       \    if(i % 2 == 0) {\n\
       \      res += 1;\n\
       \    }\n\
       \  }\n\
       \  if(res % 3 == 0) {\n\
       \    res *= 3;\n\
       \  }\n\
       \  return res;\n\
       \}"

for3 :: String
for3 = "public int for3(int n) {\n\
       \  int a;\n\
       \  if(n % 2 == 0) {\n\
       \    a = 10;\n\
       \  }\n\
       \  else {\n\
       \    a = 20;\n\
       \  }\n\n\
       \  for(int i=n; i>0; i--) {\n\
       \    if(i % 2 == 0) {\n\
       \      a += 5;\n\
       \    }\n\
       \  }\n\n\
       \  if(a % 3 == 0) {\n\
       \    a *= 3;\n\
       \  }\n\n\
       \  return a;\n\
       \}"

sum1 :: String
sum1 = "public int sum1(int n) {\n\
       \  int res = 0;\n\
       \  for(; n>0; n--) {\n\
       \    res += n;\n\
       \  }\n\
       \  return res;\n\
       \}"
