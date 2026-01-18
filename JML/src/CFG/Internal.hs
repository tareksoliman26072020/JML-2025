{-# Language LambdaCase #-}
module CFG.Internal where

import CFG.Types
import qualified Parser.Types as AST
import Data.List (find)

findCFGByName :: String -> [CFG] -> Maybe CFG
findCFGByName name = find ((== name) . getCFGName)

getCFGName :: CFG -> String
getCFGName = f2 . find f1 . nodes
  where
  f1 (Entry _ _ _) = True
  f1 _             = False
  
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

-----------------------------

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

isForInitNode :: Node -> Bool
isForInitNode = \case
  Node _ (ForInitialization _) _ -> True
  _ -> False

isForCondNode :: Node -> Bool
isForCondNode = \case
  Node _ (BooleanExpression For _) _ -> True
  _ -> False

isForEndNode :: Node -> Bool
isForEndNode = \case
  Node _ (Meet For) _ -> True
  _ -> False

getEndIfNode :: CFG -> Node -> Node
getEndIfNode cfg node
  | isIfStartNode node = helper cfg node 1
  | otherwise = error $ "getEndIfNode: won't happen: " ++ show node
  where
  helper cfg currentNode 0 = currentNode
  helper cfg currentNode counter = case findEdge_via_id cfg (getNodeId currentNode) of
      Nothing -> error "getEndIfNode: won't happen"
      Just (_,(next : _)) -> case findNode_via_id cfg next of
        nextNode
          | isIfStartNode nextNode -> helper cfg nextNode (counter + 1)
          | isIfEndNode nextNode -> helper cfg nextNode (counter - 1)
        nextNode -> helper cfg nextNode counter

getEndForNode :: CFG -> Node -> Node
getEndForNode cfg node = case findEdge_via_id cfg (getNodeId node) of
  Nothing -> error "getEndForNode: won't happen"
  Just (_,[next]) ->
    let forCondNode = findNode_via_id cfg next
    in case findEdge_via_id cfg (getNodeId forCondNode) of
         Nothing -> error "getEndForNode: won't happen"
         Just (_,[next1,next2]) ->
           let n = findNode_via_id cfg next2
           in if isForEndNode n then n
              else error $ "TODO: getEndForNode ==> " ++ show [next1,next2]

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
      mNextNodeId = case findEdge_via_id cfg startId of
         -- there's no next node. This happens in an empty method with no edges
        Nothing -> Nothing
        Just (_,[]) -> error "getPath: won't happen 2"
        Just (_,[next])
          | not (isIfStartNode currentNode || isForInitNode currentNode) -> Just next
        Just (_,(_ : _)) ->
          let endNode
               | isIfStartNode currentNode = getEndIfNode cfg currentNode
               | isForInitNode currentNode = getEndForNode cfg currentNode
               | otherwise = error $ "getPath: what is this? " ++ show currentNode
          in case findEdge_via_id cfg (getNodeId endNode) of
               Just (_,[next2]) -> Just next2
               Nothing -> error "getPath: won't happen 5"
               ex -> error $ "getPath: won't happen 6: " ++ show ex
  in case currentNode of
       End{} -> [currentNode]
       _     -> currentNode : case mNextNodeId of
                  Nothing -> []
                  Just nextNodeId -> getPath nextNodeId cfg

-----------------------------

getVarName :: Node -> String
getVarName = \case
  Node _ (Statement stmt) _ -> AST.getVarName (AST.getStatementExpression stmt)
  node -> error $ "TODO:: getVarName ==> " ++ show node

getVarNames :: Node -> [String]
getVarNames = \case
  Node _ (Statement stmt) _ -> AST.getVarNames (AST.getStatementExpression stmt)
{-
Node {
  id = 11,
  nodeData = ForStep (Just (AssignStmt {varModifier = [], assign = AssignExpr {assEleft = VarExpr {varType = Nothing, varObj = [], varName = "i"}, assEright = BinOpExpr {expr1 = VarExpr {varType = Nothing, varObj = [], varName = "i"}, binOp = -, expr2 = NumberLiteral 1.0}}})
  ),
  parent = 3
}
 -}
  Node _ (ForStep mStmt) _ -> maybe [] (AST.getVarNames . AST.getStatementExpression) mStmt
  node -> error $ "TODO:: getVarNames ==> " ++ show node

{-
data NodeData = Statement AST.Statement
              | ForInitialization (Maybe AST.Expression)
              | BooleanExpression Kind (Maybe AST.Expression)
              | ForStep (Maybe AST.Statement) 
              | TryNode | CatchNode (AST.Type AST.Exception) | FinallyNode
              | Meet Kind
 -}
getExpression :: Node -> Maybe AST.Expression
getExpression = \case
  Node _ (Statement stmt) _ -> Just $ AST.getStatementExpression stmt
  Node _ (ForInitialization mExpr) _ -> mExpr
  Node _ (BooleanExpression _ mExpr) _ -> mExpr
  Node _ (ForStep mStmt) _ -> fmap AST.getStatementExpression mStmt
  node -> error $ "TODO:: getExpression ==> " ++ show node

-----------------------------

isNewlyDeclaredNode :: Node -> Bool
isNewlyDeclaredNode = \node ->
  let mExpr = getExpression node
  in case mExpr of
       Nothing -> False
       Just expr ->
         AST.isAssignExpr expr && AST.isNewVar (AST.assEleft expr)

findNewlyDeclaredNodes :: [Node] -> [Node]
findNewlyDeclaredNodes = filter isNewlyDeclaredNode

findAlreadyDeclaredNodes :: [Node] -> [Node]
findAlreadyDeclaredNodes = filter $ \node ->
  let mExpr = getExpression node
  in case mExpr of
       Nothing -> False
       Just expr ->
         AST.isAssignExpr expr && (not $ AST.isNewVar $ AST.assEleft expr)

getBranchEnd :: NodeID -> CFG -> NodeID
getBranchEnd bStart cfg = helper (nodes cfg) where
  helper = \case
    [] -> error "getBranchEnd ==> won't happen1"
    (node : rest) -> case node of
      Entry _ _ _
        | bStart == 0 ->
            let mEndId = foldr (\n acc -> case n of
                  End theId _ _ -> Just theId
                  _ -> acc) Nothing (nodes cfg)
            in case mEndId of
                 Nothing -> error "getBranchEnd ==> won't happen2"
                 Just endId -> endId
        | otherwise -> helper rest
      End{} -> error "getBranchEnd ==> won't happen3"
      Node{}
        | CFG.Types.id node == bStart -> case nodeData node of
            BooleanExpression If _ -> getNodeId $ getEndIfNode cfg node
            ForInitialization _ -> getNodeId $ getEndForNode cfg node
            _ -> error $ "TODO2 ==> getBranchEnd ==> " ++ show node
        | otherwise -> helper rest

-----------------------------

{-
Node {
    id :: NodeID,
    nodeData :: NodeData,
    parent :: NodeID
  }
 -}
-- converts any node to a nodeData of `Statement`
convert :: Node -> Maybe Node
convert = \case
  Node theId nodeData parent -> case nodeData of
    ForStep mStmt -> flip fmap mStmt $ \stmt -> Node theId (Statement stmt) parent
    _ -> error $ "TODO1:: convert ==> " ++ show nodeData
  node -> error $ "TODO2:: convert ==> " ++ show node
