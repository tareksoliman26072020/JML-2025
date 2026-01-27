================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Void) "voidFun4" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: voidFun4

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "voidFun4",SMethodType Void)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}}

7. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

8. (visitExpr -> VarExpr): New Variable BuiltInType Int x

9. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

10. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

11. (visitStmt -> VarStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

12. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}})

13. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

14. Next Node: Node {id = 2, nodeData = Statement (VarStmt {var = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "y"}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: VarStmt {var = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "y"}}

16. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "y"}

17. (visitExpr -> VarExpr): New Variable AnyType {typee = "String", generic = Nothing} y

18. (visitExpr -> VarExpr): Modifying State: (y,SymNull String)

19. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}

20. (visitStmt -> VarStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}

21. (visitNode -> Node -> Statement): Adding Var Binding: ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}})

22. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}

23. Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

24. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}}

25. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

26. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = NumberLiteral 1.0}

27. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

28. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymNull Int) 

29. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

30. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

31. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

32. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymNum 1.0)

33. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 1

34. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 1)

35. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

36. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

37. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}})

38. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

39. Next Node: Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = StringLiteral "is one"}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

40. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = StringLiteral "is one"}}

41. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = StringLiteral "is one"}

42. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = StringLiteral "is one"}

43. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

44. (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymNull String) 

45. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}

46. (visitExpr -> StringLiteral): handling expression: StringLiteral "is one"

47. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "is one")

48. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNull String}, ER_Expr (SymString "is one")

49. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymNull String
    New Value: SymString "is one"

50. (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SymString "is one")

51. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymString "is one"}

52. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymString "is one"}

53. (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}})

54. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymString "is one"}

55. Next Node: Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

56. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}}

57. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}

58. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}

59. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "z"}

60. (visitExpr -> VarExpr): New Variable AnyType {typee = "String", generic = Nothing} z

61. (visitExpr -> VarExpr): Modifying State: (z,SymNull String)

62. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNull String}

63. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}

64. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, binOp = +, expr2 = StringLiteral " "}

65. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}

66. (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "toString"}[VarExpr {varType = Nothing, varObj = [], varName = "x"}]

67. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

68. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 1) 

69. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 1}

70. (visitExpr ==> FunCallExpr): Returning: ER_Expr (SymString "1")

71. (visitExpr -> StringLiteral): handling expression: StringLiteral " "

72. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString " ")

73. (visitExpr -> BinOpExpr): Affected: SymString "1", +, SymString " "

74. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymString "1 ")

75. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

76. (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymString "is one") 

77. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymString "is one"}

78. (visitExpr -> BinOpExpr): Affected: SymString "1 ", +, SymString "is one"

79. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymString "1 is one")

80. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNull String}, ER_Expr (SymString "1 is one")

81. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "z"
    Old Value: SymNull String
    New Value: SymString "1 is one"

82. (visitExpr ==> AssignExpr): Modifying State: (VarName "z",SymString "1 is one")

83. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymString "1 is one"}

84. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymString "1 is one"}

85. (visitNode -> Node -> Statement): Adding Var Binding: ("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})

86. (visitNode -> Node -> Statement): Adding Var Assignment: ("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})

87. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymString "1 is one"}

88. Next Node: Node {id = 6, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "z"}]}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

89. (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "z"}]}}

90. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "z"}]}

91. (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[VarExpr {varType = Nothing, varObj = [], varName = "z"}]

92. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "z"}

93. (visitExpr -> VarExpr): Look up in environmane table: (z ~~> SymString "1 is one") 

94. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymString "1 is one"}

95. (visitExpr ==> FunCallExpr): Returning: ER_Print "1 is one\n"

96. (visitStmt -> FunCallStmt): Modifying State: (SActions,1 is one
)

97. (visitStmt -> FunCallStmt): Returning: ER_Print "1 is one\n"

98. (visitNode -> Node -> Statement): Returning: ER_Print "1 is one\n"

99. Next Node: End {id = 7, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

100. (visitNode -> End): Method End

101. (visitNode -> End -> return nothing): Void

102. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "voidFun4",SMethodType Void),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]),(VarName "x",SymInt 1),(VarName "y",SymString "is one"),(VarName "z",SymString "1 is one"),(Actions,SActions ["1 is one\n"])], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "voidFun4",SMethodType Void),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 7}}),("y",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 7}}),("z",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 7}})]),(VarName "x",SymInt 1),(VarName "y",SymString "is one"),(VarName "z",SymString "1 is one"),(Actions,SActions ["1 is one\n"])], pc = []}