================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "ifFun2Call" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFun2Call

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun2Call",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun2"}, funArgs = [NumberLiteral 10.0]})}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun2"}, funArgs = [NumberLiteral 10.0]}

8. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun2"}, funArgs = [NumberLiteral 10.0]}

9. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun2"}, funArgs = [NumberLiteral 10.0]}

10. formal: ifFun2 ==> Next Node: Entry (BuiltInType Int) "ifFun2" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

11. formal: ifFun2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

12. formal: ifFun2 ==> (visitNode -> Entry): Method Start: ifFun2

13. formal: ifFun2 ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

14. formal: ifFun2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

15. formal: ifFun2 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int n

16. formal: ifFun2 ==> (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

17. formal: ifFun2 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

18. formal: ifFun2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

19. formal: ifFun2 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int n

20. formal: ifFun2 ==> (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

21. formal: ifFun2 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

22. formal: ifFun2 ==> (visitNode -> Entry -> method with args): Modifying State: (n,SymVar Int "n")

23. formal: ifFun2 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

24. formal: ifFun2 ==> Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}), parent = 0}

25. formal: ifFun2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

26. formal: ifFun2 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}

27. formal: ifFun2 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

28. formal: ifFun2 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

29. formal: ifFun2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}

30. formal: ifFun2 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int res

31. formal: ifFun2 ==> (visitExpr -> VarExpr): Modifying State: (res,SymNull Int)

32. formal: ifFun2 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}

33. formal: ifFun2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

34. formal: ifFun2 ==> (visitExpr -> VarExpr): Global Variable Detected: y 

35. formal: ifFun2 ==> (visitExpr -> VarExpr): Modifying State: (y,SymVar UnknownGlobalVarSymType "y")

36. formal: ifFun2 ==> (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}

37. formal: ifFun2 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}, ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}

38. formal: ifFun2 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "res"
    Old Value: SymNull Int
    New Value: SymVar Int "y"

39. formal: ifFun2 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "res",SymVar Int "y")

40. formal: ifFun2 ==> (castGlobalVar): Update Variable
    Var Name: y
    Old Value: SymVar UnknownGlobalVarSymType "y"
    New Value: SymVar Int "y"

41. formal: ifFun2 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar UnknownGlobalVarSymType "y"}

42. formal: ifFun2 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar UnknownGlobalVarSymType "y"}

43. formal: ifFun2 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

44. formal: ifFun2 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

45. formal: ifFun2 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar UnknownGlobalVarSymType "y"}

46. formal: ifFun2 ==> Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}}), parent = 0}

47. formal: ifFun2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

48. formal: ifFun2 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}}

49. formal: ifFun2 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}

50. formal: ifFun2 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}

51. formal: ifFun2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}

52. formal: ifFun2 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int m

53. formal: ifFun2 ==> (visitExpr -> VarExpr): Modifying State: (m,SymNull Int)

54. formal: ifFun2 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymNull Int}

55. formal: ifFun2 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

56. formal: ifFun2 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

57. formal: ifFun2 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

58. formal: ifFun2 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "m"
    Old Value: SymNull Int
    New Value: SymInt 0

59. formal: ifFun2 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "m",SymInt 0)

60. formal: ifFun2 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

61. formal: ifFun2 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

62. formal: ifFun2 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

63. formal: ifFun2 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

64. formal: ifFun2 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

65. formal: ifFun2 ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

66. formal: ifFun2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

67. formal: ifFun2 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

68. formal: ifFun2 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

69. formal: ifFun2 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

70. formal: ifFun2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

71. formal: ifFun2 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int x

72. formal: ifFun2 ==> (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

73. formal: ifFun2 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

74. formal: ifFun2 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

75. formal: ifFun2 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

76. formal: ifFun2 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

77. formal: ifFun2 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

78. formal: ifFun2 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

79. formal: ifFun2 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

80. formal: ifFun2 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

81. formal: ifFun2 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})

82. formal: ifFun2 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})

83. formal: ifFun2 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

84. formal: ifFun2 ==> Next Node: Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

85. formal: ifFun2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

86. formal: ifFun2 ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 4): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >=, expr2 = NumberLiteral 0.0}

87. formal: ifFun2 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >=, expr2 = NumberLiteral 0.0}

88. formal: ifFun2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

89. formal: ifFun2 ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

90. formal: ifFun2 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

91. formal: ifFun2 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

92. formal: ifFun2 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

93. formal: ifFun2 ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "n", >=, SymNum 0.0

94. formal: ifFun2 ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "n") Ge (SymInt 0))

95. formal: ifFun2 ==> if statement ==> Next Node: Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 4}

96. formal: ifFun2 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

97. formal: ifFun2 ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

98. formal: ifFun2 ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

99. formal: ifFun2 ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

100. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

101. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymVar Int "y") 

102. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "y"}

103. formal: ifFun2 ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

104. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

105. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymVar Int "y") 

106. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "y"}

107. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

108. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

109. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

110. formal: ifFun2 ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "y", +, SymVar Int "n"

111. formal: ifFun2 ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "y") Add (SymVar Int "n"))

112. formal: ifFun2 ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "y"}, ER_Expr (SBin (SymVar Int "y") Add (SymVar Int "n"))

113. formal: ifFun2 ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "res"
    Old Value: SymVar Int "y"
    New Value: SBin (SymVar Int "y") Add (SymVar Int "n")

114. formal: ifFun2 ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n"))

115. formal: ifFun2 ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymVar Int "y") Add (SymVar Int "n")}

116. formal: ifFun2 ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymVar Int "y") Add (SymVar Int "n")}

117. formal: ifFun2 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})

118. formal: ifFun2 ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymVar Int "y") Add (SymVar Int "n")}

119. formal: ifFun2 ==> if statement ==> Next Node: Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}}), parent = 4}

120. formal: ifFun2 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

121. formal: ifFun2 ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}}

122. formal: ifFun2 ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

123. formal: ifFun2 ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

124. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

125. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (m ~~> SymInt 0) 

126. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

127. formal: ifFun2 ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

128. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

129. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (m ~~> SymInt 0) 

130. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

131. formal: ifFun2 ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

132. formal: ifFun2 ==> if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

133. formal: ifFun2 ==> if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

134. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

135. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

136. formal: ifFun2 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

137. formal: ifFun2 ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymNum 2.0, *, SymVar Int "n"

138. formal: ifFun2 ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

139. formal: ifFun2 ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 0, +, SBin (SymInt 2) Mul (SymVar Int "n")

140. formal: ifFun2 ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

141. formal: ifFun2 ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}, ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

142. formal: ifFun2 ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "m"
    Old Value: SymInt 0
    New Value: SBin (SymInt 2) Mul (SymVar Int "n")

143. formal: ifFun2 ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "m",SBin (SymInt 2) Mul (SymVar Int "n"))

144. formal: ifFun2 ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

145. formal: ifFun2 ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

146. formal: ifFun2 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})

147. formal: ifFun2 ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

148. formal: ifFun2 ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 4,SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing)

149. formal: ifFun2 ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing)

150. formal: ifFun2 ==> Next Node: End {id = 8, parent = 0, mExpr = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0})}

151. formal: ifFun2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

152. formal: ifFun2 ==> (visitNode -> End): Method End

153. formal: ifFun2 ==> (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

154. formal: ifFun2 ==> (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

155. formal: ifFun2 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

156. formal: ifFun2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

157. formal: ifFun2 ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) 

158. formal: ifFun2 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]}

159. formal: ifFun2 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

160. formal: ifFun2 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

161. formal: ifFun2 ==> (visitExpr -> BinOpExpr): Affected: SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)], +, SymNum 1.0

162. formal: ifFun2 ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

163. formal: ifFun2 ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

164. formal: ifFun2 ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

165. formal: ifFun2 ==> (visitNode -> End -> method returns): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

166. Method Call formal SymState: SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),(VarName "n",SymVar Int "n"),(VarName "res",SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y"),(ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing),(Return,SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))], pc = []}

167. SymExec of actual parameter: ifFun2(10.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 10.0

168. SymExec of actual parameter: ifFun2(10.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 10.0)

169. (visitExpr -> FunCallExpr -> inheriting global vars list): Modifying State: (GlobalVars,["y"])

170. (visitExpr -> FunCallExpr -> inheriting global vars varnames): Modifying State: (VarNames,fromList [(VarName "y",SymVar Int "y")])

171. actual: ifFun2 ==> Next symExpr (MethodName "ifFun2" ==> SMethodType Int) in Method Call: ifFun2

172. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

173. actual: ifFun2 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

174. actual: ifFun2 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "ifFun2",SMethodType Int)

175. actual: ifFun2 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "ifFun2", er_val = SMethodType Int}

176. actual: ifFun2 ==> Next symExpr (GlobalVars ==> SGlobalVars ["y"]) in Method Call: ifFun2

177. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

178. actual: ifFun2 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars ["y"]

179. actual: ifFun2 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars ["y"])

180. actual: ifFun2 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars ["y"]}

181. actual: ifFun2 ==> Next symExpr (FormalParms ==> SFormalParms ["n"]) in Method Call: ifFun2

182. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

183. actual: ifFun2 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["n"]

184. actual: ifFun2 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["n"])

185. actual: ifFun2 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["n"]}

186. actual: ifFun2 ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])) in Method Call: ifFun2

187. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

188. actual: ifFun2 ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])

189. actual: ifFun2 ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})]))

190. actual: ifFun2 ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])}

191. actual: ifFun2 ==> Next symExpr (VarAssignments ==> SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]) in Method Call: ifFun2

192. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

193. actual: ifFun2 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]

194. actual: ifFun2 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})])

195. actual: ifFun2 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]}

196. actual: ifFun2 ==> Next symExpr (VarName "m" ==> SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]) in Method Call: ifFun2

197. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

198. actual: ifFun2 ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]

199. actual: ifFun2 ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)])

200. actual: ifFun2 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]

201. actual: ifFun2 ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName m"

202. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

203. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

204. actual: ifFun2 ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymInt 0)

205. actual: ifFun2 ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

206. actual: ifFun2 ==> Next symExpr (VarName "n" ==> SymVar Int "n") in Method Call: ifFun2

207. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

208. actual: ifFun2 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

209. actual: ifFun2 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

210. actual: ifFun2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

211. actual: ifFun2 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "n",SymInt 10)

212. actual: ifFun2 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymInt 10}

213. actual: ifFun2 ==> Next symExpr (VarName "res" ==> SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) in Method Call: ifFun2

214. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

215. actual: ifFun2 ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]

216. actual: ifFun2 ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "res",SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)])

217. actual: ifFun2 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]

218. actual: ifFun2 ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName res"

219. actual: ifFun2 ==> (visitSymExpr0 -> SymVar -> Global Variable): handling SymExpr: SymVar Int "y"

220. actual: ifFun2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymVar Int "y")

221. actual: ifFun2 ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymVar Int "y")

222. actual: ifFun2 ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "y"}

223. actual: ifFun2 ==> Next symExpr (VarName "x" ==> SymInt 1) in Method Call: ifFun2

224. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

225. actual: ifFun2 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 1

226. actual: ifFun2 ==> (visitSymExpr -> SymInt): Modifying State: (VarName "x",SymInt 1)

227. actual: ifFun2 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

228. actual: ifFun2 ==> Next symExpr (VarName "y" ==> SymVar Int "y") in Method Call: ifFun2

229. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

230. actual: ifFun2 ==> (visitSymExpr -> SymVar -> Global Variable): handling SymExpr: SymVar Int "y"

231. actual: ifFun2 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "y"}

232. actual: ifFun2 ==> Next symExpr (ScopeRange (SR {branchStart = 4, branchEnd = 7}) ==> SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing) in Method Call: ifFun2

233. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

234. actual: ifFun2 ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SBin (SymVar Int "y") Add (SymVar Int "n")),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}) Nothing

235. actual: ifFun2 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "n") Ge (SymInt 0)

SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 0),(VarName "n",SymInt 10),(VarName "res",SymVar Int "y"),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}

236. actual: ifFun2 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

237. actual: ifFun2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

238. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

239. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

240. actual: ifFun2 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool True)

241. actual: ifFun2 ==> Next symExpr (MethodName "ifFun2" ==> SMethodType Int) in Method Call: ifFun2

242. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

243. actual: ifFun2 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

244. actual: ifFun2 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "ifFun2",SMethodType Int)

245. actual: ifFun2 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "ifFun2", er_val = SMethodType Int}

246. actual: ifFun2 ==> Next symExpr (GlobalVars ==> SGlobalVars ["y"]) in Method Call: ifFun2

247. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

248. actual: ifFun2 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars ["y"]

249. actual: ifFun2 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars ["y"])

250. actual: ifFun2 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars ["y"]}

251. actual: ifFun2 ==> Next symExpr (FormalParms ==> SFormalParms ["n"]) in Method Call: ifFun2

252. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

253. actual: ifFun2 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["n"]

254. actual: ifFun2 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["n"])

255. actual: ifFun2 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["n"]}

256. actual: ifFun2 ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])) in Method Call: ifFun2

257. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

258. actual: ifFun2 ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])

259. actual: ifFun2 ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})]))

260. actual: ifFun2 ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])}

261. actual: ifFun2 ==> Next symExpr (VarAssignments ==> SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]) in Method Call: ifFun2

262. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

263. actual: ifFun2 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]

264. actual: ifFun2 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})])

265. actual: ifFun2 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]}

266. actual: ifFun2 ==> Next symExpr (VarName "m" ==> SBin (SymInt 2) Mul (SymVar Int "n")) in Method Call: ifFun2

267. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

268. actual: ifFun2 ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymInt 2) Mul (SymVar Int "n")

269. actual: ifFun2 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymInt 2) Mul (SymVar Int "n")

SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})])], pc = []}

270. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 2

271. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 2)

272. actual: ifFun2 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

273. actual: ifFun2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

274. actual: ifFun2 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SymInt 20)

275. actual: ifFun2 ==> (visitSymExpr -> SBin): Modifying State: (VarName "m",SymInt 20)

276. actual: ifFun2 ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 20}

277. actual: ifFun2 ==> Next symExpr (VarName "n" ==> SymVar Int "n") in Method Call: ifFun2

278. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

279. actual: ifFun2 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

280. actual: ifFun2 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

281. actual: ifFun2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

282. actual: ifFun2 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "n",SymInt 10)

283. actual: ifFun2 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymInt 10}

284. actual: ifFun2 ==> Next symExpr (VarName "res" ==> SBin (SymVar Int "y") Add (SymVar Int "n")) in Method Call: ifFun2

285. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

286. actual: ifFun2 ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymVar Int "y") Add (SymVar Int "n")

287. actual: ifFun2 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "y") Add (SymVar Int "n")

SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 20),(VarName "n",SymInt 10)], pc = []}

288. actual: ifFun2 ==> (visitSymExpr0 -> SymVar -> Global Variable): handling SymExpr: SymVar Int "y"

289. actual: ifFun2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymVar Int "y")

290. actual: ifFun2 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

291. actual: ifFun2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

292. actual: ifFun2 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBin (SymVar Int "y") Add (SymInt 10))

293. actual: ifFun2 ==> (visitSymExpr -> SBin): Modifying State: (VarName "res",SBin (SymVar Int "y") Add (SymInt 10))

294. actual: ifFun2 ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymVar Int "y") Add (SymInt 10)}

295. actual: ifFun2 ==> Next symExpr (VarName "x" ==> SymInt 1) in Method Call: ifFun2

296. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

297. actual: ifFun2 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 1

298. actual: ifFun2 ==> (visitSymExpr -> SymInt): Modifying State: (VarName "x",SymInt 1)

299. actual: ifFun2 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

300. actual: ifFun2 ==> Next symExpr (VarName "y" ==> SymVar Int "y") in Method Call: ifFun2

301. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

302. actual: ifFun2 ==> (visitSymExpr -> SymVar -> Global Variable): handling SymExpr: SymVar Int "y"

303. actual: ifFun2 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "y"}

304. actual: ifFun2 ==> (visitSymExpr -> SIte -> resolved condition is True -> else body exists): Modifying State: (<no key>,<whole state is updated>: SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 20),(VarName "n",SymInt 10),(VarName "res",SBin (SymVar Int "y") Add (SymInt 10)),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []})

305. actual: ifFun2 ==> Next symExpr (Return ==> SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1)) in Method Call: ifFun2

306. actual: ifFun2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

307. actual: ifFun2 ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1)

308. actual: ifFun2 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1)

SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 20),(VarName "n",SymInt 10),(VarName "res",SBin (SymVar Int "y") Add (SymInt 10)),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}

309. actual: ifFun2 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"res",Just (SymVar Int "y")) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]

310. actual: ifFun2 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "y") Add (SymInt 10)

SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 20),(VarName "n",SymInt 10),(VarName "res",SBin (SymVar Int "y") Add (SymInt 10)),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y")], pc = []}

311. actual: ifFun2 ==> (visitSymExpr0 -> SymVar -> Global Variable): handling SymExpr: SymVar Int "y"

312. actual: ifFun2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymVar Int "y")

313. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 10

314. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 10)

315. actual: ifFun2 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBin (SymVar Int "y") Add (SymInt 10))

316. actual: ifFun2 ==> (visitSymExpr0 -> SymUnknown Just): Returning: ER_Expr (SBin (SymVar Int "y") Add (SymInt 10))

317. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 1

318. actual: ifFun2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 1)

319. actual: ifFun2 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBin (SymVar Int "y") Add (SymInt 11))

320. actual: ifFun2 ==> (visitSymExpr -> SBin): Modifying State: (Return,SBin (SymVar Int "y") Add (SymInt 11))

321. actual: ifFun2 ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SBin (SymVar Int "y") Add (SymInt 11)}

322. Method Call actual SymState: SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 20),(VarName "n",SymInt 10),(VarName "res",SBin (SymVar Int "y") Add (SymInt 10)),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y"),(Return,SBin (SymVar Int "y") Add (SymInt 11))], pc = []}

323. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 20),(VarName "n",SymInt 10),(VarName "res",SBin (SymVar Int "y") Add (SymInt 10)),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y"),(Return,SBin (SymVar Int "y") Add (SymInt 11))], pc = []})

324. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymVar Int "y") Add (SymInt 11))

325. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 20),(VarName "n",SymInt 10),(VarName "res",SBin (SymVar Int "y") Add (SymInt 10)),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y"),(Return,SBin (SymVar Int "y") Add (SymInt 11))], pc = []})

326. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "ifFun2",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 20),(VarName "n",SymInt 10),(VarName "res",SBin (SymVar Int "y") Add (SymInt 10)),(VarName "x",SymInt 1),(VarName "y",SymVar Int "y"),(Return,SBin (SymVar Int "y") Add (SymInt 11))], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFun2Call",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(VarName "y",SymVar Int "y"),(Return,SBin (SymVar Int "y") Add (SymInt 11))], pc = []}