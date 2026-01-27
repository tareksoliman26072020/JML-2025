================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo22" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo22

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo22",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []})}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}

8. (visitStmt -> ReturnStmt): handling return expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}

9. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo21"}, funArgs = []}

10. formal: boo21 ==> Next Node: Entry (BuiltInType Int) "boo21" []

11. formal: boo21 ==> >>>>>>>>>> visitNode <<<<<<<<<<

12. formal: boo21 ==> (visitNode -> Entry): Method Start: boo21

13. formal: boo21 ==> (visitNode -> Entry -> method with no args): Returning: ()

14. formal: boo21 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21",SMethodType Int)], pc = []})

15. formal: boo21 ==> Next Node: End {id = 1, parent = 0, mExpr = Just (NumberLiteral 5.0)}

16. formal: boo21 ==> >>>>>>>>>> visitNode <<<<<<<<<<

17. formal: boo21 ==> (visitNode -> End): Method End

18. formal: boo21 ==> (visitNode -> End -> return something): handling return expression: NumberLiteral 5.0

19. formal: boo21 ==> (visitStmt -> ReturnStmt): handling return expression: NumberLiteral 5.0

20. formal: boo21 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

21. formal: boo21 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

22. formal: boo21 ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 5)

23. formal: boo21 ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SymNum 5.0)

24. formal: boo21 ==> (visitNode -> End -> method returns): Returning: ER_Expr (SymNum 5.0)

25. Method Call formal SymState: SymState {env = fromList [(MethodName "boo21",SMethodType Int),(Return,SymInt 5)], pc = []}

26. actual: boo21 ==> Next symExpr (MethodName "boo21" ==> SMethodType Int) in Method Call: boo21

27. actual: boo21 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

28. actual: boo21 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

29. actual: boo21 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo21",SMethodType Int)

30. actual: boo21 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo21", er_val = SMethodType Int}

31. actual: boo21 ==> Next symExpr (Return ==> SymInt 5) in Method Call: boo21

32. actual: boo21 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

33. actual: boo21 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 5

34. actual: boo21 ==> (visitSymExpr -> SymInt): Modifying State: (Return,SymInt 5)

35. actual: boo21 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 5}

36. Method Call actual SymState: SymState {env = fromList [(MethodName "boo21",SMethodType Int),(Return,SymInt 5)], pc = []}

37. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21",SMethodType Int),(Return,SymInt 5)], pc = []})

38. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 5)

39. (visitStmt -> ReturnStmt): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21",SMethodType Int),(Return,SymInt 5)], pc = []})

40. (visitNode -> End -> method returns): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo21",SMethodType Int),(Return,SymInt 5)], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo22",SMethodType Int),(Return,SymInt 5)], pc = []}