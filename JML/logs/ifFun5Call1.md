================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "ifFun5Call1" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFun5Call1

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun5Call1",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun5"}, funArgs = [NumberLiteral 10.0]})}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun5"}, funArgs = [NumberLiteral 10.0]}

8. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun5"}, funArgs = [NumberLiteral 10.0]}

9. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun5"}, funArgs = [NumberLiteral 10.0]}

10. formal: ifFun5 ==> Next Node: Entry (BuiltInType Int) "ifFun5" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

11. formal: ifFun5 ==> >>>>>>>>>> visitNode <<<<<<<<<<

12. formal: ifFun5 ==> (visitNode -> Entry): Method Start: ifFun5

13. formal: ifFun5 ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

14. formal: ifFun5 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

15. formal: ifFun5 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int n

16. formal: ifFun5 ==> (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

17. formal: ifFun5 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

18. formal: ifFun5 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

19. formal: ifFun5 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int n

20. formal: ifFun5 ==> (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

21. formal: ifFun5 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

22. formal: ifFun5 ==> (visitNode -> Entry -> method with args): Modifying State: (n,SymVar Int "n")

23. formal: ifFun5 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

24. formal: ifFun5 ==> Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}), parent = 0}

25. formal: ifFun5 ==> >>>>>>>>>> visitNode <<<<<<<<<<

26. formal: ifFun5 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

27. formal: ifFun5 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

28. formal: ifFun5 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

29. formal: ifFun5 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

30. formal: ifFun5 ==> (visitExpr -> VarExpr): Global Variable Detected: y 

31. formal: ifFun5 ==> (visitExpr -> VarExpr): Modifying State: (y,SymVar UnknownGlobalVarSymType "y")

32. formal: ifFun5 ==> (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}

33. formal: ifFun5 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

34. formal: ifFun5 ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

35. formal: ifFun5 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

36. formal: ifFun5 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}, ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

37. formal: ifFun5 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymVar UnknownGlobalVarSymType "y"
    New Value: SymVar Int "n"

38. formal: ifFun5 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SymVar Int "n")

39. formal: ifFun5 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

40. formal: ifFun5 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

41. formal: ifFun5 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}})

42. formal: ifFun5 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

43. formal: ifFun5 ==> Next Node: Node {id = 2, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

44. formal: ifFun5 ==> >>>>>>>>>> visitNode <<<<<<<<<<

45. formal: ifFun5 ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 2): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0}

46. formal: ifFun5 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0}

47. formal: ifFun5 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

48. formal: ifFun5 ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymVar Int "n") 

49. formal: ifFun5 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

50. formal: ifFun5 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

51. formal: ifFun5 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

52. formal: ifFun5 ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "n", >=, SymNum 0.0

53. formal: ifFun5 ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "n") Ge (SymInt 0))

54. formal: ifFun5 ==> if statement ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 2}

55. formal: ifFun5 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

56. formal: ifFun5 ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

57. formal: ifFun5 ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

58. formal: ifFun5 ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

59. formal: ifFun5 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

60. formal: ifFun5 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymVar Int "n") 

61. formal: ifFun5 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

62. formal: ifFun5 ==> if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

63. formal: ifFun5 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

64. formal: ifFun5 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymVar Int "n") 

65. formal: ifFun5 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}

66. formal: ifFun5 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

67. formal: ifFun5 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

68. formal: ifFun5 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

69. formal: ifFun5 ==> if statement ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "n", +, SymVar Int "n"

70. formal: ifFun5 ==> if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

71. formal: ifFun5 ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar Int "n"}, ER_Expr (SBin (SymInt 2) Mul (SymVar Int "n"))

72. formal: ifFun5 ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymVar Int "n"
    New Value: SBin (SymInt 2) Mul (SymVar Int "n")

73. formal: ifFun5 ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))

74. formal: ifFun5 ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

75. formal: ifFun5 ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

76. formal: ifFun5 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})

77. formal: ifFun5 ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SBin (SymInt 2) Mul (SymVar Int "n")}

78. formal: ifFun5 ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 2,SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing)

79. formal: ifFun5 ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing)

80. formal: ifFun5 ==> Next Node: End {id = 5, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "y"})}

81. formal: ifFun5 ==> >>>>>>>>>> visitNode <<<<<<<<<<

82. formal: ifFun5 ==> (visitNode -> End): Method End

83. formal: ifFun5 ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

84. formal: ifFun5 ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

85. formal: ifFun5 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

86. formal: ifFun5 ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]) 

87. formal: ifFun5 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]}

88. formal: ifFun5 ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])

89. formal: ifFun5 ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]}

90. formal: ifFun5 ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]}

91. Method Call formal SymState: SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]),(ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing),(Return,SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])], pc = []}

92. SymExec of actual parameter: ifFun5(10.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 10.0

93. SymExec of actual parameter: ifFun5(10.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 10.0)

94. (visitExpr -> FunCallExpr -> inheriting global vars list): Modifying State: (GlobalVars,["y"])

95. (visitExpr -> FunCallExpr -> inheriting global vars varnames): Modifying State: (VarNames,fromList [(VarName "y",SymInt 20)])

96. actual: ifFun5 ==> Next symExpr (MethodName "ifFun5" ==> SMethodType Int) in Method Call: ifFun5

97. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

98. actual: ifFun5 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

99. actual: ifFun5 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "ifFun5",SMethodType Int)

100. actual: ifFun5 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "ifFun5", er_val = SMethodType Int}

101. actual: ifFun5 ==> Next symExpr (GlobalVars ==> SGlobalVars ["y"]) in Method Call: ifFun5

102. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

103. actual: ifFun5 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars ["y"]

104. actual: ifFun5 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars ["y"])

105. actual: ifFun5 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars ["y"]}

106. actual: ifFun5 ==> Next symExpr (FormalParms ==> SFormalParms ["n"]) in Method Call: ifFun5

107. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

108. actual: ifFun5 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["n"]

109. actual: ifFun5 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["n"])

110. actual: ifFun5 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["n"]}

111. actual: ifFun5 ==> Next symExpr (VarAssignments ==> SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]) in Method Call: ifFun5

112. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

113. actual: ifFun5 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]

114. actual: ifFun5 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})])

115. actual: ifFun5 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]}

116. actual: ifFun5 ==> Next symExpr (VarName "n" ==> SymVar Int "n") in Method Call: ifFun5

117. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

118. actual: ifFun5 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

119. actual: ifFun5 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

120. actual: ifFun5 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

121. actual: ifFun5 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "n",SymInt 10)

122. actual: ifFun5 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymInt 10}

123. actual: ifFun5 ==> Next symExpr (VarName "y" ==> SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]) in Method Call: ifFun5

124. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

125. actual: ifFun5 ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]

126. actual: ifFun5 ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "y",SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])

127. actual: ifFun5 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]

128. actual: ifFun5 ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName y"

129. actual: ifFun5 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

130. actual: ifFun5 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

131. actual: ifFun5 ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymInt 10)

132. actual: ifFun5 ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 10}

133. actual: ifFun5 ==> Next symExpr (ScopeRange (SR {branchStart = 2, branchEnd = 4}) ==> SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing) in Method Call: ifFun5

134. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

135. actual: ifFun5 ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SymVar Int "n") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymInt 2) Mul (SymVar Int "n"))], pc = []}) Nothing

136. actual: ifFun5 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "n") Ge (SymInt 0)

SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymInt 10),(VarName "y",SymInt 10)], pc = []}

137. actual: ifFun5 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

138. actual: ifFun5 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

139. actual: ifFun5 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

140. actual: ifFun5 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

141. actual: ifFun5 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool True)

142. actual: ifFun5 ==> Next symExpr (MethodName "ifFun5" ==> SMethodType Int) in Method Call: ifFun5

143. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

144. actual: ifFun5 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

145. actual: ifFun5 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "ifFun5",SMethodType Int)

146. actual: ifFun5 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "ifFun5", er_val = SMethodType Int}

147. actual: ifFun5 ==> Next symExpr (GlobalVars ==> SGlobalVars ["y"]) in Method Call: ifFun5

148. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

149. actual: ifFun5 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars ["y"]

150. actual: ifFun5 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars ["y"])

151. actual: ifFun5 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars ["y"]}

152. actual: ifFun5 ==> Next symExpr (FormalParms ==> SFormalParms ["n"]) in Method Call: ifFun5

153. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

154. actual: ifFun5 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["n"]

155. actual: ifFun5 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["n"])

156. actual: ifFun5 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["n"]}

157. actual: ifFun5 ==> Next symExpr (VarAssignments ==> SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]) in Method Call: ifFun5

158. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

159. actual: ifFun5 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]

160. actual: ifFun5 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})])

161. actual: ifFun5 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]}

162. actual: ifFun5 ==> Next symExpr (VarName "n" ==> SymVar Int "n") in Method Call: ifFun5

163. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

164. actual: ifFun5 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

165. actual: ifFun5 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

166. actual: ifFun5 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

167. actual: ifFun5 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "n",SymInt 10)

168. actual: ifFun5 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymInt 10}

169. actual: ifFun5 ==> Next symExpr (VarName "y" ==> SBin (SymInt 2) Mul (SymVar Int "n")) in Method Call: ifFun5

170. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

171. actual: ifFun5 ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymInt 2) Mul (SymVar Int "n")

172. actual: ifFun5 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymInt 2) Mul (SymVar Int "n")

SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymInt 10)], pc = []}

173. actual: ifFun5 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 2

174. actual: ifFun5 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 2)

175. actual: ifFun5 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

176. actual: ifFun5 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

177. actual: ifFun5 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SymInt 20)

178. actual: ifFun5 ==> (visitSymExpr -> SBin): Modifying State: (VarName "y",SymInt 20)

179. actual: ifFun5 ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 20}

180. actual: ifFun5 ==> (visitSymExpr -> SIte -> resolved condition is True -> else body exists): Modifying State: (<no key>,<whole state is updated>: SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymInt 10),(VarName "y",SymInt 20)], pc = []})

181. actual: ifFun5 ==> Next symExpr (Return ==> SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]) in Method Call: ifFun5

182. actual: ifFun5 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

183. actual: ifFun5 ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]

184. actual: ifFun5 ==> (visitSymExpr -> SymUnknown): Modifying State: (Return,SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)])

185. actual: ifFun5 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"y",Just (SymVar Int "n")) [([(If,SR {branchStart = 2, branchEnd = 4})],3)]

186. actual: ifFun5 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 20

187. actual: ifFun5 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 20)

188. actual: ifFun5 ==> (visitSymExpr0 -> SymUnknown Just): Returning: ER_Expr (SymInt 20)

189. actual: ifFun5 ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 20}

190. Method Call actual SymState: SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymInt 10),(VarName "y",SymInt 20),(Return,SymInt 20)], pc = []}

191. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymInt 10),(VarName "y",SymInt 20),(Return,SymInt 20)], pc = []})

192. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 20)

193. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymInt 10),(VarName "y",SymInt 20),(Return,SymInt 20)], pc = []})

194. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "ifFun5",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 5}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 4}})]),(VarName "n",SymInt 10),(VarName "y",SymInt 20),(Return,SymInt 20)], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFun5Call1",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(VarName "y",SymInt 20),(Return,SymInt 20)], pc = []}