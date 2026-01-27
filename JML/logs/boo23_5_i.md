================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo23_5_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo23_5_i

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo23_5_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: End {id = 1, parent = 0, mExpr = Just (NumberLiteral 8.0)}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> End): Method End

16. (visitNode -> End -> return something): handling return expression: NumberLiteral 8.0

17. (visitStmt -> ReturnStmt): handling return expression: NumberLiteral 8.0

18. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 8.0

19. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 8.0)

20. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 8)

21. (visitStmt -> ReturnStmt): Returning: ER_Expr (SymNum 8.0)

22. (visitNode -> End -> method returns): Returning: ER_Expr (SymNum 8.0)
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo23_5_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 8)], pc = []}