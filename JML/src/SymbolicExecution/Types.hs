{-# Language FlexibleInstances, LambdaCase #-} -- to enable instancing MonadFail (Either String)
module SymbolicExecution.Types where

import qualified SymbolicExecution.Log as Log
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer
import qualified Parser.Types as AST
import qualified CFG.Types as CFGT (CFG, NodeID, Node)
import qualified Data.Map as Map (Map)
import Text.Printf (printf)
import Data.List (intercalate)

type Method_R =
    ReaderT (Config,[CFGT.CFG])
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))))
    ExecutionResult

type FormalParm = (SymType,String)
type ActualParm_post_Visitation = ExecutionResult
type MethodName = String
type MethodCall_R =
    ReaderT (Config,MethodName,[(FormalParm, ActualParm_post_Visitation)])
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))))
    ExecutionResult

newtype Method_SymExec = Method_SymExec Method_R

newtype MethodCall_SymExec = MethodCall_SymExec MethodCall_R

getReader_Method_R :: Method_SymExec -> Method_R
getReader_Method_R (Method_SymExec r) = r

getReader_MethodCall_R :: MethodCall_SymExec -> MethodCall_R
getReader_MethodCall_R (MethodCall_SymExec r) = r

data SymStateKey = MethodName String
                 | GlobalVars | FormalParms | VarBindings | VarAssignments
                 | BranchRange BranchRange | VarName String
                 | Return | Exception | Actions
                 deriving (Eq,Ord,Show)
{-
instance Ord SymStateKey where
  x <= y = case (x,y) of
    (NodeNr q,NodeNr w) -> q <= w
    (NodeNr _,VarName _) -> False
    (NodeNr _,VarBindings) -> False
    (NodeNr _,GlobalVars) -> False
    (NodeNr _,FormalParms) -> False
    (NodeNr _,Return) -> True
    (NodeNr _,MethodName _) -> False
    (NodeNr _,Exception) -> True
    (NodeNr _,Actions) -> True

    (VarName _,NodeNr _) -> True
    (VarName q,VarName w) -> q <= w
    (VarName _,VarBindings) -> False
    (VarName _,GlobalVars) -> False
    (VarName _,FormalParms) -> False
    (VarName _,Return) -> True
    (VarName _,MethodName _) -> False
    (VarName _,Exception) -> True
    (VarName _, Actions) -> True

    (VarBindings,NodeNr _) -> True
    (VarBindings,VarName _) -> True
    (VarBindings,VarBindings) -> True
    (VarBindings,GlobalVars) -> False
    (VarBindings,FormalParms) -> False
    (VarBindings,Return) -> True
    (VarBindings,MethodName _) -> False
    (VarBindings,Exception) -> True
    (VarBindings,Actions) -> True

    (Return,NodeNr _) -> False
    (Return,VarName _) -> False
    (Return,VarBindings) -> False
    (Return,GlobalVars) -> False
    (Return,FormalParms) -> False
    (Return,Return) -> True
    (Return,MethodName _) -> False
    (Return,Exception) -> True
    (Return,Actions) -> True

    (MethodName _,NodeNr _) -> True
    (MethodName _,VarName _) -> True
    (MethodName _,VarBindings) -> True
    (MethodName _,GlobalVars) -> True
    (MethodName _,FormalParms) -> True
    (MethodName _,Return) -> True
    (MethodName q,MethodName w) -> q <= w
    (MethodName _,Exception) -> True
    (MethodName _,Actions) -> True

    (Exception,NodeNr _) -> False
    (Exception,VarName _) -> False
    (Exception,VarBindings) -> False
    (Exception,GlobalVars) -> False
    (Exception,FormalParms) -> False
    (Exception,Return) -> True
    (Exception,MethodName _) -> False
    (Exception,Exception) -> True
    (Exception,Actions) -> True

    (Actions,NodeNr _) -> False
    (Actions,VarName _) -> False
    (Actions,VarBindings) -> False
    (Actions,FormalParms) -> False
    (Actions,GlobalVars) -> False
    (Actions,Return) -> False
    (Actions,MethodName _) -> False
    (Actions,Exception) -> False
    (Actions,Actions) -> True

    (GlobalVars,NodeNr _) -> True
    (GlobalVars,VarName _) -> True
    (GlobalVars,VarBindings) -> True
    (GlobalVars,FormalParms) -> True
    (GlobalVars,GlobalVars) -> True
    (GlobalVars,Return) -> True
    (GlobalVars,MethodName _) -> False
    (GlobalVars,Exception) -> True
    (GlobalVars,Actions) -> True

    (FormalParms,NodeNr _) -> True
    (FormalParms,VarName _) -> True
    (FormalParms,VarBindings) -> True
    (FormalParms,FormalParms) -> True
    (FormalParms,GlobalVars) -> False
    (FormalParms,Return) -> True
    (FormalParms,MethodName _) -> False
    (FormalParms,Exception) -> True
    (FormalParms,Actions) -> True
-}
data SymState = SymState
 { env :: Map.Map SymStateKey SymExpr
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

visitStmt ==> ReturnStmt: ER_State
visitStmt ==> AssignStmt: ER_State
visitStmt ==> VarStmt: ER_State
visitStmt ==> AssignStmt: ER_State
visitStmt ==> FunCallStmt: ER_Print

visitNode ==> Entry: ER_State
visitNode ==> End: ER_State
visitNode ==> Node ==> Statement: ER_State
visitNode ==> Node ==> BooleanExpression if ==> SBool: ER_State
visitNode ==> Node ==> BooleanExpression if ==> SBin: ER_Expr SIte
visitNode ==> Node ==> ForInitialization ==> no accumulation variable ==> ER_Triplet

visitSymExpr ==> SymFormalParam: ER_SymStateMapEntry
visitSymExpr ==> SBin: ER_SymStateMapEntry
visitSymExpr ==> SymInt: ER_SymStateMapEntry
-}
data ExecutionResult =
    ER_Expr SymExpr
  | ER_Node {er_Node_id :: CFGT.NodeID, nodeName :: String}
  | ER_SymStateMapEntry {er_key :: SymStateKey, er_val :: SymExpr}
  | ER_ArrayCallExpr {arrayIndexCall :: SymExpr, arrayIndexCallValue :: SymExpr}
  | ER_State SymState
  | ER_Logs [Log.Log]
  | ER_Triplet (ExecutionResult,ExecutionResult,ExecutionResult)
  | ER_FunCall SymState
  | ER_FunHandle SymType String
  | ER_IfCond SymExpr  -- ^ boolean expressions found in if conditions. Its existance in the environment values map means that the ......
  | ER_Print String
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
  | SymString String
  | SObjAcc [String]
  | SBin    SymExpr SymBinOp SymExpr  -- ^ binary operation
  | SNot    SymExpr               -- ^ logical negation
  | SIte    SymExpr SymState (Maybe SymState)   -- ^ if-then-else (cond, then, else)
  | SLoop   (Maybe CFGT.Node) CFGT.Node [CFGT.Node] -- Loop acc, Loop condition, and loop body. the loop step is the last node in the body
  | SymNull SymType               -- ^ value of an unassigned variable
  | SymFormalParam SymType String (Maybe SymExpr) -- ^ declared variable (a formal parameter)
  | SymGlobalVar SymType String (Maybe SymExpr) -- ^ variable declared outside the scope of the method
  | SVarBindings (Map.Map String Node_Coor)
  | SVarAssignments [(String,Node_Coor)] 
  | SException String String
  | SActions [String]
  | SArrayIndexAccess String SymExpr
  | SymArray (Maybe SymType) (Maybe Int) [SymExpr]
  | SymVar String
  | SFormalParms [String]
  | SGlobalVars [String]
  deriving (Eq,Show)

data Node_Coor = Node_Coor
  { varDeclAt :: Int
  , varFrame  :: Int
  } deriving (Eq,Show)

data BranchRange = BR
  { branchStart :: Int
  , branchEnd :: Int
  } deriving (Eq,Ord,Show)

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
  SymArray _ _ elems -> printf "[%s]" $ intercalate ", " (map ppSymExpr elems)

data SymType = Int | Double | Float | Bool | Void | Array SymType | String deriving (Show,Eq)

instance MonadFail (Either String) where
  fail = Left

predefinedFuns :: [String]
predefinedFuns = ["toString","print","println"]
