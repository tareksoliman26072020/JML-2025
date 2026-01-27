================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Void) "ifFun7" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFun7

3. (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

4. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

5. (visitExpr -> VarExpr): New Variable BuiltInType Int n

6. (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

7. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

8. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

9. (visitExpr -> VarExpr): New Variable BuiltInType Int n

10. (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

11. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

12. (visitNode -> Entry -> method with args): Modifying State: (n,SymVar Int "n")

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

14. Next Node: Node {id = 1, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 1): If condition: BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0}

16. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0}

17. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = %, expr2 = NumberLiteral 2.0}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

19. (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

20. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

21. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

22. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

23. (visitExpr -> BinOpExpr): Affected: SymVar Int "n", %, SymNum 2.0

24. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "n") Mod (SymInt 2))

25. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

26. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

27. (visitExpr -> BinOpExpr): Affected: SBin (SymVar Int "n") Mod (SymInt 2), ==, SymNum 0.0

28. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0))

29. if statement ==> Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "v"}, assEright = StringLiteral "hi"}}), parent = 1}

30. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

31. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "v"}, assEright = StringLiteral "hi"}}

32. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "v"}, assEright = StringLiteral "hi"}

33. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "v"}, assEright = StringLiteral "hi"}

34. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "v"}

35. if statement ==> (visitExpr -> VarExpr): Global Variable Detected: v 

36. if statement ==> (visitExpr -> VarExpr): Modifying State: (v,SymVar UnknownGlobalVarSymType "v")

37. if statement ==> (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymVar UnknownGlobalVarSymType "v"}

38. if statement ==> (visitExpr -> StringLiteral): handling expression: StringLiteral "hi"

39. if statement ==> (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "hi")

40. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymVar UnknownGlobalVarSymType "v"}, ER_Expr (SymString "hi")

41. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "v"
    Old Value: SymVar UnknownGlobalVarSymType "v"
    New Value: SymString "hi"

42. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "v",SymString "hi")

43. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymString "hi"}

44. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymString "hi"}

45. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})

46. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymString "hi"}

47. else statement ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "w"}, assEright = StringLiteral "bye"}}), parent = 1}

48. else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

49. else statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "w"}, assEright = StringLiteral "bye"}}

50. else statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "w"}, assEright = StringLiteral "bye"}

51. else statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "w"}, assEright = StringLiteral "bye"}

52. else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "w"}

53. else statement ==> (visitExpr -> VarExpr): Global Variable Detected: w 

54. else statement ==> (visitExpr -> VarExpr): Modifying State: (w,SymVar UnknownGlobalVarSymType "w")

55. else statement ==> (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymVar UnknownGlobalVarSymType "w"}

56. else statement ==> (visitExpr -> StringLiteral): handling expression: StringLiteral "bye"

57. else statement ==> (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "bye")

58. else statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymVar UnknownGlobalVarSymType "w"}, ER_Expr (SymString "bye")

59. else statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "w"
    Old Value: SymVar UnknownGlobalVarSymType "w"
    New Value: SymString "bye"

60. else statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "w",SymString "bye")

61. else statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymString "bye"}

62. else statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymString "bye"}

63. else statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})

64. else statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymString "bye"}

65. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 1,SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))

66. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))

67. Next Node: End {id = 5, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

68. (visitNode -> End): Method End

69. (visitNode -> End -> return nothing): Void

70. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v","w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),(VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),(ScopeRange (SR {branchStart = 1, branchEnd = 4}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v","w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),(VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),(ScopeRange (SR {branchStart = 1, branchEnd = 4}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))], pc = []}