{-# Language LambdaCase, NamedFieldPuns #-}
module CFG.CFG where

import Visitors.API
import qualified Parser.Types as AST
import qualified CFG.Types as G
import Data.List (maximumBy, foldl',nub)

data CFGCreator = Node {node :: G.Node} | Nodes {cfg :: G.CFG}
{-
data CFG = CFG {
  nodes :: [Node],
  edges :: [(NodeID,[NodeID])]
} deriving Show
-}
instance ASTVisitor CFGCreator where
--visitMethod :: AST.Method -> CFGCreator
  visitMethod method =
    let (nextNodeId,g) = visitStatement0 0 1 (AST.funBody method)
    in g
  visitStatement = undefined



visitStatement0 :: Int -> Int -> AST.Statement -> (G.NodeID,CFGCreator)
visitStatement0 currentNodeId nextNodeId stmt@AST.CompStmt{} =
  foldl' f (nextNodeId, Nodes $ G.CFG [] []) (AST.statements stmt)
  where
  f :: (G.NodeID,CFGCreator) -> AST.Statement -> (G.NodeID,CFGCreator)
  f (nextNodeId1, cfgCreator1) nextStmt = case cfgCreator1 of
    Node _     -> error "CompStmt results in Nodes"
    Nodes cfg1 -> case visitStatement0 currentNodeId nextNodeId1 nextStmt of
      -- the new nodes and edges get added
      (nextNodeId2, Nodes cfg2) -> (,)
        nextNodeId2
        (Nodes $ G.CFG {
           G.nodes = G.nodes cfg1 ++ G.nodes cfg2,
           G.edges = G.edges cfg1 ++ G.edges cfg2
         })
      -- the new node gets added
      (nextNodeId2, n@(Node node2)) -> (,)
        nextNodeId2
        (Nodes $ G.CFG {
           G.nodes = G.nodes cfg1 ++ [node2],
           G.edges = addEdge (currentNodeId,nextNodeId1) (G.edges cfg1)
         })

-- receives a pair of nodes (from,to) and adds it to the list of edges
addEdge :: (G.NodeID,G.NodeID) -> [(G.NodeID,[G.NodeID])] -> [(G.NodeID,[G.NodeID])]
addEdge (from,to) edges = case lookup from edges of
  Nothing -> edges ++ [(from,[to])]
  _       -> flip map edges $ \(v1,vs2) ->
    if v1 == from
      then (v1,nub $ vs2 ++ [to])
      else (v1,vs2)

-----------
-----------

enumerateNodes :: Int -> [G.Node] -> [G.Node]
enumerateNodes start nodes = flip map (zip [start ..] nodes) $ \case
  (_,G.Entry{}) -> error "won't happen"
  (_,G.End{})   -> error "won't happen"
  (num,node)      -> G.Node {
    G.id       = num,
    G.nodeData = G.nodeData node
  }

connectNodes :: [G.Node] -> [(G.NodeID,[G.NodeID])]
connectNodes (node1 : node2 : rest) = (G.id node1,[G.id node2]) : connectNodes (node2 : rest)
connectNodes _ = []

{-
data Node = Entry {id :: NodeID} | End {id :: NodeID} | Node {
  id :: NodeID,
  contents :: NodeData
} deriving Show
-}
getNextIdNode :: [G.Node] -> Int
getNextIdNode nodes
  | flip all nodes $ \case
      G.Node{} -> True
      _        -> False =
      G.id (maximumBy (\node1 node2 -> compare (G.id node1) (G.id node2)) nodes) + 1
  | otherwise = error "This is only meant to process the constructor named Node"
