================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Void) "manyArrs4" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: manyArrs4

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "manyArrs4",SMethodType Void)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 2.0), arrElems = []}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 2.0), arrElems = []}}}

7. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 2.0), arrElems = []}}

8. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 2.0), arrElems = []}}

9. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers"}

10. (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} numbers

11. (visitExpr -> VarExpr): Modifying State: (numbers,SymNull (Array Int))

12. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymNull (Array Int)}

13. (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 2.0), arrElems = []}

14. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

15. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

16. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymNull (Array Int)}, ER_Expr (SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int])

17. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers"
    Old Value: SymNull (Array Int)
    New Value: SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int]

18. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int])

19. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int]}

20. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int]}

21. (visitNode -> Node -> Statement): Adding Var Binding: ("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})

22. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})

23. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int]}

24. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 99.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

25. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 99.0}}

26. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 99.0}

27. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 99.0}

28. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers"}

29. (visitExpr -> VarExpr): Look up in environmane table: (numbers ~~> SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int]) 

30. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int]}

31. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

32. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

33. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers" (SymInt 0), arrayIndexCallValue = SymNull Int}

34. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 99.0

35. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 99.0)

36. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers" (SymInt 0), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 99.0)

37. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers"
    Old Value: SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]

38. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int])

39. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymInt 99}

40. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymInt 99}

41. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})

42. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymInt 99}

43. Next Node: Node {id = 3, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers"}]}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

44. (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers"}]}}

45. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers"}]}

46. (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[VarExpr {varType = Nothing, varObj = [], varName = "numbers"}]

47. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers"}

48. (visitExpr -> VarExpr): Look up in environmane table: (numbers ~~> SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]) 

49. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]}

50. (visitExpr ==> FunCallExpr): Returning: ER_Print "[99, 0]\n"

51. (visitStmt -> FunCallStmt): Modifying State: (SActions,[99, 0]
)

52. (visitStmt -> FunCallStmt): Returning: ER_Print "[99, 0]\n"

53. (visitNode -> Node -> Statement): Returning: ER_Print "[99, 0]\n"

54. Next Node: End {id = 4, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

55. (visitNode -> End): Method End

56. (visitNode -> End -> return nothing): Void

57. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "manyArrs4",SMethodType Void),(VarBindings,SVarBindings (fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})]),(VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]),(Actions,SActions ["[99, 0]\n"])], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "manyArrs4",SMethodType Void),(VarBindings,SVarBindings (fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}})]),(VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]),(Actions,SActions ["[99, 0]\n"])], pc = []}