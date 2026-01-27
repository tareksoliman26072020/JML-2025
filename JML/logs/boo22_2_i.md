================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo22_2_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo22_2_i

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo22_2_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = NumberLiteral 2.0}]}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = NumberLiteral 2.0}]}}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = NumberLiteral 2.0}]}}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = NumberLiteral 2.0}]}}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

19. (visitExpr -> VarExpr): New Variable BuiltInType Int x

20. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

21. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

22. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = NumberLiteral 2.0}]}

23. formal: boo21_i ==> Next Node: Entry (BuiltInType Int) "boo21_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

24. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

25. formal: boo21_i ==> (visitNode -> Entry): Method Start: boo21_i

26. formal: boo21_i ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

27. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

28. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

29. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

30. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

31. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

32. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

33. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

34. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

35. formal: boo21_i ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

36. formal: boo21_i ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

37. formal: boo21_i ==> Next Node: End {id = 1, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

38. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

39. formal: boo21_i ==> (visitNode -> End): Method End

40. formal: boo21_i ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

41. formal: boo21_i ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

42. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

43. formal: boo21_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

44. formal: boo21_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

45. formal: boo21_i ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

46. formal: boo21_i ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

47. formal: boo21_i ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

48. Method Call formal SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}

49. SymExec of actual parameter: boo21_i(i*2.0) ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = *, expr2 = NumberLiteral 2.0}

50. SymExec of actual parameter: boo21_i(i*2.0) ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

51. SymExec of actual parameter: boo21_i(i*2.0) ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

52. SymExec of actual parameter: boo21_i(i*2.0) ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

53. SymExec of actual parameter: boo21_i(i*2.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

54. SymExec of actual parameter: boo21_i(i*2.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

55. SymExec of actual parameter: boo21_i(i*2.0) ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", *, SymNum 2.0

56. SymExec of actual parameter: boo21_i(i*2.0) ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Mul (SymInt 2))

57. actual: boo21_i ==> Next symExpr (MethodName "boo21_i" ==> SMethodType Int) in Method Call: boo21_i

58. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

59. actual: boo21_i ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

60. actual: boo21_i ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo21_i",SMethodType Int)

61. actual: boo21_i ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo21_i", er_val = SMethodType Int}

62. actual: boo21_i ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo21_i

63. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

64. actual: boo21_i ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

65. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

66. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

67. actual: boo21_i ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo21_i

68. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

69. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

70. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

71. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymVar Int "i") Mul (SymInt 2))

72. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SBin (SymVar Int "i") Mul (SymInt 2))

73. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Mul (SymInt 2)}

74. actual: boo21_i ==> Next symExpr (Return ==> SymVar Int "i") in Method Call: boo21_i

75. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

76. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

77. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

78. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymVar Int "i") Mul (SymInt 2))

79. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (Return,SBin (SymVar Int "i") Mul (SymInt 2))

80. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SBin (SymVar Int "i") Mul (SymInt 2)}

81. Method Call actual SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SBin (SymVar Int "i") Mul (SymInt 2)),(Return,SBin (SymVar Int "i") Mul (SymInt 2))], pc = []}

82. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SBin (SymVar Int "i") Mul (SymInt 2)),(Return,SBin (SymVar Int "i") Mul (SymInt 2))], pc = []})

83. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_FunCall (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SBin (SymVar Int "i") Mul (SymInt 2)),(Return,SBin (SymVar Int "i") Mul (SymInt 2))], pc = []})

84. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SBin (SymVar Int "i") Mul (SymInt 2)

85. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SBin (SymVar Int "i") Mul (SymInt 2))

86. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymVar Int "i") Mul (SymInt 2)}

87. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymVar Int "i") Mul (SymInt 2)}

88. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

89. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

90. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymVar Int "i") Mul (SymInt 2)}

91. Next Node: End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}

>>>>>>>>>> visitNode <<<<<<<<<<

92. (visitNode -> End): Method End

93. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

94. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

95. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

96. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SBin (SymVar Int "i") Mul (SymInt 2)) 

97. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymVar Int "i") Mul (SymInt 2)}

98. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymVar Int "i") Mul (SymInt 2))

99. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymVar Int "i") Mul (SymInt 2)}

100. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymVar Int "i") Mul (SymInt 2)}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo22_2_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SymVar Int "i"),(VarName "x",SBin (SymVar Int "i") Mul (SymInt 2)),(Return,SBin (SymVar Int "i") Mul (SymInt 2))], pc = []}