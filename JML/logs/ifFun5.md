================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "ifFun5" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFun5

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

19. (visitExpr -> VarExpr): Global Variable Detected: y 

20. (visitExpr -> VarExpr): Modifying State: (y,SymVar UnknownGlobalVarSymType "y")

21. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}

22. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

23. (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

24. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

25. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}, ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

26. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymVar UnknownGlobalVarSymType "y"
    New Value: SymVar Int "n"

27. (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SymVar Int "n")

28. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

29. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

30. (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})

31. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

32. Next Node: Node {id = 2, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

33. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 2): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0}

34. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0}

35. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

36. (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymVar Int "n") 

37. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

38. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

39. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

40. (visitExpr -> BinOpExpr): Affected: SymVar Int "n", >=, SymNum 0.0

41. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "n") Ge (SymInt 0))

42. if statement ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2}

43. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

44. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

45. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

46. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

47. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

48. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymVar Int "n") 

49. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

50. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

51. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

52. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymVar Int "n") 

53. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

54. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

55. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

56. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

57. if statement ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "n", +, SymVar Int "n"

58. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

59. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}, ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

60. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymVar Int "n"
    New Value: SBin (SymInt 2) Mul (SymVar Int "n")

61. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))

62. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

63. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

64. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})

65. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

66. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 2,SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing)

67. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing)

68. Next Node: End {id = 5, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "y"})}

>>>>>>>>>> visitNode <<<<<<<<<<

69. (visitNode -> End): Method End

70. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

71. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

72. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

73. (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]) 

74. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]}

75. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])

76. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]}

77. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),(ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing),(Return,SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])], pc = []}