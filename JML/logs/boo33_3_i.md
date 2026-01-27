================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Double) "boo33_3_i" [VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo33_3_i

3. (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "i"}]

4. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "i"}

5. (visitExpr -> VarExpr): New Variable BuiltInType Double i

6. (visitExpr -> VarExpr): Modifying State: (i,SymNull Double)

7. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Double}

8. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "i"}

9. (visitExpr -> VarExpr): New Variable BuiltInType Double i

10. (visitExpr -> VarExpr): Modifying State: (i,SymNull Double)

11. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Double}

12. (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Double "i")

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo33_3_i",SMethodType Double),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Double "i")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}

19. (visitExpr -> VarExpr): New Variable BuiltInType Double x

20. (visitExpr -> VarExpr): Modifying State: (x,SymNull Double)

21. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Double}

22. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}

23. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

24. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

25. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

26. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Double "i") 

27. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Double "i"}

28. (visitExpr -> BinOpExpr): Affected: SymNum 1.0, +, SymVar Double "i"

29. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymDouble 1.0) Add (SymVar Double "i"))

30. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Double}, ER_Expr (SBin (SymDouble 1.0) Add (SymVar Double "i"))

31. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Double
    New Value: SBin (SymDouble 1.0) Add (SymVar Double "i")

32. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SBin (SymDouble 1.0) Add (SymVar Double "i"))

33. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

34. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

35. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

36. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

37. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

38. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

39. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}}}

40. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}}

41. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}}

42. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

43. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SBin (SymDouble 1.0) Add (SymVar Double "i")) 

44. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

45. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}

46. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

47. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SBin (SymDouble 1.0) Add (SymVar Double "i")) 

48. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

49. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.1

50. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.1)

51. (visitExpr -> BinOpExpr): Affected: SBin (SymDouble 1.0) Add (SymVar Double "i"), +, SymNum 0.1

52. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymDouble 1.1) Add (SymVar Double "i"))

53. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}, ER_Expr (SBin (SymDouble 1.1) Add (SymVar Double "i"))

54. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SBin (SymDouble 1.0) Add (SymVar Double "i")
    New Value: SBin (SymDouble 1.1) Add (SymVar Double "i")

55. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SBin (SymDouble 1.1) Add (SymVar Double "i"))

56. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.1) Add (SymVar Double "i")}

57. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.1) Add (SymVar Double "i")}

58. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})

59. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.1) Add (SymVar Double "i")}

60. Next Node: End {id = 3, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}

>>>>>>>>>> visitNode <<<<<<<<<<

61. (visitNode -> End): Method End

62. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

63. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

64. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

65. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SBin (SymDouble 1.1) Add (SymVar Double "i")) 

66. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.1) Add (SymVar Double "i")}

67. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SymDouble 1.1) Add (SymVar Double "i"))

68. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.1) Add (SymVar Double "i")}

69. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.1) Add (SymVar Double "i")}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo33_3_i",SMethodType Double),(FormalParms,SFormalParms ["i"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "i",SymVar Double "i"),(VarName "x",SBin (SymDouble 1.1) Add (SymVar Double "i")),(Return,SBin (SymDouble 1.1) Add (SymVar Double "i"))], pc = []}