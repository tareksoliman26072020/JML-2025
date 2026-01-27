================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo28_6_p" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo28_6_p

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo28_6_p",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28_6"}, funArgs = [NumberLiteral 10.0]})}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28_6"}, funArgs = [NumberLiteral 10.0]}

8. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28_6"}, funArgs = [NumberLiteral 10.0]}

9. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28_6"}, funArgs = [NumberLiteral 10.0]}

10. formal: boo28_6 ==> Next Node: Entry (BuiltInType Int) "boo28_6" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

11. formal: boo28_6 ==> >>>>>>>>>> visitNode <<<<<<<<<<

12. formal: boo28_6 ==> (visitNode -> Entry): Method Start: boo28_6

13. formal: boo28_6 ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

14. formal: boo28_6 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

15. formal: boo28_6 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

16. formal: boo28_6 ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

17. formal: boo28_6 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

18. formal: boo28_6 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

19. formal: boo28_6 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

20. formal: boo28_6 ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

21. formal: boo28_6 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

22. formal: boo28_6 ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

23. formal: boo28_6 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

24. formal: boo28_6 ==> Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

25. formal: boo28_6 ==> >>>>>>>>>> visitNode <<<<<<<<<<

26. formal: boo28_6 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

27. formal: boo28_6 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

28. formal: boo28_6 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

29. formal: boo28_6 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

30. formal: boo28_6 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int x

31. formal: boo28_6 ==> (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

32. formal: boo28_6 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

33. formal: boo28_6 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

34. formal: boo28_6 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

35. formal: boo28_6 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

36. formal: boo28_6 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

37. formal: boo28_6 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

38. formal: boo28_6 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

39. formal: boo28_6 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

40. formal: boo28_6 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})

41. formal: boo28_6 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})

42. formal: boo28_6 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

43. formal: boo28_6 ==> Next Node: Node {id = 2, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

44. formal: boo28_6 ==> >>>>>>>>>> visitNode <<<<<<<<<<

45. formal: boo28_6 ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 2): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

46. formal: boo28_6 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

47. formal: boo28_6 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

48. formal: boo28_6 ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

49. formal: boo28_6 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

50. formal: boo28_6 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

51. formal: boo28_6 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

52. formal: boo28_6 ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", >=, SymNum 0.0

53. formal: boo28_6 ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Ge (SymInt 0))

54. formal: boo28_6 ==> if statement ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}}), parent = 2}

55. formal: boo28_6 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

56. formal: boo28_6 ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}}

57. formal: boo28_6 ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}

58. formal: boo28_6 ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}

59. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}

60. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): New Variable BuiltInType Int y

61. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): Modifying State: (y,SymNull Int)

62. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull Int}

63. formal: boo28_6 ==> if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

64. formal: boo28_6 ==> if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

65. formal: boo28_6 ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

66. formal: boo28_6 ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymNull Int
    New Value: SymInt 0

67. formal: boo28_6 ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SymInt 0)

68. formal: boo28_6 ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}

69. formal: boo28_6 ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}

70. formal: boo28_6 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Binding: ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})

71. formal: boo28_6 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})

72. formal: boo28_6 ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}

73. formal: boo28_6 ==> if statement ==> Next Node: Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}

74. formal: boo28_6 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

75. formal: boo28_6 ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = NumberLiteral 1.0}}}

76. formal: boo28_6 ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = NumberLiteral 1.0}}

77. formal: boo28_6 ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = NumberLiteral 1.0}}

78. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

79. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymInt 0) 

80. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}

81. formal: boo28_6 ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = NumberLiteral 1.0}

82. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

83. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymInt 0) 

84. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}

85. formal: boo28_6 ==> if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

86. formal: boo28_6 ==> if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

87. formal: boo28_6 ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 0, +, SymNum 1.0

88. formal: boo28_6 ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 1)

89. formal: boo28_6 ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}, ER_Expr (SymInt 1)

90. formal: boo28_6 ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymInt 0
    New Value: SymInt 1

91. formal: boo28_6 ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SymInt 1)

92. formal: boo28_6 ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 1}

93. formal: boo28_6 ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 1}

94. formal: boo28_6 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})

95. formal: boo28_6 ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 1}

96. formal: boo28_6 ==> if statement ==> Next Node: End {id = 5, parent = 2, mExpr = Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}})}

97. formal: boo28_6 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

98. formal: boo28_6 ==> if statement ==> (visitNode -> End): Method End

99. formal: boo28_6 ==> if statement ==> (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

100. formal: boo28_6 ==> if statement ==> (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

101. formal: boo28_6 ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

102. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

103. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

104. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

105. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

106. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymInt 1) 

107. formal: boo28_6 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 1}

108. formal: boo28_6 ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", +, SymInt 1

109. formal: boo28_6 ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 1))

110. formal: boo28_6 ==> if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymVar Int "i") Add (SymInt 1))

111. formal: boo28_6 ==> if statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 1))

112. formal: boo28_6 ==> if statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 1))

113. formal: boo28_6 ==> else statement ==> Next Node: Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}

114. formal: boo28_6 ==> else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

115. formal: boo28_6 ==> else statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}}

116. formal: boo28_6 ==> else statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}

117. formal: boo28_6 ==> else statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}

118. formal: boo28_6 ==> else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

119. formal: boo28_6 ==> else statement ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

120. formal: boo28_6 ==> else statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

121. formal: boo28_6 ==> else statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}

122. formal: boo28_6 ==> else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

123. formal: boo28_6 ==> else statement ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

124. formal: boo28_6 ==> else statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

125. formal: boo28_6 ==> else statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

126. formal: boo28_6 ==> else statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

127. formal: boo28_6 ==> else statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 1, +, SymNum 1.0

128. formal: boo28_6 ==> else statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 2)

129. formal: boo28_6 ==> else statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}, ER_Expr (SymInt 2)

130. formal: boo28_6 ==> else statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymInt 1
    New Value: SymInt 2

131. formal: boo28_6 ==> else statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 2)

132. formal: boo28_6 ==> else statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

133. formal: boo28_6 ==> else statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

134. formal: boo28_6 ==> else statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})

135. formal: boo28_6 ==> else statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

136. formal: boo28_6 ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 2,SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymVar Int "i") Add (SymInt 1))], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []})))

137. formal: boo28_6 ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymVar Int "i") Add (SymInt 1))], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []})))

138. formal: boo28_6 ==> Next Node: Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 2.0}}), parent = 0}

139. formal: boo28_6 ==> >>>>>>>>>> visitNode <<<<<<<<<<

140. formal: boo28_6 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 2.0}}

141. formal: boo28_6 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 2.0}

142. formal: boo28_6 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 2.0}

143. formal: boo28_6 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}

144. formal: boo28_6 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int y

145. formal: boo28_6 ==> (visitExpr -> VarExpr): Modifying State: (y,SymNull Int)

146. formal: boo28_6 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull Int}

147. formal: boo28_6 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

148. formal: boo28_6 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

149. formal: boo28_6 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull Int}, ER_Expr (SymNum 2.0)

150. formal: boo28_6 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymNull Int
    New Value: SymInt 2

151. formal: boo28_6 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SymInt 2)

152. formal: boo28_6 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 2}

153. formal: boo28_6 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 2}

154. formal: boo28_6 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})

155. formal: boo28_6 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})

156. formal: boo28_6 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 2}

157. formal: boo28_6 ==> Next Node: End {id = 9, parent = 0, mExpr = Just (BinOpExpr {expr1 = NumberLiteral 5.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}})}

158. formal: boo28_6 ==> >>>>>>>>>> visitNode <<<<<<<<<<

159. formal: boo28_6 ==> (visitNode -> End): Method End

160. formal: boo28_6 ==> (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = NumberLiteral 5.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

161. formal: boo28_6 ==> (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = NumberLiteral 5.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

162. formal: boo28_6 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 5.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

163. formal: boo28_6 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

164. formal: boo28_6 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

165. formal: boo28_6 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

166. formal: boo28_6 ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymInt 2) 

167. formal: boo28_6 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 2}

168. formal: boo28_6 ==> (visitExpr -> BinOpExpr): Affected: SymNum 5.0, +, SymInt 2

169. formal: boo28_6 ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 7)

170. formal: boo28_6 ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 7)

171. formal: boo28_6 ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SymInt 7)

172. formal: boo28_6 ==> (visitNode -> End -> method returns): Returning: ER_Expr (SymInt 7)

173. Method Call formal SymState: SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 7})],6)]),(VarName "y",SymInt 2),(ScopeRange (SR {branchStart = 2, branchEnd = 7}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymVar Int "i") Add (SymInt 1))], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []}))),(Return,SymInt 7)], pc = []}

174. SymExec of actual parameter: boo28_6(10.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 10.0

175. SymExec of actual parameter: boo28_6(10.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 10.0)

176. actual: boo28_6 ==> Next symExpr (MethodName "boo28_6" ==> SMethodType Int) in Method Call: boo28_6

177. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

178. actual: boo28_6 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

179. actual: boo28_6 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo28_6",SMethodType Int)

180. actual: boo28_6 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo28_6", er_val = SMethodType Int}

181. actual: boo28_6 ==> Next symExpr (GlobalVars ==> SGlobalVars []) in Method Call: boo28_6

182. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

183. actual: boo28_6 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars []

184. actual: boo28_6 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars [])

185. actual: boo28_6 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars []}

186. actual: boo28_6 ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo28_6

187. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

188. actual: boo28_6 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

189. actual: boo28_6 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

190. actual: boo28_6 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

191. actual: boo28_6 ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})])) in Method Call: boo28_6

192. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

193. actual: boo28_6 ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})])

194. actual: boo28_6 ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})]))

195. actual: boo28_6 ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})])}

196. actual: boo28_6 ==> Next symExpr (VarAssignments ==> SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})]) in Method Call: boo28_6

197. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

198. actual: boo28_6 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})]

199. actual: boo28_6 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})])

200. actual: boo28_6 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})]}

201. actual: boo28_6 ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo28_6

202. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

203. actual: boo28_6 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

204. actual: boo28_6 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

205. actual: boo28_6 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

206. actual: boo28_6 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SymInt 10)

207. actual: boo28_6 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymInt 10}

208. actual: boo28_6 ==> Next symExpr (VarName "x" ==> SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 7})],6)]) in Method Call: boo28_6

209. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

210. actual: boo28_6 ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 7})],6)]

211. actual: boo28_6 ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "x",SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 7})],6)])

212. actual: boo28_6 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 7})],6)]

213. actual: boo28_6 ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName x"

214. actual: boo28_6 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 1

215. actual: boo28_6 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 1)

216. actual: boo28_6 ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymInt 1)

217. actual: boo28_6 ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

218. actual: boo28_6 ==> Next symExpr (VarName "y" ==> SymInt 2) in Method Call: boo28_6

219. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

220. actual: boo28_6 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 2

221. actual: boo28_6 ==> (visitSymExpr -> SymInt): Modifying State: (VarName "y",SymInt 2)

222. actual: boo28_6 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 2}

223. actual: boo28_6 ==> Next symExpr (ScopeRange (SR {branchStart = 2, branchEnd = 7}) ==> SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymVar Int "i") Add (SymInt 1))], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []}))) in Method Call: boo28_6

224. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

225. actual: boo28_6 ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SBin (SymVar Int "i") Add (SymInt 1))], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []}))

226. actual: boo28_6 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "i") Ge (SymInt 0)

SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("x",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 5}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 2)], pc = []}

227. actual: boo28_6 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

228. actual: boo28_6 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

229. actual: boo28_6 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

230. actual: boo28_6 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

231. actual: boo28_6 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool True)

232. actual: boo28_6 ==> Next symExpr (MethodName "boo28_6" ==> SMethodType Int) in Method Call: boo28_6

233. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

234. actual: boo28_6 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

235. actual: boo28_6 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo28_6",SMethodType Int)

236. actual: boo28_6 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo28_6", er_val = SMethodType Int}

237. actual: boo28_6 ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo28_6

238. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

239. actual: boo28_6 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

240. actual: boo28_6 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

241. actual: boo28_6 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

242. actual: boo28_6 ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])) in Method Call: boo28_6

243. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

244. actual: boo28_6 ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])

245. actual: boo28_6 ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})]))

246. actual: boo28_6 ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])}

247. actual: boo28_6 ==> Next symExpr (VarAssignments ==> SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]) in Method Call: boo28_6

248. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

249. actual: boo28_6 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]

250. actual: boo28_6 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})])

251. actual: boo28_6 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]}

252. actual: boo28_6 ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo28_6

253. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

254. actual: boo28_6 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

255. actual: boo28_6 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

256. actual: boo28_6 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

257. actual: boo28_6 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SymInt 10)

258. actual: boo28_6 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymInt 10}

259. actual: boo28_6 ==> Next symExpr (VarName "x" ==> SymInt 1) in Method Call: boo28_6

260. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

261. actual: boo28_6 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 1

262. actual: boo28_6 ==> (visitSymExpr -> SymInt): Modifying State: (VarName "x",SymInt 1)

263. actual: boo28_6 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

264. actual: boo28_6 ==> Next symExpr (VarName "y" ==> SymInt 1) in Method Call: boo28_6

265. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

266. actual: boo28_6 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 1

267. actual: boo28_6 ==> (visitSymExpr -> SymInt): Modifying State: (VarName "y",SymInt 1)

268. actual: boo28_6 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 1}

269. actual: boo28_6 ==> Next symExpr (Return ==> SBin (SymVar Int "i") Add (SymInt 1)) in Method Call: boo28_6

270. actual: boo28_6 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

271. actual: boo28_6 ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 1)

272. actual: boo28_6 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 1)

SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 1)], pc = []}

273. actual: boo28_6 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

274. actual: boo28_6 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

275. actual: boo28_6 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 1

276. actual: boo28_6 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 1)

277. actual: boo28_6 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SymInt 11)

278. actual: boo28_6 ==> (visitSymExpr -> SBin): Modifying State: (Return,SymInt 11)

279. actual: boo28_6 ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 11}

280. actual: boo28_6 ==> (visitSymExpr -> SIte -> resolved condition is True -> else body exists): Modifying State: (<no key>,<whole state is updated>: SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SymInt 11)], pc = []})

281. actual: boo28_6 ==> Next symExpr (Return ==> SymInt 7) in Method Call: boo28_6

282. actual: boo28_6 ==> (Skip):
"(Return,SymInt 7)"

283. Method Call actual SymState: SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SymInt 11)], pc = []}

284. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SymInt 11)], pc = []})

285. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 11)

286. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SymInt 11)], pc = []})

287. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo28_6",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 7}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 1),(Return,SymInt 11)], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo28_6_p",SMethodType Int),(Return,SymInt 11)], pc = []}