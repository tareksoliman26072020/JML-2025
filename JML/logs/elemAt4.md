================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "elemAt4" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: elemAt4

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "elemAt4",SMethodType Int)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}}

7. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}

8. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}

9. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}

10. (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} arr

11. (visitExpr -> VarExpr): Modifying State: (arr,SymNull (Array Int))

12. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}

13. (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}

14. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 6.0

15. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 6.0)

16. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

17. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

18. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

19. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

20. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 7.0

21. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 7.0)

22. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 8.0

23. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 8.0)

24. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}, ER_Expr (SymArray Nothing (Just 5) [SymNum 6.0,SymNum 5.0,SymNum 4.0,SymNum 7.0,SymNum 8.0])

25. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "arr"
    Old Value: SymNull (Array Int)
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]

26. (visitExpr ==> AssignExpr): Modifying State: (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8])

27. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

28. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

29. (visitNode -> Node -> Statement): Adding Var Binding: ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

30. (visitNode -> Node -> Statement): Adding Var Assignment: ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

31. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

32. Next Node: End {id = 2, parent = 0, mExpr = Just (ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (NumberLiteral 3.0)})}

>>>>>>>>>> visitNode <<<<<<<<<<

33. (visitNode -> End): Method End

34. (visitNode -> End -> return something): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (NumberLiteral 3.0)}

35. (visitStmt -> ReturnStmt): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (NumberLiteral 3.0)}

36. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "arr"}

37. (visitExpr -> VarExpr): Look up in environmane table: (arr ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]) 

38. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

39. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

40. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

41. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymInt 3), arrayIndexCallValue = SymInt 7}

42. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 7)

43. (visitStmt -> ReturnStmt): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymInt 3), arrayIndexCallValue = SymInt 7}

44. (visitNode -> End -> method returns): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymInt 3), arrayIndexCallValue = SymInt 7}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "elemAt4",SMethodType Int),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(Return,SymInt 7)], pc = []}