================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo23_4_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo23_4_i

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo23_4_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: End {id = 1, parent = 0, mExpr = Just (BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [NumberLiteral 0.0]}})}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> End): Method End

16. (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [NumberLiteral 0.0]}}

17. (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [NumberLiteral 0.0]}}

18. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [NumberLiteral 0.0]}}

19. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

20. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

21. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [NumberLiteral 0.0]}

22. formal: boo21_i ==> Next Node: Entry (BuiltInType Int) "boo21_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

23. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

24. formal: boo21_i ==> (visitNode -> Entry): Method Start: boo21_i

25. formal: boo21_i ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

26. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

27. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

28. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

29. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

30. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

31. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

32. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

33. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

34. formal: boo21_i ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

35. formal: boo21_i ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

36. formal: boo21_i ==> Next Node: End {id = 1, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

37. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

38. formal: boo21_i ==> (visitNode -> End): Method End

39. formal: boo21_i ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

40. formal: boo21_i ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

41. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

42. formal: boo21_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

43. formal: boo21_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

44. formal: boo21_i ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

45. formal: boo21_i ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

46. formal: boo21_i ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

47. Method Call formal SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}

48. SymExec of actual parameter: boo21_i(0.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

49. SymExec of actual parameter: boo21_i(0.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

50. actual: boo21_i ==> Next symExpr (MethodName "boo21_i" ==> SMethodType Int) in Method Call: boo21_i

51. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

52. actual: boo21_i ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

53. actual: boo21_i ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo21_i",SMethodType Int)

54. actual: boo21_i ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo21_i", er_val = SMethodType Int}

55. actual: boo21_i ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo21_i

56. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

57. actual: boo21_i ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

58. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

59. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

60. actual: boo21_i ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo21_i

61. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

62. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

63. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

64. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 0)

65. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SymInt 0)

66. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymInt 0}

67. actual: boo21_i ==> Next symExpr (Return ==> SymVar Int "i") in Method Call: boo21_i

68. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

69. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

70. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

71. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 0)

72. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (Return,SymInt 0)

73. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 0}

74. Method Call actual SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymInt 0),(Return,SymInt 0)], pc = []}

75. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymInt 0),(Return,SymInt 0)], pc = []})

76. (visitExpr -> BinOpExpr): Affected: SymNum 3.0, +, SymInt 0

77. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 3)

78. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 3)

79. (visitStmt -> ReturnStmt): Returning: ER_Expr (SymInt 3)

80. (visitNode -> End -> method returns): Returning: ER_Expr (SymInt 3)
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo23_4_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 3)], pc = []}