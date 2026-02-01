module Methods.JavaMethod (javaMethodInputs) where


-- when you add a method, add it also to
-- 1) `javaMethodInputs`
-- 2) `test.SymbolicExecution.TargetState`
-- 3) `allTargets` in `test.SymbolicExecution.TargetState`

javaMethodInputs :: [(String, String)]
javaMethodInputs = map (\(o,t) -> (o,t))
  [ ("ifFun7", ifFun7)
  , ("ifFun7Call", ifFun7Call)
  , ("ifFun7Call2", ifFun7Call2)
  , ("ifFun7Call3", ifFun7Call3)
  , ("ifFun8", ifFun8)
  , ("ifFun9", ifFun9)
  ]

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

{-
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
 (ScopeRange (SR {branchStart = 1, branchEnd = 6}),
     SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0))
          (SymState {env = fromList [(MethodName "ifFun9",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 6}}),("z",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 6}}),("v",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi zu"),(VarName "z",SymInt 3)], pc = []})
          (Just (SymState {env = fromList [(MethodName "ifFun9",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 1, branchEnd = 6}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))
]
 -}
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
