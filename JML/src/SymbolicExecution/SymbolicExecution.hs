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
import Control.Monad.Writer

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
    CFG.Entry t mn -> do
      tell [MethodStart mn "visitNode -> case node of Entry"]
      modify $ \symState -> SymState {
        env = env symState,
        methodType = t,
        pc = pc symState
      }
      return ER_Void
    n@CFG.End{} -> tell [MethodEnd "visitNode -> case node of End"] >> case CFG.mExpr n of
      Nothing       -> do
        tell [Void "visitNode -> case node of End -> Nothing"]
        return ER_Void
      a@(Just expr) -> do
        tell [ReturnStatement (show expr) "visitNode -> case node of End -> Just"]
        visitStmt (AST.ReturnStmt a)--visitExpr expr True
{-
Node {
    id :: NodeID,
    nodeData :: NodeData,
    parent :: NodeID
  }
-}
    n@CFG.Node{} -> throwError "TODO -> visitNode -> Node"--error "TODO"

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
        _ -> error "TODO -> visitStmt -> 1",
      methodType = methodType symState,
      pc = pc symState
    }
  return ER_Void
visitStmt _ = throwError "won't happen, or TODO -> visitStmt -> 2"

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
      let (_,funCallSymState) = runCFG cfgs cfg0
      in return $ ER_Expr $ getReturnSymExpr funCallSymState
--BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
visitExpr expr@AST.BinOpExpr{} = throwError "TODO -> visitExpr"
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

runCFG :: [CFG.CFG] -> CFG.CFG -> ([Log],SymState)
runCFG cfgs cfg = case CFG.edges cfg of
  [] -> ([],SymState Map.empty undefined [])
  (x : _) -> runHelper x where
    runHelper :: (CFG.NodeID,[CFG.NodeID]) -> ([Log],SymState)
    runHelper (from,[to]) =
      let node1 = CFG.findNode_via_id cfg from
          node2 = CFG.findNode_via_id cfg to
          rec = CFG.findEdge_via_id cfg to
      in case rec of
           Nothing   -> f $ getReader (visitNode node1) >> getReader (visitNode node2)
           Just edge -> f $ getReader (visitNode node1) >> return (runHelper edge) >> return ER_Void
    f :: R -> ([Log],SymState)
    f theRun =
      let initialSymState = SymState Map.empty undefined []
          run_r :: ExceptT String (WriterT [Log] (State SymState)) ExecutionResult
          run_r = runReaderT theRun (defaultConfig,cfgs)
          run_e :: WriterT [Log] (State SymState) (Either String ExecutionResult)
          run_e = runExceptT run_r
          run_w :: State SymState (Either String ExecutionResult,[Log])
          run_w = runWriterT run_e
          run_s :: ((Either String ExecutionResult,[Log]),SymState)
          run_s@((ei,logs),s) = runState run_w initialSymState
      in (logs,either error (const s) ei)

