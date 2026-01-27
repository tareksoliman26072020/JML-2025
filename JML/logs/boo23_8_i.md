================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo23_8_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo23_8_i

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo23_8_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: End {id = 1, parent = 0, mExpr = Just (BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 5.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}})}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> End): Method End

16. (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 5.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

17. (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 5.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

18. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = BinOpExpr {expr1 = NumberLiteral 5.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

19. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

20. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

21. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 5.0, binOp = *, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}

22. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

23. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

24. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

25. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

26. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

27. (visitExpr -> BinOpExpr): Affected: SymNum 5.0, *, SymVar Int "i"

28. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 5) Mul (SymVar Int "i"))

29. (visitExpr -> BinOpExpr): Affected: SymNum 3.0, +, SBin (SymInt 5) Mul (SymVar Int "i")

30. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymInt 3) Add (SBin (SymInt 5) Mul (SymVar Int "i")))

31. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymInt 3) Add (SBin (SymInt 5) Mul (SymVar Int "i")))

32. (visitStmt -> ReturnStmt): Returning: ER_Expr (SBin (SymInt 3) Add (SBin (SymInt 5) Mul (SymVar Int "i")))

33. (visitNode -> End -> method returns): Returning: ER_Expr (SBin (SymInt 3) Add (SBin (SymInt 5) Mul (SymVar Int "i")))
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo23_8_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SBin (SymInt 3) Add (SBin (SymInt 5) Mul (SymVar Int "i")))], pc = []}