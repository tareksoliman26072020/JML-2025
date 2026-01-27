================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "elemAtCall" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: elemAtCall

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "elemAtCall",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "elemAt"}, funArgs = [ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]},NumberLiteral 2.0]})}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "elemAt"}, funArgs = [ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]},NumberLiteral 2.0]}

8. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "elemAt"}, funArgs = [ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]},NumberLiteral 2.0]}

9. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "elemAt"}, funArgs = [ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]},NumberLiteral 2.0]}

10. formal: elemAt ==> Next Node: Entry (BuiltInType Int) "elemAt" [VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"},VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}]

11. formal: elemAt ==> >>>>>>>>>> visitNode <<<<<<<<<<

12. formal: elemAt ==> (visitNode -> Entry): Method Start: elemAt

13. formal: elemAt ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"},VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}]

14. formal: elemAt ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}

15. formal: elemAt ==> (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} arr

16. formal: elemAt ==> (visitExpr -> VarExpr): Modifying State: (arr,SymNull (Array Int))

17. formal: elemAt ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}

18. formal: elemAt ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}

19. formal: elemAt ==> (visitExpr -> VarExpr): New Variable BuiltInType Int pos

20. formal: elemAt ==> (visitExpr -> VarExpr): Modifying State: (pos,SymNull Int)

21. formal: elemAt ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymNull Int}

22. formal: elemAt ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}

23. formal: elemAt ==> (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} arr

24. formal: elemAt ==> (visitExpr -> VarExpr): Modifying State: (arr,SymNull (Array Int))

25. formal: elemAt ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}

26. formal: elemAt ==> (visitNode -> Entry -> method with args): Modifying State: (arr,SymVar (Array Int) "arr")

27. formal: elemAt ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}

28. formal: elemAt ==> (visitExpr -> VarExpr): New Variable BuiltInType Int pos

29. formal: elemAt ==> (visitExpr -> VarExpr): Modifying State: (pos,SymNull Int)

30. formal: elemAt ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymNull Int}

31. formal: elemAt ==> (visitNode -> Entry -> method with args): Modifying State: (pos,SymVar Int "pos")

32. formal: elemAt ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos")], pc = []})

33. formal: elemAt ==> Next Node: Node {id = 1, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}})), parent = 0}

34. formal: elemAt ==> >>>>>>>>>> visitNode <<<<<<<<<<

35. formal: elemAt ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 1): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}

36. formal: elemAt ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}

37. formal: elemAt ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}

38. formal: elemAt ==> (visitExpr ==> VarExpr): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SObjAcc ["arr","length"]}

39. formal: elemAt ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "pos"}

40. formal: elemAt ==> (visitExpr -> VarExpr): Look up in environmane table: (pos ~~> SymVar Int "pos") 

41. formal: elemAt ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymVar Int "pos"}

42. formal: elemAt ==> (visitExpr -> BinOpExpr): Affected: SObjAcc ["arr","length"], <=, SymVar Int "pos"

43. formal: elemAt ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos"))

44. formal: elemAt ==> if statement ==> Next Node: End {id = 2, parent = 1, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "not found"})}

45. formal: elemAt ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

46. formal: elemAt ==> if statement ==> (visitNode -> End): Method End

47. formal: elemAt ==> if statement ==> (visitNode -> End -> return something): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

48. formal: elemAt ==> if statement ==> (visitStmt -> ReturnStmt): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

49. formal: elemAt ==> if statement ==> (visitStmt -> ExcpExpr): handling expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

50. formal: elemAt ==> if statement ==> (visitExpr -> ExcpExpr): Modifying State: (Exception,ExcpExpr {excpName = Exception, excpmsg = Just "not found"})

51. formal: elemAt ==> if statement ==> (visitExpr -> ExcpExpr): Returning: ER_Expr (SException Int "Exception" "not found")

52. formal: elemAt ==> if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SException Int "Exception" "not found")

53. formal: elemAt ==> if statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SException Int "Exception" "not found")

54. formal: elemAt ==> if statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SException Int "Exception" "not found")

55. formal: elemAt ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 1,SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing)

56. formal: elemAt ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing)

57. formal: elemAt ==> Next Node: End {id = 4, parent = 0, mExpr = Just (ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})})}

58. formal: elemAt ==> >>>>>>>>>> visitNode <<<<<<<<<<

59. formal: elemAt ==> (visitNode -> End): Method End

60. formal: elemAt ==> (visitNode -> End -> return something): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})}

61. formal: elemAt ==> (visitStmt -> ReturnStmt): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})}

62. formal: elemAt ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "arr"}

63. formal: elemAt ==> (visitExpr -> VarExpr): Look up in environmane table: (arr ~~> SymVar (Array Int) "arr") 

64. formal: elemAt ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymVar (Array Int) "arr"}

65. formal: elemAt ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "pos"}

66. formal: elemAt ==> (visitExpr -> VarExpr): Look up in environmane table: (pos ~~> SymVar Int "pos") 

67. formal: elemAt ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymVar Int "pos"}

68. formal: elemAt ==> (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

69. formal: elemAt ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SArrayIndexAccess "arr" (SymVar Int "pos"))

70. formal: elemAt ==> (visitStmt -> ReturnStmt): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

71. formal: elemAt ==> (visitNode -> End -> method returns): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

72. Method Call formal SymState: SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["arr","pos"]),(VarAssignments,SVarAssignments []),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(ScopeRange (SR {branchStart = 1, branchEnd = 3}),SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing),(Return,SArrayIndexAccess "arr" (SymVar Int "pos"))], pc = []}

73. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}

74. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 6.0

75. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 6.0)

76. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

77. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

78. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

79. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

80. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 7.0

81. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 7.0)

82. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 8.0

83. SymExec of actual parameter: elemAt({6.0, 5.0, 4.0, 7.0, 8.0}) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 8.0)

84. SymExec of actual parameter: elemAt(2.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

85. SymExec of actual parameter: elemAt(2.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

86. actual: elemAt ==> Next symExpr (MethodName "elemAt" ==> SMethodType Int) in Method Call: elemAt

87. actual: elemAt ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

88. actual: elemAt ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

89. actual: elemAt ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "elemAt",SMethodType Int)

90. actual: elemAt ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "elemAt", er_val = SMethodType Int}

91. actual: elemAt ==> Next symExpr (GlobalVars ==> SGlobalVars []) in Method Call: elemAt

92. actual: elemAt ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

93. actual: elemAt ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars []

94. actual: elemAt ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars [])

95. actual: elemAt ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars []}

96. actual: elemAt ==> Next symExpr (FormalParms ==> SFormalParms ["arr","pos"]) in Method Call: elemAt

97. actual: elemAt ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

98. actual: elemAt ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["arr","pos"]

99. actual: elemAt ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["arr","pos"])

100. actual: elemAt ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["arr","pos"]}

101. actual: elemAt ==> Next symExpr (VarAssignments ==> SVarAssignments []) in Method Call: elemAt

102. actual: elemAt ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

103. actual: elemAt ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments []

104. actual: elemAt ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [])

105. actual: elemAt ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments []}

106. actual: elemAt ==> Next symExpr (VarName "arr" ==> SymVar (Array Int) "arr") in Method Call: elemAt

107. actual: elemAt ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

108. actual: elemAt ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar (Array Int) "arr"

109. actual: elemAt ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar (Array Int) "arr"

110. actual: elemAt ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8])

111. actual: elemAt ==> (visitSymExpr -> SymVar): Modifying State: (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8])

112. actual: elemAt ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

113. actual: elemAt ==> Next symExpr (VarName "pos" ==> SymVar Int "pos") in Method Call: elemAt

114. actual: elemAt ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

115. actual: elemAt ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "pos"

116. actual: elemAt ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "pos"

117. actual: elemAt ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 2)

118. actual: elemAt ==> (visitSymExpr -> SymVar): Modifying State: (VarName "pos",SymInt 2)

119. actual: elemAt ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymInt 2}

120. actual: elemAt ==> Next symExpr (ScopeRange (SR {branchStart = 1, branchEnd = 3}) ==> SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing) in Method Call: elemAt

121. actual: elemAt ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

122. actual: elemAt ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing

123. actual: elemAt ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")

SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["arr","pos"]),(VarAssignments,SVarAssignments []),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2)], pc = []}

124. actual: elemAt ==> (visitSymExpr0 -> SObjAcc): handling SymExpr: SObjAcc ["arr","length"]

125. actual: elemAt ==> (visitSymExpr0 -> SObjAcc): Returning: ER_Expr (SymInt 5)

126. actual: elemAt ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "pos"

127. actual: elemAt ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 2)

128. actual: elemAt ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool False)

129. actual: elemAt ==> (visitSymExpr -> SIte -> resolved condition is False -> no else body): State Not Modified

130. actual: elemAt ==> Next symExpr (Return ==> SArrayIndexAccess "arr" (SymVar Int "pos")) in Method Call: elemAt

131. actual: elemAt ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

132. actual: elemAt ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "pos"

133. actual: elemAt ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 2)

134. actual: elemAt ==> (visitSymExpr -> SArrayIndexAccess): Modifying State: (Return,SymInt 4)

135. actual: elemAt ==> (visitSymExpr -> SArrayIndexAccess): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 4}

136. Method Call actual SymState: SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["arr","pos"]),(VarAssignments,SVarAssignments []),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2),(Return,SymInt 4)], pc = []}

137. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["arr","pos"]),(VarAssignments,SVarAssignments []),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2),(Return,SymInt 4)], pc = []})

138. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 4)

139. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["arr","pos"]),(VarAssignments,SVarAssignments []),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2),(Return,SymInt 4)], pc = []})

140. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["arr","pos"]),(VarAssignments,SVarAssignments []),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymInt 2),(Return,SymInt 4)], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "elemAtCall",SMethodType Int),(Return,SymInt 4)], pc = []}