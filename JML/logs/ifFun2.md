================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "ifFun2" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFun2

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}

19. (visitExpr -> VarExpr): New Variable BuiltInType Int res

20. (visitExpr -> VarExpr): Modifying State: (res,SymNull Int)

21. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}

22. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

23. (visitExpr -> VarExpr): Global Variable Detected: y 

24. (visitExpr -> VarExpr): Modifying State: (y,SymVar UnknownGlobalVarSymType "y")

25. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}

26. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}, ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}

27. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "res"
    Old Value: SymNull Int
    New Value: SymVar Int "y"

28. (visitExpr ==> AssignExpr): Modifying State: (VarName "res",SymVar Int "y")

29. (castGlobalVar): Update Variable
    Var Name: y
    Old Value: SymVar UnknownGlobalVarSymType "y"
    New Value: SymVar Int "y"

30. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar UnknownGlobalVarSymType "y"}

31. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar UnknownGlobalVarSymType "y"}

32. (visitNode -> Node -> Statement): Adding Var Binding: ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

33. (visitNode -> Node -> Statement): Adding Var Assignment: ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

34. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar UnknownGlobalVarSymType "y"}

35. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

36. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}}

37. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}

38. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}

39. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}

40. (visitExpr -> VarExpr): New Variable BuiltInType Int m

41. (visitExpr -> VarExpr): Modifying State: (m,SymNull Int)

42. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymNull Int}

43. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

44. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

45. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

46. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "m"
    Old Value: SymNull Int
    New Value: SymInt 0

47. (visitExpr ==> AssignExpr): Modifying State: (VarName "m",SymInt 0)

48. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

49. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

50. (visitNode -> Node -> Statement): Adding Var Binding: ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

51. (visitNode -> Node -> Statement): Adding Var Assignment: ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

52. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

53. Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

54. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

55. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

56. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

57. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

58. (visitExpr -> VarExpr): New Variable BuiltInType Int x

59. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

60. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

61. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

62. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

63. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

64. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

65. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

66. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

67. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

68. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})

69. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})

70. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

71. Next Node: Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

72. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 4): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >=, expr2 = NumberLiteral 0.0}

73. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >=, expr2 = NumberLiteral 0.0}

74. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

75. (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

76. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

77. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

78. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

79. (visitExpr -> BinOpExpr): Affected: SymVar Int "n", >=, SymNum 0.0

80. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "n") Ge (SymInt 0))

81. if statement ==> Next Node: Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 4}

82. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

83. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

84. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

85. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

86. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

87. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymVar Int "y") 

88. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "y"}

89. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

90. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

91. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymVar Int "y") 

92. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "y"}

93. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

94. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

95. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

96. if statement ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "y", +, SymVar Int "n"

97. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "y") Add (SymVar Int "n"))

98. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "y"}, ER_Expr (SBin (SymVar Int "y") Add (SymVar Int "n"))

99. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "res"
    Old Value: SymVar Int "y"
    New Value: SBin (SymVar Int "y") Add (SymVar Int "n")

100. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n"))

101. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymVar Int "y") Add (SymVar Int "n")}

102. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymVar Int "y") Add (SymVar Int "n")}

103. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})

104. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymVar Int "y") Add (SymVar Int "n")}

105. if statement ==> Next Node: Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}}), parent = 4}

106. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

107. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}}

108. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

109. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

110. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

111. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (m ~~> SymInt 0) 

112. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

113. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

114. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

115. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (m ~~> SymInt 0) 

116. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

117. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

118. if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

119. if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

120. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

121. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

122. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

123. if statement ==> (visitExpr -> BinOpExpr): Affected: SymNum 2.0, *, SymVar Int "n"

124. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

125. if statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 0, +, SBin (SymInt 2) Mul (SymVar Int "n")

126. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

127. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}, ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

128. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "m"
    Old Value: SymInt 0
    New Value: SBin (SymInt 2) Mul (SymVar Int "n")

129. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "m",SBin (SymInt 2) Mul (SymVar Int "n"))

130. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

131. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

132. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})

133. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

134. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 4,SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing)

135. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing)

136. Next Node: End {id = 8, parent = 0, mExpr = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0})}

>>>>>>>>>> visitNode <<<<<<<<<<

137. (visitNode -> End): Method End

138. (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

139. (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

140. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

141. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

142. (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) 

143. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]}

144. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

145. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

146. (visitExpr -> BinOpExpr): Affected: SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)], +, SymNum 1.0

147. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

148. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

149. (visitStmt -> ReturnStmt): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

150. (visitNode -> End -> method returns): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),(VarName "n",SymVar Int "n"),(VarName "res",SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y"),(ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing),(Return,SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))], pc = []}