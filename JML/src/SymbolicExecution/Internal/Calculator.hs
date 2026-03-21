{-# Language LambdaCase #-}
module SymbolicExecution.Internal.Calculator (numericCalculator, booleanCalculator, objAccCalculator, stringCalculator, funCallCalculator, whichCalculator, whichCalculator2) where

import SymbolicExecution.Types
import Data.Maybe
import qualified Parser.Types as AST (BinOp(..))
import Control.Applicative ((<|>))
import Text.Printf (printf)
import Prelude hiding (abs,negate)
import qualified Prelude (abs)
import SymbolicExecution.Internal.Internal
import SymbolicExecution.Types
import qualified Data.Map as Map (Map,lookup)
import Data.List (intercalate)

numericCalculator :: SymExpr -> SymExpr
numericCalculator = \case
  SBin e1 op e2 ->
    let calculating = numericCalculator2 op (e1,e2)
    in case calculating of
         SBin e1_ op_ e2_
           | calculating == SBin e1 op e2 -> SBin e1 op e2
           | otherwise -> numericCalculator $ SBin e1_ op_ e2_
         e -> e
  e -> e

booleanCalculator :: SymExpr -> SymExpr
booleanCalculator = \case
  SBin e1 op e2 ->
    let calculating = booleanCalculator2 op (e1,e2)
    in case calculating of
         SBin e1_ op_ e2_
           | calculating == SBin e1 op e2 -> SBin e1 op e2
           | otherwise -> booleanCalculator $ SBin e1_ op_ e2_
         e -> e
  e -> e

-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------

numericCalculator2 :: SymBinOp -> (SymExpr, SymExpr) -> SymExpr
numericCalculator2 op = \case
  (SymNum num1, SymNum num2) ->
    SymNum (getFractionalArithBinOp op num1 num2)
  (SymInt num1, SymInt num2) ->
    SymInt (getIntegralArithBinOp op num1 num2)
  (SymDouble num1, SymDouble num2) ->
    SymDouble (getFractionalArithBinOp op num1 num2)
  (SymFloat num1, SymFloat num2) ->
    SymFloat (getFractionalArithBinOp op num1 num2)
  -- Multiplication with 0
  (SymInt 0, _) | op == Mul -> SymInt 0
  (_, SymInt 0) | op == Mul -> SymInt 0
  (SymDouble 0, _) | op == Mul -> SymDouble 0
  (_, SymDouble 0) | op == Mul -> SymDouble 0
  (SymFloat 0, _) | op == Mul -> SymFloat 0
  (_, SymFloat 0) | op == Mul -> SymFloat 0
  (a@(SymNum 0), b) | op == Mul -> cast (toSymType2 b) a
  (a, b@(SymNum 0)) | op == Mul -> cast (toSymType2 a) b
  -- Multiplication with 1
  (a@(SymInt 1), b) | op == Mul -> cast (toSymType2 a) b
  (a, b@(SymInt 1)) | op == Mul -> cast (toSymType2 b) a
  (a@(SymDouble 1), b) | op == Mul -> cast (toSymType2 a) b
  (a, b@(SymDouble 1)) | op == Mul -> cast (toSymType2 b) a
  (a@(SymFloat 1), b) | op == Mul -> cast (toSymType2 a) b
  (a, b@(SymFloat 1)) | op == Mul -> cast (toSymType2 b) a
  (a@(SymNum 1), b) | op == Mul -> b
  (a, b@(SymNum 0)) | op == Mul -> a
  -- Addition with 0
  (SymInt 0, b) | op == Add -> cast Int b
  (a, SymInt 0) | op == Add -> cast Int a
  (SymDouble 0, b) | op == Add -> cast Double b
  (a, SymDouble 0) | op == Add -> cast Double a
  (SymFloat 0, b) | op == Add -> cast Float b
  (a, SymFloat 0) | op == Add -> cast Double a
  (a@(SymNum 0), b) | op == Add -> b
  (a, b@(SymNum 0)) | op == Add -> a
  -- Substraction with 0
  (a@(SymInt 0), b) | op == Sub ->
    let num = cast Int b
    in negate num
  (a, SymInt 0) | op == Sub -> cast Int a
  (SymDouble 0, b) | op == Sub ->
    let num = cast Double b
    in negate num
  (a, SymDouble 0) | op == Sub -> cast Double a
  (a@(SymFloat 0), b) | op == Sub ->
    let num = cast Float b
    in negate num
  (a, SymFloat 0) | op == Sub -> cast Float a
  (a@(SymNum 0), b) | op == Sub -> negate b
  (a, b@(SymNum 0)) | op == Sub -> a
  -- arithmetics on vars
  (a@(SymVar t1 varName1),b@(SymVar t2 varName2))
    | op == Add && varName1 == varName2 ->
        let t3 = pick_known_symType (t1,t2)
        in SBin (cast t3 $ SymNum 2) Mul a
    | op == Sub && varName1 == varName2 -> 
        let t3 = pick_known_symType (t1,t2)
        in cast t3 (SymNum 0)
----------
  (SymNum num1, SymInt num2) ->
    SymInt (getIntegralArithBinOp op (round num1) num2)
  (SymInt num1, SymNum num2) ->
    SymInt (getIntegralArithBinOp op num1 (round num2))
----------
  (SymNum num1, SymDouble num2) ->
    SymDouble (getFractionalArithBinOp op (toDouble num1) num2)
  (SymDouble num1, SymNum num2) ->
    SymDouble (getFractionalArithBinOp op num1 (toDouble num2))
----------
  (SymNum num1, SymFloat num2) ->
    SymFloat (getFractionalArithBinOp op num1 num2)
  (SymFloat num1, SymNum num2) ->
    SymFloat (getFractionalArithBinOp op num1 num2)
----------
-- determine SymType and cast it on the other SymExprs.
-- if not found, then java syntactical error,
--     which will not happen, because safety of type checking is assumed.
--
--
  (a@(SBin _ _ _), b@(SBin _ _ _)) ->
    let a2 = numericCalculator a
        b2 = numericCalculator b
    in case (a2,b2) of
         (_, SBin e21 op2 e22)
           | op == Add && op2 == Mul && (not . isVar) e21 && isNegative e21 ->
               numericCalculator $ SBin a2 Sub (SBin (abs e21) op2 e22)
           | op == Add && op2 == Mul && (not . isVar) e22 && isNegative e22 ->
               numericCalculator $ SBin a2 Sub (SBin e21 op2 (abs e22))
         (SBin e11 op1 e12, SBin e21 op2 e22)
             -- (x op1 e12) op (x op2 e22)
           | all (`elem` [Add,Sub]) [op1,op,op2]
             && all isVar [e11,e21] && getVarName e11 == getVarName e21 ->
               -- (x - e12) - (x - e22) == (x - x) - (e12 - e22)
               -- (x + e12) - (x - e22) == (x - x) + (e12 + e22)
               -- (x + e12) + (x - e22) == (x + x) + (e12 - e22)
               -- (x + e12) + (x + e22) == (x + x) + (e12 + e22)
               -- (x - e12) + (x + e22) == (x + x) - (e12 - e22)
               -- (x - e12) - (x + e22) == (x - x) - (e12 + e22)
               -- (x + e12) - (x + e22) == (x - x) + (e12 - e22)
               -- (x - e12) + (x - e22) == (x + x) - (e12 + e22)
               numericCalculator $ SBin (SBin e11 op e21)
                                 op1
                                 (SBin e12 (multiplyOps (multiplyOps op1 op) op2) e22)
           ------------------------------------------------------
             -- (x op1 e12) op (e21 op2 x)
           | all (`elem` [Add,Sub]) [op1,op,op2]
             && all isVar [e11,e22] && getVarName e11 == getVarName e22 ->
               -- (x - e12) - (e21 - x) == (x + x) - (e21 + e12)
               -- (x + e12) - (e21 - x) == (x + x) - (e21 - e12)
               -- (x + e12) + (e21 - x) == (x - x) + (e21 + e12)
               -- (x + e12) + (e21 + x) == (x + x) + (e21 + e12)
               -- (x - e12) + (e21 + x) == (x + x) + (e21 - e12)
               -- (x - e12) - (e21 + x) == (x - x) - (e21 + e12)
               -- (x + e12) - (e21 + x) == (x - x) - (e21 - e12)
               -- (x - e12) + (e21 - x) == (x - x) + (e21 - e12)
               numericCalculator $ SBin (SBin e11 (multiplyOps op op2) e22)
                                 op
                                 (SBin e21 (multiplyOps op1 op) e12)
           ------------------------------------------------------
             -- (e11 op1 x) op (x op2 e22)
           | all (`elem` [Add,Sub]) [op1,op,op2]
             && all isVar [e12,e21] && getVarName e12 == getVarName e21 ->
               -- (e11 - x) - (x - e22) == (e11 + e22) - (x + x)
               -- (e11 + x) - (x - e22) == (e11 + e22) - (x - x)
               -- (e11 + x) + (x - e22) == (e11 - e22) + (x + x)
               -- (e11 + x) + (x + e22) == (e11 + e22) + (x + x)
               -- (e11 - x) + (x + e22) == (e11 + e22) + (x - x)
               -- (e11 - x) - (x + e22) == (e11 - e22) - (x + x)
               -- (e11 + x) - (x + e22) == (e11 - e22) - (x - x)
               -- (e11 - x) + (x - e22) == (e11 - e22) + (x - x)
               numericCalculator $ SBin (SBin e11 (multiplyOps op op2) e22)
                                 op
                                 (SBin e21 (multiplyOps op1 op) e12)
           ------------------------------------------------------
             -- (e11 op1 x) op (e21 op2 x)
           | all (`elem` [Add,Sub]) [op1,op,op2]
             && all isVar [e12,e22] && getVarName e12 == getVarName e22 ->
               -- (e11 - x) - (e21 - x) == (e11 - e21) - (x - x)
               -- (e11 + x) - (e21 - x) == (e11 - e21) + (x + x)
               -- (e11 + x) + (e21 - x) == (e11 + e21) + (x - x)
               -- (e11 + x) + (e21 + x) == (e11 + e21) + (x + x)
               -- (e11 - x) + (e21 + x) == (e11 + e21) - (x - x)
               -- (e11 - x) - (e21 + x) == (e11 - e21) - (x + x)
               -- (e11 + x) - (e21 + x) == (e11 - e21) + (x - x)
               -- (e11 - x) + (e21 - x) == (e11 + e21) - (x + x)
               numericCalculator $ SBin (SBin e11 op e21)
                                 op1
                                 (SBin e12 (multiplyOps (multiplyOps op1 op) op2) e22)
           | all (`elem` [Add,Sub]) [op1,op,op2] ->
               SBin a2 op b2
           ------------------------------------------------------
           -- (e11 - e12) * (e21 + e22) == (e11 * (e21 + e22)) - (e12 * (e21 + e22))
           | op `elem` [Mul,Div] && op1 `elem` [Add,Sub] && op2 `elem` [Add,Sub] &&
             (all (not . isVar) [e11,e21] ||
              all (not . isVar) [e11,e22] ||
              all (not . isVar) [e12,e21] ||
              all (not . isVar) [e12,e22]) ->
                numericCalculator $ SBin (SBin e11 op (SBin e21 op2 e22))
                                  op1
                                  (SBin e12 op (SBin e21 op2 e22))
           -- (e11 - e12) * (e21 op2 e22) == (e11 * (e21 op2 e22)) - (e12 * (e21 op2 e22))
           -- (2 - 3) * (4 * 5) == (2 * (4 * 5)) - (3 * (4 * 5))
           | op `elem` [Mul,Div] && op1 `elem` [Add,Sub] &&
             (all (not . isVar) [e11,e21] ||
              all (not . isVar) [e11,e22] ||
              all (not . isVar) [e12,e21] ||
              all (not . isVar) [e12,e22]) ->
                numericCalculator $ SBin (SBin e11 op (SBin e21 op2 e22))
                                  op1
                                  (SBin e12 op (SBin e21 op2 e22))
           -- (e11 op1 e12) * (e21 - e22) == ((e11 op1 e12) * e21) - ((e11 op1 e12) * e22)
           -- (2 * 3) * (4 - 5) == ((2 * 3) * 4) - ((2 * 3) * 5)
           | op `elem` [Mul,Div] && op2 `elem` [Add,Sub] &&
             (all (not . isVar) [e11,e21] ||
              all (not . isVar) [e11,e22] ||
              all (not . isVar) [e12,e21] ||
              all (not . isVar) [e12,e22]) ->
                numericCalculator $ SBin (SBin (SBin e11 op1 e12) op e21)
                                  Sub
                                  (SBin (SBin e11 op1 e12) op e22)
           -- (e11 op1 e12) * (e21 op2 e22) == ((e11 op1 e12) * e21) * e22
           -- (2 * 3) * (4 * 5) == ((2 * 3) * 4) * 5 
           | op `elem` [Mul,Div] ->
               numericCalculator $ SBin (SBin (SBin e11 op1 e12) op e21)
                                 op
                                 e22
           ---------------------------------------------------------------
           -- (e11 * X) op (e21 * X) = (e11 op e21) * X
           | op `elem` [Add,Sub] && all (== Mul) [op1,op2]
             && all isVar [e12,e22] && getVarName e12 == getVarName e22 ->
               numericCalculator $ SBin (SBin e11 op e21)
                                 Mul
                                 e12
           -- (e11 * X) op (X * e22) = (e11 op e22) * X
           | op `elem` [Add,Sub] && all (== Mul) [op1,op2]
             && all isVar [e12,e21] && getVarName e12 == getVarName e21 ->
               numericCalculator $ SBin (SBin e11 op e22)
                                 Mul
                                 e12 
           -- (X * e12) op (e21 * X) = (e12 op e21) * X
           | op `elem` [Add,Sub] && all (== Mul) [op1,op2]
             && all isVar [e11,e22] && getVarName e11 == getVarName e22 ->
               numericCalculator $ SBin (SBin e12 op e21)
                                 Mul
                                 e11
           -- (X * e12) op (X * e22) == (e12 op e22) * X
           | op `elem` [Add,Sub] && all (== Mul) [op1,op2]
             && all isVar [e11,e21] && getVarName e11 == getVarName e21 ->
               numericCalculator $ SBin (SBin e12 op e22)
                                 Mul
                                 e11
           ---------------------------------------------------------------
           -- (e11 * X) op (e21 - X) == (a (op*-) e22) op e21
           -- (2x) + (3 - x) = ((2-1) * X) + 3 = X + 3
           | op `elem` [Add,Sub] && op1 == Mul && op2 `elem` [Add,Sub]
             && all isVar [e12,e22] && getVarName e12 == getVarName e22 ->
               numericCalculator $ SBin (numericCalculator $ SBin a (multiplyOps op op2) e22)
                                 op
                                 e21
           -- (e11 * X) op (X - e22) == (a op e21) (op*-) e22
           | op `elem` [Add,Sub] && op1 == Mul && op2 `elem` [Add,Sub]
             && all isVar [e12,e21] && getVarName e12 == getVarName e21 ->
               numericCalculator $ SBin (numericCalculator $ SBin a op e21)
                                 (multiplyOps op op2)
                                 e22
           -- (X * e12) op (X - e22) == ((e12 * e11) op e21) (op*-) e22
           | op `elem` [Add,Sub] && op1 == Mul && op2 `elem` [Add,Sub]
             && all isVar [e11,e21] && getVarName e11 == getVarName e21 ->
               numericCalculator $ SBin (numericCalculator $ SBin (SBin e21 Mul e11) op e21)
                                 (multiplyOps op op2)
                                 e22
           -- (X * e12) op (e21 - X) == ((e12 * e11) (op*-) e22) op e21
           | op `elem` [Add,Sub] && op1 == Mul && op2 `elem` [Add,Sub]
             && all isVar [e11,e22] && getVarName e11 == getVarName e22 ->
               numericCalculator $ SBin (numericCalculator $ SBin (SBin e12 Mul e11)
                                                    (multiplyOps op op2)
                                                    e22)
                                 op
                                 e21
           ---------------------------------------------------------------
           -- (e11 op1 X) op (e21 * X) == e11 op1 (e12 op1*op b)
           -- (e11 + X) - (e21 * X) == e11 + (X - b)
           -- (e11 - X) - (e21 * X) == e11 - (X + b)
           -- (e11 + X) + (e21 * X) == e11 + (X + b)
           -- (e11 - X) + (e21 * X) == e11 - (X - b)
           | op `elem` [Add,Sub] && op2 == Mul && op1 `elem` [Add,Sub]
             && all isVar [e12,e22] && getVarName e12 == getVarName e22 ->
               numericCalculator $ SBin e11
                                 op1
                                 (numericCalculator $ SBin e12
                                                           (multiplyOps op1 op)
                                                           b)
           -- (e11 op1 X) op (X * e22) == e11 op1 (e12 op1*op (e22 * e21))
           | op `elem` [Add,Sub] && op2 == Mul && op1 `elem` [Add,Sub]
             && all isVar [e12,e21] && getVarName e12 == getVarName e21 ->
               numericCalculator $ SBin e11
                                        op1
                                        (numericCalculator $ SBin e12
                                                                  (multiplyOps op1 op)
                                                                  (SBin e22 Mul e21))
           -- (X op1 e12) op (X * e22) == (op1 e12) + (e11 op (e22 * e21))
           -- (X + e12) + (X * e22) == e12  + (X + e22*X) == (op1 e12) + (e11 op e22*e21)
           -- (X - e12) + (X * e22) == -e12 + (X + e22*X) == (op1 e12) + 
           -- (X + e12) - (X * e22) == e12  + (X - e22*X) == (op1 e12) + 
           -- (X - e12) - (X * e22) == e12  + (X - e22*X) == (op1 e12) + 
           | op `elem` [Add,Sub] && op2 == Mul && op1 `elem` [Add,Sub]
             && all isVar [e11,e21] && getVarName e11 == getVarName e21 ->
               numericCalculator $ SBin (numericCalculator $ SBin (newSymNum op1) Mul e12)
                                        Add
                                        (numericCalculator $ SBin e11 op (SBin e22 Mul e21))
           -- (X op1 e12) op (e21 * X) == (op1 e12) + (e11 op e21*e22)
           -- (X + e12) + (e21 * X) == e12 + (X + e21*X) == (op1 e12) + (e11 + e21*e22)
           -- (X - e12) + (e21 * X) == 
           -- (X + e12) - (e21 * X) == 
           -- (X - e12) - (e21 * X) == 
           | op `elem` [Add,Sub] && op2 == Mul && op1 `elem` [Add,Sub]
             && all isVar [e11,e22] && getVarName e11 == getVarName e22 ->
               numericCalculator $ SBin (numericCalculator $ SBin (newSymNum op1) Mul e12)
                                        Add
                                        (numericCalculator $ SBin e11
                                                                  op
                                                                  (SBin e21 Mul e22))
           ---------------------------------------------------------------
         _ -> SBin a2 op b2
---------- commutative events
  (a@(SBin symExpr1 op1 symExpr2), b)
    ---------- (i op1 1) op 2
    | isVar symExpr1 && all (not . isVar) [symExpr2,b]
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op1,op) of
      -- (i + 1) + 2 == i + (1+2)
      (Add,Add) -> numericCalculator $ SBin symExpr1 Add (SBin symExpr2 Add b)
      -- (i - 1) - 2 == i - (1 + 2)
      (Sub,Sub) -> numericCalculator $ SBin symExpr1 Sub (SBin symExpr2 Add b)
      -- (i + 1) - 2 == i + (1 - 2)
      (Add,Sub) -> numericCalculator $ SBin symExpr1 Add (SBin symExpr2 Sub b)
      -- (i - 1) + 2 == i - (1 - 2)
      (Sub,Add) -> numericCalculator $ SBin symExpr1 Sub (SBin symExpr2 Sub b)
      -- (i * 2) * 3 == i * (2 * 3)
      (Mul,Mul) -> numericCalculator $ SBin symExpr1 Mul (SBin symExpr2 Mul b)
      -- (i / 2) / 3 == i / (2 * 3)
      (Div,Div) -> numericCalculator $ SBin symExpr1 Div (SBin symExpr2 Mul b)
      -- (i * 2) / 3 == i * (2 / 3)
      (Mul,Div) -> numericCalculator $ SBin symExpr1 Mul (SBin symExpr2 Div b)
      -- (i / 2) * 3 == i * (3 / 2)
      (Div,Mul) -> numericCalculator $ SBin symExpr1 Mul (SBin b Div symExpr2)
    ---------- (1 op1 i) op 2
    | all (not . isVar) [symExpr1,b] && isVar symExpr2
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op1,op) of
      -- (1 + i) + 2 == (1 + 2) + i
      (Add,Add) -> 
        let calc = numericCalculator $ SBin (SBin symExpr1 Add b) Add symExpr2
        in calc
      -- (1 - i) - 2 == (1 - 2) - i
      (Sub,Sub) -> numericCalculator $ SBin (SBin symExpr1 Sub b) Sub symExpr2
      -- (1 + i) - 2 == (1 - 2) + i
      (Add,Sub) -> numericCalculator $ SBin (SBin symExpr1 Sub b) Add symExpr2
      -- (1 - i) + 2 == (1 + 2) - i
      (Sub,Add) -> numericCalculator $ SBin (SBin symExpr1 Add b) Sub symExpr2
      -- (2 * i) * 3 == (2 * 3) * i
      (Mul,Mul) -> numericCalculator $ SBin (SBin symExpr1 Mul b) Mul symExpr2
      -- (2 / i) / 3 == (2 / 3) / i
      (Div,Div) -> numericCalculator $ SBin (SBin symExpr1 Div b) Div symExpr2
      -- (2 * i) / 3 == (2 / 3) * i
      (Mul,Div) -> numericCalculator $ SBin (SBin symExpr1 Div b) Mul symExpr2
      -- (2 / i) * 3 == (2 * 3) / i
      (Div,Mul) -> numericCalculator $ SBin (SBin symExpr1 Mul b) Div symExpr2
    ---------- PART 1/2 (? is number or var): (x op1 ?) op x, ? = symExpr2
    | all isVar [symExpr1,b] && getVarName symExpr1 == getVarName b
      && ((isVar symExpr2 && getVarName symExpr2 /= getVarName symExpr1)
          || (not $ isVar symExpr2))
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op1,op) of
        -- (x + ?) + x == (x + x) + ?
        (Add,Add) -> numericCalculator $ SBin (SBin symExpr1 Add b) Add symExpr2
        -- (x + ?) - x == (x - x) + ?
        (Add,Sub) -> numericCalculator $ SBin (SBin symExpr1 Sub b) Add symExpr2
        -- (x - ?) + x == (x + x) - ?
        (Sub,Add) -> numericCalculator $ SBin (SBin symExpr1 Add b) Sub symExpr2
        -- (x - ?) - x == (x - x) - ?
        (Sub,Sub) -> numericCalculator $ SBin (SBin symExpr1 Sub b) Sub symExpr2
        -- (x * ?) * x == (x * x) * ?
        (Mul,Mul) -> numericCalculator $ SBin (SBin symExpr1 Mul b) Mul symExpr2
        -- (x * ?) / x == (x / x) * ?
        (Mul,Div) -> numericCalculator $ SBin (SBin symExpr1 Div b) Mul symExpr2
        -- (x / ?) * x == (x * x) / ?
        (Div,Mul) -> numericCalculator $ SBin (SBin symExpr1 Mul b) Div symExpr2
        -- (x / ?) / x == (x / x) / ?
        (Div,Div) -> numericCalculator $ SBin (SBin symExpr1 Div b) Div symExpr2
{-
(SBin (SBin (SymInt 2) Mul (SymFormalParam Int "i" Nothing)) Add (SymInt 9))
(SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2))))
-}
    ---------- PART 2/2 (? == number): (x op1 ?) op x, ? = symExpr2
    | all isVar [symExpr1,b] && getVarName symExpr1 == getVarName b
      && (not $ isVar symExpr2)
      && ((op1,op) `elem` [(Mul,Add),(Mul,Sub),(Div,Add),(Div,Sub)]) -> case (op1,op) of
        -- (x * 3) + x == (3 + 1) * x
        (Mul,Add) -> numericCalculator $ SBin (SBin symExpr2 Add (SymNum 1)) Mul symExpr1
        -- (x * 3) - x == (3 - 1) * x
        (Mul,Sub) -> numericCalculator $ SBin (SBin symExpr2 Sub (SymNum 1)) Mul symExpr1
        -- (x / 3) + x == (1/3 + 1) * x
        (Div,Add) -> numericCalculator $ SBin (SBin (SBin (SymNum 1) Div symExpr2) Add (SymNum 1)) Mul symExpr1
        -- (x / 3) - x == (1/3 - 1) * x
        (Div,Sub) -> numericCalculator $ SBin (SBin (SBin (SymNum 1) Div symExpr2) Sub (SymNum 1)) Mul symExpr1
    ---------- PART 1/2 (? is number or var): (? op1 x) op x, ? = symExpr1
    | all isVar [symExpr2,b] && getVarName symExpr2 == getVarName b
      && ((isVar symExpr1 && getVarName symExpr1 /= getVarName symExpr2)
          || (not $ isVar symExpr1))
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op1,op) of
        -- (? + x) + x == (x + x) + ?
        (Add,Add) -> numericCalculator $ SBin (SBin b Add symExpr2) Add symExpr1
        -- (? - x) - x == ? - (x + x)
        (Sub,Sub) -> numericCalculator $ SBin symExpr1 Sub (SBin symExpr2 Add b)
        -- (? + x) - x == ? + (x - x)
        (Add,Sub) -> numericCalculator $ SBin symExpr1 Add (SBin symExpr2 Sub b)
        -- (? - x) + x == ? + (x - x)
        (Sub,Add) -> numericCalculator $ SBin symExpr1 Add (SBin symExpr2 Sub b)
        -- (? * x) * x == ? * (x * x)
        (Mul,Mul) -> numericCalculator $ SBin symExpr1 Mul (SBin symExpr2 Mul b)
        -- (? / x) / x == ? / (x * x)
        (Div,Div) -> numericCalculator $ SBin symExpr1 Div (SBin symExpr2 Mul b)
        -- (? * x) / x == ? * (x / x)
        (Mul,Div) -> numericCalculator $ SBin symExpr1 Mul (SBin symExpr2 Div b)
        -- (? / x) * x == ? * (x / x)
        (Div,Mul) -> numericCalculator $ SBin symExpr1 Mul (SBin symExpr2 Div b)
    ---------- PART 2/2 (? is number): (? op1 x) op x, ? = symExpr1
    | all isVar [symExpr2,b] && getVarName symExpr2 == getVarName b
      && (not $ isVar symExpr1)
      && ((op1,op) `elem` [(Mul,Add),(Mul,Sub)]) -> case (op1,op) of
        -- (3 * x) + x == (3 + 1) * x
        (Mul,Add) -> numericCalculator $ SBin (SBin symExpr1 Add (SymNum 1)) Mul symExpr2
        -- (3 * x) - x == (3 - 1) * x
        (Mul,Sub) -> numericCalculator $ SBin (SBin symExpr1 Sub (SymNum 1)) Mul symExpr2
    | otherwise -> let
        symType = pick_known_symType (toSymType2 a,toSymType2 b)
        expr1 = numericCalculator2 op1 (cast symType symExpr1,cast symType symExpr2)
        expr2 = cast symType b  
        in SBin expr1 op expr2
----------
  (a, b@(SBin symExpr1 op1 symExpr2))
    | [op,op1] == [Add,Mul] && (not . isVar) symExpr1 && isNegative symExpr1 ->
        numericCalculator $ SBin a Sub (SBin (abs symExpr1) op1 symExpr2)
    | [op,op1] == [Add,Mul] && (not . isVar) symExpr2 && isNegative symExpr2 ->
        numericCalculator $ SBin a Sub (SBin symExpr1 op1 (abs symExpr2))
    ---------- 1 op (i op1 2)
    | all (not . isVar) [a,symExpr2] && isVar symExpr1
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op,op1) of
      -- 1 + (i + 2) == (1 + 2) + i
      (Add,Add) -> numericCalculator $ SBin (SBin a Add symExpr2) Add symExpr1
      -- 1 - (i - 2) == (1 + 2) - i
      (Sub,Sub) -> numericCalculator $ SBin (SBin a Add symExpr2) Sub symExpr1
      -- 1 + (i - 2) == (1 - 2) + i
      (Add,Sub) -> numericCalculator $ SBin (SBin a Sub symExpr2) Add symExpr1
      -- 1 - (i + 2) == (1 - 2) - i
      (Sub,Add) -> numericCalculator $ SBin (SBin a Sub symExpr2) Sub symExpr1
      -- 2 * (i * 3) == (2 * 3) * i
      (Mul,Mul) -> numericCalculator $ SBin (SBin a Mul symExpr2) Mul symExpr1
      -- 2 / (i / 3) == (2 * 3) / i
      (Div,Div) -> numericCalculator $ SBin (SBin a Mul symExpr2) Div symExpr1
      -- 2 * (i / 3) == (2 / 3) * i
      (Mul,Div) -> numericCalculator $ SBin (SBin a Div symExpr2) Mul symExpr1
      -- 2 / (i * 3) == (2 / 3) / i
      (Div,Mul) -> numericCalculator $ SBin (SBin a Div symExpr2) Div symExpr1
    ---------- 1 op (2 op1 i)
    | all (not . isVar) [a,symExpr1] && isVar symExpr2
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op,op1) of
      -- 1 + (2 + i) == (1 + 2) + i
      (Add,Add) -> numericCalculator $ SBin (SBin a Add symExpr1) Add symExpr2
      -- 1 - (2 - i) == (1 - 2) + i
      (Sub,Sub) -> numericCalculator $ SBin (SBin a Sub symExpr1) Add symExpr2
      -- 1 + (2 - i) == (1 + 2) - i
      (Add,Sub) -> numericCalculator $ SBin (SBin a Add symExpr1) Sub symExpr2
      -- 1 - (2 + i) == (1 - 2) - i
      (Sub,Add) -> numericCalculator $ SBin (SBin a Sub symExpr1) Sub symExpr2
      -- 2 * (3 * i) == (2 * 3) * i
      (Mul,Mul) -> numericCalculator $ SBin (SBin a Mul symExpr1) Mul symExpr2
      -- 2 / (3 / i) == (2 / 3) * i
      (Div,Div) -> numericCalculator $ SBin (SBin a Div symExpr1) Mul symExpr2
      -- 2 * (3 / i) == (2 * 3) / i
      (Mul,Div) -> numericCalculator $ SBin (SBin a Mul symExpr1) Div symExpr2
      -- 2 / (3 * i) == (2 / 3) / i
      (Div,Mul) -> numericCalculator $ SBin (SBin a Div symExpr1) Div symExpr2
    ---------- PART 1/2 (? is number or var): X op (X op1 ?), ? = symExpr2
    | all isVar [a,symExpr1] && getVarName a == getVarName symExpr1
      && ((isVar symExpr2 && getVarName symExpr2 /= getVarName symExpr1)
          || (not $ isVar symExpr2))
      && ((op,op1) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op,op1) of
        -- X + (X + Y) == (X + X) + Y
        (Add,Add) -> numericCalculator $ SBin (SBin a Add symExpr1) Add symExpr2
        -- X - (X - Y) == (X - X) + Y
        (Sub,Sub) -> numericCalculator $ SBin (SBin a Sub symExpr1) Add symExpr2
        -- X + (X - Y) == (X + X) - Y
        (Add,Sub) -> numericCalculator $ SBin (SBin a Add symExpr1) Sub symExpr2
        -- X - (X + Y) == (X - X) - Y
        (Sub,Add) -> numericCalculator $ SBin (SBin a Sub symExpr1) Sub symExpr2
        -- X * (X * Y) == (X * X) * Y
        (Mul,Mul) -> numericCalculator $ SBin (SBin a Mul symExpr1) Mul symExpr2
        -- X / (X / Y) == (X / X) * Y
        (Div,Div) -> numericCalculator $ SBin (SBin a Div symExpr1) Mul symExpr2
        -- X * (X / Y) == (X * X) / Y
        (Mul,Div) -> numericCalculator $ SBin (SBin a Mul symExpr1) Div symExpr2
        -- X / (X * Y) == (X / X) / Y
        (Div,Mul) -> numericCalculator $ SBin (SBin a Div symExpr1) Div symExpr2
    ---------- PART 2/2 (? is number): X op (X op1 ?), ? = symExpr2
    | all isVar [a,symExpr1] && getVarName a == getVarName symExpr1
      && (not $ isVar symExpr2)
      && ((op,op1) `elem` [(Add,Mul),(Sub,Mul),(Add,Div),(Sub,Div)]) -> case (op,op1) of
        -- X + (X * 3) == (1 + 3) * X
        (Add,Mul) -> numericCalculator $ SBin (SBin (SymNum 1) Add symExpr2) Mul a
        -- X - (X * 3) == (1 - 3) * X
        (Sub,Mul) -> numericCalculator $ SBin (SBin (SymNum 1) Sub symExpr2) Mul a
        -- X + (X / 3) == (1 + 1/3) * x
        (Add,Div) -> numericCalculator $ SBin (SBin (SymNum 1) Add (SBin (SymNum 1) Div symExpr2)) Mul a
        -- X - (X / 3) == (1 - 1/3) * x
        (Sub,Div) -> numericCalculator $ SBin (SBin (SymNum 1) Sub (SBin (SymNum 1) Div symExpr2)) Mul a
    ---------- PART 1/2 (? is number or var): X op (? op1 X), ? = symExpr1
    | all isVar [a,symExpr2] && getVarName a == getVarName symExpr2
      && ((isVar symExpr1 && getVarName symExpr1 /= getVarName symExpr2) ||
          (not $ isVar symExpr1)
         )
      && ((op,op1) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op,op1) of
        -- X + (Y + X) == (X + X) + Y
        (Add,Add) -> numericCalculator $ SBin (SBin a Add symExpr2) Add symExpr1
        -- X - (Y - X) == (X + X) - Y
        (Sub,Sub) -> numericCalculator $ SBin (SBin a Add symExpr2) Sub symExpr1
        -- X + (Y - X) == (X - X) + Y
        (Add,Sub) -> numericCalculator $ SBin (SBin a Sub symExpr2) Add symExpr1
        -- X - (Y + X) == (X - X) - Y
        (Sub,Add) -> numericCalculator $ SBin (SBin a Sub symExpr2) Sub symExpr1
        -- X * (Y * X) == (X * X) * Y
        (Mul,Mul) -> numericCalculator $ SBin (SBin a Mul symExpr2) Mul symExpr1
        -- X / (Y / X) == (X * X) / Y
        (Div,Div) -> numericCalculator $ SBin (SBin a Mul symExpr2) Div symExpr1
        -- X * (Y / X) == (X / X) * Y
        (Mul,Div) -> numericCalculator $ SBin (SBin a Div symExpr2) Mul symExpr1
        -- X / (Y * X) == (X / X) / Y
        (Div,Mul) -> numericCalculator $ SBin (SBin a Div symExpr2) Div symExpr1
    ---------- PART 2/2 (? is number): X op (? op1 X), ? = symExpr1
    | all isVar [a,symExpr2] && getVarName a == getVarName symExpr2
      && (not $ isVar symExpr1)
      && ((op,op1) `elem` [(Add,Mul),(Sub,Mul)]) -> case (op,op1) of
        -- X + (3 * X) == (1 + 3) * X
        (Add,Mul) -> numericCalculator $ SBin (SBin (SymNum 1) Add symExpr1) Mul a
        -- X - (3 * X) == (1 - 3) * X
        (Sub,Mul) -> numericCalculator $ SBin (SBin (SymNum 1) Sub symExpr1) Mul a
    | otherwise -> let
        symType = pick_known_symType (toSymType2 a,toSymType2 b)
        expr1 = cast symType a
        expr2 = numericCalculator2 op1 (cast symType symExpr1,cast symType symExpr2)
        in SBin expr1 op expr2
----------
  (a, b@(SymVar t _)) ->
    let t3 = pick_known_symType (toSymType2 a,t)
    in SBin (cast t3 a) op (cast t3 b)
  (a@(SymVar t _), b) ->
    let t3 = pick_known_symType (t,toSymType2 b)
    in SBin (cast t3 a) op (cast t3 b)
----------
  (a@(SException _ _ _),b) -> a
  (a,b@(SException _ _ _)) -> b
----------
  (a@(SymUnknown expr _),b) ->
    SBin a op (cast (toSymType2 expr) b)
  (a,b@(SymUnknown expr _)) ->
    SBin (cast (toSymType2 expr) a) op b
----------
  (a@(SymFun _ symExpr1),b@(SymFun _ symExpr2)) ->
    let t3 = pick_known_symType (toSymType2 symExpr1, toSymType2 symExpr2)
    in SBin (cast t3 a) op (cast t3 b)
  (a@(SymFun _ symExpr1),b) ->
    let t3 = pick_known_symType (toSymType2 symExpr1,toSymType2 b)
    in SBin (cast t3 a) op (cast t3 b)
  (a,b@(SymFun _ symExpr2)) ->
    let t3 = pick_known_symType (toSymType2 a,toSymType2 symExpr2)
    in SBin (cast t3 a) op (cast t3 b)
----------
  (a@(SObjAcc _),b) -> SBin a op b
  (a,b@(SObjAcc _)) -> SBin a op b
----------
  (a,b) -> error $ printf "numericCalculator: (%s ,, %s ,, %s)" (show a) (show op) (show b)

isNegative :: SymExpr -> Bool
isNegative = \case
  SymNum num -> num < 0
  SymInt num -> num < 0
  SymDouble num -> num < 0
  SymFloat num -> num < 0
  _ -> error "isNegative: won't happen"

abs :: SymExpr -> SymExpr
abs = \case
  SymNum num -> SymNum $ Prelude.abs num
  SymInt num -> SymInt $ Prelude.abs num
  SymDouble num -> SymDouble $ Prelude.abs num
  SymFloat num -> SymFloat $ Prelude.abs num
  _ -> error "isNegative: won't happen"

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

booleanCalculator2 :: SymBinOp -> (SymExpr, SymExpr) -> SymExpr
booleanCalculator2 op = \case
  (SymNum num1, SymNum num2)
--    | op == Mod = SBool (round num1) `mod` (round num2)
    -> SBool $ getArithBoolOp op num1 num2
  (SymInt num1, SymInt num2) ->
    SBool $ getArithBoolOp op num1 num2
  (SymDouble num1, SymDouble num2) ->
    SBool $ getArithBoolOp op num1 num2
  (SymFloat num1, SymFloat num2) ->
    SBool $ getArithBoolOp op num1 num2
  ----------
  (a@(SymVar t1 _), b@(SymVar t2 _)) ->
    let t3 = pick_known_symType (t1,t2)
    in SBin (cast t3 a) op (cast t3 b)
  (a@(SymVar t1 _), b) ->
    let t3 = pick_known_symType (t1,toSymType2 b)
    in SBin (cast t3 a) op (cast t3 b)
  (a, b@(SymVar t2 _)) ->
    let t3 = pick_known_symType (toSymType2 a,t2)
    in SBin (cast t3 a) op (cast t3 b)
  ----------
  (a@(SObjAcc li), b)
    -> SBin a op (cast (toSymType2 a) b)
  (a, b@(SObjAcc li))
    -> SBin (cast (toSymType2 b) a) op b
  ----------
  (a@(SymNum _),b) ->
    SBin (cast (toSymType2 b) a) op b
  (a,b@(SymNum _)) ->
    SBin a op (cast (toSymType2 a) b)
  ----------
  (a@(SBin _ op1 _),b) ->
    let whichFun
          | isBooleanOperator op1 = booleanCalculator
          | isArithmeticOperator op1 = numericCalculator
        a2 = whichFun a
    in SBin a2 op b
  (a,b@(SBin _ op2 _)) ->
    let whichFun
          | isBooleanOperator op2 = booleanCalculator
          | isArithmeticOperator op2 = numericCalculator
        b2 = whichFun b
    in SBin a op b2
  (a@(SBin _ op1 _),b@(SBin _ op2 _)) ->
    let whichFun theOp
          | isBooleanOperator theOp = booleanCalculator
          | isArithmeticOperator theOp = numericCalculator
        a2 = (whichFun op1) a
        b2 = (whichFun op2) b
    in SBin a2 op b2
  ----------
  (a@(SymFun pf1 expr1),b@(SymFun pf2 expr2))
    | a == b -> a
    | otherwise ->
        let newType
              | any (== ToString) [pf1,pf2] = String
              | otherwise = pick_known_symType (toSymType2 expr1,toSymType2 expr2)
        in SBin (cast newType a) op (cast newType b)
  (a@(SymFun pf expr1),b) ->
    let newType
          | pf == ToString = String
          | otherwise = pick_known_symType (toSymType2 expr1,toSymType2 b)
        in SBin (cast newType a) op (cast newType b)
  (a,b@(SymFun pf expr2)) ->
    let newType
          | pf == ToString = String
          | otherwise = pick_known_symType (toSymType2 a,toSymType2 expr2)
        in SBin (cast newType a) op (cast newType b)
  ----------
  (a@(SArrayIndexAccess (Array t1) arrName1 expr1),
   b@(SArrayIndexAccess (Array t2) arrName2 expr2)) ->
    let t3 = pick_known_symType (t1,t2)
    in SBin (SArrayIndexAccess (Array t3) arrName1 expr1)
            op
            (SArrayIndexAccess (Array t3) arrName2 expr2)
  (a@(SArrayIndexAccess (Array t1) arrName1 expr1),b) ->
    let t3 = pick_known_symType (t1,toSymType2 b)
    in SBin (SArrayIndexAccess (Array t3) arrName1 expr1)
            op
            (cast t3 b)
  (a,b@(SArrayIndexAccess (Array t2) arrName2 expr2)) ->
    let t3 = pick_known_symType (toSymType2 a,t2)
    in SBin (cast t3 a)
            op
            (SArrayIndexAccess (Array t3) arrName2 expr2)
  ----------
  (p1,p2) -> error $ printf "booleanCalculator2: (%s ,, %s ,, %s)" (show p1) (show op) (show p1)
  ----------

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

objAccCalculator :: Map.Map SymStateKey SymExpr -> SymExpr -> SymExpr
objAccCalculator varNames = \case
  SObjAcc names
    | length names >= 3 -> error $ "objAccCalculator ==> won't happen1 ==> " ++ show names
    | length names <= 1 -> error $ "objAccCalculator ==> won't happen2 ==> " ++ show names
  expr@(SObjAcc [varName,_]) ->
    let Just varNameVal = Map.lookup (VarName varName) varNames
    in objAccCalculator2 expr varNameVal
  arr@(SArrayIndexAccess arrType arrName arrIndexSymExpr) ->
    let Just varSymExpr = Map.lookup (VarName arrName) varNames
    in case (varSymExpr,arrIndexSymExpr) of
         (SymArray _ _ elems,SymInt index) -> elems !! fromIntegral index
         _ -> arr
  e -> error $ "objAccCalculator ==> won't happen3 ==> " ++ show e

objAccCalculator2 :: SymExpr -> SymExpr -> SymExpr
objAccCalculator2 expr@(SObjAcc [varName,methodCall]) = \case
  SymVar _ _ -> expr
  SymArray _ mLength elems
    | methodCall == "length" -> SymInt
        $ maybe (fromIntegral $ length elems) fromIntegral $ mLength
    | otherwise -> error "TODO: objAccCalculator2"

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

stringCalculator :: SymExpr -> SymExpr
stringCalculator = \case
  symExpr@(SBin e1 op e2) ->
    let calculating = stringCalculator2 op (e1,e2)
    in if calculating == symExpr
         then symExpr
       else stringCalculator calculating
  e -> e


stringCalculator2 :: SymBinOp -> (SymExpr,SymExpr) -> SymExpr
stringCalculator2 Add = \case
  ((SymString str1),(SymString str2)) -> SymString $ str1 ++ str2
  ----------
--SBin (SymVar String "s") Add (SymString " ")
  (e1@(SymVar String _),e2@(SymVar String _)) -> SBin e1 Add e2
  (e1@(SymVar String _),e2@(SymString _)) -> SBin e1 Add e2
  (e1@(SymString _),e2@(SymVar String _)) -> SBin e1 Add e2
  ----------
  (e1@(SBin _ _ _),e2) ->
    let rec = stringCalculator e1
    in SBin rec Add e2
  (e1,e2@(SBin _ _ _)) ->
    let rec = stringCalculator e2
    in SBin e1 Add rec
  (e1@(SBin _ _ _),e2@(SBin _ _ _)) ->
    let rec1 = stringCalculator e1
        rec2 = stringCalculator e2
    in SBin rec1 Add rec2
  ----------
  (e1@(SymFun ToString _),e2@(SymFun ToString _)) ->
     SBin e1 Add e2
  (e1@(SymFun ToString _),e2) ->
    SBin e1 Add (cast String e2)
  (e1,e2@(SymFun ToString _)) ->
    SBin (cast String e1) Add e2
  ----------
  (e1@(SArrayIndexAccess (Array String) _ _), e2)
    | toSymType2 e2 == String ->
        SBin e1 Add e2
  (e1, e2@(SArrayIndexAccess (Array String) _ _))
    | toSymType2 e1 == String ->
        SBin e1 Add e2
  ----------
  expr -> error $ "TODO: stringCalculator2: " ++ show expr

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

{-
toString ==> returns SymString
-}
funCallCalculator :: (DefinedFun,[SymExpr]) -> SymExpr
funCallCalculator = \case
  (ToString,[argExpr]) -> case argExpr of
     SymInt num -> SymString $ show num
     SymString str -> SymString $ printf "\"%s\"" str
     -- `SymFun String` is the same as `SymString`
     SymFun ToString _ -> SymFun ToString argExpr
     SymArray _ _ _ -> SymString $ ppSymExpr_no_symType argExpr
     SymArray mt ms symExprs ->
       let (areSymStrings,symExprs2) =
             let two = flip map symExprs $ \expr ->
                   let se = funCallCalculator (ToString,[expr])
                   in se
             in flip (,) two $ foldr (\r l -> case r of
                  SymString _ -> l
                  _           -> False) True symExprs2
       in if areSymStrings
            then SymString
                 $ printf "[%s]" (intercalate ", " $ flip map symExprs2 (\(SymString str) -> str))
          else SymFun ToString $ SymArray mt ms symExprs2
     SymNum num -> SymString $ show num
     symExpr@(SymVar _ _) -> cast String symExpr
     SBin expr1 op expr2 ->
       case (whichCalculator expr1 op expr2) argExpr of
         res
           | res == argExpr -> cast String res
           | otherwise -> funCallCalculator (ToString,[res])
     SymUnknown _ _ -> SymFun ToString argExpr
     SLoopFailure _ _ -> argExpr
     SymFun _ _ -> SymFun ToString argExpr
     SBool True -> SymString "true"
     SBool False -> SymString "false"
     _ -> error $ "TODO1: funCallCalculator ==> " ++ show argExpr
  (funName,[argExpr])        
    | funName `elem` [Print,Println] ->
        {-let ER_Expr (SymString str) = funCallCalculator (ToString,[argExpr])
        in ER_Print $ str ++ if funName == Print then "" else "\n"-}
         let x = flatten $ funCallCalculator (ToString,[argExpr])
         in case x of
              SymString str -> SymString $ str ++ if funName == Print then "" else "\n"
              s@(SymFun pf expr) -> SymFun funName s
    where
    flatten symExpr
      | toSymType2 argExpr == String = case symExpr of
          SymString ('\"' : rest) -> SymString (init rest)
          SymFun ToString e@(SymFun ToString _) -> e
          SymFun _ _ -> error $ "TODO2: funCallCalculator ==> " ++ show symExpr
      | otherwise = symExpr
  tu@(funName,argsExprs) -> error $ "TODO3: funCallCalculator ==> " ++ show tu

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

whichCalculator :: SymExpr -> SymBinOp -> SymExpr -> (SymExpr -> SymExpr)
whichCalculator op1 operator op2 =
  case whichCalculator2 op1 operator op2 of
    "stringCalculator"  -> stringCalculator
    "numericCalculator" -> numericCalculator
    "booleanCalculator" -> booleanCalculator

whichCalculator2 :: SymExpr -> SymBinOp -> SymExpr -> String
whichCalculator2 op1 operator op2 =
  let isNumericOp = operator `elem` [Add, Mul, Sub, Div, Mod]
      isString = all (==String) $ map toSymType2 [op1,op2]
  in case isNumericOp of
       True | isString -> "stringCalculator"
            | otherwise -> "numericCalculator"
       False -> "booleanCalculator"
