================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo22_i_3" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo22_i_3

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo22_i_3",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_3_i"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "i"}]})}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> End): Method End

16. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_3_i"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "i"}]}

17. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_3_i"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "i"}]}

18. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_3_i"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "i"}]}

19. formal: boo21_3_i ==> Next Node: Entry (BuiltInType Int) "boo21_3_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

20. formal: boo21_3_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

21. formal: boo21_3_i ==> (visitNode -> Entry): Method Start: boo21_3_i

22. formal: boo21_3_i ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

23. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

24. formal: boo21_3_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

25. formal: boo21_3_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

26. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

27. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

28. formal: boo21_3_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

29. formal: boo21_3_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

30. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

31. formal: boo21_3_i ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

32. formal: boo21_3_i ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

33. formal: boo21_3_i ==> Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}}), parent = 0}

34. formal: boo21_3_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

35. formal: boo21_3_i ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}}

36. formal: boo21_3_i ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}

37. formal: boo21_3_i ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}

38. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

39. formal: boo21_3_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

40. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

41. formal: boo21_3_i ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}

42. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

43. formal: boo21_3_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

44. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

45. formal: boo21_3_i ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

46. formal: boo21_3_i ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

47. formal: boo21_3_i ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", +, SymNum 2.0

48. formal: boo21_3_i ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

49. formal: boo21_3_i ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}, ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

50. formal: boo21_3_i ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "i"
    Old Value: SymVar Int "i"
    New Value: SBin (SymVar Int "i") Add (SymInt 2)

51. formal: boo21_3_i ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "i",SBin (SymVar Int "i") Add (SymInt 2))

52. formal: boo21_3_i ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

53. formal: boo21_3_i ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

54. formal: boo21_3_i ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

55. formal: boo21_3_i ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

56. formal: boo21_3_i ==> Next Node: End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

57. formal: boo21_3_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

58. formal: boo21_3_i ==> (visitNode -> End): Method End

59. formal: boo21_3_i ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

60. formal: boo21_3_i ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

61. formal: boo21_3_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

62. formal: boo21_3_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SBin (SymVar Int "i") Add (SymInt 2)) 

63. formal: boo21_3_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

64. formal: boo21_3_i ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymVar Int "i") Add (SymInt 2))

65. formal: boo21_3_i ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

66. formal: boo21_3_i ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

67. Method Call formal SymState: SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []}

68. SymExec of actual parameter: boo21_3_i(i) ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

69. SymExec of actual parameter: boo21_3_i(i) ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

70. SymExec of actual parameter: boo21_3_i(i) ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

71. actual: boo21_3_i ==> Next symExpr (MethodName "boo21_3_i" ==> SMethodType Int) in Method Call: boo21_3_i

72. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

73. actual: boo21_3_i ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

74. actual: boo21_3_i ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo21_3_i",SMethodType Int)

75. actual: boo21_3_i ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo21_3_i", er_val = SMethodType Int}

76. actual: boo21_3_i ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo21_3_i

77. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

78. actual: boo21_3_i ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

79. actual: boo21_3_i ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

80. actual: boo21_3_i ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

81. actual: boo21_3_i ==> Next symExpr (VarAssignments ==> SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]) in Method Call: boo21_3_i

82. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

83. actual: boo21_3_i ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]

84. actual: boo21_3_i ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])

85. actual: boo21_3_i ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]}

86. actual: boo21_3_i ==> Next symExpr (VarName "i" ==> SBin (SymVar Int "i") Add (SymInt 2)) in Method Call: boo21_3_i

87. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

88. actual: boo21_3_i ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 2)

89. actual: boo21_3_i ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 2)

SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])], pc = []}

90. actual: boo21_3_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

91. actual: boo21_3_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymVar Int "i")

92. actual: boo21_3_i ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 2

93. actual: boo21_3_i ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 2)

94. actual: boo21_3_i ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

95. actual: boo21_3_i ==> (visitSymExpr -> SBin): Modifying State: (VarName "i",SBin (SymVar Int "i") Add (SymInt 2))

96. actual: boo21_3_i ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

97. actual: boo21_3_i ==> Next symExpr (Return ==> SBin (SymVar Int "i") Add (SymInt 2)) in Method Call: boo21_3_i

98. actual: boo21_3_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

99. actual: boo21_3_i ==> (visitSymExpr -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 2)

100. actual: boo21_3_i ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "i") Add (SymInt 2)

SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2))], pc = []}

101. actual: boo21_3_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

102. actual: boo21_3_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymVar Int "i")

103. actual: boo21_3_i ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 2

104. actual: boo21_3_i ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 2)

105. actual: boo21_3_i ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

106. actual: boo21_3_i ==> (visitSymExpr -> SBin): Modifying State: (Return,SBin (SymVar Int "i") Add (SymInt 2))

107. actual: boo21_3_i ==> (visitSymExpr -> SBin): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SBin (SymVar Int "i") Add (SymInt 2)}

108. Method Call actual SymState: SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []}

109. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []})

110. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymVar Int "i") Add (SymInt 2))

111. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []})

112. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo22_i_3",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []}