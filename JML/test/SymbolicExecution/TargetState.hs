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
  ("ifFun7",ifFun7),
  ("ifFun7Call",ifFun7Call),
  ("ifFun7Call2",ifFun7Call2),
  ("ifFun7Call3",ifFun7Call3),
  ("ifFun8",ifFun8),
  ("ifFun9",ifFun9)
  ]

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

