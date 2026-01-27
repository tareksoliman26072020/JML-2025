================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "elemAt2call" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: elemAt2call

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "elemAt2call",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "elemAt2"}, funArgs = [NumberLiteral 2.0]})}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "elemAt2"}, funArgs = [NumberLiteral 2.0]}

8. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "elemAt2"}, funArgs = [NumberLiteral 2.0]}

9. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "elemAt2"}, funArgs = [NumberLiteral 2.0]}

10. formal: elemAt2 ==> Next Node: Entry (BuiltInType Int) "elemAt2" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}]

11. formal: elemAt2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

12. formal: elemAt2 ==> (visitNode -> Entry): Method Start: elemAt2

13. formal: elemAt2 ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}]

14. formal: elemAt2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}

15. formal: elemAt2 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int pos

16. formal: elemAt2 ==> (visitExpr -> VarExpr): Modifying State: (pos,SymNull Int)

17. formal: elemAt2 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymNull Int}

18. formal: elemAt2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}

19. formal: elemAt2 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int pos

20. formal: elemAt2 ==> (visitExpr -> VarExpr): Modifying State: (pos,SymNull Int)

21. formal: elemAt2 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymNull Int}

22. formal: elemAt2 ==> (visitNode -> Entry -> method with args): Modifying State: (pos,SymVar Int "pos")

23. formal: elemAt2 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarName "pos",SymVar Int "pos")], pc = []})

24. formal: elemAt2 ==> Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}}), parent = 0}

25. formal: elemAt2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

26. formal: elemAt2 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}}

27. formal: elemAt2 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}

28. formal: elemAt2 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}

29. formal: elemAt2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}

30. formal: elemAt2 ==> (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} arr

31. formal: elemAt2 ==> (visitExpr -> VarExpr): Modifying State: (arr,SymNull (Array Int))

32. formal: elemAt2 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}

33. formal: elemAt2 ==> (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}

34. formal: elemAt2 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 6.0

35. formal: elemAt2 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 6.0)

36. formal: elemAt2 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

37. formal: elemAt2 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

38. formal: elemAt2 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

39. formal: elemAt2 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

40. formal: elemAt2 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 7.0

41. formal: elemAt2 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 7.0)

42. formal: elemAt2 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 8.0

43. formal: elemAt2 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 8.0)

44. formal: elemAt2 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}, ER_Expr (SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8])

45. formal: elemAt2 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "arr"
    Old Value: SymNull (Array Int)
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]

46. formal: elemAt2 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8])

47. formal: elemAt2 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

48. formal: elemAt2 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

49. formal: elemAt2 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

50. formal: elemAt2 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

51. formal: elemAt2 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

52. formal: elemAt2 ==> Next Node: Node {id = 2, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}})), parent = 0}

53. formal: elemAt2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

54. formal: elemAt2 ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 2): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}

55. formal: elemAt2 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}

56. formal: elemAt2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}

57. formal: elemAt2 ==> (visitExpr ==> VarExpr): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymInt 5}

58. formal: elemAt2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "pos"}

59. formal: elemAt2 ==> (visitExpr -> VarExpr): Look up in environmane table: (pos ~~> SymVar Int "pos") 

60. formal: elemAt2 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymVar Int "pos"}

61. formal: elemAt2 ==> (visitExpr -> BinOpExpr): Affected: SymInt 5, <=, SymVar Int "pos"

62. formal: elemAt2 ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymInt 5) Le (SymVar Int "pos"))

63. formal: elemAt2 ==> if statement ==> Next Node: End {id = 3, parent = 2, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "not found"})}

64. formal: elemAt2 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

65. formal: elemAt2 ==> if statement ==> (visitNode -> End): Method End

66. formal: elemAt2 ==> if statement ==> (visitNode -> End -> return something): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

67. formal: elemAt2 ==> if statement ==> (visitStmt -> ReturnStmt): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

68. formal: elemAt2 ==> if statement ==> (visitStmt -> ExcpExpr): handling expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

69. formal: elemAt2 ==> if statement ==> (visitExpr -> ExcpExpr): Modifying State: (Exception,ExcpExpr {excpName = Exception, excpmsg = Just "not found"})

70. formal: elemAt2 ==> if statement ==> (visitExpr -> ExcpExpr): Returning: ER_Expr (SException Int "Exception" "not found")

71. formal: elemAt2 ==> if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SException Int "Exception" "not found")

72. formal: elemAt2 ==> if statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SException Int "Exception" "not found")

73. formal: elemAt2 ==> if statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SException Int "Exception" "not found")

74. formal: elemAt2 ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 2,SIte (SBin (SymInt 5) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing)

75. formal: elemAt2 ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymInt 5) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing)

76. formal: elemAt2 ==> Next Node: End {id = 5, parent = 0, mExpr = Just (ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})})}

77. formal: elemAt2 ==> >>>>>>>>>> visitNode <<<<<<<<<<

78. formal: elemAt2 ==> (visitNode -> End): Method End

79. formal: elemAt2 ==> (visitNode -> End -> return something): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})}

80. formal: elemAt2 ==> (visitStmt -> ReturnStmt): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})}

81. formal: elemAt2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "arr"}

82. formal: elemAt2 ==> (visitExpr -> VarExpr): Look up in environmane table: (arr ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]) 

83. formal: elemAt2 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

84. formal: elemAt2 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "pos"}

85. formal: elemAt2 ==> (visitExpr -> VarExpr): Look up in environmane table: (pos ~~> SymVar Int "pos") 

86. formal: elemAt2 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymVar Int "pos"}

87. formal: elemAt2 ==> (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

88. formal: elemAt2 ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SArrayIndexAccess "arr" (SymVar Int "pos"))

89. formal: elemAt2 ==> (visitStmt -> ReturnStmt): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

90. formal: elemAt2 ==> (visitNode -> End -> method returns): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

91. Method Call formal SymState: SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymInt 5) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing),(Return,SArrayIndexAccess "arr" (SymVar Int "pos"))], pc = []}

92. SymExec of actual parameter: elemAt2(2.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

93. SymExec of actual parameter: elemAt2(2.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

94. actual: elemAt2 ==> Next symExpr (MethodName "elemAt2" ==> SMethodType Int) in Method Call: elemAt2

95. actual: elemAt2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

96. actual: elemAt2 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

97. actual: elemAt2 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "elemAt2",SMethodType Int)

98. actual: elemAt2 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "elemAt2", er_val = SMethodType Int}

99. actual: elemAt2 ==> Next symExpr (GlobalVars ==> SGlobalVars []) in Method Call: elemAt2

100. actual: elemAt2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

101. actual: elemAt2 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars []

102. actual: elemAt2 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars [])

103. actual: elemAt2 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars []}

104. actual: elemAt2 ==> Next symExpr (FormalParms ==> SFormalParms ["pos"]) in Method Call: elemAt2

105. actual: elemAt2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

106. actual: elemAt2 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["pos"]

107. actual: elemAt2 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["pos"])

108. actual: elemAt2 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["pos"]}

109. actual: elemAt2 ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])) in Method Call: elemAt2

110. actual: elemAt2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

111. actual: elemAt2 ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])

112. actual: elemAt2 ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]))

113. actual: elemAt2 ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])}

114. actual: elemAt2 ==> Next symExpr (VarAssignments ==> SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]) in Method Call: elemAt2

115. actual: elemAt2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

116. actual: elemAt2 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]

117. actual: elemAt2 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])

118. actual: elemAt2 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]}

119. actual: elemAt2 ==> Next symExpr (VarName "arr" ==> SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]) in Method Call: elemAt2

120. actual: elemAt2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

121. actual: elemAt2 ==> (visitSymExpr -> SymArray): handling SymExpr: SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]

122. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 6

123. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 6)

124. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 5

125. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 5)

126. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 4

127. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 4)

128. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 7

129. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 7)

130. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 8

131. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 8)

132. actual: elemAt2 ==> (visitSymExpr -> SymArray): Modifying State: (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8])

133. actual: elemAt2 ==> (visitSymExpr -> SymArray): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

134. actual: elemAt2 ==> Next symExpr (VarName "pos" ==> SymVar Int "pos") in Method Call: elemAt2

135. actual: elemAt2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

136. actual: elemAt2 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "pos"

137. actual: elemAt2 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "pos"

138. actual: elemAt2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 2)

139. actual: elemAt2 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "pos",SymInt 2)

140. actual: elemAt2 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymInt 2}

141. actual: elemAt2 ==> Next symExpr (ScopeRange (SR {branchStart = 2, branchEnd = 4}) ==> SIte (SBin (SymInt 5) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing) in Method Call: elemAt2

142. actual: elemAt2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

143. actual: elemAt2 ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SymInt 5) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing

144. actual: elemAt2 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymInt 5) Le (SymVar Int "pos")

SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2)], pc = []}

145. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 5

146. actual: elemAt2 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 5)

147. actual: elemAt2 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "pos"

148. actual: elemAt2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 2)

149. actual: elemAt2 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool False)

150. actual: elemAt2 ==> (visitSymExpr -> SIte -> resolved condition is False -> no else body): State Not Modified

151. actual: elemAt2 ==> Next symExpr (Return ==> SArrayIndexAccess "arr" (SymVar Int "pos")) in Method Call: elemAt2

152. actual: elemAt2 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

153. actual: elemAt2 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "pos"

154. actual: elemAt2 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 2)

155. actual: elemAt2 ==> (visitSymExpr -> SArrayIndexAccess): Modifying State: (Return,SymInt 4)

156. actual: elemAt2 ==> (visitSymExpr -> SArrayIndexAccess): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 4}

157. Method Call actual SymState: SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2),(Return,SymInt 4)], pc = []}

158. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2),(Return,SymInt 4)], pc = []})

159. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 4)

160. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2),(Return,SymInt 4)], pc = []})

161. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2),(Return,SymInt 4)], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "elemAt2call",SMethodType Int),(Return,SymInt 4)], pc = []}