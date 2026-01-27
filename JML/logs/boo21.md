================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo21" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo21

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo21",SMethodType Int)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Just (NumberLiteral 5.0)}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return something): handling return expression: NumberLiteral 5.0

8. (visitStmt -> ReturnStmt): handling return expression: NumberLiteral 5.0

9. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

10. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

11. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 5)

12. (visitStmt -> ReturnStmt): Returning: ER_Expr (SymNum 5.0)

13. (visitNode -> End -> method returns): Returning: ER_Expr (SymNum 5.0)
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo21",SMethodType Int),(Return,SymInt 5)], pc = []}