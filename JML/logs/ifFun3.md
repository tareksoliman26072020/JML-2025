================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "ifFun3" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFun3

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun3",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}

19. (visitExpr -> VarExpr): New Variable BuiltInType Int res

20. (visitExpr -> VarExpr): Modifying State: (res,SymNull Int)

21. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}

22. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

23. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

24. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

25. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "res"
    Old Value: SymNull Int
    New Value: SymInt 0

26. (visitExpr ==> AssignExpr): Modifying State: (VarName "res",SymInt 0)

27. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

28. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

29. (visitNode -> Node -> Statement): Adding Var Binding: ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

30. (visitNode -> Node -> Statement): Adding Var Assignment: ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

31. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

32. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

33. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}}

34. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}

35. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}

36. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}

37. (visitExpr -> VarExpr): New Variable BuiltInType Int m

38. (visitExpr -> VarExpr): Modifying State: (m,SymNull Int)

39. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymNull Int}

40. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

41. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

42. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

43. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "m"
    Old Value: SymNull Int
    New Value: SymInt 0

44. (visitExpr ==> AssignExpr): Modifying State: (VarName "m",SymInt 0)

45. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

46. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

47. (visitNode -> Node -> Statement): Adding Var Binding: ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

48. (visitNode -> Node -> Statement): Adding Var Assignment: ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

49. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

50. Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

51. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

52. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

53. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

54. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

55. (visitExpr -> VarExpr): New Variable BuiltInType Int x

56. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

57. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

58. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

59. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

60. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

61. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

62. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

63. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

64. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

65. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})

66. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})

67. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

68. Next Node: Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

69. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 4): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0}

70. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0}

71. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

72. (visitExpr -> VarExpr): Global Variable Detected: y 

73. (visitExpr -> VarExpr): Modifying State: (y,SymVar UnknownGlobalVarSymType "y")

74. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}

75. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

76. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

77. (castGlobalVar): Update Variable
    Var Name: y
    Old Value: SymVar UnknownGlobalVarSymType "y"
    New Value: SymVar UnknownNumSymType "y"

78. (visitExpr -> BinOpExpr): Affected: SymVar UnknownGlobalVarSymType "y", >=, SymNum 0.0

79. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0))

80. if statement ==> Next Node: Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 4}

81. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

82. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

83. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

84. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

85. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

86. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymInt 0) 

87. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

88. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

89. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

90. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymInt 0) 

91. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

92. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

93. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

94. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

95. if statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 0, +, SymVar Int "n"

96. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymVar Int "n")

97. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}, ER_Expr (SymVar Int "n")

98. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "res"
    Old Value: SymInt 0
    New Value: SymVar Int "n"

99. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "res",SymVar Int "n")

100. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "n"}

101. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "n"}

102. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})

103. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "n"}

104. if statement ==> Next Node: Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}}), parent = 4}

105. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

106. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}}

107. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

108. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

109. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

110. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (m ~~> SymInt 0) 

111. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

112. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

113. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

114. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (m ~~> SymInt 0) 

115. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

116. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

117. if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

118. if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

119. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

120. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

121. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

122. if statement ==> (visitExpr -> BinOpExpr): Affected: SymNum 2.0, *, SymVar Int "n"

123. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

124. if statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 0, +, SBin (SymInt 2) Mul (SymVar Int "n")

125. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

126. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}, ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

127. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "m"
    Old Value: SymInt 0
    New Value: SBin (SymInt 2) Mul (SymVar Int "n")

128. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "m",SBin (SymInt 2) Mul (SymVar Int "n"))

129. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

130. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

131. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})

132. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

133. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 4,SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun3",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1),(VarName "y",SymVar UnknownNumSymType "y")], pc = []}) Nothing)

134. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun3",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1),(VarName "y",SymVar UnknownNumSymType "y")], pc = []}) Nothing)

135. Next Node: End {id = 8, parent = 0, mExpr = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0})}

>>>>>>>>>> visitNode <<<<<<<<<<

136. (visitNode -> End): Method End

137. (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

138. (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

139. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

140. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

141. (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) 

142. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]}

143. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

144. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

145. (visitExpr -> BinOpExpr): Affected: SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)], +, SymNum 1.0

146. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

147. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

148. (visitStmt -> ReturnStmt): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

149. (visitNode -> End -> method returns): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFun3",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),(VarName "n",SymVar Int "n"),(VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),(VarName "x",SymInt 1),(VarName "y",SymVar UnknownNumSymType "y"),(ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun3",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1),(VarName "y",SymVar UnknownNumSymType "y")], pc = []}) Nothing),(Return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))], pc = []}