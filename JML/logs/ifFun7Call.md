================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Void) "ifFun7Call" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFun7Call

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun7Call",SMethodType Void)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun7"}, funArgs = [NumberLiteral 4.0]}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun7"}, funArgs = [NumberLiteral 4.0]}}

7. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "ifFun7"}, funArgs = [NumberLiteral 4.0]}

8. formal: ifFun7 ==> Next Node: Entry (BuiltInType Void) "ifFun7" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

9. formal: ifFun7 ==> >>>>>>>>>> visitNode <<<<<<<<<<

10. formal: ifFun7 ==> (visitNode -> Entry): Method Start: ifFun7

11. formal: ifFun7 ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

12. formal: ifFun7 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

13. formal: ifFun7 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int n

14. formal: ifFun7 ==> (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

15. formal: ifFun7 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

16. formal: ifFun7 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

17. formal: ifFun7 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int n

18. formal: ifFun7 ==> (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

19. formal: ifFun7 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

20. formal: ifFun7 ==> (visitNode -> Entry -> method with args): Modifying State: (n,SymVar Int "n")

21. formal: ifFun7 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

22. formal: ifFun7 ==> Next Node: Node {id = 1, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0})), parent = 0}

23. formal: ifFun7 ==> >>>>>>>>>> visitNode <<<<<<<<<<

24. formal: ifFun7 ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 1): If condition: BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0}

25. formal: ifFun7 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = %, expr2 = NumberLiteral 2.0}, binOp = ==, expr2 = NumberLiteral 0.0}

26. formal: ifFun7 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "n"}, binOp = %, expr2 = NumberLiteral 2.0}

27. formal: ifFun7 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

28. formal: ifFun7 ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

29. formal: ifFun7 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

30. formal: ifFun7 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

31. formal: ifFun7 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

32. formal: ifFun7 ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "n", %, SymNum 2.0

33. formal: ifFun7 ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "n") Mod (SymInt 2))

34. formal: ifFun7 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

35. formal: ifFun7 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

36. formal: ifFun7 ==> (visitExpr -> BinOpExpr): Affected: SBin (SymVar Int "n") Mod (SymInt 2), ==, SymNum 0.0

37. formal: ifFun7 ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0))

38. formal: ifFun7 ==> if statement ==> Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "v"}, assEright = StringLiteral "hi"}}), parent = 1}

39. formal: ifFun7 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

40. formal: ifFun7 ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "v"}, assEright = StringLiteral "hi"}}

41. formal: ifFun7 ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "v"}, assEright = StringLiteral "hi"}

42. formal: ifFun7 ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "v"}, assEright = StringLiteral "hi"}

43. formal: ifFun7 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "v"}

44. formal: ifFun7 ==> if statement ==> (visitExpr -> VarExpr): Global Variable Detected: v 

45. formal: ifFun7 ==> if statement ==> (visitExpr -> VarExpr): Modifying State: (v,SymVar UnknownGlobalVarSymType "v")

46. formal: ifFun7 ==> if statement ==> (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymVar UnknownGlobalVarSymType "v"}

47. formal: ifFun7 ==> if statement ==> (visitExpr -> StringLiteral): handling expression: StringLiteral "hi"

48. formal: ifFun7 ==> if statement ==> (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "hi")

49. formal: ifFun7 ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymVar UnknownGlobalVarSymType "v"}, ER_Expr (SymString "hi")

50. formal: ifFun7 ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "v"
    Old Value: SymVar UnknownGlobalVarSymType "v"
    New Value: SymString "hi"

51. formal: ifFun7 ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "v",SymString "hi")

52. formal: ifFun7 ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymString "hi"}

53. formal: ifFun7 ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymString "hi"}

54. formal: ifFun7 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})

55. formal: ifFun7 ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymString "hi"}

56. formal: ifFun7 ==> else statement ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "w"}, assEright = StringLiteral "bye"}}), parent = 1}

57. formal: ifFun7 ==> else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

58. formal: ifFun7 ==> else statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "w"}, assEright = StringLiteral "bye"}}

59. formal: ifFun7 ==> else statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "w"}, assEright = StringLiteral "bye"}

60. formal: ifFun7 ==> else statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "w"}, assEright = StringLiteral "bye"}

61. formal: ifFun7 ==> else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "w"}

62. formal: ifFun7 ==> else statement ==> (visitExpr -> VarExpr): Global Variable Detected: w 

63. formal: ifFun7 ==> else statement ==> (visitExpr -> VarExpr): Modifying State: (w,SymVar UnknownGlobalVarSymType "w")

64. formal: ifFun7 ==> else statement ==> (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymVar UnknownGlobalVarSymType "w"}

65. formal: ifFun7 ==> else statement ==> (visitExpr -> StringLiteral): handling expression: StringLiteral "bye"

66. formal: ifFun7 ==> else statement ==> (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "bye")

67. formal: ifFun7 ==> else statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymVar UnknownGlobalVarSymType "w"}, ER_Expr (SymString "bye")

68. formal: ifFun7 ==> else statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "w"
    Old Value: SymVar UnknownGlobalVarSymType "w"
    New Value: SymString "bye"

69. formal: ifFun7 ==> else statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "w",SymString "bye")

70. formal: ifFun7 ==> else statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymString "bye"}

71. formal: ifFun7 ==> else statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymString "bye"}

72. formal: ifFun7 ==> else statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})

73. formal: ifFun7 ==> else statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymString "bye"}

74. formal: ifFun7 ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 1,SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))

75. formal: ifFun7 ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))

76. formal: ifFun7 ==> Next Node: End {id = 5, parent = 0, mExpr = Nothing}

77. formal: ifFun7 ==> >>>>>>>>>> visitNode <<<<<<<<<<

78. formal: ifFun7 ==> (visitNode -> End): Method End

79. formal: ifFun7 ==> (visitNode -> End -> return nothing): Void

80. formal: ifFun7 ==> (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v","w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),(VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),(ScopeRange (SR {branchStart = 1, branchEnd = 4}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))], pc = []})

81. Method Call formal SymState: SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v","w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]),(VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]),(ScopeRange (SR {branchStart = 1, branchEnd = 4}),SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []})))], pc = []}

82. SymExec of actual parameter: ifFun7(4.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

83. SymExec of actual parameter: ifFun7(4.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

84. (visitExpr -> FunCallExpr -> inheriting global vars list): Modifying State: (GlobalVars,["v"])

85. (visitExpr -> FunCallExpr -> inheriting global vars varnames): Modifying State: (VarNames,fromList [(VarName "v",SymString "hi")])

86. actual: ifFun7 ==> Next symExpr (MethodName "ifFun7" ==> SMethodType Void) in Method Call: ifFun7

87. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

88. actual: ifFun7 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Void

89. actual: ifFun7 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "ifFun7",SMethodType Void)

90. actual: ifFun7 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "ifFun7", er_val = SMethodType Void}

91. actual: ifFun7 ==> Next symExpr (GlobalVars ==> SGlobalVars ["v","w"]) in Method Call: ifFun7

92. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

93. actual: ifFun7 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars ["v","w"]

94. actual: ifFun7 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars ["v","w"])

95. actual: ifFun7 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars ["v","w"]}

96. actual: ifFun7 ==> Next symExpr (FormalParms ==> SFormalParms ["n"]) in Method Call: ifFun7

97. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

98. actual: ifFun7 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["n"]

99. actual: ifFun7 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["n"])

100. actual: ifFun7 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["n"]}

101. actual: ifFun7 ==> Next symExpr (VarAssignments ==> SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]) in Method Call: ifFun7

102. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

103. actual: ifFun7 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]

104. actual: ifFun7 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})])

105. actual: ifFun7 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]}

106. actual: ifFun7 ==> Next symExpr (VarName "n" ==> SymVar Int "n") in Method Call: ifFun7

107. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

108. actual: ifFun7 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

109. actual: ifFun7 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

110. actual: ifFun7 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 4)

111. actual: ifFun7 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "n",SymInt 4)

112. actual: ifFun7 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymInt 4}

113. actual: ifFun7 ==> Next symExpr (VarName "v" ==> SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]) in Method Call: ifFun7

114. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

115. actual: ifFun7 ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]

116. actual: ifFun7 ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "v",SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)])

117. actual: ifFun7 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (String,"v",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],2)]

118. actual: ifFun7 ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName v"

119. actual: ifFun7 ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymVar String "v")

120. actual: ifFun7 ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymVar String "v"}

121. actual: ifFun7 ==> Next symExpr (VarName "w" ==> SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]) in Method Call: ifFun7

122. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

123. actual: ifFun7 ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]

124. actual: ifFun7 ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "w",SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)])

125. actual: ifFun7 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (String,"w",Nothing) [([(If,SR {branchStart = 1, branchEnd = 4})],3)]

126. actual: ifFun7 ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName w"

127. actual: ifFun7 ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymVar String "w")

128. actual: ifFun7 ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "w", er_val = SymVar String "w"}

129. actual: ifFun7 ==> Next symExpr (ScopeRange (SR {branchStart = 1, branchEnd = 4}) ==> SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []}))) in Method Call: ifFun7

130. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

131. actual: ifFun7 ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)) (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "v",SymString "hi")], pc = []}) (Just (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymVar Int "n"),(VarName "w",SymString "bye")], pc = []}))

132. actual: ifFun7 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SBin (SymVar Int "n") Mod (SymInt 2)) Eq (SymInt 0)

SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v","w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymInt 4),(VarName "v",SymVar String "v"),(VarName "w",SymVar String "w")], pc = []}

133. actual: ifFun7 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "n") Mod (SymInt 2)

SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v","w"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}}),("w",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymInt 4),(VarName "v",SymVar String "v"),(VarName "w",SymVar String "w")], pc = []}

134. actual: ifFun7 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

135. actual: ifFun7 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 4)

136. actual: ifFun7 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 2

137. actual: ifFun7 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 2)

138. actual: ifFun7 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SymInt 0)

139. actual: ifFun7 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

140. actual: ifFun7 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

141. actual: ifFun7 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool True)

142. actual: ifFun7 ==> Next symExpr (MethodName "ifFun7" ==> SMethodType Void) in Method Call: ifFun7

143. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

144. actual: ifFun7 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Void

145. actual: ifFun7 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "ifFun7",SMethodType Void)

146. actual: ifFun7 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "ifFun7", er_val = SMethodType Void}

147. actual: ifFun7 ==> Next symExpr (GlobalVars ==> SGlobalVars ["v"]) in Method Call: ifFun7

148. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

149. actual: ifFun7 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars ["v"]

150. actual: ifFun7 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars ["v"])

151. actual: ifFun7 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars ["v"]}

152. actual: ifFun7 ==> Next symExpr (FormalParms ==> SFormalParms ["n"]) in Method Call: ifFun7

153. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

154. actual: ifFun7 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["n"]

155. actual: ifFun7 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["n"])

156. actual: ifFun7 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["n"]}

157. actual: ifFun7 ==> Next symExpr (VarAssignments ==> SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]) in Method Call: ifFun7

158. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

159. actual: ifFun7 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]

160. actual: ifFun7 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})])

161. actual: ifFun7 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]}

162. actual: ifFun7 ==> Next symExpr (VarName "n" ==> SymVar Int "n") in Method Call: ifFun7

163. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

164. actual: ifFun7 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

165. actual: ifFun7 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "n"

166. actual: ifFun7 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 4)

167. actual: ifFun7 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "n",SymInt 4)

168. actual: ifFun7 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymInt 4}

169. actual: ifFun7 ==> Next symExpr (VarName "v" ==> SymString "hi") in Method Call: ifFun7

170. actual: ifFun7 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

171. actual: ifFun7 ==> (visitSymExpr -> SymString): handling SymExpr: SymString "hi"

172. actual: ifFun7 ==> (visitSymExpr -> SymString): Modifying State: (VarName "v",SymString "hi")

173. actual: ifFun7 ==> (visitSymExpr -> SymString): Returning: ER_SymStateMapEntry {er_key = VarName "v", er_val = SymString "hi"}

174. actual: ifFun7 ==> (visitSymExpr -> SIte -> resolved condition is True -> else body exists): Modifying State: (<no key>,<whole state is updated>: SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymInt 4),(VarName "v",SymString "hi")], pc = []})

175. Method Call actual SymState: SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymInt 4),(VarName "v",SymString "hi")], pc = []}

176. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "ifFun7",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("v",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 4}})]),(VarName "n",SymInt 4),(VarName "v",SymString "hi")], pc = []})

177. (visitNode -> Node -> Statement): Returning: ER_Void

178. Next Node: End {id = 2, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

179. (visitNode -> End): Method End

180. (visitNode -> End -> return nothing): Void

181. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun7Call",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(VarName "v",SymString "hi")], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFun7Call",SMethodType Void),(GlobalVars,SGlobalVars ["v"]),(VarName "v",SymString "hi")], pc = []}