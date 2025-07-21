module CFG.Types where

import qualified Parser.Types as AST(Statement,Expression(..), Type(..), Types(..))
import Data.List (intercalate)
import Text.Printf(printf)

type NodeID = Int

data Node = Entry | End {id :: NodeID, mExpr :: Maybe AST.Expression} | Node {
  id :: NodeID,
  nodeData :: NodeData,
  parent :: NodeID
} deriving Show

data CFG = CFG {
  nodes :: [Node],
  edges :: [(NodeID,[NodeID])]
} deriving Show

data NodeData = Statement AST.Statement
              | BooleanExpression Kind AST.Expression 
              | Meet Kind
              deriving Show

data Kind = If | While | For | TryCatch
          deriving Show

showNode Entry = "Entry"
showNode (end@End{}) = "End " ++ show (CFG.Types.id end)
  ++ maybe "" (\e -> ": " ++ showExpr e) (mExpr end)
showNode (node@Node{}) = error "TODO"

{-
  | VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
  | ArrayCallExpr {arrName :: Expression, index :: Maybe Expression}
  | ArrayInstantiationExpr {arrType :: Maybe (Type Types), arrSize :: Maybe Expression, arrElems :: [Expression]}
  | BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
  | UnOpExpr {unOp :: UnOp, expr :: Expression}
  | CondExpr {eiff :: Expression, ethenn :: Expression, eelsee :: Expression}
  | AssignExpr {assEleft :: Expression, assEright :: Expression}
  | ExcpExpr {excpName :: Exception, excpmsg :: Maybe String}
-}
showExpr :: AST.Expression -> String
showExpr (AST.NumberLiteral num) = show num
showExpr (AST.BoolLiteral bool) = show bool
showExpr (AST.CharLiteral ch) = [ch]
showExpr (AST.StringLiteral str) = str
showExpr AST.Null = "Null"
showExpr (AST.ReturnExpr ret) = maybe "" showExpr ret
showExpr (AST.FunCallExpr name args) =
  printf "%s(%s)" (showExpr name) (intercalate ", " $ map showExpr args)
showExpr (v@AST.VarExpr{}) =
  let theType = maybe "" (\t -> showType t ++ " ") (AST.varType v)
      objs    = list "" (\li -> intercalate "." li ++ ".") (AST.varObj v)
  in theType ++ objs ++ AST.varName v
showExpr _ = error "TODO"

showCFG :: CFG -> String
showCFG (cfg@CFG{}) = "  " ++
  intercalate "\n----------\n  " (map showNode $ nodes cfg) ++ "\n" ++
  "========================\n  " ++
  intercalate "\n  " (map show $ edges cfg) ++ "\n"

{-
data Type a
  = BuiltInType a
  | AnyType {typee :: String, generic :: Maybe (Type a)}
  | ArrayType {baseType :: Type a}
  deriving (Eq, Show)

==============================

data Types
  = Int
  | Void
  | Char
  | String
  | Boolean
  | Double
  | Short
  | Float
  | Long
  | Byte
-}
showType :: AST.Type AST.Types -> String
showType (AST.BuiltInType t) = case t of
  AST.Int     -> "Int"
  AST.Void    -> "Void"
  AST.Char    -> "Char"
  AST.String  -> "String"
  AST.Boolean -> "Boolean"
  AST.Double  -> "Double"
  AST.Short   -> "Short"
  AST.Float   -> "Float"
  AST.Long    -> "Long"
  AST.Byte    -> "Byte"
showType _ = error "TODO"

list :: b -> ([a] -> b) -> [a] -> b
list b _ [] = b
list _ f li = f li
