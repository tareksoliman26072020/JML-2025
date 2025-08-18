module SymbolicExecution.Types where

import qualified Data.Map as Map
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import qualified Parser.Types as AST (Types)
import qualified CFG.Types as CFGT (CFG)

type SymExec a =
   ReaderT (Config,[CFGT.CFG])         -- solver endpoints, thresholds…
   (ExceptT String (State SymState)) a -- env :: Map Var SymExpr; pc :: [SymExpr]

data SymState = SymState
 { env :: Map.Map String SymExpr
 , methodType :: AST.Types
 , pc  :: [SymExpr]          -- ^ Path‐conditions: accumulate the conditions under which each execution state is feasible.
 }
 deriving Show

getReturnSymExpr :: SymState -> SymExpr
getReturnSymExpr symState = case Map.lookup "return" $ env symState of
  Just symExpr -> symExpr
  Nothing      -> error "won't happen, because this function is only called on SymStates with a return Statement."
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

-- | A (tiny) symbolic expression language
data SymExpr
  = SVar    String                -- ^ symbolic variable, e.g. "x" or "tmp1"
  | SymNum    Float
  | SymInt    Integer             -- ^ concrete integer literal
  | SymDouble Double              -- ^ concrete double literal
  | SymFloat  Float               -- ^ concrete float literal
  | SBool   Bool                  -- ^ concrete Boolean literal
  | SBin    SymBinOp SymExpr SymExpr  -- ^ binary operation
  | SNot    SymExpr               -- ^ logical negation
  | SIte    SymExpr SymExpr SymExpr   -- ^ if-then-else (cond, then, else)
  deriving (Eq, Show)

