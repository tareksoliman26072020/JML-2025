module JML.Types where

import qualified Data.Map as Map (Map)
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer

import qualified SymbolicExecution.Types as SYT (
  SymbolicExecution,SymbolicExecutionValue)
import qualified CFG.Types as CFGT (Node_Coor)
import qualified JML.Logs.Log as Log (Log, Header)

data Op = Add | Sub | Mul | Div | Gt | Ge | Lt | Le | Eq | Neq
        deriving (Show,Eq)

data Expr = Var String | Int Int | Double Double
          | Bin Expr Op Expr | Not Expr | Old Expr
          | Result Expr
          deriving (Show,Eq)

data Clause =
    NormalBehavior {
      requires :: Maybe Expr,
      assignable :: [Expr],
      ensures :: Maybe Expr
    }
  | ExceptionalBehavior {
      requires :: Maybe Expr,
      signals :: String,
      assignable :: [Expr],
      ensures :: Maybe Expr
    }
--  | Requires Expr
--  | Ensures Expr
  | LoopInvariant Expr
--  | Signals String Expr
--  | Assignable [String]
  deriving (Show,Eq)

data Method = Method {
  name    :: String,
  clauses :: [Clause]
} deriving (Show,Eq)

data JMLState = JMLState {
  method    :: Method,
  logHeader :: Log.Header
} deriving (Show,Eq)

type JMLMonad =
  ExceptT String (ReaderT (Map.Map String SYT.SymbolicExecution)
                          (WriterT [Log.Log] (State JMLState)))

newtype MethodProcessor = MethodProcessor {
  methodProcessorMonad :: JMLMonad ExecutionResult
}

data ExecutionResult =
    ER_Void
  | ER_NoGlobalVars
  | ER_FormalParms [String]
  | ER_VarAssignments [(String,(SYT.SymbolicExecutionValue,CFGT.Node_Coor))]
  | ER_VarBindings (Map.Map String CFGT.Node_Coor)
  | ER_VarName_Global_Reassigned String SYT.SymbolicExecutionValue
  | ER_VarName_Skipped String SYT.SymbolicExecutionValue
  | ER_ReturnException Clause
  | ER_Return Clause
  deriving Show
