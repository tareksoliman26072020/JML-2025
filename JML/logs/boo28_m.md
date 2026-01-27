================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo28_m" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo28_m

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo28_m",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28"}, funArgs = [NumberLiteral (-10.0)]})}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28"}, funArgs = [NumberLiteral (-10.0)]}

8. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28"}, funArgs = [NumberLiteral (-10.0)]}

9. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28"}, funArgs = [NumberLiteral (-10.0)]}

10. formal: boo28 ==> Next Node: Entry (BuiltInType Int) "boo28" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

11. formal: boo28 ==> >>>>>>>>>> visitNode <<<<<<<<<<

12. formal: boo28 ==> (visitNode -> Entry): Method Start: boo28

13. formal: boo28 ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

14. formal: boo28 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

15. formal: boo28 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

16. formal: boo28 ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

17. formal: boo28 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

18. formal: boo28 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

19. formal: boo28 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

20. formal: boo28 ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

21. formal: boo28 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

22. formal: boo28 ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

23. formal: boo28 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

24. formal: boo28 ==> Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

25. formal: boo28 ==> >>>>>>>>>> visitNode <<<<<<<<<<

26. formal: boo28 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

27. formal: boo28 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

28. formal: boo28 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

29. formal: boo28 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

30. formal: boo28 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int x

31. formal: boo28 ==> (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

32. formal: boo28 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

33. formal: boo28 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

34. formal: boo28 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

35. formal: boo28 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

36. formal: boo28 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

37. formal: boo28 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

38. formal: boo28 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

39. formal: boo28 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

40. formal: boo28 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})

41. formal: boo28 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})

42. formal: boo28 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

43. formal: boo28 ==> Next Node: Node {id = 2, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

44. formal: boo28 ==> >>>>>>>>>> visitNode <<<<<<<<<<

45. formal: boo28 ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 2): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

46. formal: boo28 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

47. formal: boo28 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

48. formal: boo28 ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

49. formal: boo28 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

50. formal: boo28 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

51. formal: boo28 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

52. formal: boo28 ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", >=, SymNum 0.0

53. formal: boo28 ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Ge (SymInt 0))

54. formal: boo28 ==> if statement ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}

55. formal: boo28 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

56. formal: boo28 ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}}

57. formal: boo28 ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}

58. formal: boo28 ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}

59. formal: boo28 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

60. formal: boo28 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

61. formal: boo28 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

62. formal: boo28 ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}

63. formal: boo28 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

64. formal: boo28 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

65. formal: boo28 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

66. formal: boo28 ==> if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

67. formal: boo28 ==> if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

68. formal: boo28 ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 1, +, SymNum 1.0

69. formal: boo28 ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 2)

70. formal: boo28 ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}, ER_Expr (SymInt 2)

71. formal: boo28 ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymInt 1
    New Value: SymInt 2

72. formal: boo28 ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 2)

73. formal: boo28 ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

74. formal: boo28 ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

75. formal: boo28 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})

76. formal: boo28 ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

77. formal: boo28 ==> if statement ==> Next Node: End {id = 4, parent = 2, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

78. formal: boo28 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

79. formal: boo28 ==> if statement ==> (visitNode -> End): Method End

80. formal: boo28 ==> if statement ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

81. formal: boo28 ==> if statement ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

82. formal: boo28 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

83. formal: boo28 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

84. formal: boo28 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

85. formal: boo28 ==> if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

86. formal: boo28 ==> if statement ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

87. formal: boo28 ==> if statement ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

88. formal: boo28 ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 2,SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")], pc = []}) Nothing)

89. formal: boo28 ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")], pc = []}) Nothing)

90. formal: boo28 ==> Next Node: End {id = 6, parent = 0, mExpr = Just (NumberLiteral 5.0)}

91. formal: boo28 ==> >>>>>>>>>> visitNode <<<<<<<<<<

92. formal: boo28 ==> (visitNode -> End): Method End

93. formal: boo28 ==> (visitNode -> End -> return something): handling return expression: NumberLiteral 5.0

94. formal: boo28 ==> (visitStmt -> ReturnStmt): handling return expression: NumberLiteral 5.0

95. formal: boo28 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

96. formal: boo28 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

97. formal: boo28 ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 5)

98. formal: boo28 ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SymNum 5.0)

99. formal: boo28 ==> (visitNode -> End -> method returns): Returning: ER_Expr (SymNum 5.0)

100. Method Call formal SymState: SymState {env = fromList [(MethodName "boo28",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 5})],3)]),(ScopeRange (SR {branchStart = 2, branchEnd = 5}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")], pc = []}) Nothing),(Return,SymInt 5)], pc = []}

101. SymExec of actual parameter: boo28(-10.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral (-10.0)

102. SymExec of actual parameter: boo28(-10.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum (-10.0))

103. actual: boo28 ==> Next symExpr (MethodName "boo28" ==> SMethodType Int) in Method Call: boo28

104. actual: boo28 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

105. actual: boo28 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

106. actual: boo28 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo28",SMethodType Int)

107. actual: boo28 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo28", er_val = SMethodType Int}

108. actual: boo28 ==> Next symExpr (GlobalVars ==> SGlobalVars []) in Method Call: boo28

109. actual: boo28 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

110. actual: boo28 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars []

111. actual: boo28 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars [])

112. actual: boo28 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars []}

113. actual: boo28 ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo28

114. actual: boo28 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

115. actual: boo28 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

116. actual: boo28 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

117. actual: boo28 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

118. actual: boo28 ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])) in Method Call: boo28

119. actual: boo28 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

120. actual: boo28 ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])

121. actual: boo28 ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})]))

122. actual: boo28 ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])}

123. actual: boo28 ==> Next symExpr (VarAssignments ==> SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]) in Method Call: boo28

124. actual: boo28 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

125. actual: boo28 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]

126. actual: boo28 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})])

127. actual: boo28 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]}

128. actual: boo28 ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo28

129. actual: boo28 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

130. actual: boo28 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

131. actual: boo28 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

132. actual: boo28 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt (-10))

133. actual: boo28 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SymInt (-10))

134. actual: boo28 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymInt (-10)}

135. actual: boo28 ==> Next symExpr (VarName "x" ==> SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 5})],3)]) in Method Call: boo28

136. actual: boo28 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

137. actual: boo28 ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 5})],3)]

138. actual: boo28 ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "x",SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 5})],3)])

139. actual: boo28 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 5})],3)]

140. actual: boo28 ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName x"

141. actual: boo28 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 1

142. actual: boo28 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 1)

143. actual: boo28 ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymInt 1)

144. actual: boo28 ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

145. actual: boo28 ==> Next symExpr (ScopeRange (SR {branchStart = 2, branchEnd = 5}) ==> SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")], pc = []}) Nothing) in Method Call: boo28

146. actual: boo28 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

147. actual: boo28 ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2),(Return,SymVar Int "i")], pc = []}) Nothing

148. actual: boo28 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "i") Ge (SymInt 0)

SymState {env = fromList [(MethodName "boo28",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymInt (-10)),(VarName "x",SymInt 1)], pc = []}

149. actual: boo28 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

150. actual: boo28 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt (-10))

151. actual: boo28 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

152. actual: boo28 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

153. actual: boo28 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool False)

154. actual: boo28 ==> (visitSymExpr -> SIte -> resolved condition is False -> no else body): State Not Modified

155. actual: boo28 ==> Next symExpr (Return ==> SymInt 5) in Method Call: boo28

156. actual: boo28 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

157. actual: boo28 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 5

158. actual: boo28 ==> (visitSymExpr -> SymInt): Modifying State: (Return,SymInt 5)

159. actual: boo28 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 5}

160. Method Call actual SymState: SymState {env = fromList [(MethodName "boo28",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymInt (-10)),(VarName "x",SymInt 1),(Return,SymInt 5)], pc = []}

161. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymInt (-10)),(VarName "x",SymInt 1),(Return,SymInt 5)], pc = []})

162. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 5)

163. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymInt (-10)),(VarName "x",SymInt 1),(Return,SymInt 5)], pc = []})

164. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo28",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 5}})]),(VarName "i",SymInt (-10)),(VarName "x",SymInt 1),(Return,SymInt 5)], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo28_m",SMethodType Int),(Return,SymInt 5)], pc = []}