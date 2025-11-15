{-# Language LambdaCase #-}
module SymbolicExecution.Internal.Calculator (calculate) where

import SymbolicExecution.Internal.Internal-- (toSymType2, findSymType, negate, cast)
import SymbolicExecution.Types
import Prelude hiding (negate)
import Text.Printf (printf)

calculating :: SymBinOp -> (SymExpr, SymExpr) -> SymExpr
calculating op (e1,e2) = case (e1,e2) of
  (SymNum _, SymNum _) ->
    calculateHelper op (e1,e2)
  (SymInt _, SymInt _) ->
    calculateHelper op (e1,e2)
  (SymDouble _, SymDouble _) ->
    calculateHelper op (e1,e2)
  (SymFloat _, SymFloat _) ->
    calculateHelper op (e1,e2)
  -- Multiplication with 0
  (SymInt 0, _) | op == Mul -> calculateHelper op (e1,e2)
  (_, SymInt 0) | op == Mul -> calculateHelper op (e1,e2)
  (SymDouble 0, _) | op == Mul -> calculateHelper op (e1,e2)
  (_, SymDouble 0) | op == Mul -> calculateHelper op (e1,e2)
  (SymFloat 0, _) | op == Mul -> calculateHelper op (e1,e2)
  (_, SymFloat 0) | op == Mul -> calculateHelper op (e1,e2)
  (SymNum 0, _) | op == Mul -> calculateHelper op (e1,e2)
  (_, SymNum 0) | op == Mul -> calculateHelper op (e1,e2)
  -- Multiplication with 1
  (SymInt 1, _) | op == Mul -> calculateHelper op (e1,e2)
  (_, SymInt 1) | op == Mul -> calculateHelper op (e1,e2)
  (SymDouble 1, _) | op == Mul -> calculateHelper op (e1,e2)
  (_, SymDouble 1) | op == Mul -> calculateHelper op (e1,e2)
  (SymFloat 1, _) | op == Mul -> calculateHelper op (e1,e2)
  (_, SymFloat 1) | op == Mul -> calculateHelper op (e1,e2)
  (SymNum 1, _) | op == Mul -> calculateHelper op (e1,e2)
  (_, SymNum 0) | op == Mul -> calculateHelper op (e1,e2)
  -- Addition with 0
  (SymInt 0, _) | op == Add -> calculateHelper op (e1,e2)
  (_, SymInt 0) | op == Add -> calculateHelper op (e1,e2)
  (SymDouble 0, _) | op == Add -> calculateHelper op (e1,e2)
  (_, SymDouble 0) | op == Add -> calculateHelper op (e1,e2)
  (SymFloat 0, _) | op == Add -> calculateHelper op (e1,e2)
  (_, SymFloat 0) | op == Add -> calculateHelper op (e1,e2)
  (SymNum 0, _) | op == Add -> calculateHelper op (e1,e2)
  (_, SymNum 0) | op == Add -> calculateHelper op (e1,e2)
  -- Substraction with 0
  (SymInt 0, _) | op == Sub -> calculateHelper op (e1,e2)
  (_, SymInt 0) | op == Sub -> calculateHelper op (e1,e2)
  (SymDouble 0, _) | op == Sub -> calculateHelper op (e1,e2)
  (_, SymDouble 0) | op == Sub -> calculateHelper op (e1,e2)
  (SymFloat 0, _) | op == Sub -> calculateHelper op (e1,e2)
  (_, SymFloat 0) | op == Sub -> calculateHelper op (e1,e2)
  (SymNum 0, _) | op == Sub -> calculateHelper op (e1,e2)
  (_, SymNum 0) | op == Sub -> calculateHelper op (e1,e2)
  -- arithmetics on vars
  (SymFormalParam _ varName1 _, SymFormalParam _ varName2 _)
    | op == Add && varName1 == varName2 -> calculateHelper op (e1,e2)
    | op == Sub && varName1 == varName2 -> calculateHelper op (e1,e2)
  (SymFormalParam _ _ _, SymFormalParam _ _ _) -> calculateHelper op (e1,e2)
  --
  (SymGlobalVar _ _, SymGlobalVar _ _) -> calculateHelper op (e1,e2)
----------
  (SymNum _, SymInt _) -> calculateHelper op (e1,e2)
  (SymInt _, SymNum _) -> calculateHelper op (e1,e2)
----------
  (SymNum _, SymDouble _) -> calculateHelper op (e1,e2)
  (SymDouble _, SymNum _) -> calculateHelper op (e1,e2)
----------
  (SymNum _, SymFloat _) -> calculateHelper op (e1,e2)
  (SymFloat _, SymNum _) -> calculateHelper op (e1,e2)
----------
  (SBin _ _ _, SBin _ _ _) -> calculateHelper op (e1,e2)
---------- commutative events
  (SBin symExpr1 op1 symExpr2, b)
    ---------- (i op1 1) op 2
    | isVar symExpr1 && all (not . isVar) [symExpr2,b]
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) ->
        calculateHelper op (e1,e2)
    ---------- (1 op1 i) op 2
    | all (not . isVar) [symExpr1,b] && isVar symExpr2
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) ->
        calculateHelper op (e1,e2)
    ---------- PART 1/2 (? is number or var): (x op1 ?) op x, ? = symExpr2
    | all isVar [symExpr1,b] && getVarName symExpr1 == getVarName b
      && ((isVar symExpr2 && getVarName symExpr2 /= getVarName symExpr1)
          || (not $ isVar symExpr2))
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) ->
        calculateHelper op (e1,e2)
    ---------- PART 2/2 (? == number): (x op1 ?) op x, ? = symExpr2
    | all isVar [symExpr1,b] && getVarName symExpr1 == getVarName b
      && (not $ isVar symExpr2)
      && ((op1,op) `elem` [(Mul,Add),(Mul,Sub),(Div,Add),(Div,Sub)]) ->
        calculateHelper op (e1,e2)
    ---------- PART 1/2 (? is number or var): (? op1 x) op x, ? = symExpr1
    | all isVar [symExpr2,b] && getVarName symExpr2 == getVarName b
      && ((isVar symExpr1 && getVarName symExpr1 /= getVarName symExpr2)
          || (not $ isVar symExpr1))
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) ->
        calculateHelper op (e1,e2)
    ---------- PART 2/2 (? is number): (? op1 x) op x, ? = symExpr1
    | all isVar [symExpr2,b] && getVarName symExpr2 == getVarName b
      && (not $ isVar symExpr1)
      && ((op1,op) `elem` [(Mul,Add),(Mul,Sub)]) ->
        calculateHelper op (e1,e2)
    | otherwise -> calculateHelper op (e1,e2)
----------
  (a, b@(SBin symExpr1 op1 symExpr2))
    ---------- 1 op (i op1 2)
    | all (not . isVar) [a,symExpr2] && isVar symExpr1
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) ->
        calculateHelper op (e1,e2)
    ---------- 1 op (2 op1 i)
    | all (not . isVar) [a,symExpr1] && isVar symExpr2
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) ->
        calculateHelper op (e1,e2)
    ---------- PART 1/2 (? is not number): X op (X op1 ?), ? = symExpr2
    | all isVar [a,symExpr1] && getVarName a == getVarName symExpr1
      && ((isVar symExpr2 && getVarName symExpr2 /= getVarName symExpr1)
          || (not $ isVar symExpr2))
      && ((op,op1) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) ->
        calculateHelper op (e1,e2)
    ---------- PART 2/2 (? is number): X op (X op1 ?), ? = symExpr2
    | all isVar [a,symExpr1] && getVarName a == getVarName symExpr1
      && (not $ isVar symExpr2)
      && ((op,op1) `elem` [(Add,Mul),(Sub,Mul),(Add,Div),(Sub,Div)]) ->
        calculateHelper op (e1,e2)
    ---------- PART 1/2 (? is not number): X op (? op1 X), ? = symExpr1
    | all isVar [a,symExpr2] && getVarName a == getVarName symExpr2
      && ((isVar symExpr1 && getVarName symExpr1 /= getVarName symExpr2) ||
          (not $ isVar symExpr1)
         )
      && ((op,op1) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) ->
        calculateHelper op (e1,e2)
    ---------- PART 2/2 (? is number): X op (? op1 X), ? = symExpr1
    | all isVar [a,symExpr2] && getVarName a == getVarName symExpr2
      && (not $ isVar symExpr1)
      && ((op,op1) `elem` [(Add,Mul),(Sub,Mul)]) ->
        calculateHelper op (e1,e2)
    | otherwise -> calculateHelper op (e1,e2)
----------
  (_, SymFormalParam _ _ Nothing) ->
    calculateHelper op (e1,e2)
  (_, SymFormalParam _ _ (Just _)) ->
    calculateHelper op (e1,e2)
  (SymFormalParam _ _ Nothing, _) ->
    calculateHelper op (e1,e2)
  (SymFormalParam _ _ (Just _), _) ->
    calculateHelper op (e1,e2)
----------
  (_, SymGlobalVar _ _) ->
    calculateHelper op (e1,e2)
  (SymGlobalVar _ _, _) ->
    calculateHelper op (e1,e2)
----------
  _ -> calculateHelper op (e1,e2)

-- >>>>>>>>>>>>>>>>>>>>
-- >>>>>>>>>>>>>>>>>>>>
-- >>>>>>>>>>>>>>>>>>>>

calculateHelper :: SymBinOp -> (SymExpr, SymExpr) -> SymExpr
calculateHelper op = \case
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
  (a@(SymFormalParam t1 varName1 _), b@(SymFormalParam t2 varName2 _))
    | op == Add && varName1 == varName2 -> SBin (cast t1 $ SymNum 2) Mul a
    | op == Sub && varName1 == varName2 -> cast t1 (SymNum 0)
  (a@(SymFormalParam _ _ _), b@(SymFormalParam _ _ _)) ->
    SBin a op b
  --
  (a@(SymGlobalVar _ _), b@(SymGlobalVar _ _)) ->
    SBin a op b
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
{-
1)
SBin (SymFormalParam Int "i" Nothing)
     Add
     (SBin (SBin (SymInt 11) Add (SymFormalParam Int "i" Nothing))
           Add
           (SymFormalParam Int "i" Nothing)
     )

(Add)

2)
SBin (SymFormalParam Int "i" Nothing)
     Add
     (SBin (SymInt 9)
           Add
           (SymFormalParam Int "i" Nothing)
     )
-}
{-
1) i + ((11 + i) + i)
SBin (SymFormalParam Int "i" Nothing)
     Add
     (SBin (SBin (SymInt 11)
                 Add
                 (SymFormalParam Int "i" Nothing)
           )
           Add
           (SymFormalParam Int "i" Nothing)
     )

+

2) i + (9 + i)
SBin (SymFormalParam Int "i" Nothing)
     Add
     (SBin (SymInt 9)
           Add
           (SymFormalParam Int "i" Nothing)
     )
-}
  (a@(SBin _ _ _), b@(SBin _ _ _)) ->
    error $ printf "TODO: calculateHelper: (%s) (%s) (%s)" (show a) (show op) (show b) 
---------- commutative events
  (a@(SBin symExpr1 op1 symExpr2), b)
    ---------- (i op1 1) op 2
    | isVar symExpr1 && all (not . isVar) [symExpr2,b]
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op1,op) of
      -- (i + 1) + 2 == i + (1+2)
      (Add,Add) -> calculating0 $ SBin symExpr1 Add (SBin symExpr2 Add b)
      -- (i - 1) - 2 == i - (1 + 2)
      (Sub,Sub) -> calculating0 $ SBin symExpr1 Sub (SBin symExpr2 Add b)
      -- (i + 1) - 2 == i + (1 - 2)
      (Add,Sub) -> calculating0 $ SBin symExpr1 Add (SBin symExpr2 Sub b)
      -- (i - 1) + 2 == i - (1 - 2)
      (Sub,Add) -> calculating0 $ SBin symExpr1 Sub (SBin symExpr2 Sub b)
      -- (i * 2) * 3 == i * (2 * 3)
      (Mul,Mul) -> calculating0 $ SBin symExpr1 Mul (SBin symExpr2 Mul b)
      -- (i / 2) / 3 == i / (2 * 3)
      (Div,Div) -> calculating0 $ SBin symExpr1 Div (SBin symExpr2 Mul b)
      -- (i * 2) / 3 == i * (2 / 3)
      (Mul,Div) -> calculating0 $ SBin symExpr1 Mul (SBin symExpr2 Div b)
      -- (i / 2) * 3 == i * (3 / 2)
      (Div,Mul) -> calculating0 $ SBin symExpr1 Mul (SBin b Div symExpr2)
    ---------- (1 op1 i) op 2
    | all (not . isVar) [symExpr1,b] && isVar symExpr2
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op1,op) of
      -- (1 + i) + 2 == (1 + 2) + i
      (Add,Add) -> 
        let calc = calculating0 $ SBin (SBin symExpr1 Add b) Add symExpr2
        in calc
      -- (1 - i) - 2 == (1 - 2) - i
      (Sub,Sub) -> calculating0 $ SBin (SBin symExpr1 Sub b) Sub symExpr2
      -- (1 + i) - 2 == (1 - 2) + i
      (Add,Sub) -> calculating0 $ SBin (SBin symExpr1 Sub b) Add symExpr2
      -- (1 - i) + 2 == (1 + 2) - i
      (Sub,Add) -> calculating0 $ SBin (SBin symExpr1 Add b) Sub symExpr2
      -- (2 * i) * 3 == (2 * 3) * i
      (Mul,Mul) -> calculating0 $ SBin (SBin symExpr1 Mul b) Mul symExpr2
      -- (2 / i) / 3 == (2 / 3) / i
      (Div,Div) -> calculating0 $ SBin (SBin symExpr1 Div b) Div symExpr2
      -- (2 * i) / 3 == (2 / 3) * i
      (Mul,Div) -> calculating0 $ SBin (SBin symExpr1 Div b) Mul symExpr2
      -- (2 / i) * 3 == (2 * 3) / i
      (Div,Mul) -> calculating0 $ SBin (SBin symExpr1 Mul b) Div symExpr2
    ---------- PART 1/2 (? is number or var): (x op1 ?) op x, ? = symExpr2
    | all isVar [symExpr1,b] && getVarName symExpr1 == getVarName b
      && ((isVar symExpr2 && getVarName symExpr2 /= getVarName symExpr1)
          || (not $ isVar symExpr2))
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op1,op) of
        -- (x + ?) + x == (x + x) + ?
        (Add,Add) -> calculating0 $ SBin (SBin symExpr1 Add b) Add symExpr2
        -- (x + ?) - x == (x - x) + ?
        (Add,Sub) -> calculating0 $ SBin (SBin symExpr1 Sub b) Add symExpr2
        -- (x - ?) + x == (x + x) - ?
        (Sub,Add) -> calculating0 $ SBin (SBin symExpr1 Add b) Sub symExpr2
        -- (x - ?) - x == (x - x) - ?
        (Sub,Sub) -> calculating0 $ SBin (SBin symExpr1 Sub b) Sub symExpr2
        -- (x * ?) * x == (x * x) * ?
        (Mul,Mul) -> calculating0 $ SBin (SBin symExpr1 Mul b) Mul symExpr2
        -- (x * ?) / x == (x / x) * ?
        (Mul,Div) -> calculating0 $ SBin (SBin symExpr1 Div b) Mul symExpr2
        -- (x / ?) * x == (x * x) / ?
        (Div,Mul) -> calculating0 $ SBin (SBin symExpr1 Mul b) Div symExpr2
        -- (x / ?) / x == (x / x) / ?
        (Div,Div) -> calculating0 $ SBin (SBin symExpr1 Div b) Div symExpr2
    ---------- PART 2/2 (? == number): (x op1 ?) op x, ? = symExpr2
    | all isVar [symExpr1,b] && getVarName symExpr1 == getVarName b
      && (not $ isVar symExpr2)
      && ((op1,op) `elem` [(Mul,Add),(Mul,Sub),(Div,Add),(Div,Sub)]) -> case (op1,op) of
        -- (x * 3) + x == (3 + 1) * x
        (Mul,Add) -> calculating0 $ SBin (SBin symExpr2 Add (SymNum 1)) Mul symExpr1
        -- (x * 3) - x == (3 - 1) * x
        (Mul,Sub) -> calculating0 $ SBin (SBin symExpr2 Sub (SymNum 1)) Mul symExpr1
        -- (x / 3) + x == (1/3 + 1) * x
        (Div,Add) -> calculating0 $ SBin (SBin (SBin (SymNum 1) Div symExpr2) Add (SymNum 1)) Mul symExpr1
        -- (x / 3) - x == (1/3 - 1) * x
        (Div,Sub) -> calculating0 $ SBin (SBin (SBin (SymNum 1) Div symExpr2) Sub (SymNum 1)) Mul symExpr1
    ---------- PART 1/2 (? is number or var): (? op1 x) op x, ? = symExpr1
    | all isVar [symExpr2,b] && getVarName symExpr2 == getVarName b
      && ((isVar symExpr1 && getVarName symExpr1 /= getVarName symExpr2)
          || (not $ isVar symExpr1))
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op1,op) of
        -- (? + x) + x == (x + x) + ?
        (Add,Add) -> calculating0 $ SBin (SBin b Add symExpr2) Add symExpr1
        -- (? - x) - x == ? - (x + x)
        (Sub,Sub) -> calculating0 $ SBin symExpr1 Sub (SBin symExpr2 Add b)
        -- (? + x) - x == ? + (x - x)
        (Add,Sub) -> calculating0 $ SBin symExpr1 Add (SBin symExpr2 Sub b)
        -- (? - x) + x == ? + (x - x)
        (Sub,Add) -> calculating0 $ SBin symExpr1 Add (SBin symExpr2 Sub b)
        -- (? * x) * x == ? * (x * x)
        (Mul,Mul) -> calculating0 $ SBin symExpr1 Mul (SBin symExpr2 Mul b)
        -- (? / x) / x == ? / (x * x)
        (Div,Div) -> calculating0 $ SBin symExpr1 Div (SBin symExpr2 Mul b)
        -- (? * x) / x == ? * (x / x)
        (Mul,Div) -> calculating0 $ SBin symExpr1 Mul (SBin symExpr2 Div b)
        -- (? / x) * x == ? * (x / x)
        (Div,Mul) -> calculating0 $ SBin symExpr1 Mul (SBin symExpr2 Div b)
    ---------- PART 2/2 (? is number): (? op1 x) op x, ? = symExpr1
    | all isVar [symExpr2,b] && getVarName symExpr2 == getVarName b
      && (not $ isVar symExpr1)
      && ((op1,op) `elem` [(Mul,Add),(Mul,Sub)]) -> case (op1,op) of
        -- (3 * x) + x == (3 + 1) * x
        (Mul,Add) -> calculating0 $ SBin (SBin symExpr1 Add (SymNum 1)) Mul symExpr2
        -- (3 * x) - x == (3 - 1) * x
        (Mul,Sub) -> calculating0 $ SBin (SBin symExpr1 Sub (SymNum 1)) Mul symExpr2
    | otherwise -> maybe (error "calculateHelper ~~> won't happen 1") id $ do
      symType <- findSymType [a,b]
      let expr1 = calculateHelper op1 (cast symType symExpr1,cast symType symExpr2)
          expr2 = cast symType b  
      return $ SBin expr1 op expr2
----------
  (a, b@(SBin symExpr1 op1 symExpr2))
    ---------- 1 op (i op1 2)
    | all (not . isVar) [a,symExpr2] && isVar symExpr1
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op,op1) of
      -- 1 + (i + 2) == (1 + 2) + i
      (Add,Add) -> calculating0 $ SBin (SBin a Add symExpr2) Add symExpr1
      -- 1 - (i - 2) == (1 + 2) - i
      (Sub,Sub) -> calculating0 $ SBin (SBin a Add symExpr2) Sub symExpr1
      -- 1 + (i - 2) == (1 - 2) + i
      (Add,Sub) -> calculating0 $ SBin (SBin a Sub symExpr2) Add symExpr1
      -- 1 - (i + 2) == (1 - 2) - i
      (Sub,Add) -> calculating0 $ SBin (SBin a Sub symExpr2) Sub symExpr1
      -- 2 * (i * 3) == (2 * 3) * i
      (Mul,Mul) -> calculating0 $ SBin (SBin a Mul symExpr2) Mul symExpr1
      -- 2 / (i / 3) == (2 * 3) / i
      (Div,Div) -> calculating0 $ SBin (SBin a Mul symExpr2) Div symExpr1
      -- 2 * (i / 3) == (2 / 3) * i
      (Mul,Div) -> calculating0 $ SBin (SBin a Div symExpr2) Mul symExpr1
      -- 2 / (i * 3) == (2 / 3) / i
      (Div,Mul) -> calculating0 $ SBin (SBin a Div symExpr2) Div symExpr1
    ---------- 1 op (2 op1 i)
    | all (not . isVar) [a,symExpr1] && isVar symExpr2
      && ((op1,op) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op,op1) of
      -- 1 + (2 + i) == (1 + 2) + i
      (Add,Add) -> calculating0 $ SBin (SBin a Add symExpr1) Add symExpr2
      -- 1 - (2 - i) == (1 - 2) + i
      (Sub,Sub) -> calculating0 $ SBin (SBin a Sub symExpr1) Add symExpr2
      -- 1 + (2 - i) == (1 + 2) - i
      (Add,Sub) -> calculating0 $ SBin (SBin a Add symExpr1) Sub symExpr2
      -- 1 - (2 + i) == (1 - 2) - i
      (Sub,Add) -> calculating0 $ SBin (SBin a Sub symExpr1) Sub symExpr2
      -- 2 * (3 * i) == (2 * 3) * i
      (Mul,Mul) -> calculating0 $ SBin (SBin a Mul symExpr1) Mul symExpr2
      -- 2 / (3 / i) == (2 / 3) * i
      (Div,Div) -> calculating0 $ SBin (SBin a Div symExpr1) Mul symExpr2
      -- 2 * (3 / i) == (2 * 3) / i
      (Mul,Div) -> calculating0 $ SBin (SBin a Mul symExpr1) Div symExpr2
      -- 2 / (3 * i) == (2 / 3) / i
      (Div,Mul) -> calculating0 $ SBin (SBin a Div symExpr1) Div symExpr2
    ---------- PART 1/2 (? is number or var): X op (X op1 ?), ? = symExpr2
    | all isVar [a,symExpr1] && getVarName a == getVarName symExpr1
      && ((isVar symExpr2 && getVarName symExpr2 /= getVarName symExpr1)
          || (not $ isVar symExpr2))
      && ((op,op1) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op,op1) of
        -- X + (X + Y) == (X + X) + Y
        (Add,Add) -> calculating0 $ SBin (SBin a Add symExpr1) Add symExpr2
        -- X - (X - Y) == (X - X) + Y
        (Sub,Sub) -> calculating0 $ SBin (SBin a Sub symExpr1) Add symExpr2
        -- X + (X - Y) == (X + X) - Y
        (Add,Sub) -> calculating0 $ SBin (SBin a Add symExpr1) Sub symExpr2
        -- X - (X + Y) == (X - X) - Y
        (Sub,Add) -> calculating0 $ SBin (SBin a Sub symExpr1) Sub symExpr2
        -- X * (X * Y) == (X * X) * Y
        (Mul,Mul) -> calculating0 $ SBin (SBin a Mul symExpr1) Mul symExpr2
        -- X / (X / Y) == (X / X) * Y
        (Div,Div) -> calculating0 $ SBin (SBin a Div symExpr1) Mul symExpr2
        -- X * (X / Y) == (X * X) / Y
        (Mul,Div) -> calculating0 $ SBin (SBin a Mul symExpr1) Div symExpr2
        -- X / (X * Y) == (X / X) / Y
        (Div,Mul) -> calculating0 $ SBin (SBin a Div symExpr1) Div symExpr2
    ---------- PART 2/2 (? is number): X op (X op1 ?), ? = symExpr2
    | all isVar [a,symExpr1] && getVarName a == getVarName symExpr1
      && (not $ isVar symExpr2)
      && ((op,op1) `elem` [(Add,Mul),(Sub,Mul),(Add,Div),(Sub,Div)]) -> case (op,op1) of
        -- X + (X * 3) == (1 + 3) * X
        (Add,Mul) -> calculating0 $ SBin (SBin (SymNum 1) Add symExpr2) Mul a
        -- X - (X * 3) == (1 - 3) * X
        (Sub,Mul) -> calculating0 $ SBin (SBin (SymNum 1) Sub symExpr2) Mul a
        -- X + (X / 3) == (1 + 1/3) * x
        (Add,Div) -> calculating0 $ SBin (SBin (SymNum 1) Add (SBin (SymNum 1) Div symExpr2)) Mul a
        -- X - (X / 3) == (1 - 1/3) * x
        (Sub,Div) -> calculating0 $ SBin (SBin (SymNum 1) Sub (SBin (SymNum 1) Div symExpr2)) Mul a
    ---------- PART 1/2 (? is number or var): X op (? op1 X), ? = symExpr1
    | all isVar [a,symExpr2] && getVarName a == getVarName symExpr2
      && ((isVar symExpr1 && getVarName symExpr1 /= getVarName symExpr2) ||
          (not $ isVar symExpr1)
         )
      && ((op,op1) `elem` [(Add,Add),(Sub,Sub),(Add,Sub),(Sub,Add)
                          ,(Mul,Mul),(Div,Div),(Mul,Div),(Div,Mul)]) -> case (op,op1) of
        -- X + (Y + X) == (X + X) + Y
        (Add,Add) -> calculating0 $ SBin (SBin a Add symExpr2) Add symExpr1
        -- X - (Y - X) == (X + X) - Y
        (Sub,Sub) -> calculating0 $ SBin (SBin a Add symExpr2) Sub symExpr1
        -- X + (Y - X) == (X - X) + Y
        (Add,Sub) -> calculating0 $ SBin (SBin a Sub symExpr2) Add symExpr1
        -- X - (Y + X) == (X - X) - Y
        (Sub,Add) -> calculating0 $ SBin (SBin a Sub symExpr2) Sub symExpr1
        -- X * (Y * X) == (X * X) * Y
        (Mul,Mul) -> calculating0 $ SBin (SBin a Mul symExpr2) Mul symExpr1
        -- X / (Y / X) == (X * X) / Y
        (Div,Div) -> calculating0 $ SBin (SBin a Mul symExpr2) Div symExpr1
        -- X * (Y / X) == (X / X) * Y
        (Mul,Div) -> calculating0 $ SBin (SBin a Div symExpr2) Mul symExpr1
        -- X / (Y * X) == (X / X) / Y
        (Div,Mul) -> calculating0 $ SBin (SBin a Div symExpr2) Div symExpr1
    ---------- PART 2/2 (? is number): X op (? op1 X), ? = symExpr1
    | all isVar [a,symExpr2] && getVarName a == getVarName symExpr2
      && (not $ isVar symExpr1)
      && ((op,op1) `elem` [(Add,Mul),(Sub,Mul)]) -> case (op,op1) of
        -- X + (3 * X) == (1 + 3) * X
        (Add,Mul) -> calculating0 $ SBin (SBin (SymNum 1) Add symExpr1) Mul a
        -- X - (3 * X) == (1 - 3) * X
        (Sub,Mul) -> calculating0 $ SBin (SBin (SymNum 1) Sub symExpr1) Mul a
    | otherwise -> maybe (error "calculateHelper ~~> won't happen 2") id $ do
      symType <- findSymType [a,b]
      let expr1 = cast symType a
          expr2 = calculateHelper op1 (cast symType symExpr1,cast symType symExpr2)
      return $ SBin expr1 op expr2
----------
  (a, b@(SymFormalParam t _ Nothing)) ->
    SBin (cast t a) op b
  (a, b@(SymFormalParam t _ (Just symExpr))) ->
    calculateHelper op (cast t a,symExpr)
  (a@(SymFormalParam t _ Nothing), b) ->
    SBin a op (cast t b)
  (a@(SymFormalParam t _ (Just symExpr)), b) ->
    calculateHelper op (symExpr,cast t b)
----------
  (a, b@(SymGlobalVar t _)) ->
    SBin (cast t a) op b
  (a@(SymGlobalVar t _), b) ->
    SBin a op (cast t b)
----------
  (a,b) -> error $ printf "calculateHelper: %s %s %s" (show a) (show op) (show b)

calculating0 :: SymExpr -> SymExpr
calculating0 (SBin expr1 op expr2) = calculateHelper op (expr1,expr2)

calculate :: SymBinOp -> (SymExpr, SymExpr) -> SymExpr
calculate op (e1,e2) =
  let calculating1 = calculating op (e1,e2)
  in case calculating1 of
       SBin e1_ op_ e2_
         | calculating1 == SBin e1 op e2 -> SBin e1 op e2
         | otherwise -> calculate op_ (e1_,e2_)
       _ -> calculating1
