{-# Language LambdaCase #-}
module SymbolicExecution.SymbolicExecution where

import qualified SymbolicExecution.Types as SY
import qualified CFG.Types as CFG
import qualified Data.Map as Map
import Control.Monad.Reader (runReaderT)
import Control.Monad.State  (State(..), evalState, get, modify)
import Control.Monad (forM_)
import qualified Parser.Types as AST

{-
data Node = Entry | End {
    id :: NodeID,
    parent :: NodeID,
    mExpr :: Maybe AST.Expression
  } | Node {
    id :: NodeID,
    nodeData :: NodeData,
    parent :: NodeID
  } deriving Show
-}

{-
type SymExec a =
   ReaderT Config                 -- solver endpoints, thresholds…
   (State SymState) a             -- env :: Map Var SymExpr; pc :: [SymExpr]

data SymState = SymState
 { env :: Map.Map String SymExpr
 , methodType :: Maybe AST.Types
 , pc  :: [SymExpr]          -- ^ Path‐conditions: accumulate the conditions under which each execution state is feasible.
 }
-}
execNode :: CFG.Node -> SY.SymExec SY.SymState
--execNode node = return $ SY.SymState Map.empty []
execNode = \case
  CFG.Entry t -> do
    modify $ \symState -> SY.SymState {
      SY.env = SY.env symState,
      SY.methodType = t,
      SY.pc = SY.pc symState
    }
    get
    {-do
    symState <- get
    return $ error $ show $ SY.SymState {
      SY.env = SY.env symState,
      SY.methodType = t,
      SY.pc = SY.pc symState
    }-}
  -- End {id = 1, mExpr = Just (NumberLiteral 5.0)}
  n@CFG.End{} -> case CFG.mExpr n of
    Nothing   -> get
    Just expr -> do
      execExpr expr True
  _ -> error "TODO"


{-
data Expression
  = NumberLiteral Float
  | BoolLiteral Bool
  | CharLiteral Char
  | StringLiteral String
  | Null
  | VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
  | ArrayCallExpr {arrName :: Expression, index :: Maybe Expression}
  | ArrayInstantiationExpr {arrType :: Maybe (Type Types), arrSize :: Maybe Expression, arrElems :: [Expression]}
  | BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
  | UnOpExpr {unOp :: UnOp, expr :: Expression}
  | FunCallExpr {funName :: Expression, funArgs :: [Expression]}
  | CondExpr {eiff :: Expression, ethenn :: Expression, eelsee :: Expression}
  | AssignExpr {assEleft :: Expression, assEright :: Expression}
  | ExcpExpr {excpName :: Exception, excpmsg :: Maybe String}
  | ReturnExpr {returnE :: Maybe Expression}
  deriving (Eq, Show)
-}
{-
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
execExpr :: AST.Expression -> Bool -> SY.SymExec SY.SymState
execExpr (AST.NumberLiteral float) isEnd = do
  modify $ \symState -> 
    let symExpr = case SY.methodType symState of
          AST.Int    -> SY.SymInt (round float)
          AST.Double -> SY.SymDouble (realToFrac float)
          AST.Float  -> SY.SymFloat float
          _          -> error "won't happen"
    in SY.SymState {
      SY.env = Map.insert "return" symExpr (SY.env symState),
      SY.methodType = SY.methodType symState,
      SY.pc = SY.pc symState
    }
  get
execExpr _ _ = error "won't happen"

------------------------------

{-
data CFG = CFG {
  nodes :: [Node],
  edges :: [(NodeID,[NodeID])]
} deriving Show

----------

data Node = Entry | End {
    id :: NodeID,
    parent :: NodeID,
    mExpr :: Maybe AST.Expression
  } | Node {
    id :: NodeID,
    nodeData :: NodeData,
    parent :: NodeID
  } deriving Show

----------

type SymExec a =
   ReaderT Config
   (State SymState) a

data SymState = SymState
 { env :: Map.Map String SymExpr
 , pc  :: [SymExpr]          -- ^ Path‐conditions: accumulate the conditions under which each execution state is feasible.
-}
runCFG :: CFG.CFG -> SY.SymState
runCFG cfg = case CFG.edges cfg of
  [] -> SY.SymState Map.empty undefined []
  (x : _) -> runHelper x where
    runHelper :: (CFG.NodeID,[CFG.NodeID]) -> SY.SymState
    runHelper (from,[to]) =
      let node1 = CFG.findNode_via_id cfg from
          node2 = CFG.findNode_via_id cfg to
          rec = CFG.findEdge_via_id cfg to
      in case rec of
           Nothing   -> f $ execNode node1 >> execNode node2
           Just edge -> f $ execNode node1 >> return (runHelper edge)
    f :: SY.SymExec SY.SymState -> SY.SymState
    f theRun =
      let initialSymState = SY.SymState Map.empty undefined []
          run_r :: State SY.SymState SY.SymState
          run_r = runReaderT theRun SY.defaultConfig
          run_s :: SY.SymState
          run_s = evalState run_r initialSymState
      in run_s
