{-# Language FlexibleInstances, LambdaCase #-} -- to enable instancing MonadFail (Either String)
module SymbolicExecution.Types where

import qualified SymbolicExecution.Logs.Log as Log
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer
import qualified Parser.Types as AST
import qualified CFG.Types as CFGT (CFG, NodeID, Node, ScopeRange, Node_Coor, Kind)
import qualified Data.Map as Map (Map)
import Text.Printf (printf)
import Data.List (intercalate)

type SymbolicExecutionMonad =
    ExceptT String (ReaderT (Config,[CFGT.CFG]) (WriterT [Log.Log] (State SymState)))
----------
----------
----------
    
newtype MethodProcessor = MethodProcessor {
  methodProcessorMonad :: SymbolicExecutionMonad ExecutionResult
}

----------

data SymStateKey = MethodHandle
                 | GlobalVars | FormalParms | VarBindings | VarAssignments
                 | VarName String | ScopeRange CFGT.ScopeRange | LoopFailure
                 | LoopConditions CFGT.ScopeRange
                 | Return | Exception | Actions
                 deriving (Eq,Ord,Show)

type SymStateEnv = Map.Map SymStateKey SymExpr
data SymState = SymState
 { env :: SymStateEnv
 , logHeader :: Log.Header
 }
 deriving (Eq,Show)

{-
In short, every element of pc becomes a clause in your requires or loop_invariant, and every binding in your final env becomes an equation in your ensures. That’s exactly how symbolic execution wires into JML inference.
-}

-- | Global settings for symbolic execution
data Config = Config
  { iterationMaxBound :: Int              -- ^ max number of loop iterations
  }

defaultConfig :: Config
defaultConfig = Config 20

-- | A binary operator in our symbolic language
data SymBinOp
  = Add      -- ^ +
  | Sub      -- ^ -
  | Mul      -- ^ *
  | Div      -- ^ /
  | Mod
  | Eq       -- ^ ==
  | Neq      -- ^ /=
  | Lt       -- ^ <
  | Le       -- ^ <=
  | Gt       -- ^ >
  | Ge       -- ^ >=
  | And      -- ^ logical &&
  | Or       -- ^ logical ||
  deriving (Eq, Show)

{-
ExecutionResult is used to transform data from a monadic transformer to another.

visitExpr sends data to visitExpr, visitStmt, visitNode

visitExpr ==> NumberLiteral: ER_Expr
visitExpr ==> StringLiteral: ER_Expr
ER_FunCall encapsulates the state of a function call which posseses actual parameters.
visitExpr ==> FunCallExpr ==> function without parameters: ER_Expr
visitExpr ==> FunCallExpr ==> function with parameters: ER_FunCall
visitExpr ==> BinOpExpr: ER_Expr
visitExpr ==> AssignExpr: ER_SymStateMapEntry
visitExpr ==> VarExpr ==> no object access: ER_SymStateMapEntry
visitExpr ==> VarExpr ==> object access: ER_Expr
visitExpr ==> ExcpExpr: ER_Expr SException
visitExpr ==> ArrayInstantiationExpr: ER_Expr 
visitExpr ==> ArrayCallExpr: ER_ArrayCallExpr

visitStmt sends data to visitNode (this may change in the future so that it also sends data to visitStmt)

visitStmt ==> ReturnStmt: ER_State or (visitExpr ==> expr)
visitStmt ==> VarStmt: ER_SymStateMapEntry or ER_Expr (look visitExpr ==> VarExpr)
visitStmt ==> AssignStmt: ER_SymStateMapEntry
visitStmt ==> FunCallStmt: ER_PredefinedFunCall

visitNode ==> Entry: ER_State
visitNode ==> End: ER_State
visitNode ==> Node ==> Statement: ER_State
visitNode ==> Node ==> BooleanExpression if ==> SBool: ER_State
visitNode ==> Node ==> BooleanExpression if ==> SBin: ER_Expr SIte
visitNode ==> Node ==> ForInitialization ==> no accumulation variable ==> ER_Triplet
visitNode ==> Node ==> ForStep ==> no statement ==> ER_Void
visitNode ==> Node ==> ForStep ==> yes statement ==> ER_Void

visitForLoop ==> loop can be processed ==> visitForLoop1 ==> ER_ForLoopDone
visitForLoop ==> loop can't be processed ==> visitForLoop2 ==> ER_SymStateMapEntry

visitForLoop2 ==> ER_SymStateMapEntry

visitSymExpr ==> SymFormalParam: ER_SymStateMapEntry
visitSymExpr ==> SBin: ER_SymStateMapEntry
visitSymExpr ==> SymInt: ER_SymStateMapEntry
-}

data ExecutionResult =
    ER_Expr SymExpr
  | ER_Node {er_Node_id :: CFGT.NodeID, nodeName :: String}
  | ER_SymStateMapEntry SymStateKey SymExpr
  | ER_VarExprObjAccess {-object access name-}String {-object access value-}SymExpr
  | ER_ArrayCallExpr {arrayIndexCall :: SymExpr, arrayIndexCallValue :: SymExpr}
  | ER_State SymState
  | ER_Logs [Log.Log]
  | ER_Triplet (ExecutionResult,ExecutionResult,ExecutionResult)
  | ER_FunCall SymState
  | ER_FunHandle SymType String
  | ER_IfCond SymExpr  -- ^ boolean expressions found in if conditions. Its existance in the environment values map means that the ......
  | ER_PredefinedFunCall SymExpr
  | ER_ForLoopDone
  | ER_Void
  | ER_ActualParameterDetected
  deriving Show

data SymExpr =
-- | A (tiny) symbolic expression language
    SMethodHandle SymType String
  | SymNum    Float
  | SymInt    Integer             -- ^ concrete integer literal
  | SymDouble Double              -- ^ concrete double literal
  | SymFloat  Float               -- ^ concrete float literal
  | SBool   Bool                  -- ^ concrete Boolean literal
  | SymString String
  | SObjAcc [String]
  | SBin    SymExpr SymBinOp SymExpr  -- ^ binary operation
  | SNot    SymExpr               -- ^ logical negation
  | SIte    SymExpr SymStateEnv (Maybe SymStateEnv)   -- ^ if-then-else (cond, then, else)

  | SLoop   (Maybe CFGT.Node) (Maybe AST.Expression) [CFGT.Node] -- Loop acc, Loop condition, and loop body. the loop step is the last node in the body
  | SLoopConditions [Map.Map String SymExpr]
  | SLoopFailure CFGT.ScopeRange Int

  | SymNull SymType               -- ^ value of an unassigned variable
  | SymVar SymType String
  | SymFun DefinedFun SymExpr
  | SVarBindings (Map.Map String CFGT.Node_Coor)
  | SVarAssignments [(String,(SymExpr,CFGT.Node_Coor))] 
  | SException SymType String String
  | SActions [SymExpr]
  | SArrayIndexAccess SymType String SymExpr
  | SymArray (Maybe SymType) (Maybe SymExpr) [SymExpr]
  | SymUnknown SymExpr [SymReason]
  | SFormalParms [String]
  | SGlobalVars [String]
  deriving (Eq,Show)

type SymReason = ([(CFGT.Kind,CFGT.ScopeRange)],Int)

data SymType = Int | Double | Float | Bool | Void | Array SymType | String 
             | UnknownGlobalVarSymType
             | UnknownNumSymType deriving (Show,Eq)

instance MonadFail (Either String) where
  fail = Left

predefinedFuns :: [String]
predefinedFuns = ["toString","print","println"]

data DefinedFun = ToString | Print | Println | UserDefined String deriving (Show,Eq)

toDefinedFun :: String -> DefinedFun
toDefinedFun = \case
  "toString" -> ToString
  "print"    -> Print
  "println"  -> Println
  str        -> UserDefined str
