module CFG.Types where

import qualified Parser.Types as AST(Statement(..),Expression(..), Type(..), Types(..), Modifier(..))
import Data.List (intercalate)
import Text.Printf(printf)

type NodeID = Int

data Node = Entry | End {id :: NodeID, mExpr :: Maybe AST.Expression} | Node {
  id :: NodeID,
  nodeData :: NodeData,
  parent :: NodeID
} deriving Show

showNode Entry = "Entry"
showNode (end@End{}) = "End " ++ show (CFG.Types.id end)
  ++ maybe "()" (\e -> ": " ++ showExpr e) (mExpr end)
showNode (node@Node{}) = printf "%d -> %d:\n        %s"
  (parent node) (CFG.Types.id node) (showNodeData (nodeData node))

------------------------------

data CFG = CFG {
  nodes :: [Node],
  edges :: [(NodeID,[NodeID])]
} deriving Show

showCFG :: CFG -> String
showCFG (cfg@CFG{}) = "  " ++
  intercalate "\n----------\n  " (map showNode $ nodes cfg) ++ "\n" ++
  "========================\n  " ++
  intercalate "\n  " (map show $ edges cfg) ++ "\n"

------------------------------

data NodeData = Statement AST.Statement
              | BooleanExpression Kind AST.Expression 
              | Meet Kind
              deriving Show

showNodeData :: NodeData -> String
showNodeData (Statement stmt) = showStatement stmt
showNodeData (BooleanExpression kind expr) = error "TODO"
showNodeData (Meet kind) = error "TODO"

------------------------------

data Kind = If | While | For | TryCatch
          deriving Show

{-
  | ArrayCallExpr {arrName :: Expression, index :: Maybe Expression}
  | ArrayInstantiationExpr {arrType :: Maybe (Type Types), arrSize :: Maybe Expression, arrElems :: [Expression]}
  | BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
  | UnOpExpr {unOp :: UnOp, expr :: Expression}
  | CondExpr {eiff :: Expression, ethenn :: Expression, eelsee :: Expression}
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
showExpr expr@AST.AssignExpr{} =
  showExpr (AST.assEleft expr) ++ " = " ++ showExpr (AST.assEright expr)
showExpr _ = error "TODO"

{-
data Type a
  = BuiltInType a
  | AnyType {typee :: String, generic :: Maybe (Type a)}
  | ArrayType {baseType :: Type a}
  deriving (Eq, Show)
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

{-
  = CompStmt {statements :: [Statement]}
  | VarStmt {var :: Expression}
  | CondStmt {condition :: Expression, siff :: Statement, selsee :: Statement}
  | ForStmt {acc :: Statement, cond :: Expression, step :: Statement, forBody :: Statement}
  | WhileStmt {condition :: Expression, whileBody :: Statement}
  | FunCallStmt {funCall :: Expression}
  | TryCatchStmt {tryBody :: Statement,
                  catchExcp :: Type Exception, catchBody :: Statement,
                  finallyBody :: Statement}
  | ReturnStmt {returnS :: Maybe Expression}
-}
showStatement :: AST.Statement -> String
showStatement stmt@AST.AssignStmt{} =
  list "" (\li -> unwords (map showModifier li) ++ " ") (AST.varModifier stmt) ++
  showExpr (AST.assign stmt)
showStatement _ = error "TODO"

{-
data Modifier
  = Static
  | Public
  | Private
  | Protected
  | Final
  | Abstract
-}
showModifier :: AST.Modifier -> String
showModifier _ = error "TODO"

list :: b -> ([a] -> b) -> [a] -> b
list b _ [] = b
list _ f li = f li
