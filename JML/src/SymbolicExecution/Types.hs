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

type R =
    ReaderT (Config,[CFGT.CFG])         -- solver endpoints, thresholds…
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String)))) -- env :: Map Var SymExpr; pc :: [SymExpr]
    ExecutionResult

newtype SymExec = SymExec R

getReader :: SymExec -> R
getReader (SymExec r) = r

data SymState = SymState
 { env :: Map.Map String SymExpr
 , pc  :: [SymExpr]          -- ^ Path‐conditions: accumulate the conditions under which each execution state is feasible.
 }
 deriving Show

getReturnSymExpr :: SymState -> SymExpr
getReturnSymExpr symState = case Map.lookup "return" $ env symState of
  Just symExpr -> symExpr
  Nothing      -> error "won't happen, because this function is only called on SymStates with a return Statement."

getBinSymExpr :: (SymExpr, SymExpr) -> AST.BinOp -> SymExpr
getBinSymExpr (SymNum num1, SymNum num2) op =
  SymNum (getFractionalArithBinOp op num1 num2)
--error $ show $ SymNum (getFractionalArithBinOp op num1 num2)
getBinSymExpr (SymInt num1, SymInt num2) op =
  SymInt (getIntegralArithBinOp op num1 num2)
getBinSymExpr (SymDouble num1, SymDouble num2) op =
  SymDouble (getFractionalArithBinOp op num1 num2)
getBinSymExpr (SymFloat num1, SymFloat num2) op =
  SymFloat (getFractionalArithBinOp op num1 num2)
getBinSymExpr (SymNum num1, SymInt num2) op =
  SymInt (getIntegralArithBinOp op (round num1) num2)
getBinSymExpr (SymNum num1, SymDouble num2) op =
  SymDouble (getFractionalArithBinOp op (toDouble num1) num2)
getBinSymExpr (SymNum num1, SymFloat num2) op =
  SymFloat (getFractionalArithBinOp op num1 num2)
getBinSymExpr (symExpr, SymNum num2) op = getBinSymExpr (SymNum num2, symExpr) op

toDouble :: Float -> Double
toDouble = read . show

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
visitExpr ==> FunCallExpr: ER_Expr
visitExpr ==> BinOpExpr: ER_Expr
visitExpr ==> AssignExpr: ER_SymStateMapEntry
visitExpr ==> VarExpr: ER_SymStateMapEntry

visitStmt sends data to visitNode (this may change in the future so that it also sends data to visitStmt)

visitStmt ==> ReturnStmt: ER_Void (this will change to ER_Node)
visitStmt ==> AssignStmt: ER_Void (this will change to ER_Node)
visitStmt ==> VarStmt: ER_Void (this will change to ER_Node)
-}
data ExecutionResult =
    ER_Expr SymExpr
  | ER_Node {id :: CFGT.NodeID, nodeName :: String}
  | ER_SymStateMapEntry {symStateKey :: String, symStateVal :: SymExpr}
  | ER_State SymState
  | ER_Void
  deriving Show

data SymExpr =
-- | A (tiny) symbolic expression language
    SymNum    Float
  | SymInt    Integer             -- ^ concrete integer literal
  | SymDouble Double              -- ^ concrete double literal
  | SymFloat  Float               -- ^ concrete float literal
  | SBool   Bool                  -- ^ concrete Boolean literal
  | SBin    SymBinOp SymExpr SymExpr  -- ^ binary operation
  | SNot    SymExpr               -- ^ logical negation
  | SIte    SymExpr SymExpr SymExpr   -- ^ if-then-else (cond, then, else)
  | SymNull SymType               -- ^ value of an unassigned variable
  deriving Show

data SymType = Int | Double | Float | Bool | Void deriving Show

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

-- getBinSymExpr :: (SymExpr, SymExpr) -> AST.BinOp -> SymExpr
-- data BinOp = Plus | Mult | Minus | Div | Mod | Less | LessEq | Greater | GreaterEq | Eq | Neq | And | Or
cast :: SymType -> SymExpr -> SymExpr
cast symType symExpr = case symExpr of
  SymNum _ -> case symType of
                Int    -> getBinSymExpr (symExpr, SymInt 0) AST.Plus
                Double -> getBinSymExpr (symExpr, SymDouble 0) AST.Plus
                Float  -> getBinSymExpr (symExpr, SymFloat 0) AST.Plus
                Bool   -> error "won't happen"
                Void   -> error "won't happen"
  a -> a

instance MonadFail (Either String) where
  fail = Left
