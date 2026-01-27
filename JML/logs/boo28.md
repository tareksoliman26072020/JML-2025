================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo28" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo28

3. (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

4. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

5. (visitExpr -> VarExpr): New Variable BuiltInType Int i

6. (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

7. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

8. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

9. (visitExpr -> VarExpr): New Variable BuiltInType Int i

10. (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

11. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

12. (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

19. (visitExpr -> VarExpr): New Variable BuiltInType Int x

20. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

21. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

22. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

23. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

24. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

25. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

26. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

27. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

28. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

29. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})

30. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})

31. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

32. Next Node: Node {id = 2, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

33. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 2): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

34. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

35. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

36. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

37. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

38. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

39. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

40. (visitExpr -> BinOpExpr): Affected: SymVar Int "i", >=, SymNum 0.0

41. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Ge (SymInt 0))

42. if statement ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}

43. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

44. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}}

45. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}

46. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}

47. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

48. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

49. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

50. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}

51. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

52. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

53. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

54. if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

55. if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

56. if statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 1, +, SymNum 1.0

57. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 2)

58. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}, ER_Expr (SymInt 2)

59. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymInt 1
    New Value: SymInt 2

60. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 2)

61. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

62. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

63. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})

64. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

65. if statement ==> Next Node: End {id = 4, parent = 2, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

66. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

67. if statement ==> (visitNode -> End): Method End

68. if statement ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

69. if statement ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

70. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

71. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

72. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

73. if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

74. if statement ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

75. if statement ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

76. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 2,SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")], pc = []}) Nothing)

77. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")], pc = []}) Nothing)

78. Next Node: End {id = 6, parent = 0, mExpr = Just (NumberLiteral 5.0)}

>>>>>>>>>> visitNode <<<<<<<<<<

79. (visitNode -> End): Method End

80. (visitNode -> End -> return something): handling return expression: NumberLiteral 5.0

81. (visitStmt -> ReturnStmt): handling return expression: NumberLiteral 5.0

82. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

83. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

84. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 5)

85. (visitStmt -> ReturnStmt): Returning: ER_Expr (SymNum 5.0)

86. (visitNode -> End -> method returns): Returning: ER_Expr (SymNum 5.0)
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo28",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 5})],3)]),(ScopeRange (SR {branchStart = 2, branchEnd = 5}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")], pc = []}) Nothing),(Return,SymInt 5)], pc = []}