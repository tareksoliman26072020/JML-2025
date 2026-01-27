================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "ifFunCall" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFunCall

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFunCall",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (BinOpExpr {expr1 = NumberLiteral 4.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun"}, funArgs = [NumberLiteral 3.0]}})}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = NumberLiteral 4.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun"}, funArgs = [NumberLiteral 3.0]}}

8. (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = NumberLiteral 4.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun"}, funArgs = [NumberLiteral 3.0]}}

9. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 4.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun"}, funArgs = [NumberLiteral 3.0]}}

10. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

11. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

12. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun"}, funArgs = [NumberLiteral 3.0]}

13. formal: ifFun ==> Next Node: Entry (BuiltInType Int) "ifFun" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

14. formal: ifFun ==> >>>>>>>>>> visitNode <<<<<<<<<<

15. formal: ifFun ==> (visitNode -> Entry): Method Start: ifFun

16. formal: ifFun ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

17. formal: ifFun ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

18. formal: ifFun ==> (visitExpr -> VarExpr): New Variable BuiltInType Int n

19. formal: ifFun ==> (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

20. formal: ifFun ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

21. formal: ifFun ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

22. formal: ifFun ==> (visitExpr -> VarExpr): New Variable BuiltInType Int n

23. formal: ifFun ==> (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

24. formal: ifFun ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

25. formal: ifFun ==> (visitNode -> Entry -> method with args): Modifying State: (n,SymVar Int "n")

26. formal: ifFun ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

27. formal: ifFun ==> Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}), parent = 0}

28. formal: ifFun ==> >>>>>>>>>> visitNode <<<<<<<<<<

29. formal: ifFun ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}}

30. formal: ifFun ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}

31. formal: ifFun ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = NumberLiteral 0.0}

32. formal: ifFun ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}

33. formal: ifFun ==> (visitExpr -> VarExpr): New Variable BuiltInType Int res

34. formal: ifFun ==> (visitExpr -> VarExpr): Modifying State: (res,SymNull Int)

35. formal: ifFun ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}

36. formal: ifFun ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

37. formal: ifFun ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

38. formal: ifFun ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

39. formal: ifFun ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "res"
    Old Value: SymNull Int
    New Value: SymInt 0

40. formal: ifFun ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "res",SymInt 0)

41. formal: ifFun ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

42. formal: ifFun ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

43. formal: ifFun ==> (visitNode -> Node -> Statement): Adding Var Binding: ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

44. formal: ifFun ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

45. formal: ifFun ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

46. formal: ifFun ==> Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}}), parent = 0}

47. formal: ifFun ==> >>>>>>>>>> visitNode <<<<<<<<<<

48. formal: ifFun ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}}

49. formal: ifFun ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}

50. formal: ifFun ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}, assEright = NumberLiteral 0.0}

51. formal: ifFun ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "m"}

52. formal: ifFun ==> (visitExpr -> VarExpr): New Variable BuiltInType Int m

53. formal: ifFun ==> (visitExpr -> VarExpr): Modifying State: (m,SymNull Int)

54. formal: ifFun ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymNull Int}

55. formal: ifFun ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

56. formal: ifFun ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

57. formal: ifFun ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

58. formal: ifFun ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "m"
    Old Value: SymNull Int
    New Value: SymInt 0

59. formal: ifFun ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "m",SymInt 0)

60. formal: ifFun ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

61. formal: ifFun ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

62. formal: ifFun ==> (visitNode -> Node -> Statement): Adding Var Binding: ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

63. formal: ifFun ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

64. formal: ifFun ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

65. formal: ifFun ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

66. formal: ifFun ==> >>>>>>>>>> visitNode <<<<<<<<<<

67. formal: ifFun ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

68. formal: ifFun ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

69. formal: ifFun ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

70. formal: ifFun ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

71. formal: ifFun ==> (visitExpr -> VarExpr): New Variable BuiltInType Int x

72. formal: ifFun ==> (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

73. formal: ifFun ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

74. formal: ifFun ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

75. formal: ifFun ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

76. formal: ifFun ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

77. formal: ifFun ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

78. formal: ifFun ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

79. formal: ifFun ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

80. formal: ifFun ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

81. formal: ifFun ==> (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})

82. formal: ifFun ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})

83. formal: ifFun ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

84. formal: ifFun ==> Next Node: Node {id = 4, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

85. formal: ifFun ==> >>>>>>>>>> visitNode <<<<<<<<<<

86. formal: ifFun ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 4): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >=, expr2 = NumberLiteral 0.0}

87. formal: ifFun ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = >=, expr2 = NumberLiteral 0.0}

88. formal: ifFun ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

89. formal: ifFun ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

90. formal: ifFun ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

91. formal: ifFun ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

92. formal: ifFun ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

93. formal: ifFun ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "n", >=, SymNum 0.0

94. formal: ifFun ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "n") Ge (SymInt 0))

95. formal: ifFun ==> if statement ==> Next Node: Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 4}

96. formal: ifFun ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

97. formal: ifFun ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

98. formal: ifFun ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

99. formal: ifFun ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

100. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

101. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymInt 0) 

102. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

103. formal: ifFun ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

104. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

105. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymInt 0) 

106. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

107. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

108. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

109. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

110. formal: ifFun ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 0, +, SymVar Int "n"

111. formal: ifFun ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymVar Int "n")

112. formal: ifFun ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}, ER_Expr (SymVar Int "n")

113. formal: ifFun ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "res"
    Old Value: SymInt 0
    New Value: SymVar Int "n"

114. formal: ifFun ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "res",SymVar Int "n")

115. formal: ifFun ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "n"}

116. formal: ifFun ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "n"}

117. formal: ifFun ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}})

118. formal: ifFun ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymVar Int "n"}

119. formal: ifFun ==> if statement ==> Next Node: Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}}), parent = 4}

120. formal: ifFun ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

121. formal: ifFun ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}}

122. formal: ifFun ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

123. formal: ifFun ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

124. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

125. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (m ~~> SymInt 0) 

126. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

127. formal: ifFun ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

128. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

129. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (m ~~> SymInt 0) 

130. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

131. formal: ifFun ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 2.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

132. formal: ifFun ==> if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

133. formal: ifFun ==> if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

134. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

135. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

136. formal: ifFun ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

137. formal: ifFun ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymNum 2.0, *, SymVar Int "n"

138. formal: ifFun ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

139. formal: ifFun ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 0, +, SBin (SymInt 2) Mul (SymVar Int "n")

140. formal: ifFun ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

141. formal: ifFun ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}, ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

142. formal: ifFun ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "m"
    Old Value: SymInt 0
    New Value: SBin (SymInt 2) Mul (SymVar Int "n")

143. formal: ifFun ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "m",SBin (SymInt 2) Mul (SymVar Int "n"))

144. formal: ifFun ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

145. formal: ifFun ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

146. formal: ifFun ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})

147. formal: ifFun ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

148. formal: ifFun ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 4,SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing)

149. formal: ifFun ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing)

150. formal: ifFun ==> Next Node: End {id = 8, parent = 0, mExpr = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0})}

151. formal: ifFun ==> >>>>>>>>>> visitNode <<<<<<<<<<

152. formal: ifFun ==> (visitNode -> End): Method End

153. formal: ifFun ==> (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

154. formal: ifFun ==> (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

155. formal: ifFun ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "res"}, binOp = +, expr2 = NumberLiteral 1.0}

156. formal: ifFun ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

157. formal: ifFun ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) 

158. formal: ifFun ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]}

159. formal: ifFun ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

160. formal: ifFun ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

161. formal: ifFun ==> (visitExpr -> BinOpExpr): Affected: SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)], +, SymNum 1.0

162. formal: ifFun ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

163. formal: ifFun ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

164. formal: ifFun ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

165. formal: ifFun ==> (visitNode -> End -> method returns): Returning: ER_Expr (SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))

166. Method Call formal SymState: SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]),(VarName "n",SymVar Int "n"),(VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]),(VarName "x",SymInt 1),(ScopeRange (SR {branchStart = 4, branchEnd = 7}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing),(Return,SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1))], pc = []}

167. SymExec of actual parameter: ifFun(3.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

168. SymExec of actual parameter: ifFun(3.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

169. actual: ifFun ==> Next symExpr (MethodName "ifFun" ==> SMethodType Int) in Method Call: ifFun

170. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

171. actual: ifFun ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

172. actual: ifFun ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "ifFun",SMethodType Int)

173. actual: ifFun ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "ifFun", er_val = SMethodType Int}

174. actual: ifFun ==> Next symExpr (GlobalVars ==> SGlobalVars []) in Method Call: ifFun

175. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

176. actual: ifFun ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars []

177. actual: ifFun ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars [])

178. actual: ifFun ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars []}

179. actual: ifFun ==> Next symExpr (FormalParms ==> SFormalParms ["n"]) in Method Call: ifFun

180. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

181. actual: ifFun ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["n"]

182. actual: ifFun ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["n"])

183. actual: ifFun ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["n"]}

184. actual: ifFun ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])) in Method Call: ifFun

185. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

186. actual: ifFun ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])

187. actual: ifFun ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})]))

188. actual: ifFun ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])}

189. actual: ifFun ==> Next symExpr (VarAssignments ==> SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]) in Method Call: ifFun

190. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

191. actual: ifFun ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]

192. actual: ifFun ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})])

193. actual: ifFun ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]}

194. actual: ifFun ==> Next symExpr (VarName "m" ==> SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]) in Method Call: ifFun

195. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

196. actual: ifFun ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]

197. actual: ifFun ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "m",SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)])

198. actual: ifFun ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"m",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],6)]

199. actual: ifFun ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName m"

200. actual: ifFun ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

201. actual: ifFun ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

202. actual: ifFun ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymInt 0)

203. actual: ifFun ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 0}

204. actual: ifFun ==> Next symExpr (VarName "n" ==> SymVar Int "n") in Method Call: ifFun

205. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

206. actual: ifFun ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

207. actual: ifFun ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

208. actual: ifFun ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 3)

209. actual: ifFun ==> (visitSymExpr -> SymVar): Modifying State: (VarName "n",SymInt 3)

210. actual: ifFun ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymInt 3}

211. actual: ifFun ==> Next symExpr (VarName "res" ==> SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) in Method Call: ifFun

212. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

213. actual: ifFun ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]

214. actual: ifFun ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "res",SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)])

215. actual: ifFun ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]

216. actual: ifFun ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName res"

217. actual: ifFun ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

218. actual: ifFun ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

219. actual: ifFun ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymInt 0)

220. actual: ifFun ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 0}

221. actual: ifFun ==> Next symExpr (VarName "x" ==> SymInt 1) in Method Call: ifFun

222. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

223. actual: ifFun ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 1

224. actual: ifFun ==> (visitSymExpr -> SymInt): Modifying State: (VarName "x",SymInt 1)

225. actual: ifFun ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

226. actual: ifFun ==> Next symExpr (ScopeRange (SR {branchStart = 4, branchEnd = 7}) ==> SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing) in Method Call: ifFun

227. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

228. actual: ifFun ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SBin (SymInt 2) Mul (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "res",SymVar Int "n"),(VarName "x",SymInt 1)], pc = []}) Nothing

229. actual: ifFun ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "n") Ge (SymInt 0)

SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 0),(VarName "n",SymInt 3),(VarName "res",SymInt 0),(VarName "x",SymInt 1)], pc = []}

230. actual: ifFun ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

231. actual: ifFun ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 3)

232. actual: ifFun ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

233. actual: ifFun ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

234. actual: ifFun ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool True)

235. actual: ifFun ==> Next symExpr (MethodName "ifFun" ==> SMethodType Int) in Method Call: ifFun

236. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

237. actual: ifFun ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

238. actual: ifFun ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "ifFun",SMethodType Int)

239. actual: ifFun ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "ifFun", er_val = SMethodType Int}

240. actual: ifFun ==> Next symExpr (FormalParms ==> SFormalParms ["n"]) in Method Call: ifFun

241. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

242. actual: ifFun ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["n"]

243. actual: ifFun ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["n"])

244. actual: ifFun ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["n"]}

245. actual: ifFun ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])) in Method Call: ifFun

246. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

247. actual: ifFun ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])

248. actual: ifFun ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})]))

249. actual: ifFun ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])}

250. actual: ifFun ==> Next symExpr (VarAssignments ==> SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]) in Method Call: ifFun

251. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

252. actual: ifFun ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]

253. actual: ifFun ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})])

254. actual: ifFun ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]}

255. actual: ifFun ==> Next symExpr (VarName "m" ==> SBin (SymInt 2) Mul (SymVar Int "n")) in Method Call: ifFun

256. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

257. actual: ifFun ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymInt 2) Mul (SymVar Int "n")

258. actual: ifFun ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymInt 2) Mul (SymVar Int "n")

SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})])], pc = []}

259. actual: ifFun ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 2

260. actual: ifFun ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 2)

261. actual: ifFun ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

262. actual: ifFun ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 3)

263. actual: ifFun ==> (visitSymExpr -> SBin): Returning: ER_Expr (SymInt 6)

264. actual: ifFun ==> (visitSymExpr -> SBin): Modifying State: (VarName "m",SymInt 6)

265. actual: ifFun ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymInt 6}

266. actual: ifFun ==> Next symExpr (VarName "n" ==> SymVar Int "n") in Method Call: ifFun

267. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

268. actual: ifFun ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

269. actual: ifFun ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

270. actual: ifFun ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 3)

271. actual: ifFun ==> (visitSymExpr -> SymVar): Modifying State: (VarName "n",SymInt 3)

272. actual: ifFun ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymInt 3}

273. actual: ifFun ==> Next symExpr (VarName "res" ==> SymVar Int "n") in Method Call: ifFun

274. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

275. actual: ifFun ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

276. actual: ifFun ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

277. actual: ifFun ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 3)

278. actual: ifFun ==> (visitSymExpr -> SymVar): Modifying State: (VarName "res",SymInt 3)

279. actual: ifFun ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymInt 3}

280. actual: ifFun ==> Next symExpr (VarName "x" ==> SymInt 1) in Method Call: ifFun

281. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

282. actual: ifFun ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 1

283. actual: ifFun ==> (visitSymExpr -> SymInt): Modifying State: (VarName "x",SymInt 1)

284. actual: ifFun ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

285. actual: ifFun ==> (visitSymExpr -> SIte -> resolved condition is True -> else body exists): Modifying State: (<no key>,<whole state is updated>: SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 6),(VarName "n",SymInt 3),(VarName "res",SymInt 3),(VarName "x",SymInt 1)], pc = []})

286. actual: ifFun ==> Next symExpr (Return ==> SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1)) in Method Call: ifFun

287. actual: ifFun ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

288. actual: ifFun ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1)

289. actual: ifFun ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]) Add (SymInt 1)

SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 6),(VarName "n",SymInt 3),(VarName "res",SymInt 3),(VarName "x",SymInt 1)], pc = []}

290. actual: ifFun ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"res",Just (SymInt 0)) [([(If,SR {branchStart = 4, branchEnd = 7})],5)]

291. actual: ifFun ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 3

292. actual: ifFun ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 3)

293. actual: ifFun ==> (visitSymExpr0 -> SymUnknown Just): Returning: ER_Expr (SymInt 3)

294. actual: ifFun ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 1

295. actual: ifFun ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 1)

296. actual: ifFun ==> (visitSymExpr -> SBin): Returning: ER_Expr (SymInt 4)

297. actual: ifFun ==> (visitSymExpr -> SBin): Modifying State: (Return,SymInt 4)

298. actual: ifFun ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 4}

299. Method Call actual SymState: SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 6),(VarName "n",SymInt 3),(VarName "res",SymInt 3),(VarName "x",SymInt 1),(Return,SymInt 4)], pc = []}

300. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "ifFun",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarBindings,SVarBindings (fromList [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("res",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 4, branchEnd = 7}}),("m",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 4, branchEnd = 7}})]),(VarName "m",SymInt 6),(VarName "n",SymInt 3),(VarName "res",SymInt 3),(VarName "x",SymInt 1),(Return,SymInt 4)], pc = []})

301. (visitExpr -> BinOpExpr): Affected: SymNum 4.0, +, SymInt 4

302. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 8)

303. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 8)

304. (visitStmt -> ReturnStmt): Returning: ER_Expr (SymInt 8)

305. (visitNode -> End -> method returns): Returning: ER_Expr (SymInt 8)
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFunCall",SMethodType Int),(Return,SymInt 8)], pc = []}