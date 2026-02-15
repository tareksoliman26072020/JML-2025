module SymbolicExecution.TargetState (target) where

import Prelude hiding (id)
import qualified Data.Map as Map

import CFG.Types
import Parser.Types
import SymbolicExecution.Types hiding (SymType(..), SymBinOp(..))
import qualified SymbolicExecution.Types as SYT (SymType(..), SymBinOp(..))

target :: String -> SymState
target name = case lookup name allTargets of
  Nothing -> error $ "testing ==> SymbolicExecution ==> target ==> funname does not exist: " ++ name
  Just state -> state

allTargets :: [(String,SymState)]
allTargets = [
  ("boo30",boo30),
  ("voidFun1",voidFun1),
  ("voidFun2",voidFun2),
  ("voidFun3",voidFun3),
  ("manyArrs",manyArrs),
  ("manyArrs2",manyArrs2),
  ("manyArrs3",manyArrs3),
  ("manyArrs4", manyArrs4),
  ("ifFun",ifFun),
  ("ifFun2",ifFun2),
  ("ifFunCall",ifFunCall), ("ifFun2Call",ifFun2Call), ("ifFun2Call2",ifFun2Call2),
  ("ifFun3",ifFun3), ("voidFun3Call", voidFun3Call),
  ("ifFun4",ifFun4),
  ("ifFun5",ifFun5), ("ifFun5Call1",ifFun5Call1), ("ifFun5Call2",ifFun5Call2),
  ("ifFun6",ifFun6), ("ifFun6Call",ifFun6Call),
  ("ifFun7",ifFun7), ("ifFun7Call",ifFun7Call), ("ifFun7Call2",ifFun7Call2), ("ifFun7Call3",ifFun7Call3),
  ("ifFun8",ifFun8), ("ifFun8Call",ifFun8Call),
  ("ifFun9",ifFun9),
  ("ifFun10",ifFun10),
  ("ifFun11",ifFun11),
  ("ifFun12",ifFun12),
  ("succFun", succFun), ("callSuccFun", callSuccFun), ("callCallSuccFun", callCallSuccFun),
  ("wrongSum1", wrongSum1),
  ("wrongSum2", wrongSum2),
  ("wrongSum3", wrongSum3),
  ("wrongSum4", wrongSum4),
  ("wrongSum5", wrongSum5),
  ("for1", for1),
  ("for2", for2),
  ("sum1", sum1)
  ]

-----------------------------
-----------------------------
-----------------------------

boo30 :: SymState
boo30 = undefined

voidFun1 :: SymState
voidFun1 = SymState {
  env = Map.fromList [
    (MethodName "voidFun1",SMethodType SYT.Void)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

voidFun2 :: SymState
voidFun2 = SymState {
  env = Map.fromList [
    (MethodName "voidFun2",SMethodType SYT.Void)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

voidFun3 :: SymState
voidFun3 = SymState {
  env = Map.fromList [
    (MethodName "voidFun3",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["y2","z"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [
        ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}}),
        ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
    (VarAssignments,SVarAssignments [
        ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 10}}),
        ("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 10}}),
        ("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 10}}),
        ("z",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 9}}),
        ("z",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 6, branchEnd = 9}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "x",SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n")),
    (VarName "y",SymString "is one"),
    (VarName "y2",SymString "is not one"),
    (VarName "z",SymUnknown (SYT.String,"z",Nothing) [
        ([(If,SR {branchStart = 6, branchEnd = 9})],7),
        ([(If,SR {branchStart = 6, branchEnd = 9})],8)]),
    (ScopeRange (SR {branchStart = 6, branchEnd = 9}),
     SIte (SBin (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n")) SYT.Eq (SymInt 1))
          (SymState {env = Map.fromList [
              (MethodName "voidFun3",SMethodType SYT.Void),
              (GlobalVars,SGlobalVars ["y2","z"]),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
              (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 10}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 10}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 10}}),("z",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 9}})]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "x",SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n")),
              (VarName "y",SymString "is one"),
              (VarName "y2",SymString "is not one"),
              (VarName "z",SBin (SBin (SymFun ToString (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"))) SYT.Add (SymString " ")) SYT.Add (SymString "is one"))], pc = []})
          (Just (SymState {env = Map.fromList [
              (MethodName "voidFun3",SMethodType SYT.Void),
              (GlobalVars,SGlobalVars ["y2","z"]),
              (FormalParms,SFormalParms ["n"]),
              (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 10}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 10}})])),
              (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 10}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 10}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 10}}),("z",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 6, branchEnd = 9}})]),
              (VarName "n",SymVar SYT.Int "n"),
              (VarName "x",SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n")),
              (VarName "y",SymString "is one"),
              (VarName "y2",SymString "is not one"),
              (VarName "z",SBin (SBin (SymFun ToString (SBin (SymInt 1) SYT.Add (SymVar SYT.Int "n"))) SYT.Add (SymString " ")) SYT.Add (SymString "is not one"))], pc = []})))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

voidFun3Call :: SymState
voidFun3Call = SymState {
  env = Map.fromList [
    (MethodName "voidFun3Call",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["y2","z"]),
    (VarName "y2",SymString "is not one"),
    (VarName "z",SymString "11 is not one"),
    (Actions,SActions [SymString "11 is not one\n"])
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

manyArrs :: SymState
manyArrs = SymState {
  env = Map.fromList [
    (MethodName "manyArrs",SMethodType SYT.Void),
    (VarBindings,SVarBindings (Map.fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}),("numbers",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 5}})]),
    (VarName "numbers",SymArray (Just SYT.Int) (Just 2) [SymInt 99,SymInt 5]),
    (Actions,SActions [SymString "[99, 5]\n"])
  ], pc = []
}

-----------------------------
-----------------------------
-----------------------------

manyArrs2 :: SymState
manyArrs2 = SymState {
  env = Map.fromList [
    (MethodName "manyArrs2",SMethodType SYT.Void),
    (VarBindings,SVarBindings (Map.fromList [("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})])),
    (VarAssignments,SVarAssignments [("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 29}}),("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 11, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 15, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 16, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 17, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 18, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 19, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 20, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 21, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 22, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 23, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 24, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 25, varFrame = SR {branchStart = 0, branchEnd = 29}})]),
    (VarName "brand",SymArray (Just SYT.String) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),
    (VarName "numbers1",SymArray (Just SYT.Int) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]),
    (VarName "numbers2",SymArray (Just SYT.Int) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]),
    (VarName "numbers3",SymArray (Just SYT.Int) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]),
    (VarName "strs",SymArray (Just SYT.String) (Just 3) [SymNull SYT.String,SymString "meow",SymNull SYT.String]),
    (Actions,SActions [SymString "[86, 57, 80, 34, 50, 48, 94]\n",SymString "[51, 84, 92, 87, 81]\n",SymString "[5, 75, 34, 10, 6]\n"])
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

manyArrs3 :: SymState
manyArrs3 = SymState {
  env = Map.fromList [
    (MethodName "manyArrs3",SMethodType (SYT.Array SYT.Int)),
    (VarBindings,SVarBindings (Map.fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
    (VarName "numbers",SymArray (Just SYT.Int) (Just 2) [SymInt 99,SymInt 5]),
    (Return,SymArray (Just SYT.Int) (Just 2) [SymInt 99,SymInt 5])
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

manyArrs4 :: SymState
manyArrs4 = SymState {
  env = Map.fromList [
    (MethodName "manyArrs4",SMethodType SYT.Void),
    (VarBindings,SVarBindings (Map.fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
    (VarName "numbers",SymArray (Just SYT.Int) (Just 2) [SymInt 99,SymNull SYT.Int]),
    (Actions,SActions [SymString "[99, 0]\n"])
  ], pc = []}


-----------------------------
-----------------------------
-----------------------------

ifFun :: SymState
ifFun = SymState {
  env = Map.fromList [
    (MethodName "ifFun",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (SYT.Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun",SMethodType SYT.Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n")),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SymVar SYT.Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing),
    (Return,SBin (SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) SYT.Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFunCall :: SymState
ifFunCall = SymState {
  env = Map.fromList [
    (MethodName "ifFunCall",SMethodType SYT.Int),
    (Return,SymInt 8)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun2 :: SymState
ifFun2 = SymState {
  env = Map.fromList [
    (MethodName "ifFun2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (SYT.Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SYT.Int,"res",Just (SymVar SYT.Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (VarName "y",SymVar SYT.Int "y"),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun2",SMethodType SYT.Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n")),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SBin (SymVar SYT.Int "y") SYT.Add (SymVar SYT.Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar SYT.Int "y")], pc = []}) Nothing),
    (Return,SBin (SymUnknown (SYT.Int,"res",Just (SymVar SYT.Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) SYT.Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun2Call :: SymState
ifFun2Call = SymState {
  env = Map.fromList [
    (MethodName "ifFun2Call",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymVar SYT.Int "y"),
    (Return,SBin (SymVar SYT.Int "y") SYT.Add (SymInt 11))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun2Call2 :: SymState
ifFun2Call2 = SymState {
  env = Map.fromList [
    (MethodName "ifFun2Call2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymVar SYT.Int "y"),
    (Return,SBin (SymVar SYT.Int "y") SYT.Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun3 :: SymState
ifFun3 = SymState {
  env = Map.fromList [
    (MethodName "ifFun3",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (SYT.Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (VarName "y",SymVar SYT.UnknownNumSymType "y"),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar SYT.UnknownNumSymType "y") SYT.Ge (SymNum 0.0)) (SymState {env = Map.fromList [(MethodName "ifFun3",SMethodType SYT.Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n")),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SymVar SYT.Int "n"),(VarName "x",SymInt 1),(VarName "y",SymVar SYT.UnknownNumSymType "y")], pc = []}) Nothing),
    (Return,SBin (SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) SYT.Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun4 :: SymState
ifFun4 = SymState {
  env = Map.fromList [
    (MethodName "ifFun4",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "y",SymUnknown (SYT.Int,"y",Just (SymVar SYT.Int "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 3}),
        SIte (SBin (SymVar SYT.Int "y") SYT.Ge (SymInt 0))
             (SymState {env = Map.fromList [
                 (MethodName "ifFun4",SMethodType SYT.Int),
                 (GlobalVars,SGlobalVars ["y"]),
                 (FormalParms,SFormalParms ["n"]),
                 (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),
                 (VarName "n",SymVar SYT.Int "n"),
                 (VarName "y",SBin (SymVar SYT.Int "y") SYT.Add (SymVar SYT.Int "n"))
             ], pc = []}) 
             Nothing),
    (Return,SymUnknown (SYT.Int,"y",Just (SymVar SYT.Int "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)])
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun5 :: SymState
ifFun5 = SymState {
  env = Map.fromList [
    (MethodName "ifFun5",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "y",SymUnknown (SYT.Int,"y",Just (SymVar SYT.Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun5",SMethodType SYT.Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "y",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"))], pc = []}) Nothing),
    (Return,SymUnknown (SYT.Int,"y",Just (SymVar SYT.Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun5Call1 :: SymState
ifFun5Call1 = SymState {
  env = Map.fromList [
    (MethodName "ifFun5Call1",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymInt 20),
    (Return,SymInt 20)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun5Call2 :: SymState
ifFun5Call2 = SymState {
  env = Map.fromList [
    (MethodName "ifFun5Call2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymInt (-10)),
    (Return,SymInt (-10))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun6 :: SymState
ifFun6 = SymState {
  env = Map.fromList [
    (MethodName "ifFun6",SMethodType SYT.String),
    (GlobalVars,SGlobalVars ["y","m","s","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}}),("s",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
    (VarName "c",SymVar SYT.String "c"),
    (VarName "m",SymUnknown (SYT.Int,"m",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "s",SymString "something"),
    (VarName "y",SymUnknown (SYT.UnknownNumSymType,"y",Just (SymVar SYT.UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 4}),SIte (SBin (SymVar SYT.UnknownNumSymType "y") SYT.Ge (SymNum 0.0)) (SymState {env = Map.fromList [(MethodName "ifFun6",SMethodType SYT.String),(GlobalVars,SGlobalVars ["y","m"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "m",SBin (SymVar SYT.Int "m") SYT.Add (SymVar SYT.Int "n")),(VarName "n",SymVar SYT.Int "n"),(VarName "y",SBin (SymNum (-1.0)) SYT.Mul (SymVar SYT.UnknownNumSymType "y"))], pc = []}) Nothing),
    (Return,SymVar SYT.String "c")
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun6Call :: SymState
ifFun6Call = SymState {
  env = Map.fromList [
    (MethodName "ifFun6Call",SMethodType SYT.String),
    (GlobalVars,SGlobalVars ["y","m","c","s"]),
    (VarAssignments,SVarAssignments [
        ("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),
        ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),
        ("c",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
    (VarName "c",SymString "dangerous"),
    (VarName "m",SymInt 11),
    (VarName "s",SymString "something"),
    (VarName "y",SymInt (-5)),
    (Return,SymString "6.0 dangerous something6")
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun7 :: SymState
ifFun7 = SymState {
  env = Map.fromList [
    (MethodName "ifFun7",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),
        ("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "v",SymUnknown (SYT.String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "w",SymUnknown (SYT.String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 4}),
        SIte
            (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0))
            (SymState {env = Map.fromList [(MethodName "ifFun7",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "v",SymString "hi")], pc = []})
            (Just (SymState {env = Map.fromList [(MethodName "ifFun7",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "w",SymString "bye")], pc = []})))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun7Call :: SymState
ifFun7Call = SymState {
  env = Map.fromList [
    (MethodName "ifFun7Call",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v"]),
    (VarName "v",SymString "hi")
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun7Call2 :: SymState
ifFun7Call2 = SymState {
  env = Map.fromList [
    (MethodName "ifFun7Call2",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye")
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun7Call3 :: SymState
ifFun7Call3 = SymState {
  env = Map.fromList [
    (MethodName "ifFun7Call3",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["t","v","w"]),
    (VarName "t",SymVar SYT.Int "t"),
    (VarName "v",SymUnknown (SYT.String,"v",Nothing) [
        ([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "w",SymUnknown (SYT.String,"w",Nothing) [
        ([(If,SR {branchStart = 1, branchEnd = 4})],3)])
], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun8 :: SymState
ifFun8 = SymState {
  env = Map.fromList [
    (MethodName "ifFun8",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "v",SymUnknown (SYT.String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 6})],2)]),
    (VarName "w",SymUnknown (SYT.String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),SIte (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun8",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "v",SymString "hi"),(Actions,SActions [SymString "hi\n"])], pc = []}) (Just (SymState {env = Map.fromList [(MethodName "ifFun8",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "w",SymString "bye"),(Actions,SActions [SymString "bye\n"])], pc = []})))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun8Call :: SymState
ifFun8Call = SymState {
  env = Map.fromList [
    (MethodName "ifFun8Call",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye"),
    (Actions,SActions [SymString "hi\n",SymString "bye\n",SymString "hi\n"])
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun9 :: SymState
ifFun9 = SymState {
  env = Map.fromList [
    (MethodName "ifFun9",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),
        ("v",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}}),
        ("w",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "v",SymUnknown (SYT.String,"v",Nothing) [
        ([(If,SR {branchStart = 1, branchEnd = 6})],2),
        ([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
    (VarName "w",SymUnknown (SYT.String,"w",Nothing) [
        ([(If,SR {branchStart = 1, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),
        SIte (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0))
             (SymState {env = Map.fromList [(MethodName "ifFun9",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "v",SymString "hi zu"),(VarName "z",SymInt 3)], pc = []})
             (Just (SymState {env = Map.fromList [(MethodName "ifFun9",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "w",SymString "bye")], pc = []})))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun10 :: SymState
ifFun10 = SymState {
  env = Map.fromList [
    (MethodName "ifFun10",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["v","t","i"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}}),
        ("v",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}),
        ("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),
        ("v",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}}),
        ("res",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 9}}),
        ("t",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 9}})]),
    (VarName "i",SymVar SYT.UnknownGlobalVarSymType "i"),
    (VarName "res",SymInt 0),
    (VarName "t",SymVar SYT.UnknownGlobalVarSymType "i"),
    (VarName "v",SymUnknown (SYT.String,"v",Just (SymVar SYT.String "v")) [
        ([(If,SR {branchStart = 2, branchEnd = 6})],3),
        ([(If,SR {branchStart = 2, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SIte (SBin (SymVar SYT.String "v") SYT.Eq (SymString "bye")) (SymState {env = Map.fromList [(MethodName "ifFun10",SMethodType SYT.Int),(GlobalVars,SGlobalVars ["v"]),(VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}}),("v",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "res",SymInt 1),(VarName "v",SymString "zuzu")], pc = []}) Nothing),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun11 :: SymState
ifFun11 = SymState {
  env = Map.fromList [
    (MethodName "ifFun11",SMethodType SYT.Int),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})]),
    (VarName "res",SymInt 0),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun12 :: SymState
ifFun12 = SymState {
  env = Map.fromList [
    (MethodName "ifFun12",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun12",SMethodType SYT.Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SymInt 1)], pc = []}) Nothing),
    (Return,SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])], pc = []}

-----------------------------
-----------------------------
-----------------------------

succFun :: SymState
succFun = SymState {
  env = Map.fromList [
    (MethodName "succFun",SMethodType SYT.Void),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
    (VarName "i",SBin (SymVar SYT.Int "i") SYT.Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

callSuccFun :: SymState
callSuccFun = SymState {
  env = Map.fromList [
    (MethodName "callSuccFun",SMethodType SYT.Int),
    (FormalParms,SFormalParms ["n"]),
    (VarName "n",SBin (SymVar SYT.Int "n") SYT.Add (SymInt 1)),
    (Return,SBin (SymVar SYT.Int "n") SYT.Add (SymInt 1))
  ], pc = []
}

-----------------------------
-----------------------------
-----------------------------

callCallSuccFun :: SymState
callCallSuccFun = SymState {
  env = Map.fromList [
    (MethodName "callCallSuccFun",SMethodType SYT.Int),
    (Return,SymInt 6)
  ], pc = []
  }

-----------------------------
-----------------------------
-----------------------------

wrongSum1 :: SymState
wrongSum1 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum1",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["w","t","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}}),("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 3, branchEnd = 12}}),("t",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 3, branchEnd = 12}}),("j",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 3, branchEnd = 12}})]),
    (VarName "j",SymUnknown (SYT.Int,"j",Just (SymVar SYT.Int "w")) [([(For,SR {branchStart = 3, branchEnd = 12})],10)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (SYT.Int,"t",Nothing) [([(For,SR {branchStart = 3, branchEnd = 12})],9)]),
    (VarName "w",SymVar SYT.Int "w"),
    (ScopeRange (SR {branchStart = 3, branchEnd = 12}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 3},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 3},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 3},Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 10, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "c"}}}), parent = 3},Node {id = 11, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

wrongSum2 :: SymState
wrongSum2 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),
        ("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),
        ("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),
        ("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (SYT.Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (VarName "v",SymUnknown (SYT.String,"v",Nothing) [
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],8),
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral True)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

wrongSum3 :: SymState
wrongSum3 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum3",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (SYT.Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral False)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

wrongSum4 :: SymState
wrongSum4 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum4",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (SYT.Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (VarName "v",SymUnknown (SYT.String,"v",Nothing) [
      ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],8),
      ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "v"}, binOp = Eq, expr2 = StringLiteral "bye"})), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

wrongSum5 :: SymState
wrongSum5 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum5",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 15}}),
        ("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 14}}),
        ("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),
        ("t",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 14}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SYT.Int,"res",Just (SymInt 0)) [
        ([(For,SR {branchStart = 2, branchEnd = 14})],4),
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],9)]),
    (VarName "t",SymUnknown (SYT.Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 14})],12)]),
    (VarName "v",SymUnknown (SYT.String,"v",Nothing) [
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],8),
        ([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 14}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "v"}, binOp = Eq, expr2 = StringLiteral "bye"})), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 13, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 14})],4),([(For,SR {branchStart = 2, branchEnd = 14}),(If,SR {branchStart = 7, branchEnd = 11})],9)])
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

for1 :: SymState
for1 = SymState {
  env = Map.fromList [
    (MethodName "for1",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)], pc = []}

-----------------------------
-----------------------------
-----------------------------

for2 :: SymState
for2 = SymState {
  env = Map.fromList [
    (MethodName "for2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),
        ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),
        ("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SYT.Int,"res",Just (SymInt 0)) [
        ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),
        ([(If,SR {branchStart = 9, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (ScopeRange (SR {branchStart = 9, branchEnd = 11}),SIte (SBin (SBin (SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) SYT.Mod (SymInt 3)) SYT.Eq (SymInt 0)) (SymState {env = Map.fromList [(MethodName "for2",SMethodType SYT.Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SBin (SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) SYT.Mul (SymInt 3)),(ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}])], pc = []}) Nothing),
    (Return,SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),([(If,SR {branchStart = 9, branchEnd = 11})],10)])], pc = []}

-----------------------------
-----------------------------
-----------------------------

sum1 :: SymState
sum1 = SymState {
  env = Map.fromList [
    (MethodName "sum1",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),("n",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),
    (VarName "n",SymUnknown (SYT.Int,"n",Just (SymVar SYT.Int "n")) [([(For,SR {branchStart = 2, branchEnd = 6})],5)]),
    (VarName "res",SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SYT.Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])], pc = []
}

-----------------------------
-----------------------------
-----------------------------
