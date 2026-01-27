================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "ifFun4" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "n"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: ifFun4

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "ifFun4",SMethodType Int),(FormalParms,SFormalParms ["n"]),(VarName "n",SymVar Int "n")], pc = []})

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

26. if statement ==> Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}), parent = 1}

27. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

28. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}}

29. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

30. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}}

31. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

32. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymVar UnknownNumSymType "y") 

33. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownNumSymType "y"}

34. if statement ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "n"}}

35. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

36. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymVar UnknownNumSymType "y") 

37. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownNumSymType "y"}

38. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "n"}

39. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (n ~~> SymVar Int "n") 

40. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "n", er_val = SymVar Int "n"}

41. if statement ==> (castGlobalVar): Update Variable
    Var Name: y
    Old Value: SymVar UnknownNumSymType "y"
    New Value: SymVar Int "y"

42. if statement ==> (visitExpr -> BinOpExpr): Affected: SymVar UnknownNumSymType "y", +, SymVar Int "n"

43. if statement ==> (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "y") Add (SymVar Int "n"))

44. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownNumSymType "y"}, ER_Expr (SBin (SymVar Int "y") Add (SymVar Int "n"))

45. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymVar Int "y"
    New Value: SBin (SymVar Int "y") Add (SymVar Int "n")

46. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SBin (SymVar Int "y") Add (SymVar Int "n"))

47. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SBin (SymVar Int "y") Add (SymVar Int "n")}

48. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SBin (SymVar Int "y") Add (SymVar Int "n")}

49. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})

50. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SBin (SymVar Int "y") Add (SymVar Int "n")}

51. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 1,SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun4",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymVar Int "y") Add (SymVar Int "n"))], pc = []}) Nothing)

52. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun4",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymVar Int "y") Add (SymVar Int "n"))], pc = []}) Nothing)

53. Next Node: End {id = 4, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "y"})}

>>>>>>>>>> visitNode <<<<<<<<<<

54. (visitNode -> End): Method End

55. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

56. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

57. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

58. (visitExpr -> VarExpr): Look up in environmane table: (y ~~> SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]) 

59. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]}

60. (castGlobalVar): Update Variable
    Var Name: y
    Old Value: SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]
    New Value: SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]

61. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)])

62. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]}

63. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "ifFun4",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "n",SymVar Int "n"),(VarName "y",SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)]),(ScopeRange (SR {branchStart = 1, branchEnd = 3}),SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0)) (SymState {env = fromList [(MethodName "ifFun4",SMethodType Int),(GlobalVars,SGlobalVars ["y"]),(FormalParms,SFormalParms ["n"]),(VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),(VarName "n",SymVar Int "n"),(VarName "y",SBin (SymVar Int "y") Add (SymVar Int "n"))], pc = []}) Nothing),(Return,SymUnknown (UnknownNumSymType,"y",Just (SymVar UnknownNumSymType "y")) [([(If,SR {branchStart = 1, branchEnd = 3})],2)])], pc = []}