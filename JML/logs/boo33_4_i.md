================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Double) "boo33_4_i" [VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "i"},VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "j"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo33_4_i

3. (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "i"},VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "j"}]

4. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "i"}

5. (visitExpr -> VarExpr): New Variable BuiltInType Double i

6. (visitExpr -> VarExpr): Modifying State: (i,SymNull Double)

7. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Double}

8. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "j"}

9. (visitExpr -> VarExpr): New Variable BuiltInType Double j

10. (visitExpr -> VarExpr): Modifying State: (j,SymNull Double)

11. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "j", er_val = SymNull Double}

12. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "i"}

13. (visitExpr -> VarExpr): New Variable BuiltInType Double i

14. (visitExpr -> VarExpr): Modifying State: (i,SymNull Double)

15. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Double}

16. (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Double "i")

17. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "j"}

18. (visitExpr -> VarExpr): New Variable BuiltInType Double j

19. (visitExpr -> VarExpr): Modifying State: (j,SymNull Double)

20. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "j", er_val = SymNull Double}

21. (visitNode -> Entry -> method with args): Modifying State: (j,SymVar Double "j")

22. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo33_4_i",SMethodType Double),(FormalParms,SFormalParms ["i","j"]),(VarName "i",SymVar Double "i"),(VarName "j",SymVar Double "j")], pc = []})

23. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

24. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}}

25. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

26. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}}

27. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Double), varObj = [], varName = "x"}

28. (visitExpr -> VarExpr): New Variable BuiltInType Double x

29. (visitExpr -> VarExpr): Modifying State: (x,SymNull Double)

30. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Double}

31. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 1.0, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "i"}}

32. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

33. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

34. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

35. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Double "i") 

36. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Double "i"}

37. (visitExpr -> BinOpExpr): Affected: SymNum 1.0, +, SymVar Double "i"

38. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymDouble 1.0) Add (SymVar Double "i"))

39. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Double}, ER_Expr (SBin (SymDouble 1.0) Add (SymVar Double "i"))

40. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Double
    New Value: SBin (SymDouble 1.0) Add (SymVar Double "i")

41. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SBin (SymDouble 1.0) Add (SymVar Double "i"))

42. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

43. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

44. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

45. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

46. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

47. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "j"}}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

48. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "j"}}}}

49. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "j"}}}

50. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "j"}}}

51. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

52. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SBin (SymDouble 1.0) Add (SymVar Double "i")) 

53. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

54. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "j"}}

55. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "x"}, binOp = +, expr2 = NumberLiteral 0.1}

56. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

57. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SBin (SymDouble 1.0) Add (SymVar Double "i")) 

58. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}

59. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.1

60. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.1)

61. (visitExpr -> BinOpExpr): Affected: SBin (SymDouble 1.0) Add (SymVar Double "i"), +, SymNum 0.1

62. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SymDouble 1.1) Add (SymVar Double "i"))

63. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "j"}

64. (visitExpr -> VarExpr): Look up in environmane table: (j ~~> SymVar Double "j") 

65. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "j", er_val = SymVar Double "j"}

66. (visitExpr -> BinOpExpr): Affected: SBin (SymDouble 1.1) Add (SymVar Double "i"), +, SymVar Double "j"

67. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j"))

68. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SymDouble 1.0) Add (SymVar Double "i")}, ER_Expr (SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j"))

69. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SBin (SymDouble 1.0) Add (SymVar Double "i")
    New Value: SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")

70. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j"))

71. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")}

72. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")}

73. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})

74. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")}

75. Next Node: End {id = 3, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}

>>>>>>>>>> visitNode <<<<<<<<<<

76. (visitNode -> End): Method End

77. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

78. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

79. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

80. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")) 

81. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")}

82. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j"))

83. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")}

84. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo33_4_i",SMethodType Double),(FormalParms,SFormalParms ["i","j"]),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("x",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "i",SymVar Double "i"),(VarName "j",SymVar Double "j"),(VarName "x",SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j")),(Return,SBin (SBin (SymDouble 1.1) Add (SymVar Double "i")) Add (SymVar Double "j"))], pc = []}