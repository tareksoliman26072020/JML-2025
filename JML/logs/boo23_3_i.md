================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo23_3_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo23_3_i

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo23_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}]}}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}]}}}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}]}}}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}]}}}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

19. (visitExpr -> VarExpr): New Variable BuiltInType Int x

20. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

21. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

22. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}]}}

23. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

24. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

25. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}]}

26. formal: boo21_i ==> Next Node: Entry (BuiltInType Int) "boo21_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

27. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

28. formal: boo21_i ==> (visitNode -> Entry): Method Start: boo21_i

29. formal: boo21_i ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

30. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

31. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

32. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

33. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

34. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

35. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

36. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

37. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

38. formal: boo21_i ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

39. formal: boo21_i ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

40. formal: boo21_i ==> Next Node: End {id = 1, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

41. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

42. formal: boo21_i ==> (visitNode -> End): Method End

43. formal: boo21_i ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

44. formal: boo21_i ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

45. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

46. formal: boo21_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

47. formal: boo21_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

48. formal: boo21_i ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

49. formal: boo21_i ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

50. formal: boo21_i ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

51. Method Call formal SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}

52. SymExec of actual parameter: boo21_i(i+i) ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}

53. SymExec of actual parameter: boo21_i(i+i) ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

54. SymExec of actual parameter: boo21_i(i+i) ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

55. SymExec of actual parameter: boo21_i(i+i) ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

56. SymExec of actual parameter: boo21_i(i+i) ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

57. SymExec of actual parameter: boo21_i(i+i) ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

58. SymExec of actual parameter: boo21_i(i+i) ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

59. SymExec of actual parameter: boo21_i(i+i) ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", +, SymVar Int "i"

60. SymExec of actual parameter: boo21_i(i+i) ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "i"))

61. actual: boo21_i ==> Next symExpr (MethodName "boo21_i" ==> SMethodType Int) in Method Call: boo21_i

62. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

63. actual: boo21_i ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

64. actual: boo21_i ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo21_i",SMethodType Int)

65. actual: boo21_i ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo21_i", er_val = SMethodType Int}

66. actual: boo21_i ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo21_i

67. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

68. actual: boo21_i ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

69. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

70. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

71. actual: boo21_i ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo21_i

72. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

73. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

74. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

75. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "i"))

76. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SBin (SymInt 2) Mul (SymVar Int "i"))

77. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymInt 2) Mul (SymVar Int "i")}

78. actual: boo21_i ==> Next symExpr (Return ==> SymVar Int "i") in Method Call: boo21_i

79. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

80. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

81. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

82. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "i"))

83. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (Return,SBin (SymInt 2) Mul (SymVar Int "i"))

84. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SBin (SymInt 2) Mul (SymVar Int "i")}

85. Method Call actual SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SBin (SymInt 2) Mul (SymVar Int "i")),(Return,SBin (SymInt 2) Mul (SymVar Int "i"))], pc = []}

86. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SBin (SymInt 2) Mul (SymVar Int "i")),(Return,SBin (SymInt 2) Mul (SymVar Int "i"))], pc = []})

87. (visitExpr -> BinOpExpr): Affected: SymNum 3.0, +, SBin (SymInt 2) Mul (SymVar Int "i")

88. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i")))

89. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i")))

90. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i"))

91. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i")))

92. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i"))}

93. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i"))}

94. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

95. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

96. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i"))}

97. Next Node: End {id = 2, parent = 0, mExpr = Just (NumberLiteral 5.0)}

>>>>>>>>>> visitNode <<<<<<<<<<

98. (visitNode -> End): Method End

99. (visitNode -> End -> return something): handling return expression: NumberLiteral 5.0

100. (visitStmt -> ReturnStmt): handling return expression: NumberLiteral 5.0

101. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

102. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

103. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 5)

104. (visitStmt -> ReturnStmt): Returning: ER_Expr (SymNum 5.0)

105. (visitNode -> End -> method returns): Returning: ER_Expr (SymNum 5.0)
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo23_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SymVar Int "i"),(VarName "x",SBin (SymInt 3) Add (SBin (SymInt 2) Mul (SymVar Int "i"))),(Return,SymInt 5)], pc = []}