================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "elemAt" [VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"},VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: elemAt

3. (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"},VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}]

4. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}

5. (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} arr

6. (visitExpr -> VarExpr): Modifying State: (arr,SymNull (Array Int))

7. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}

8. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}

9. (visitExpr -> VarExpr): New Variable BuiltInType Int pos

10. (visitExpr -> VarExpr): Modifying State: (pos,SymNull Int)

11. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymNull Int}

12. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}

13. (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} arr

14. (visitExpr -> VarExpr): Modifying State: (arr,SymNull (Array Int))

15. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}

16. (visitNode -> Entry -> method with args): Modifying State: (arr,SymVar (Array Int) "arr")

17. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}

18. (visitExpr -> VarExpr): New Variable BuiltInType Int pos

19. (visitExpr -> VarExpr): Modifying State: (pos,SymNull Int)

20. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymNull Int}

21. (visitNode -> Entry -> method with args): Modifying State: (pos,SymVar Int "pos")

22. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos")], pc = []})

23. Next Node: Node {id = 1, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

24. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 1): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}

25. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}

26. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}

27. (visitExpr ==> VarExpr): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SObjAcc ["arr","length"]}

28. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "pos"}

29. (visitExpr -> VarExpr): Look up in environmane table: (pos ~~> SymVar Int "pos") 

30. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymVar Int "pos"}

31. (visitExpr -> BinOpExpr): Affected: SObjAcc ["arr","length"], <=, SymVar Int "pos"

32. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos"))

33. if statement ==> Next Node: End {id = 2, parent = 1, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "not found"})}

34. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

35. if statement ==> (visitNode -> End): Method End

36. if statement ==> (visitNode -> End -> return something): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

37. if statement ==> (visitStmt -> ReturnStmt): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

38. if statement ==> (visitStmt -> ExcpExpr): handling expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

39. if statement ==> (visitExpr -> ExcpExpr): Modifying State: (Exception,ExcpExpr {excpName = Exception, excpmsg = Just "not found"})

40. if statement ==> (visitExpr -> ExcpExpr): Returning: ER_Expr (SException Int "Exception" "not found")

41. if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SException Int "Exception" "not found")

42. if statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SException Int "Exception" "not found")

43. if statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SException Int "Exception" "not found")

44. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 1,SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing)

45. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing)

46. Next Node: End {id = 4, parent = 0, mExpr = Just (ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})})}

>>>>>>>>>> visitNode <<<<<<<<<<

47. (visitNode -> End): Method End

48. (visitNode -> End -> return something): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})}

49. (visitStmt -> ReturnStmt): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})}

50. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "arr"}

51. (visitExpr -> VarExpr): Look up in environmane table: (arr ~~> SymVar (Array Int) "arr") 

52. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymVar (Array Int) "arr"}

53. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "pos"}

54. (visitExpr -> VarExpr): Look up in environmane table: (pos ~~> SymVar Int "pos") 

55. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymVar Int "pos"}

56. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

57. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SArrayIndexAccess "arr" (SymVar Int "pos"))

58. (visitStmt -> ReturnStmt): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

59. (visitNode -> End -> method returns): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["arr","pos"]),(VarAssignments,SVarAssignments []),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(ScopeRange (SR {branchStart = 1, branchEnd = 3}),SIte (SBin (SObjAcc ["arr","length"]) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt",SMethodType Int),(FormalParms,SFormalParms ["arr","pos"]),(VarName "arr",SymVar (Array Int) "arr"),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing),(Return,SArrayIndexAccess "arr" (SymVar Int "pos"))], pc = []}