module JML.Types where

import qualified Data.Map as Map (Map)
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer

import qualified SymbolicExecution.Types as SYT (
  SymbolicExecution,SymbolicExecutionValue)
import qualified CFG.Types as CFGT (Node_Coor, ScopeRange)
import qualified JML.Logs.Log as Log (Log, Header)

data Op = Add | Sub | Mul | Div | Gt | Ge | Lt | Le | Eq | Neq
        deriving (Show,Eq)

data JMLType = String_Type | Int_Type | Num_Type | Double_Type | Bool_Type | Unknown_Type
             | Array_Type JMLType
             deriving (Show,Eq)

data Expr = JMLVar JMLType String | JMLVarUnknown JMLType String | JMLInt Int | JMLDouble Double | JMLNum Float | JMLBool Bool
          | JMLString String | JMLNull JMLType
          | JMLBin Expr Op Expr | JMLNot Expr | JMLOld Expr | Expr `JMLAnd` Expr
          | Expr `JMLEquals` Expr | JMLResult Expr | JMLActions [Expr]
          | JMLException JMLType String String
          | JMLObjAcc [String] | JMLArrayIndexAccess JMLType String Expr
          | JMLArray (Maybe JMLType) (Maybe Expr) [Expr]
          | SymFun DefinedFun Expr
          | JMLVoid {- this is made to be coupled with `JMLResult` -}
          deriving (Show,Eq)

data DefinedFun = ToString | Print | Println | UserDefined String deriving (Show,Eq)

data Behavior =
    NormalBehavior {
      scopeRange :: Maybe CFGT.ScopeRange,
      requires :: Maybe Expr,
      assignable :: [String],
      vars :: [Expr],
      hasSideEffect :: Bool,
      ensures :: [Expr]
    }
  | ExceptionalBehavior {
      scopeRange :: Maybe CFGT.ScopeRange,
      requires :: Maybe Expr,
      signals :: String,
      assignable :: [String],
      vars :: [Expr],
      hasSideEffect :: Bool,
      ensures :: [Expr]
    }
  deriving (Show,Eq)

data Clause = Requires (Maybe CFGT.ScopeRange,Maybe Expr) [ClauseValue]
            deriving (Show,Eq)

data ClauseValue =
    Ensures Expr
  | LoopInvariant Expr
  | Signals String Expr
  | Assignable [String]
  | VarAssignment (JMLType,String,Expr)
  | HasSideEffect
  deriving (Show,Eq)

data Method = Method {
  name      :: String,
  behaviors :: [Behavior]
} deriving (Show,Eq)

data JMLState = JMLState {
  method    :: Method,
  jmlStack  :: [Clause],
  logHeader :: Log.Header,
  formalParms :: [String],
  localVars :: [String],
  globalVars :: [String]
} deriving (Show,Eq)

type JMLMonad =
  ExceptT String (ReaderT (Map.Map String SYT.SymbolicExecution)
                          (WriterT [Log.Log] (State JMLState)))

newtype MethodProcessor = MethodProcessor {
  methodProcessorMonad :: JMLMonad ExecutionResult
}

data ExecutionResult =
    ER_Void
  | ER_GlobalVars [String]
  | ER_FormalParms [String]
  | ER_VarAssignments [(String,(SYT.SymbolicExecutionValue,CFGT.Node_Coor))]
  | ER_VarBindings (Map.Map String CFGT.Node_Coor)
  -- a global variable has been reassigned
  -- this results in an entry in `Assignable`, and entry in `ensures`
  | ER_VarName_Global_Reassigned String SYT.SymbolicExecutionValue (Maybe (CFGT.ScopeRange,Expr))
  | ER_VarName String SYT.SymbolicExecutionValue (Maybe (CFGT.ScopeRange,Expr))
  | ER_VarName_Unassigned String SYT.SymbolicExecutionValue (Maybe (CFGT.ScopeRange,Expr))
  | ER_ReturnException String
  | ER_Return SYT.SymbolicExecutionValue
  | ER_ReturnVoid
  | ER_Actions Expr
  | ER_IfThenElse CFGT.ScopeRange
           (Expr,JMLState,[ExecutionResult]) (Maybe (Expr,JMLState,[ExecutionResult]))
  deriving (Show,Eq)
