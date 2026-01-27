================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo27" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo27

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: Node {id = 1, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 1): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

16. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >=, expr2 = NumberLiteral 0.0}

17. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

18. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

19. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

20. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

21. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

22. (visitExpr -> BinOpExpr): Affected: SymVar Int "i", >=, SymNum 0.0

23. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Ge (SymInt 0))

24. if statement ==> Next Node: End {id = 2, parent = 1, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

25. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

26. if statement ==> (visitNode -> End): Method End

27. if statement ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

28. if statement ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

29. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

30. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

31. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

32. if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

33. if statement ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

34. if statement ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

35. else statement ==> Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = NumberLiteral (-1.0), binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 1}

36. else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

37. else statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = NumberLiteral (-1.0), binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}

38. else statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = NumberLiteral (-1.0), binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

39. else statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}, assEright = BinOpExpr {expr1 = NumberLiteral (-1.0), binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

40. else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "res"}

41. else statement ==> (visitExpr -> VarExpr): New Variable BuiltInType Int res

42. else statement ==> (visitExpr -> VarExpr): Modifying State: (res,SymNull Int)

43. else statement ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}

44. else statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral (-1.0), binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}

45. else statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral (-1.0)

46. else statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum (-1.0))

47. else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

48. else statement ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

49. else statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

50. else statement ==> (visitExpr -> BinOpExpr): Affected: SymNum (-1.0), *, SymVar Int "i"

51. else statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt (-1)) Mul (SymVar Int "i"))

52. else statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "res", er_val = SymNull Int}, ER_Expr (SBin (SymInt (-1)) Mul (SymVar Int "i"))

53. else statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "res"
    Old Value: SymNull Int
    New Value: SBin (SymInt (-1)) Mul (SymVar Int "i")

54. else statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "res",SBin (SymInt (-1)) Mul (SymVar Int "i"))

55. else statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymInt (-1)) Mul (SymVar Int "i")}

56. else statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymInt (-1)) Mul (SymVar Int "i")}

57. else statement ==> (visitNode -> Node -> Statement): Adding Var Binding: ("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})

58. else statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})

59. else statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymInt (-1)) Mul (SymVar Int "i")}

60. else statement ==> Next Node: End {id = 4, parent = 1, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "res"})}

61. else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

62. else statement ==> (visitNode -> End): Method End

63. else statement ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

64. else statement ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

65. else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "res"}

66. else statement ==> (visitExpr -> VarExpr): Look up in environmane table: (res ~~> SBin (SymInt (-1)) Mul (SymVar Int "i")) 

67. else statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymInt (-1)) Mul (SymVar Int "i")}

68. else statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymInt (-1)) Mul (SymVar Int "i"))

69. else statement ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymInt (-1)) Mul (SymVar Int "i")}

70. else statement ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "res", er_val = SBin (SymInt (-1)) Mul (SymVar Int "i")}

71. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 1,SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}) (Just (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "res",SBin (SymInt (-1)) Mul (SymVar Int "i")),(Return,SBin (SymInt (-1)) Mul (SymVar Int "i"))], pc = []})))

72. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}) (Just (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "res",SBin (SymInt (-1)) Mul (SymVar Int "i")),(Return,SBin (SymInt (-1)) Mul (SymVar Int "i"))], pc = []})))

73. Next Node: End {id = 6, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

74. (visitNode -> End): Method End

75. (visitNode -> End -> return nothing): Void

76. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments []),(VarName "i",SymVar Int "i"),(ScopeRange (SR {branchStart = 1, branchEnd = 5}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}) (Just (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "res",SBin (SymInt (-1)) Mul (SymVar Int "i")),(Return,SBin (SymInt (-1)) Mul (SymVar Int "i"))], pc = []})))], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo27",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments []),(VarName "i",SymVar Int "i"),(ScopeRange (SR {branchStart = 1, branchEnd = 5}),SIte (SBin (SymVar Int "i") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}) (Just (SymState {env = fromList [(MethodName "boo27",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})])),(VarAssignments,SVarAssignments [("res",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 1, branchEnd = 5}})]),(VarName "i",SymVar Int "i"),(VarName "res",SBin (SymInt (-1)) Mul (SymVar Int "i")),(Return,SBin (SymInt (-1)) Mul (SymVar Int "i"))], pc = []})))], pc = []}