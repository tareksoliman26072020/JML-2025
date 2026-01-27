================
===Begin Logs===
================
1. Next Node: Entry (AnyType {typee = "String", generic = Nothing}) "ifFun6" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFun6

3. (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

4. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

5. (visitExpr -> VarExpr): New Variable BuiltInType Int n

6. (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

7. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

8. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}

9. (visitExpr -> VarExpr): New Variable BuiltInType Int n

10. (visitExpr -> VarExpr): Modifying State: (n,SymNull Int)

11. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymNull Int}

12. (visitNode -> Entry -> method with args): Modifying State: (n,SymVar Int "n")

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun6",SMethodType String),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

14. Next Node: Node {id = 1, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 1): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0}

16. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = >=, expr2 = NumberLiteral 0.0}

17. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

18. (visitExpr -> VarExpr): Global Variable Detected: y 

19. (visitExpr -> VarExpr): Modifying State: (y,SymVar UnknownGlobalVarSymType "y")

20. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}

21. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

22. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

23. (castGlobalVar): Update Variable
    Var Name: y
    Old Value: SymVar UnknownGlobalVarSymType "y"
    New Value: SymVar UnknownNumSymType "y"

24. (visitExpr -> BinOpExpr): Affected: SymVar UnknownGlobalVarSymType "y", >=, SymNum 0.0

25. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0))

26. if statement ==> Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 1}

27. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

28. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

29. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

30. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "m"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

31. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

32. if statement ==> (visitExpr -> VarExpr): Global Variable Detected: m 

33. if statement ==> (visitExpr -> VarExpr): Modifying State: (m,SymVar UnknownGlobalVarSymType "m")

34. if statement ==> (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymVar UnknownGlobalVarSymType "m"}

35. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "m"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

36. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "m"}

37. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (m ~~> SymVar UnknownGlobalVarSymType "m") 

38. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymVar UnknownGlobalVarSymType "m"}

39. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

40. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

41. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

42. if statement ==> (castGlobalVar): Update Variable
    Var Name: m
    Old Value: SymVar UnknownGlobalVarSymType "m"
    New Value: SymVar Int "m"

43. if statement ==> (visitExpr -> BinOpExpr): Affected: SymVar UnknownGlobalVarSymType "m", +, SymVar Int "n"

44. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "m") Add (SymVar Int "n"))

45. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "m", er_val = SymVar UnknownGlobalVarSymType "m"}, ER_Expr (SBin (SymVar Int "m") Add (SymVar Int "n"))

46. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "m"
    Old Value: SymVar Int "m"
    New Value: SBin (SymVar Int "m") Add (SymVar Int "n")

47. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "m",SBin (SymVar Int "m") Add (SymVar Int "n"))

48. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymVar Int "m") Add (SymVar Int "n")}

49. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymVar Int "m") Add (SymVar Int "n")}

50. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})

51. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "m", er_val = SBin (SymVar Int "m") Add (SymVar Int "n")}

52. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 1,SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun6",SMethodType String),(GlobalVars,SGlobalVars ["y","m"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "m",SBin (SymVar Int "m") Add (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "y",SymVar UnknownNumSymType "y")], pc = []}) Nothing)

53. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun6",SMethodType String),(GlobalVars,SGlobalVars ["y","m"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "m",SBin (SymVar Int "m") Add (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "y",SymVar UnknownNumSymType "y")], pc = []}) Nothing)

54. Next Node: Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "s"}, assEright = StringLiteral "something"}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

55. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "s"}, assEright = StringLiteral "something"}}

56. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "s"}, assEright = StringLiteral "something"}

57. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "s"}, assEright = StringLiteral "something"}

58. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "s"}

59. (visitExpr -> VarExpr): Global Variable Detected: s 

60. (visitExpr -> VarExpr): Modifying State: (s,SymVar UnknownGlobalVarSymType "s")

61. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "s", er_val = SymVar UnknownGlobalVarSymType "s"}

62. (visitExpr -> StringLiteral): handling expression: StringLiteral "something"

63. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "something")

64. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "s", er_val = SymVar UnknownGlobalVarSymType "s"}, ER_Expr (SymString "something")

65. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "s"
    Old Value: SymVar UnknownGlobalVarSymType "s"
    New Value: SymString "something"

66. (visitExpr ==> AssignExpr): Modifying State: (VarName "s",SymString "something")

67. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "s", er_val = SymString "something"}

68. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "s", er_val = SymString "something"}

69. (visitNode -> Node -> Statement): Adding Var Assignment: ("s",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 5}})

70. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "s", er_val = SymString "something"}

71. Next Node: End {id = 5, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "c"})}

>>>>>>>>>> visitNode <<<<<<<<<<

72. (visitNode -> End): Method End

73. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "c"}

74. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "c"}

75. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "c"}

76. (visitExpr -> VarExpr): Global Variable Detected: c 

77. (visitExpr -> VarExpr): Modifying State: (c,SymVar UnknownGlobalVarSymType "c")

78. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "c", er_val = SymVar UnknownGlobalVarSymType "c"}

79. (castGlobalVar): Update Variable
    Var Name: c
    Old Value: SymVar UnknownGlobalVarSymType "c"
    New Value: SymVar String "c"

80. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar String "c")

81. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "c", er_val = SymVar UnknownGlobalVarSymType "c"}

82. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "c", er_val = SymVar UnknownGlobalVarSymType "c"}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFun6",SMethodType String),(GlobalVars,SGlobalVars ["y","m","s","c"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}}),("s",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 5}})]),(VarName "c",SymVar String "c"),(VarName "m",SymUnknown (Int,"m",Nothing) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]),(VarName "n",SymVar Int "n"),(VarName "s",SymString "something"),(VarName "y",SymVar UnknownNumSymType "y"),(ScopeRange (SR {branchStart = 1, branchEnd = 3}),SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun6",SMethodType String),(GlobalVars,SGlobalVars ["y","m"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("m",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "m",SBin (SymVar Int "m") Add (SymVar Int "n")),(VarName "n",SymVar Int "n"),(VarName "y",SymVar UnknownNumSymType "y")], pc = []}) Nothing),(Return,SymVar String "c")], pc = []}