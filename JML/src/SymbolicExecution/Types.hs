{-# Language FlexibleInstances, LambdaCase #-} -- to enable instancing MonadFail (Either String)
module SymbolicExecution.Types where

import qualified SymbolicExecution.Log as Log
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer
import qualified Parser.Types as AST
import qualified CFG.Types as CFGT (CFG, NodeID)
import qualified Data.Map as Map (Map)
import Text.Printf (printf)

type Method_R =
    ReaderT (Config,[CFGT.CFG])
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))))
    ExecutionResult

type FormalParm = (SymType,String)
type ActualParm_post_Visitation = ExecutionResult
type MethodCall_R =
    ReaderT (Config,[(FormalParm, ActualParm_post_Visitation)])
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))))
    ExecutionResult

newtype Method_SymExec = Method_SymExec Method_R

newtype MethodCall_SymExec = MethodCall_SymExec MethodCall_R

getReader_Method_R :: Method_SymExec -> Method_R
getReader_Method_R (Method_SymExec r) = r

getReader_MethodCall_R :: MethodCall_SymExec -> MethodCall_R
getReader_MethodCall_R (MethodCall_SymExec r) = r

data SymState = SymState
 { env :: Map.Map String SymExpr
 , pc  :: [SymExpr]          -- ^ Path‐conditions: accumulate the conditions under which each execution state is feasible.
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
defaultConfig = Config 50

-- | A binary operator in our symbolic language
data SymBinOp
  = Add      -- ^ +
  | Sub      -- ^ -
  | Mul      -- ^ *
  | Div      -- ^ /
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
ER_FunCall encapsulates the state of a function call which posseses actual parameters.
visitExpr ==> FunCallExpr ==> function without parameters: ER_Expr
visitExpr ==> FunCallExpr ==> function with parameters: ER_FunCall
visitExpr ==> BinOpExpr: ER_Expr
visitExpr ==> AssignExpr: ER_SymStateMapEntry
visitExpr ==> VarExpr: ER_SymStateMapEntry

visitStmt sends data to visitNode (this may change in the future so that it also sends data to visitStmt)

visitStmt ==> ReturnStmt: ER_State
visitStmt ==> AssignStmt: ER_State
visitStmt ==> VarStmt: ER_State
visitStmt ==> AssignStmt: ER_State

visitNode ==> Entry: ER_State
visitNode ==> End: ER_State
visitNode ==> Node: ER_State

visitSymExpr ==> SymFormalParam: ER_SymStateMapEntry
visitSymExpr ==> SBin: ER_SymStateMapEntry
visitSymExpr ==> SymInt: ER_SymStateMapEntry
-}
data ExecutionResult =
    ER_Expr SymExpr
  | ER_Node {er_Node_id :: CFGT.NodeID, nodeName :: String}
  | ER_SymStateMapEntry {er_key :: String, er_val :: SymExpr}
  | ER_State SymState
  | ER_FunCall SymState
  | ER_FunHandle SymType String
  | ER_IfCond SymExpr  -- ^ boolean expressions found in if conditions. Its existance in the environment values map means that the ......
  | ER_Void
  deriving Show

data SymExpr =
-- | A (tiny) symbolic expression language
    SMethodType SymType
  | SymNum    Float
  | SymInt    Integer             -- ^ concrete integer literal
  | SymDouble Double              -- ^ concrete double literal
  | SymFloat  Float               -- ^ concrete float literal
  | SBool   Bool                  -- ^ concrete Boolean literal
  | SBin    SymExpr SymBinOp SymExpr  -- ^ binary operation
  | SNot    SymExpr               -- ^ logical negation
  | SIte    SymExpr (Maybe SymState) (Maybe SymState)   -- ^ if-then-else (cond, then, else)
  | SymNull SymType               -- ^ value of an unassigned variable
  | SymFormalParam SymType String (Maybe SymExpr) -- ^ declared variable (a formal parameter)
  | SymGlobalVar SymType String (Maybe SymExpr) -- ^ variable declared outside the scope of the method
  deriving (Eq,Show)

ppSymExpr :: SymExpr -> String
ppSymExpr = \case
  SymNum num -> show num
  SymInt num -> show num
  SymDouble num -> show num
  SymFloat  num -> show num
  SBool b -> show b
  SBin e1 op e2 -> printf "(%s) %s (%s)" (ppSymExpr e1) (show op) (ppSymExpr e2)
  SNot e -> printf "!(%s)" (ppSymExpr e)
  SIte _ _ _ -> undefined
  SymNull t -> undefined
  SymFormalParam t s m -> maybe s ppSymExpr m
  SymGlobalVar t s m -> maybe s ppSymExpr m

data SymType = Int | Double | Float | Bool | Void | Array SymType deriving (Show,Eq)

instance MonadFail (Either String) where
  fail = Left
