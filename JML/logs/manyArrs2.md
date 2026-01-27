================
===Begin Logs===
================
1. Next Node: Entry (BuiltInType Void) "manyArrs2" []

>>>>>>>>>> visitNode <<<<<<<<<<

2. (visitNode -> Entry): Method Start: manyArrs2

3. (visitNode -> Entry -> method with no args): Returning: ()

4. (visitNode -> Entry -> method has args): Returning: ER_State (SymState {env = fromList [(MethodName "manyArrs2",SMethodType Void)], pc = []})

5. Next Node: Node {id = 1, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers1"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 7.0), arrElems = []}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

6. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers1"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 7.0), arrElems = []}}}

7. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers1"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 7.0), arrElems = []}}

8. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers1"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 7.0), arrElems = []}}

9. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers1"}

10. (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} numbers1

11. (visitExpr -> VarExpr): Modifying State: (numbers1,SymNull (Array Int))

12. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymNull (Array Int)}

13. (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 7.0), arrElems = []}

14. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 7.0

15. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 7.0)

16. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymNull (Array Int)}, ER_Expr (SymArray (Just (Array Int)) (Just 7) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int])

17. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers1"
    Old Value: SymNull (Array Int)
    New Value: SymArray (Just (Array Int)) (Just 7) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]

18. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int])

19. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

20. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

21. (visitNode -> Node -> Statement): Adding Var Binding: ("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}})

22. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}})

23. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

24. Next Node: Node {id = 2, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers2"}, assEright = ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 40.0,NumberLiteral 55.0,NumberLiteral 63.0,NumberLiteral 17.0,NumberLiteral 22.0]}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

25. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers2"}, assEright = ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 40.0,NumberLiteral 55.0,NumberLiteral 63.0,NumberLiteral 17.0,NumberLiteral 22.0]}}}

26. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers2"}, assEright = ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 40.0,NumberLiteral 55.0,NumberLiteral 63.0,NumberLiteral 17.0,NumberLiteral 22.0]}}

27. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers2"}, assEright = ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 40.0,NumberLiteral 55.0,NumberLiteral 63.0,NumberLiteral 17.0,NumberLiteral 22.0]}}

28. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers2"}

29. (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} numbers2

30. (visitExpr -> VarExpr): Modifying State: (numbers2,SymNull (Array Int))

31. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymNull (Array Int)}

32. (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Nothing, arrSize = Nothing, arrElems = [NumberLiteral 40.0,NumberLiteral 55.0,NumberLiteral 63.0,NumberLiteral 17.0,NumberLiteral 22.0]}

33. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 40.0

34. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 40.0)

35. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 55.0

36. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 55.0)

37. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 63.0

38. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 63.0)

39. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 17.0

40. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 17.0)

41. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 22.0

42. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 22.0)

43. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymNull (Array Int)}, ER_Expr (SymArray Nothing (Just 5) [SymNum 40.0,SymNum 55.0,SymNum 63.0,SymNum 17.0,SymNum 22.0])

44. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers2"
    Old Value: SymNull (Array Int)
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 40,SymInt 55,SymInt 63,SymInt 17,SymInt 22]

45. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 40,SymInt 55,SymInt 63,SymInt 17,SymInt 22])

46. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 40,SymInt 55,SymInt 63,SymInt 17,SymInt 22]}

47. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 40,SymInt 55,SymInt 63,SymInt 17,SymInt 22]}

48. (visitNode -> Node -> Statement): Adding Var Binding: ("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}})

49. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}})

50. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 40,SymInt 55,SymInt 63,SymInt 17,SymInt 22]}

51. Next Node: Node {id = 3, nodeData = Statement (VarStmt {var = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers3"}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

52. (visitNode -> case nodeData of Node -> Statement): Method Statement: VarStmt {var = VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers3"}}

53. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = BuiltInType Int}), varObj = [], varName = "numbers3"}

54. (visitExpr -> VarExpr): New Variable ArrayType {baseType = BuiltInType Int} numbers3

55. (visitExpr -> VarExpr): Modifying State: (numbers3,SymNull (Array Int))

56. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymNull (Array Int)}

57. (visitStmt -> VarStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymNull (Array Int)}

58. (visitNode -> Node -> Statement): Adding Var Binding: ("numbers3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 29}})

59. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymNull (Array Int)}

60. Next Node: Node {id = 4, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 5.0), arrElems = []}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

61. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 5.0), arrElems = []}}}

62. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 5.0), arrElems = []}}

63. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 5.0), arrElems = []}}

64. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}

65. (visitExpr -> VarExpr): Look up in environmane table: (numbers3 ~~> SymNull (Array Int)) 

66. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymNull (Array Int)}

67. (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType Int}), arrSize = Just (NumberLiteral 5.0), arrElems = []}

68. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

69. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

70. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymNull (Array Int)}, ER_Expr (SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int])

71. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers3"
    Old Value: SymNull (Array Int)
    New Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]

72. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int])

73. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

74. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

75. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers3",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 29}})

76. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

77. Next Node: Node {id = 5, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "brand"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Nothing, arrElems = [StringLiteral "Toyota",StringLiteral "Mercedes",StringLiteral "BMW",StringLiteral "Volkswagen",StringLiteral "Skoda"]}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

78. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "brand"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Nothing, arrElems = [StringLiteral "Toyota",StringLiteral "Mercedes",StringLiteral "BMW",StringLiteral "Volkswagen",StringLiteral "Skoda"]}}}

79. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "brand"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Nothing, arrElems = [StringLiteral "Toyota",StringLiteral "Mercedes",StringLiteral "BMW",StringLiteral "Volkswagen",StringLiteral "Skoda"]}}

80. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "brand"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Nothing, arrElems = [StringLiteral "Toyota",StringLiteral "Mercedes",StringLiteral "BMW",StringLiteral "Volkswagen",StringLiteral "Skoda"]}}

81. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "brand"}

82. (visitExpr -> VarExpr): New Variable ArrayType {baseType = AnyType {typee = "String", generic = Nothing}} brand

83. (visitExpr -> VarExpr): Modifying State: (brand,SymNull (Array String))

84. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "brand", er_val = SymNull (Array String)}

85. (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Nothing, arrElems = [StringLiteral "Toyota",StringLiteral "Mercedes",StringLiteral "BMW",StringLiteral "Volkswagen",StringLiteral "Skoda"]}

86. (visitExpr -> StringLiteral): handling expression: StringLiteral "Toyota"

87. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "Toyota")

88. (visitExpr -> StringLiteral): handling expression: StringLiteral "Mercedes"

89. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "Mercedes")

90. (visitExpr -> StringLiteral): handling expression: StringLiteral "BMW"

91. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "BMW")

92. (visitExpr -> StringLiteral): handling expression: StringLiteral "Volkswagen"

93. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "Volkswagen")

94. (visitExpr -> StringLiteral): handling expression: StringLiteral "Skoda"

95. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "Skoda")

96. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "brand", er_val = SymNull (Array String)}, ER_Expr (SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"])

97. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "brand"
    Old Value: SymNull (Array String)
    New Value: SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]

98. (visitExpr ==> AssignExpr): Modifying State: (VarName "brand",SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"])

99. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "brand", er_val = SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]}

100. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "brand", er_val = SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]}

101. (visitNode -> Node -> Statement): Adding Var Binding: ("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}})

102. (visitNode -> Node -> Statement): Adding Var Assignment: ("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}})

103. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "brand", er_val = SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]}

104. Next Node: Node {id = 6, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "strs"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Just (NumberLiteral 3.0), arrElems = []}}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

105. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "strs"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Just (NumberLiteral 3.0), arrElems = []}}}

106. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "strs"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Just (NumberLiteral 3.0), arrElems = []}}

107. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "strs"}, assEright = ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Just (NumberLiteral 3.0), arrElems = []}}

108. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Just (ArrayType {baseType = AnyType {typee = "String", generic = Nothing}}), varObj = [], varName = "strs"}

109. (visitExpr -> VarExpr): New Variable ArrayType {baseType = AnyType {typee = "String", generic = Nothing}} strs

110. (visitExpr -> VarExpr): Modifying State: (strs,SymNull (Array String))

111. (visitExpr -> VarExpr -> Declaring Local Variable): Returning: ER_SymStateMapEntry {er_key = VarName "strs", er_val = SymNull (Array String)}

112. (visitStmt -> ArrayInstantiationExpr): handling expression: ArrayInstantiationExpr {arrType = Just (ArrayType {baseType = BuiltInType String}), arrSize = Just (NumberLiteral 3.0), arrElems = []}

113. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

114. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

115. (visitExpr -> AssignExpr): Affected: ER_SymStateMapEntry {er_key = VarName "strs", er_val = SymNull (Array String)}, ER_Expr (SymArray (Just (Array String)) (Just 3) [SymNull String,SymNull String,SymNull String])

116. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "strs"
    Old Value: SymNull (Array String)
    New Value: SymArray (Just (Array String)) (Just 3) [SymNull String,SymNull String,SymNull String]

117. (visitExpr ==> AssignExpr): Modifying State: (VarName "strs",SymArray (Just (Array String)) (Just 3) [SymNull String,SymNull String,SymNull String])

118. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "strs", er_val = SymArray (Just (Array String)) (Just 3) [SymNull String,SymNull String,SymNull String]}

119. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "strs", er_val = SymArray (Just (Array String)) (Just 3) [SymNull String,SymNull String,SymNull String]}

120. (visitNode -> Node -> Statement): Adding Var Binding: ("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})

121. (visitNode -> Node -> Statement): Adding Var Assignment: ("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})

122. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "strs", er_val = SymArray (Just (Array String)) (Just 3) [SymNull String,SymNull String,SymNull String]}

123. Next Node: Node {id = 7, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "strs"}, index = Just (NumberLiteral 1.0)}, assEright = StringLiteral "meow"}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

124. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "strs"}, index = Just (NumberLiteral 1.0)}, assEright = StringLiteral "meow"}}

125. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "strs"}, index = Just (NumberLiteral 1.0)}, assEright = StringLiteral "meow"}

126. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "strs"}, index = Just (NumberLiteral 1.0)}, assEright = StringLiteral "meow"}

127. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "strs"}

128. (visitExpr -> VarExpr): Look up in environmane table: (strs ~~> SymArray (Just (Array String)) (Just 3) [SymNull String,SymNull String,SymNull String]) 

129. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "strs", er_val = SymArray (Just (Array String)) (Just 3) [SymNull String,SymNull String,SymNull String]}

130. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

131. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

132. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "strs" (SymInt 1), arrayIndexCallValue = SymNull String}

133. (visitExpr -> StringLiteral): handling expression: StringLiteral "meow"

134. (visitExpr -> StringLiteral): Returning: ER_Expr (SymString "meow")

135. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "strs" (SymInt 1), arrayIndexCallValue = SymNull String}, ER_Expr (SymString "meow")

136. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "strs"
    Old Value: SymArray (Just (Array String)) (Just 3) [SymNull String,SymNull String,SymNull String]
    New Value: SymArray (Just (Array String)) (Just 3) [SymNull String,SymString "meow",SymNull String]

137. (visitExpr ==> AssignExpr): Modifying State: (VarName "strs",SymArray (Just (Array String)) (Just 3) [SymNull String,SymString "meow",SymNull String])

138. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "strs", er_val = SymString "meow"}

139. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "strs", er_val = SymString "meow"}

140. (visitNode -> Node -> Statement): Adding Var Assignment: ("strs",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 29}})

141. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "strs", er_val = SymString "meow"}

142. Next Node: Node {id = 8, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 86.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

143. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 86.0}}

144. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 86.0}

145. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 86.0}

146. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}

147. (visitExpr -> VarExpr): Look up in environmane table: (numbers1 ~~> SymArray (Just (Array Int)) (Just 7) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]) 

148. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

149. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

150. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

151. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 0), arrayIndexCallValue = SymNull Int}

152. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 86.0

153. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 86.0)

154. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 0), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 86.0)

155. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers1"
    Old Value: SymArray (Just (Array Int)) (Just 7) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]

156. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int])

157. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 86}

158. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 86}

159. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers1",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 29}})

160. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 86}

161. Next Node: Node {id = 9, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 80.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

162. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 80.0}}

163. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 80.0}

164. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 80.0}

165. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}

166. (visitExpr -> VarExpr): Look up in environmane table: (numbers1 ~~> SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]) 

167. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

168. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

169. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

170. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 2), arrayIndexCallValue = SymNull Int}

171. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 80.0

172. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 80.0)

173. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 2), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 80.0)

174. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers1"
    Old Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int]

175. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int])

176. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 80}

177. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 80}

178. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers1",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 29}})

179. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 80}

180. Next Node: Node {id = 10, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 57.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

181. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 57.0}}

182. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 57.0}

183. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 57.0}

184. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}

185. (visitExpr -> VarExpr): Look up in environmane table: (numbers1 ~~> SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int]) 

186. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

187. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

188. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

189. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 1), arrayIndexCallValue = SymNull Int}

190. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 57.0

191. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 57.0)

192. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 1), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 57.0)

193. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers1"
    Old Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymNull Int,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int]

194. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int])

195. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 57}

196. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 57}

197. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers1",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 0, branchEnd = 29}})

198. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 57}

199. Next Node: Node {id = 11, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 34.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

200. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 34.0}}

201. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 34.0}

202. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 34.0}

203. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}

204. (visitExpr -> VarExpr): Look up in environmane table: (numbers1 ~~> SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int]) 

205. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

206. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

207. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

208. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 3), arrayIndexCallValue = SymNull Int}

209. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 34.0

210. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 34.0)

211. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 3), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 34.0)

212. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers1"
    Old Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymNull Int,SymNull Int,SymNull Int,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymNull Int,SymNull Int,SymNull Int]

213. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymNull Int,SymNull Int,SymNull Int])

214. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 34}

215. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 34}

216. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers1",Node_Coor {varDeclAt = 11, varFrame = SR {branchStart = 0, branchEnd = 29}})

217. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 34}

218. Next Node: Node {id = 12, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 50.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

219. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 50.0}}

220. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 50.0}

221. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 50.0}

222. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}

223. (visitExpr -> VarExpr): Look up in environmane table: (numbers1 ~~> SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymNull Int,SymNull Int,SymNull Int]) 

224. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymNull Int,SymNull Int,SymNull Int]}

225. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

226. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

227. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 4), arrayIndexCallValue = SymNull Int}

228. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 50.0

229. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 50.0)

230. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 4), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 50.0)

231. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers1"
    Old Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymNull Int,SymNull Int,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymNull Int,SymNull Int]

232. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymNull Int,SymNull Int])

233. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 50}

234. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 50}

235. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers1",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 0, branchEnd = 29}})

236. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 50}

237. Next Node: Node {id = 13, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 5.0)}, assEright = NumberLiteral 48.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

238. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 5.0)}, assEright = NumberLiteral 48.0}}

239. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 5.0)}, assEright = NumberLiteral 48.0}

240. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 5.0)}, assEright = NumberLiteral 48.0}

241. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}

242. (visitExpr -> VarExpr): Look up in environmane table: (numbers1 ~~> SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymNull Int,SymNull Int]) 

243. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymNull Int,SymNull Int]}

244. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

245. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

246. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 5), arrayIndexCallValue = SymNull Int}

247. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 48.0

248. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 48.0)

249. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 5), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 48.0)

250. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers1"
    Old Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymNull Int,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymNull Int]

251. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymNull Int])

252. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 48}

253. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 48}

254. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers1",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 0, branchEnd = 29}})

255. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 48}

256. Next Node: Node {id = 14, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 6.0)}, assEright = NumberLiteral 94.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

257. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 6.0)}, assEright = NumberLiteral 94.0}}

258. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 6.0)}, assEright = NumberLiteral 94.0}

259. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}, index = Just (NumberLiteral 6.0)}, assEright = NumberLiteral 94.0}

260. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}

261. (visitExpr -> VarExpr): Look up in environmane table: (numbers1 ~~> SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymNull Int]) 

262. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymNull Int]}

263. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 6.0

264. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 6.0)

265. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 6), arrayIndexCallValue = SymNull Int}

266. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 94.0

267. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 94.0)

268. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers1" (SymInt 6), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 94.0)

269. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers1"
    Old Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]

270. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94])

271. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 94}

272. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 94}

273. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers1",Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 0, branchEnd = 29}})

274. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymInt 94}

275. Next Node: Node {id = 15, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 51.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

276. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 51.0}}

277. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 51.0}

278. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 51.0}

279. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}

280. (visitExpr -> VarExpr): Look up in environmane table: (numbers2 ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 40,SymInt 55,SymInt 63,SymInt 17,SymInt 22]) 

281. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 40,SymInt 55,SymInt 63,SymInt 17,SymInt 22]}

282. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

283. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

284. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 0), arrayIndexCallValue = SymInt 40}

285. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 51.0

286. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 51.0)

287. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 0), arrayIndexCallValue = SymInt 40}, ER_Expr (SymNum 51.0)

288. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers2"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymInt 40,SymInt 55,SymInt 63,SymInt 17,SymInt 22]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 55,SymInt 63,SymInt 17,SymInt 22]

289. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 55,SymInt 63,SymInt 17,SymInt 22])

290. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 51}

291. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 51}

292. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers2",Node_Coor {varDeclAt = 15, varFrame = SR {branchStart = 0, branchEnd = 29}})

293. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 51}

294. Next Node: Node {id = 16, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 84.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

295. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 84.0}}

296. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 84.0}

297. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 84.0}

298. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}

299. (visitExpr -> VarExpr): Look up in environmane table: (numbers2 ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 55,SymInt 63,SymInt 17,SymInt 22]) 

300. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 55,SymInt 63,SymInt 17,SymInt 22]}

301. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

302. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

303. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 1), arrayIndexCallValue = SymInt 55}

304. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 84.0

305. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 84.0)

306. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 1), arrayIndexCallValue = SymInt 55}, ER_Expr (SymNum 84.0)

307. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers2"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 55,SymInt 63,SymInt 17,SymInt 22]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 63,SymInt 17,SymInt 22]

308. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 63,SymInt 17,SymInt 22])

309. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 84}

310. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 84}

311. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers2",Node_Coor {varDeclAt = 16, varFrame = SR {branchStart = 0, branchEnd = 29}})

312. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 84}

313. Next Node: Node {id = 17, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 92.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

314. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 92.0}}

315. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 92.0}

316. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 92.0}

317. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}

318. (visitExpr -> VarExpr): Look up in environmane table: (numbers2 ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 63,SymInt 17,SymInt 22]) 

319. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 63,SymInt 17,SymInt 22]}

320. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

321. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

322. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 2), arrayIndexCallValue = SymInt 63}

323. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 92.0

324. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 92.0)

325. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 2), arrayIndexCallValue = SymInt 63}, ER_Expr (SymNum 92.0)

326. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers2"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 63,SymInt 17,SymInt 22]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 17,SymInt 22]

327. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 17,SymInt 22])

328. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 92}

329. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 92}

330. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers2",Node_Coor {varDeclAt = 17, varFrame = SR {branchStart = 0, branchEnd = 29}})

331. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 92}

332. Next Node: Node {id = 18, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 87.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

333. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 87.0}}

334. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 87.0}

335. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 87.0}

336. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}

337. (visitExpr -> VarExpr): Look up in environmane table: (numbers2 ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 17,SymInt 22]) 

338. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 17,SymInt 22]}

339. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

340. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

341. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 3), arrayIndexCallValue = SymInt 17}

342. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 87.0

343. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 87.0)

344. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 3), arrayIndexCallValue = SymInt 17}, ER_Expr (SymNum 87.0)

345. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers2"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 17,SymInt 22]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 22]

346. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 22])

347. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 87}

348. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 87}

349. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers2",Node_Coor {varDeclAt = 18, varFrame = SR {branchStart = 0, branchEnd = 29}})

350. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 87}

351. Next Node: Node {id = 19, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 81.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

352. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 81.0}}

353. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 81.0}

354. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 81.0}

355. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}

356. (visitExpr -> VarExpr): Look up in environmane table: (numbers2 ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 22]) 

357. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 22]}

358. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

359. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

360. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 4), arrayIndexCallValue = SymInt 22}

361. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 81.0

362. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 81.0)

363. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers2" (SymInt 4), arrayIndexCallValue = SymInt 22}, ER_Expr (SymNum 81.0)

364. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers2"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 22]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]

365. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81])

366. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 81}

367. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 81}

368. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers2",Node_Coor {varDeclAt = 19, varFrame = SR {branchStart = 0, branchEnd = 29}})

369. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymInt 81}

370. Next Node: Node {id = 20, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 43.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

371. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 43.0}}

372. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 43.0}

373. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 43.0}

374. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}

375. (visitExpr -> VarExpr): Look up in environmane table: (numbers3 ~~> SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]) 

376. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]}

377. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

378. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

379. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 4), arrayIndexCallValue = SymNull Int}

380. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 43.0

381. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 43.0)

382. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 4), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 43.0)

383. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers3"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymNull Int]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymInt 43]

384. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymInt 43])

385. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 43}

386. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 43}

387. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers3",Node_Coor {varDeclAt = 20, varFrame = SR {branchStart = 0, branchEnd = 29}})

388. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 43}

389. Next Node: Node {id = 21, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 10.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

390. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 10.0}}

391. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 10.0}

392. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 3.0)}, assEright = NumberLiteral 10.0}

393. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}

394. (visitExpr -> VarExpr): Look up in environmane table: (numbers3 ~~> SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymInt 43]) 

395. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymInt 43]}

396. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 3.0

397. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 3.0)

398. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 3), arrayIndexCallValue = SymNull Int}

399. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 10.0

400. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 10.0)

401. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 3), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 10.0)

402. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers3"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymNull Int,SymInt 43]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymInt 10,SymInt 43]

403. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymInt 10,SymInt 43])

404. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 10}

405. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 10}

406. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers3",Node_Coor {varDeclAt = 21, varFrame = SR {branchStart = 0, branchEnd = 29}})

407. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 10}

408. Next Node: Node {id = 22, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 34.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

409. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 34.0}}

410. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 34.0}

411. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 2.0)}, assEright = NumberLiteral 34.0}

412. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}

413. (visitExpr -> VarExpr): Look up in environmane table: (numbers3 ~~> SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymInt 10,SymInt 43]) 

414. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymInt 10,SymInt 43]}

415. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 2.0

416. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 2.0)

417. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 2), arrayIndexCallValue = SymNull Int}

418. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 34.0

419. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 34.0)

420. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 2), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 34.0)

421. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers3"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymNull Int,SymInt 10,SymInt 43]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymInt 34,SymInt 10,SymInt 43]

422. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymInt 34,SymInt 10,SymInt 43])

423. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 34}

424. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 34}

425. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers3",Node_Coor {varDeclAt = 22, varFrame = SR {branchStart = 0, branchEnd = 29}})

426. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 34}

427. Next Node: Node {id = 23, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 75.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

428. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 75.0}}

429. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 75.0}

430. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 1.0)}, assEright = NumberLiteral 75.0}

431. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}

432. (visitExpr -> VarExpr): Look up in environmane table: (numbers3 ~~> SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymInt 34,SymInt 10,SymInt 43]) 

433. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymInt 34,SymInt 10,SymInt 43]}

434. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 1.0

435. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 1.0)

436. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 1), arrayIndexCallValue = SymNull Int}

437. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 75.0

438. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 75.0)

439. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 1), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 75.0)

440. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers3"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymNull Int,SymInt 34,SymInt 10,SymInt 43]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 43]

441. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 43])

442. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 75}

443. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 75}

444. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers3",Node_Coor {varDeclAt = 23, varFrame = SR {branchStart = 0, branchEnd = 29}})

445. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 75}

446. Next Node: Node {id = 24, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 6.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

447. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 6.0}}

448. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 6.0}

449. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 4.0)}, assEright = NumberLiteral 6.0}

450. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}

451. (visitExpr -> VarExpr): Look up in environmane table: (numbers3 ~~> SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 43]) 

452. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 43]}

453. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 4.0

454. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 4.0)

455. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 4), arrayIndexCallValue = SymInt 43}

456. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 6.0

457. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 6.0)

458. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 4), arrayIndexCallValue = SymInt 43}, ER_Expr (SymNum 6.0)

459. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers3"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 43]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 6]

460. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 6])

461. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 6}

462. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 6}

463. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers3",Node_Coor {varDeclAt = 24, varFrame = SR {branchStart = 0, branchEnd = 29}})

464. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 6}

465. Next Node: Node {id = 25, nodeData = Statement (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 5.0}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

466. (visitNode -> case nodeData of Node -> Statement): Method Statement: AssignStmt {varModifier = [], assign = AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 5.0}}

467. (visitStmt -> pattern matching: AssignStmt): handling assign statement: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 5.0}

468. (visitExpr -> AssignExpr): handling expression: AssignExpr {assEleft = ArrayCallExpr {arrName = VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}, index = Just (NumberLiteral 0.0)}, assEright = NumberLiteral 5.0}

469. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}

470. (visitExpr -> VarExpr): Look up in environmane table: (numbers3 ~~> SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 6]) 

471. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 6]}

472. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 0.0

473. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 0.0)

474. (visitExpr ==> ArrayCallExpr): Returning: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 0), arrayIndexCallValue = SymNull Int}

475. (visitExpr -> NumberLiteral): handling expression: NumberLiteral 5.0

476. (visitExpr -> NumberLiteral): Returning: ER_Expr (SymNum 5.0)

477. (visitExpr -> AssignExpr): Affected: ER_ArrayCallExpr {arrayIndexCall = SArrayIndexAccess "numbers3" (SymInt 0), arrayIndexCallValue = SymNull Int}, ER_Expr (SymNum 5.0)

478. (visitExpr ==> AssignExpr): Update Variable
    Var Name: VarName "numbers3"
    Old Value: SymArray (Just (Array Int)) (Just 5) [SymNull Int,SymInt 75,SymInt 34,SymInt 10,SymInt 6]
    New Value: SymArray (Just (Array Int)) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]

479. (visitExpr ==> AssignExpr): Modifying State: (VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6])

480. (visitExpr -> AssignExpr): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 5}

481. (visitStmt -> AssignStmt): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 5}

482. (visitNode -> Node -> Statement): Adding Var Assignment: ("numbers3",Node_Coor {varDeclAt = 25, varFrame = SR {branchStart = 0, branchEnd = 29}})

483. (visitNode -> Node -> Statement): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymInt 5}

484. Next Node: Node {id = 26, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}]}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

485. (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}]}}

486. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}]}

487. (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}]

488. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers1"}

489. (visitExpr -> VarExpr): Look up in environmane table: (numbers1 ~~> SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]) 

490. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers1", er_val = SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]}

491. (visitExpr ==> FunCallExpr): Returning: ER_Print "[86, 57, 80, 34, 50, 48, 94]\n"

492. (visitStmt -> FunCallStmt): Modifying State: (SActions,[86, 57, 80, 34, 50, 48, 94]
)

493. (visitStmt -> FunCallStmt): Returning: ER_Print "[86, 57, 80, 34, 50, 48, 94]\n"

494. (visitNode -> Node -> Statement): Returning: ER_Print "[86, 57, 80, 34, 50, 48, 94]\n"

495. Next Node: Node {id = 27, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}]}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

496. (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}]}}

497. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}]}

498. (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}]

499. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers2"}

500. (visitExpr -> VarExpr): Look up in environmane table: (numbers2 ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]) 

501. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers2", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]}

502. (visitExpr ==> FunCallExpr): Returning: ER_Print "[51, 84, 92, 87, 81]\n"

503. (visitStmt -> FunCallStmt): Modifying State: (SActions,[51, 84, 92, 87, 81]
)

504. (visitStmt -> FunCallStmt): Returning: ER_Print "[51, 84, 92, 87, 81]\n"

505. (visitNode -> Node -> Statement): Returning: ER_Print "[51, 84, 92, 87, 81]\n"

506. Next Node: Node {id = 28, nodeData = Statement (FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}]}}), parent = 0}

>>>>>>>>>> visitNode <<<<<<<<<<

507. (visitNode -> case nodeData of Node -> Statement): Method Statement: FunCallStmt {funCall = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}]}}

508. (visitExpr -> FunCallExpr): handling expression: FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "println"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}]}

509. (visitExpr ==> FunCallExpr): Processing Predefined FunCall: VarExpr {varType = Nothing, varObj = [], varName = "println"}[VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}]

510. (visitExpr -> VarExpr): handling expression: VarExpr {varType = Nothing, varObj = [], varName = "numbers3"}

511. (visitExpr -> VarExpr): Look up in environmane table: (numbers3 ~~> SymArray (Just (Array Int)) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]) 

512. (visitExpr -> VarExpr -> Updating): Returning: ER_SymStateMapEntry {er_key = VarName "numbers3", er_val = SymArray (Just (Array Int)) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]}

513. (visitExpr ==> FunCallExpr): Returning: ER_Print "[5, 75, 34, 10, 6]\n"

514. (visitStmt -> FunCallStmt): Modifying State: (SActions,[5, 75, 34, 10, 6]
)

515. (visitStmt -> FunCallStmt): Returning: ER_Print "[5, 75, 34, 10, 6]\n"

516. (visitNode -> Node -> Statement): Returning: ER_Print "[5, 75, 34, 10, 6]\n"

517. Next Node: End {id = 29, parent = 0, mExpr = Nothing}

>>>>>>>>>> visitNode <<<<<<<<<<

518. (visitNode -> End): Method End

519. (visitNode -> End -> return nothing): Void

520. (visitNode -> End -> void method): Returning: ER_State (SymState {env = fromList [(MethodName "manyArrs2",SMethodType Void),(VarBindings,SVarBindings (fromList [("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})])),(VarAssignments,SVarAssignments [("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 29}}),("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 11, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 15, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 16, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 17, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 18, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 19, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 20, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 21, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 22, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 23, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 24, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 25, varFrame = SR {branchStart = 0, branchEnd = 29}})]),(VarName "brand",SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),(VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]),(VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]),(VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]),(VarName "strs",SymArray (Just (Array String)) (Just 3) [SymNull String,SymString "meow",SymNull String]),(Actions,SActions ["[86, 57, 80, 34, 50, 48, 94]\n","[51, 84, 92, 87, 81]\n","[5, 75, 34, 10, 6]\n"])], pc = []})
==============
===End Logs===
==============


SymState:
SymState {env = fromList [(MethodName "manyArrs2",SMethodType Void),(VarBindings,SVarBindings (fromList [("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}})])),(VarAssignments,SVarAssignments [("numbers1",Node_Coor {varDeclAt = 1, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 0, branchEnd = 29}}),("brand",Node_Coor {varDeclAt = 5, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 6, varFrame = SR {branchStart = 0, branchEnd = 29}}),("strs",Node_Coor {varDeclAt = 7, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 8, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 10, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 11, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 13, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers1",Node_Coor {varDeclAt = 14, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 15, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 16, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 17, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 18, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers2",Node_Coor {varDeclAt = 19, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 20, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 21, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 22, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 23, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 24, varFrame = SR {branchStart = 0, branchEnd = 29}}),("numbers3",Node_Coor {varDeclAt = 25, varFrame = SR {branchStart = 0, branchEnd = 29}})]),(VarName "brand",SymArray (Just (Array String)) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]),(VarName "numbers1",SymArray (Just (Array Int)) (Just 7) [SymInt 86,SymInt 57,SymInt 80,SymInt 34,SymInt 50,SymInt 48,SymInt 94]),(VarName "numbers2",SymArray (Just (Array Int)) (Just 5) [SymInt 51,SymInt 84,SymInt 92,SymInt 87,SymInt 81]),(VarName "numbers3",SymArray (Just (Array Int)) (Just 5) [SymInt 5,SymInt 75,SymInt 34,SymInt 10,SymInt 6]),(VarName "strs",SymArray (Just (Array String)) (Just 3) [SymNull String,SymString "meow",SymNull String]),(Actions,SActions ["[86, 57, 80, 34, 50, 48, 94]\n","[51, 84, 92, 87, 81]\n","[5, 75, 34, 10, 6]\n"])], pc = []}