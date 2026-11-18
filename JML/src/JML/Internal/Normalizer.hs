{-# Language MultiWayIf, LambdaCase, ScopedTypeVariables #-}
module JML.Internal.Normalizer where

import Prelude hiding (negate)
import Control.Monad (foldM,liftM)
import Control.Monad.Writer
import Control.Monad.Reader (ReaderT,ask,runReaderT)
import Control.Monad.State (State,get,modify,runState)
import Control.Monad.Except (throwError,runExceptT)
import Text.Printf (printf)
import Data.List
import Data.Functor (($>))
import Data.Foldable (forM_)
import Data.Traversable (forM)
import qualified Data.Map as Map

import JML.Types
import JML.PrettyPrint (ppBehavior, ppBehaviors, ppColoredClauses)
import qualified JML.Logs.Log as Log
import qualified JML.Types as SYT

combinePreconditions :: Maybe Expr -> Maybe Expr -> Maybe Expr
combinePreconditions mPre1 mPre2 = case (mPre1,mPre2) of
  (Nothing,Nothing) -> Nothing
  (Nothing,Just pre2) -> Just pre2
  (Just pre1,Nothing) -> Just pre1
  (Just pre1,Just pre2) -> let
    combined = JMLBin pre1 And pre2 in if
    | pre2 `isRedundantDueTo` pre1 -> Just pre1
    | otherwise -> Just combined
  {-(Just pre1,Just pre2) -> let
    combined = JMLBin pre1 op pre2
    nubbed = nubPreConditions combined
    in Just nubbed-}

isRedundantDueTo :: Expr -> Expr -> Bool
isRedundantDueTo newExpr oldExpr = let
  loc = "JML.Internal.Normalizer.isRedundantDueTo"
  isAnd = (`elem` [And,NonFlattableAnd])
  logContents = [
    ("oldExpr",show oldExpr),
    ("newExpr",show newExpr)] in equalBoolExprs newExpr oldExpr ||
    case (oldExpr,newExpr) of
      ----------
      (JMLBin expr1 op expr2,expr3)
        | isAnd op ->
            {-case op of
              NonFlattableAnd ->
                error $ printf "MEOW:\n\
                  \  expr1: %s\n\
                  \  expr2: %s\n\
                  \  expr3: %s\n\
                  \  p1: %s\n\
                  \  p2: %s"
                  (show expr1) (show expr2) (show expr3)
                  (show $ isRedundantDueTo expr1 expr3) (show $ isRedundantDueTo expr2 expr3)
              _ ->-} isRedundantDueTo expr3 expr1 || isRedundantDueTo expr3 expr2
        | otherwise -> equalBoolExprs oldExpr newExpr{-
        | otherwise -> error $ printf "TODO in %s:\n\
            \  1) %s\n\
            \  2) %s" loc (show oldExpr) (show newExpr)-}

equalBoolExprs :: Expr -> Expr -> Bool
equalBoolExprs expr_fst expr_snd = let
  loc = "JML.Internal.Internal.equalBoolExprs"
  logContents = [("expr_fst",show expr_fst),("expr_snd",show expr_snd)]
  p (e1,e2) (e3,e4) = equalBoolExprs e1 e2 && equalBoolExprs e3 e4 in
  case (expr_fst,expr_snd) of
    -- > 	a > b , b < a
    (JMLBin expr1 Gt expr2,JMLBin expr3 Lt expr4) ->
      p (expr1,expr4) (expr2,expr3)
    -- >=	a >= b , b <= a
    (JMLBin expr1 Ge expr2,JMLBin expr3 Le expr4) ->
      p (expr1,expr4) (expr2,expr3)
    -- <	a < b , b > a
    (JMLBin expr1 Lt expr2,JMLBin expr3 Gt expr4) ->
      p (expr1,expr4) (expr2,expr3)
    -- <=	a <= b , b >= a
    (JMLBin expr1 Le expr2,JMLBin expr3 Ge expr4) ->
      p (expr1,expr4) (expr2,expr3)
    -- ==	a == b , b == a
    (JMLBin expr1 Eq expr2,JMLBin expr3 Eq expr4) ->
      p (expr1,expr4) (expr2,expr3)
    -- /=	a /= b , b /= a
    (JMLBin expr1 Neq expr2,JMLBin expr3 Neq expr4) ->
      p (expr1,expr4) (expr2,expr3)
    --
    _ -> expr_fst == expr_snd

nubPreConditions :: Expr -> Expr
nubPreConditions expr = let
  loc = "JML.Internal.Internal.nubPreConditions"
  isAnd = (`elem` [And,NonFlattableAnd]) in
  case expr of
    JMLBin expr1 op expr2
      | expr1 == expr2 -> expr
    ---------- a && (b && c)
    JMLBin expr1 op1 right@(JMLBin expr2 op2 expr3)
      | -- a && (a && b) == a && b
        all isAnd [op1,op2] &&
        expr1 == expr2 -> nubPreConditions right
      | -- a && (b && a) == b && a
        all isAnd [op1,op2] &&
        expr1 == expr3 -> nubPreConditions right
    ---------- (a && b) && c
    JMLBin left@(JMLBin expr1 op1 expr2) op2 expr3
      | -- (a && b) && a == a && b
        all isAnd [op1,op2] &&
        expr1 == expr3 -> nubPreConditions left
      | -- (b && a) && a == b && a
        all isAnd [op1,op2] &&
        expr2 == expr3 -> nubPreConditions left
    ---------- a && (b || c)
    JMLBin expr1 op1 right@(JMLBin expr2 Or expr3)
      | -- a && (a || b) == a || b
        isAnd op1 &&
        expr1 == expr2 -> nubPreConditions right
      | -- a && (b || a) == b || a
        isAnd op1 &&
        expr1 == expr3 -> nubPreConditions right
    ---------- (a || b) && c
    JMLBin left@(JMLBin expr1 Or expr2) op2 expr3
      | -- (a || b) && a
        isAnd op2 &&
        expr1 == expr3 -> nubPreConditions left
      | -- (b || a) && a
        isAnd op2 &&
        expr2 == expr3 -> nubPreConditions left
    ---------- a || (b || c)
    JMLBin expr1 Or right@(JMLBin expr2 Or expr3)
      | -- a || (a || b)
        expr1 == expr2 -> nubPreConditions right
      | -- a || (b || a)
        expr1 == expr3 -> nubPreConditions right
    ----------
    _ -> expr

