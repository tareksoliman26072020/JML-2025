================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo21_i" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo21_i

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: End {id = 1, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "i"})}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> End): Method End

16. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

17. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

19. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

20. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

21. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymVar Int "i")

22. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

23. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo21_i",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymVar Int "i")], pc = []}