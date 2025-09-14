{-# Language LambdaCase #-}
{-# Language FlexibleInstances #-} -- to enable instancing MonadFail (Either String)
module SymbolicExecution.Types where

import qualified Data.Map as Map
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer
import qualified Parser.Types as AST (Types)
import qualified CFG.Types as CFGT (CFG)
import Text.Printf (printf)
import Data.List (foldl')

type R =
    ReaderT (Config,[CFGT.CFG])         -- solver endpoints, thresholds…
    (ExceptT String (WriterT [Log] (StateT SymState (Either String)))) -- env :: Map Var SymExpr; pc :: [SymExpr]
    ExecutionResult

newtype SymExec = SymExec R

data Log = Expression_2_Handle String String
         | MethodStart String String
         | MethodEnd String
         | Void String
         | ReturnStatement String String
         | Edge_2_Handle String String
         | Meow String String
         | Node_2_Handle String String
         | HorizontalLine String
         | MethodStatement String
         | AssignStatement String String
         | NewVariable String String String
         | UpdateVariable String String
         | Assign String String String
         | LookUpEnvTable String String String

instance Show Log where
  show = \case
    MethodEnd loc               -> printf "(%s): Method End" loc
    Void loc                    -> printf "(%s): Void" loc
    MethodStart str loc         -> printf "(%s): Method Start: %s" loc str
    MethodStatement str         -> printf "(%s): Method Statement" str
    Expression_2_Handle str loc -> printf "(%s): handling expression: %s" loc str
    ReturnStatement str loc     -> printf "(%s): handling return statement: %s" loc str
    AssignStatement str loc     -> printf "(%s): handling return statement: %s" loc str
    Edge_2_Handle str loc       -> printf "(%s): running CFG: %s" loc str
    Meow str1 str2              -> printf "Meow: %s %s" str1 str2
    HorizontalLine str          -> printf ">>>>>>>>>> %s <<<<<<<<<<" str
    NewVariable tn vn loc       -> printf "(%s): %s %s" loc tn vn
    UpdateVariable vn loc       -> printf "(%s): %s" loc vn
    Assign left right loc       -> printf "(%s): Assigning %s = %s" loc left right
    LookUpEnvTable key val loc  -> printf "(%s): Look up in environmane table (%s ~~> %s) " loc key val

ppLogs :: [Log] -> [String]
ppLogs = snd . foldl' enumerated (1,[])
  where
  enumerated :: (Int,[String]) -> Log -> (Int,[String])     
  enumerated (num,res) log@(HorizontalLine _) = (num,res ++ [show log])
  enumerated (num,res) x = (num+1,res ++ [printf "%d) %s" num (show x)])

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

data ExecutionResult = ER_Expr SymExpr | ER_Key {key :: String} | ER_Void deriving (Eq, Show)
data SymExpr =
-- | A (tiny) symbolic expression language
    SymVar    String              -- ^ symbolic variable, e.g. "x" or "tmp1"
  | SymNum    Float
  | SymInt    Integer             -- ^ concrete integer literal
  | SymDouble Double              -- ^ concrete double literal
  | SymFloat  Float               -- ^ concrete float literal
  | SBool   Bool                  -- ^ concrete Boolean literal
  | SBin    SymBinOp SymExpr SymExpr  -- ^ binary operation
  | SNot    SymExpr               -- ^ logical negation
  | SIte    SymExpr SymExpr SymExpr   -- ^ if-then-else (cond, then, else)
  | SymNull
  deriving (Eq, Show)

instance MonadFail (Either String) where
  fail = Left
