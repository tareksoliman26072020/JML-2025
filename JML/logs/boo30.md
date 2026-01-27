================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Int) "boo30" [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}]

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: boo30

3. (visitNode -> Entry -> method with args): Visiting formal parameters: [VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}]

4. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}

5. (visitExpr -> VarExpr): New Variable BuiltInType Int z

6. (visitExpr -> VarExpr): Modifying State: (z,SymNull Int)

7. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNull Int}

8. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "z"}

9. (visitExpr -> VarExpr): New Variable BuiltInType Int z

10. (visitExpr -> VarExpr): Modifying State: (z,SymNull Int)

11. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymNull Int}

12. (visitNode -> Entry -> method with args): Modifying State: (z,SymVar Int "z")

13. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(FormalParms,SFormalParms ["z"]),(VarName "z",SymVar Int "z")], pc = []})

14. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x1"}, assEright = NumberLiteral 0.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

15. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x1"}, assEright = NumberLiteral 0.0}}

16. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x1"}, assEright = NumberLiteral 0.0}

17. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x1"}, assEright = NumberLiteral 0.0}

18. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x1"}

19. (visitExpr -> VarExpr): New Variable BuiltInType Int x1

20. (visitExpr -> VarExpr): Modifying State: (x1,SymNull Int)

21. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x1", er_val = SymNull Int}

22. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

23. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

24. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x1", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

25. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x1"
    Old Value: SymNull Int
    New Value: SymInt 0

26. (visitExpr ==> AssignExpr): Modifying State: (VarName "x1",SymInt 0)

27. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x1", er_val = SymInt 0}

28. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x1", er_val = SymInt 0}

29. (visitNode -> Node -> Statement): Adding Var Binding: ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

30. (visitNode -> Node -> Statement): Adding Var Assignment: ("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}})

31. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x1", er_val = SymInt 0}

32. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x2"}, assEright = NumberLiteral 0.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

33. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x2"}, assEright = NumberLiteral 0.0}}

34. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x2"}, assEright = NumberLiteral 0.0}

35. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x2"}, assEright = NumberLiteral 0.0}

36. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "x2"}

37. (visitExpr -> VarExpr): New Variable BuiltInType Int x2

38. (visitExpr -> VarExpr): Modifying State: (x2,SymNull Int)

39. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "x2", er_val = SymNull Int}

40. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

41. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

42. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "x2", er_val = SymNull Int}, ER_Expr (SymNum 0.0)

43. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "x2"
    Old Value: SymNull Int
    New Value: SymInt 0

44. (visitExpr ==> AssignExpr): Modifying State: (VarName "x2",SymInt 0)

45. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "x2", er_val = SymInt 0}

46. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "x2", er_val = SymInt 0}

47. (visitNode -> Node -> Statement): Adding Var Binding: ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

48. (visitNode -> Node -> Statement): Adding Var Assignment: ("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})

49. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "x2", er_val = SymInt 0}

50. Next Node: Node {id = 3, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

51. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}}

52. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}

53. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y"}, assEright = NumberLiteral 0.0}

54. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y"}

55. (visitExpr -> VarExpr): Global Variable Detected: y 

56. (visitExpr -> VarExpr): Modifying State: (y,SymVar UnknownGlobalVarSymType "y")

57. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}

58. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

59. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

60. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymVar UnknownGlobalVarSymType "y"}, ER_Expr (SymNum 0.0)

61. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y"
    Old Value: SymVar UnknownGlobalVarSymType "y"
    New Value: SymNum 0.0

62. (visitExpr ==> AssignExpr): Modifying State: (VarName "y",SymNum 0.0)

63. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNum 0.0}

64. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNum 0.0}

65. (visitNode -> Node -> Statement): Adding Var Assignment: ("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}})

66. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y", er_val = SymNum 0.0}

67. Next Node: Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, assEright = NumberLiteral 0.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

68. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, assEright = NumberLiteral 0.0}}

69. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, assEright = NumberLiteral 0.0}

70. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y1"}, assEright = NumberLiteral 0.0}

71. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y1"}

72. (visitExpr -> VarExpr): Global Variable Detected: y1 

73. (visitExpr -> VarExpr): Modifying State: (y1,SymVar UnknownGlobalVarSymType "y1")

74. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y1", er_val = SymVar UnknownGlobalVarSymType "y1"}

75. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

76. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

77. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y1", er_val = SymVar UnknownGlobalVarSymType "y1"}, ER_Expr (SymNum 0.0)

78. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y1"
    Old Value: SymVar UnknownGlobalVarSymType "y1"
    New Value: SymNum 0.0

79. (visitExpr ==> AssignExpr): Modifying State: (VarName "y1",SymNum 0.0)

80. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y1", er_val = SymNum 0.0}

81. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y1", er_val = SymNum 0.0}

82. (visitNode -> Node -> Statement): Adding Var Assignment: ("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}})

83. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y1", er_val = SymNum 0.0}

84. Next Node: Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y2"}, assEright = NumberLiteral 0.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

85. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y2"}, assEright = NumberLiteral 0.0}}

86. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y2"}, assEright = NumberLiteral 0.0}

87. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "y2"}, assEright = NumberLiteral 0.0}

88. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "y2"}

89. (visitExpr -> VarExpr): Global Variable Detected: y2 

90. (visitExpr -> VarExpr): Modifying State: (y2,SymVar UnknownGlobalVarSymType "y2")

91. (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "y2", er_val = SymVar UnknownGlobalVarSymType "y2"}

92. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

93. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

94. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "y2", er_val = SymVar UnknownGlobalVarSymType "y2"}, ER_Expr (SymNum 0.0)

95. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "y2"
    Old Value: SymVar UnknownGlobalVarSymType "y2"
    New Value: SymNum 0.0

96. (visitExpr ==> AssignExpr): Modifying State: (VarName "y2",SymNum 0.0)

97. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "y2", er_val = SymNum 0.0}

98. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "y2", er_val = SymNum 0.0}

99. (visitNode -> Node -> Statement): Adding Var Assignment: ("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}})

100. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "y2", er_val = SymNum 0.0}

101. Next Node: Node {id = 6, nodeData = BooleanExpression If (Just (BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "z"}, binOp = >=, expr2 = NumberLiteral 0.0})), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

102. (visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: 6): If condition: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "z"}, binOp = >=, expr2 = NumberLiteral 0.0}

103. (visitExpr -> BinOpExpr): handling expression: BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "z"}, binOp = >=, expr2 = NumberLiteral 0.0}

104. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "z"}

105. (visitExpr -> VarExpr): Look up in environmane table: (z ~~> SymVar Int "z") 

106. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "z", er_val = SymVar Int "z"}

107. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

108. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

109. (visitExpr -> BinOpExpr): Affected: SymVar Int "z", >=, SymNum 0.0

110. (visitExpr -> BinOpExpr -> booleanCalculator): Returning: ER_Expr (SBin (SymVar Int "z") Ge (SymInt 0))

111. if statement ==> Next Node: Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t1"}, assEright = NumberLiteral 7.0}}), parent = 6}

112. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

113. if statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t1"}, assEright = NumberLiteral 7.0}}

114. if statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t1"}, assEright = NumberLiteral 7.0}

115. if statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t1"}, assEright = NumberLiteral 7.0}

116. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "t1"}

117. if statement ==> (visitExpr -> VarExpr): Global Variable Detected: t1 

118. if statement ==> (visitExpr -> VarExpr): Modifying State: (t1,SymVar UnknownGlobalVarSymType "t1")

119. if statement ==> (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "t1", er_val = SymVar UnknownGlobalVarSymType "t1"}

120. if statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 7.0

121. if statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 7.0)

122. if statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "t1", er_val = SymVar UnknownGlobalVarSymType "t1"}, ER_Expr (SymNum 7.0)

123. if statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "t1"
    Old Value: SymVar UnknownGlobalVarSymType "t1"
    New Value: SymNum 7.0

124. if statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "t1",SymNum 7.0)

125. if statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "t1", er_val = SymNum 7.0}

126. if statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "t1", er_val = SymNum 7.0}

127. if statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}})

128. if statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "t1", er_val = SymNum 7.0}

129. if statement ==> Next Node: End {id = 8, parent = 6, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "t1"})}

130. if statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

131. if statement ==> (visitNode -> End): Method End

132. if statement ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "t1"}

133. if statement ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "t1"}

134. if statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "t1"}

135. if statement ==> (visitExpr -> VarExpr): Look up in environmane table: (t1 ~~> SymNum 7.0) 

136. if statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "t1", er_val = SymNum 7.0}

137. if statement ==> (castGlobalVar): Update Variable
    Var Name: t1
    Old Value: SymNum 7.0
    New Value: SymInt 7

138. if statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 7)

139. if statement ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "t1", er_val = SymNum 7.0}

140. if statement ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "t1", er_val = SymNum 7.0}

141. else statement ==> Next Node: Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t2"}, assEright = NumberLiteral 17.0}}), parent = 6}

142. else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

143. else statement ==> (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t2"}, assEright = NumberLiteral 17.0}}

144. else statement ==> (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t2"}, assEright = NumberLiteral 17.0}

145. else statement ==> (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "t2"}, assEright = NumberLiteral 17.0}

146. else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "t2"}

147. else statement ==> (visitExpr -> VarExpr): Global Variable Detected: t2 

148. else statement ==> (visitExpr -> VarExpr): Modifying State: (t2,SymVar UnknownGlobalVarSymType "t2")

149. else statement ==> (visitExpr -> VarExpr -> Recording Global Variable): Returning: ER_SymStateMapEntry {er_key = VarName "t2", er_val = SymVar UnknownGlobalVarSymType "t2"}

150. else statement ==> (visitExpr -> NumberLiteral): handling expression: NumberLiteral 17.0

151. else statement ==> (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 17.0)

152. else statement ==> (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "t2", er_val = SymVar UnknownGlobalVarSymType "t2"}, ER_Expr (SymNum 17.0)

153. else statement ==> (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "t2"
    Old Value: SymVar UnknownGlobalVarSymType "t2"
    New Value: SymNum 17.0

154. else statement ==> (visitExpr ==> AssignExpr): Modifying State: (VarName "t2",SymNum 17.0)

155. else statement ==> (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "t2", er_val = SymNum 17.0}

156. else statement ==> (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "t2", er_val = SymNum 17.0}

157. else statement ==> (visitNode -> Node -> Statement): Adding Var Assignment: ("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})

158. else statement ==> (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "t2", er_val = SymNum 17.0}

159. else statement ==> Next Node: End {id = 10, parent = 6, mExpr = Just (VarExpr {varType = Nothing, varObj = [], varName = "t2"})}

160. else statement ==> >>>>>>>>>> visitNode <<<<<<<<<<

161. else statement ==> (visitNode -> End): Method End

162. else statement ==> (visitNode -> End -> return something): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "t2"}

163. else statement ==> (visitStmt -> ReturnStmt): handling return expression: VarExpr {varType = Nothing, varObj = [], varName = "t2"}

164. else statement ==> (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "t2"}

165. else statement ==> (visitExpr -> VarExpr): Look up in environmane table: (t2 ~~> SymNum 17.0) 

166. else statement ==> (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "t2", er_val = SymNum 17.0}

167. else statement ==> (castGlobalVar): Update Variable
    Var Name: t2
    Old Value: SymNum 17.0
    New Value: SymInt 17

168. else statement ==> (visitStmt -> ReturnStmt -> method with args): Modifying State: (return,SymInt 17)

169. else statement ==> (visitStmt -> ReturnStmt): Returning: ER_SymStateMapEntry {er_key = VarName "t2", er_val = SymNum 17.0}

170. else statement ==> (visitNode -> End -> method returns): Returning: ER_SymStateMapEntry {er_key = VarName "t2", er_val = SymNum 17.0}

171. (visitNode -> Node -> BooleanExpression if -> recording symbolic branching): Modifying State: (if node num: 6,SIte (SBin (SymVar Int "z") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t1"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t1",SymInt 7),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 7)], pc = []}) (Just (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t2"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t2",SymInt 17),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 17)], pc = []})))

172. (visitNode -> Node -> BooleanExpression If): Returning: ER_Expr (SIte (SBin (SymVar Int "z") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t1"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t1",SymInt 7),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 7)], pc = []}) (Just (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t2"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t2",SymInt 17),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 17)], pc = []})))

173. Next Node: End {id = 12, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

174. (visitNode -> End): Method End

175. (visitNode -> End -> return nothing): Void

176. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t1","t2"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}}),("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t1",SymUnknown (Int,"t1",Nothing) [([(If,SR {branchStart = 6, branchEnd = 11})],7)]),(VarName "t2",SymUnknown (Int,"t2",Nothing) [([(If,SR {branchStart = 6, branchEnd = 11})],9)]),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(ScopeRange (SR {branchStart = 6, branchEnd = 11}),SIte (SBin (SymVar Int "z") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t1"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t1",SymInt 7),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 7)], pc = []}) (Just (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t2"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t2",SymInt 17),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 17)], pc = []})))], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t1","t2"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}}),("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t1",SymUnknown (Int,"t1",Nothing) [([(If,SR {branchStart = 6, branchEnd = 11})],7)]),(VarName "t2",SymUnknown (Int,"t2",Nothing) [([(If,SR {branchStart = 6, branchEnd = 11})],9)]),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(ScopeRange (SR {branchStart = 6, branchEnd = 11}),SIte (SBin (SymVar Int "z") Ge (SymInt 0)) (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t1"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t1",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t1",SymInt 7),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 7)], pc = []}) (Just (SymState {env = fromList [(MethodName "boo30",SMethodType Int),(GlobalVars,SGlobalVars ["y","y1","y2","t2"]),(FormalParms,SFormalParms ["z"]),(VarBindings,SVarBindings (fromList [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}})])),(VarAssignments,SVarAssignments [("x1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 8}}),("x2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y1",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 8}}),("y2",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 8}}),("t2",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 6, branchEnd = 11}})]),(VarName "t2",SymInt 17),(VarName "x1",SymInt 0),(VarName "x2",SymInt 0),(VarName "y",SymNum 0.0),(VarName "y1",SymNum 0.0),(VarName "y2",SymNum 0.0),(VarName "z",SymVar Int "z"),(Return,SymInt 17)], pc = []})))], pc = []}