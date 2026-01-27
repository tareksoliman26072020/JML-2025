================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Void) "voidFun5" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: voidFun5

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "voidFun5",SMethodType Void)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "Before"]}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "Before"]}}

7. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "Before"]}

8. (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[StringLiteral "Before"]

9. (visitExpr -> StringLiteral): handling expression: StringLiteral "Before"

10. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "Before")

11. (visitExpr ==> FunCallExpr): Returning: ER_Print "Before\n"

12. (visitStmt -> FunCallStmt): Modifying State: (SActions,Before
)

13. (visitStmt -> FunCallStmt): Returning: ER_Print "Before\n"

14. (visitNode -> Node -> Statement): Returning: ER_Print "Before\n"

15. Next Node: Node {id = 2, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "voidFun4"}, funArgs = []}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

16. (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "voidFun4"}, funArgs = []}}

17. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "voidFun4"}, funArgs = []}

18. formal: voidFun4 ==> Next Node: Entry (BuiltInType Void) "voidFun4" []

19. formal: voidFun4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

20. formal: voidFun4 ==> (visitNode -> Entry): Method Start: voidFun4

21. formal: voidFun4 ==> (visitNode -> Entry -> method with no args): Returning: ()

22. formal: voidFun4 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "voidFun4",SMethodType Void)], pc = []})

23. formal: voidFun4 ==> Next Node: Node {id = 1, nodeData = Statement (VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}}), parent = 0}

24. formal: voidFun4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

25. formal: voidFun4 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}}

26. formal: voidFun4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

27. formal: voidFun4 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int x

28. formal: voidFun4 ==> (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

29. formal: voidFun4 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

30. formal: voidFun4 ==> (visitStmt -> VarStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

31. formal: voidFun4 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})

32. formal: voidFun4 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

33. formal: voidFun4 ==> Next Node: Node {id = 2, nodeData = Statement (VarStmt {var = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "y"}}), parent = 0}

34. formal: voidFun4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

35. formal: voidFun4 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: VarStmt {var = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "y"}}

36. formal: voidFun4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "y"}

37. formal: voidFun4 ==> (visitExpr -> VarExpr): New Variable AnyType {typee = "String", generic = Nothing} y

38. formal: voidFun4 ==> (visitExpr -> VarExpr): Modifying State: (y,SymNull String)

39. formal: voidFun4 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}

40. formal: voidFun4 ==> (visitStmt -> VarStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}

41. formal: voidFun4 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}})

42. formal: voidFun4 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}

43. formal: voidFun4 ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

44. formal: voidFun4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

45. formal: voidFun4 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

46. formal: voidFun4 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

47. formal: voidFun4 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

48. formal: voidFun4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

49. formal: voidFun4 ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymNull Int) 

50. formal: voidFun4 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

51. formal: voidFun4 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

52. formal: voidFun4 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

53. formal: voidFun4 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

54. formal: voidFun4 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

55. formal: voidFun4 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

56. formal: voidFun4 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

57. formal: voidFun4 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

58. formal: voidFun4 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}})

59. formal: voidFun4 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

60. formal: voidFun4 ==> Next Node: Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = StringLiteral "is one"}}), parent = 0}

61. formal: voidFun4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

62. formal: voidFun4 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = StringLiteral "is one"}}

63. formal: voidFun4 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = StringLiteral "is one"}

64. formal: voidFun4 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = StringLiteral "is one"}

65. formal: voidFun4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

66. formal: voidFun4 ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymNull String) 

67. formal: voidFun4 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}

68. formal: voidFun4 ==> (visitExpr -> StringLiteral): handling expression: StringLiteral "is one"

69. formal: voidFun4 ==> (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "is one")

70. formal: voidFun4 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}, ER_Expr (SymString "is one")

71. formal: voidFun4 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymNull String
    New Value: SymString "is one"

72. formal: voidFun4 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SymString "is one")

73. formal: voidFun4 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymString "is one"}

74. formal: voidFun4 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymString "is one"}

75. formal: voidFun4 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}})

76. formal: voidFun4 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymString "is one"}

77. formal: voidFun4 ==> Next Node: Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}}), parent = 0}

78. formal: voidFun4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

79. formal: voidFun4 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}}

80. formal: voidFun4 ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}

81. formal: voidFun4 ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}

82. formal: voidFun4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}

83. formal: voidFun4 ==> (visitExpr -> VarExpr): New Variable AnyType {typee = "String", generic = Nothing} z

84. formal: voidFun4 ==> (visitExpr -> VarExpr): Modifying State: (z,SymNull String)

85. formal: voidFun4 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNull String}

86. formal: voidFun4 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

87. formal: voidFun4 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}

88. formal: voidFun4 ==> (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}

89. formal: voidFun4 ==> (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "toString"}[VarExpr {varType = Nothing, varObj = [], varName = "x"}]

90. formal: voidFun4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

91. formal: voidFun4 ==> (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

92. formal: voidFun4 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

93. formal: voidFun4 ==> (visitExpr ==> FunCallExpr): Returning: ER_Expr (SymString "1")

94. formal: voidFun4 ==> (visitExpr -> StringLiteral): handling expression: StringLiteral " "

95. formal: voidFun4 ==> (visitExpr -> StringLiteral): Returning: ER_Expr (SymString " ")

96. formal: voidFun4 ==> (visitExpr -> BinOpExpr): Affected: SymString "1", +, SymString " "

97. formal: voidFun4 ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymString "1 ")

98. formal: voidFun4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

99. formal: voidFun4 ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymString "is one") 

100. formal: voidFun4 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymString "is one"}

101. formal: voidFun4 ==> (visitExpr -> BinOpExpr): Affected: SymString "1 ", +, SymString "is one"

102. formal: voidFun4 ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymString "1 is one")

103. formal: voidFun4 ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNull String}, ER_Expr (SymString "1 is one")

104. formal: voidFun4 ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "z"
    Old Value: SymNull String
    New Value: SymString "1 is one"

105. formal: voidFun4 ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "z",SymString "1 is one")

106. formal: voidFun4 ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymString "1 is one"}

107. formal: voidFun4 ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymString "1 is one"}

108. formal: voidFun4 ==> (visitNode -> Node -> Statement): Adding Var Binding: ("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})

109. formal: voidFun4 ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})

110. formal: voidFun4 ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymString "1 is one"}

111. formal: voidFun4 ==> Next Node: Node {id = 6, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "z"}]}}), parent = 0}

112. formal: voidFun4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

113. formal: voidFun4 ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "z"}]}}

114. formal: voidFun4 ==> (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "z"}]}

115. formal: voidFun4 ==> (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[VarExpr {varType = Nothing, varObj = [], varName = "z"}]

116. formal: voidFun4 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "z"}

117. formal: voidFun4 ==> (visitExpr -> VarExpr): Look up in environmane table: (z ~~> SymString "1 is one") 

118. formal: voidFun4 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymString "1 is one"}

119. formal: voidFun4 ==> (visitExpr ==> FunCallExpr): Returning: ER_Print "1 is one\n"

120. formal: voidFun4 ==> (visitStmt -> FunCallStmt): Modifying State: (SActions,1 is one
)

121. formal: voidFun4 ==> (visitStmt -> FunCallStmt): Returning: ER_Print "1 is one\n"

122. formal: voidFun4 ==> (visitNode -> Node -> Statement): Returning: ER_Print "1 is one\n"

123. formal: voidFun4 ==> Next Node: End {id = 7, parent = 0, mExpr = Nothing}

124. formal: voidFun4 ==> >>>>>>>>>> visitNode <<<<<<<<<<

125. formal: voidFun4 ==> (visitNode -> End): Method End

126. formal: voidFun4 ==> (visitNode -> End -> return nothing): Void

127. formal: voidFun4 ==> (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "voidFun4",SMethodType Void),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]),(VarName "x",SymInt 1),(VarName "y",SymString "is one"),(VarName "z",SymString "1 is one"),(Actions,SActions ["1 is one\n"])], pc = []})

128. Method Call formal SymState: SymState {env = fromList [(MethodName "voidFun4",SMethodType Void),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]),(VarName "x",SymInt 1),(VarName "y",SymString "is one"),(VarName "z",SymString "1 is one"),(Actions,SActions ["1 is one\n"])], pc = []}

129. (visitExpr -> FunCallExpr -> inheriting actions): Modifying State: (Actions,["1 is one\n"])

130. actual: voidFun4 ==> Next symExpr (MethodName "voidFun4" ==> SMethodType Void) in Method Call: voidFun4

131. actual: voidFun4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

132. actual: voidFun4 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Void

133. actual: voidFun4 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "voidFun4",SMethodType Void)

134. actual: voidFun4 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "voidFun4", er_val = SMethodType Void}

135. actual: voidFun4 ==> Next symExpr (VarBindings ==> SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])) in Method Call: voidFun4

136. actual: voidFun4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

137. actual: voidFun4 ==> (visitSymExpr -> SVarBindings): handling SymExpr: SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])

138. actual: voidFun4 ==> (visitSymExpr -> SVarBindings): Modifying State: (VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]))

139. actual: voidFun4 ==> (visitSymExpr -> SVarBindings): Returning: ER_SymStateMapEntry {er_key = VarBindings, er_val = SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])}

140. actual: voidFun4 ==> Next symExpr (VarAssignments ==> SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]) in Method Call: voidFun4

141. actual: voidFun4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

142. actual: voidFun4 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]

143. actual: voidFun4 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])

144. actual: voidFun4 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]}

145. actual: voidFun4 ==> Next symExpr (VarName "x" ==> SymInt 1) in Method Call: voidFun4

146. actual: voidFun4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

147. actual: voidFun4 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 1

148. actual: voidFun4 ==> (visitSymExpr -> SymInt): Modifying State: (VarName "x",SymInt 1)

149. actual: voidFun4 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

150. actual: voidFun4 ==> Next symExpr (VarName "y" ==> SymString "is one") in Method Call: voidFun4

151. actual: voidFun4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

152. actual: voidFun4 ==> (visitSymExpr -> SymString): handling SymExpr: SymString "is one"

153. actual: voidFun4 ==> (visitSymExpr -> SymString): Modifying State: (VarName "y",SymString "is one")

154. actual: voidFun4 ==> (visitSymExpr -> SymString): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymString "is one"}

155. actual: voidFun4 ==> Next symExpr (VarName "z" ==> SymString "1 is one") in Method Call: voidFun4

156. actual: voidFun4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

157. actual: voidFun4 ==> (visitSymExpr -> SymString): handling SymExpr: SymString "1 is one"

158. actual: voidFun4 ==> (visitSymExpr -> SymString): Modifying State: (VarName "z",SymString "1 is one")

159. actual: voidFun4 ==> (visitSymExpr -> SymString): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymString "1 is one"}

160. actual: voidFun4 ==> Next symExpr (Actions ==> SActions ["1 is one\n"]) in Method Call: voidFun4

161. actual: voidFun4 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

162. actual: voidFun4 ==> (visitSymExpr -> SActions): handling SymExpr: SActions ["1 is one\n"]

163. actual: voidFun4 ==> (visitSymExpr -> SActions): Modifying State: (Actions,SActions ["1 is one\n"])

164. actual: voidFun4 ==> (visitSymExpr -> SActions): Returning: ER_SymStateMapEntry {er_key = Actions, er_val = SActions ["1 is one\n"]}

165. Method Call actual SymState: SymState {env = fromList [(MethodName "voidFun4",SMethodType Void),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]),(VarName "x",SymInt 1),(VarName "y",SymString "is one"),(VarName "z",SymString "1 is one"),(Actions,SActions ["1 is one\n"])], pc = []}

166. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "voidFun4",SMethodType Void),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]),(VarName "x",SymInt 1),(VarName "y",SymString "is one"),(VarName "z",SymString "1 is one"),(Actions,SActions ["1 is one\n"])], pc = []})

167. (visitNode -> Node -> Statement): Returning: ER_Void

168. Next Node: Node {id = 3, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "After"]}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

169. (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "After"]}}

170. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "After"]}

171. (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[StringLiteral "After"]

172. (visitExpr -> StringLiteral): handling expression: StringLiteral "After"

173. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "After")

174. (visitExpr ==> FunCallExpr): Returning: ER_Print "After\n"

175. (visitStmt -> FunCallStmt): Modifying State: (SActions,After
)

176. (visitStmt -> FunCallStmt): Returning: ER_Print "After\n"

177. (visitNode -> Node -> Statement): Returning: ER_Print "After\n"

178. Next Node: End {id = 4, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

179. (visitNode -> End): Method End

180. (visitNode -> End -> return nothing): Void

181. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "voidFun5",SMethodType Void),(Actions,SActions ["Before\n","1 is one\n","After\n"])], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "voidFun5",SMethodType Void),(Actions,SActions ["Before\n","1 is one\n","After\n"])], pc = []}