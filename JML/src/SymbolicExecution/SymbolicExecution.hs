{-# Language LambdaCase #-}
module SymbolicExecution.SymbolicExecution where

import SymbolicExecution.Types
import qualified CFG.Types as CFG
import qualified Data.Map as Map
import Control.Monad.Reader (runReaderT)
import Control.Monad.State  (StateT, modify, runStateT)
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
    n@CFG.End{} -> do
      tell [MethodEnd "visitNode -> case node of End"]
      case CFG.mExpr n of
        Nothing       -> do
          tell [Void "visitNode -> case node of End -> Nothing"]
          return ER_Void
        a@(Just expr) -> do
          tell [ReturnStatement (show expr) "visitNode -> case node of End -> Just"]
          visitStmt (AST.ReturnStmt a)
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
  tell [ReturnStatement (show expr) "visitStmt -> pattern matching: ReturnStmt"]
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
visitStmt _ = throwError "TODO -> visitStmt -> 2"

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
visitExpr expr@(AST.NumberLiteral float) = do
  tell [Expression_2_Handle (show expr) "visitExpr -> pattern matching: NumberLiteral"]
  return $ ER_Expr (SymNum float)
{-
data SymState = SymState
 { env :: Map.Map String SymExpr
 , methodType :: AST.Types
 , pc  :: [SymExpr]
 }
-}
-- FunCallExpr {funName :: Expression, funArgs :: [Expression]}
visitExpr (expr@AST.FunCallExpr{}) = do
  tell [Expression_2_Handle (show expr) "visitExpr -> pattern matching: FunCallExpr"]
  (_,cfgs) <- ask
  let funCallName = AST.getFunCallName $ AST.FunCallStmt expr
  case CFG.findCFGByName funCallName cfgs of
    Nothing   -> throwError $ "Method " ++ funCallName ++ " does not exist"
    Just cfg0 ->
      let (_,funCallSymState) = runCFG cfgs cfg0
      in return $ ER_Expr $ getReturnSymExpr funCallSymState
--BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
visitExpr expr@AST.BinOpExpr{} = do
  tell [Expression_2_Handle (show expr) "visitExpr -> pattern matching: BinOpExpr"]
  ER_Expr operand1 <- visitExpr (AST.expr1 expr)
  ER_Expr operand2 <- visitExpr (AST.expr2 expr)
  let operands = [operand1,operand2]
  case AST.binOp expr `elem` [AST.Plus, AST.Mult, AST.Minus, AST.Div] of
    True -> return $ ER_Expr $ getBinSymExpr (operand1, operand2) (AST.binOp expr)
    False -> throwError "TODO: visitExpr -> BinOpExpr"
visitExpr _ = error "won't happen"

getIntegralArithBinOp :: Integral a => AST.BinOp -> (a -> a -> a)
getIntegralArithBinOp = \case
    AST.Plus  -> (+)
    AST.Mult  -> (*)
    AST.Minus -> (-)

getFractionalArithBinOp :: Fractional a => AST.BinOp -> (a -> a -> a)
getFractionalArithBinOp = \case
    AST.Plus  -> (+)
    AST.Mult  -> (*)
    AST.Minus -> (-)
    AST.Div   -> (/)

getBinSymExpr :: (SymExpr, SymExpr) -> AST.BinOp -> SymExpr
getBinSypExpr (SymNum num1, SymNum num2) op =
  SymNum (getFractionalArithBinOp op num1 num2)
getBinSypExpr (SymInt num1, SymInt num2) op =
  SymInt (getIntegralArithBinOp op num1 num2)
getBinSypExpr (SymDouble num1, SymDouble num2) op =
  SymDouble (getFractionalArithBinOp op num1 num2)
getBinSypExpr (SymFloat num1, SymFloat num2) op =
  SymFloat (getFractionalArithBinOp op num1 num2)
getBinSymExpr (SymNum num1, SymInt num2) op =
  SymInt (getIntegralArithBinOp op (round num1) num2)
getBinSymExpr (SymNum num1, SymDouble num2) op =
  SymDouble (getFractionalArithBinOp op (realToFrac num1) num2)
getBinSymExpr (SymNum num1, SymFloat num2) op =
  SymFloat (getFractionalArithBinOp op num1 num2)
getBinSymExpr (symExpr, SymNum num2) op = getBinSymExpr (SymNum num2, symExpr) op


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
      let node1 :: CFG.Node
          node1 = CFG.findNode_via_id cfg from
          node2 :: CFG.Node
          node2 = CFG.findNode_via_id cfg to
          rec = CFG.findEdge_via_id cfg to
      in case rec of
         --Nothing   -> f $ getReader (visitNode node1) >> getReader (visitNode node2)
           Nothing -> f $ do
             getReader $ visitNode node1
             getReader $ visitNode node2
           Just edge -> f $ do
             getReader (visitNode node1)
             return (runHelper edge)
             return ER_Void
    f :: R -> ([Log],SymState)
    f theRun =
      let initialSymState = SymState Map.empty undefined []
          run_r :: ExceptT String (WriterT [Log] (StateT SymState Maybe)) ExecutionResult
          run_r = runReaderT theRun (defaultConfig,cfgs)
          run_e :: WriterT [Log] (StateT SymState Maybe) (Either String ExecutionResult)
          run_e = runExceptT run_r
          run_w :: StateT SymState Maybe (Either String ExecutionResult,[Log])
          run_w = runWriterT run_e
          mRun_s :: Maybe ((Either String ExecutionResult,[Log]),SymState)
          mRun_s = runStateT run_w initialSymState
      in case mRun_s of
           Nothing -> error "Why is this Nothing?"
           Just ((ei,logs),s) -> (logs,either error (const s) ei)

