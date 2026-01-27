================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo22_i_2" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo22_i_2

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo22_i_2",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: End {id = 1, parent = 0, mExpr = Just (BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}, binOp = +, expr2 = NumberLiteral 1.0})}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> End): Method End

16. (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}, binOp = +, expr2 = NumberLiteral 1.0}

17. (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}, binOp = +, expr2 = NumberLiteral 1.0}

18. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}, binOp = +, expr2 = NumberLiteral 1.0}

19. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}]}

20. formal: boo21_i ==> Next Node: Entry (BuiltInType Int) "boo21_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

21. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

22. formal: boo21_i ==> (visitNode -> Entry): Method Start: boo21_i

23. formal: boo21_i ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

24. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

25. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

26. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

27. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

28. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

29. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

30. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

31. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

32. formal: boo21_i ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

33. formal: boo21_i ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

34. formal: boo21_i ==> Next Node: End {id = 1, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

35. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

36. formal: boo21_i ==> (visitNode -> End): Method End

37. formal: boo21_i ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

38. formal: boo21_i ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

39. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

40. formal: boo21_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

41. formal: boo21_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

42. formal: boo21_i ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

43. formal: boo21_i ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

44. formal: boo21_i ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

45. Method Call formal SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}

46. SymExec of actual parameter: boo21_i(i+4.0) ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 4.0}

47. SymExec of actual parameter: boo21_i(i+4.0) ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

48. SymExec of actual parameter: boo21_i(i+4.0) ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

49. SymExec of actual parameter: boo21_i(i+4.0) ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

50. SymExec of actual parameter: boo21_i(i+4.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

51. SymExec of actual parameter: boo21_i(i+4.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

52. SymExec of actual parameter: boo21_i(i+4.0) ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", +, SymNum 4.0

53. SymExec of actual parameter: boo21_i(i+4.0) ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 4))

54. actual: boo21_i ==> Next symExpr (MethodName "boo21_i" ==> SMethodType Int) in Method Call: boo21_i

55. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

56. actual: boo21_i ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

57. actual: boo21_i ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo21_i",SMethodType Int)

58. actual: boo21_i ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo21_i", er_val = SMethodType Int}

59. actual: boo21_i ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo21_i

60. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

61. actual: boo21_i ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

62. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

63. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

64. actual: boo21_i ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo21_i

65. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

66. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

67. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

68. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 4))

69. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SBin (SymVar Int "i") Add (SymInt 4))

70. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 4)}

71. actual: boo21_i ==> Next symExpr (Return ==> SymVar Int "i") in Method Call: boo21_i

72. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

73. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

74. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

75. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 4))

76. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (Return,SBin (SymVar Int "i") Add (SymInt 4))

77. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SBin (SymVar Int "i") Add (SymInt 4)}

78. Method Call actual SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 4)),(Return,SBin (SymVar Int "i") Add (SymInt 4))], pc = []}

79. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 4)),(Return,SBin (SymVar Int "i") Add (SymInt 4))], pc = []})

80. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

81. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

82. (visitExpr -> BinOpExpr): Affected: SBin (SymVar Int "i") Add (SymInt 4), +, SymNum 1.0

83. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 5))

84. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymVar Int "i") Add (SymInt 5))

85. (visitStmt -> ReturnStmt): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 5))

86. (visitNode -> End -> method returns): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 5))
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo22_i_2",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SBin (SymVar Int "i") Add (SymInt 5))], pc = []}