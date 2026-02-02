module SymbolicExecution.TargetState (target) where

import qualified Data.Map as Map
--import Data.List (find)

import CFG.Types
import SymbolicExecution.Types

target :: String -> SymState
target name = case lookup name allTargets of
  Nothing -> error $ "testing ==> SymbolicExecution ==> target ==> funname does not exist: " ++ name
  Just state -> state

allTargets :: [(String,SymState)]
allTargets = [
  ("ifFun",ifFun),
  ("ifFun2",ifFun2),
  ("ifFunCall",ifFunCall), ("ifFun2Call",ifFun2Call), ("ifFun2Call2",ifFun2Call2),
  ("ifFun3",ifFun3),
  ("ifFun4",ifFun4),
  ("ifFun5",ifFun5), ("ifFun5Call1",ifFun5Call1), ("ifFun5Call2",ifFun5Call2),
  ("ifFun6",ifFun6),
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
  ("for2", for2)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun :: SymState
ifFun = SymState {
  env = Map.fromList [
    (MethodName "ifFun",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing),
    (Return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFunCall :: SymState
ifFunCall = SymState {
  env = Map.fromList [
    (MethodName "ifFunCall",SMethodType Int),
    (Return,SymInt 8)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun2 :: SymState
ifFun2 = SymState {
  env = Map.fromList [
    (MethodName "ifFun2",SMethodType Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (VarName "y",SymVar Int "y"),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing),
    (Return,SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun2Call :: SymState
ifFun2Call = SymState {
  env = Map.fromList [
    (MethodName "ifFun2Call",SMethodType Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymVar Int "y"),
    (Return,SBin (SymVar Int "y") Add (SymInt 11))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun2Call2 :: SymState
ifFun2Call2 = SymState {
  env = Map.fromList [
    (MethodName "ifFun2Call2",SMethodType Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymVar Int "y"),
    (Return,SBin (SymVar Int "y") Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun3 :: SymState
ifFun3 = SymState {
  env = Map.fromList [
    (MethodName "ifFun3",SMethodType Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (VarName "y",SymVar UnknownNumSymType "y"),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = Map.fromList [(MethodName "ifFun3",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1),(VarName "y",SymVar UnknownNumSymType "y")], pc = []}) Nothing),
    (Return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun4 :: SymState
ifFun4 = SymState {
  env = Map.fromList [
    (MethodName "ifFun4",SMethodType Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "y",SymUnknown (Int,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 3}),SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = Map.fromList [(MethodName "ifFun4",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymVar Int "y") Add (SymVar Int "n"))], pc = []}) Nothing),
    (Return,SymUnknown (Int,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)])
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun5 :: SymState
ifFun5 = SymState {
  env = Map.fromList [
    (MethodName "ifFun5",SMethodType Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "y",SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing),
    (Return,SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun5Call1 :: SymState
ifFun5Call1 = SymState {
  env = Map.fromList [
    (MethodName "ifFun5Call1",SMethodType Int),
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
    (MethodName "ifFun5Call2",SMethodType Int),
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
    (MethodName "ifFun6",SMethodType String),
    (GlobalVars,SGlobalVars ["y","m","s","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}}),("s",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
    (VarName "c",SymVar String "c"),
    (VarName "m",SymUnknown (Int,"m",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "n",SymVar Int "n"),
    (VarName "s",SymString "something"),
    (VarName "y",SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 4}),SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = Map.fromList [(MethodName "ifFun6",SMethodType String),(GlobalVars,SGlobalVars ["y","m"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "m",SBin (SymVar Int "m") Add (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymNum (-1.0)) Mul (SymVar UnknownNumSymType "y"))], pc = []}) Nothing),
    (Return,SymVar String "c")
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun7 :: SymState
ifFun7 = SymState {
  env = Map.fromList [
    (MethodName "ifFun7",SMethodType Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),
        ("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 4}),
        SIte
            (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0))
            (SymState {env = Map.fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []})
            (Just (SymState {env = Map.fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun7Call :: SymState
ifFun7Call = SymState {
  env = Map.fromList [
    (MethodName "ifFun7Call",SMethodType Void),
    (GlobalVars,SGlobalVars ["v"]),
    (VarName "v",SymString "hi")
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun7Call2 :: SymState
ifFun7Call2 = SymState {
  env = Map.fromList [
    (MethodName "ifFun7Call2",SMethodType Void),
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
    (MethodName "ifFun7Call3",SMethodType Void),
    (GlobalVars,SGlobalVars ["t","v","w"]),
    (VarName "t",SymVar UnknownGlobalVarSymType "t"),
    (VarName "v",SymVar String "v"),
    (VarName "w",SymVar String "w")
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun8 :: SymState
ifFun8 = SymState {
  env = Map.fromList [
    (MethodName "ifFun8",SMethodType Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 6})],2)]),
    (VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun8",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi"),(Actions,SActions ["hi\n"])], pc = []}) (Just (SymState {env = Map.fromList [(MethodName "ifFun8",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye"),(Actions,SActions ["bye\n"])], pc = []})))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun8Call :: SymState
ifFun8Call = SymState {
  env = Map.fromList [
    (MethodName "ifFun8Call",SMethodType Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye"),
    (Actions,SActions ["hi\n","bye\n","hi\n"])
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun9 :: SymState
ifFun9 = SymState {
  env = Map.fromList [
    (MethodName "ifFun9",SMethodType Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),
        ("v",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}}),
        ("w",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "v",SymUnknown (String,"v",Nothing) [
        ([(If,SR {branchStart = 1, branchEnd = 6})],2),
        ([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
    (VarName "w",SymUnknown (String,"w",Nothing) [
        ([(If,SR {branchStart = 1, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),
        SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0))
             (SymState {env = Map.fromList [(MethodName "ifFun9",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi zu"),(VarName "z",SymInt 3)], pc = []})
             (Just (SymState {env = Map.fromList [(MethodName "ifFun9",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun10 :: SymState
ifFun10 = SymState {
  env = Map.fromList [
    (MethodName "ifFun10",SMethodType Int),
    (GlobalVars,SGlobalVars ["v","t","i"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),
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
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SIte (SBin (SymVar String "v") Eq (SymString "bye")) (SymState {env = Map.fromList [(MethodName "ifFun10",SMethodType Int),(GlobalVars,SGlobalVars ["v"]),(VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}}),("v",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "res",SymInt 1),(VarName "v",SymString "zuzu")], pc = []}) Nothing),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

ifFun11 :: SymState
ifFun11 = SymState {
  env = Map.fromList [
    (MethodName "ifFun11",SMethodType Int),
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
    (MethodName "ifFun12",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun12",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "res",SymInt 1)], pc = []}) Nothing),
    (Return,SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])], pc = []}

-----------------------------
-----------------------------
-----------------------------

succFun :: SymState
succFun = SymState {
  env = Map.fromList [
    (MethodName "succFun",SMethodType Void),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
    (VarName "i",SBin (SymVar Int "i") Add (SymInt 1))
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

callSuccFun :: SymState
callSuccFun = SymState {
  env = Map.fromList [
    (MethodName "callSuccFun",SMethodType Int),
    (FormalParms,SFormalParms ["n"]),
    (VarName "n",SBin (SymVar Int "n") Add (SymInt 1)),
    (Return,SBin (SymVar Int "n") Add (SymInt 1))
  ], pc = []
}

-----------------------------
-----------------------------
-----------------------------

callCallSuccFun :: SymState
callCallSuccFun = SymState {
  env = Map.fromList [
    (MethodName "callCallSuccFun",SMethodType Int),
    (Return,SymInt 6)
  ], pc = []
  }

-----------------------------
-----------------------------
-----------------------------

wrongSum1 :: SymState
wrongSum1 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum1",SMethodType Int),
    (GlobalVars,SGlobalVars ["w","t","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}}),("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 3, branchEnd = 12}}),("t",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 3, branchEnd = 12}}),("j",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 3, branchEnd = 12}})]),
    (VarName "j",SymUnknown (Int,"j",Just (SymVar Int "w")) [([(For,SR {branchStart = 3, branchEnd = 12})],10)]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 3, branchEnd = 12})],9)]),
    (VarName "w",SymVar Int "w"),
    (ScopeRange (SR {branchStart = 3, branchEnd = 12}),SLoop (Just (Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 3},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 3},Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 3},Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 3},Node {id = 10, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "j"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "c"}}}), parent = 3},Node {id = 11, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 3}]),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

wrongSum2 :: SymState
wrongSum2 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum2",SMethodType Int),
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
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (VarName "v",SymUnknown (String,"v",Nothing) [
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],8),
        ([(For,SR {branchStart = 2, branchEnd = 15}),(If,SR {branchStart = 7, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral True)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

wrongSum3 :: SymState
wrongSum3 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum3",SMethodType Int),
    (GlobalVars,SGlobalVars ["t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (Int,"t",Nothing) [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral False)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ], pc = []}

-----------------------------
-----------------------------
-----------------------------

wrongSum4 :: SymState
wrongSum4 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum4",SMethodType Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
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

-----------------------------
-----------------------------
-----------------------------

wrongSum5 :: SymState
wrongSum5 = SymState {
  env = Map.fromList [
    (MethodName "wrongSum5",SMethodType Int),
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

-----------------------------
-----------------------------
-----------------------------

for1 :: SymState
for1 = SymState {
  env = Map.fromList [
    (MethodName "for1",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymInt 0),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)], pc = []}

-----------------------------
-----------------------------
-----------------------------

for2 :: SymState
for2 = SymState {
  env = Map.fromList [
    (MethodName "for2",SMethodType Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),
        ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),
        ("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),
    (VarName "n",SymVar Int "n"),
    (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [
        ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),
        ([(If,SR {branchStart = 9, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (ScopeRange (SR {branchStart = 9, branchEnd = 11}),SIte (SBin (SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) Mod (SymInt 3)) Eq (SymInt 0)) (SymState {env = Map.fromList [(MethodName "for2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) Mul (SymInt 3)),(ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})), parent = 2}])], pc = []}) Nothing),
    (Return,SymUnknown (Int,"res",Just (SymInt 0)) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),([(If,SR {branchStart = 9, branchEnd = 11})],10)])], pc = []}

-----------------------------
-----------------------------
-----------------------------
