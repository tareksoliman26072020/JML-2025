{-# Language LambdaCase, NamedFieldPuns #-}
module CFG.CFG where

import Visitors.API
import qualified Parser.Types as AST
import qualified CFG.Types as G
import Data.List (foldl',nub)

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
    let (_,g) = visitStatement0 (0,0,1) (AST.funBody method)
    in case g of
         Nodes cfg -> Nodes $ G.CFG {
           G.nodes = G.Entry : G.nodes cfg,
           G.edges = G.edges cfg
         }
         _ -> error "won't happen"
  visitStatement = error "visitStatement0 is a replacement for this"


type SourceNodeID  = G.NodeID
type CurrentNodeID = G.NodeID
type NextNodeID    = G.NodeID

visitStatement0 :: (SourceNodeID,CurrentNodeID,NextNodeID) -> AST.Statement -> ((SourceNodeID,CurrentNodeID,NextNodeID),CFGCreator)
visitStatement0 ids stmt@AST.CompStmt{} =
  foldl' f (ids, Nodes $ G.CFG [] []) (AST.statements stmt)
  where
  f :: ((SourceNodeID,CurrentNodeID,NextNodeID),CFGCreator) -> AST.Statement -> ((SourceNodeID,CurrentNodeID,NextNodeID),CFGCreator)
  f ((sourceNodeID1,currentNodeID1,nextNodeID1), cfgCreator1) nextStmt = case cfgCreator1 of
    Node _     -> error "CompStmt results in Nodes"
    Nodes cfg1 -> case visitStatement0 (sourceNodeID1,currentNodeID1,nextNodeID1) nextStmt of
      -- the new nodes and edges get added
      (nodeIDs, Nodes cfg2) -> (,)
        nodeIDs
        (Nodes $ G.CFG {
           G.nodes = G.nodes cfg1 ++ G.nodes cfg2,
           G.edges = G.edges cfg1 ++ G.edges cfg2
         })
      -- the new node gets added
      (nodeIDs, Node node2) -> (,)
        nodeIDs
        (Nodes $ G.CFG {
           G.nodes  = G.nodes cfg1 ++ [node2],
           G.edges  = addEdge (currentNodeID1,nextNodeID1) (G.edges cfg1)
         })
visitStatement0 (sourceNodeID,_,nextNodeID) stmt@AST.VarStmt{} =
  let node = G.Node {
        G.id = nextNodeID,
        G.nodeData = G.Statement stmt,
        G.parent = sourceNodeID
      }
  in ((sourceNodeID,nextNodeID,nextNodeID+1),Node node)
visitStatement0 (sourceNodeID,_,nextNodeID) stmt@AST.AssignStmt{} =
  let node = G.Node {
        G.id = nextNodeID,
        G.nodeData = G.Statement stmt,
        G.parent = sourceNodeID
      }
  in ((sourceNodeID,nextNodeID,nextNodeID+1),Node node)
visitStatement0 (sourceNodeID,currentNodeID,nextNodeID) stmt@AST.CondStmt{} =
  let ---------------- condNode
      condNode = G.Node {
        G.id = nextNodeID,
        G.nodeData = G.BooleanExpression G.If (AST.condition stmt),
        G.parent = sourceNodeID
      }
      ---------------- ifBranch
      ((_,if_currentNodeID,if_nextNodeID),if_cfg_creator) =
        visitStatement0 (nextNodeID,nextNodeID,nextNodeID+1) (AST.siff stmt)
      ---------------- elseBranch
      ((_,else_currentNodeID,else_nextNodeID),else_cfg_creator) =
        visitStatement0 (nextNodeID,nextNodeID,if_nextNodeID) (AST.selsee stmt)
      meetNode = G.Node {
        G.id       = else_nextNodeID,
        G.nodeData = G.Meet G.If,
        G.parent   = sourceNodeID
      }
  in case (if_cfg_creator,else_cfg_creator) of
       (Nodes if_cfg,Nodes else_cfg) -> (,)
         (sourceNodeID,G.id meetNode,G.id meetNode + 1)
         (Nodes $ G.CFG {
           G.nodes = condNode : G.nodes if_cfg ++ G.nodes else_cfg ++ [meetNode],
           G.edges = (currentNodeID,[nextNodeID])
                      : refineEdges (G.edges if_cfg ++ G.edges else_cfg)
                       -- There's an edge between the end of the if branch, and the meet node
                      ++ [(if_currentNodeID,[else_nextNodeID])
                       -- There's an edge between the end of the else branch, and the meet node
                         ,(else_currentNodeID,[else_nextNodeID])]
         })
       _ -> error "won't happen"
visitStatement0 (sourceNodeID,_,nextNodeID) stmt@AST.ForStmt{} =
  let ---------------- condNode
      condNode = G.Node {
        G.id       = nextNodeID,-- :: NodeID,
        G.nodeData = G.BooleanExpression G.For $ AST.cond stmt,-- :: NodeData,
        G.parent   = sourceNodeID-- :: NodeID
      }
      ---------------- trueBranch
      ((_,trueCurrentID,trueNextID),true_cfg_creator0) =
        visitStatement0 (G.id condNode,G.id condNode,G.id condNode+1) (AST.forBody stmt)
      ---------------- step node
      stepNode = G.Node {
        G.id       = trueNextID,
        G.nodeData = G.Statement $ AST.step stmt,
        G.parent   = trueCurrentID
      }
      ---------------- add step node to true branch
      ---------------- add edge from step node to cond node
      true_cfg_creator = case true_cfg_creator0 of
        Nodes true_cfg -> G.CFG {
          G.nodes = G.nodes true_cfg ++ [stepNode],
          G.edges = (G.edges true_cfg) ++
                    [(trueCurrentID,[G.id stepNode])] ++ -- from for body to step node
                    [(G.id stepNode,[G.id condNode])]       -- from step node to cond node
        }
        _                      -> error "won't happen"
      ---------------- meet branch
      meetNode = G.Node {
        G.id       = trueNextID+1,-- :: NodeID,
        G.nodeData = G.Meet G.For,-- :: NodeData,
        G.parent   = sourceNodeID-- :: NodeID
      }
  in (,)
       (sourceNodeID,G.id meetNode,G.id meetNode+1)
       (Nodes $ G.CFG { -- add cond node, meet node
          G.nodes = condNode : G.nodes true_cfg_creator ++ [meetNode],
          G.edges = G.edges true_cfg_creator
                    ++ [(G.id condNode,[G.id meetNode])] -- from cond node to meet node
       })
visitStatement0 (sourceNodeID,_,nextNodeID) stmt@AST.WhileStmt{} =
  let condNode = G.Node {
        G.id       = nextNodeID,
        G.nodeData = G.BooleanExpression G.While (AST.condition stmt),
        G.parent   = sourceNodeID
      }
      ((_,trueCurrentID,trueNextID),true_cfg_creator0) =
        visitStatement0 (G.id condNode,G.id condNode,G.id condNode+1) (AST.whileBody stmt)
      true_cfg_creator = case true_cfg_creator0 of
        Nodes cfg -> G.CFG {
          G.nodes = G.nodes cfg,
          G.edges = G.edges cfg ++ [(trueCurrentID,[G.id condNode])]
        }
        _         -> error "won't happen"
      meetNode = G.Node {
        G.id       = trueNextID,
        G.nodeData = G.Meet G.While,
        G.parent   = sourceNodeID
      }
  in (,)
       (sourceNodeID,G.id meetNode,G.id meetNode+1)
       (Nodes $ G.CFG {
          G.nodes = condNode : G.nodes true_cfg_creator ++ [meetNode],
          G.edges = (G.id condNode,[G.id condNode+1]) : G.edges true_cfg_creator
                    ++ [(G.id condNode,[G.id meetNode])]
       })
visitStatement0 (sourceNodeID,currentNodeID,nextNodeID) stmt@AST.TryCatchStmt{} =
  let -- try start node
      try_start = G.Node {
        G.id       = nextNodeID,
        G.nodeData = G.TryNode,
        G.parent   = sourceNodeID
      }
      -- try
      ((_,tryCurrentID,tryNextID),try_cfg_creator0) =
        visitStatement0 (sourceNodeID, G.id try_start, G.id try_start + 1) (AST.tryBody stmt)
      -- catch start node
      catch_start = G.Node {
        G.id       = tryNextID,
        G.nodeData = G.CatchNode $ AST.catchExcp stmt,
        G.parent   = sourceNodeID
      }
      -- catch
      ((_,catchCurrentID,catchNextID),catch_cfg_creator0) =
        visitStatement0 (sourceNodeID, G.id catch_start, G.id catch_start + 1) (AST.catchBody stmt)
      -- finally start node
      finally_start = --case AST.finallyBody stmt of AST.CompStmt ss -> ...
        G.Node {
          G.id       = catchNextID,
          G.nodeData = G.FinallyNode,
          G.parent   = sourceNodeID
        }
      -- finally
      ((_,finallyCurrentID,finallyNextID),finally_cfg_creator0) =
        visitStatement0 (sourceNodeID, G.id finally_start, G.id finally_start + 1) (AST.finallyBody stmt)
      -- all nodes
      allNodes = [try_start]
                 ++ case try_cfg_creator0 of
                      Nodes cfg -> G.nodes cfg
                      Node _    -> error "won't happen"
                 ++ [catch_start]
                 ++ case catch_cfg_creator0 of
                      Nodes cfg -> G.nodes cfg
                      Node _    -> error "won't happen"
                 ++ case AST.finallyBody stmt of
                      AST.CompStmt [] -> []
                      AST.CompStmt{}  ->
                        [finally_start]
                        ++ case finally_cfg_creator0 of
                             Nodes cfg -> G.nodes cfg
                             Node _    -> error "won't happen"
                      _               -> error "won't happen"
      -- all edges
      allEdges = undefined
  in (,)
       (sourceNodeID, finallyCurrentID, finallyNextID)
       (Nodes $ G.CFG {
          G.nodes = allNodes,
          G.edges = allEdges -- :: [(NodeID,[NodeID])]
       })
{-
visitStatement0 (sourceNodeID,currentNodeID,nextNodeID) stmt@AST.TryCatchStmt{} =
  let -- try
      ((_,tryCurrentID,tryNextID),try_cfg_creator0) =
        visitStatement0 (sourceNodeID,currentNodeID,nextNodeID) (AST.tryBody stmt)
      -- catch
      ((catchSourceID,catchCurrentID,catchNextID),catch_cfg_creator0) =
        visitStatement0 (sourceNodeID,tryCurrentID,tryNextID) (AST.catchBody stmt)
      -- meet node: both try and catch meet in this node:
      meetNode = G.Node {
        G.id       = catchNextID,
        G.nodeData = G.Meet G.TryCatchFinally,
        G.parent   = catchSourceID
      }
      -- finally
      ((_,finallyCurrentID,finallyNextID),finally_cfg_creator0) =
        visitStatement0 (sourceNodeID,G.id meetNode,G.id meetNode+1) (AST.finallyBody stmt)
      -- CFGs
      getCfg = \case
        Nodes cfg -> G.CFG {
          G.nodes = G.nodes cfg,
          G.edges = G.edges cfg
        }
        _         -> error "won't happen"
      ----------
      allNodes = flip concatMap
        [try_cfg_creator0, catch_cfg_creator0, Node meetNode, finally_cfg_creator0]
        $ \case Node node -> [node]
                cfg0      -> G.nodes $ getCfg cfg0
      allEdges = (concatMap (G.edges . getCfg)
        [try_cfg_creator0, catch_cfg_creator0, finally_cfg_creator0])
        ++ [(tryCurrentID  ,[G.id meetNode])]
        ++ [(catchCurrentID,[G.id meetNode])]
        ++ [(G.id meetNode ,[G.id meetNode+1])]
  in (,)
       (sourceNodeID,finallyCurrentID,finallyNextID)
       (Nodes $ G.CFG {
          G.nodes = allNodes,
          G.edges = allEdges
       })
-}
visitStatement0 (sourceNodeID,_,nextNodeID) stmt@AST.ReturnStmt{} =
  (,)
    (sourceNodeID,nextNodeID,nextNodeID+1)
    $ Node $ G.End nextNodeID sourceNodeID (AST.returnS stmt)
visitStatement0 _ AST.FunCallStmt{} = error "won't happen"

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

{-
concatenates values of collided keys:

[(0,[1]),(1,[2]),(1,[3]),(2,[4]),(3,[4])]
  ==>
[(0,[1]),(1,[2,3]),(2,[4]),(3,[4])]
-}
refineEdges :: [(G.NodeID,[G.NodeID])] -> [(G.NodeID,[G.NodeID])]
refineEdges [] = []
refineEdges (x@(k1,_) : rest) =
  let search_and_combine = foldl' f1 x rest
      newRest            = filter (\(k,_) -> k /= k1) rest
  in search_and_combine : refineEdges newRest
  where
  f1 :: (G.NodeID,[G.NodeID]) -> (G.NodeID,[G.NodeID]) -> (G.NodeID,[G.NodeID])
  f1 y@(key,vals) (k,vs)
    | k==key    = (key,vals++vs)
    | otherwise = y

-----------
-----------

exec :: AST.Method -> G.CFG
exec x = case visitMethod x of
  Nodes cfg -> cfg
  _         -> error "won't happen"

-----------
-----------

showCFGCreator :: CFGCreator -> String
showCFGCreator (Node n) = G.showNode n
showCFGCreator (Nodes cfg) = G.showCFG cfg
