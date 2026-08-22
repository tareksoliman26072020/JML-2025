{-# Language LambdaCase, NamedFieldPuns, MultiWayIf #-}
module Parser.Print where

import Data.Char
import Data.List

import Parser.Types

showType :: Type Types -> String
showType = \case
  BuiltInType t -> map toLower $ show t
  AnyType {typee} -> typee -- ignore generics
  ArrayType {baseType} -> showType baseType ++ "[]"

showExcp :: Exception -> String
showExcp (Exception str) = str

showExpr :: Expression -> String
showExpr = \case
  VarExpr {varType, varObj, varName} -> maybe "" ((++ " ") . showType) varType
    ++ intercalate "." (varObj ++ [varName])
  BinOpExpr {expr1, binOp, expr2} -> let p = prec binOp in
    showLeftArg p expr1 ++ show binOp ++ showRightArg p expr2
  UnOpExpr {unOp, expr} -> show unOp ++ showParenExpr expr
  NumberLiteral num -> let
    int = floor num :: Int in if
    | num == fromIntegral int -> show int
    | otherwise -> show num
  BoolLiteral bool -> map toLower $ show bool
  CharLiteral char -> show char
  StringLiteral str -> show str
  Null -> "null"
  ArrayCallExpr {arrName, index} -> show arrName
    ++ "[" ++ maybe "" showExpr index ++ "]"
  FunCallExpr {funName, funArgs} -> showExpr funName
    ++ "(" ++ intercalate ", " (map showExpr funArgs) ++ ")"
  CondExpr {eiff, ethenn, eelsee} -> showParenExpr eiff
    ++ "?" ++ showParenExpr ethenn
    ++ ":" ++ showParenExpr eelsee
  AssignExpr (VarExpr _ _ varName1)
             (BinOpExpr (VarExpr _ _ varName2) op expr2)
    | varName1 == varName2 && isOne expr2 && op `elem` [Plus,Minus] -> varName1 ++ case op of
        Plus -> "++"
        Minus -> "--"
    | varName1 == varName2 -> varName1 ++ (case op of
        Plus -> "+="
        Mult -> "*="
        Minus -> "-="
        Div -> "/=") ++ showExpr expr2
  AssignExpr {assEleft, assEright} ->
    showExpr assEleft ++ " = " ++ showExpr assEright
  ExcpExpr {excpName, excpmsg} -> "throw new " ++ showExcp excpName ++ "("
    ++ maybe "" show excpmsg ++ ")"
  ReturnExpr {returnE} -> "return" ++ maybe "" ((" " ++) . showExpr) returnE
  expr -> error $ "TODO in Parser.Print.showExpr ==> " ++ show expr

isOne :: Expression -> Bool
isOne = \case
  NumberLiteral 1 -> True
  _ -> False

addParen :: String -> String
addParen = ("(" ++) . (++ ")")

showParenExpr :: Expression -> String
showParenExpr e = (case e of
  BinOpExpr {} -> addParen
  CondExpr {} -> addParen
  _ -> id) $ showExpr e

showArg :: Assoc -> Prec -> Expression -> String
showArg a p e = (case e of
  CondExpr {} -> addParen
  BinOpExpr {binOp} -> let q = prec binOp in case compare p q of
    LT -> addParen
    EQ -> if a == assoc q then id else addParen
    GT -> id
  _ -> id) $ showExpr e

showLeftArg :: Prec -> Expression -> String
showLeftArg p = (if p > PCmp then (++ " ") else id) . showArg ALeft p

showRightArg :: Prec -> Expression -> String
showRightArg p = (if p > PCmp then (" " ++) else id) . showArg ARight p

showModifiers :: [Modifier] -> String
showModifiers = \case
  [] -> ""
  l -> concatMap ((++ " ") . map toLower . show) l

indent :: String -> String
indent = intercalate "\n" . map ("  " ++) . lines

showExcpType :: Type Exception -> String
showExcpType = \case
  BuiltInType t -> show t
  AnyType {typee, generic} -> typee
    ++ maybe "" ((" " ++) . showExcpType) generic
  ArrayType {baseType} -> showExcpType baseType ++ "[]"

delimStmt :: Statement -> String
delimStmt s = case s of
  AssignStmt {} -> ";"
  FunCallStmt {} -> ";"
  ReturnStmt {} -> ";"
  _ -> ""

showStmt :: Statement -> String
showStmt = \case
  CompStmt {statements} -> case statements of
    [] -> "{}"
    _ -> "{\n" ++ indent (intercalate ";\n" (map showStmt statements)
      ++ delimStmt (last statements)) ++ "\n}"
  VarStmt {var} -> showExpr var
  AssignStmt {varModifier, assign} ->
    showModifiers varModifier ++ showExpr assign
  CondStmt {condition, siff, selsee} ->
    "if" ++ addParen (showExpr condition)
    ++ showStmt siff ++ case selsee of
      CompStmt [] -> ""
      _ -> "\nelse" ++ showStmt selsee
  ForStmt {mAcc, mCond, mStep, forBody} ->
    "for(" ++ maybe "" showStmt mAcc ++ "; " ++ maybe "" showExpr mCond ++ "; " ++ maybe ""  showStmt mStep
    ++ ")" ++ showStmt forBody
  WhileStmt {} -> error "showStmt"
  FunCallStmt {funCall} -> showExpr funCall
  TryCatchStmt {tryBody, catchExcp, catchBody, finallyBody} ->
    "try" ++ showStmt tryBody
    ++ "\ncatch(" ++ showExcpType catchExcp ++ ")"
    ++ showStmt catchBody ++ case finallyBody of
      CompStmt [] -> ""
      _ -> "\nfinally " ++ showStmt finallyBody
  ReturnStmt {returnS} -> case returnS of
    Just e@ExcpExpr {} -> showExpr e
    _ -> showExpr (ReturnExpr returnS)
  BreakStmt -> "break"
  stmt -> error $ "TODO in Parser.Print.showStmt: " ++ show stmt

showDecl :: Method -> String
showDecl FunDef {funModifier, isPureFlag, funDecl, throws, funBody} =
  showModifiers funModifier
  ++ (if isPureFlag then "/*@ pure @*/ " else "") ++ showStmt funDecl
  ++ maybe "" ((" throws " ++) . showExcp) throws ++ showStmt funBody
