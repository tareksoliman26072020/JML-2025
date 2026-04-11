module JML.Types where

import qualified Data.Map as Map (Map)
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer

import qualified SymbolicExecution.Types as SYT (SymbolicExecution)
import qualified JML.Logs.Log as Log (Log, Header)

data Op = Add | Sub | Mul | Div | Gt | Ge | Lt | Le | Eq | Neq
        deriving Show

data Expr = Var String | Num Int | Bin Expr Op Expr | Not Expr | Old Expr
          deriving Show

data Clause =
    Requires Expr
  | Ensures Expr
  | LoopInvariant Expr
  | Signals String Expr
  | Assignable [String]
  deriving Show

data Method = Method {
  name    :: String,
  clauses :: [Clause]
} deriving Show

data JMLState = JMLState {
  method    :: Method,
  logHeader :: Log.Header
}

type JMLMonad =
  ExceptT String (ReaderT (Map.Map String SYT.SymbolicExecution)
                          (WriterT [Log.Log] (State JMLState)))

newtype MethodProcessor = MethodProcessor {
  methodProcessorMonad :: JMLMonad ExecutionResult
}

data ExecutionResult = ER_Void
