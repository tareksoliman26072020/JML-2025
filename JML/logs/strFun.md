================
===Begin Logs===
================
1. Next Node: Entry (AnyType {typee = "String", generic = Nothing}) "strFun" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: strFun

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "strFun",SMethodType String)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "firstName"}, assEright = StringLiteral "Tarek"}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "firstName"}, assEright = StringLiteral "Tarek"}}

7. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "firstName"}, assEright = StringLiteral "Tarek"}

8. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "firstName"}, assEright = StringLiteral "Tarek"}

9. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "firstName"}

10. (visitExpr -> VarExpr): New Variable AnyType {typee = "String", generic = Nothing} firstName

11. (visitExpr -> VarExpr): Modifying State: (firstName,SymNull String)

12. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "firstName", er_val = SymNull String}

13. (visitExpr -> StringLiteral): handling expression: StringLiteral "Tarek"

14. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "Tarek")

15. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "firstName", er_val = SymNull String}, ER_Expr (SymString "Tarek")

16. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "firstName"
    Old Value: SymNull String
    New Value: SymString "Tarek"

17. (visitExpr ==> AssignExpr): Modifying State: (VarName "firstName",SymString "Tarek")

18. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "firstName", er_val = SymString "Tarek"}

19. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "firstName", er_val = SymString "Tarek"}

20. (visitNode -> Node -> Statement): Adding Var Binding: ("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

21. (visitNode -> Node -> Statement): Adding Var Assignment: ("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}})

22. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "firstName", er_val = SymString "Tarek"}

23. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "lastName"}, assEright = StringLiteral "Soliman"}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

24. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "lastName"}, assEright = StringLiteral "Soliman"}}

25. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "lastName"}, assEright = StringLiteral "Soliman"}

26. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "lastName"}, assEright = StringLiteral "Soliman"}

27. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (AnyType {typee = "String", generic = Nothing}), varObj = [], varName = "lastName"}

28. (visitExpr -> VarExpr): New Variable AnyType {typee = "String", generic = Nothing} lastName

29. (visitExpr -> VarExpr): Modifying State: (lastName,SymNull String)

30. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "lastName", er_val = SymNull String}

31. (visitExpr -> StringLiteral): handling expression: StringLiteral "Soliman"

32. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "Soliman")

33. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "lastName", er_val = SymNull String}, ER_Expr (SymString "Soliman")

34. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "lastName"
    Old Value: SymNull String
    New Value: SymString "Soliman"

35. (visitExpr ==> AssignExpr): Modifying State: (VarName "lastName",SymString "Soliman")

36. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "lastName", er_val = SymString "Soliman"}

37. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "lastName", er_val = SymString "Soliman"}

38. (visitNode -> Node -> Statement): Adding Var Binding: ("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})

39. (visitNode -> Node -> Statement): Adding Var Assignment: ("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})

40. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "lastName", er_val = SymString "Soliman"}

41. Next Node: End {id = 3, parent = 0, mExpr = Just (BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "firstName"}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "lastName"}})}

>>>>>>>>>> visitNode <<<<<<<<<<

42. (visitNode -> End): Method End

43. (visitNode -> End -> return something): handling return expression: BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "firstName"}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "lastName"}}

44. (visitStmt -> ReturnStmt): handling return expression: BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "firstName"}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "lastName"}}

45. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "firstName"}, binOp = +, expr2 = StringLiteral " "}, binOp = +, expr2 = VarExpr {varType = Nothing, varObj = [], varName = "lastName"}}

46. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "firstName"}, binOp = +, expr2 = StringLiteral " "}

47. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "firstName"}

48. (visitExpr -> VarExpr): Look up in environmane table: (firstName ~~> SymString "Tarek") 

49. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "firstName", er_val = SymString "Tarek"}

50. (visitExpr -> StringLiteral): handling expression: StringLiteral " "

51. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString " ")

52. (visitExpr -> BinOpExpr): Affected: SymString "Tarek", +, SymString " "

53. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymString "Tarek ")

54. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "lastName"}

55. (visitExpr -> VarExpr): Look up in environmane table: (lastName ~~> SymString "Soliman") 

56. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "lastName", er_val = SymString "Soliman"}

57. (visitExpr -> BinOpExpr): Affected: SymString "Tarek ", +, SymString "Soliman"

58. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymString "Tarek Soliman")

59. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymString "Tarek Soliman")

60. (visitStmt -> ReturnStmt): Returning: ER_Expr (SymString "Tarek Soliman")

61. (visitNode -> End -> method returns): Returning: ER_Expr (SymString "Tarek Soliman")
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "strFun",SMethodType String),(VarBindings,SVarBindings (fromList [("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})])),(VarAssignments,SVarAssignments [("firstName",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 3}}),("lastName",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 3}})]),(VarName "firstName",SymString "Tarek"),(VarName "lastName",SymString "Soliman"),(Return,SymString "Tarek Soliman")], pc = []}