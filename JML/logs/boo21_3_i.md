================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo21_3_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo21_3_i

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

19. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

20. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

21. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = +, expr2 = NumberLiteral 2.0}

22. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

23. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

24. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

25. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

26. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

27. (visitExpr -> BinOpExpr): Affected: SymVar Int "i", +, SymNum 2.0

28. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

29. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}, ER_Expr (SBin (SymVar Int "i") Add (SymInt 2))

30. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "i"
    Old Value: SymVar Int "i"
    New Value: SBin (SymVar Int "i") Add (SymInt 2)

31. (visitExpr ==> AssignExpr): Modifying State: (VarName "i",SBin (SymVar Int "i") Add (SymInt 2))

32. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

33. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

34. (visitNode -> Node -> Statement): Adding Var Assignment: ("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

35. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

36. Next Node: End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

>>>>>>>>>> visitNode <<<<<<<<<<

37. (visitNode -> End): Method End

38. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

39. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

40. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

41. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SBin (SymVar Int "i") Add (SymInt 2)) 

42. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

43. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymVar Int "i") Add (SymInt 2))

44. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}

45. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SBin (SymVar Int "i") Add (SymInt 2)}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo21_3_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments [("i",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "i",SBin (SymVar Int "i") Add (SymInt 2)),(Return,SBin (SymVar Int "i") Add (SymInt 2))], pc = []}