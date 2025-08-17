{-# Language LambdaCase #-}
module SymbolicExecution.SymbolicExecution where

import qualified SymbolicExecution.Types as SY
import qualified CFG.Types as CFG
import qualified Data.Map as Map
import Control.Monad.Reader (runReaderT)
import Control.Monad.State  (State, modify, runState)
import Control.Monad.Except
import Control.Monad (forM_)
import qualified Parser.Types as AST

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
execNode :: CFG.Node -> SY.SymExec ()
--execNode node = return $ SY.SymState Map.empty []
execNode = \case
  CFG.Entry t _ ->
    modify $ \symState -> SY.SymState {
      SY.env = SY.env symState,
      SY.methodType = t,
      SY.pc = SY.pc symState
    }
  -- End {id = 1, mExpr = Just (NumberLiteral 5.0)}
  n@CFG.End{} -> case CFG.mExpr n of
    Nothing   -> return ()
    Just expr -> execExpr expr True
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
execExpr :: AST.Expression -> Bool -> SY.SymExec ()
execExpr (AST.NumberLiteral float) isEnd = modify $ \symState -> 
  let symExpr = case SY.methodType symState of
        AST.Int    -> SY.SymInt (round float)
        AST.Double -> SY.SymDouble (realToFrac float)
        AST.Float  -> SY.SymFloat float
        _          -> error "won't happen"
  in SY.SymState {
       SY.env = case isEnd of
         True -> Map.insert "return" symExpr (SY.env symState)
         False -> error "TODO",
       SY.methodType = SY.methodType symState,
       SY.pc = SY.pc symState
     }
{-
data SymState = SymState
 { env :: Map.Map String SymExpr
 , methodType :: AST.Types
 , pc  :: [SymExpr]
 }
-}
-- FunCallExpr {funName :: Expression, funArgs :: [Expression]}
execExpr (expr@AST.FunCallExpr{}) isEnd = do
  (co,cfgs) <- ask-- :: ReaderT (SY.Config,[CFG.CFG]) (State SY.SymState) (SY.Config,[CFG.CFG])
  let funCallName = AST.getFunCallName $ AST.FunCallStmt expr
  case CFG.findCFGByName funCallName cfgs of
    Nothing   -> throwError $ "Method " ++ funCallName ++ " does not exist"
    Just cfg0 -> 
      let funCallSymState = runCFG cfgs cfg0
          symExpr = case isEnd of
            True  -> SY.getReturnSymExpr funCallSymState
            False -> error "TODO: Here we have a fun call, but not within a return statement"
      in modify $ \symState ->
           SY.SymState {
             SY.env        = Map.insert "return" symExpr (SY.env symState),
             SY.methodType = SY.methodType symState,
             SY.pc         = SY.pc symState
           }
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
runCFG :: [CFG.CFG] -> CFG.CFG -> SY.SymState
runCFG cfgs cfg = case CFG.edges cfg of
  [] -> SY.SymState Map.empty undefined []
  (x : _) -> runHelper x where
    runHelper :: (CFG.NodeID,[CFG.NodeID]) -> SY.SymState
    runHelper (from,[to]) =
      let node1 = CFG.findNode_via_id cfg from
          node2 = CFG.findNode_via_id cfg to
          rec = CFG.findEdge_via_id cfg to
      in case rec of
           Nothing   -> f $ execNode node1 >> execNode node2
           Just edge -> f $ execNode node1 >> return (runHelper edge) >> return ()
    f :: SY.SymExec () -> SY.SymState
    f theRun =
      let initialSymState = SY.SymState Map.empty undefined []
          run_r :: ExceptT String (State SY.SymState) ()
          run_r = runReaderT theRun (SY.defaultConfig,cfgs)
          run_e :: State SY.SymState (Either String ())
          run_e = runExceptT run_r
          run_s :: (Either String (), SY.SymState)
          run_s@(ei,s) = runState run_e initialSymState
      -- either :: (a -> c) -> (b -> c) -> Either a b -> c
      in either error (const s) ei


