{-# Language LambdaCase #-}
module SymbolicExecution.SymbolicExecution where

import SymbolicExecution.Types
import qualified CFG.Types as CFG
import qualified Data.Map as Map
import Control.Monad.Reader (runReaderT)
import Control.Monad.State  (State, modify, runState)
import Control.Monad.Except
import Control.Monad (forM_)
import qualified Parser.Types as AST
import Visitors.API
import Control.Monad.Reader

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
   ReaderT (Config,[CFG])         -- solver endpoints, thresholds…
   (State SymState) a             -- env :: Map Var SymExpr; pc :: [SymExpr]

data SymState = SymState
 { env :: Map.Map String SymExpr
 , methodType :: Maybe AST.Types
 , pc  :: [SymExpr]          -- ^ Path‐conditions: accumulate the conditions under which each execution state is feasible.
 }
-}
instance CFGVisitor SymExec where
--visitNode :: CFG.Node -> SymExec
  --visitNode node = return $ SymState Map.empty []
  visitNode node = SymExec $ case node of
    CFG.Entry t _ -> do
      modify $ \symState -> SymState {
        env = env symState,
        methodType = t,
        pc = pc symState
      }
      return ER_Void
    n@CFG.End{} -> case CFG.mExpr n of
      Nothing       -> return ER_Void
      a@(Just expr) -> visitStmt (AST.ReturnStmt a)--visitExpr expr True
    _ -> error "TODO"


visitStmt :: AST.Statement -> R
visitStmt (AST.ReturnStmt (Just expr)) = do
  symExpr <- visitExpr expr
  modify $ \symState ->
    SymState {
      env = case (methodType symState, symExpr) of
        (AST.Int, ER_Expr (SymNum float))    ->
          Map.insert "return" (SymInt (round float)) (env symState)
        (AST.Double, ER_Expr (SymNum float)) ->
          Map.insert "return" (SymDouble (realToFrac float)) (env symState)
        (AST.Float, ER_Expr (SymNum float))  ->
          Map.insert "return" (SymFloat float) (env symState)
        (_,ER_Expr s)                           ->
          Map.insert "return" s (env symState)
        _ -> error "TODO",
      methodType = methodType symState,
      pc = pc symState
    }
  return ER_Void
visitStmt _ = error "won't happen, or TODO"

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
visitExpr :: AST.Expression -> R
visitExpr (AST.NumberLiteral float) = return $ ER_Expr (SymNum float)
{-
data SymState = SymState
 { env :: Map.Map String SymExpr
 , methodType :: AST.Types
 , pc  :: [SymExpr]
 }
-}
-- FunCallExpr {funName :: Expression, funArgs :: [Expression]}
visitExpr (expr@AST.FunCallExpr{}) = do
  (_,cfgs) <- ask-- :: ReaderT (Config,[CFG.CFG]) (State SymState) (Config,[CFG.CFG])
  let funCallName = AST.getFunCallName $ AST.FunCallStmt expr
  case CFG.findCFGByName funCallName cfgs of
    Nothing   -> throwError $ "Method " ++ funCallName ++ " does not exist"
    Just cfg0 -> 
      let funCallSymState = runCFG cfgs cfg0
      in return $ ER_Expr $ getReturnSymExpr funCallSymState
visitExpr _ = error "won't happen"

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

runCFG :: [CFG.CFG] -> CFG.CFG -> SymState
runCFG cfgs cfg = case CFG.edges cfg of
  [] -> SymState Map.empty undefined []
  (x : _) -> runHelper x where
    runHelper :: (CFG.NodeID,[CFG.NodeID]) -> SymState
    runHelper (from,[to]) =
      let node1 = CFG.findNode_via_id cfg from
          node2 = CFG.findNode_via_id cfg to
          rec = CFG.findEdge_via_id cfg to
      in case rec of
           Nothing   -> f $ getReader (visitNode node1) >> getReader (visitNode node2)
           Just edge -> f $ getReader (visitNode node1) >> return (runHelper edge) >> return ER_Void
    f :: R -> SymState
    f theRun =
      let initialSymState = SymState Map.empty undefined []
          run_r :: ExceptT String (State SymState) ExecutionResult
          run_r = runReaderT theRun (defaultConfig,cfgs)
          run_e :: State SymState (Either String ExecutionResult)
          run_e = runExceptT run_r
          run_s :: (Either String ExecutionResult, SymState)
          run_s@(ei,s) = runState run_e initialSymState
      -- either :: (a -> c) -> (b -> c) -> Either a b -> c
      in either error (const s) ei

