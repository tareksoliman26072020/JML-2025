================
===Begin Logs===
================
1. Next Node: Entry (ArrayType {baseType = BuiltInType Int}) "manyArrs3" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: manyArrs3

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "manyArrs3",SMethodType (Array Int))], pc = []})

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

43. Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 5.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

44. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 5.0}}

45. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 5.0}

46. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 5.0}

47. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers"}

48. (visitExpr -> VarExpr): Look up in environmane table: (numbers ~~> SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]) 

49. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]}

50. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

51. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

52. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers" (SymInt 1), arrayIndexCallValue = SymNull Int}

53. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

54. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

55. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers" (SymInt 1), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 5.0)

56. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers"
    Old Value: SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]

57. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5])

58. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymInt 5}

59. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymInt 5}

60. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})

61. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymInt 5}

62. Next Node: End {id = 4, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "numbers"})}

>>>>>>>>>> visitNode <<<<<<<<<<

63. (visitNode -> End): Method End

64. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers"}

65. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers"}

66. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers"}

67. (visitExpr -> VarExpr): Look up in environmane table: (numbers ~~> SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]) 

68. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]}

69. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5])

70. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]}

71. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "numbers", er_val = SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "manyArrs3",SMethodType (Array Int)),(VarBindings,SVarBindings (fromList [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}})])),(VarAssignments,SVarAssignments [("numbers",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 4}}),("numbers",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 4}})]),(VarName "numbers",SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]),(Return,SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5])], pc = []}