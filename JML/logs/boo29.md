================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Boolean) "boo29" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo29

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo29",SMethodType Bool)], pc = []})

5. Next Node: Node {id = 1, nodeData = BooleanExpression If (Just (BoolLiteral True)), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 1): If condition: BoolLiteral True

7. (visitExpr -> BoolLiteral): handling expression: BoolLiteral True

8. (visitExpr -> BoolLiteral): Returning: ER_Expr (SBool True)

9. if statement ==> Next Node: End {id = 2, parent = 1, mExpr = Just (BoolLiteral False)}

10. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

11. if statement ==> (visitNode -> End): Method End

12. if statement ==> (visitNode -> End -> return something): handling return expression: BoolLiteral False

13. if statement ==> (visitStmt -> ReturnStmt): handling return expression: BoolLiteral False

14. if statement ==> (visitExpr -> BoolLiteral): handling expression: BoolLiteral False

15. if statement ==> (visitExpr -> BoolLiteral): Returning: ER_Expr (SBool False)

16. if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SBool False)

17. if statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SBool False)

18. if statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SBool False)

19. (visitNode -> Node -> BooleanExpression if -> overwriting if): Modifying State: (<new state>,SymState {env = fromList [(MethodName "boo29",SMethodType Bool),(Return,SBool False),(Actions,SActions [])], pc = []})

20. (visitNode -> Node -> BooleanExpression If): Returning: ER_State (SymState {env = fromList [(MethodName "boo29",SMethodType Bool),(Return,SBool False),(Actions,SActions [])], pc = []})

21. Next Node: End {id = 5, parent = 0, mExpr = Nothing}

22. (Skip):
"End {id = 5, parent = 0, mExpr = Nothing}"
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo29",SMethodType Bool),(Return,SBool False),(Actions,SActions [])], pc = []}