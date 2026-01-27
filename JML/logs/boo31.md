================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo31" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo31

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo31",SMethodType Int)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = NumberLiteral 0.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = NumberLiteral 0.0}}

7. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = NumberLiteral 0.0}

8. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"}, assEright = NumberLiteral 0.0}

9. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "z"}

10. (visitExpr -> VarExpr): Global Variable Detected: z 

11. (visitExpr -> VarExpr): Modifying State: (z,SymVar UnknownGlobalVarSymType "z")

12. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymVar UnknownGlobalVarSymType "z"}

13. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

14. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

15. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymVar UnknownGlobalVarSymType "z"}, ER_Expr (SymNum 0.0)

16. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "z"
    Old Value: SymVar UnknownGlobalVarSymType "z"
    New Value: SymNum 0.0

17. (visitExpr ==> AssignExpr): Modifying State: (VarName "z",SymNum 0.0)

18. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNum 0.0}

19. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNum 0.0}

20. (visitNode -> Node -> Statement): Adding Var Assignment: ("z",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

21. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNum 0.0}

22. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "z"}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

23. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "z"}}}

24. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "z"}}

25. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = VarExpr {varType = Nothing, varObj = [], varName = "z"}}

26. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

27. (visitExpr -> VarExpr): New Variable BuiltInType Int x

28. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

29. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

30. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "z"}

31. (visitExpr -> VarExpr): Look up in environmane table: (z ~~> SymNum 0.0) 

32. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNum 0.0}

33. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNum 0.0}

34. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 0

35. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 0)

36. (castGlobalVar): Update Variable
    Var Name: z
    Old Value: SymNum 0.0
    New Value: SymInt 0

37. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNum 0.0}

38. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNum 0.0}

39. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})

40. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})

41. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNum 0.0}

42. Next Node: End {id = 3, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}

>>>>>>>>>> visitNode <<<<<<<<<<

43. (visitNode -> End): Method End

44. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

45. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

46. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

47. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 0) 

48. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 0}

49. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 0)

50. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 0}

51. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 0}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo31",SMethodType Int),(GlobalVars,SGlobalVars ["z"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("z",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "x",SymInt 0),(VarName "z",SymInt 0),(Return,SymInt 0)], pc = []}