================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo25" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo25

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

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

14. Next Node: Node {id = 1, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 10.0})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 1): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 10.0}

16. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 10.0}

17. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

18. (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

19. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

20. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 10.0

21. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 10.0)

22. (visitExpr -> BinOpExpr): Affected: SymVar Int "i", >, SymNum 10.0

23. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Gt (SymInt 10))

24. if statement ==> Next Node: Node {id = 2, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "Oopsie"]}}), parent = 1}

25. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

26. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "Oopsie"]}}

27. if statement ==> (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "Oopsie"]}

28. if statement ==> (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[StringLiteral "Oopsie"]

29. if statement ==> (visitExpr -> StringLiteral): handling expression: StringLiteral "Oopsie"

30. if statement ==> (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "Oopsie")

31. if statement ==> (visitExpr ==> FunCallExpr): Returning: ER_Print "Oopsie\n"

32. if statement ==> (visitStmt -> FunCallStmt): Modifying State: (SActions,Oopsie
)

33. if statement ==> (visitStmt -> FunCallStmt): Returning: ER_Print "Oopsie\n"

34. if statement ==> (visitNode -> Node -> Statement): Returning: ER_Print "Oopsie\n"

35. if statement ==> Next Node: End {id = 3, parent = 1, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "meow"})}

36. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

37. if statement ==> (visitNode -> End): Method End

38. if statement ==> (visitNode -> End -> return something): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "meow"}

39. if statement ==> (visitStmt -> ReturnStmt): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "meow"}

40. if statement ==> (visitStmt -> ExcpExpr): handling expression: ExcpExpr {excpName = Exception, excpmsg = Just "meow"}

41. if statement ==> (visitExpr -> ExcpExpr): Modifying State: (Exception,ExcpExpr {excpName = Exception, excpmsg = Just "meow"})

42. if statement ==> (visitExpr -> ExcpExpr): Returning: ER_Expr (SException Int "Exception" "meow")

43. if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SException Int "Exception" "meow")

44. if statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SException Int "Exception" "meow")

45. if statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SException Int "Exception" "meow")

46. else statement ==> Next Node: End {id = 4, parent = 1, mExpr = Just (NumberLiteral 6.0)}

47. else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

48. else statement ==> (visitNode -> End): Method End

49. else statement ==> (visitNode -> End -> return something): handling return expression: NumberLiteral 6.0

50. else statement ==> (visitStmt -> ReturnStmt): handling return expression: NumberLiteral 6.0

51. else statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 6.0

52. else statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 6.0)

53. else statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 6)

54. else statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SymNum 6.0)

55. else statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SymNum 6.0)

56. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 1,SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []})))

57. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []})))

58. Next Node: End {id = 6, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

59. (visitNode -> End): Method End

60. (visitNode -> End -> return nothing): Void

61. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments []),(VarName "i",SymVar Int "i"),(ScopeRange (SR {branchStart = 1, branchEnd = 5}),SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []})))], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo25",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments []),(VarName "i",SymVar Int "i"),(ScopeRange (SR {branchStart = 1, branchEnd = 5}),SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []})))], pc = []}