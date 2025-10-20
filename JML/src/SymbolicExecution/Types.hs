{-# Language LambdaCase #-}
{-# Language FlexibleInstances #-} -- to enable instancing MonadFail (Either String)
module SymbolicExecution.Types where

import qualified SymbolicExecution.Log as Log
import qualified Data.Map as Map
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer
import qualified Parser.Types as AST
import qualified CFG.Types as CFGT (CFG, NodeID)

type Method_R =
    ReaderT (Config,[CFGT.CFG])
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))))
    ExecutionResult

type FormalParm = String
type ActualParm_post_Execution = ExecutionResult
type MethodCall_R =
    ReaderT (Config,[(FormalParm, ActualParm_post_Execution)])
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
 deriving Show

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

toSymBinOp :: AST.BinOp -> SymBinOp
toSymBinOp AST.Plus = Add
toSymBinOp AST.Mult = Mul
toSymBinOp AST.Minus = Sub
toSymBinOp AST.Div = Div
toSymBinOp _ = error "toSymBinOp ~~> TODO"

{-
ExecutionResult is used to transform data from a monadic transformer to another.

visitExpr sends data to visitExpr, visitStmt, visitNode

visitExpr ==> NumberLiteral: ER_Expr
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

ER_FunCall encapsulates the state of a function call which posseses actual parameters.
visitExpr ==> FunCallExpr ==> function with parameters: ER_FunCall

insertActualParams ==> SymFormalParam: SymActualParam
-}
data ExecutionResult =
    ER_Expr SymExpr
  | ER_Node {id :: CFGT.NodeID, nodeName :: String}
  | ER_SymStateMapEntry {symStateKey :: String, symStateVal :: SymExpr}
  | ER_State SymState
  | ER_FunCall SymState
  | ER_Formal_2_Actual {formal :: String, actual :: SymExpr}
  | ER_Formal_Unchanged SymExpr
  | ER_Void
  deriving Show

data SymExpr =
-- | A (tiny) symbolic expression language
    SymNum    Float
  | SymInt    Integer             -- ^ concrete integer literal
  | SymDouble Double              -- ^ concrete double literal
  | SymFloat  Float               -- ^ concrete float literal
  | SBool   Bool                  -- ^ concrete Boolean literal
  | SBin    SymExpr SymBinOp SymExpr  -- ^ binary operation
  | SNot    SymExpr               -- ^ logical negation
  | SIte    SymExpr SymExpr SymExpr   -- ^ if-then-else (cond, then, else)
  | SymNull SymType               -- ^ value of an unassigned variable
  | SymFormalParam SymType String (Maybe SymExpr) -- ^ declared variable (a formal parameter)
  | SymGlobalVar SymType String   -- ^ variable declared outside the scope of the method
  deriving Show

data SymType = Int | Double | Float | Bool | Void deriving Show

isFormalParameter :: SymExpr -> Bool
isFormalParameter (SymFormalParam _ _ _) = True
isFormalParameter _ = False

isGlobalVariable :: SymExpr -> Bool
isGlobalVariable (SymGlobalVar _ _) = True
isGlobalVariable _ = False

-- get SymType via AST.Type
toSymType1 :: AST.Type AST.Types -> SymType
toSymType1 (AST.BuiltInType t) = case t of
  AST.Int     -> Int
  AST.Void    -> Void
  AST.Char    -> undefined
  AST.String  -> undefined
  AST.Boolean -> Bool
  AST.Double  -> Double
  AST.Short   -> undefined
  AST.Float   -> Float
  AST.Long    -> undefined
  AST.Byte    -> undefined

-- get SymType via SymExpr
toSymType2 :: SymExpr -> SymType
toSymType2 (SymInt _) = Int
toSymType2 (SymDouble _) = Double
toSymType2 (SymFloat _) = Float
toSymType2 (SBool _) = Bool
toSymType2 (SymNull t) = t
toSymType2 (SymFormalParam t _ _) = t
toSymType2 (SymGlobalVar t _) = t

getReturnSymExpr :: SymState -> Maybe SymExpr
getReturnSymExpr symState = Map.lookup "return" $ env symState

instance MonadFail (Either String) where
  fail = Left
