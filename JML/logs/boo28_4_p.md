================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo28_4_p" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo28_4_p

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo28_4_p",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28_4"}, funArgs = [NumberLiteral 10.0]})}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28_4"}, funArgs = [NumberLiteral 10.0]}

8. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28_4"}, funArgs = [NumberLiteral 10.0]}

9. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo28_4"}, funArgs = [NumberLiteral 10.0]}

10. formal: boo28_4 ==> Next Node: Entry (BuiltInType Int) "boo28_4" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

11. formal: boo28_4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

12. formal: boo28_4 ==> (visitNode -> Entry): Method Start: boo28_4

13. formal: boo28_4 ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

14. formal: boo28_4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

15. formal: boo28_4 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

16. formal: boo28_4 ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

17. formal: boo28_4 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

18. formal: boo28_4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

19. formal: boo28_4 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

20. formal: boo28_4 ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

21. formal: boo28_4 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

22. formal: boo28_4 ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

23. formal: boo28_4 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

24. formal: boo28_4 ==> Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

25. formal: boo28_4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

26. formal: boo28_4 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

27. formal: boo28_4 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

28. formal: boo28_4 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

29. formal: boo28_4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

30. formal: boo28_4 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int x

31. formal: boo28_4 ==> (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

32. formal: boo28_4 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

33. formal: boo28_4 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

34. formal: boo28_4 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

35. formal: boo28_4 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

36. formal: boo28_4 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

37. formal: boo28_4 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

38. formal: boo28_4 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

39. formal: boo28_4 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

40. formal: boo28_4 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})

41. formal: boo28_4 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})

42. formal: boo28_4 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

43. formal: boo28_4 ==> Next Node: Node {id = 2, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

44. formal: boo28_4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

45. formal: boo28_4 ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 2): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

46. formal: boo28_4 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

47. formal: boo28_4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

48. formal: boo28_4 ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

49. formal: boo28_4 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

50. formal: boo28_4 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

51. formal: boo28_4 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

52. formal: boo28_4 ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", >=, SymNum 0.0

53. formal: boo28_4 ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Ge (SymInt 0))

54. formal: boo28_4 ==> if statement ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}}), parent = 2}

55. formal: boo28_4 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

56. formal: boo28_4 ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}}

57. formal: boo28_4 ==> if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}

58. formal: boo28_4 ==> if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}

59. formal: boo28_4 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}

60. formal: boo28_4 ==> if statement ==> (visitExpr -> VarExpr): New Variable BuiltInType Int y

61. formal: boo28_4 ==> if statement ==> (visitExpr -> VarExpr): Modifying State: (y,SymNull Int)

62. formal: boo28_4 ==> if statement ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull Int}

63. formal: boo28_4 ==> if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

64. formal: boo28_4 ==> if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

65. formal: boo28_4 ==> if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

66. formal: boo28_4 ==> if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymNull Int
    New Value: SymInt 0

67. formal: boo28_4 ==> if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SymInt 0)

68. formal: boo28_4 ==> if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}

69. formal: boo28_4 ==> if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}

70. formal: boo28_4 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Binding: ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})

71. formal: boo28_4 ==> if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})

72. formal: boo28_4 ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}

73. formal: boo28_4 ==> if statement ==> Next Node: End {id = 4, parent = 2, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

74. formal: boo28_4 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

75. formal: boo28_4 ==> if statement ==> (visitNode -> End): Method End

76. formal: boo28_4 ==> if statement ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

77. formal: boo28_4 ==> if statement ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

78. formal: boo28_4 ==> if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

79. formal: boo28_4 ==> if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

80. formal: boo28_4 ==> if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

81. formal: boo28_4 ==> if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

82. formal: boo28_4 ==> if statement ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

83. formal: boo28_4 ==> if statement ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

84. formal: boo28_4 ==> else statement ==> Next Node: Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}}), parent = 2}

85. formal: boo28_4 ==> else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

86. formal: boo28_4 ==> else statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}}

87. formal: boo28_4 ==> else statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}

88. formal: boo28_4 ==> else statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}}

89. formal: boo28_4 ==> else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

90. formal: boo28_4 ==> else statement ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

91. formal: boo28_4 ==> else statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

92. formal: boo28_4 ==> else statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 1.0}

93. formal: boo28_4 ==> else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

94. formal: boo28_4 ==> else statement ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

95. formal: boo28_4 ==> else statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

96. formal: boo28_4 ==> else statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

97. formal: boo28_4 ==> else statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

98. formal: boo28_4 ==> else statement ==> (visitExpr -> BinOpExpr): Affected: SymInt 1, +, SymNum 1.0

99. formal: boo28_4 ==> else statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 2)

100. formal: boo28_4 ==> else statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}, ER_Expr (SymInt 2)

101. formal: boo28_4 ==> else statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymInt 1
    New Value: SymInt 2

102. formal: boo28_4 ==> else statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 2)

103. formal: boo28_4 ==> else statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

104. formal: boo28_4 ==> else statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

105. formal: boo28_4 ==> else statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})

106. formal: boo28_4 ==> else statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 2}

107. formal: boo28_4 ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 2,SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymVar Int "i")], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []})))

108. formal: boo28_4 ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymVar Int "i")], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []})))

109. formal: boo28_4 ==> Next Node: End {id = 7, parent = 0, mExpr = Just (NumberLiteral 5.0)}

110. formal: boo28_4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

111. formal: boo28_4 ==> (visitNode -> End): Method End

112. formal: boo28_4 ==> (visitNode -> End -> return something): handling return expression: NumberLiteral 5.0

113. formal: boo28_4 ==> (visitStmt -> ReturnStmt): handling return expression: NumberLiteral 5.0

114. formal: boo28_4 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

115. formal: boo28_4 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

116. formal: boo28_4 ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 5)

117. formal: boo28_4 ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SymNum 5.0)

118. formal: boo28_4 ==> (visitNode -> End -> method returns): Returning: ER_Expr (SymNum 5.0)

119. Method Call formal SymState: SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 6})],5)]),(ScopeRange (SR {branchStart = 2, branchEnd = 6}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymVar Int "i")], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []}))),(Return,SymInt 5)], pc = []}

120. SymExec of actual parameter: boo28_4(10.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 10.0

121. SymExec of actual parameter: boo28_4(10.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 10.0)

122. actual: boo28_4 ==> Next symExpr (MethodName "boo28_4" ==> SMethodType Int) in Method Call: boo28_4

123. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

124. actual: boo28_4 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

125. actual: boo28_4 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo28_4",SMethodType Int)

126. actual: boo28_4 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo28_4", er_val = SMethodType Int}

127. actual: boo28_4 ==> Next symExpr (GlobalVars ==> SGlobalVars []) in Method Call: boo28_4

128. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

129. actual: boo28_4 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars []

130. actual: boo28_4 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars [])

131. actual: boo28_4 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars []}

132. actual: boo28_4 ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo28_4

133. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

134. actual: boo28_4 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

135. actual: boo28_4 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

136. actual: boo28_4 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

137. actual: boo28_4 ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])) in Method Call: boo28_4

138. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

139. actual: boo28_4 ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])

140. actual: boo28_4 ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})]))

141. actual: boo28_4 ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])}

142. actual: boo28_4 ==> Next symExpr (VarAssignments ==> SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]) in Method Call: boo28_4

143. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

144. actual: boo28_4 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]

145. actual: boo28_4 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})])

146. actual: boo28_4 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]}

147. actual: boo28_4 ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo28_4

148. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

149. actual: boo28_4 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

150. actual: boo28_4 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

151. actual: boo28_4 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

152. actual: boo28_4 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SymInt 10)

153. actual: boo28_4 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymInt 10}

154. actual: boo28_4 ==> Next symExpr (VarName "x" ==> SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 6})],5)]) in Method Call: boo28_4

155. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

156. actual: boo28_4 ==> (visitSymExpr -> SymUnknown): handling SymExpr: SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 6})],5)]

157. actual: boo28_4 ==> (visitSymExpr -> SymUnknown): Modifying State: (VarName "x",SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 6})],5)])

158. actual: boo28_4 ==> (visitSymExpr0 -> SymUnknown): handling SymExpr: SymUnknown (Int,"x",Just (SymInt 1)) [([(If,SR {branchStart = 2, branchEnd = 6})],5)]

159. actual: boo28_4 ==> (Skip):
"visitSymExpr0 -> SymUnknown -> VarName x"

160. actual: boo28_4 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 1

161. actual: boo28_4 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 1)

162. actual: boo28_4 ==> (visitSymExpr0 -> SymUnknown): Returning: ER_Expr (SymInt 1)

163. actual: boo28_4 ==> (visitSymExpr -> SymUnknown): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

164. actual: boo28_4 ==> Next symExpr (ScopeRange (SR {branchStart = 2, branchEnd = 6}) ==> SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymVar Int "i")], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []}))) in Method Call: boo28_4

165. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

166. actual: boo28_4 ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymVar Int "i")], pc = []}) (Just (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymVar Int "i"),(VarName "x",SymInt 2)], pc = []}))

167. actual: boo28_4 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "i") Ge (SymInt 0)

SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("x",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1)], pc = []}

168. actual: boo28_4 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

169. actual: boo28_4 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

170. actual: boo28_4 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 0

171. actual: boo28_4 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 0)

172. actual: boo28_4 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool True)

173. actual: boo28_4 ==> Next symExpr (MethodName "boo28_4" ==> SMethodType Int) in Method Call: boo28_4

174. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

175. actual: boo28_4 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

176. actual: boo28_4 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo28_4",SMethodType Int)

177. actual: boo28_4 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo28_4", er_val = SMethodType Int}

178. actual: boo28_4 ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo28_4

179. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

180. actual: boo28_4 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

181. actual: boo28_4 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

182. actual: boo28_4 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

183. actual: boo28_4 ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])) in Method Call: boo28_4

184. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

185. actual: boo28_4 ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])

186. actual: boo28_4 ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]))

187. actual: boo28_4 ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])}

188. actual: boo28_4 ==> Next symExpr (VarAssignments ==> SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]) in Method Call: boo28_4

189. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

190. actual: boo28_4 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]

191. actual: boo28_4 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])

192. actual: boo28_4 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]}

193. actual: boo28_4 ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo28_4

194. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

195. actual: boo28_4 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

196. actual: boo28_4 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

197. actual: boo28_4 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

198. actual: boo28_4 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SymInt 10)

199. actual: boo28_4 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymInt 10}

200. actual: boo28_4 ==> Next symExpr (VarName "x" ==> SymInt 1) in Method Call: boo28_4

201. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

202. actual: boo28_4 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 1

203. actual: boo28_4 ==> (visitSymExpr -> SymInt): Modifying State: (VarName "x",SymInt 1)

204. actual: boo28_4 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

205. actual: boo28_4 ==> Next symExpr (VarName "y" ==> SymInt 0) in Method Call: boo28_4

206. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

207. actual: boo28_4 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 0

208. actual: boo28_4 ==> (visitSymExpr -> SymInt): Modifying State: (VarName "y",SymInt 0)

209. actual: boo28_4 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymInt 0}

210. actual: boo28_4 ==> Next symExpr (Return ==> SymVar Int "i") in Method Call: boo28_4

211. actual: boo28_4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

212. actual: boo28_4 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

213. actual: boo28_4 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

214. actual: boo28_4 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 10)

215. actual: boo28_4 ==> (visitSymExpr -> SymVar): Modifying State: (Return,SymInt 10)

216. actual: boo28_4 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 10}

217. actual: boo28_4 ==> (visitSymExpr -> SIte -> resolved condition is True -> else body exists): Modifying State: (<no key>,<whole state is updated>: SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymInt 10)], pc = []})

218. actual: boo28_4 ==> Next symExpr (Return ==> SymInt 5) in Method Call: boo28_4

219. actual: boo28_4 ==> (Skip):
"(Return,SymInt 5)"

220. Method Call actual SymState: SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymInt 10)], pc = []}

221. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymInt 10)], pc = []})

222. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 10)

223. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymInt 10)], pc = []})

224. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo28_4",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 2, branchEnd = 6}})]),(VarName "i",SymInt 10),(VarName "x",SymInt 1),(VarName "y",SymInt 0),(Return,SymInt 10)], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo28_4_p",SMethodType Int),(Return,SymInt 10)], pc = []}