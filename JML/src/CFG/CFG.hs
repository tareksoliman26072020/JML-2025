{-# Language LambdaCase #-}
module CFG.CFG where

import Visitors.API
import qualified Parser.Types as AST
import qualified CFG.Types as G
import Data.List (maximumBy)

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
    let funBodyNodes = undefined--map (node . visitStatement0 1) (AST.statements $ AST.funBody method)
        nodes0 :: [G.Node]
        nodes0 = G.Entry 0
                 : funBodyNodes
                 : G.End (getNextIdNode funBodyNodes)
                 : []
        edges0 = connectNodes nodes0
    in Nodes $ G.CFG nodes0 edges0
--visitStatement :: AST.Statement -> CFGCreator
  visitStatement = undefined



visitStatement0 :: Int -> AST.Statement -> (G.NodeID,CFGCreator)
visitStatement0 = undefined
{-
visitStatement0 startPos a@AST.CompStmt{} =
  let nodes0 = map (\(pos,stmt) -> node $ visitStatement0 pos stmt)
                   (zip [startPos ..] $ AST.statements a)
      edges0 = connectNodes nodes0
  in Nodes $ G.CFG nodes0 edges0
--CondStmt {condition :: Expression, siff :: Statement, selsee :: Statement}
visitStatement0 startPos a@AST.CondStmt{} =
  let conditionNode = G.Node { -- :: G.Node
        G.id = startPos,--NodeID,
        G.contents = G.BooleanExpression G.If (AST.condition a)
      }
      if_cfg = cfg $ visitStatement0 (startPos+1) $ AST.siff a -- :: G.CFG
      else_cfg = cfg $ visitStatement0 (getNextIdNode $ G.nodes if_cfg) $ AST.selsee a -- :: G.CFG
      endNode = G.Node { -- :: G.Node
        G.id = error "Not Error: enumerateNodes will override this",
        G.contents = G.Meet G.If
      }
visitStatement0 _ a@AST.ForStmt{} = undefined
visitStatement0 _ a@AST.WhileStmt{} = undefined
visitStatement0 _ a@AST.TryCatchStmt{} = undefined
visitStatement0 _ a = Node $ undefined a
-}

enumerateNodes :: Int -> [G.Node] -> [G.Node]
enumerateNodes start nodes = flip map (zip [start ..] nodes) $ \case
  (num,G.Entry{}) -> error "won't happen"
  (num,G.End{})   -> error "won't happen"
  (num,node)      -> G.Node {
    G.id       = num,
    G.contents = G.contents node
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
