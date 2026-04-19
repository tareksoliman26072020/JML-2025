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

data JMLType = String_Type | Int_Type | Num_Type | Double_Type | Bool_Type | Unknown_Type
             deriving (Show,Eq)

data Expr = JMLVar JMLType String | JMLInt Int | JMLDouble Double | JMLNum Float
          | JMLString String
          | JMLBin Expr Op Expr | JMLNot Expr | JMLOld Expr | Expr `JMLAnd` Expr
          | Expr `JMLEquals` Expr | JMLResult Expr | JMLActions [Expr]
          deriving (Show,Eq)

data Behavior =
    NormalBehavior {
      requires :: Maybe Expr,
      assignable :: [String],
      ensures :: [Expr]
    }
  | ExceptionalBehavior {
      requires :: Maybe Expr,
      signals :: String,
      assignable :: [String],
      ensures :: [Expr]
    }
  deriving (Show,Eq)

data Clause =
    Requires Expr
  | Ensures Expr
  | LoopInvariant Expr
  | Signals String Expr
  | Assignable [String]
  deriving (Show,Eq)

data Method = Method {
  name      :: String,
  behaviors :: [Behavior]
} deriving (Show,Eq)

data JMLState = JMLState {
  method    :: Method,
  jmlStack  :: [Clause],
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
  -- a global variable has been reassigned
  -- this results in an entry in `Assignable`, and entry in `ensures`
  | ER_VarName_Global_Reassigned String SYT.SymbolicExecutionValue
  | ER_VarName_Skipped String SYT.SymbolicExecutionValue
  | ER_ReturnException Behavior
  | ER_Return Behavior
  | ER_ReturnVoid
  | ER_Actions Expr
  | ER_IfThenElse (Expr,Method) (Maybe (Expr,Method)) (Bool,Bool)
  deriving (Show,Eq)
