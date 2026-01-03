{-# Language LambdaCase, NamedFieldPuns #-}
module CFG.CFG where

import Visitors.API
import qualified Parser.Types as AST
import qualified CFG.Types as G
import Data.List (foldl',nub,find)

data CFGCreator = Node {node :: G.Node} | Nodes {cfg :: G.CFG}

instance ASTVisitor CFGCreator where
--visitMethod :: AST.Method -> CFGCreator
  visitMethod method =
    let ((_,currentNodeID,nextNodeID),g) = visitStatement0 (0,0,1) (AST.funBody method)
    in case g of
    {-
         Node cfg
           | null (G.nodes cfg) ->
               Nodes $ G.CFG {
                 G.nodes = case AST.getMethodDecl method of
                   (Just t,methodName) ->
                     let entry = G.Entry t methodName (AST.getMethodFormalParams method)
                     in [entry],
                 G.edges = []
              }
     -}
         Nodes cfg ->
           let theEnd = case last (G.nodes cfg) of
                          G.End{} -> []
                          _       -> [G.End nextNodeID 0 Nothing]
           in Nodes $ G.CFG {
                G.nodes = case AST.getMethodDecl method of
                  (Just t,methodName) ->
                    let entry = G.Entry t methodName (AST.getMethodFormalParams method)
                        theNodes = G.nodes cfg
                    in case null (G.nodes cfg) of
                         True -> [entry]
                         False -> entry : theNodes ++ theEnd,
                G.edges = case null (G.nodes cfg) of
                            True -> []
                            False -> G.edges cfg ++ if null theEnd then [] else [(currentNodeID,[nextNodeID])]
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
        G.nodeData = G.BooleanExpression G.If (Just $ AST.condition stmt),
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
visitStatement0 (sourceNodeID,currentNodeID,nextNodeID) stmt@AST.ForStmt{} =
  let ---------------- initializationNode
      initializationNode = G.Node {
        G.id       = nextNodeID,
        G.nodeData = G.ForInitialization $ flip fmap (AST.mAcc stmt) $ \case
                       a@AST.AssignStmt{} -> AST.assign a
                       _                  -> error "won't happen",
        G.parent   = sourceNodeID
      }
      ---------------- condNode
      condNode = G.Node {
        G.id       = G.id initializationNode + 1,
        G.nodeData = G.BooleanExpression G.For $ AST.mCond stmt,
        G.parent   = sourceNodeID
      }
      ---------------- trueBranch
      ((_,trueCurrentID,trueNextID),true_cfg_creator0) =
        visitStatement0 (sourceNodeID,G.id condNode,G.id condNode+1) (AST.forBody stmt)
      ---------------- step node
      stepNode = G.Node {
        G.id       = trueNextID,
        G.nodeData = G.ForStep $ AST.mStep stmt,
        G.parent   = sourceNodeID
      }
      ---------------- add step node to true branch
      ---------------- add edge from step node to cond node
      true_cfg_creator = case true_cfg_creator0 of
        Nodes true_cfg -> G.CFG {
          G.nodes = G.nodes true_cfg ++ [stepNode],
          G.edges = (G.edges true_cfg) ++
                    [(trueCurrentID,[G.id stepNode])] ++ -- from for body to step node
                    [(G.id stepNode,[G.id condNode])]    -- from step node to cond node
        }
        _              -> error "won't happen"
      ---------------- meet branch
      meetNode = G.Node {
        G.id       = G.id stepNode + 1,
        G.nodeData = G.Meet G.For,
        G.parent   = sourceNodeID
      }
  in (,)
       (sourceNodeID,G.id meetNode,G.id meetNode+1)
       (Nodes $ G.CFG { -- add cond node, meet node
          G.nodes = initializationNode : condNode
                    : G.nodes true_cfg_creator ++ [meetNode],
          G.edges = [(currentNodeID,[nextNodeID])]
                    ++ [(G.id initializationNode,[G.id condNode])] -- init node ==> cond node
                    ++ G.edges true_cfg_creator
                    ++ [(G.id condNode,[G.id meetNode])]        -- cond node ==> meet node
       })
visitStatement0 (sourceNodeID,currentNodeID,nextNodeID) stmt@AST.WhileStmt{} =
  let condNode = G.Node {
        G.id       = nextNodeID,
        G.nodeData = G.BooleanExpression G.While (AST.mCondition stmt),
        G.parent   = sourceNodeID
      }
      ((_,trueCurrentID,trueNextID),true_cfg_creator0) =
        visitStatement0 (sourceNodeID,G.id condNode,G.id condNode+1) (AST.whileBody stmt)
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
          G.edges = [(currentNodeID,[nextNodeID])]
                    ++ G.edges true_cfg_creator
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
      -- all edges :: [(NodeID,[NodeID])]
      allEdges =
        -- before try start node ==> try start node
        [(currentNodeID, [G.id try_start])] ++ 
        -- try start node ==> try path
  --    [(G.id try_start, [G.id try_start + 1])] ++
        -- try edges
        (case try_cfg_creator0 of
           Nodes cfg -> G.edges cfg
           Node  _   -> error "won't happen") ++
        -- end of try path ==> catch start node
        [(tryCurrentID, [G.id catch_start])] ++
        -- catch start node ==> catch path
  --    [(G.id catch_start, [G.id catch_start + 1])] ++
        -- catch edges
        (case catch_cfg_creator0 of
           Nodes cfg -> G.edges cfg
           Node  _   -> error "won't happen") ++
        case AST.finallyBody stmt of
          AST.CompStmt [] -> []
          AST.CompStmt{}  ->
            -- end of catch path ==> finally start node (if there's finally)
            [(catchCurrentID,[G.id finally_start])] ++
            -- finally start node ==> finally path
  --        [(G.id finally_start, [G.id finally_start + 1])] ++
            -- finally edges
            case finally_cfg_creator0 of
              Nodes cfg -> G.edges cfg
              Node  _   -> error "won't happen"
          _               -> error "won't happen"
  in (,)
       (sourceNodeID, finallyCurrentID, finallyNextID)
       (Nodes $ G.CFG {
          G.nodes = allNodes,
          G.edges = allEdges
       })
visitStatement0 (sourceNodeID,_,nextNodeID) stmt@AST.ReturnStmt{} =
  (,)
    (sourceNodeID,nextNodeID,nextNodeID+1)
    $ Node $ G.End nextNodeID sourceNodeID (AST.returnS stmt)
visitStatement0 (sourceNodeID,_,nextNodeID) stmt@AST.FunCallStmt{} =
  (,)
    (sourceNodeID,nextNodeID,nextNodeID+1)
    (Node $ G.Node {
       G.id       = nextNodeID,
       G.nodeData = G.Statement stmt,
       G.parent   = sourceNodeID
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
