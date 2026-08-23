module JML.Types where

import qualified Data.Map as Map (Map)
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer

import qualified SymbolicExecution.Types as SYT (
  SymbolicExecution,SymbolicExecutionValue,SymType,
  LoopSummary,LoopPattern,LoopSummaryTag,LoopExitFact)
import qualified CFG.Types as CFGT (Node_Coor, ScopeRange)
import qualified JML.Logs.Log as Log (Log, Header)

data Op = Add | Sub | Mul | Div | Gt | Ge | Lt | Le | Eq | Neq | Mod
        | And | NonFlattableAnd -- And, NonFlattableAnd are technically the same.
                                -- the difference can be seen in
                                --   JML.PrettyPrint.unflattenPreConditions
        | Or
        deriving (Show,Eq)

data JMLType = String_Type | Int_Type | Num_Type | Double_Type | Bool_Type | Unknown_Type
             | Array_Type JMLType
             deriving (Show,Eq)

data Expr = JMLVar JMLType String | JMLVarUnknown [CFGT.ScopeRange] JMLType String Expr
          | JMLInt Int | JMLDouble Double | JMLNum Float | JMLBool Bool
          | JMLString String | JMLNull JMLType
          | JMLBin Expr Op Expr | JMLNot Expr | JMLOld Expr
          | Expr `JMLEquals` Expr | Expr `JMLNotEquals` Expr | Expr `JMLImplies` Expr
          | JMLRange String Expr Expr
          | JMLResult Expr | JMLActions [Expr]
          | JMLException JMLType String String
          | JMLObjAcc [String] | JMLArrayIndexAccess JMLType String Expr
          | JMLArray (Maybe JMLType) (Maybe Expr) [Expr]
          | SymFun DefinedFun Expr
          | JMLVoid {- this is made to be coupled with `JMLResult` -}
          deriving (Show,Eq)


data DefinedFun = ToString | Print | Println | UserDefined String deriving (Show,Eq)

data Behavior =
    NormalBehavior {
      behaviorScopeRange :: Maybe CFGT.ScopeRange,
      requires :: Maybe Expr,
      assignable :: [String],
      vars :: [Expr],
      hasSideEffect :: Bool,
      ensures :: [Expr]
    }
  | ExceptionalBehavior {
      behaviorScopeRange :: Maybe CFGT.ScopeRange,
      requires :: Maybe Expr,
      signals :: String,
      assignable :: [String],
      vars :: [Expr],
      hasSideEffect :: Bool,
      ensures :: [Expr]
    }
  deriving (Show,Eq)

------------------------------------------------

data LoopInvariantTemplate
  = Maintaining Maintaining_LoopInvariantTemplate
  | LoopAssigns LoopAssigns_LoopInvariantTemplate
  | Decreases Decreases_LoopInvariantTemplate
  deriving (Show,Eq)
{-
data LoopInvariantTemplate
  = CounterBoundsTemplate Expr String Expr
  | StridedCounterTemplate
      String  -- counter
      Expr    -- stride
      Expr    -- residue
  | LoopFrameTemplate [String]
  | DecreasesTemplate Expr
  deriving (Show, Eq)
  -}

data Maintaining_LoopInvariantTemplate
  = CounterBoundsTemplate Expr String Expr
  | StridedCounterTemplate
      String  -- counter
      Expr    -- stride
      Expr    -- residue
  | MovingBoundRelationTemplate String Expr
  | CounterLowerBoundTemplate Expr String
  | GuardedInvariantTemplate Expr Expr
  deriving (Show, Eq)

data LoopAssigns_LoopInvariantTemplate
  = LoopFrameTemplate [String]
  deriving (Show, Eq)

data Decreases_LoopInvariantTemplate
  = DecreasesTemplate Expr
  deriving (Show, Eq)

------------------------------------------------

data LoopInvariants = LoopInvariants {
  loopScopeRange :: CFGT.ScopeRange,
  loopClauses :: [LoopInvariantTemplate]
} deriving (Show,Eq)

data JMLSpecification =
    MethodSpecification Behavior
  | LoopSpecification LoopInvariants
  deriving (Show,Eq)

data Clause = Requires (Maybe CFGT.ScopeRange,Maybe Expr) [ClauseValue]
            deriving (Show,Eq)

data ClauseValue =
    Ensures Expr
  | LoopInvariant Expr
  | Signals String Expr
  | Assignable [String]
  | VarAssignment (JMLType,String,Expr)
  | VarInRange (JMLType,String,(Expr,Expr))
  | Implication Expr ClauseValue
  | HasSideEffect
  deriving (Show,Eq)


data Method = Method {
  name              :: String,
  jmlSpecifications :: [JMLSpecification]
} deriving (Show,Eq)

data JMLState = JMLState {
  method    :: Method,
  jmlStack  :: [Clause],
  logHeader :: Log.Header,
  formalParms :: [String],
  localVars :: [String],
  globalVars :: [String],
  reAssigned :: [String],
  pathCreationEnumeration :: Int
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
  | ER_IfThenElse (Maybe String,CFGT.ScopeRange)
           (Expr,JMLState,[ExecutionResult]) (Maybe (Expr,JMLState,[ExecutionResult]))
  | ER_LoopConditions CFGT.ScopeRange [Map.Map String SYT.SymbolicExecutionValue]
  | ER_ArrayAccess [(
       Either SYT.SymbolicExecutionValue (SYT.SymType,String,SYT.SymbolicExecutionValue)
      ,Maybe (SYT.SymType,String,SYT.SymbolicExecutionValue)
      ,Either SYT.SymbolicExecutionValue (SYT.SymType,String,SYT.SymbolicExecutionValue)
      )]
  | ER_LoopSummary CFGT.ScopeRange [LoopInvariantTemplate] SYT.LoopSummary
  deriving (Show,Eq)
