================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo22_i_4" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo22_i_4

3. (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

4. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

5. (visitExpr -> VarExpr): New Variable BuiltInType Int i

6. (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

7. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

8. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

9. (visitExpr -> VarExpr): New Variable BuiltInType Int i

10. (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

11. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

12. (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo22_i_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: End {id = 1, parent = 0, mExpr = Just (BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_3_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}, binOp = *, expr2 = NumberLiteral 5.0})}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> End): Method End

16. (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_3_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}, binOp = *, expr2 = NumberLiteral 5.0}

17. (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_3_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}, binOp = *, expr2 = NumberLiteral 5.0}

18. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_3_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}, binOp = *, expr2 = NumberLiteral 5.0}

19. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_3_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}

20. formal: boo21_3_i ==> Next Node: Entry (BuiltInType Int) "boo21_3_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

21. formal: boo21_3_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

22. formal: boo21_3_i ==> (visitNode -> Entry): Method Start: boo21_3_i

23. formal: boo21_3_i ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

24. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

25. formal: boo21_3_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

26. formal: boo21_3_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

27. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

28. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

29. formal: boo21_3_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

30. formal: boo21_3_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

31. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

32. formal: boo21_3_i ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

33. formal: boo21_3_i ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

34. formal: boo21_3_i ==> Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}}), parent = 0}

35. formal: boo21_3_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

36. formal: boo21_3_i ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}}

37. formal: boo21_3_i ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}

38. formal: boo21_3_i ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}

39. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

40. formal: boo21_3_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

41. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

42. formal: boo21_3_i ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}

43. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

44. formal: boo21_3_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

45. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

46. formal: boo21_3_i ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

47. formal: boo21_3_i ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

48. formal: boo21_3_i ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", +, SymNum 2.0

49. formal: boo21_3_i ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

50. formal: boo21_3_i ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}, ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

51. formal: boo21_3_i ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "i"
    Old Value: SymVar Int "i"
    New Value: SBin (SymVar Int "i") Add (SymInt 2)

52. formal: boo21_3_i ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "i",SBin (SymVar Int "i") Add (SymInt 2))

53. formal: boo21_3_i ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

54. formal: boo21_3_i ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

55. formal: boo21_3_i ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

56. formal: boo21_3_i ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

57. formal: boo21_3_i ==> Next Node: End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

58. formal: boo21_3_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

59. formal: boo21_3_i ==> (visitNode -> End): Method End

60. formal: boo21_3_i ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

61. formal: boo21_3_i ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

62. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

63. formal: boo21_3_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SBin (SymVar Int "i") Add (SymInt 2)) 

64. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

65. formal: boo21_3_i ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymVar Int "i") Add (SymInt 2))

66. formal: boo21_3_i ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

67. formal: boo21_3_i ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

68. Method Call formal SymState: SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []}

69. SymExec of actual parameter: boo21_3_i(i+4.0) ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}

70. SymExec of actual parameter: boo21_3_i(i+4.0) ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

71. SymExec of actual parameter: boo21_3_i(i+4.0) ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

72. SymExec of actual parameter: boo21_3_i(i+4.0) ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

73. SymExec of actual parameter: boo21_3_i(i+4.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

74. SymExec of actual parameter: boo21_3_i(i+4.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

75. SymExec of actual parameter: boo21_3_i(i+4.0) ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", +, SymNum 4.0

76. SymExec of actual parameter: boo21_3_i(i+4.0) ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 4))

77. actual: boo21_3_i ==> Next symExpr (MethodName "boo21_3_i" ==> SMethodType Int) in Method Call: boo21_3_i

78. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

79. actual: boo21_3_i ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

80. actual: boo21_3_i ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo21_3_i",SMethodType Int)

81. actual: boo21_3_i ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo21_3_i", er_val = SMethodType Int}

82. actual: boo21_3_i ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo21_3_i

83. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

84. actual: boo21_3_i ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

85. actual: boo21_3_i ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

86. actual: boo21_3_i ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

87. actual: boo21_3_i ==> Next symExpr (VarAssignments ==> SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]) in Method Call: boo21_3_i

88. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

89. actual: boo21_3_i ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]

90. actual: boo21_3_i ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])

91. actual: boo21_3_i ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]}

92. actual: boo21_3_i ==> Next symExpr (VarName "i" ==> SBin (SymVar Int "i") Add (SymInt 2)) in Method Call: boo21_3_i

93. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

94. actual: boo21_3_i ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 2)

95. actual: boo21_3_i ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 2)

SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])], pc = []}

96. actual: boo21_3_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

97. actual: boo21_3_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 4))

98. actual: boo21_3_i ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 2

99. actual: boo21_3_i ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 2)

100. actual: boo21_3_i ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 6))

101. actual: boo21_3_i ==> (visitSymExpr -> SBin): Modifying State: (VarName "i",SBin (SymVar Int "i") Add (SymInt 6))

102. actual: boo21_3_i ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 6)}

103. actual: boo21_3_i ==> Next symExpr (Return ==> SBin (SymVar Int "i") Add (SymInt 2)) in Method Call: boo21_3_i

104. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

105. actual: boo21_3_i ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 2)

106. actual: boo21_3_i ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 2)

SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 6))], pc = []}

107. actual: boo21_3_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

108. actual: boo21_3_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 4))

109. actual: boo21_3_i ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 2

110. actual: boo21_3_i ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 2)

111. actual: boo21_3_i ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 6))

112. actual: boo21_3_i ==> (visitSymExpr -> SBin): Modifying State: (Return,SBin (SymVar Int "i") Add (SymInt 6))

113. actual: boo21_3_i ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SBin (SymVar Int "i") Add (SymInt 6)}

114. Method Call actual SymState: SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 6)),(Return,SBin (SymVar Int "i") Add (SymInt 6))], pc = []}

115. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 6)),(Return,SBin (SymVar Int "i") Add (SymInt 6))], pc = []})

116. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

117. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

118. (visitExpr -> BinOpExpr): Affected: SBin (SymVar Int "i") Add (SymInt 6), *, SymNum 5.0

119. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SBin (SymVar Int "i") Add (SymInt 6)) Mul (SymInt 5))

120. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SBin (SymVar Int "i") Add (SymInt 6)) Mul (SymInt 5))

121. (visitStmt -> ReturnStmt): Returning: ER_Expr (SBin (SBin (SymVar Int "i") Add (SymInt 6)) Mul (SymInt 5))

122. (visitNode -> End -> method returns): Returning: ER_Expr (SBin (SBin (SymVar Int "i") Add (SymInt 6)) Mul (SymInt 5))
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo22_i_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SBin (SBin (SymVar Int "i") Add (SymInt 6)) Mul (SymInt 5))], pc = []}