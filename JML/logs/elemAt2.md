================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "elemAt2" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: elemAt2

3. (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}]

4. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}

5. (visitExpr -> VarExpr): New Variable BuiltInType Int pos

6. (visitExpr -> VarExpr): Modifying State: (pos,SymNull Int)

7. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymNull Int}

8. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "pos"}

9. (visitExpr -> VarExpr): New Variable BuiltInType Int pos

10. (visitExpr -> VarExpr): Modifying State: (pos,SymNull Int)

11. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymNull Int}

12. (visitNode -> Entry -> method with args): Modifying State: (pos,SymVar Int "pos")

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarName "pos",SymVar Int "pos")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "arr"}

19. (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} arr

20. (visitExpr -> VarExpr): Modifying State: (arr,SymNull (Array Int))

21. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}

22. (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Nothing, arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]}

23. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 6.0

24. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 6.0)

25. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

26. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

27. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

28. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

29. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 7.0

30. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 7.0)

31. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 8.0

32. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 8.0)

33. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymNull (Array Int)}, ER_Expr (SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8])

34. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "arr"
    Old Value: SymNull (Array Int)
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]

35. (visitExpr ==> AssignExpr): Modifying State: (VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8])

36. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

37. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

38. (visitNode -> Node -> Statement): Adding Var Binding: ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

39. (visitNode -> Node -> Statement): Adding Var Assignment: ("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

40. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

41. Next Node: Node {id = 2, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

42. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 2): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}

43. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}, binOp = <=, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "pos"}}

44. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = ["arr"], varName = "length"}

45. (visitExpr ==> VarExpr): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymInt 5}

46. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "pos"}

47. (visitExpr -> VarExpr): Look up in environmane table: (pos ~~> SymVar Int "pos") 

48. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymVar Int "pos"}

49. (visitExpr -> BinOpExpr): Affected: SymInt 5, <=, SymVar Int "pos"

50. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymInt 5) Le (SymVar Int "pos"))

51. if statement ==> Next Node: End {id = 3, parent = 2, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "not found"})}

52. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

53. if statement ==> (visitNode -> End): Method End

54. if statement ==> (visitNode -> End -> return something): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

55. if statement ==> (visitStmt -> ReturnStmt): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

56. if statement ==> (visitStmt -> ExcpExpr): handling expression: ExcpExpr {excpName = Exception, excpmsg = Just "not found"}

57. if statement ==> (visitExpr -> ExcpExpr): Modifying State: (Exception,ExcpExpr {excpName = Exception, excpmsg = Just "not found"})

58. if statement ==> (visitExpr -> ExcpExpr): Returning: ER_Expr (SException Int "Exception" "not found")

59. if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SException Int "Exception" "not found")

60. if statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SException Int "Exception" "not found")

61. if statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SException Int "Exception" "not found")

62. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 2,SIte (SBin (SymInt 5) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing)

63. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymInt 5) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing)

64. Next Node: End {id = 5, parent = 0, mExpr = Just (ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})})}

>>>>>>>>>> visitNode <<<<<<<<<<

65. (visitNode -> End): Method End

66. (visitNode -> End -> return something): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})}

67. (visitStmt -> ReturnStmt): handling return expression: ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"}, index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})}

68. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "arr"}

69. (visitExpr -> VarExpr): Look up in environmane table: (arr ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]) 

70. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "arr", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]}

71. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "pos"}

72. (visitExpr -> VarExpr): Look up in environmane table: (pos ~~> SymVar Int "pos") 

73. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "pos", er_val = SymVar Int "pos"}

74. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

75. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SArrayIndexAccess "arr" (SymVar Int "pos"))

76. (visitStmt -> ReturnStmt): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}

77. (visitNode -> End -> method returns): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "arr" (SymVar Int "pos"), arrayIndexCallValue = SArrayIndexAccess "arr" (SymVar Int "pos")}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(ScopeRange (SR {branchStart = 2, branchEnd = 4}),SIte (SBin (SymInt 5) Le (SymVar Int "pos")) (SymState {env = fromList [(MethodName "elemAt2",SMethodType Int),(FormalParms,SFormalParms ["pos"]),(VarBindings,SVarBindings (fromList [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("arr",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "arr",SymArray (Just (Array Int)) (Just 5) [SymInt 6,SymInt 5,SymInt 4,SymInt 7,SymInt 8]),(VarName "pos",SymVar Int "pos"),(Return,SException Int "Exception" "not found")], pc = []}) Nothing),(Return,SArrayIndexAccess "arr" (SymVar Int "pos"))], pc = []}