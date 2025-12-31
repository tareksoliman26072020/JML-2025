{-# Language LambdaCase #-}
module CFG.Types where

import qualified Parser.Types as AST(Statement(..),Expression(..), Type(..), Types(..), Modifier(..), Exception(..))
import Data.List (intercalate, find)
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
  } deriving Show

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

findCFGByName :: String -> [CFG] -> Maybe CFG
findCFGByName name = find ((== name) . getCFGName)

getCFGName :: CFG -> String
getCFGName = f2 . find f1 . nodes
  where
  f1 (Entry _ _ _) = True
  f1 _           = False
  
  f2 (Just (Entry _ name _)) = name
  f2 Nothing               = error "Won't happen"

getCFGType :: CFG -> AST.Type AST.Types
getCFGType cfg = 
  let finding = flip find (nodes cfg) $ \case
        Entry _ _ _ -> True
        _         -> False
  in case finding of
       Nothing -> error "won't happen"
       Just (Entry t _ _)  -> t

getCFGFormalParams :: CFG -> [AST.Expression]
getCFGFormalParams cfg = case getEntryNode cfg of
  Entry _ _ args -> args
  _              -> error "won't happen"

------------------------------

data NodeData = Statement AST.Statement
              | ForInitialization AST.Expression
              | BooleanExpression Kind AST.Expression
              | ForStep AST.Statement 
              | TryNode | CatchNode (AST.Type AST.Exception) | FinallyNode
              | Meet Kind
              deriving Show

showNodeData :: NodeData -> String
showNodeData (Statement stmt) = showStatement stmt
showNodeData (ForInitialization expr) = "For: init: " ++ showExpr expr
showNodeData (BooleanExpression kind expr) = show kind ++ ": " ++ "cond: " ++ showExpr expr
showNodeData (ForStep stmt) = "For: step: " ++ showStatement stmt
showNodeData TryNode = "Try Node"
showNodeData (CatchNode t) = "Catch Node: " ++ showTypeException t
showNodeData FinallyNode = "Finally Node"
showNodeData (Meet kind) = "Meet: " ++ show kind


isIfStartNode :: Node -> Bool
isIfStartNode = \case
  Node _ (BooleanExpression If _) _ -> True
  _ -> False

isIfEndNode :: Node -> Bool
isIfEndNode = \case
  Node _ (Meet If) _ -> True
  _ -> False

isForStartNode :: Node -> Bool
isForStartNode = \case
  Node _ (ForInitialization _) _ -> True
  _ -> False

isForEndNode :: Node -> Bool
isForEndNode = \case
  Node _ (Meet For) _ -> True
  _ -> False

getEndKindNode :: CFG -> Node -> Kind -> Node
getEndKindNode cfg node kind = case kind of
  If
    | isIfStartNode node -> helper cfg node 1
  For
    | isForStartNode node -> helper cfg node 1
  _ -> error $ "getEndKindNode: won't happen (neither If nor For start node): " ++ show node
  where
  helper cfg currentNode 0 = currentNode
  helper cfg currentNode counter = case findEdge_via_id cfg (getNodeId currentNode) of
      Nothing -> error "getEndKindNode: won't happen"
      Just (_,(next : _))  -> case (kind , findNode_via_id cfg next) of
        (If,nextNode)
          | isIfStartNode nextNode -> helper cfg nextNode (counter + 1)
          | isIfEndNode nextNode -> helper cfg nextNode (counter - 1)
        (For,nextNode)
          | isForStartNode nextNode -> helper cfg nextNode (counter + 1)
          | isForEndNode nextNode -> helper cfg nextNode (counter - 1)
        (_,nextNode) -> helper cfg nextNode counter

------------------------------

data Kind = If | While | For
          deriving Show

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

findNode_via_id :: CFG -> NodeID -> Node
findNode_via_id cfg nodeId =
  case find (\n -> getNodeId n == nodeId) $ nodes cfg of
    Just node -> node
    Nothing   -> error "won't happen"

findEdge_via_id :: CFG -> NodeID -> Maybe (NodeID,[NodeID])
findEdge_via_id cfg nodeId = flip find (edges cfg) $ \(n,_) -> n==nodeId

getEntryNode :: CFG -> Node
getEntryNode cfg = findNode_via_id cfg 0 

getNodeId :: Node -> NodeID
getNodeId = \case
  Entry _ _ _ -> 0
  n@End{}  -> CFG.Types.id n
  n@Node{} -> CFG.Types.id n

getPath :: NodeID -> CFG -> [Node]
getPath startId cfg =
  let currentNode = findNode_via_id cfg startId
      nextNodeId = case findEdge_via_id cfg startId of
        Nothing -> error "getPath: won't happen 1"
        Just (_,[]) -> error "getPath: won't happen 2"
        Just (_,[next])
          | not (isIfStartNode currentNode) -> next
        {-
        Just (_,[next])
          | isIfStartNode currentNode ->
              let endNode = getEndKindNode cfg currentNode If
              in case findEdge_via_id cfg (getNodeId endNode) of
                   Just (_,[next2]) -> next2
                   Nothing -> error "getPath: won't happen 3"
                   ex -> error $ "getPath: won't happen 4: " ++ show ex
          -}
        Just (_,(_ : _)) ->
          let endNode
               | isIfStartNode currentNode = getEndKindNode cfg currentNode If
               | isForStartNode currentNode = getEndKindNode cfg currentNode For
               | otherwise = error $ "getPath: what is this? " ++ show currentNode
          in case findEdge_via_id cfg (getNodeId endNode) of
               Just (_,[next2]) -> next2
               Nothing -> error "getPath: won't happen 5"
               ex -> error $ "getPath: won't happen 6: " ++ show ex
  in case currentNode of
       End{} -> [currentNode]
       _     -> currentNode : getPath nextNodeId cfg

-----------------------------
