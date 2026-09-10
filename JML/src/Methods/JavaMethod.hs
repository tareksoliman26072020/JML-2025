module Methods.JavaMethod (javaMethodInputs) where

import Prelude hiding (replicate, tail, sqrt)
-- when you add a method, add it also to
-- 1) `javaMethodInputs`
-- 2) `test.SymbolicExecution.TargetState`
-- 3) `allTargets` in `test.SymbolicExecution.TargetState`

javaMethodInputs :: [(String, Int, String)]
javaMethodInputs = [
  ("boo21",1,boo21), ("boo21_2",1,boo21_2), ("boo22",1,boo22),
  ("boo22_2",1,boo22_2), ("boo23_3",1,boo23_3), ("boo23_3_1",1,boo23_3_1),
  ("boo23_4",1,boo23_4), ("boo23_9",1,boo23_9), ("boo33_3",1,boo33_3),
  ("boo33_4",1,boo33_4), ("boo33_5",1,boo33_5), ("boo33_6",1,boo33_6),
  ("boo33_7",1,boo33_7),
  ("boo21_i",1,boo21_i), ("boo21_2_i",1,boo21_2_i),
  ("boo33_5_2",1,boo33_5_2), ("boo33_5_3",1,boo33_5_3), ("boo33_5_4",1,boo33_5_4),
  ("boo21_3_i",1,boo21_3_i),
  ("boo21_3_i_1",1,boo21_3_i_1), ("boo21_3_i_2",1,boo21_3_i_2), ("boo21_3_i_3",1,boo21_3_i_3),
  ("boo21_3_i_4",1,boo21_3_i_4), ("boo21_3_i_5",1,boo21_3_i_5), ("boo21_3_i_6",1,boo21_3_i_6),
  ("boo21_3_i_7",1,boo21_3_i_7), ("boo21_3_i_8",1,boo21_3_i_8), ("boo21_3_i_9",1,boo21_3_i_9),
  ("boo22_i",1,boo22_i), ("boo22_i_2",1,boo22_i_2),
  ("boo22_i_3",1,boo22_i_3), ("boo22_i_4",1,boo22_i_4),
  ("boo22_i_5",1,boo22_i_5), ("boo22_i_5_call",1,boo22_i_5_call),
  ("boo22_2_i",1,boo22_2_i),
  ("boo22_2_i_2",1,boo22_2_i_2), ("boo23_3_i",1,boo23_3_i),
  ("boo23_3_i_2",1,boo23_3_i_2), ("boo23_4_i",1,boo23_4_i), ("boo23_4_i_2",1,boo23_4_i_2),
  ("boo23_4_i_3",1,boo23_4_i_3), ("boo23_4_i_4",1,boo23_4_i_4), ("boo23_4_i_4_1",1,boo23_4_i_4_1),
  ("boo23_4_i_5",1,boo23_4_i_5), ("boo23_5_i",1,boo23_5_i), ("boo23_6_i",1,boo23_6_i),
  ("boo23_7_i",1,boo23_7_i), ("boo23_8_i",1,boo23_8_i), ("boo23_9_i",1,boo23_9_i),
  ("boo23_9_i_2",1,boo23_9_i_2), ("boo23_10_i",1,boo23_10_i), ("boo23_10_i_2",1,boo23_10_i_2),
  ("boo23_11_i",1,boo23_11_i), ("boo23_12_i",1,boo23_12_i), ("boo33_3_i",1,boo33_3_i),
  ("boo33_4_i",1,boo33_4_i), ("boo33_4_i_call",1,boo33_4_i_call),
  ("boo24",1,boo24),
  ("boo24_2",1,boo24_2),
  ("exceptionFun",1,exceptionFun),
  ("boo25",1,boo25),
  ("boo26_2",1,boo26_2),
  ("boo27",1,boo27),
  ("boo27_2",1,boo27_2),
  ("boo28",1,boo28),
  ("boo282",1,boo282),
  ("boo283",1,boo283),
  ("boo28_p",1,boo28_p),
  ("boo28_m",1,boo28_m),
  ("boo28_2",1,boo28_2),
  ("boo28_2_1",1,boo28_2_1),
  ("boo28_4",1,boo28_4),
  ("boo28_4_1",1,boo28_4_1),
  ("boo28_4_2",1,boo28_4_2),
  ("boo28_4_p",1,boo28_4_p),
  ("boo28_4_m",1,boo28_4_m),
  ("boo28_5",1,boo28_5),
  ("boo28_6",1,boo28_6),
  ("boo28_6_2",1,boo28_6_2),
  ("boo28_6_3",1,boo28_6_3),
  ("boo28_6_4",1,boo28_6_4),
  ("boo28_6_5",1,boo28_6_5),
  ("boo28_6_6",1,boo28_6_6),
  ("boo28_6_6_2",1,boo28_6_6_2),
  ("boo28_6_6_3",1,boo28_6_6_3),
  ("boo28_6_6_4",1,boo28_6_6_4),
  ("boo28_6_7",1,boo28_6_7),
  ("boo28_6_8",1,boo28_6_8), ("boo28_6_8_call",1,boo28_6_8_call),
  ("boo28_6_p",1,boo28_6_p),
  ("boo29",1,boo29),
  ("boo30",1,boo30),
  ("boo31",1,boo31),
  ("boo31_2",1,boo31_2),
  ("boo31_3",1,boo31_3),
  ("boo32",1,boo32), ("boo32Call",1,boo32Call),
  ("elemAt",1,elemAt), ("elemAtCall",1,elemAtCall),
  ("elemAt2",1,elemAt2), ("elemAt2Call",1,elemAt2Call),
                         ("elemAt2Call2",1,elemAt2Call2),
  ("elemAt3",1,elemAt3),
  ("elemAt4",1,elemAt4),
  ("strFun",1,strFun),
  ("voidFun1",1,voidFun1),
  ("voidFun2",1,voidFun2),
  ("voidFun3",1,voidFun3),
  ("manyArrs",1,manyArrs),
  ("manyArrs2",1,manyArrs2),
  ("manyArrs3",1,manyArrs3),
  ("manyArrs4",1,manyArrs4),
  ("manyArrs5",1,manyArrs5),
  ("manyArrs6",1,manyArrs6),
  ("manyArrs7",2,manyArrs7), ("manyArrs7Call1",2,manyArrs7Call1),
                             ("manyArrs7Call2",2,manyArrs7Call2),
  ("ifFun",1,ifFun),
  ("ifFunCall",1,ifFunCall),
  ("ifFun2",1,ifFun2),
  ("ifFun2Call",1,ifFun2Call),
  ("ifFun2Call2",1,ifFun2Call2),
  ("ifFun3",1,ifFun3), ("voidFun3Call",1,voidFun3Call),
  ("voidFun4",1,voidFun4), ("voidFun5",1,voidFun5), ("voidFun6",1,voidFun6),
  ("ifFun4",1,ifFun4), ("ifFun4Call",1,ifFun4Call),
  ("ifFun5",1,ifFun5),
  ("ifFun5Call1",1,ifFun5Call1),
  ("ifFun5Call2",1,ifFun5Call2),
  ("ifFun6",1,ifFun6), ("ifFun6Call",1,ifFun6Call), ("ifFun6Call2",1,ifFun6Call2),
  ("ifFun7",1,ifFun7),
  ("ifFun7Call",1,ifFun7Call),
  ("ifFun7Call2",1,ifFun7Call2),
  ("ifFun7Call3",1,ifFun7Call3),
  ("ifFun8",1,ifFun8),
  ("ifFun8Call",1,ifFun8Call),
  ("ifFun9",1,ifFun9),
  ("ifFun10",1,ifFun10),
  ("ifFun11",1,ifFun11),
  ("ifFun12",1,ifFun12),
  ("ifFun13",1,ifFun13), ("ifFun13Call",1,ifFun13Call),
  ("succFun",1,succFun), ("succFunCall",1,succFunCall), ("callSuccFun",1,callSuccFun), ("callCallSuccFun",1,callCallSuccFun),
  ("wrongSum1",2,wrongSum1),
  ("wrongSum2",2,wrongSum2),
  ("wrongSum3",2,wrongSum3),
  ("wrongSum4",2,wrongSum4),
  ("wrongSum5",2,wrongSum5),
  ("for1",2,for1),
  ("for2",2,for2),
  ("for3",2,for3),
  ("sum1",2,sum1), ("sum1Call1",2,sum1Call1),
                   ("sum1Call2",2,sum1Call2),
                   ("sum1Call3",2,sum1Call3),
  ("sum2",2,sum2),
  ("sum4",2,sum4), ("sum4Call",2,sum4Call),
  ("sum1_While",2,sum1_While), ("sum1_WhileCall",2,sum1_WhileCall),
  ("sum1_While2",2,sum1_While2), ("sum1_While2Call1",2,sum1_While2Call1),
                                 ("sum1_While2Call2",2,sum1_While2Call2),
  ("sumOddNums",2,sumOddNums), ("sumOddNumsCall1",2,sumOddNumsCall1),
                               ("sumOddNumsCall2",2,sumOddNumsCall2),
  ("sumUntilNegative",2,sumUntilNegative), ("sumUntilNegativeCall1",2,sumUntilNegativeCall1),
                                           ("sumUntilNegativeCall2",2,sumUntilNegativeCall2),
  ("processArray1",2,processArray1), ("processArray1Call",2,processArray1Call),
  ("isEmpty",1,isEmpty), ("callIsEmpty",1,callIsEmpty),
                         ("callIsNotEmpty",1,callIsNotEmpty),
  ("fillArray",2,fillArray), ("fillArrayCall",2,fillArrayCall),
  ("sqrt",2,sqrt), ("sqrtCall1",2,sqrtCall1),
                   ("sqrtCall2",2,sqrtCall2),
  ("boo34",1,boo34), ("boo34Call",1,boo34Call),
  ("getMax",2,getMax), ("getMaxCall",2,getMaxCall),
  ("swap",1,swap), ("swapCall",1,swapCall),
  ("partition",2,partition), ("partitionCall1",2,partitionCall1),
                             ("partitionCall2",2,partitionCall2),
                             ("partitionCall3",2,partitionCall3),
                             ("partitionCall4",2,partitionCall4),
                             ("partitionCall5",2,partitionCall5),
                             ("partitionCall6",2,partitionCall6),
  ("isAscending1",2,isAscending1), ("isAscending1Call",2,isAscending1Call),
  ("isAscending2",2,isAscending2), ("isAscending2Call",2,isAscending2Call),
  ("copyArray",2,copyArray), ("copyArrayCall",2,copyArrayCall),
  ("addElemRight",2,addElemRight), ("addElemRightCall",2,addElemRightCall),
  ("removeAtPos",2,removeAtPos), ("removeAtPosCall1",2,removeAtPosCall1),
                                ("removeAtPosCall2",2,removeAtPosCall2),
  ("takeWhileAsLongAsEven",2,takeWhileAsLongAsEven),
      ("takeWhileAsLongAsEvenCall1",2,takeWhileAsLongAsEvenCall1),
      ("takeWhileAsLongAsEvenCall2",2,takeWhileAsLongAsEvenCall2),
----------Bubble Sort:
  ("bubbleSort",2,bubbleSort), ("bubbleSortCall",2,bubbleSortCall),
  ("replicate",2,replicate), ("replicateCall",2,replicateCall),
  ("sum3",2,sum3), ("sum3Call1",2,sum3Call1),
                   ("sum3Call2",2,sum3Call2),
  ("arrayBoolean",1,arrayBoolean), ("arrayBooleanCall",1,arrayBooleanCall),
----------
  ("tail",2,tail), ("tailCall1",2,tailCall1),
                   ("tailCall2",2,tailCall2),
                   ("tailCall3",2,tailCall3),
                   ("tailCall4",2,tailCall4),
  ("doubleArrayElems",2,doubleArrayElems), ("doubleArrayElemsCall",2,doubleArrayElemsCall),
  ("doubleArrayElems2",2,doubleArrayElems2), ("doubleArrayElems2Call",2,doubleArrayElems2Call),
----------
  ("quickSort",2,quickSort), ("quickSortCall1",2,quickSortCall1)
                           , ("quickSortCall2",2,quickSortCall2)
                           , ("quickSortCall3",2,quickSortCall3),
----------
  ("idByLoop",3,idByLoop),
  ("idByLoopStride3",3,idByLoopStride3),
  ("idByLoop2",3,idByLoop2),
  ("halving",3,halving)
  ]

boo21 = "public int boo21(){\n\
        \  return 5;\n\
        \}"

boo21_2 = "public int boo21_2(){\n\
          \  int i;\n\
          \  return 5;\n\
          \}"

boo22 = "public int boo22(){\n\
        \  return boo21();\n\
        \}"

boo22_2 = "public int boo22_2(){\n\
          \  int x = boo21();\n\
          \  return x;\n\
          \}"

boo23_3 = "public int boo23_3(){\n\
          \  int x = 3 + boo21();\n\
          \  return 5;\n\
          \}"

boo23_3_1 = "public int boo23_3_1() {\n\
            \  return 3 + 5;\n\
            \}"

boo23_4 = "public int boo23_4(){\n\
          \  return 3 + boo21();\n\
          \}"

boo23_9 = "public int boo23_9(){\n\
          \  int x;\n\
          \  x = 3 + boo21();\n\
          \  return x;\n\
          \}"

boo33_3 = "public double boo33_3(){\n\
          \  double x = 1;\n\
          \  x+=0.1;\n\
          \  return x;\n\
          \}"

boo33_4 = "public double boo33_4(){\n\
          \  double x = 1;\n\
          \  x = x + 0.1;\n\
          \  return x;\n\
          \}"

boo33_5 = "public double boo33_5(String str){\n\
          \  double x = 1;\n\
          \  int y;\n\
          \  z = t;\n\
          \  x = x + 0.1;\n\
          \  return x;\n\
          \}"

boo33_6 = "public double boo33_6(String str){\n\
          \  double x = 1;\n\
          \  int y;\n\
          \  z = t;\n\
          \  x = x + 0.1;\n\
          \  z = 1;\n\
          \  return x;\n\
          \}"

boo33_7 = "public double boo33_7(){\n\
          \  double x;\n\
          \  x = c;\n\
          \  return x;\n\
          \}"

boo21_i = "public int boo21_i(int i){\n\
          \  return i;\n\
          \}"

boo21_2_i = "public int boo21_2_i(int i){\n\
            \  i = 5;\n\
            \  return i;\n\
            \}"

boo33_5_2 = "public double boo33_5_2(String str){\n\
            \  double x = 1;\n\
            \  int y;\n\
            \  z = str;\n\
            \  x = x + 0.1;\n\
            \  return x;\n\
            \}"

boo33_5_3 = "public double boo33_5_3(String str){\n\
            \  double x = 1;\n\
            \  int y;\n\
            \  str = str + \"1\";\n\
            \  z = str;\n\
            \  x = x + 0.1;\n\
            \  return x;\n\
            \}"

boo33_5_4 = "public double boo33_5_4(String str){\n\
            \  double x = 1;\n\
            \  int y;\n\
            \  z = str;\n\
            \  str = str + \"1\";\n\
            \  x = x + 0.1;\n\
            \  return x;\n\
            \}"

boo21_3_i = "public int boo21_3_i(int i){\n\
            \  i += 2;\n\
            \  return i;\n\
            \}"

boo21_3_i_1 = "public int boo21_3_i_1(int i){\n\
              \  i += 2;\n\
              \  return i+i;\n\
              \}"

boo21_3_i_2 = "public int boo21_3_i_2(int i){\n\
              \  i += 2;\n\
              \  int x = i + 5 + i;\n\
              \  return x;\n\
              \}"

boo21_3_i_3 = "public int boo21_3_i_3(int i){\n\
              \  i += 2;\n\
              \  int x = i + 5 + i;\n\
              \  return x + i + x;\n\
              \}"

boo21_3_i_4 = "public int boo21_3_i_4(int i){\n\
              \  x += i + 2 + i;\n\
              \  return x;\n\
              \}"

boo21_3_i_5 = "public int boo21_3_i_5(int i){\n\
              \  x += i + 2 - 2*i;\n\
              \  return x;\n\
              \}"

boo21_3_i_6 = "public int boo21_3_i_6(int i){\n\
              \  x += 2 + 3*i - 2*i;\n\
              \  return x;\n\
              \}"

boo21_3_i_7 = "public int boo21_3_i_7(int i){\n\
              \  x += 2 + 3*i - 2*i - i;\n\
              \  return x;\n\
              \}"

boo21_3_i_8 = "public int boo21_3_i_8(int i){\n\
              \  x += i + 2 + 3*i;\n\
              \  return x;\n\
              \}"

boo21_3_i_9 = "public int boo21_3_i_9(int i){\n\
              \  i += i;\n\
              \  return i;\n\
              \}"

boo22_i = "public int boo22_i(int i){\n\
          \  return boo21_i(i);\n\
          \}"

boo22_i_2 = "public int boo22_i_2(int i){\n\
            \  return boo21_i(i+4) + 1;\n\
            \}"

boo22_i_3 = "public int boo22_i_3(int i){\n\
            \  return boo21_3_i(i);\n\
            \}"

boo22_i_4 = "public int boo22_i_4(int i){\n\
            \  return boo21_3_i(i+4) * 5;\n\
            \}"

boo22_i_5 = "public int boo22_i_5(int i){\n\
            \  return boo21_3_i(j);\n\
            \}"

boo22_i_5_call = "public void boo22_i_5_call() {\n\
                 \  j = 9;\n\
                 \  println(toString(j));\n\
                 \  println(toString(boo22_i_5(666)));\n\
                 \  println(toString(j));\n\
                 \}"

boo22_2_i = "public int boo22_2_i(int i){\n\
            \  int x = boo21_i(i*2);\n\
            \  return x;\n\
            \}"

boo22_2_i_2 = "public int boo22_2_i_2(){\n\
              \  int j = 6;\n\
              \  int i = 3 + j;\n\
              \  int x = boo21_i(i*2);\n\
              \  return x + i + j;\n\
              \}"

boo23_3_i = "public int boo23_3_i(int i){\n\
            \  int x = 3 + boo21_i(i+i);\n\
            \  return 5;\n\
            \}"

boo23_3_i_2 = "public int boo23_3_i_2(){\n\
              \  int i = 4;\n\
              \  int x = 3 + boo21_i(i+i);\n\
              \  return x+5;\n\
              \}"

boo23_4_i = "public int boo23_4_i(int i){\n\
            \  return 3 + boo21_i(0);\n\
            \}"

boo23_4_i_2 = "public int boo23_4_i_2(){\n\
              \  return 5 * boo21_i(0*4+2);\n\
              \}"

boo23_4_i_3 = "public int boo23_4_i_3(int i){\n\
              \  return 5 * boo21_i(0*i+2);\n\
              \}"

boo23_4_i_4 = "public int boo23_4_i_4(int i){\n\
              \  return 15 * boo21_i(3*i+2);\n\
              \}"

boo23_4_i_4_1 = "public int boo23_4_i_4_1(){\n\
                \  return boo23_4_i_4(5);\n\
                \}"

boo23_4_i_5 = "public int boo23_4_i_5(int i){\n\
              \  return 15 * boo21_i(1*i+2);\n\
              \}"

boo23_5_i = "public int boo23_5_i(int i){\n\
            \  return 8;\n\
            \}"

boo23_6_i = "public double boo23_6_i(int i){\n\
            \  return 8;\n\
            \}"

boo23_7_i = "public double boo23_7_i(double i){\n\
            \  return 3+5+i;\n\
            \}"

boo23_8_i = "public int boo23_8_i(int i){\n\
            \  return 3+5*i;\n\
            \}"

boo23_9_i = "public int boo23_9_i(int i){\n\
            \  int x;\n\
            \  x = 3 + boo21_i(i+2) - i;\n\
            \  return x;\n\
            \}"

boo23_9_i_2 = "public int boo23_9_i_2(int i){\n\
              \  int x;\n\
              \  x = 3 + boo21_i(i+2) - 2*i;\n\
              \  return x;\n\
              \}"

boo23_10_i = "public int boo23_10_i(int i){\n\
             \  int x = 3+5+i;\n\
             \  return x;\n\
             \}"

boo23_10_i_2 = "public int boo23_10_i_2(int i){\n\
               \  int x = 3+i+5;\n\
               \  return x;\n\
               \}"

boo23_11_i = "public int boo23_11_i(int i){\n\
             \  int x = 3+5;\n\
             \  x = 10-1;\n\
             \  return x*i;\n\
             \}"

boo23_12_i = "public int boo23_12_i(int i){\n\
             \  int x = 3 + boo21_i(i);\n\
             \  return x;\n\
             \}"

boo33_3_i = "public double boo33_3_i(double i){\n\
            \  double x = 1 + i;\n\
            \  x+=0.1;\n\
            \  return x;\n\
            \}"

boo33_4_i = "public double boo33_4_i(double i, double j){\n\
            \  double x = 1 + i;\n\
            \  x = x + 0.1 + j;\n\
            \  return x;\n\
            \}"

boo33_4_i_call = "public double boo33_4_i_call(){\n\
                 \  double x = 1 + boo33_4_i(8.8,7.6);\n\
                 \  return x;\n\
                 \}"

boo24 :: String
boo24 = "public int boo24(){\n\
        \  int x = 3 + boo25(5);\n\
        \  return x;\n\
        \}"

boo24_2 :: String
boo24_2 = "public int boo24_2(){\n\
          \  int x = 3 + boo25(11);\n\
          \  return x;\n\
          \}"

exceptionFun :: String
exceptionFun = "public int exceptionFun() {\n\
               \  throw new Exception(\"thee\");\n\
               \}"

boo25 :: String
boo25 = "public int boo25(int i){\n\
        \  if(i>10){\n\
        \    println(\"Oopsie\");\n\
        \    throw new Exception(\"meow\");\n\
        \  }\n\
        \  else{\n\
        \    return 6;\n\
        \  }\n\
        \}"

boo26_2 :: String
boo26_2 = "public int boo26_2(){\n\
          \  return boo27(-5);\n\
          \}"

boo27 :: String
boo27 = "public int boo27(int i){\n\
        \  if(i >= 0){\n\
        \    return i;\n\
        \  }\n\
        \  else{\n\
        \    int res = -1 * i;\n\
        \    return res;\n\
        \  }\n\
        \}"

boo27_2 :: String
boo27_2 = "public int boo27_2() {\n\
          \  return boo27(5);\n\
          \}"

boo28 :: String
boo28 = "public int boo28(int i){\n\
        \  int x = 1;\n\
        \  if(i >= 0){\n\
        \    x++;\n\
        \    return i;\n\
        \  }\n\
        \  return 5;\n\
        \}"

boo282 :: String
boo282 = "public int boo282(){\n\
         \  int x = 1;\n\
         \  if(x >= 0){\n\
         \    x++;\n\
         \    return x;\n\
         \  }\n\
         \  return 5;\n\
         \}"

boo283 :: String
boo283 = "public int boo283(){\n\
         \  int x = 1;\n\
         \  if(x < 0){\n\
         \    x++;\n\
         \    return x;\n\
         \  }\n\
         \  return 5;\n\
         \}"

boo28_p :: String
boo28_p = "public int boo28_p() {\n\
          \  return boo28(10);\n\
          \}"

boo28_m :: String
boo28_m = "public int boo28_m() {\n\
          \  return boo28(-10);\n\
          \}"

boo28_2 :: String
boo28_2 = "public int boo28_2(int i){\n\
          \  int x = 1;\n\
          \  if(i >= 0){\n\
          \    x++;\n\
          \    int y = 0;\n\
          \    return i;\n\
          \  }\n\
          \  return 5;\n\
          \}"

boo28_2_1 :: String
boo28_2_1 = "public int boo28_2_1(){\n\
            \  int x = 1;\n\
            \  if(x >= 0){\n\
            \    x++;\n\
            \    int y = 0;\n\
            \    return 1+x+1;\n\
            \  }\n\
            \  return 5;\n\
            \}"

boo28_4 :: String
boo28_4 = "public int boo28_4(int i){\n\
          \  int x = 1;\n\
          \  if(i >= 0){\n\
          \    int y = 0;\n\
          \    return i;\n\
          \  }\n\
          \  else {\n\
          \   x++;\n\
          \  }\n\
          \  return 5;\n\
          \}"

boo28_4_1 :: String
boo28_4_1 = "public int boo28_4_1(int i){\n\
            \  int x = 1;\n\
            \  if(true){\n\
            \    int y = 0;\n\
            \    return i;\n\
            \  }\n\
            \  else {\n\
            \   x++;\n\
            \  }\n\
            \  return 5;\n\
            \}"

boo28_4_2 :: String
boo28_4_2 = "public int boo28_4_2(int i){\n\
            \  int x = 1;\n\
            \  if(false){\n\
            \    int y = 0;\n\
            \    return i;\n\
            \  }\n\
            \  else {\n\
            \   x++;\n\
            \  }\n\
            \  return 5;\n\
            \}"

boo28_4_p :: String
boo28_4_p = "public int boo28_4_p() {\n\
            \  return boo28_4(10);\n\
            \}"

boo28_4_m :: String
boo28_4_m = "public int boo28_4_m() {\n\
            \  return boo28_4(-10);\n\
            \}"

boo28_5 :: String
boo28_5 = "public int boo28_5(int i){\n\
          \  int x = 1;\n\
          \  if(i >= 0){\n\
          \    int y = 0;\n\
          \    y++;\n\
          \    return i+y;\n\
          \  }\n\
          \  else {\n\
          \   x++;\n\
          \  }\n\
          \  return 5;\n\
          \}"

boo28_6 :: String
boo28_6 = "public static int boo28_6(int i){\n\
          \  int x = 1;\n\
          \  if(i >= 0){\n\
          \    int y = 0;\n\
          \    y++;\n\
          \    return i+y;\n\
          \  }\n\
          \  else {\n\
          \    x++;\n\
          \  }\n\
          \  int y = 2;\n\
          \  return 5+y;\n\
          \}"

boo28_6_2 :: String
boo28_6_2 = "public static int boo28_6_2(int i){\n\
            \  int x = 1;\n\
            \  if(x >= 0){\n\
            \    int y = 0;\n\
            \    y++;\n\
            \    return i+y;\n\
            \  }\n\
            \  else {\n\
            \    x++;\n\
            \  }\n\
            \  int y = 2;\n\
            \  return 5+y;\n\
            \}"

boo28_6_3 :: String
boo28_6_3 = "public static int boo28_6_3(int i){\n\
            \  int x = 1;\n\
            \  if(x >= 0){\n\
            \    int y = 0;\n\
            \    y++;\n\
            \  }\n\
            \  else {\n\
            \    x++;\n\
            \  }\n\
            \  int y = 2;\n\
            \  return 5+y;\n\
            \}"

boo28_6_4 :: String
boo28_6_4 = "public static int boo28_6_4(int i){\n\
            \  int x = 1;\n\
            \  if(x < 0){\n\
            \    int y = 0;\n\
            \    y++;\n\
            \  }\n\
            \  else {\n\
            \    x++;\n\
            \  }\n\
            \  int y = 2;\n\
            \  return 5+y;\n\
            \}"

boo28_6_5 :: String
boo28_6_5 = "public static int boo28_6_5(int i){\n\
            \  int x = 1;\n\
            \  if(x < 0){\n\
            \    int y = 0;\n\
            \    y++;\n\
            \  }\n\
            \  else {\n\
            \    x++;\n\
            \  }\n\
            \  return x;\n\
            \}"

boo28_6_6 :: String
boo28_6_6 = "public static int boo28_6_6(int i){\n\
            \  int x = 1;\n\
            \  if(i >= 0){\n\
            \    int y = 0;\n\
            \    y++;\n\
            \    return i+y;\n\
            \  }\n\
            \  else {\n\
            \    x++;\n\
            \  }\n\
            \  return x;\n\
            \}"

boo28_6_6_2 :: String
boo28_6_6_2 = "public static int boo28_6_6_2(int i){\n\
              \  int x = 1;\n\
              \  if(i >= 0){\n\
              \    x = 0;\n\
              \  }\n\
              \  else {\n\
              \    x++;\n\
              \  }\n\
              \  return i+x;\n\
              \}"

boo28_6_6_3 :: String
boo28_6_6_3 = "public static int boo28_6_6_3(int i){\n\
              \  int x = 1;\n\
              \  if(i >= 0){\n\
              \    x = 0;\n\
              \    y = true;\n\
              \  }\n\
              \  else {\n\
              \    x++;\n\
              \    y = false;\n\
              \  }\n\
              \  return i+x;\n\
              \}"

boo28_6_6_4 = "public static int boo28_6_6_4(int i){\n\
              \  int x = 1;\n\
              \  if(i >= 0){\n\
              \    int y = 0;\n\
              \    y++;\n\
              \    return i+y;\n\
              \  }\n\
              \  else {\n\
              \    int z = 9;\n\
              \    x++;\n\
              \  }\n\
              \  return x;\n\
              \}"

boo28_6_7 :: String
boo28_6_7 = "public static int boo28_6_7(int i){\n\
            \  int x = 1;\n\
            \  if(i >= 0){\n\
            \    int y = 0;\n\
            \    y++;\n\
            \    return i+y;\n\
            \  }\n\
            \  else {\n\
            \    x++;\n\
            \  }\n\
            \  x = 5;\n\
            \  return x;\n\
            \}"

boo28_6_8 :: String
boo28_6_8 = "public int boo28_6_8(int i) {\n\
            \  int res = 0;\n\
            \  if(i % 2 == 0) {\n\
            \    res += 1;\n\
            \  }\n\
            \  if(i % 3 == 0) {\n\
            \    res *= 3;\n\
            \  }\n\
            \  return res;\n\
            \}"

boo28_6_8_call :: String
boo28_6_8_call = "public void boo28_6_8_call() {\n\
                 \  println(toString(boo28_6_8(5)));\n\
                 \  println(toString(boo28_6_8(8)));\n\
                 \  println(toString(boo28_6_8(12)));\n\
                 \}"

boo28_6_p :: String
boo28_6_p = "public int boo28_6_p() {\n\
            \  return boo28_6(10);\n\
            \}"

boo29 :: String
boo29 = "public boolean boo29(){\n\
        \  if(true){\n\
        \    return false;\n\
        \  }\n\
        \  else{\n\
        \    return true;\n\
        \  }\n\
        \}"

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

elemAt3 :: String
elemAt3 = "public int elemAt3(int pos) throws Exception {\n\
          \  if(pos<0) {\n\
          \    throw new Exception(\"too small\");\n\
          \  }\n\
          \  else {\n\
          \    int[] arr = new int[]{6,5,4,7,8};\n\
          \    if(arr.length<=pos) {\n\
          \      throw new Exception(\"not found\");\n\
          \    }\n\
          \    return arr[pos];\n\
          \  }\n\
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

voidFun4 :: String
voidFun4 = "public void voidFun4() {\n\
           \  int x;\n\
           \  String y;\n\
           \  x = 1;\n\
           \  y = \"is one\";\n\
           \  String z = toString(x) + \" \" + y;\n\
           \  println(z);\n\
           \}"

voidFun5 :: String
voidFun5 = "public void voidFun5() {\n\
           \  println(\"Before\");\n\
           \  voidFun4();\n\
           \  println(\"After\");\n\
           \}"

voidFun6 :: String
voidFun6 = "public void voidFun6(int n) {\n\
           \  println(toString(n));\n\
           \  println(toString(n+1));\n\
           \  int x = n+1;\n\
           \  println(toString(x));\n\
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

manyArrs7 :: String
manyArrs7 = "public void manyArrs7(String[] brand) {\n\
            \  for(int i=0; i<brand.length; i++) {\n\
            \    brand[i] = toString(i+1) + \". \" + brand[i];\n\
            \  }\n\
            \  println(brand);\n\
            \}"

manyArrs7Call1 :: String
manyArrs7Call1 = "public void manyArrs7Call1() {\n\
                 \  manyArrs7(new String[] {\"Toyota\",\"Mercedes\",\"BMW\",\"Volkswagen\",\"Skoda\"});\n\
                 \}"

manyArrs7Call2 :: String
manyArrs7Call2 = "public static void manyArrs7Call2() {\n\
                 \    String[] brand = new String[] {\"Toyota\",\"Mercedes\",\"BMW\",\"Volkswagen\",\"Skoda\"};\n\
                 \    manyArrs7(brand);\n\
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

ifFun4Call :: String
ifFun4Call = "public void ifFun4Call() {\n\
             \  y = 2;\n\
             \  z = ifFun4(1);\n\
             \  println(toString(y));\n\
             \  println(toString(z));\n\
             \  y = -1;\n\
             \  z = ifFun4(10);\n\
             \  println(toString(y));\n\
             \  println(toString(z));\n\
             \  y = 3;\n\
             \  z = ifFun4(9);\n\
             \  println(toString(y));\n\
             \  println(toString(z));\n\
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

ifFun6Call2 :: String
ifFun6Call2 = "public String ifFun6Call2() {\n\
              \  y = 5;\n\
              \  m = 1;\n\
              \  c = \"dangerous\";\n\
              \  return ifFun6(10) + \" \" + toString(m);\n\
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

ifFun13 :: String
ifFun13 = "public void ifFun13() {\n\
          \  if(t % 2 == 0) {\n\
          \    v = \"hi\";\n\
          \  }\n\
          \  else {\n\
          \    w = \"bye\";\n\
          \  }\n\
          \  s = \"something\" + toString(n);\n\
          \}"

ifFun13Call :: String
ifFun13Call = "public void ifFun13Call() {\n\
              \  ifFun13();\n\
              \}"

succFun :: String
succFun = "public void succFun(int i) {\n\
       \  i += 1;\n\
       \}"

succFunCall :: String
succFunCall = "public void succFunCall() {\n\
              \  int n = 2;\n\
              \  succFun(n);\n\
              \  println(toString(n));\n\
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

sum1Call1 :: String
sum1Call1 = "public String sum1Call1() {\n\
            \  return toString(sum1(21));\n\
            \}"

sum1Call2 :: String
sum1Call2 = "public String sum1Call2() {\n\
            \  return toString(sum1(x));\n\
            \}"

sum1Call3 :: String
sum1Call3 = "public String sum1Call3() {\n\
            \  x = 3;\n\
            \  return toString(sum1(x));\n\
            \}"

sum2 :: String
sum2 = "public int sum2() {\n\
       \  int res = 0;\n\
       \  int n = 21;\n\
       \  for(int i=0; n>0; n--) {\n\
       \    res += n;\n\
       \  }\n\
       \  return res;\n\
       \}"

sum4 = "public int sum4(int n) {\n\
       \  int res = 0;\n\
       \  for(;n>0;) {\n\
       \    res += n;\n\
       \     n--;\n\
       \  }\n\
       \  return res;\n\
       \}"

sum4Call = "public int sum4Call() {\n\
           \  return sum4(3);\n\
           \}"

sum1_While = "public int sum1_While(int n) {\n\
             \  int res = 0;\n\
             \  while(n>0) {\n\
             \    res += n;\n\
             \    n--;\n\
             \  }\n\
             \  return res;\n\
             \}"

sumOddNums = "public int sumOddNums(int[] nums) {\n\
             \  int sum = 0;\n\
             \  for (int i=0; i<nums.length; i++) {\n\
             \      if (nums[i] % 2 == 0) {\n\
             \        continue;\n\
             \      }\n\
             \      sum += nums[i];\n\
             \  }\n\
             \  return sum;\n\
             \}"

sumOddNumsCall1 = "public int sumOddNumsCall1() {\n\
                  \  int x = sumOddNums(new int[]{1,2,3,4});\n\
                  \  return x;\n\
                  \}"

sumOddNumsCall2 = "public int sumOddNumsCall2() {\n\
                  \  int x = sumOddNums(new int[]{1,3});\n\
                  \  return x;\n\
                  \}"

sumUntilNegative = "public int sumUntilNegative(int[] nums) {\n\
                   \    int sum = 0;\n\
                   \    for (int i=0; i<nums.length; i++) {\n\
                   \        if (nums[i] < 0) {\n\
                   \            break;\n\
                   \        }\n\
                   \        sum += nums[i];\n\
                   \    }\n\
                   \    return sum;\n\
                   \}"

sumUntilNegativeCall1 = "public int sumUntilNegativeCall1() {\n\
                        \  return sumUntilNegative(new int[]{});\n\
                        \}"

sumUntilNegativeCall2 = "public int sumUntilNegativeCall2() {\n\
                        \  return sumUntilNegative(new int[]{4,1,-2,1});\n\
                        \}"

processArray1 = "public int processArray1(int[] arr) {\n\
                \  int sum = 0;\n\
                \  for (int i = 0; i < arr.length; i++) {\n\
                \    if (arr[i] % 2 == 0) {\n\
                \      sum += arr[i];\n\
                \    } else {\n\
                \      sum -= arr[i];\n\
                \    }\n\
                \  }\n\
                \  return sum;\n\
                \}"

processArray1Call = "public int processArray1Call() {\n\
                    \  int x = processArray1(new int[]{1,2,3,4});\n\
                    \  return x;\n\
                    \}"

fillArray = "public int[] fillArray(int size, int elem) {\n\
            \  int[] arr = new int[size];\n\
            \  for(int i=0; i<size; i++) {\n\
            \    arr[i] = elem;\n\
            \  }\n\
            \  return arr;\n\
            \}"

fillArrayCall = "public void fillArrayCall() {\n\
                \  println(fillArray(5,10));\n\
                \}"

sqrt = "public static int sqrt(int y) throws Exception{\n\
       \  for(int i=0; i<=y; i=i+1){\n\
       \    int j = i*i;\n\
       \    if(j==y){\n\
       \      return i;\n\
       \    }\n\
       \    else{\n\
       \      if(i==y){\n\
       \        throw new Exception(\"not found\");\n\
       \      }\n\
       \    }\n\
       \  }\n\
       \}"

sqrtCall1 = "public static int sqrtCall1() {\n\
            \  int x = sqrt(9);\n\
            \  return x;\n\
            \}"

sqrtCall2 = "public static int sqrtCall2() {\n\
            \  int x = sqrt(8);\n\
            \  return x;\n\
            \}"

boo34 = "public void boo34(String input){\n\
        \  if (input.length > 0) {\n\
        \    String msg = \"non-empty\";\n\
        \    status = msg;\n\
        \  } else {\n\
        \    String msg = \"empty\";\n\
        \    status = msg;\n\
        \  }\n\
        \}"

boo34Call = "public void boo34Call() {\n\
            \  boo34(\"Hello\");\n\
            \  println(status);\n\
            \  boo34(\"\");\n\
            \  println(status);\n\
            \}"

sum1_WhileCall = "public int sum1_WhileCall() {\n\
                 \  return sum1_While(3);\n\
                 \}"

sum1_While2 = "public int sum1_While2(int n) {\n\
              \  int res = 0;\n\
              \  while(true) {\n\
              \    res += n;\n\
              \    n--;\n\
              \    if(n<=0) {\n\
              \      break;\n\
              \    }\n\
              \  }\n\
              \  return res;\n\
              \}"

sum1_While2Call1 = "public int sum1_While2Call1() {\n\
                   \  return sum1_While2(0);\n\
                   \}"

sum1_While2Call2 = "public int sum1_While2Call2() {\n\
                   \  return sum1_While2(3);\n\
                   \}"

isEmpty = "public boolean isEmpty(int[] arr) {\n\
          \  return arr.length == 0;\n\
          \}"

callIsEmpty = "public boolean callIsEmpty() {\n\
              \  return isEmpty(new int[]{});\n\
              \}"

callIsNotEmpty = "public boolean callIsNotEmpty() {\n\
                 \  return isEmpty(new int[]{1,2,3});\n\
                 \}"

getMax = "public static int getMax(int[] arr) throws Exception {\n\
         \  if(arr.length == 0) {\n\
         \    throw new Exception(\"empty array\");\n\
         \  }\n\
         \  else {\n\
         \    int max = arr[0];\n\
         \    for(int i=1; i<arr.length; i++) {\n\
         \      if(arr[i] > max) {\n\
         \        max = arr[i];\n\
         \      }\n\
         \    }\n\
         \    return max;\n\
         \  }\n\
         \}"

getMaxCall = "public static int getMaxCall() {\n\
             \  return getMax(new int[] {5,4,6,4,7,8,9,0,1});\n\
             \}"

swap = "private static void swap(int[] arr, int i, int j) {\n\
       \  int temp = arr[i];\n\
       \  arr[i] = arr[j];\n\
       \  arr[j] = temp;\n\
       \}"

swapCall = "private static void swapCall() {\n\
           \  int[] arr = new int[] {5,4,6,4,7,8,9,0,1};\n\
           \  swap(arr,0,1);\n\
           \}"


partition = "private static int partition(int[] arr, int low, int high) {\n\
            \  int pivot = arr[high];\n\
            \  int i = low - 1;\n\
            \  for (int j = low; j < high; j++) {\n\
            \    if (arr[j] < pivot) {\n\
            \      i++;\n\
            \      swap(arr, i, j);\n\
            \    }\n\
            \  }\n\
            \  swap(arr, i + 1, high);\n\
            \  return i + 1;\n\
            \}"

partitionCall1 = "private static void partitionCall1() {\n\
                 \  int[] arr = {7};\n\
                 \  int x = partition(arr,0,0);\n\
                 \  println(arr);\n\
                 \  println(toString(x));\n\
                 \}"

partitionCall2 = "private static void partitionCall2() {\n\
                 \  int[] arr = {9,7};\n\
                 \  int x = partition(arr,0,1);\n\
                 \  println(arr);\n\
                 \  println(toString(x));\n\
                 \}"

partitionCall3 = "private static void partitionCall3() {\n\
                 \  int[] arr = {3,7};\n\
                 \  int x = partition(arr,0,1);\n\
                 \  println(arr);\n\
                 \  println(toString(x));\n\
                 \}"

partitionCall4 = "private static void partitionCall4() {\n\
                 \  int[] arr = {9,3,7};\n\
                 \  int x = partition(arr,0,2);\n\
                 \  println(arr);\n\
                 \  println(toString(x));\n\
                 \}"

partitionCall5 = "private static void partitionCall5() {\n\
                 \  int[] arr = {1,2,7};\n\
                 \  int x = partition(arr,0,2);\n\
                 \  println(arr);\n\
                 \  println(toString(x));\n\
                 \}"

partitionCall6 = "private static void partitionCall6() {\n\
                 \  int[] arr = {9,8,7};\n\
                 \  int x = partition(arr,0,2);\n\
                 \  println(arr);\n\
                 \  println(toString(x));\n\
                 \}"

isAscending1 = "public boolean isAscending1(int[] arr) {\n\
               \  boolean res = true;\n\
               \  for(int i = 0; i<arr.length-1; i++) {\n\
               \    if(arr[i] > arr[i+1]) {\n\
               \      res = false;\n\
               \    }\n\
               \  }\n\
               \  return res;\n\
               \}"

isAscending1Call = "public void isAscending1Call() {\n\
                   \  int[] arr1 = new int[]{1,2,4,6,7,99};\n\
                   \  int[] arr2 = new int[]{1,2,4,7,6,99};\n\
                   \  println(toString(isAscending1(arr1)));\n\
                   \  println(toString(isAscending1(arr2)));\n\
                   \}"

isAscending2 = "public boolean isAscending2(int[] arr) {\n\
               \  for(int i = 0; i<arr.length-1; i++) {\n\
               \    if(arr[i] > arr[i+1]) {\n\
               \      return false;\n\
               \    }\n\
               \  }\n\
               \  return true;\n\
               \}"

isAscending2Call = "public void isAscending2Call() {\n\
                   \  int[] arr1 = new int[]{1,2,4,6,7,99};\n\
                   \  int[] arr2 = new int[]{1,2,4,7,6,99};\n\
                   \  println(toString(isAscending2(arr1)));\n\
                   \  println(toString(isAscending2(arr2)));\n\
                   \}"

copyArray = "public int[] copyArray(int[] arr) {\n\
            \  int[] copy = new int[arr.length];\n\
            \  for(int i=0; i<arr.length; i++) {\n\
            \    copy[i] = arr[i];\n\
            \  }\n\
            \  return copy;\n\
            \}"

copyArrayCall = "public void copyArrayCall() {\n\
                \  int[] arr = new int[]{1,4,6,8};\n\
                \  int[] c = copyArray(arr);\n\
                \  println(arr);\n\
                \  println(c);\n\
                \}"

addElemRight = "public int[] addElemRight(int[] arr, int elem) {\n\
               \  int[] res = new int[arr.length + 1];\n\
               \  for(int i=0; i<arr.length; i++) {\n\
               \    res[i] = arr[i];\n\
               \  }\n\
               \  res[arr.length] = elem;\n\
               \  return res;\n\
               \}"

addElemRightCall = "public void addElemRightCall() {\n\
                   \  int[] arr = addElemRight(new int[]{1,2,3},4);\n\
                   \  println(arr);\n\
                   \}"

removeAtPos = "public int[] removeAtPos(int[] arr, int pos) {\n\
              \  int[] res = new int[arr.length-1];\n\
              \  int j = 0;\n\
              \  for(int i=0; i<arr.length; i++) {\n\
              \    if(i == pos) {\n\
              \      continue;\n\
              \    }\n\
              \    res[j] = arr[i];\n\
              \    j++;\n\
              \  }\n\
              \  return res;\n\
              \}"

removeAtPosCall1 = "public void removeAtPosCall1() {\n\
                   \  int[] arr = removeAtPos(new int[]{1,2,3},1);\n\
                   \  println(arr);\n\
                   \}"

removeAtPosCall2 = "public void removeAtPosCall2() {\n\
                   \  int[] arr = removeAtPos(new int[]{4,9},0);\n\
                   \  println(arr);\n\
                   \}"

takeWhileAsLongAsEven = "public int[] takeWhileAsLongAsEven(int[] arr) {\n\
                        \  int[] res = new int[0];\n\
                        \  for(int i=0; i<arr.length; i++) {\n\
                        \    if(arr[i] % 2 == 0) {\n\
                        \      int[] temp = new int[res.length+1];\n\
                        \      for(int j=0; j<=i; j++) {\n\
                        \        if(j<i) {\n\
                        \         temp[j] = res[j];\n\
                        \        }\n\
                        \        else {\n\
                        \          temp[j] = arr[i];\n\
                        \        }\n\
                        \      }\n\
                        \      res = temp;\n\
                        \    }\n\
                        \    else {\n\
                        \      return res;\n\
                        \    }\n\
                        \  }\n\
                        \  return res;\n\
                        \}"

takeWhileAsLongAsEvenCall1 = "public void takeWhileAsLongAsEvenCall1() {\n\
                             \  int[] arr = takeWhileAsLongAsEven(new int[]{2,4,6,8});\n\
                             \  println(arr);\n\
                             \}"

takeWhileAsLongAsEvenCall2 = "public void takeWhileAsLongAsEvenCall2() {\n\
                             \  int[] arr = takeWhileAsLongAsEven(new int[]{2,4,7,6,8});\n\
                             \  println(arr);\n\
                             \}"

bubbleSort = "public static void bubbleSort(int[] arr) {\n\
             \  int n = arr.length;\n\
             \  for (int i = 0; i < n - 1; i++) {\n\
             \    for (int j = 0; j < n - i - 1; j++) {\n\
             \      if (arr[j] > arr[j + 1]) {\n\
             \        int temp = arr[j];\n\
             \        arr[j] = arr[j + 1];\n\
             \        arr[j + 1] = temp;\n\
             \      }\n\
             \    }\n\
             \  }\n\
             \}"

bubbleSortCall = "public static void bubbleSortCall() {\n\
                 \  int[] arr = new int[] {5,4,6,4,7,8,9,0,1};\n\
                 \  bubbleSort(arr);\n\
                 \  return arr;\n\
                 \}"

replicate = "public String replicate(int n,String v) {\n\
            \  String core = v;\n\
            \  String res = \"\";\n\
            \  for(int i=n; i>0; i--) {\n\
            \    res += core;\n\
            \  }\n\
            \  return res;\n\
            \}"

replicateCall = "public String replicateCall() {\n\
                \  String str = replicate(5,\"qw\");\n\
                \  return str;\n\
                \}"

sum3 = "public int sum3(int n) {\n\
       \  int res = 0;\n\
       \  for(;; n--) {\n\
       \    if (n<=0) {\n\
       \      break;\n\
       \    }\n\
       \    res += n;\n\
       \  }\n\
       \  return res;\n\
       \}"

sum3Call1 = "public int sum3Call1() {\n\
            \  int x = sum3(0);\n\
            \  return x;\n\
            \}"

sum3Call2 = "public int sum3Call2() {\n\
            \  int x = sum3(3);\n\
            \  return x;\n\
            \}"

arrayBoolean = "public static boolean arrayBoolean(int[] arr) {\n\
               \  return arr == null || arr.length <= 1;\n\
               \}"

arrayBooleanCall = "public static void arrayBooleanCall() {\n\
                   \  println(toString(arrayBoolean(new int[] {5})));\n\
                   \  println(toString(arrayBoolean(new int[] {5,6})));\n\
                   \  println(toString(arrayBoolean(null)));\n\
                   \}"

tail = "public static int[] tail(int[] arr) {\n\
       \  if (arr == null || arr.length <= 1) {\n\
       \    throw new Exception(\"array is too small\");\n\
       \  }\n\
       \  else {\n\
       \    int[] arr2 = new int[arr.length-1];\n\
       \    int j = 0;\n\
       \    for (int i = 1; i<arr.length; i++) {\n\
       \      arr2[j] = arr[i];\n\
       \      j++;\n\
       \    }\n\
       \    return arr2;\n\
       \  }\n\
       \}"

tailCall1 = "public static void tailCall1() {\n\
            \    println(tail(null));\n\
            \}"

tailCall2 = "public static void tailCall2() {\n\
            \    println(tail(new int[]{}));\n\
            \}"

tailCall3 = "public static void tailCall3() {\n\
            \    println(tail(new int[]{4, 9}));\n\
            \}"

tailCall4 = "public static void tailCall4() {\n\
            \    println(tail(new int[]{4, 9, 2}));\n\
            \}"

doubleArrayElems = "public static void doubleArrayElems(int[] arr) {\n\
                   \  for(int i=0; i<arr.length; i++) {\n\
                   \    int x = arr[i];\n\
                   \    arr[i] += x;\n\
                   \  }\n\
                   \  println(arr);\n\
                   \}"

doubleArrayElemsCall = "public static void doubleArrayElemsCall() {\n\
                       \  doubleArrayElems(new int[]{1,2,3});\n\
                       \}"

doubleArrayElems2 = "public static void doubleArrayElems2(int[] arr) {\n\
                    \  int i = 0;\n\
                    \  while(i<arr.length) {\n\
                    \    int x = arr[i];\n\
                    \    arr[i] += x;\n\
                    \    i++;\n\
                    \  }\n\
                    \  println(arr);\n\
                    \}"

doubleArrayElems2Call = "public static void doubleArrayElems2Call() {\n\
                        \  doubleArrayElems2(new int[]{1,2,3});\n\
                        \}"

quickSort = "public static void quickSort(int[] arr) {\n\
            \  if (arr == null || arr.length <= 1) {\n\
            \    return;\n\
            \  }\n\
            \\n\
            \  int[] stack = new int[arr.length * 2];\n\
            \  int top = -1;\n\
            \\n\
            \  top++;\n\
            \  stack[top] = 0;\n\
            \  top++;\n\
            \  stack[top] = arr.length - 1;\n\
            \\n\
            \  while (top >= 1) {\n\
            \    int high = stack[top];\n\
            \    top--;\n\
            \    int low = stack[top];\n\
            \    top--;\n\
            \\n\
            \    int pivotIndex = partition(arr, low, high);\n\
            \\n\
            \    if (pivotIndex - 1 > low) {\n\
            \      top++;\n\
            \      stack[top] = low;\n\
            \      top++;\n\
            \      stack[top] = pivotIndex - 1;\n\
            \    }\n\
            \\n\
            \    if (pivotIndex + 1 < high) {\n\
            \      top++;\n\
            \      stack[top] = pivotIndex + 1;\n\
            \      top++;\n\
            \      stack[top] = high;\n\
            \    }\n\
            \  }\n\
            \}"

quickSortCall1 = "public static int[] quickSortCall1() {\n\
                 \  int[] arr = null;\n\
                 \  quickSort(arr);\n\
                 \  return arr;\n\
                 \}"

quickSortCall2 = "public static int[] quickSortCall2() {\n\
                 \  int[] arr = new int[] {7};\n\
                 \  quickSort(arr);\n\
                 \  return arr;\n\
                 \}"

quickSortCall3 = "public static int[] quickSortCall3() {\n\
                 \  int[] arr = new int[] {1,5,2,4,3};\n\
                 \  quickSort(arr);\n\
                 \  return arr;\n\
                 \}"

idByLoop = "public static int idByLoop(int n) {\n\
           \  int i = 0;\n\
           \  while (i < n) {\n\
           \    i++;\n\
           \  }\n\
           \  return i;\n\
           \}"

idByLoopStride3 = "int idByLoopStride3 (int n) {\n\
                  \  int i = 0;\n\
                  \  while(i<n) {\n\
                  \    i+=3;\n\
                  \  }\n\
                  \  return i;\n\
                  \}"

idByLoop2 = "public static int idByLoop2(int n) {\n\
            \  int i = 0;\n\
            \  while (true) {\n\
            \    if(i >= n) {\n\
            \      break;\n\
            \    }\n\
            \    i++;\n\
            \  }\n\
            \  return i;\n\
            \}"

halving = "int halving (int n) {\n\
          \  int i = 0;\n\
          \  while(i<n) {\n\
          \    n--;\n\
          \    i++;\n\
          \  }\n\
          \  return i;\n\
          \}"
