================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo22_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo22_i

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo22_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "i"}]})}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> End): Method End

16. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "i"}]}

17. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "i"}]}

18. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21_i"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "i"}]}

19. formal: boo21_i ==> Next Node: Entry (BuiltInType Int) "boo21_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

20. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

21. formal: boo21_i ==> (visitNode -> Entry): Method Start: boo21_i

22. formal: boo21_i ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

23. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

24. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

25. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

26. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

27. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

28. formal: boo21_i ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

29. formal: boo21_i ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

30. formal: boo21_i ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

31. formal: boo21_i ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

32. formal: boo21_i ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

33. formal: boo21_i ==> Next Node: End {id = 1, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

34. formal: boo21_i ==> >>>>>>>>>> visitNode <<<<<<<<<<

35. formal: boo21_i ==> (visitNode -> End): Method End

36. formal: boo21_i ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

37. formal: boo21_i ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

38. formal: boo21_i ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

39. formal: boo21_i ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

40. formal: boo21_i ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

41. formal: boo21_i ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

42. formal: boo21_i ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

43. formal: boo21_i ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

44. Method Call formal SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}

45. SymExec of actual parameter: boo21_i(i) ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

46. SymExec of actual parameter: boo21_i(i) ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

47. SymExec of actual parameter: boo21_i(i) ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

48. actual: boo21_i ==> Next symExpr (MethodName "boo21_i" ==> SMethodType Int) in Method Call: boo21_i

49. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

50. actual: boo21_i ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

51. actual: boo21_i ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo21_i",SMethodType Int)

52. actual: boo21_i ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo21_i", er_val = SMethodType Int}

53. actual: boo21_i ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo21_i

54. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

55. actual: boo21_i ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

56. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

57. actual: boo21_i ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

58. actual: boo21_i ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo21_i

59. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

60. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

61. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

62. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymVar Int "i")

63. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SymVar Int "i")

64. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

65. actual: boo21_i ==> Next symExpr (Return ==> SymVar Int "i") in Method Call: boo21_i

66. actual: boo21_i ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

67. actual: boo21_i ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

68. actual: boo21_i ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

69. actual: boo21_i ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymVar Int "i")

70. actual: boo21_i ==> (visitSymExpr -> SymVar): Modifying State: (Return,SymVar Int "i")

71. actual: boo21_i ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymVar Int "i"}

72. Method Call actual SymState: SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}

73. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []})

74. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

75. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []})

76. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo22_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}