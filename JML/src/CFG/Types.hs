{-# Language LambdaCase #-}
module CFG.Types where

import qualified Parser.Types as AST(
  Statement(..),Expression(..), Type(..), Types(..), Modifier(..), Exception(..),
  getStatementExpression,getVarName,getVarNames)
import Data.List (intercalate)
import Text.Printf(printf)

type NodeID = Int

data Node = Entry (AST.Type AST.Types) String [AST.Expression] | End {
    id :: NodeID,
    parent :: NodeID,
    mExpr :: Maybe AST.Expression
  } | Node {
    id :: NodeID,
    nodeData :: NodeData,
    parent :: NodeID
  } deriving (Eq,Show)

showNode :: Node -> String
showNode (Entry t n args) = "Entry " ++ n ++ ": method type: " ++ showType t
  ++ case null args of
       True -> ""
       False -> ", args: (" ++ intercalate ", " (map showExpr args) ++ ")"
showNode (end@End{}) =
  printf "End: %d -> %d:\n        %s"
    (parent end) (CFG.Types.id end) (maybe "()" (\e -> "return: " ++ showExpr e) (mExpr end))
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
              | ForInitialization (Maybe AST.Expression)
              | BooleanExpression Kind (Maybe AST.Expression)
              | ForStep (Maybe AST.Statement) 
              | TryNode | CatchNode (AST.Type AST.Exception) | FinallyNode
              | Meet Kind
              deriving (Eq,Show)

showNodeData :: NodeData -> String
showNodeData (Statement stmt) = showStatement stmt
showNodeData (ForInitialization mExpr) = "For: init: " ++ case fmap showExpr mExpr of
  Nothing -> "Nothing"
  Just str -> "Just " ++ str
showNodeData (BooleanExpression kind mExpr) = show kind ++ ": " ++ case mExpr of
  Nothing -> "no condition"
  Just expr -> "cond: " ++ showExpr expr
showNodeData (ForStep mStmt) = case mStmt of
  Just stmt -> "For: step: " ++ showStatement stmt
  Nothing -> "For: no step"
showNodeData TryNode = "Try Node"
showNodeData (CatchNode t) = "Catch Node: " ++ showTypeException t
showNodeData FinallyNode = "Finally Node"
showNodeData (Meet kind) = "Meet: " ++ show kind

------------------------------

data Kind = If | While | For
          deriving (Eq,Show)

data Node_Coor = Node_Coor
  { varDeclAt :: Int
  , varFrame  :: ScopeRange
  } deriving (Eq,Show)

data ScopeRange = SR
  { branchStart :: Int
  , branchEnd :: Int
  } deriving (Eq,Ord,Show)

{-
  | ArrayCallExpr {arrName :: Expression, index :: Maybe Expression}
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
showExpr expr@AST.BinOpExpr{} = printf "%s %s %s"
  (showExpr $ AST.expr1 expr) (show $ AST.binOp expr) (showExpr $ AST.expr2 expr)
showExpr (expr@AST.ExcpExpr{}) = printf "%s(%s)"
  (show (AST.excpName expr)) (maybe "" Prelude.id (AST.excpmsg expr))
showExpr expr@AST.ArrayInstantiationExpr{} = newInstance ++ size ++ value where

  newInstance :: String
  newInstance = case AST.arrType expr of
    Nothing           -> ""
    Just (AST.ArrayType t) -> printf "new %s" (showType t)
    Just _ -> error "won't happen"

  size :: String
  size = case (AST.arrType expr, AST.arrSize expr) of
    (Just _, Nothing)  -> "[]"
    (Just _, Just e)   -> printf "[%s]" (showExpr e)
    (Nothing, Nothing) -> ""
    (Nothing, Just _)  -> error "won't happen"
  
  value :: String
  value = case (AST.arrType expr, AST.arrSize expr) of
    (Nothing,_)      -> printf "{%s}" $ intercalate ", " (map showExpr $ AST.arrElems expr)
    (Just _,Just _)  -> ""
    (Just _,Nothing) -> "{}"
showExpr expr@AST.ArrayCallExpr{} =
  showExpr (AST.arrName expr) ++ "[" ++ maybe "" showExpr (AST.index expr) ++ "]"
showExpr expr@AST.CondExpr{} = printf "%s ? %s : %s"
  (showExpr $ AST.eiff expr) (showExpr $ AST.ethenn expr) (showExpr $ AST.eelsee expr)
showExpr expr = error $ "TODO: " ++ show expr

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
  _ -> error $ "TODO1: showType ==> " ++ show t
showType (AST.AnyType "String" _) = "String"
--showType t = error $ "TODO2: showType ==> " ++ show t
-- This will be called by `showExpr VarExpr`:
showType (t@AST.ArrayType{}) = showType (AST.baseType t) ++ "[]"
showType _ = error "TODO"

-- AnyType {typee :: String, generic :: Maybe (Type a)}
showTypeException :: AST.Type AST.Exception -> String
showTypeException t@AST.AnyType{} = AST.typee t
showTypeException _ = error "won't happen"

{-
  = CompStmt {statements :: [Statement]}
  | VarStmt {var :: Expression}
  | CondStmt {condition :: Expression, siff :: Statement, selsee :: Statement}
  | ForStmt {acc :: Statement, cond :: Expression, step :: Statement, forBody :: Statement}
  | WhileStmt {condition :: Expression, whileBody :: Statement}
  | TryCatchStmt {tryBody :: Statement,
                  catchExcp :: Type Exception, catchBody :: Statement,
                  finallyBody :: Statement}
  | ReturnStmt {returnS :: Maybe Expression}
-}
showStatement :: AST.Statement -> String
showStatement stmt@AST.AssignStmt{} =
  list "" (\li -> unwords (map showModifier li) ++ " ") (AST.varModifier stmt) ++
  showExpr (AST.assign stmt)
showStatement (AST.VarStmt expr) = showExpr expr
showStatement stmt@AST.FunCallStmt{} = showExpr (AST.funCall stmt)
showStatement AST.ContinueStmt = "continue"
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

-----------------------------
