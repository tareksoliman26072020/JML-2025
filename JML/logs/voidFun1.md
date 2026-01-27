================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Void) "voidFun1" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: voidFun1

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "voidFun1",SMethodType Void)], pc = []})

5. Next Node: End {id = 1, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> End): Method End

7. (visitNode -> End -> return nothing): Void

8. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "voidFun1",SMethodType Void)], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "voidFun1",SMethodType Void)], pc = []}