================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo23_9_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo23_9_i

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo23_9_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}}

16. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

17. (visitExpr -> VarExpr): New Variable BuiltInType Int x

18. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

19. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

20. (visitStmt -> VarStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

21. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

22. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

23. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}]}}, binOp = -, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

24. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}]}}, binOp = -, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}

25. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}]}}, binOp = -, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

26. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}]}}, binOp = -, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

27. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

28. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymNull Int) 

29. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

30. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}]}}, binOp = -, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}

31. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}]}}

32. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

33. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

34. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}]}

35. formal: boo21_i ==> Next Node: Entry (BuiltInType Int) "boo21_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

36. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

37. formal: boo21_i ==> (visitNode -> Entry): Method Start: boo21_i

38. formal: boo21_i ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

39. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

40. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

41. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

42. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

43. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

44. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

45. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

46. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

47. formal: boo21_i ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

48. formal: boo21_i ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

49. formal: boo21_i ==> Next Node: End {id = 1, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

50. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

51. formal: boo21_i ==> (visitNode -> End): Method End

52. formal: boo21_i ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

53. formal: boo21_i ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

54. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

55. formal: boo21_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

56. formal: boo21_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

57. formal: boo21_i ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

58. formal: boo21_i ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

59. formal: boo21_i ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

60. Method Call formal SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}

61. SymExec of actual parameter: boo21_i(i+2.0) ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}

62. SymExec of actual parameter: boo21_i(i+2.0) ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

63. SymExec of actual parameter: boo21_i(i+2.0) ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

64. SymExec of actual parameter: boo21_i(i+2.0) ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

65. SymExec of actual parameter: boo21_i(i+2.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

66. SymExec of actual parameter: boo21_i(i+2.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

67. SymExec of actual parameter: boo21_i(i+2.0) ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", +, SymNum 2.0

68. SymExec of actual parameter: boo21_i(i+2.0) ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

69. actual: boo21_i ==> Next symExpr (MethodName "boo21_i" ==> SMethodType Int) in Method Call: boo21_i

70. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

71. actual: boo21_i ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

72. actual: boo21_i ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo21_i",SMethodType Int)

73. actual: boo21_i ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo21_i", er_val = SMethodType Int}

74. actual: boo21_i ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo21_i

75. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

76. actual: boo21_i ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

77. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

78. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

79. actual: boo21_i ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo21_i

80. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

81. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

82. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

83. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

84. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SBin (SymVar Int "i") Add (SymInt 2))

85. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

86. actual: boo21_i ==> Next symExpr (Return ==> SymVar Int "i") in Method Call: boo21_i

87. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

88. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

89. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

90. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

91. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (Return,SBin (SymVar Int "i") Add (SymInt 2))

92. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SBin (SymVar Int "i") Add (SymInt 2)}

93. Method Call actual SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []}

94. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []})

95. (visitExpr -> BinOpExpr): Affected: SymNum 3.0, +, SBin (SymVar Int "i") Add (SymInt 2)

96. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 5) Add (SymVar Int "i"))

97. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

98. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

99. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

100. (visitExpr -> BinOpExpr): Affected: SBin (SymInt 5) Add (SymVar Int "i"), -, SymVar Int "i"

101. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 5)

102. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymInt 5)

103. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 5

104. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 5)

105. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 5}

106. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 5}

107. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})

108. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 5}

109. Next Node: End {id = 3, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}

>>>>>>>>>> visitNode <<<<<<<<<<

110. (visitNode -> End): Method End

111. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

112. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

113. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

114. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 5) 

115. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 5}

116. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 5)

117. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 5}

118. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 5}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo23_9_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 5),(Return,SymInt 5)], pc = []}