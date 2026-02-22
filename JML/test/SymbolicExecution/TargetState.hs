module SymbolicExecution.TargetState (target) where

import Prelude hiding (id)
import qualified Data.Map as Map

import CFG.Types
import Parser.Types
import SymbolicExecution.Types hiding (SymType(..), SymBinOp(..))
import qualified SymbolicExecution.Types as SYT (SymType(..), SymBinOp(..))
import qualified Data.Map.Lazy as Map

target :: String -> SymState
target name = case lookup name allTargets of
  Nothing -> error $ "testing ==> SymbolicExecution ==> target ==> funname does not exist: " ++ name
  Just state -> state

allTargets :: [(String,SymState)]
allTargets = [
  ("boo30",boo30),
  ("boo31",boo31),
  ("boo31_2", boo31_2),
  ("boo31_3", boo31_3),
  ("boo32", boo32), ("boo32Call", boo32Call),
  ("elemAt", elemAt), ("elemAtCall", elemAtCall),
  ("elemAt2", elemAt2), ("elemAt2Call", elemAt2Call), ("elemAt2Call2", elemAt2Call2),
  ("elemAt4", elemAt4),
  ("strFun", strFun),
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

boo30 :: Map.Map SymStateKey SymExpr
boo30 = Map.fromList [
    (MethodName "boo30",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y","y1","y2","t1","t2"]),
    (FormalParms,SFormalParms ["z"]),
    (VarBindings,SVarBindings (Map.fromList [
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
          (SymState {env = Map.fromList [
              (MethodName "boo30",SMethodType SYT.Int),
              (GlobalVars,SGlobalVars ["y","y1","y2","t1"]),
              (FormalParms,SFormalParms ["z"]),
              (VarBindings,SVarBindings (Map.fromList [
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
              (VarName "z",SymVar SYT.Int "z"),
              (Return,SymInt 7)
          ], pc = []})
          (Just (SymState {env = Map.fromList [
              (MethodName "boo30",SMethodType SYT.Int),
              (GlobalVars,SGlobalVars ["y","y1","y2","t2"]),
              (FormalParms,SFormalParms ["z"]),
              (VarBindings,SVarBindings (Map.fromList [
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
              (VarName "z",SymVar SYT.Int "z"),
              (Return,SymInt 17)
          ], pc = []})))
  ]

-----------------------------
-----------------------------
-----------------------------

boo31 :: Map.Map SymStateKey SymExpr
boo31 = Map.fromList [
    (MethodName "boo31",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["z"]),
    (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [("z",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
    (VarName "x",SymInt 0),
    (VarName "z",SymInt 0),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

boo31_2 :: Map.Map SymStateKey SymExpr
boo31_2 = Map.fromList [
    (MethodName "boo31_2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["z","y","y1","y2","t1"]),
    (VarBindings,SVarBindings (Map.fromList [
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
  ]

-----------------------------
-----------------------------
-----------------------------

boo31_3 :: Map.Map SymStateKey SymExpr
boo31_3 = Map.fromList [
    (MethodName "boo31_3",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["z","y","y1","y2","t2"]),
    (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("z",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
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

boo32 :: SymState
boo32 = Map.fromList [
    (MethodName "boo32",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y1","y2","y3"]),
    (VarBindings,SVarBindings (Map.fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
    (VarName "x",SBin (SBin (SymVar SYT.Int "y1") SYT.Add (SymVar SYT.Int "y2")) SYT.Add (SymVar SYT.Int "y3")),
    (VarName "y1",SymVar SYT.Int "y1"),
    (VarName "y2",SymVar SYT.Int "y2"),
    (VarName "y3",SymVar SYT.Int "y3"),
    (Return,SBin (SBin (SymVar SYT.Int "y1") SYT.Add (SymVar SYT.Int "y2")) SYT.Add (SymVar SYT.Int "y3"))
  ]

-----------------------------
-----------------------------
-----------------------------

boo32Call :: Map.Map SymStateKey SymExpr
boo32Call = Map.fromList [
    (MethodName "boo32Call",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y1","y2","y3"]),
    (VarAssignments,SVarAssignments [("y1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
    (VarName "y1",SymNum 1.0),
    (VarName "y2",SymNum 2.0),
    (VarName "y3",SymNum 3.0),
    (Return,SymInt 6)
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt :: Map.Map SymStateKey SymExpr
elemAt = Map.fromList [
    (MethodName "elemAt",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["arr","pos"]),
    (VarAssignments,SVarAssignments []),
    (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
    (VarName "pos",SymVar SYT.Int "pos"),
    (ScopeRange (SR {branchStart = 1, branchEnd = 3}),
     SIte (SBin (SObjAcc ["arr","length"]) SYT.Le (SymVar SYT.Int "pos"))
          (SymState {
             env = Map.fromList [
               (MethodName "elemAt",SMethodType SYT.Int),
               (FormalParms,SFormalParms ["arr","pos"]),
               (VarName "arr",SymVar (SYT.Array SYT.Int) "arr"),
               (VarName "pos",SymVar SYT.Int "pos"),
               (Return,SException SYT.Int "Exception" "not found")
             ], pc = []})
          Nothing),
    (Return,SArrayIndexAccess "arr" (SymVar SYT.Int "pos"))
  ]

-----------------------------
-----------------------------
-----------------------------

elemAtCall :: Map.Map SymStateKey SymExpr
elemAtCall = Map.fromList [
    (MethodName "elemAtCall",SMethodType SYT.Int),
    (Return,SymInt 4)
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt2 :: Map.Map SymStateKey SymExpr
elemAt2 = Map.fromList [
    (MethodName "elemAt2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["pos"]),
    (VarBindings,SVarBindings (Map.fromList [
      ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [
      ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
    (VarName "arr",SymArray (Just SYT.Int) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (VarName "pos",SymVar SYT.Int "pos"),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),
     SIte (SBin (SymInt 5) SYT.Le (SymVar SYT.Int "pos"))
          (SymState {
             env = Map.fromList [
               (MethodName "elemAt2",SMethodType SYT.Int),
               (FormalParms,SFormalParms ["pos"]),
               (VarBindings,SVarBindings (Map.fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
               (VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
               (VarName "arr",SymArray (Just SYT.Int) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
               (VarName "pos",SymVar SYT.Int "pos"),
               (Return,SException SYT.Int "Exception" "not found")
             ], pc = []})
          Nothing),
    (Return,SArrayIndexAccess "arr" (SymVar SYT.Int "pos"))
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt2Call :: Map.Map SymStateKey SymExpr
elemAt2Call = Map.fromList [
    (MethodName "elemAt2Call",SMethodType SYT.Int),
    (Return,SymInt 4)
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt2Call2 :: Map.Map SymStateKey SymExpr
elemAt2Call2 = Map.fromList [
    (MethodName "elemAt2Call2",SMethodType SYT.Int),
    (Return,SException SYT.Int "Exception" "not found")
  ]

-----------------------------
-----------------------------
-----------------------------

elemAt4 :: Map.Map SymStateKey SymExpr
elemAt4 = Map.fromList [
    (MethodName "elemAt4",SMethodType SYT.Int),
    (VarBindings,SVarBindings (Map.fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),
    (VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
    (VarName "arr",SymArray (Just SYT.Int) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),
    (Return,SymInt 7)
  ]

-----------------------------
-----------------------------
-----------------------------

strFun :: Map.Map SymStateKey SymExpr
strFun = Map.fromList [
    (MethodName "strFun",SMethodType SYT.String),
    (VarBindings,SVarBindings (Map.fromList [("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),
    (VarAssignments,SVarAssignments [("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),
    (VarName "firstName",SymString "Tarek"),
    (VarName "lastName",SymString "Soliman"),
    (Return,SymString "Tarek Soliman")
  ]

-----------------------------
-----------------------------
-----------------------------

voidFun1 :: Map.Map SymStateKey SymExpr
voidFun1 = Map.fromList [
    (MethodName "voidFun1",SMethodType SYT.Void)
  ]

-----------------------------
-----------------------------
-----------------------------

voidFun2 :: Map.Map SymStateKey SymExpr
voidFun2 = Map.fromList [
    (MethodName "voidFun2",SMethodType SYT.Void)
  ]

-----------------------------
-----------------------------
-----------------------------

voidFun3 :: Map.Map SymStateKey SymExpr
voidFun3 = Map.fromList [
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
    (VarName "z",SymUnknown (SymVar SYT.String "z") [
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
  ]

-----------------------------
-----------------------------
-----------------------------

voidFun3Call :: Map.Map SymStateKey SymExpr
voidFun3Call = Map.fromList [
    (MethodName "voidFun3Call",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["y2","z"]),
    (VarName "y2",SymString "is not one"),
    (VarName "z",SymString "11 is not one"),
    (Actions,SActions [SymString "11 is not one\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs :: Map.Map SymStateKey SymExpr
manyArrs = Map.fromList [
    (MethodName "manyArrs",SMethodType SYT.Void),
    (VarBindings,SVarBindings (Map.fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 5}}),("numbers",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 5}})]),
    (VarName "numbers",SymArray (Just SYT.Int) (Just 2) [SymInt 99,SymInt 5]),
    (Actions,SActions [SymString "[99, 5]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs2 :: Map.Map SymStateKey SymExpr
manyArrs2 = Map.fromList [
    (MethodName "manyArrs2",SMethodType SYT.Void),
    (VarBindings,SVarBindings (Map.fromList [("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})])),
    (VarAssignments,SVarAssignments [("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 29}}),("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 11, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 15, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 16, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 17, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 18, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 19, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 20, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 21, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 22, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 23, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 24, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 25, varFrame = SR {branchStart = 0, branchEnd = 29}})]),
    (VarName "brand",SymArray (Just SYT.String) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),
    (VarName "numbers1",SymArray (Just SYT.Int) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]),
    (VarName "numbers2",SymArray (Just SYT.Int) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]),
    (VarName "numbers3",SymArray (Just SYT.Int) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]),
    (VarName "strs",SymArray (Just SYT.String) (Just 3) [SymNull SYT.String,SymString "meow",SymNull SYT.String]),
    (Actions,SActions [SymString "[86, 57, 80, 34, 50, 48, 94]\n",SymString "[51, 84, 92, 87, 81]\n",SymString "[5, 75, 34, 10, 6]\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs3 :: Map.Map SymStateKey SymExpr
manyArrs3 = Map.fromList [
    (MethodName "manyArrs3",SMethodType (SYT.Array SYT.Int)),
    (VarBindings,SVarBindings (Map.fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
    (VarName "numbers",SymArray (Just SYT.Int) (Just 2) [SymInt 99,SymInt 5]),
    (Return,SymArray (Just SYT.Int) (Just 2) [SymInt 99,SymInt 5])
  ]

-----------------------------
-----------------------------
-----------------------------

manyArrs4 :: Map.Map SymStateKey SymExpr
manyArrs4 = Map.fromList [
    (MethodName "manyArrs4",SMethodType SYT.Void),
    (VarBindings,SVarBindings (Map.fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),
    (VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})]),
    (VarName "numbers",SymArray (Just SYT.Int) (Just 2) [SymInt 99,SymNull SYT.Int]),
    (Actions,SActions [SymString "[99, 0]\n"])
  ]


-----------------------------
-----------------------------
-----------------------------

ifFun :: Map.Map SymStateKey SymExpr
ifFun = Map.fromList [
    (MethodName "ifFun",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun",SMethodType SYT.Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n")),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SymVar SYT.Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing),
    (Return,SBin (SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFunCall :: Map.Map SymStateKey SymExpr
ifFunCall = Map.fromList [
    (MethodName "ifFunCall",SMethodType SYT.Int),
    (Return,SymInt 8)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun2 :: Map.Map SymStateKey SymExpr
ifFun2 = Map.fromList [
    (MethodName "ifFun2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymVar SYT.Int "y") [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (VarName "y",SymVar SYT.Int "y"),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun2",SMethodType SYT.Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n")),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SBin (SymVar SYT.Int "y") SYT.Add (SymVar SYT.Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar SYT.Int "y")], pc = []}) Nothing),
    (Return,SBin (SymUnknown (SymVar SYT.Int "y") [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun2Call :: Map.Map SymStateKey SymExpr
ifFun2Call = Map.fromList [
    (MethodName "ifFun2Call",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymVar SYT.Int "y"),
    (Return,SBin (SymVar SYT.Int "y") SYT.Add (SymInt 11))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun2Call2 :: Map.Map SymStateKey SymExpr
ifFun2Call2 = Map.fromList [
    (MethodName "ifFun2Call2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymVar SYT.Int "y"),
    (Return,SBin (SymVar SYT.Int "y") SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun3 :: Map.Map SymStateKey SymExpr
ifFun3 = Map.fromList [
    (MethodName "ifFun3",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),
    (VarName "m",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),
    (VarName "x",SymInt 1),
    (VarName "y",SymVar SYT.UnknownNumSymType "y"),
    (ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar SYT.UnknownNumSymType "y") SYT.Ge (SymNum 0.0)) (SymState {env = Map.fromList [(MethodName "ifFun3",SMethodType SYT.Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n")),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SymVar SYT.Int "n"),(VarName "x",SymInt 1),(VarName "y",SymVar SYT.UnknownNumSymType "y")], pc = []}) Nothing),
    (Return,SBin (SymUnknown (SymInt 0) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun4 :: Map.Map SymStateKey SymExpr
ifFun4 = Map.fromList [
    (MethodName "ifFun4",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "y",SymUnknown (SymVar SYT.Int "y") [([(If,SR {branchStart = 1, branchEnd = 3})],2)]),
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
    (Return,SymUnknown (SymVar SYT.Int "y") [([(If,SR {branchStart = 1, branchEnd = 3})],2)])
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun5 :: Map.Map SymStateKey SymExpr
ifFun5 = Map.fromList [
    (MethodName "ifFun5",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "y",SymUnknown (SymVar SYT.Int "n") [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun5",SMethodType SYT.Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "y",SBin (SymInt 2) SYT.Mul (SymVar SYT.Int "n"))], pc = []}) Nothing),
    (Return,SymUnknown (SymVar SYT.Int "n") [([(If,SR {branchStart = 2, branchEnd = 4})],3)])]

-----------------------------
-----------------------------
-----------------------------

ifFun5Call1 :: Map.Map SymStateKey SymExpr
ifFun5Call1 = Map.fromList [
    (MethodName "ifFun5Call1",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymInt 20),
    (Return,SymInt 20)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun5Call2 :: Map.Map SymStateKey SymExpr
ifFun5Call2 = Map.fromList [
    (MethodName "ifFun5Call2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["y"]),
    (VarName "y",SymInt (-10)),
    (Return,SymInt (-10))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun6 :: Map.Map SymStateKey SymExpr
ifFun6 = Map.fromList [
    (MethodName "ifFun6",SMethodType SYT.String),
    (GlobalVars,SGlobalVars ["y","m","s","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}}),("s",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
    (VarName "c",SymVar SYT.String "c"),
    (VarName "m",SymUnknown (SymVar SYT.Int "m") [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "s",SymString "something"),
    (VarName "y",SymUnknown (SymVar SYT.UnknownNumSymType "y") [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 4}),SIte (SBin (SymVar SYT.UnknownNumSymType "y") SYT.Ge (SymNum 0.0)) (SymState {env = Map.fromList [(MethodName "ifFun6",SMethodType SYT.String),(GlobalVars,SGlobalVars ["y","m"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "m",SBin (SymVar SYT.Int "m") SYT.Add (SymVar SYT.Int "n")),(VarName "n",SymVar SYT.Int "n"),(VarName "y",SBin (SymNum (-1.0)) SYT.Mul (SymVar SYT.UnknownNumSymType "y"))], pc = []}) Nothing),
    (Return,SymVar SYT.String "c")
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun6Call :: Map.Map SymStateKey SymExpr
ifFun6Call = Map.fromList [
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
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun7 :: Map.Map SymStateKey SymExpr
ifFun7 = Map.fromList [
    (MethodName "ifFun7",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),
        ("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "w",SymUnknown (SymVar SYT.String "w") [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 4}),
        SIte
            (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0))
            (SymState {env = Map.fromList [(MethodName "ifFun7",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "v",SymString "hi")], pc = []})
            (Just (SymState {env = Map.fromList [(MethodName "ifFun7",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "w",SymString "bye")], pc = []})))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun7Call :: Map.Map SymStateKey SymExpr
ifFun7Call = Map.fromList [
    (MethodName "ifFun7Call",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v"]),
    (VarName "v",SymString "hi")
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun7Call2 :: Map.Map SymStateKey SymExpr
ifFun7Call2 = Map.fromList [
    (MethodName "ifFun7Call2",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye")
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun7Call3 :: Map.Map SymStateKey SymExpr
ifFun7Call3 = Map.fromList [
    (MethodName "ifFun7Call3",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["t","v","w"]),
    (VarName "t",SymVar SYT.Int "t"),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [
        ([(If,SR {branchStart = 1, branchEnd = 4})],2)]),
    (VarName "w",SymUnknown (SymVar SYT.String "w") [
        ([(If,SR {branchStart = 1, branchEnd = 4})],3)])]

-----------------------------
-----------------------------
-----------------------------

ifFun8 :: Map.Map SymStateKey SymExpr
ifFun8 = Map.fromList [
    (MethodName "ifFun8",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [([(If,SR {branchStart = 1, branchEnd = 6})],2)]),
    (VarName "w",SymUnknown (SymVar SYT.String "w") [([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),SIte (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun8",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "v",SymString "hi"),(Actions,SActions [SymString "hi\n"])], pc = []}) (Just (SymState {env = Map.fromList [(MethodName "ifFun8",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "w",SymString "bye"),(Actions,SActions [SymString "bye\n"])], pc = []})))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun8Call :: Map.Map SymStateKey SymExpr
ifFun8Call = Map.fromList [
    (MethodName "ifFun8Call",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (VarName "v",SymString "hi"),
    (VarName "w",SymString "bye"),
    (Actions,SActions [SymString "hi\n",SymString "bye\n",SymString "hi\n"])
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun9 :: Map.Map SymStateKey SymExpr
ifFun9 = Map.fromList [
    (MethodName "ifFun9",SMethodType SYT.Void),
    (GlobalVars,SGlobalVars ["v","w"]),
    (FormalParms,SFormalParms ["n"]),
    (VarAssignments,SVarAssignments [
        ("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),
        ("v",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}}),
        ("w",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "v",SymUnknown (SymVar SYT.String "v") [
        ([(If,SR {branchStart = 1, branchEnd = 6})],2),
        ([(If,SR {branchStart = 1, branchEnd = 6})],4)]),
    (VarName "w",SymUnknown (SymVar SYT.String "w") [
        ([(If,SR {branchStart = 1, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 1, branchEnd = 6}),
        SIte (SBin (SBin (SymVar SYT.Int "n") SYT.Mod (SymInt 2)) SYT.Eq (SymInt 0))
             (SymState {env = Map.fromList [(MethodName "ifFun9",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "v",SymString "hi zu"),(VarName "z",SymInt 3)], pc = []})
             (Just (SymState {env = Map.fromList [(MethodName "ifFun9",SMethodType SYT.Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "w",SymString "bye")], pc = []})))
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun10 :: Map.Map SymStateKey SymExpr
ifFun10 = Map.fromList [
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
    (VarName "v",SymUnknown (SymVar SYT.String "v") [
        ([(If,SR {branchStart = 2, branchEnd = 6})],3),
        ([(If,SR {branchStart = 2, branchEnd = 6})],5)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SIte (SBin (SymVar SYT.String "v") SYT.Eq (SymString "bye")) (SymState {env = Map.fromList [(MethodName "ifFun10",SMethodType SYT.Int),(GlobalVars,SGlobalVars ["v"]),(VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 9}}),("v",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "res",SymInt 1),(VarName "v",SymString "zuzu")], pc = []}) Nothing),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun11 :: Map.Map SymStateKey SymExpr
ifFun11 = Map.fromList [
    (MethodName "ifFun11",SMethodType SYT.Int),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})]),
    (VarName "res",SymInt 0),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

ifFun12 :: Map.Map SymStateKey SymExpr
ifFun12 = Map.fromList [
    (MethodName "ifFun12",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymInt 0) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar SYT.Int "n") SYT.Ge (SymInt 0)) (SymState {env = Map.fromList [(MethodName "ifFun12",SMethodType SYT.Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SymInt 1)], pc = []}) Nothing),
    (Return,SymUnknown (SymInt 0) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])]

-----------------------------
-----------------------------
-----------------------------

succFun :: Map.Map SymStateKey SymExpr
succFun = Map.fromList [
    (MethodName "succFun",SMethodType SYT.Void),
    (FormalParms,SFormalParms ["i"]),
    (VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),
    (VarName "i",SBin (SymVar SYT.Int "i") SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

callSuccFun :: Map.Map SymStateKey SymExpr
callSuccFun = Map.fromList [
    (MethodName "callSuccFun",SMethodType SYT.Int),
    (FormalParms,SFormalParms ["n"]),
    (VarName "n",SBin (SymVar SYT.Int "n") SYT.Add (SymInt 1)),
    (Return,SBin (SymVar SYT.Int "n") SYT.Add (SymInt 1))
  ]

-----------------------------
-----------------------------
-----------------------------

callCallSuccFun :: Map.Map SymStateKey SymExpr
callCallSuccFun = Map.fromList [
    (MethodName "callCallSuccFun",SMethodType SYT.Int),
    (Return,SymInt 6)
  ]

-----------------------------
-----------------------------
-----------------------------

wrongSum1 :: Map.Map SymStateKey SymExpr
wrongSum1 = Map.fromList [
    (MethodName "wrongSum1",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["w","t","c"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 13}}),("j",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 13}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 3, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 3, branchEnd = 12}}),("t",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 3, branchEnd = 12}}),("j",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 3, branchEnd = 12}})]),
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

wrongSum2 :: Map.Map SymStateKey SymExpr
wrongSum2 = Map.fromList [
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

wrongSum3 :: Map.Map SymStateKey SymExpr
wrongSum3 = Map.fromList [
    (MethodName "wrongSum3",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (VarName "t",SymUnknown (SymVar SYT.Int "t") [([(For,SR {branchStart = 2, branchEnd = 15})],13)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 15}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 2},Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}, assEright = NumberLiteral 9.0}}), parent = 2},Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 7, nodeData = BooleanExpression If (Just (BoolLiteral False)), parent = 2},Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 2},Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}), parent = 2},Node {id = 14, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)
  ]

-----------------------------
-----------------------------
-----------------------------

wrongSum4 :: Map.Map SymStateKey SymExpr
wrongSum4 = Map.fromList [
    (MethodName "wrongSum4",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars ["v","t"]),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 16}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}}),("v",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 7, branchEnd = 11}}),("res",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}}),("v",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 7, branchEnd = 11}}),("res",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}),("t",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 2, branchEnd = 15}})]),
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

wrongSum5 :: Map.Map SymStateKey SymExpr
wrongSum5 = Map.fromList [
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

for1 :: Map.Map SymStateKey SymExpr
for1 = Map.fromList [
    (MethodName "for1",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 6}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymInt 0),
    (ScopeRange (SR {branchStart = 2, branchEnd = 5}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymInt 0)]

-----------------------------
-----------------------------
-----------------------------

for2 :: Map.Map SymStateKey SymExpr
for2 = Map.fromList [
    (MethodName "for2",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),
    (VarAssignments,SVarAssignments [
        ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),
        ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),
        ("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),
    (VarName "n",SymVar SYT.Int "n"),
    (VarName "res",SymUnknown (SymInt 0) [
        ([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),
        ([(If,SR {branchStart = 9, branchEnd = 11})],10)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (ScopeRange (SR {branchStart = 9, branchEnd = 11}),SIte (SBin (SBin (SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) SYT.Mod (SymInt 3)) SYT.Eq (SymInt 0)) (SymState {env = Map.fromList [(MethodName "for2",SMethodType SYT.Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 12}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 6}}),("res",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 9, branchEnd = 11}})]),(VarName "n",SymVar SYT.Int "n"),(VarName "res",SBin (SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5)]) SYT.Mul (SymInt 3)),(ScopeRange (SR {branchStart = 2, branchEnd = 8}),SLoop (Just (Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0})) (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Mod, expr2 = NumberLiteral 2.0}, binOp = Eq, expr2 = NumberLiteral 0.0})), parent = 2},Node {id = 7, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}])], pc = []}) Nothing),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 8}),(If,SR {branchStart = 4, branchEnd = 6})],5),([(If,SR {branchStart = 9, branchEnd = 11})],10)])]

-----------------------------
-----------------------------
-----------------------------

sum1 :: Map.Map SymStateKey SymExpr
sum1 = Map.fromList [
    (MethodName "sum1",SMethodType SYT.Int),
    (GlobalVars,SGlobalVars []),
    (FormalParms,SFormalParms ["n"]),
    (VarBindings,SVarBindings (Map.fromList [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})])),
    (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("res",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 6}}),("n",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),
    (VarName "n",SymUnknown (SymVar SYT.Int "n") [([(For,SR {branchStart = 2, branchEnd = 6})],5)]),
    (VarName "res",SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 6})],4)]),
    (ScopeRange (SR {branchStart = 2, branchEnd = 6}),SLoop Nothing (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Greater, expr2 = NumberLiteral 0.0})) [Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = Plus, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2},Node {id = 5, nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "n"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = Minus, expr2 = NumberLiteral 1.0}}})), parent = 2}]),
    (Return,SymUnknown (SymInt 0) [([(For,SR {branchStart = 2, branchEnd = 6})],4)])]

-----------------------------
-----------------------------
-----------------------------
