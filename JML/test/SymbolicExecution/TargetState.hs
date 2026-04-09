module SymbolicExecution.TargetState (target) where

import Prelude hiding (id, replicate, tail, sqrt)
import qualified Data.Map as Map

import CFG.Types
import Parser.Types
import SymbolicExecution.Types hiding (SymType(..), SymBinOp(..))
import qualified SymbolicExecution.Types as SYT (SymType(..), SymBinOp(..))
import qualified Data.Map.Lazy as Map

target :: String -> SymStateEnv
target name = case lookup name allTargets of
  Nothing -> error $ "testing ==> SymbolicExecution ==> target ==> funname does not exist: " ++ name
  Just stateEnv -> stateEnv

allTargets :: [(String,SymStateEnv)]
allTargets = [
  ("boo24",boo24),
  ("boo24_2",boo24_2),
  ("boo25",boo25),
  ("boo26_2",boo26_2),
  ("boo27",boo27),
  ("boo27_2",boo27_2),
  ("boo28",boo28),
  ("boo282",boo282),
  ("boo283",boo283),
  ("boo28_p",boo28_p),
  ("boo28_m",boo28_m),
  ("boo28_2",boo28_2),
  ("boo28_2_1",boo28_2_1),
  ("boo28_4",boo28_4),
  ("boo28_4_1",boo28_4_1),
  ("boo28_4_2",boo28_4_2),
  ("boo28_4_p",boo28_4_p),
  ("boo28_4_m",boo28_4_m),
  ("boo28_5",boo28_5),
  ("boo28_6",boo28_6),
  ("boo28_6_2",boo28_6_2),
  ("boo28_6_3",boo28_6_3),
  ("boo28_6_4",boo28_6_4),
  ("boo28_6_5",boo28_6_5),
  ("boo28_6_6",boo28_6_6),
  ("boo28_6_7",boo28_6_7),
  ("boo28_6_p",boo28_6_p),
  ("boo29",boo29),
  ("boo30",boo30),
  ("boo31",boo31),
  ("boo31_2", boo31_2),
  ("boo31_3", boo31_3),
  ("boo32", boo32), ("boo32Call", boo32Call),
  ("elemAt", elemAt), ("elemAtCall", elemAtCall),
  ("elemAt2", elemAt2), ("elemAt2Call", elemAt2Call),
                        ("elemAt2Call2", elemAt2Call2),
  ("elemAt4", elemAt4),
  ("strFun", strFun),
  ("voidFun1",voidFun1),
  ("voidFun2",voidFun2),
  ("voidFun3",voidFun3),
  ("manyArrs",manyArrs),
  ("manyArrs2",manyArrs2),
  ("manyArrs3",manyArrs3),
  ("manyArrs4", manyArrs4),
  ("manyArrs5", manyArrs5),
  ("manyArrs6", manyArrs6),
  ("manyArrs7", manyArrs7), ("manyArrs7Call1", manyArrs7Call1), ("manyArrs7Call2", manyArrs7Call2),
  ("ifFun",ifFun),
  ("ifFun2",ifFun2),
  ("ifFunCall",ifFunCall), ("ifFun2Call",ifFun2Call), ("ifFun2Call2",ifFun2Call2),
  ("ifFun3",ifFun3), ("voidFun3Call", voidFun3Call),
  ("ifFun4",ifFun4), ("ifFun4Call", ifFun4Call),
  ("ifFun5",ifFun5), ("ifFun5Call1",ifFun5Call1), ("ifFun5Call2",ifFun5Call2),
  ("ifFun6",ifFun6), ("ifFun6Call",ifFun6Call), ("ifFun6Call2", ifFun6Call2),
  ("ifFun7",ifFun7), ("ifFun7Call",ifFun7Call), ("ifFun7Call2",ifFun7Call2), ("ifFun7Call3",ifFun7Call3),
  ("ifFun8",ifFun8), ("ifFun8Call",ifFun8Call),
  ("ifFun9",ifFun9),
  ("ifFun10",ifFun10),
  ("ifFun11",ifFun11),
  ("ifFun12",ifFun12),
  ("succFun", succFun), ("succFunCall", succFunCall), ("callSuccFun", callSuccFun), ("callCallSuccFun", callCallSuccFun),
  ("wrongSum1", wrongSum1),
  ("wrongSum2", wrongSum2),
  ("wrongSum3", wrongSum3),
  ("wrongSum4", wrongSum4),
  ("wrongSum5", wrongSum5),
  ("for1", for1),
  ("for2", for2),
  ("for3", for3),
  ("sum1", sum1), ("sum1Call1", sum1Call1),
                  ("sum1Call2", sum1Call2),
                  ("sum1Call3", sum1Call3),
  ("sum2", sum2),
  ("sum4", sum4), ("sum4Call", sum4Call),
  ("sum1_While", sum1_While), ("sum1_WhileCall", sum1_WhileCall),
  ("sum1_While2", sum1_While2), ("sum1_While2Call1", sum1_While2Call1),
                                ("sum1_While2Call2", sum1_While2Call2),
  ("sumOddNums", sumOddNums), ("sumOddNumsCall1", sumOddNumsCall1),
                              ("sumOddNumsCall2", sumOddNumsCall2),
  ("sumUntilNegative", sumUntilNegative), ("sumUntilNegativeCall1", sumUntilNegativeCall1),
                                          ("sumUntilNegativeCall2", sumUntilNegativeCall2),
  ("processArray1", processArray1), ("processArray1Call", processArray1Call),
  ("isEmpty", isEmpty), ("callIsEmpty", callIsEmpty), ("callIsNotEmpty", callIsNotEmpty),
  ("fillArray", fillArray), ("fillArrayCall", fillArrayCall),
  ("sqrt", sqrt), ("sqrtCall1", sqrtCall1),
                  ("sqrtCall2", sqrtCall2),
  ("getMax", getMax), ("getMaxCall", getMaxCall),
  ("swap",swap), ("swapCall",swapCall),
  ("partition", partition), ("partitionCall1", partitionCall1),
                            ("partitionCall2", partitionCall2),
                            ("partitionCall3", partitionCall3),
                            ("partitionCall4", partitionCall4),
                            ("partitionCall5", partitionCall5),
                            ("partitionCall6", partitionCall6),
  ("isAscending1", isAscending1), ("isAscending1Call", isAscending1Call),
  ("isAscending2", isAscending2), ("isAscending2Call", isAscending2Call),
  ("copyArray", copyArray), ("copyArrayCall", copyArrayCall),
  ("addElemRight", addElemRight), ("addElemRightCall", addElemRightCall),
  ("removeAtPos", removeAtPos), ("removeAtPosCall1", removeAtPosCall1),
                                ("removeAtPosCall2", removeAtPosCall2),
  ("takeWhileAsLongAsEven", takeWhileAsLongAsEven),
      ("takeWhileAsLongAsEvenCall1", takeWhileAsLongAsEvenCall1),
      ("takeWhileAsLongAsEvenCall2", takeWhileAsLongAsEvenCall2),
----------Bubble Sort:
  ("bubbleSort", bubbleSort), ("bubbleSortCall", bubbleSortCall),
  ("replicate", replicate), ("replicateCall", replicateCall),
  ("sum3", sum3), ("sum3Call1", sum3Call1),
                  ("sum3Call2", sum3Call2),
  ("arrayBoolean", arrayBoolean), ("arrayBooleanCall", arrayBooleanCall),
----------
  ("tail", tail), ("tailCall1", tailCall1),
                  ("tailCall2", tailCall2),
                  ("tailCall3", tailCall3),
                  ("tailCall4", tailCall4),
  ("doubleArrayElems", doubleArrayElems), ("doubleArrayElemsCall", doubleArrayElemsCall),
  ("doubleArrayElems2", doubleArrayElems2), ("doubleArrayElems2Call", doubleArrayElems2Call),
  ("quickSort", quickSort), ("quickSortCall1", quickSortCall1)
                          , ("quickSortCall2", quickSortCall2)
                          , ("quickSortCall3", quickSortCall3)
  ]

-----------------------------
-----------------------------
-----------------------------

boo24 :: SymStateEnv
boo24 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo24"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 9,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 9),
    (Return,SymInt 9)
  ]

-----------------------------
-----------------------------
-----------------------------

boo24_2 :: SymStateEnv
boo24_2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo24_2"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SException SYT.Int "Exception" "meow",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SException SYT.Int "Exception" "meow"),
    (Return,SException SYT.Int "Exception" "meow"),
    (Actions,SActions [SymString "Oopsie\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

boo25 :: SymStateEnv
boo25 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo25"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments []),
    (VarName "i",SymVar SYT.Int "i"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 5}),
     SIte (SBin (SymVar SYT.Int "i") SYT.Gt (SymInt 10))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo25"),
              (FormalParms,SFormalParms ["i"]),
              (VarName "i",SymVar SYT.Int "i"),
              (Return,SException SYT.Int "Exception" "meow"),
              (Actions,SActions [SymString "Oopsie\n"])])
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo25"),
              (FormalParms,SFormalParms ["i"]),
              (VarName "i",SymVar SYT.Int "i"),
              (Return,SymInt 6)])))
  ]

-----------------------------
-----------------------------
-----------------------------

boo26_2 :: SymStateEnv
boo26_2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo26_2"),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo27 :: SymStateEnv
boo27 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo27"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments []),
    (VarName "i",SymVar SYT.Int "i"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 5}),
     SIte (SBin (SymVar SYT.Int "i") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo27"),
              (FormalParms,SFormalParms ["i"]),
              (VarName "i",SymVar SYT.Int "i"),
              (Return,SymVar SYT.Int "i")])
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo27"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})])),
              (VarAssignments,SVarAssignments [
                  ("res",(SBin (SymInt (-1)) SYT.Mul (SymVar SYT.Int "i"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "res",SBin (SymInt (-1)) SYT.Mul (SymVar SYT.Int "i")),
              (Return,SBin (SymInt (-1)) SYT.Mul (SymVar SYT.Int "i"))])))
  ]

-----------------------------
-----------------------------
-----------------------------

boo27_2 :: SymStateEnv
boo27_2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo27_2"),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28 :: SymStateEnv
boo28 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 5})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),
     SIte (SBin (SymVar SYT.Int "i") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo28"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
                  ("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "x",SymInt 2),
              (Return,SymVar SYT.Int "i")])
          Nothing),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo282 :: SymStateEnv
boo282 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo282"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
    (VarName "x",SymInt 2),
    (Return,SymInt 2),
    (Actions,SActions [])
  ]

-----------------------------
-----------------------------
-----------------------------

boo283 :: SymStateEnv
boo283 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo283"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "x",SymInt 1),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_p :: SymStateEnv
boo28_p = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_p"),
    (Return,SymInt 10)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_m :: SymStateEnv
boo28_m = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_m"),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_2 :: SymStateEnv
boo28_2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 6})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SIte (SBin (SymVar SYT.Int "i") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo28_2"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
                  ("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
                  ("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})),
                  ("y",(SymInt 0,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "x",SymInt 2),
              (VarName "y",SymInt 0),
              (Return,SymVar SYT.Int "i")])
          Nothing),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_2_1 :: SymStateEnv
boo28_2_1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_2_1"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("y",(SymInt 0,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "x",SymInt 2),
    (Return,SymInt 4),
    (Actions,SActions [])
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_4 :: SymStateEnv
boo28_4 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_4"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SIte (SBin (SymVar SYT.Int "i") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo28_4"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),
                  ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
                  ("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "x",SymInt 1),
              (VarName "y",SymInt 0),
              (Return,SymVar SYT.Int "i")])
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo28_4"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
                  ("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "x",SymInt 2)]))),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_4_1 :: SymStateEnv
boo28_4_1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_4_1"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymInt 1),
    (Return,SymVar SYT.Int "i"),
    (Actions,SActions [])
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_4_2 :: SymStateEnv
boo28_4_2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_4_2"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymInt 2),
    (Return,SymInt 5),
    (Actions,SActions [])
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_4_p :: SymStateEnv
boo28_4_p = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_4_p"),
    (Return,SymInt 10)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_4_m :: SymStateEnv
boo28_4_m = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_4_m"),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_5 :: SymStateEnv
boo28_5 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_5"),
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
              (MethodHandle,SMethodHandle SYT.Int "boo28_5"),
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
              (MethodHandle,SMethodHandle SYT.Int "boo28_5"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
                  ("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "x",SymInt 2)]))),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_6 :: SymStateEnv
boo28_6 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_6"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})),
        ("y",(SymInt 2,Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymUnknown (SymInt 1) [([(If,SR {branchStart = 2, branchEnd = 7})],6)]),
    (VarName "y",SymInt 2),
    (ScopeRange (SR {branchStart = 2, branchEnd = 7}),
     SIte (SBin (SymVar SYT.Int "i") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo28_6"),
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
              (MethodHandle,SMethodHandle SYT.Int "boo28_6"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
                  ("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "x",SymInt 2)]))),
    (Return,SymInt 7)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_6_2 :: SymStateEnv
boo28_6_2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_6_2"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})),
        ("y",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymInt 1),
    (Return,SBin (SymVar SYT.Int "i") SYT.Add (SymInt 1)),
    (Actions,SActions [])
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_6_3 :: SymStateEnv
boo28_6_3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_6_3"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
        ("y",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("y",(SymInt 0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("y",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("y",(SymInt 2,Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 8}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymInt 1),
    (VarName "y",SymInt 2),
    (Return,SymInt 7),
    (Actions,SActions [])
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_6_4 :: SymStateEnv
boo28_6_4 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_6_4"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
        ("y",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("y",(SymInt 2,Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 8}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymInt 2),
    (VarName "y",SymInt 2),
    (Return,SymInt 7),
    (Actions,SActions [])
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_6_5 :: SymStateEnv
boo28_6_5 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_6_5"),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymInt 2),
    (Return,SymInt 2),
    (Actions,SActions [])
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_6_6 :: SymStateEnv
boo28_6_6 = Map.fromList [
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

-----------------------------
-----------------------------
-----------------------------

boo28_6_7 :: SymStateEnv
boo28_6_7 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_6_7"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["i"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})),
        ("x",(SymInt 5,Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "x",SymInt 5),
    (ScopeRange (SR {branchStart = 2, branchEnd = 7}),
     SIte (SBin (SymVar SYT.Int "i") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo28_6_7"),
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
              (MethodHandle,SMethodHandle SYT.Int "boo28_6_7"),
              (FormalParms,SFormalParms ["i"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
                  ("x",(SymInt 2,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
              (VarName "i",SymVar SYT.Int "i"),
              (VarName "x",SymInt 2)]))),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

boo28_6_p :: SymStateEnv
boo28_6_p = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo28_6_p"),
    (Return,SymInt 11)
  ]

-----------------------------
-----------------------------
-----------------------------

boo29 :: SymStateEnv
boo29 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Bool "boo29"),
    (Return,SBool False),
    (Actions,SActions [])
  ]

-----------------------------
-----------------------------
-----------------------------

boo30 :: SymStateEnv
boo30 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo30"),
    (GlobalVars,SGlobalVars ["y","y1","y2","t1","t2"]),
    (FormalParms,SFormalParms ["z"]),
    (VarBindings,SVarBindings (Map.fromList [
      ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
      ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("x1",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("x2",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("y",(SymNum 0.0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("y1",(SymNum 0.0,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("y2",(SymNum 0.0,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("t1",(SymInt 7,Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}})),
        ("t2",(SymInt 17,Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}}))]),
    (VarName "t1",SymUnknown (SymVar SYT.Int "t1") [([(If,SR {branchStart = 6, branchEnd = 11})],7)]),
    (VarName "t2",SymUnknown (SymVar SYT.Int "t2") [([(If,SR {branchStart = 6, branchEnd = 11})],9)]),
    (VarName "x1",SymInt 0),
    (VarName "x2",SymInt 0),
    (VarName "y",SymNum 0.0),
    (VarName "y1",SymNum 0.0),
    (VarName "y2",SymNum 0.0),
    (VarName "z",SymVar SYT.Int "z"),
    (ScopeRange (SR {branchStart = 6, branchEnd = 11}),
     SIte (SBin (SymVar SYT.Int "z") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo30"),
              (GlobalVars,SGlobalVars ["y","y1","y2","t1"]),
              (FormalParms,SFormalParms ["z"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [
                  ("x1",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("x2",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("y",(SymNum 0.0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("y1",(SymNum 0.0,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("y2",(SymNum 0.0,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("t1",(SymInt 7,Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}}))]),
              (VarName "t1",SymInt 7),
              (VarName "x1",SymInt 0),
              (VarName "x2",SymInt 0),
              (VarName "y",SymNum 0.0),
              (VarName "y1",SymNum 0.0),
              (VarName "y2",SymNum 0.0),
              (VarName "z",SymVar SYT.Int "z"),
              (Return,SymInt 7)
          ])
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "boo30"),
              (GlobalVars,SGlobalVars ["y","y1","y2","t2"]),
              (FormalParms,SFormalParms ["z"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
                  ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [
                  ("x1",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("x2",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("y",(SymNum 0.0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("y1",(SymNum 0.0,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("y2",(SymNum 0.0,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("t2",(SymInt 17,Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}}))]),
              (VarName "t2",SymInt 17),
              (VarName "x1",SymInt 0),
              (VarName "x2",SymInt 0),
              (VarName "y",SymNum 0.0),
              (VarName "y1",SymNum 0.0),
              (VarName "y2",SymNum 0.0),
              (VarName "z",SymVar SYT.Int "z"),
              (Return,SymInt 17)
          ])))
  ]

-----------------------------
-----------------------------
-----------------------------

boo31 :: SymStateEnv
boo31 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo31"),
    (GlobalVars,SGlobalVars ["z"]),
    (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("z",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),
        ("x",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "x",SymInt 0),
    (VarName "z",SymInt 0),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

boo31_2 :: SymStateEnv
boo31_2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo31_2"),
    (GlobalVars,SGlobalVars ["z","y","y1","y2","t1"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("z",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),
        ("x",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "t1",SymInt 7),
    (VarName "x",SymInt 0),
    (VarName "y",SymNum 0.0),
    (VarName "y1",SymNum 0.0),
    (VarName "y2",SymNum 0.0),
    (VarName "z",SymInt 0),
    (Return,SymInt 7)
  ]

-----------------------------
-----------------------------
-----------------------------

boo31_3 :: SymStateEnv
boo31_3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo31_3"),
    (GlobalVars,SGlobalVars ["z","y","y1","y2","t2"]),
    (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("z",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("x",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "t2",SymInt 17),
    (VarName "x",SymInt 0),
    (VarName "y",SymNum 0.0),
    (VarName "y1",SymNum 0.0),
    (VarName "y2",SymNum 0.0),
    (VarName "z",SymInt 0),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

boo32 :: SymStateEnv
boo32 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo32"),
    (GlobalVars,SGlobalVars ["y1","y2","y3"]),
    (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SBin (SBin (SymVar SYT.Int "y1") SYT.Add (SymVar SYT.Int "y2")) SYT.Add (SymVar SYT.Int "y3"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SBin (SBin (SymVar SYT.Int "y1") SYT.Add (SymVar SYT.Int "y2")) SYT.Add (SymVar SYT.Int "y3")),
    (VarName "y1",SymVar SYT.Int "y1"),
    (VarName "y2",SymVar SYT.Int "y2"),
    (VarName "y3",SymVar SYT.Int "y3"),
    (Return,SBin (SBin (SymVar SYT.Int "y1") SYT.Add (SymVar SYT.Int "y2")) SYT.Add (SymVar SYT.Int "y3"))
  ]

-----------------------------
-----------------------------
-----------------------------

boo32Call :: SymStateEnv
boo32Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "boo32Call"),
    (GlobalVars,SGlobalVars ["y1","y2","y3"]),
    (VarAssignments,SVarAssignments [
        ("y1",(SymNum 1.0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("y2",(SymNum 2.0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("y3",(SymNum 3.0,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "y1",SymNum 1.0),
    (VarName "y2",SymNum 2.0),
    (VarName "y3",SymNum 3.0),
    (Return,SymInt 6)
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt :: SymStateEnv
elemAt = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "elemAt"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr","pos"]),
    (VarAssignments,SVarAssignments []),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "pos",SymVar SYT.Int "pos"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 3}),
     SIte (SBin (SObjAcc ["arr","length"]) SYT.Le (SymVar SYT.Int "pos"))
          (Map.fromList [
               (MethodHandle,SMethodHandle SYT.Int "elemAt"),
               (FormalParms,SFormalParms ["arr","pos"]),
               (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
               (VarName "pos",SymVar SYT.Int "pos"),
               (Return,SException SYT.Int "Exception" "not found")
             ])
          Nothing),
    (Return,SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymVar SYT.Int "pos"))
  ]

-----------------------------
-----------------------------
-----------------------------

elemAtCall :: SymStateEnv
elemAtCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "elemAtCall"),
    (Return,SymInt 4)
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt2 :: SymStateEnv
elemAt2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "elemAt2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["pos"]),
    (VarBindings,SVarBindings (Map.fromList [
      ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (VarName "pos",SymVar SYT.Int "pos"),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),
     SIte (SBin (SymInt 5) SYT.Le (SymVar SYT.Int "pos"))
          (Map.fromList [
               (MethodHandle,SMethodHandle SYT.Int "elemAt2"),
               (FormalParms,SFormalParms ["pos"]),
               (VarBindings,SVarBindings (Map.fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
               (VarAssignments,SVarAssignments [
                   ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
               (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
               (VarName "pos",SymVar SYT.Int "pos"),
               (Return,SException SYT.Int "Exception" "not found")
             ])
          Nothing),
    (Return,SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymVar SYT.Int "pos"))
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt2Call :: SymStateEnv
elemAt2Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "elemAt2Call"),
    (Return,SymInt 4)
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt2Call2 :: SymStateEnv
elemAt2Call2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "elemAt2Call2"),
    (Return,SException SYT.Int "Exception" "not found")
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt4 :: SymStateEnv
elemAt4 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "elemAt4"),
    (VarBindings,SVarBindings (Map.fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (Return,SymInt 7)
  ]

-----------------------------
-----------------------------
-----------------------------

strFun :: SymStateEnv
strFun = Map.fromList [
    (MethodHandle,SMethodHandle SYT.String "strFun"),
    (VarBindings,SVarBindings (Map.fromList [("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("firstName",(SymString "Tarek",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})),
        ("lastName",(SymString "Soliman",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "firstName",SymString "Tarek"),
    (VarName "lastName",SymString "Soliman"),
    (Return,SymString "Tarek Soliman")
  ]

-----------------------------
-----------------------------
-----------------------------

voidFun1 :: SymStateEnv
voidFun1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "voidFun1"),
    (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

voidFun2 :: SymStateEnv
voidFun2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "voidFun2")
  ]

-----------------------------
-----------------------------
-----------------------------

voidFun3 :: SymStateEnv
voidFun3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "voidFun3"),
    (GlobalVars,SGlobalVars ["y2","z"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}}),
        ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("y",(SymString "is one",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("y2",(SymString "is not one",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("z",(SBin (SBin (SymFun ToString (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"))) SYT.Add (SymString " ")) SYT.Add (SymString "is one"),Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 9}})),
        ("z",(SBin (SBin (SymFun ToString (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"))) SYT.Add (SymString " ")) SYT.Add (SymString "is not one"),Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 6, branchEnd = 9}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "x",SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n")),
    (VarName "y",SymString "is one"),
    (VarName "y2",SymString "is not one"),
    (VarName "z",SymUnknown (SymVar SYT.String "z") [
        ([(If,SR {branchStart = 6, branchEnd = 9})],7),
        ([(If,SR {branchStart = 6, branchEnd = 9})],8)]),
    (ScopeRange (SR {branchStart = 6, branchEnd = 9}),
     SIte (SBin (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n")) SYT.Eq (SymInt 1))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Void "voidFun3"),
              (GlobalVars,SGlobalVars ["y2","z"]),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 10}})),
                  ("y",(SymString "is one",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 10}})),
                  ("y2",(SymString "is not one",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 10}})),
                  ("z",(SBin (SBin (SymFun ToString (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"))) SYT.Add (SymString " ")) SYT.Add (SymString "is one"),Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 9}}))]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "x",SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n")),
              (VarName "y",SymString "is one"),
              (VarName "y2",SymString "is not one"),
              (VarName "z",SBin (SBin (SymFun ToString (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"))) SYT.Add (SymString " ")) SYT.Add (SymString "is one"))])
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Void "voidFun3"),
              (GlobalVars,SGlobalVars ["y2","z"]),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
              (VarAssignments,SVarAssignments [
                  ("x",(SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 10}})),
                  ("y",(SymString "is one",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 10}})),
                  ("y2",(SymString "is not one",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 10}})),
                  ("z",(SBin (SBin (SymFun ToString (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"))) SYT.Add (SymString " ")) SYT.Add (SymString "is not one"),Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 6, branchEnd = 9}}))]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "x",SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n")),
              (VarName "y",SymString "is one"),
              (VarName "y2",SymString "is not one"),
              (VarName "z",SBin (SBin (SymFun ToString (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"))) SYT.Add (SymString " ")) SYT.Add (SymString "is not one"))]))),
    (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

voidFun3Call :: SymStateEnv
voidFun3Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "voidFun3Call"),
    (GlobalVars,SGlobalVars ["y2","z"]),
    (VarName "y2",SymString "is not one"),
    (VarName "z",SymString "11 is not one"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "11 is not one\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs :: SymStateEnv
manyArrs = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "manyArrs"),
    (VarBindings,SVarBindings (Map.fromList [
        ("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("numbers",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("numbers",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 99,SymNull SYT.Int],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("numbers",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 99,SymInt 5],Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "numbers",SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 99,SymInt 5]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[99, 5]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs2 :: SymStateEnv
manyArrs2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "manyArrs2"),
    (VarBindings,SVarBindings (Map.fromList [("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})])),
    (VarAssignments,SVarAssignments [
        ("numbers1",(SymArray (Just SYT.Int) (Just $ SymInt 7) [SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers2",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 40,SymInt 55,SymInt 63,SymInt 17,SymInt 22],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers3",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("brand",(SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("strs",(SymArray (Just SYT.String) (Just $ SymInt 3) [SymNull SYT.String,SymNull SYT.String,SymNull SYT.String],Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("strs",(SymArray (Just SYT.String) (Just $ SymInt 3) [SymNull SYT.String,SymString "meow",SymNull SYT.String],Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers1",(SymArray (Just SYT.Int) (Just $ SymInt 7) [SymInt 86,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers1",(SymArray (Just SYT.Int) (Just $ SymInt 7) [SymInt 86,SymNull SYT.Int,SymInt 80,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers1",(SymArray (Just SYT.Int) (Just $ SymInt 7) [SymInt 86,SymInt 57,SymInt 80,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers1",(SymArray (Just SYT.Int) (Just $ SymInt 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 11, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers1",(SymArray (Just SYT.Int) (Just $ SymInt 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers1",(SymArray (Just SYT.Int) (Just $ SymInt 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymNull SYT.Int],Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers1",(SymArray (Just SYT.Int) (Just $ SymInt 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94],Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers2",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 51,SymInt 55,SymInt 63,SymInt 17,SymInt 22],Node_Coor {varDeclAt = 15, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers2",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 51,SymInt 84,SymInt 63,SymInt 17,SymInt 22],Node_Coor {varDeclAt = 16, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers2",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 17,SymInt 22],Node_Coor {varDeclAt = 17, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers2",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 22],Node_Coor {varDeclAt = 18, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers2",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81],Node_Coor {varDeclAt = 19, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers3",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymInt 43],Node_Coor {varDeclAt = 20, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers3",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymNull SYT.Int,SymNull SYT.Int,SymNull SYT.Int,SymInt 10,SymInt 43],Node_Coor {varDeclAt = 21, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers3",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymNull SYT.Int,SymNull SYT.Int,SymInt 34,SymInt 10,SymInt 43],Node_Coor {varDeclAt = 22, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers3",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymNull SYT.Int,SymInt 75,SymInt 34,SymInt 10,SymInt 43],Node_Coor {varDeclAt = 23, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers3",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymNull SYT.Int,SymInt 75,SymInt 34,SymInt 10,SymInt 6],Node_Coor {varDeclAt = 24, varFrame = SR {branchStart = 0, branchEnd = 29}})),
        ("numbers3",(SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6],Node_Coor {varDeclAt = 25, varFrame = SR {branchStart = 0, branchEnd = 29}}))]),
    (VarName "brand",SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),
    (VarName "numbers1",SymArray (Just SYT.Int) (Just $ SymInt 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]),
    (VarName "numbers2",SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]),
    (VarName "numbers3",SymArray (Just SYT.Int) (Just $ SymInt 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]),
    (VarName "strs",SymArray (Just SYT.String) (Just $ SymInt 3) [SymNull SYT.String,SymString "meow",SymNull SYT.String]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[86, 57, 80, 34, 50, 48, 94]\n",SymString "[51, 84, 92, 87, 81]\n",SymString "[5, 75, 34, 10, 6]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs3 :: SymStateEnv
manyArrs3 = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "manyArrs3"),
    (VarBindings,SVarBindings (Map.fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("numbers",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("numbers",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 99,SymNull SYT.Int],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("numbers",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 99,SymInt 5],Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "numbers",SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 99,SymInt 5]),
    (Return,SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 99,SymInt 5])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs4 :: SymStateEnv
manyArrs4 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "manyArrs4"),
    (VarBindings,SVarBindings (Map.fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("numbers",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymNull SYT.Int,SymNull SYT.Int],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("numbers",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 99,SymNull SYT.Int],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "numbers",SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 99,SymNull SYT.Int]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[99, 0]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs5 :: SymStateEnv
manyArrs5 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "manyArrs5"),
    (VarBindings,SVarBindings (Map.fromList [
        ("brand",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("brand",(SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("brand",(SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "1. Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("brand",(SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("brand",(SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("brand",(SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",SymString "4. Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("brand",(SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",SymString "4. Volkswagen",SymString "5. Skoda"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "brand",SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",SymString "4. Volkswagen",SymString "5. Skoda"]),
    (LoopConditions (SR {branchStart = 2, branchEnd = 6}),
     SLoopConditions [
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 0)],
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 1)],
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 2)],
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 3)],
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 4)]]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[1. Toyota, 2. Mercedes, 3. BMW, 4. Volkswagen, 5. Skoda]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs6 :: SymStateEnv
manyArrs6 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "manyArrs6"),
    (VarBindings,SVarBindings (Map.fromList [
        ("brand",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("brand",(SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}))]),
    (VarName "brand",SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),
    (LoopConditions (SR {branchStart = 2, branchEnd = 6}),
     SLoopConditions [
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 0)],
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 1)],
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 2)],
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 3)],
         Map.fromList [("brand.length",SymInt 5),("i",SymInt 4)]]),
    (Return,SymReturnVoid),
    (Actions,
     SActions [
         SymString "1. Toyota\n",
         SymString "2. Mercedes\n",
         SymString "3. BMW\n",
         SymString "4. Volkswagen\n",
         SymString "5. Skoda\n",
         SymString "[Toyota, Mercedes, BMW, Volkswagen, Skoda]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs7 :: SymStateEnv
manyArrs7 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "manyArrs7"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["brand"]),
    (VarAssignments,SVarAssignments [
        ("brand",(SymVar (SYT.Array SYT.String) "brand",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}}))]),
    (VarName "brand",SymVar (SYT.Array SYT.String) "brand"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 5}),
     SLoop (Just (Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["brand"], varName = "length"}})) 
           [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "brand"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}]}, binOp = Plus, expr2 = StringLiteral ". "}, binOp = Plus, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "brand"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 1},Node {id = 4, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 1}]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymFun Println (SymVar (SYT.Array SYT.String) "brand")])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs7Call1 :: SymStateEnv
manyArrs7Call1 = Map.fromList [
 (MethodHandle,SMethodHandle SYT.Void "manyArrs7Call1"),
 (Return,SymReturnVoid),
 (Actions,SActions [SymString "[1. Toyota, 2. Mercedes, 3. BMW, 4. Volkswagen, 5. Skoda]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs7Call2 :: SymStateEnv
manyArrs7Call2 = Map.fromList [
  (MethodHandle,SMethodHandle SYT.Void "manyArrs7Call2"),
  (VarBindings,SVarBindings (Map.fromList [("brand",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
  (VarAssignments,SVarAssignments [("brand",(SymArray (Just SYT.String) (Just $ SymInt 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
  (VarName "brand",SymArray (Just SYT.String) (Just $ SymInt 5) [
     SymString "1. Toyota",SymString "2. Mercedes",SymString "3. BMW",
     SymString "4. Volkswagen",SymString "5. Skoda"]),
  (Return,SymReturnVoid),
  (Actions,SActions [SymString "[1. Toyota, 2. Mercedes, 3. BMW, 4. Volkswagen, 5. Skoda]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun :: SymStateEnv
ifFun = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("m",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("x",(SymInt 1,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})),
        ("m",(SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}}))]),
    (VarName "m",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),
     SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "ifFun"),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [
                  ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("m",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})),
                  ("m",(SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}}))]),
              (VarName "m",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n")),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "res",SymVar SYT.Int "n"),
              (VarName "x",SymInt 1)]) Nothing),
    (Return,SBin (SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFunCall :: SymStateEnv
ifFunCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFunCall"),
    (Return,SymInt 8)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun2 :: SymStateEnv
ifFun2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun2"),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymVar SYT.Int "y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("m",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("x",(SymInt 1,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("res",(SBin (SymVar SYT.Int "y") SYT.Add (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})),
        ("m",(SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}}))]),
    (VarName "m",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymVar SYT.Int "y") [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (VarName "y",SymVar SYT.Int "y"),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),
     SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "ifFun2"),
              (GlobalVars,SGlobalVars ["y"]),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [
                  ("res",(SymVar SYT.Int "y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("m",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("res",(SBin (SymVar SYT.Int "y") SYT.Add (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})),
                  ("m",(SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}}))]),
              (VarName "m",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n")),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "res",SBin (SymVar SYT.Int "y") SYT.Add (SymVar SYT.Int "n")),
              (VarName "x",SymInt 1),
              (VarName "y",SymVar SYT.Int "y")]) Nothing),
    (Return,SBin (SymUnknown (SymVar SYT.Int "y") [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun2Call :: SymStateEnv
ifFun2Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun2Call"),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymVar SYT.Int "y"),
    (Return,SBin (SymVar SYT.Int "y") SYT.Add (SymInt 11))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun2Call2 :: SymStateEnv
ifFun2Call2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun2Call2"),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymVar SYT.Int "y"),
    (Return,SBin (SymVar SYT.Int "y") SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun3 :: SymStateEnv
ifFun3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun3"),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("m",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("x",(SymInt 1,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})),
        ("m",(SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}}))]),
    (VarName "m",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (VarName "y",SymVar SYT.UnknownNumSymType "y"),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),
     SIte (SBin (SymVar SYT.UnknownNumSymType "y") SYT.Ge (SymNum 0.0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "ifFun3"),
              (GlobalVars,SGlobalVars ["y"]),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
              (VarAssignments,SVarAssignments [
                  ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("m",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("x",(SymInt 1,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})),
                  ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})),
                  ("m",(SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}}))]),
              (VarName "m",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n")),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "res",SymVar SYT.Int "n"),
              (VarName "x",SymInt 1),
              (VarName "y",SymVar SYT.UnknownNumSymType "y")]) Nothing),
    (Return,SBin (SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun4 :: SymStateEnv
ifFun4 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun4"),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("y",(SBin (SymVar SYT.Int "y") SYT.Add (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "y",SymUnknown (SymVar SYT.Int "y") [
        ([(If,SR {branchStart = 1, branchEnd = 3})],2)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 3}),
     SIte (SBin (SymVar SYT.Int "y") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "ifFun4"),
              (GlobalVars,SGlobalVars ["y"]),
              (FormalParms,SFormalParms ["n"]),
              (VarAssignments,SVarAssignments [
                  ("y",(SBin (SymVar SYT.Int "y") SYT.Add (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}}))]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "y",SBin (SymVar SYT.Int "y") SYT.Add (SymVar SYT.Int "n"))])
          Nothing),
    (Return,SymUnknown (SymVar SYT.Int "y") [
        ([(If,SR {branchStart = 1, branchEnd = 3})],2)])
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun4Call :: SymStateEnv
ifFun4Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "ifFun4Call"),
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

-----------------------------
-----------------------------
-----------------------------

ifFun5 :: SymStateEnv
ifFun5 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun5"),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("y",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("y",(SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "y",SymUnknown (SymVar SYT.Int "n") [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),
     SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "ifFun5"),
              (GlobalVars,SGlobalVars ["y"]),
              (FormalParms,SFormalParms ["n"]),
              (VarAssignments,SVarAssignments [
                  ("y",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
                  ("y",(SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}}))]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "y",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"))]) Nothing),
    (Return,SymUnknown (SymVar SYT.Int "n") [([(If,SR {branchStart = 2, branchEnd = 4})],3)])]

-----------------------------
-----------------------------
-----------------------------

ifFun5Call1 :: SymStateEnv
ifFun5Call1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun5Call1"),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymInt 20),
    (Return,SymInt 20)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun5Call2 :: SymStateEnv
ifFun5Call2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun5Call2"),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymInt (-10)),
    (Return,SymInt (-10))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun6 :: SymStateEnv
ifFun6 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.String "ifFun6"),
    (GlobalVars,SGlobalVars ["y","m","s","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("m",(SBin (SymVar SYT.Int "m") SYT.Add (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})),
        ("y",(SBin (SymNum (-1.0)) SYT.Mul (SymVar SYT.UnknownNumSymType "y"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})),
        ("s",(SymString "something",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}}))]),
    (VarName "c",SymVar SYT.String "c"),
    (VarName "m",SymUnknown (SymVar SYT.Int "m") [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "s",SymString "something"),
    (VarName "y",SymUnknown (SymVar SYT.UnknownNumSymType "y") [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 4}),
     SIte (SBin (SymVar SYT.UnknownNumSymType "y") SYT.Ge (SymNum 0.0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.String "ifFun6"),
              (GlobalVars,SGlobalVars ["y","m"]),
              (FormalParms,SFormalParms ["n"]),
              (VarAssignments,SVarAssignments [
                  ("m",(SBin (SymVar SYT.Int "m") SYT.Add (SymVar SYT.Int "n"),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})),
                  ("y",(SBin (SymNum (-1.0)) SYT.Mul (SymVar SYT.UnknownNumSymType "y"),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}}))]),
              (VarName "m",SBin (SymVar SYT.Int "m") SYT.Add (SymVar SYT.Int "n")),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "y",SBin (SymNum (-1.0)) SYT.Mul (SymVar SYT.UnknownNumSymType "y"))]) Nothing),
    (Return,SymVar SYT.String "c")
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun6Call :: SymStateEnv
ifFun6Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.String "ifFun6Call"),
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
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun6Call2 :: SymStateEnv
ifFun6Call2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.String "ifFun6Call2"),
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

-----------------------------
-----------------------------
-----------------------------

ifFun7 :: SymStateEnv
ifFun7 = Map.fromList [
  (MethodHandle,SMethodHandle SYT.Void "ifFun7"),
  (GlobalVars,SGlobalVars ["v","w","s"]),
  (FormalParms,SFormalParms ["n"]),
  (VarAssignments,SVarAssignments [
      ("v",(SymString "hi",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})),
      ("w",(SymString "bye",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})),
      ("s",(SymString "something",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}}))]),
  (VarName "n",SymVar SYT.Int "n"),
  (VarName "s",SymString "something"),
  (VarName "v",SymUnknown (SymVar SYT.String "v") [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
  (VarName "w",SymUnknown (SymVar SYT.String "w") [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
  (ScopeRange (SR {branchStart = 1, branchEnd = 4}),
   SIte (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0))
        (Map.fromList [
            (MethodHandle,SMethodHandle SYT.Void "ifFun7"),
            (GlobalVars,SGlobalVars ["v"]),
            (FormalParms,SFormalParms ["n"]),
            (VarAssignments,SVarAssignments [("v",(SymString "hi",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}))]),
            (VarName "n",SymVar SYT.Int "n"),
            (VarName "v",SymString "hi")])
        (Just (Map.fromList [
            (MethodHandle,SMethodHandle SYT.Void "ifFun7"),
            (GlobalVars,SGlobalVars ["w"]),
            (FormalParms,SFormalParms ["n"]),
            (VarAssignments,SVarAssignments [("w",(SymString "bye",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}}))]),
            (VarName "n",SymVar SYT.Int "n"),
            (VarName "w",SymString "bye")]))),
            (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun7Call :: SymStateEnv
ifFun7Call = Map.fromList [
  (MethodHandle,SMethodHandle SYT.Void "ifFun7Call"),
  (GlobalVars,SGlobalVars ["v","s"]),
  (VarName "s",SymString "something"),
  (VarName "v",SymString "hi"),
  (Return,SymReturnVoid)]

-----------------------------
-----------------------------
-----------------------------

ifFun7Call2 :: SymStateEnv
ifFun7Call2 = Map.fromList [
  (MethodHandle,SMethodHandle SYT.Void "ifFun7Call2"),
  (GlobalVars,SGlobalVars ["v","s","w"]),
  (VarName "s",SymString "something"),
  (VarName "v",SymString "hi"),
  (VarName "w",SymString "bye"),
  (Return,SymReturnVoid)]

-----------------------------
-----------------------------
-----------------------------

ifFun7Call3 :: SymStateEnv
ifFun7Call3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "ifFun7Call3"),
    (GlobalVars,SGlobalVars ["t","v","w","s"]),
    (VarName "s",SymString "something"),
    (VarName "t",SymVar SYT.Int "t"),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [
        ([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "w",SymUnknown (SymVar SYT.String "w") [
        ([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
    (Return,SymReturnVoid)]

-----------------------------
-----------------------------
-----------------------------

ifFun8 :: SymStateEnv
ifFun8 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "ifFun8"),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("v",(SymString "hi",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})),
        ("w",(SymString "bye",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [([(If,SR {branchStart = 1, branchEnd = 6})],2)]),
    (VarName "w",SymUnknown (SymVar SYT.String "w") [([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),
     SIte (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Void "ifFun8"),
              (GlobalVars,SGlobalVars ["v"]),
              (FormalParms,SFormalParms ["n"]),
              (VarAssignments,SVarAssignments [
                  ("v",(SymString "hi",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "v",SymString "hi"),
              (Actions,SActions [SymString "hi\n"])])
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Void "ifFun8"),
              (GlobalVars,SGlobalVars ["w"]),
              (FormalParms,SFormalParms ["n"]),
              (VarAssignments,SVarAssignments [
                  ("w",(SymString "bye",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
                  (VarName "n",SymVar SYT.Int "n"),
                  (VarName "w",SymString "bye"),
                  (Actions,SActions [SymString "bye\n"])]))),
    (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun8Call :: SymStateEnv
ifFun8Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "ifFun8Call"),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "hi\n",SymString "bye\n",SymString "hi\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun9 :: SymStateEnv
ifFun9 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "ifFun9"),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("v",(SymString "hi",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})),
        ("v",(SymString "hi zu",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})),
        ("w",(SymString "bye",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [
        ([(If,SR {branchStart = 1, branchEnd = 6})],2),
        ([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
    (VarName "w",SymUnknown (SymVar SYT.String "w") [
        ([(If,SR {branchStart = 1, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),
     SIte (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Void "ifFun9"),
              (GlobalVars,SGlobalVars ["v"]),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (Map.fromList [("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}})])),
              (VarAssignments,SVarAssignments [
                  ("v",(SymString "hi",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})),
                  ("z",(SymInt 3,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}})),
                  ("v",(SymString "hi zu",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "v",SymString "hi zu"),
              (VarName "z",SymInt 3)])
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Void "ifFun9"),
              (GlobalVars,SGlobalVars ["w"]),
              (FormalParms,SFormalParms ["n"]),
              (VarAssignments,SVarAssignments [
                  ("w",(SymString "bye",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "w",SymString "bye")]))),
    (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun10 :: SymStateEnv
ifFun10 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun10"),
    (GlobalVars,SGlobalVars ["v","t","i"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})),
        ("v",(SymString "hi",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("res",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("v",(SymString "zuzu",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("res",(SymInt 0,Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 9}})),
        ("t",(SymVar SYT.UnknownGlobalVarSymType "i",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 9}}))]),
    (VarName "i",SymVar SYT.UnknownGlobalVarSymType "i"),
    (VarName "res",SymInt 0),
    (VarName "t",SymVar SYT.UnknownGlobalVarSymType "i"),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [
        ([(If,SR {branchStart = 2, branchEnd = 6})],3),
        ([(If,SR {branchStart = 2, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SIte (SBin (SymVar SYT.String "v") SYT.Eq (SymString "bye"))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "ifFun10"),
              (GlobalVars,SGlobalVars ["v"]),
              (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),
              (VarAssignments,SVarAssignments [
                  ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})),
                  ("v",(SymString "hi",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})),
                  ("res",(SymInt 1,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
                  ("v",(SymString "zuzu",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
              (VarName "res",SymInt 1),
              (VarName "v",SymString "zuzu")]) Nothing),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun11 :: SymStateEnv
ifFun11 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun11"),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "res",SymInt 0),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun12 :: SymStateEnv
ifFun12 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "ifFun12"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("res",(SymInt 1,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymInt 0) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),
     SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "ifFun12"),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
              (VarAssignments,SVarAssignments [
                  ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
                  ("res",(SymInt 1,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}}))]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "res",SymInt 1)]) Nothing),
    (Return,SymUnknown (SymInt 0) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])]

-----------------------------
-----------------------------
-----------------------------

succFun :: SymStateEnv
succFun = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "succFun"),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [
        ("i",(SBin (SymVar SYT.Int "i") SYT.Add (SymInt 1),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "i",SBin (SymVar SYT.Int "i") SYT.Add (SymInt 1)),
    (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

succFunCall :: SymStateEnv
succFunCall = Map.fromList [
   (MethodHandle,SMethodHandle SYT.Void "succFunCall"),
   (VarBindings,SVarBindings (Map.fromList [
       ("n",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
   (VarAssignments,SVarAssignments [
       ("n",(SymInt 2,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
   (VarName "n",SymInt 2),
   (Return,SymReturnVoid),
   (Actions,SActions [SymString "2\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

callSuccFun :: SymStateEnv
callSuccFun = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "callSuccFun"),
    (FormalParms,SFormalParms ["n"]),
    (VarName "n",SymVar SYT.Int "n"),
    (Return,SymVar SYT.Int "n")
  ]

-----------------------------
-----------------------------
-----------------------------

callCallSuccFun :: SymStateEnv
callCallSuccFun = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "callCallSuccFun"),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

wrongSum1 :: SymStateEnv
wrongSum1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "wrongSum1"),
    (GlobalVars,SGlobalVars ["w","t","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}})),
        ("j",(SymVar SYT.Int "w",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 12}})),
        ("res",(SymInt 0,Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 3, branchEnd = 12}})),
        ("t",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 3, branchEnd = 12}})),
        ("j",(SymVar SYT.Int "c",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 3, branchEnd = 12}}))]),
    (VarName "j",SymUnknown (SymVar SYT.Int "w") [([(For,SR {branchStart = 3, branchEnd = 12})],10)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (SymVar SYT.Int "t") [([(For,SR {branchStart = 3, branchEnd = 12})],9)]),
    (VarName "w",SymVar SYT.Int "w"),
    (ScopeRange (SR {branchStart = 3, branchEnd = 12}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 3},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 3},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 3},Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 10, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "c"}}}), parent = 3},Node {id = 11, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

wrongSum2 :: SymStateEnv
wrongSum2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "wrongSum2"),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}})),
        ("v",(SymString "hi",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}})),
        ("res",(SBin (SymVar SYT.Int "n") SYT.Add (SymInt 1),Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}})),
        ("v",(SymString "zuzu",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}})),
        ("res",(SymInt 0,Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}})),
        ("t",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (SymVar SYT.Int "t") [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],8),
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral True)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

wrongSum3 :: SymStateEnv
wrongSum3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "wrongSum3"),
    (GlobalVars,SGlobalVars ["t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}})),
        ("res",(SymInt 0,Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}})),
        ("t",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (SymVar SYT.Int "t") [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral False)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

wrongSum4 :: SymStateEnv
wrongSum4 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "wrongSum4"),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}})),
        ("v",(SymString "hi",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}})),
        ("res",(SBin (SymVar SYT.Int "n") SYT.Add (SymInt 1),Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}})),
        ("v",(SymString "zuzu",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}})),
        ("res",(SymInt 0,Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}})),
        ("t",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (SymVar SYT.Int "t") [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [
      ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],8),
      ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "v"}, binOp = Eq, expr2 = StringLiteral "bye"})), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

wrongSum5 :: SymStateEnv
wrongSum5 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "wrongSum5"),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 14}})),
        ("v",(SymString "hi",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}})),
        ("res",(SBin (SymVar SYT.Int "n") SYT.Add (SymInt 1),Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}})),
        ("v",(SymString "zuzu",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}})),
        ("t",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 14}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymInt 0) [
        ([(For,SR {branchStart = 2, branchEnd = 14})],4),
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],9)]),
    (VarName "t",SymUnknown (SymVar SYT.Int "t") [([(For,SR {branchStart = 2, branchEnd = 14})],12)]),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],8),
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 14}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "v"}, binOp = Eq, expr2 = StringLiteral "bye"})), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 13, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 14})],4),([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],9)])
  ]

-----------------------------
-----------------------------
-----------------------------

for1 :: SymStateEnv
for1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "for1"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)]

-----------------------------
-----------------------------
-----------------------------

for2 :: SymStateEnv
for2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "for2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})),
        ("res",(SymInt 1,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}})),
        ("res",(SBin (SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) SYT.Mul (SymInt 3),Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}}))]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymInt 0) [
        ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),
        ([(If,SR {branchStart = 9, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
           (ScopeRange (SR {branchStart = 9, branchEnd = 11}),
            SIte (SBin (SBin (SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) SYT.Mod (SymInt 3)) SYT.Eq (SymInt 0)) 
            (Map.fromList [
                (MethodHandle,SMethodHandle SYT.Int "for2"),
                (GlobalVars,SGlobalVars []),
                (FormalParms,SFormalParms ["n"]),
                (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
                (VarAssignments,SVarAssignments [
                    ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})),
                    ("res",(SymInt 1,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}})),
                    ("res",(SBin (SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) SYT.Mul (SymInt 3),Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}}))]),
                (VarName "n",SymVar SYT.Int "n"),
                (VarName "res",SBin (SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) SYT.Mul (SymInt 3)),
                (ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}])]) Nothing),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),([(If,SR {branchStart = 9, branchEnd = 11})],10)])]

-----------------------------
-----------------------------
-----------------------------

for3 :: SymStateEnv
for3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "for3"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [
        ("a",(SymInt 10,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})),
        ("a",(SymInt 20,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}})),
        ("a",(SBin (SymUnknown (SymVar SYT.Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4)]) SYT.Add (SymInt 5),Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 8, branchEnd = 10}})),
        ("a",(SBin (SymUnknown (SymVar SYT.Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9)]) SYT.Mul (SymInt 3),Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 13, branchEnd = 15}}))]),
    (VarName "a",SymUnknown (SymVar SYT.Int "a") [
     ([(If,SR {branchStart = 2, branchEnd = 5})],3),
     ([(If,SR {branchStart = 2, branchEnd = 5})],4),
     ([(For,SR {branchStart = 6, branchEnd = 12}),
       (If,SR {branchStart = 8, branchEnd = 10})],9),
     ([(If,SR {branchStart = 13, branchEnd = 15})],14)]),
    (VarName "n",SymVar SYT.Int "n"),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SIte (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0)) (Map.fromList [(MethodHandle,SMethodHandle SYT.Int "for3"),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 10,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),(VarName "a",SymInt 10),(VarName "n",SymVar SYT.Int "n")]) (Just (Map.fromList [(MethodHandle,SMethodHandle SYT.Int "for3"),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 20,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),(VarName "a",SymInt 20),(VarName "n",SymVar SYT.Int "n")]))),
    (ScopeRange (SR {branchStart = 6, branchEnd = 12}),SLoop (Just (Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 8, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 6},Node {id = 11, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 6}]),
    (ScopeRange (SR {branchStart = 13, branchEnd = 15}),SIte (SBin (SBin (SymUnknown (SymVar SYT.Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9)]) SYT.Mod (SymInt 3)) SYT.Eq (SymInt 0)) (Map.fromList [(MethodHandle,SMethodHandle SYT.Int "for3"),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 10,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})),("a",(SymInt 20,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}})),("a",(SBin (SymUnknown (SymVar SYT.Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4)]) SYT.Add (SymInt 5),Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 8, branchEnd = 10}})),("a",(SBin (SymUnknown (SymVar SYT.Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9)]) SYT.Mul (SymInt 3),Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 13, branchEnd = 15}}))]),(VarName "a",SBin (SymUnknown (SymVar SYT.Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9)]) SYT.Mul (SymInt 3)),(VarName "n",SymVar SYT.Int "n"),(ScopeRange (SR {branchStart = 2, branchEnd = 5}),SIte (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0)) (Map.fromList [(MethodHandle,SMethodHandle SYT.Int "for3"),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 10,Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),(VarName "a",SymInt 10),(VarName "n",SymVar SYT.Int "n")]) (Just (Map.fromList [(MethodHandle,SMethodHandle SYT.Int "for3"),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("a",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),(VarAssignments,SVarAssignments [("a",(SymInt 20,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),(VarName "a",SymInt 20),(VarName "n",SymVar SYT.Int "n")]))),(ScopeRange (SR {branchStart = 6, branchEnd = 12}),SLoop (Just (Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 8, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 6},Node {id = 11, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 6}])]) Nothing),
    (Return,SymUnknown (SymVar SYT.Int "a") [([(If,SR {branchStart = 2, branchEnd = 5})],3),([(If,SR {branchStart = 2, branchEnd = 5})],4),([(For,SR {branchStart = 6, branchEnd = 12}),(If,SR {branchStart = 8, branchEnd = 10})],9),([(If,SR {branchStart = 13, branchEnd = 15})],14)])
  ]

-----------------------------
-----------------------------
-----------------------------

sum1 :: SymStateEnv
sum1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sum1"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("n",(SBin (SymVar SYT.Int "n") SYT.Sub (SymInt 1),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "n",SymUnknown (SymVar SYT.Int "n") [([(For,SR {branchStart = 2, branchEnd = 6})],5)]),
    (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])]

-----------------------------
-----------------------------
-----------------------------

sum1Call1 :: SymStateEnv
sum1Call1 = Map.fromList [
  (MethodHandle,SMethodHandle SYT.String "sum1Call1"),
  (Return,SLoopFailure (SR {branchStart = 2, branchEnd = 6}) 20)
 ]

-----------------------------
-----------------------------
-----------------------------

sum1Call2 :: SymStateEnv
sum1Call2 = Map.fromList [
  (MethodHandle,SMethodHandle SYT.String "sum1Call2"),
  (GlobalVars,SGlobalVars ["x"]),
  (VarName "x",SymVar SYT.Int "x"),
  (Return,SymFun ToString (
     (SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])))
  ]

-----------------------------
-----------------------------
-----------------------------

sum1Call3 :: SymStateEnv
sum1Call3 = Map.fromList [
  (MethodHandle,SMethodHandle SYT.String "sum1Call3"),
  (GlobalVars,SGlobalVars ["x"]),
  (VarAssignments,SVarAssignments [("x",(SymInt 3,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
  (VarName "x",SymInt 3),
  (Return,SymString "6")
  ]

-----------------------------
-----------------------------
-----------------------------
 
sum2 :: SymStateEnv
sum2 = Map.fromList [
  (MethodHandle,SMethodHandle SYT.Int "sum2"),
  (GlobalVars,SGlobalVars []),
  (VarBindings,SVarBindings (Map.fromList [
      ("n",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),
      ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
  (VarAssignments,SVarAssignments [
      ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
      ("n",(SymInt 21,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
      ("res",(SymInt 21,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 7}})),
      ("n",(SymInt 20,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 3, branchEnd = 7}}))]),
  (VarName "n",SymUnknown (SymInt 21) [([(For,SR {branchStart = 3, branchEnd = 7})],6)]),
  (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 3, branchEnd = 7})],5)]),
  (ScopeRange (SR {branchStart = 3, branchEnd = 7}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 3},Node {id = 6, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
  (LoopFailure,SLoopFailure (SR {branchStart = 3, branchEnd = 7}) 20),
  (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 3, branchEnd = 7})],5)])
  ]

-----------------------------
-----------------------------
-----------------------------

sum4 :: SymStateEnv
sum4 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sum4"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})),("n",(SBin (SymVar SYT.Int "n") SYT.Sub (SymInt 1),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 7}}))]),
    (VarName "n",SymUnknown (SymVar SYT.Int "n") [([(For,SR {branchStart = 2, branchEnd = 7})],5)]),
    (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 7})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 7}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Minus, expr2 = NumberLiteral 1.0}}}), parent = 2},Node {id = 6, nodeData = ForStep Nothing, parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 7})],4)])
  ]

-----------------------------
-----------------------------
-----------------------------

sum4Call :: SymStateEnv
sum4Call = Map.fromList [
   (MethodHandle,SMethodHandle SYT.Int "sum4Call"),
   (Return,SymInt 6)
  ]

-----------------------------
-----------------------------
-----------------------------

sum1_While :: SymStateEnv
sum1_While = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sum1_While"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})),("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})),("n",(SBin (SymVar SYT.Int "n") SYT.Sub (SymInt 1),Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 5}}))]),
    (VarName "n",SymUnknown (SymVar SYT.Int "n") [([(For,SR {branchStart = 2, branchEnd = 5})],4)]),
    (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 5})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Minus, expr2 = NumberLiteral 1.0}}}), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 5})],3)])
  ]

-----------------------------
-----------------------------
-----------------------------

sum1_WhileCall :: SymStateEnv
sum1_WhileCall = Map.fromList [
   (MethodHandle,SMethodHandle SYT.Int "sum1_WhileCall"),
   (Return,SymInt 6)
  ]

-----------------------------
-----------------------------
-----------------------------

sum1_While2 :: SymStateEnv
sum1_While2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sum1_While2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 8}})),
        ("n",(SBin (SymVar SYT.Int "n") SYT.Sub (SymInt 1),Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 8}}))]),
    (VarName "n",SymUnknown (SymVar SYT.Int "n") [([(For,SR {branchStart = 2, branchEnd = 8})],4)]),
    (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),
     SLoop Nothing
           (Just (BoolLiteral True))
           [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Minus, expr2 = NumberLiteral 1.0}}}), parent = 2},Node {id = 5, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = LessEq, expr2 = NumberLiteral 0.0})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8})],3)])
  ]

-----------------------------
-----------------------------
-----------------------------

sum1_While2Call1 :: SymStateEnv
sum1_While2Call1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sum1_While2Call1"),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

sum1_While2Call2 :: SymStateEnv
sum1_While2Call2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sum1_While2Call2"),
    (Return,SymInt 6)
  ]

-----------------------------
-----------------------------
-----------------------------

sumOddNums :: SymStateEnv
sumOddNums = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sumOddNums"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["nums"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("sum",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("sum",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("sum",(SArrayIndexAccess (SYT.Array SYT.Int) "nums" (SymInt 0),Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 2, branchEnd = 9}}))]),
    (VarName "nums",SymVar (SYT.Array SYT.Int) "nums"),
    (VarName "sum",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 9}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["nums"], varName = "length"}}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "nums"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = Plus, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "nums"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 2},Node {id = 8, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)])
  ]

-----------------------------
-----------------------------
-----------------------------

sumOddNumsCall1 :: SymStateEnv
sumOddNumsCall1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sumOddNumsCall1"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 4,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 4),
    (Return,SymInt 4)
  ]

-----------------------------
-----------------------------
-----------------------------

sumOddNumsCall2 :: SymStateEnv
sumOddNumsCall2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sumOddNumsCall2"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 4,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 4),
    (Return,SymInt 4)
  ]

-----------------------------
-----------------------------
-----------------------------

sumUntilNegative :: SymStateEnv
sumUntilNegative = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sumUntilNegative"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["nums"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("sum",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("sum",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("sum",(SArrayIndexAccess (SYT.Array SYT.Int) "nums" (SymInt 0),Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 2, branchEnd = 9}}))]),
    (VarName "nums",SymVar (SYT.Array SYT.Int) "nums"),
    (VarName "sum",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 9}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["nums"], varName = "length"}}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "nums"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = Less, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "sum"}, binOp = Plus, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "nums"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}}), parent = 2},Node {id = 8, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)])
  ]

-----------------------------
-----------------------------
-----------------------------

sumUntilNegativeCall1 :: SymStateEnv
sumUntilNegativeCall1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sumUntilNegativeCall1"),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

sumUntilNegativeCall2 :: SymStateEnv
sumUntilNegativeCall2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sumUntilNegativeCall2"),
    (Return,SymInt 5)
  ]

-----------------------------
-----------------------------
-----------------------------

processArray1 :: SymStateEnv
processArray1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "processArray1"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("sum",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("sum",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("sum",(SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 0),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})),
        ("sum",(SBin (SymInt (-1)) SYT.Mul (SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 0)),Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "sum",SymUnknown (SymInt 0) [
        ([(For,SR {branchStart = 2, branchEnd = 9}),(If,SR {branchStart = 4, branchEnd = 7})],5),
        ([(For,SR {branchStart = 2, branchEnd = 9}),(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 9}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 8, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [
        ([(For,SR {branchStart = 2, branchEnd = 9}),(If,SR {branchStart = 4, branchEnd = 7})],5),
        ([(For,SR {branchStart = 2, branchEnd = 9}),(If,SR {branchStart = 4, branchEnd = 7})],6)])
  ]

-----------------------------
-----------------------------
-----------------------------

processArray1Call :: SymStateEnv
processArray1Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "processArray1Call"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 2,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 2),
    (Return,SymInt 2)
  ]

-----------------------------
-----------------------------
-----------------------------

isEmpty :: SymStateEnv
isEmpty = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Bool "isEmpty"),
    (FormalParms,SFormalParms ["arr"]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (Return,SBin (SObjAcc ["arr","length"]) SYT.Eq (SymInt 0))
  ]

-----------------------------
-----------------------------
-----------------------------

callIsEmpty :: SymStateEnv
callIsEmpty = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Bool "callIsEmpty"),
    (Return,SBool True)
  ]

-----------------------------
-----------------------------
-----------------------------

callIsNotEmpty :: SymStateEnv
callIsNotEmpty = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Bool "callIsNotEmpty"),
    (Return,SBool False)
  ]

-----------------------------
-----------------------------
-----------------------------

fillArray :: SymStateEnv
fillArray = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "fillArray"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["size","elem"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just (SymVar SYT.Int "size")) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})),
        ("arr",(SymArray (Just SYT.Int) (Just (SymVar SYT.Int "size")) [SymVar SYT.Int "elem"],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "arr",SymUnknown (SymArray (Just SYT.Int) (Just (SymVar SYT.Int "size")) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (VarName "elem",SymVar SYT.Int "elem"),
    (VarName "size",SymVar SYT.Int "size"),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "size"}}))
           [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "elem"}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymArray (Just SYT.Int) (Just (SymVar SYT.Int "size")) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])
  ]

-----------------------------
-----------------------------
-----------------------------

fillArrayCall :: SymStateEnv
fillArrayCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "fillArrayCall"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[10, 10, 10, 10, 10]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

sqrt :: SymStateEnv
sqrt = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sqrt"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["y"]),
    (VarAssignments,SVarAssignments []),
    (VarName "y",SymVar SYT.Int "y"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 11}),
     SLoop (Just (Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = LessEq, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}))
           [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Mult, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 1},Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = Eq, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}})), parent = 1},Node {id = 10, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 1}])
  ]

-----------------------------
-----------------------------
-----------------------------

sqrtCall1 :: SymStateEnv
sqrtCall1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sqrtCall1"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 3,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 3),
    (Return,SymInt 3)
  ]

-----------------------------
-----------------------------
-----------------------------

sqrtCall2 :: SymStateEnv
sqrtCall2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sqrtCall2"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SException SYT.Int "Exception" "not found",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SException SYT.Int "Exception" "not found"),
    (Return,SException SYT.Int "Exception" "not found")
  ]

-----------------------------
-----------------------------
-----------------------------

getMax :: SymStateEnv
getMax = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "getMax"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarAssignments,SVarAssignments []),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 12}),
     SIte (SBin (SObjAcc ["arr","length"]) SYT.Eq (SymInt 0))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "getMax"),
              (FormalParms,SFormalParms ["arr"]),
              (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
              (Return,SException SYT.Int "Exception" "empty array")]) 
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Int "getMax"),
              (GlobalVars,SGlobalVars []),
              (FormalParms,SFormalParms ["arr"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("max",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 12}})])),
              (VarAssignments,SVarAssignments [
                  ("max",(SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 0),Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 12}})),
                  ("max",(SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 1),Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 2}}))]),
              (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
              (VarName "max",SymUnknown (SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 0)) [
                  ([(If,SR {branchStart = 1, branchEnd = 12}),
                    (For,SR {branchStart = 4, branchEnd = 10}),
                    (If,SR {branchStart = 6, branchEnd = 8})],7)]),
              (ScopeRange (SR {branchStart = 4, branchEnd = 10}),
               SLoop (Just (Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 1.0}}), parent = 1}))
                     (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}})) 
                     [Node {id = 6, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = Greater, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "max"}})), parent = 4},Node {id = 9, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 4}]),
              (Return,SymUnknown (SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 0)) [
                  ([(If,SR {branchStart = 1, branchEnd = 12}),
                    (For,SR {branchStart = 4, branchEnd = 10}),
                    (If,SR {branchStart = 6, branchEnd = 8})],7)])]))
    )
  ]

-----------------------------
-----------------------------
-----------------------------

getMaxCall :: SymStateEnv
getMaxCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "getMaxCall"),
    (Return,SymInt 9)
  ]

-----------------------------
-----------------------------
-----------------------------

swap :: SymStateEnv
swap = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "swap"),
    (FormalParms,SFormalParms ["arr","i","j"]),
    (VarBindings,SVarBindings (Map.fromList [("temp",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [
        ("temp",(SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymVar SYT.Int "i"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("arr",(SymVar (SYT.Array SYT.Int) "arr",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})),
        ("arr",(SymVar (SYT.Array SYT.Int) "arr",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "i",SymVar SYT.Int "i"),
    (VarName "j",SymVar SYT.Int "j"),
    (VarName "temp",SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymVar SYT.Int "i")),
    (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

swapCall :: SymStateEnv
swapCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "swapCall"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 9) [SymInt 5,SymInt 4,SymInt 6,SymInt 4,SymInt 7,SymInt 8,SymInt 9,SymInt 0,SymInt 1],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 9) [SymInt 4,SymInt 5,SymInt 6,SymInt 4,SymInt 7,SymInt 8,SymInt 9,SymInt 0,SymInt 1]),
    (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

partition :: SymStateEnv
partition = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "partition"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr","low","high"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("i",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 12}}),
        ("pivot",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("pivot",(SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymVar SYT.Int "high"),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})),
        ("i",(SBin (SymVar SYT.Int "low") SYT.Sub (SymInt 1),Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 12}})),
        ("i",(SymVar SYT.Int "low",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 5, branchEnd = 8}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "high",SymVar SYT.Int "high"),
    (VarName "i",SymUnknown (SBin (SymVar SYT.Int "low") SYT.Sub (SymInt 1)) [([(For,SR {branchStart = 3, branchEnd = 10}),(If,SR {branchStart = 5, branchEnd = 8})],6)]),
    (VarName "low",SymVar SYT.Int "low"),
    (VarName "pivot",SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymVar SYT.Int "high")),
    (ScopeRange (SR {branchStart = 3, branchEnd = 10}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "j"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "low"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "high"}})) [Node {id = 5, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "j"})}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pivot"}})), parent = 3},Node {id = 9, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SBin (SymUnknown (SBin (SymVar SYT.Int "low") SYT.Sub (SymInt 1)) [([(For,SR {branchStart = 3, branchEnd = 10}),(If,SR {branchStart = 5, branchEnd = 8})],6)]) SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

partitionCall1 :: SymStateEnv
partitionCall1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "partitionCall1"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 1) [SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 1) [SymInt 7]),
    (VarName "x",SymInt 0),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[7]\n",SymString "0\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

partitionCall2 :: SymStateEnv
partitionCall2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "partitionCall2"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 9,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 7,SymInt 9]),
    (VarName "x",SymInt 0),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[7, 9]\n",SymString "0\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

partitionCall3 :: SymStateEnv
partitionCall3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "partitionCall3"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
 (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 3,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 1,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 2) [SymInt 3,SymInt 7]),
    (VarName "x",SymInt 1),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[3, 7]\n",SymString "1\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

partitionCall4 :: SymStateEnv
partitionCall4 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "partitionCall4"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 3) [SymInt 9,SymInt 3,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 1,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 3) [SymInt 3,SymInt 7,SymInt 9]),
    (VarName "x",SymInt 1),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[3, 7, 9]\n",SymString "1\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

partitionCall5 :: SymStateEnv
partitionCall5 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "partitionCall5"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 3) [SymInt 1,SymInt 2,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 2,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 3) [SymInt 1,SymInt 2,SymInt 7]),
    (VarName "x",SymInt 2),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[1, 2, 7]\n",SymString "2\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

partitionCall6 :: SymStateEnv
partitionCall6 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "partitionCall6"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 3) [SymInt 9,SymInt 8,SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("x",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 3) [SymInt 7,SymInt 8,SymInt 9]),
    (VarName "x",SymInt 0),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[7, 8, 9]\n",SymString "0\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

isAscending1 :: SymStateEnv
isAscending1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Bool "isAscending1"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SBool True,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})),
        ("res",(SBool False,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "res",SymUnknown (SBool True) [
        ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = Minus, expr2 = NumberLiteral 1.0}}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = Greater, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0})}})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SBool True) [
        ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)])
  ]

-----------------------------
-----------------------------
-----------------------------

isAscending1Call :: SymStateEnv
isAscending1Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "isAscending1Call"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("arr2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("arr1",(SymArray (Just SYT.Int) (Just $ SymInt 6) [SymInt 1,SymInt 2,SymInt 4,SymInt 6,SymInt 7,SymInt 99],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("arr2",(SymArray (Just SYT.Int) (Just $ SymInt 6) [SymInt 1,SymInt 2,SymInt 4,SymInt 7,SymInt 6,SymInt 99],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr1",SymArray (Just SYT.Int) (Just $ SymInt 6) [SymInt 1,SymInt 2,SymInt 4,SymInt 6,SymInt 7,SymInt 99]),
    (VarName "arr2",SymArray (Just SYT.Int) (Just $ SymInt 6) [SymInt 1,SymInt 2,SymInt 4,SymInt 7,SymInt 6,SymInt 99]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "true\n",SymString "false\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

isAscending2 :: SymStateEnv
isAscending2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Bool "isAscending2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarAssignments,SVarAssignments []),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 7}),
     SLoop (Just (Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = Minus, expr2 = NumberLiteral 1.0}}))
           [Node {id = 3, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = Greater, expr2 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0})}})), parent = 1},Node {id = 6, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 1}]),
    (Return,SBool True)
  ]

-----------------------------
-----------------------------
-----------------------------

isAscending2Call :: SymStateEnv
isAscending2Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "isAscending2Call"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("arr2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("arr1",(SymArray (Just SYT.Int) (Just (SymInt 6)) [SymInt 1,SymInt 2,SymInt 4,SymInt 6,SymInt 7,SymInt 99],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("arr2",(SymArray (Just SYT.Int) (Just (SymInt 6)) [SymInt 1,SymInt 2,SymInt 4,SymInt 7,SymInt 6,SymInt 99],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr1",SymArray (Just SYT.Int) (Just (SymInt 6)) [SymInt 1,SymInt 2,SymInt 4,SymInt 6,SymInt 7,SymInt 99]),
    (VarName "arr2",SymArray (Just SYT.Int) (Just (SymInt 6)) [SymInt 1,SymInt 2,SymInt 4,SymInt 7,SymInt 6,SymInt 99]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "true\n",SymString "false\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

copyArray :: SymStateEnv
copyArray = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "copyArray"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (Map.fromList [("copy",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [("copy",(SymArray (Just SYT.Int) (Just (SObjAcc ["arr","length"])) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})),("copy",(SymArray (Just SYT.Int) (Just (SObjAcc ["arr","length"])) [SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 0)],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "copy",SymUnknown (SymArray (Just SYT.Int) (Just (SObjAcc ["arr","length"])) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "copy"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymArray (Just SYT.Int) (Just (SObjAcc ["arr","length"])) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])
  ]

-----------------------------
-----------------------------
-----------------------------

copyArrayCall :: SymStateEnv
copyArrayCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "copyArrayCall"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),
        ("c",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just (SymInt 4)) [SymInt 1,SymInt 4,SymInt 6,SymInt 8],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})),
        ("c",(SymArray (Just SYT.Int) (Just (SymInt 4)) [SymInt 1,SymInt 4,SymInt 6,SymInt 8],Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just (SymInt 4)) [SymInt 1,SymInt 4,SymInt 6,SymInt 8]),
    (VarName "c",SymArray (Just SYT.Int) (Just (SymInt 4)) [SymInt 1,SymInt 4,SymInt 6,SymInt 8]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[1, 4, 6, 8]\n",SymString "[1, 4, 6, 8]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

addElemRight :: SymStateEnv
addElemRight = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "addElemRight"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr","elem"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Add (SymInt 1))) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("res",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Add (SymInt 1))) [SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 0)],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("res",(SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Add (SymInt 1))) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)],Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 8}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "elem",SymVar SYT.Int "elem"),
    (VarName "res",SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Add (SymInt 1))) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "res"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Add (SymInt 1))) []) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])
  ]

-----------------------------
-----------------------------
-----------------------------

addElemRightCall :: SymStateEnv
addElemRightCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "addElemRightCall"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just (SymInt 4)) [SymInt 1,SymInt 2,SymInt 3,SymInt 4],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just (SymInt 4)) [SymInt 1,SymInt 2,SymInt 3,SymInt 4]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[1, 2, 3, 4]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

removeAtPos :: SymStateEnv
removeAtPos = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "removeAtPos"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr","pos"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 12}}),
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1))) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})),
        ("j",(SymInt 0,Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 12}})),
        ("res",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1))) [SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 0)],Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 3, branchEnd = 11}})),
        ("j",(SymInt 1,Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 3, branchEnd = 11}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "j",SymUnknown (SymInt 0) [([(For,SR {branchStart = 3, branchEnd = 11})],9)]),
    
    (VarName "pos",SymVar SYT.Int "pos"),
    (VarName "res",SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1))) []) [([(For,SR {branchStart = 3, branchEnd = 11})],8)]),
    (ScopeRange (SR {branchStart = 3, branchEnd = 11}),
     SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 5, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Eq, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}})), parent = 3},Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "res"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "j"})}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 3},Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = Plus, expr2 = NumberLiteral 1.0}}}), parent = 3},Node {id = 10, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1))) []) [([(For,SR {branchStart = 3, branchEnd = 11})],8)])
  ]

-----------------------------
-----------------------------
-----------------------------

removeAtPosCall1 :: SymStateEnv
removeAtPosCall1 = Map.fromList [
  (MethodHandle,SMethodHandle SYT.Void "removeAtPosCall1"),
  (VarBindings,SVarBindings (Map.fromList [
      ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
  (VarAssignments,SVarAssignments [
      ("arr",(SymArray (Just SYT.Int) (Just (SymInt 2)) [SymInt 1,SymInt 3],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
  (VarName "arr",SymArray (Just SYT.Int) (Just (SymInt 2)) [SymInt 1,SymInt 3]),
  (Return,SymReturnVoid),
  (Actions,SActions [SymString "[1, 3]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

removeAtPosCall2 :: SymStateEnv
removeAtPosCall2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "removeAtPosCall2"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just (SymInt 1)) [SymInt 9],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just (SymInt 1)) [SymInt 9]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[9]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

takeWhileAsLongAsEven :: SymStateEnv
takeWhileAsLongAsEven = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "takeWhileAsLongAsEven"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymArray (Just SYT.Int) (Just (SymInt 0)) [],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})),
        ("res",(SymArray (Just SYT.Int) (Just (SymInt 1)) [SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 0)],Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 4, branchEnd = 16}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "res",SymUnknown (SymArray (Just SYT.Int) (Just (SymInt 0)) []) [([(For,SR {branchStart = 2, branchEnd = 18}),(If,SR {branchStart = 4, branchEnd = 16})],14)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 18}),
     SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 17, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymArray (Just SYT.Int) (Just (SymInt 0)) []) [([(For,SR {branchStart = 2, branchEnd = 18}),(If,SR {branchStart = 4, branchEnd = 16})],14)])
  ]

-----------------------------
-----------------------------
-----------------------------

takeWhileAsLongAsEvenCall1 :: SymStateEnv
takeWhileAsLongAsEvenCall1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "takeWhileAsLongAsEvenCall1"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just (SymInt 4)) [SymInt 2,SymInt 4,SymInt 6,SymInt 8],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just (SymInt 4)) [SymInt 2,SymInt 4,SymInt 6,SymInt 8]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[2, 4, 6, 8]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

takeWhileAsLongAsEvenCall2 :: SymStateEnv
takeWhileAsLongAsEvenCall2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "takeWhileAsLongAsEvenCall2"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just (SymInt 2)) [SymInt 2,SymInt 4],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just (SymInt 2)) [SymInt 2,SymInt 4]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[2, 4]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

bubbleSort :: SymStateEnv
bubbleSort = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "bubbleSort"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("n",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})])),
    (VarAssignments,SVarAssignments [
        ("n",(SObjAcc ["arr","length"],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})),
        ("arr",(SymVar (SYT.Array SYT.Int) "arr",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 6, branchEnd = 10}})),
        ("arr",(SymVar (SYT.Array SYT.Int) "arr",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 10}}))]),
    (VarName "arr",SymUnknown (SymVar (SYT.Array SYT.Int) "arr") [
        ([(For,SR {branchStart = 2, branchEnd = 14}),(For,SR {branchStart = 4, branchEnd = 12}),(If,SR {branchStart = 6, branchEnd = 10})],8),
        ([(For,SR {branchStart = 2, branchEnd = 14}),(For,SR {branchStart = 4, branchEnd = 12}),(If,SR {branchStart = 6, branchEnd = 10})],9)]),
    (VarName "n",SObjAcc ["arr","length"]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 14}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Minus, expr2 = NumberLiteral 1.0}})) [Node {id = 4, nodeData = ForInitialization (Just (AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "j"}, assEright = NumberLiteral 0.0})), parent = 2},Node {id = 13, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

bubbleSortCall :: SymStateEnv
bubbleSortCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "bubbleSortCall"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just $ SymInt 9) [SymInt 5,SymInt 4,SymInt 6,SymInt 4,SymInt 7,SymInt 8,SymInt 9,SymInt 0,SymInt 1],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just $ SymInt 9) [SymInt 0,SymInt 1,SymInt 4,SymInt 4,SymInt 5,SymInt 6,SymInt 7,SymInt 8,SymInt 9]),
 (Return,SymArray (Just SYT.Int) (Just $ SymInt 9) [SymInt 0,SymInt 1,SymInt 4,SymInt 4,SymInt 5,SymInt 6,SymInt 7,SymInt 8,SymInt 9])
  ]

-----------------------------
-----------------------------
-----------------------------

replicate :: SymStateEnv
replicate = Map.fromList [
    (MethodHandle,SMethodHandle SYT.String "replicate"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n","v"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("core",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),
        ("res",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("core",(SymVar SYT.String "v",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("res",(SymString "",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("res",(SBin (SymString "") SYT.Add (SymVar SYT.String "v"),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 7}}))]),
    (VarName "core",SymVar SYT.String "v"),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymString "") [
        ([(For,SR {branchStart = 3, branchEnd = 7})],5)]),
    (VarName "v",SymVar SYT.String "v"),
    (ScopeRange (SR {branchStart = 3, branchEnd = 7}),
     SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0}))
           [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "core"}}}}), parent = 3},Node {id = 6, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SymUnknown (SymString "") [([(For,SR {branchStart = 3, branchEnd = 7})],5)])
  ]

-----------------------------
-----------------------------
-----------------------------

replicateCall :: SymStateEnv
replicateCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.String "replicateCall"),
    (VarBindings,SVarBindings (Map.fromList [
        ("str",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("str",(SymString "qwqwqwqwqw",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "str",SymString "qwqwqwqwqw"),
    (Return,SymString "qwqwqwqwqw")
  ]

-----------------------------
-----------------------------
-----------------------------

sum3 :: SymStateEnv
sum3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sum3"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("res",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}})),
        ("res",(SymVar SYT.Int "n",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 2, branchEnd = 9}})),
        ("n",(SBin (SymVar SYT.Int "n") SYT.Sub (SymInt 1),Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 2, branchEnd = 9}}))]),
    (VarName "n",SymUnknown (SymVar SYT.Int "n") [([(For,SR {branchStart = 2, branchEnd = 9})],8)]),
    (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 9}),
     SLoop Nothing
           Nothing
           [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = LessEq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 8, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 9})],7)])
  ]

-----------------------------
-----------------------------
-----------------------------

sum3Call1 :: SymStateEnv
sum3Call1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sum3Call1"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 0),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

sum3Call2 :: SymStateEnv
sum3Call2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Int "sum3Call2"),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("x",(SymInt 6,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}}))]),
    (VarName "x",SymInt 6),
    (Return,SymInt 6)
  ]

-----------------------------
-----------------------------
-----------------------------

arrayBoolean :: SymStateEnv
arrayBoolean = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Bool "arrayBoolean"),
    (FormalParms,SFormalParms ["arr"]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (Return,SBin (SBin (SymVar (SYT.Array SYT.Int) "arr") SYT.Eq (SymNull (SYT.Array SYT.Int)))
                       SYT.Or
                       (SBin (SObjAcc ["arr","length"]) SYT.Le (SymInt 1)))
  ]

-----------------------------
-----------------------------
-----------------------------

arrayBooleanCall :: SymStateEnv
arrayBooleanCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "arrayBooleanCall"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "true\n",SymString "false\n",SymString "true\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

tail :: SymStateEnv
tail = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "tail"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarAssignments,SVarAssignments []),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 12}),
     SIte (SBin (SBin (SymVar (SYT.Array SYT.Int) "arr") SYT.Eq (SymNull (SYT.Array SYT.Int))) SYT.Or (SBin (SObjAcc ["arr","length"]) SYT.Le (SymInt 1)))
          (Map.fromList [(MethodHandle,SMethodHandle (SYT.Array SYT.Int) "tail"),(FormalParms,SFormalParms ["arr"]),(VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),(Return,SException (SYT.Array SYT.Int) "Exception" "array is too small")])
          (Just (Map.fromList [
              (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "tail"),
              (GlobalVars,SGlobalVars []),
              (FormalParms,SFormalParms ["arr"]),
              (VarBindings,SVarBindings (Map.fromList [
                  ("arr2",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 12}}),
                  ("j",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 12}})])),
              (VarAssignments,SVarAssignments [
                  ("arr2",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1))) [],Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 12}})),
                  ("j",(SymInt 0,Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 12}})),
                  ("arr2",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1))) [SArrayIndexAccess (SYT.Array SYT.Int) "arr" (SymInt 1)],Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 5, branchEnd = 2}})),
                  ("j",(SymInt 1,Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 5, branchEnd = 2}}))]),
              (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
              (VarName "arr2",SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1))) []) [
                  ([(If,SR {branchStart = 1, branchEnd = 12}),(For,SR {branchStart = 5, branchEnd = 10})],7)]),
              (VarName "j",SymUnknown (SymInt 0) [([(If,SR {branchStart = 1, branchEnd = 12}),(For,SR {branchStart = 5, branchEnd = 10})],8)]),
              (ScopeRange (SR {branchStart = 5, branchEnd = 10}),
               SLoop (Just (Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 1.0}}), parent = 1}))
                     (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}})) 
                     [Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr2"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "j"})}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 5},Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "j"}, binOp = Plus, expr2 = NumberLiteral 1.0}}}), parent = 5},Node {id = 9, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 5}]),
    (Return,SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1))) []) [
        ([(If,SR {branchStart = 1, branchEnd = 12}),(For,SR {branchStart = 5, branchEnd = 10})],7)])])))
  ]

-----------------------------
-----------------------------
-----------------------------

tailCall1 :: SymStateEnv
tailCall1 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "tailCall1"),
    (Return,SymReturnVoid),
    (Actions,SActions [SException (SYT.Array SYT.Int) "Exception" "array is too small"])
  ]

-----------------------------
-----------------------------
-----------------------------

tailCall2 :: SymStateEnv
tailCall2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "tailCall2"),
    (Return,SymReturnVoid),
    (Actions,SActions [SException (SYT.Array SYT.Int) "Exception" "array is too small"])
  ]

-----------------------------
-----------------------------
-----------------------------

tailCall3 :: SymStateEnv
tailCall3 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "tailCall3"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[9]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

tailCall4 :: SymStateEnv
tailCall4 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "tailCall4"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[9, 2]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

doubleArrayElems :: SymStateEnv
doubleArrayElems = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "doubleArrayElems"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarAssignments,SVarAssignments [
        ("arr",(SymVar (SYT.Array SYT.Int) "arr",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),
     SLoop (Just (Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = NumberLiteral 0.0}}), parent = 0}))
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 1},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "x"}}}}), parent = 1},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}})), parent = 1}]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymFun Println (SymVar (SYT.Array SYT.Int) "arr")])
  ]

-----------------------------
-----------------------------
-----------------------------

doubleArrayElemsCall :: SymStateEnv
doubleArrayElemsCall = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "doubleArrayElemsCall"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[2, 4, 6]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

doubleArrayElems2 :: SymStateEnv
doubleArrayElems2 = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "doubleArrayElems2"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [
        ("i",(SymInt 0,Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})),
        ("arr",(SymVar (SYT.Array SYT.Int) "arr",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}})),
        ("i",(SymInt 1,Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "i",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),
     SLoop Nothing
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}}))
           [Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}}}), parent = 2},Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, assEright = BinOpExpr {expr1 = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "x"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Plus, expr2 = NumberLiteral 1.0}}}), parent = 2}]),
    (Return,SymReturnVoid),
    (Actions,SActions [SymFun Println (SymVar (SYT.Array SYT.Int) "arr")])
  ]

-----------------------------
-----------------------------
-----------------------------

doubleArrayElems2Call :: SymStateEnv
doubleArrayElems2Call = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "doubleArrayElems2Call"),
    (Return,SymReturnVoid),
    (Actions,SActions [SymString "[2, 4, 6]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

quickSort :: SymStateEnv
quickSort = Map.fromList [
    (MethodHandle,SMethodHandle SYT.Void "quickSort"),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("stack",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 2}}),
        ("top",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [
        ("stack",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Mul (SymInt 2))) [],Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 2}})),
        ("top",(SymInt (-1),Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 2}})),
        ("top",(SymInt 0,Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 2}})),
        ("stack",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Mul (SymInt 2))) [SymInt 0],Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 2}})),
        ("top",(SymInt 1,Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 2}})),
        ("stack",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Mul (SymInt 2))) [SymInt 0,SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1)],Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 2}})),
        ("top",(SymInt 0,Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 10, branchEnd = 2}})),
        ("top",(SymInt (-1),Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 10, branchEnd = 2}})),
        ("top",(SymInt 0,Node_Coor {varDeclAt = 17, varFrame = SR {branchStart = 16, branchEnd = 2}})),
        ("stack",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Mul (SymInt 2))) [SArrayIndexAccess (SYT.Array SYT.Int) "stack" (SymInt 0),SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1)],Node_Coor {varDeclAt = 18, varFrame = SR {branchStart = 16, branchEnd = 2}})),
        ("top",(SymInt 1,Node_Coor {varDeclAt = 19, varFrame = SR {branchStart = 16, branchEnd = 2}})),
        ("stack",(SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Mul (SymInt 2))) [SArrayIndexAccess (SYT.Array SYT.Int) "stack" (SymInt 0),SymUnknown (SBin (SArrayIndexAccess (SYT.Array SYT.Int) "stack" (SymInt 0)) SYT.Sub (SymInt 1)) [([(For,SR {branchStart = 3, branchEnd = 10}),(If,SR {branchStart = 5, branchEnd = 8})],6)]],Node_Coor {varDeclAt = 20, varFrame = SR {branchStart = 16, branchEnd = 2}})),
        ("top",(SBin (SymUnknown (SymInt (-1)) [([(If,SR {branchStart = 16, branchEnd = 21})],17),([(If,SR {branchStart = 16, branchEnd = 21})],19)]) SYT.Add (SymInt 1),Node_Coor {varDeclAt = 23, varFrame = SR {branchStart = 22, branchEnd = 2}})),
        ("stack",(SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Mul (SymInt 2))) [SymInt 0,SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1)]) [([(If,SR {branchStart = 16, branchEnd = 21})],18),([(If,SR {branchStart = 16, branchEnd = 21})],20)],Node_Coor {varDeclAt = 24, varFrame = SR {branchStart = 22, branchEnd = 2}})),
        ("top",(SBin (SymUnknown (SymInt (-1)) [([(If,SR {branchStart = 16, branchEnd = 21})],17),([(If,SR {branchStart = 16, branchEnd = 21})],19)]) SYT.Add (SymInt 2),Node_Coor {varDeclAt = 25, varFrame = SR {branchStart = 22, branchEnd = 2}})),
        ("stack",(SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Mul (SymInt 2))) [SymInt 0,SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1)]) [([(If,SR {branchStart = 16, branchEnd = 21})],18),([(If,SR {branchStart = 16, branchEnd = 21})],20)],Node_Coor {varDeclAt = 26, varFrame = SR {branchStart = 22, branchEnd = 2}}))]),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "stack",SymUnknown (SymArray (Just SYT.Int) (Just (SBin (SObjAcc ["arr","length"]) SYT.Mul (SymInt 2))) [SymInt 0,SBin (SObjAcc ["arr","length"]) SYT.Sub (SymInt 1)]) [([(If,SR {branchStart = 16, branchEnd = 21})],18),([(If,SR {branchStart = 16, branchEnd = 21})],20),([(If,SR {branchStart = 16, branchEnd = 21}),(If,SR {branchStart = 22, branchEnd = 27})],24),([(If,SR {branchStart = 16, branchEnd = 21}),(If,SR {branchStart = 22, branchEnd = 27})],26)]),
    (VarName "top",SymUnknown (SymInt 1) [([],12),([],14),([(If,SR {branchStart = 16, branchEnd = 21})],17),([(If,SR {branchStart = 16, branchEnd = 21})],19),([(If,SR {branchStart = 16, branchEnd = 21}),(If,SR {branchStart = 22, branchEnd = 27})],23),([(If,SR {branchStart = 16, branchEnd = 21}),(If,SR {branchStart = 22, branchEnd = 27})],25)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 3}),
     SIte (SBin (SBin (SymVar (SYT.Array SYT.Int) "arr") SYT.Eq (SymNull (SYT.Array SYT.Int))) SYT.Or (SBin (SObjAcc ["arr","length"]) SYT.Le (SymInt 1)))
          (Map.fromList [
              (MethodHandle,SMethodHandle SYT.Void "quickSort"),
              (FormalParms,SFormalParms ["arr"]),
              (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
              (Return,SymReturnVoid)])
          Nothing),
    (ScopeRange (SR {branchStart = 10, branchEnd = 28}),
     SLoop Nothing
           (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "top"}, binOp = GreaterEq, expr2 = NumberLiteral 1.0}))
           [Node {id = 11, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "high"}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "stack"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "top"})}}}), parent = 10},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "top"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "top"}, binOp = Minus, expr2 = NumberLiteral 1.0}}}), parent = 10},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "low"}, assEright = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "stack"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "top"})}}}), parent = 10},Node {id = 14, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "top"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "top"}, binOp = Minus, expr2 = NumberLiteral 1.0}}}), parent = 10},Node {id = 15, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pivotIndex"}, assEright = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "partition"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "arr"},VarExpr {varType = Nothing, varObj = [], varName = "low"},VarExpr {varType = Nothing, varObj = [], varName = "high"}]}}}), parent = 10},Node {id = 16, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "pivotIndex"}, binOp = Minus, expr2 = NumberLiteral 1.0}, binOp = Greater, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "low"}})), parent = 10},Node {id = 22, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "pivotIndex"}, binOp = Plus, expr2 = NumberLiteral 1.0}, binOp = Less, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "high"}})), parent = 10}]),
    (Return,SymReturnVoid)
  ]

-----------------------------
-----------------------------
-----------------------------

quickSortCall1 :: SymStateEnv
quickSortCall1 = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "quickSortCall1"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymNull (SYT.Array SYT.Int),Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymNull (SYT.Array SYT.Int)),
    (Return,SymNull (SYT.Array SYT.Int))
  ]

-----------------------------
-----------------------------
-----------------------------

quickSortCall2 :: SymStateEnv
quickSortCall2 = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "quickSortCall2"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just (SymInt 1)) [SymInt 7],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just (SymInt 1)) [SymInt 7]),
    (Return,SymArray (Just SYT.Int) (Just (SymInt 1)) [SymInt 7])
  ]

-----------------------------
-----------------------------
-----------------------------

quickSortCall3 :: SymStateEnv
quickSortCall3 = Map.fromList [
    (MethodHandle,SMethodHandle (SYT.Array SYT.Int) "quickSortCall3"),
    (VarBindings,SVarBindings (Map.fromList [
        ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
        ("arr",(SymArray (Just SYT.Int) (Just (SymInt 5)) [SymInt 1,SymInt 5,SymInt 2,SymInt 4,SymInt 3],Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}))]),
    (VarName "arr",SymArray (Just SYT.Int) (Just (SymInt 5)) [SymInt 1,SymInt 2,SymInt 3,SymInt 4,SymInt 5]),
    (Return,SymArray (Just SYT.Int) (Just (SymInt 5)) [SymInt 1,SymInt 2,SymInt 3,SymInt 4,SymInt 5])
  ]
