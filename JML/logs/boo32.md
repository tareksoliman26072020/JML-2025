================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo32" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo32

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo32",SMethodType Int)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y2"}}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y3"}}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y2"}}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y3"}}}}

7. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y2"}}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y3"}}}

8. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y2"}}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y3"}}}

9. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

10. (visitExpr -> VarExpr): New Variable BuiltInType Int x

11. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

12. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

13. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y2"}}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y3"}}

14. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y2"}}

15. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y1"}

16. (visitExpr -> VarExpr): Global Variable Detected: y1 

17. (visitExpr -> VarExpr): Modifying State: (y1,SymVar UnknownGlobalVarSymType "y1")

18. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y1", er_val = SymVar UnknownGlobalVarSymType "y1"}

19. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y2"}

20. (visitExpr -> VarExpr): Global Variable Detected: y2 

21. (visitExpr -> VarExpr): Modifying State: (y2,SymVar UnknownGlobalVarSymType "y2")

22. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y2", er_val = SymVar UnknownGlobalVarSymType "y2"}

23. (visitExpr -> BinOpExpr): Affected: SymVar UnknownGlobalVarSymType "y1", +, SymVar UnknownGlobalVarSymType "y2"

24. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar UnknownGlobalVarSymType "y1") Add (SymVar UnknownGlobalVarSymType "y2"))

25. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y3"}

26. (visitExpr -> VarExpr): Global Variable Detected: y3 

27. (visitExpr -> VarExpr): Modifying State: (y3,SymVar UnknownGlobalVarSymType "y3")

28. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y3", er_val = SymVar UnknownGlobalVarSymType "y3"}

29. (visitExpr -> BinOpExpr): Affected: SBin (SymVar UnknownGlobalVarSymType "y1") Add (SymVar UnknownGlobalVarSymType "y2"), +, SymVar UnknownGlobalVarSymType "y3"

30. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SBin (SymVar UnknownGlobalVarSymType "y1") Add (SymVar UnknownGlobalVarSymType "y2")) Add (SymVar UnknownGlobalVarSymType "y3"))

31. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SBin (SBin (SymVar UnknownGlobalVarSymType "y1") Add (SymVar UnknownGlobalVarSymType "y2")) Add (SymVar UnknownGlobalVarSymType "y3"))

32. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")

33. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3"))

34. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")}

35. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")}

36. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

37. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

38. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")}

39. Next Node: End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}

>>>>>>>>>> visitNode <<<<<<<<<<

40. (visitNode -> End): Method End

41. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

42. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

43. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

44. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")) 

45. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")}

46. (castGlobalVar): Update Variable
    Var Name: y1
    Old Value: SymVar UnknownGlobalVarSymType "y1"
    New Value: SymVar Int "y1"

47. (castGlobalVar): Update Variable
    Var Name: y2
    Old Value: SymVar UnknownGlobalVarSymType "y2"
    New Value: SymVar Int "y2"

48. (castGlobalVar): Update Variable
    Var Name: y3
    Old Value: SymVar UnknownGlobalVarSymType "y3"
    New Value: SymVar Int "y3"

49. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3"))

50. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")}

51. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo32",SMethodType Int),(GlobalVars,SGlobalVars ["y1","y2","y3"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "x",SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3")),(VarName "y1",SymVar Int "y1"),(VarName "y2",SymVar Int "y2"),(VarName "y3",SymVar Int "y3"),(Return,SBin (SBin (SymVar Int "y1") Add (SymVar Int "y2")) Add (SymVar Int "y3"))], pc = []}