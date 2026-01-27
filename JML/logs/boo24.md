================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo24" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo24

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo24",SMethodType Int)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo25"}, funArgs = [NumberLiteral 5.0]}}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo25"}, funArgs = [NumberLiteral 5.0]}}}}

7. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo25"}, funArgs = [NumberLiteral 5.0]}}}

8. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}, assEright = BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo25"}, funArgs = [NumberLiteral 5.0]}}}

9. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x"}

10. (visitExpr -> VarExpr): New Variable BuiltInType Int x

11. (visitExpr -> VarExpr): Modifying State: (x,SymNull Int)

12. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}

13. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = NumberLiteral 3.0, binOp = +, expr2 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo25"}, funArgs = [NumberLiteral 5.0]}}

14. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

15. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

16. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "boo25"}, funArgs = [NumberLiteral 5.0]}

17. formal: boo25 ==> Next Node: Entry (BuiltInType Int) "boo25" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

18. formal: boo25 ==> >>>>>>>>>> visitNode <<<<<<<<<<

19. formal: boo25 ==> (visitNode -> Entry): Method Start: boo25

20. formal: boo25 ==> (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}]

21. formal: boo25 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

22. formal: boo25 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

23. formal: boo25 ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

24. formal: boo25 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

25. formal: boo25 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}

26. formal: boo25 ==> (visitExpr -> VarExpr): New Variable BuiltInType Int i

27. formal: boo25 ==> (visitExpr -> VarExpr): Modifying State: (i,SymNull Int)

28. formal: boo25 ==> (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymNull Int}

29. formal: boo25 ==> (visitNode -> Entry -> method with args): Modifying State: (i,SymVar Int "i")

30. formal: boo25 ==> (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i")], pc = []})

31. formal: boo25 ==> Next Node: Node {id = 1, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 10.0})), parent = 0}

32. formal: boo25 ==> >>>>>>>>>> visitNode <<<<<<<<<<

33. formal: boo25 ==> (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 1): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 10.0}

34. formal: boo25 ==> (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = >, expr2 = NumberLiteral 10.0}

35. formal: boo25 ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "i"}

36. formal: boo25 ==> (visitExpr -> VarExpr): Look up in environmane table: (i ~~> SymVar Int "i") 

37. formal: boo25 ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymVar Int "i"}

38. formal: boo25 ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 10.0

39. formal: boo25 ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 10.0)

40. formal: boo25 ==> (visitExpr -> BinOpExpr): Affected: SymVar Int "i", >, SymNum 10.0

41. formal: boo25 ==> (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "i") Gt (SymInt 10))

42. formal: boo25 ==> if statement ==> Next Node: Node {id = 2, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "Oopsie"]}}), parent = 1}

43. formal: boo25 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

44. formal: boo25 ==> if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "Oopsie"]}}

45. formal: boo25 ==> if statement ==> (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [StringLiteral "Oopsie"]}

46. formal: boo25 ==> if statement ==> (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[StringLiteral "Oopsie"]

47. formal: boo25 ==> if statement ==> (visitExpr -> StringLiteral): handling expression: StringLiteral "Oopsie"

48. formal: boo25 ==> if statement ==> (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "Oopsie")

49. formal: boo25 ==> if statement ==> (visitExpr ==> FunCallExpr): Returning: ER_Print "Oopsie\n"

50. formal: boo25 ==> if statement ==> (visitStmt -> FunCallStmt): Modifying State: (SActions,Oopsie
)

51. formal: boo25 ==> if statement ==> (visitStmt -> FunCallStmt): Returning: ER_Print "Oopsie\n"

52. formal: boo25 ==> if statement ==> (visitNode -> Node -> Statement): Returning: ER_Print "Oopsie\n"

53. formal: boo25 ==> if statement ==> Next Node: End {id = 3, parent = 1, mExpr = Just (ExcpExpr {excpName = Exception, excpmsg = Just "meow"})}

54. formal: boo25 ==> if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

55. formal: boo25 ==> if statement ==> (visitNode -> End): Method End

56. formal: boo25 ==> if statement ==> (visitNode -> End -> return something): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "meow"}

57. formal: boo25 ==> if statement ==> (visitStmt -> ReturnStmt): handling return expression: ExcpExpr {excpName = Exception, excpmsg = Just "meow"}

58. formal: boo25 ==> if statement ==> (visitStmt -> ExcpExpr): handling expression: ExcpExpr {excpName = Exception, excpmsg = Just "meow"}

59. formal: boo25 ==> if statement ==> (visitExpr -> ExcpExpr): Modifying State: (Exception,ExcpExpr {excpName = Exception, excpmsg = Just "meow"})

60. formal: boo25 ==> if statement ==> (visitExpr -> ExcpExpr): Returning: ER_Expr (SException Int "Exception" "meow")

61. formal: boo25 ==> if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SException Int "Exception" "meow")

62. formal: boo25 ==> if statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SException Int "Exception" "meow")

63. formal: boo25 ==> if statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SException Int "Exception" "meow")

64. formal: boo25 ==> else statement ==> Next Node: End {id = 4, parent = 1, mExpr = Just (NumberLiteral 6.0)}

65. formal: boo25 ==> else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

66. formal: boo25 ==> else statement ==> (visitNode -> End): Method End

67. formal: boo25 ==> else statement ==> (visitNode -> End -> return something): handling return expression: NumberLiteral 6.0

68. formal: boo25 ==> else statement ==> (visitStmt -> ReturnStmt): handling return expression: NumberLiteral 6.0

69. formal: boo25 ==> else statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 6.0

70. formal: boo25 ==> else statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 6.0)

71. formal: boo25 ==> else statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 6)

72. formal: boo25 ==> else statement ==> (visitStmt -> ReturnStmt): Returning: ER_Expr (SymNum 6.0)

73. formal: boo25 ==> else statement ==> (visitNode -> End -> method returns): Returning: ER_Expr (SymNum 6.0)

74. formal: boo25 ==> (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 1,SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []})))

75. formal: boo25 ==> (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []})))

76. formal: boo25 ==> Next Node: End {id = 6, parent = 0, mExpr = Nothing}

77. formal: boo25 ==> >>>>>>>>>> visitNode <<<<<<<<<<

78. formal: boo25 ==> (visitNode -> End): Method End

79. formal: boo25 ==> (visitNode -> End -> return nothing): Void

80. formal: boo25 ==> (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments []),(VarName "i",SymVar Int "i"),(ScopeRange (SR {branchStart = 1, branchEnd = 5}),SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []})))], pc = []})

81. Method Call formal SymState: SymState {env = fromList [(MethodName "boo25",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments []),(VarName "i",SymVar Int "i"),(ScopeRange (SR {branchStart = 1, branchEnd = 5}),SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []})))], pc = []}

82. SymExec of actual parameter: boo25(5.0) ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

83. SymExec of actual parameter: boo25(5.0) ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

84. actual: boo25 ==> Next symExpr (MethodName "boo25" ==> SMethodType Int) in Method Call: boo25

85. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

86. actual: boo25 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

87. actual: boo25 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo25",SMethodType Int)

88. actual: boo25 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo25", er_val = SMethodType Int}

89. actual: boo25 ==> Next symExpr (GlobalVars ==> SGlobalVars []) in Method Call: boo25

90. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

91. actual: boo25 ==> (visitSymExpr -> SGlobalVars): handling SymExpr: SGlobalVars []

92. actual: boo25 ==> (visitSymExpr -> SGlobalVars): Modifying State: (GlobalVars,SGlobalVars [])

93. actual: boo25 ==> (visitSymExpr -> SGlobalVars): Returning: ER_SymStateMapEntry {er_key = GlobalVars, er_val = SGlobalVars []}

94. actual: boo25 ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo25

95. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

96. actual: boo25 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

97. actual: boo25 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

98. actual: boo25 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

99. actual: boo25 ==> Next symExpr (VarAssignments ==> SVarAssignments []) in Method Call: boo25

100. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

101. actual: boo25 ==> (visitSymExpr -> SVarAssignments): handling SymExpr: SVarAssignments []

102. actual: boo25 ==> (visitSymExpr -> SVarAssignments): Modifying State: (VarAssignments,SVarAssignments [])

103. actual: boo25 ==> (visitSymExpr -> SVarAssignments): Returning: ER_SymStateMapEntry {er_key = VarAssignments, er_val = SVarAssignments []}

104. actual: boo25 ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo25

105. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

106. actual: boo25 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

107. actual: boo25 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

108. actual: boo25 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 5)

109. actual: boo25 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SymInt 5)

110. actual: boo25 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymInt 5}

111. actual: boo25 ==> Next symExpr (ScopeRange (SR {branchStart = 1, branchEnd = 5}) ==> SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []}))) in Method Call: boo25

112. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

113. actual: boo25 ==> (visitSymExpr -> SIte): handling SymExpr: SIte (SBin (SymVar Int "i") Gt (SymInt 10)) (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SException Int "Exception" "meow"),(Actions,SActions ["Oopsie\n"])], pc = []}) (Just (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymVar Int "i"),(Return,SymInt 6)], pc = []}))

114. actual: boo25 ==> (visitSymExpr0 -> SBin): handling SymExpr: SBin (SymVar Int "i") Gt (SymInt 10)

SymState {env = fromList [(MethodName "boo25",SMethodType Int),(GlobalVars,SGlobalVars []),(FormalParms,SFormalParms ["i"]),(VarAssignments,SVarAssignments []),(VarName "i",SymInt 5)], pc = []}

115. actual: boo25 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

116. actual: boo25 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 5)

117. actual: boo25 ==> (visitSymExpr0 -> SymInt): handling SymExpr: SymInt 10

118. actual: boo25 ==> (visitSymExpr0 -> SymInt): Returning: ER_Expr (SymInt 10)

119. actual: boo25 ==> (visitSymExpr -> SBin): Returning: ER_Expr (SBool False)

120. actual: boo25 ==> Next symExpr (MethodName "boo25" ==> SMethodType Int) in Method Call: boo25

121. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

122. actual: boo25 ==> (visitSymExpr -> SMethodType): handling SymExpr: SMethodType Int

123. actual: boo25 ==> (visitSymExpr -> SMethodType): Modifying State: (MethodName "boo25",SMethodType Int)

124. actual: boo25 ==> (visitSymExpr -> SMethodType): Returning: ER_SymStateMapEntry {er_key = MethodName "boo25", er_val = SMethodType Int}

125. actual: boo25 ==> Next symExpr (FormalParms ==> SFormalParms ["i"]) in Method Call: boo25

126. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

127. actual: boo25 ==> (visitSymExpr -> SFormalParms): handling SymExpr: SFormalParms ["i"]

128. actual: boo25 ==> (visitSymExpr -> SFormalParms): Modifying State: (FormalParms,SFormalParms ["i"])

129. actual: boo25 ==> (visitSymExpr -> SFormalParms): Returning: ER_SymStateMapEntry {er_key = FormalParms, er_val = SFormalParms ["i"]}

130. actual: boo25 ==> Next symExpr (VarName "i" ==> SymVar Int "i") in Method Call: boo25

131. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

132. actual: boo25 ==> (visitSymExpr -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

133. actual: boo25 ==> (visitSymExpr0 -> SymVar -> Formal Parameter): handling SymExpr: SymVar Int "i"

134. actual: boo25 ==> (visitSymExpr0 -> SymVar): Returning: ER_Expr (SymInt 5)

135. actual: boo25 ==> (visitSymExpr -> SymVar): Modifying State: (VarName "i",SymInt 5)

136. actual: boo25 ==> (visitSymExpr -> SymVar): Returning: ER_SymStateMapEntry {er_key = VarName "i", er_val = SymInt 5}

137. actual: boo25 ==> Next symExpr (Return ==> SymInt 6) in Method Call: boo25

138. actual: boo25 ==> >>>>>>>>>> visitSymExpr <<<<<<<<<<

139. actual: boo25 ==> (visitSymExpr -> SymInt): handling SymExpr: SymInt 6

140. actual: boo25 ==> (visitSymExpr -> SymInt): Modifying State: (Return,SymInt 6)

141. actual: boo25 ==> (visitSymExpr -> SymInt): Returning: ER_SymStateMapEntry {er_key = Return, er_val = SymInt 6}

142. actual: boo25 ==> (visitSymExpr -> SIte -> resolved condition is False): Modifying State: (<no key>,<whole state is updated>: SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymInt 5),(Return,SymInt 6)], pc = []})

143. Method Call actual SymState: SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymInt 5),(Return,SymInt 6)], pc = []}

144. (visitExpr -> FunCallExpr -> with parameters): Returning: ER_FunCall (SymState {env = fromList [(MethodName "boo25",SMethodType Int),(FormalParms,SFormalParms ["i"]),(VarName "i",SymInt 5),(Return,SymInt 6)], pc = []})

145. (visitExpr -> BinOpExpr): Affected: SymNum 3.0, +, SymInt 6

146. (visitExpr -> BinOpExpr -> numericCalculator): Returning: ER_Expr (SymInt 9)

147. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymNull Int}, ER_Expr (SymInt 9)

148. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x"
    Old Value: SymNull Int
    New Value: SymInt 9

149. (visitExpr ==> AssignExpr): Modifying State: (VarName "x",SymInt 9)

150. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 9}

151. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 9}

152. (visitNode -> Node -> Statement): Adding Var Binding: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

153. (visitNode -> Node -> Statement): Adding Var Assignment: ("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})

154. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 9}

155. Next Node: End {id = 2, parent = 0, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "x"})}

>>>>>>>>>> visitNode <<<<<<<<<<

156. (visitNode -> End): Method End

157. (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

158. (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

159. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "x"}

160. (visitExpr -> VarExpr): Look up in environmane table: (x ~~> SymInt 9) 

161. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 9}

162. (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 9)

163. (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 9}

164. (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "x", er_val = SymInt 9}
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo24",SMethodType Int),(VarBindings,SVarBindings (fromList [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})])),(VarAssignments,SVarAssignments [("x",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 2}})]),(VarName "x",SymInt 9),(Return,SymInt 9)], pc = []}