{-# Language LambdaCase, MultiWayIf, ScopedTypeVariables #-}
module SymbolicExecution.Internal.Math.Isolator where

import qualified CFG.Types as CFGT

import SymbolicExecution.Types
import SymbolicExecution.Internal.Internal (
  existsIn, constructLog, tellNextLog, constructLogContents,
  incrementLogEnumeration, incrementLogDepth, decrementLogDepth,
  cast, toSymType2, isInstanceOf, runMonad)

import Control.Monad.Except (throwError, runExceptT)
import qualified Control.Monad.State as MonadicState (State,runState)
import Control.Monad.Writer (WriterT, runWriterT, censor)
import Control.Monad.Reader (ReaderT, runReaderT)
import Text.Printf (printf)
import Data.List (intercalate)
import Data.Bifunctor (bimap)

import qualified SymbolicExecution.Logs.Log as Log
import Data.Functor (($>))
import qualified Data.Map as Map
import SymbolicExecution.Internal.Math.Calculator

loc = "SymbolicExecution.Internal.Math.Isolator"
{-
1)
SymInt 5 ==> Nothing
isolate "i" (SymInt 5)
==========
2)
j ==> Nothing
isolate "i" (SymVar Int "j")
==========
3)
i ==> Just i
isolate "i" (SymVar Int "i")
==========
4)
i + 1 ==> Nothing
Because `Add` is not a Boolean relation, not `And`, not `Or`, and not `SNot`.
-- i+1
4) isolate "i" (SBin (SymVar Int "i") Add (SymInt 1)) ==> Nothing
==========
5)
i + 1 > n ==> Just (i > n - 1)
-- i+1 > n ==> Just (i > n-1)
isolate "i" (SBin (SBin (SymVar Int "i") Add (SymInt 1)) Gt (SymVar Int "n"))
==========
6)
1 + i <= n ==> Just (i <= n - 1)
-- 1+i <= n ==> Just (i <= n-1)
isolate "i" (SBin (SBin (SymInt 1) Add (SymVar Int "i")) Le (SymVar Int "n"))
==========
7)
i - 1 >= n ==> Just (i >= n + 1)
-- i-1 >= n ==> Just (i >= n+1)
isolate "i" (SBin (SBin (SymVar Int "i") Sub (SymInt 1)) Ge (SymVar Int "n"))
==========
8)
1 - i < n ==> Just (i > 1 - n)
-- 1-i < n ==> Just (i> 1-n)
isolate "i" (SBin (SBin (SymInt 1) Sub (SymVar Int "i")) Lt (SymVar Int "n"))
==========
9)
2 * i == n ==> Just (i == n / 2)
-- 2*i == n ==> Just (i == n/2)
isolate "i" (SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Eq (SymVar Int "n"))
==========
10)
i * (-2) > n ==> Just (i < n / (-2))
-- i*(-2) > n ==> Just (i < n/(-2))
isolate "i" (SBin (SBin (SymVar Int "i") Mul (SymInt (-2))) Gt (SymVar Int "n"))
==========
11)
i / 2 <= n ==> Just (i <= n * 2)
-- i/2 <= n
isolate "i" (SBin (SBin (SymVar Int "i") Div (SymInt 2)) Le (SymVar Int "n"))
==========
12)
i / (-2) < n ==> Just (i > n * (-2))
-- i/(-2) < n
isolate "i" $ SBin (SBin (SymVar Int "i") Div (SymInt (-2))) Lt (SymVar Int "n")
==========
13)
n < i + 1 ==> Just (i > n - 1)
-- n < i+1
isolate "i" $ SBin (SymVar Int "n") Lt (SBin (SymVar Int "i") Add (SymInt 1))
==========
14)
n >= i - 1 ==> Just (i <= n + 1)
-- n >= i-1
isolate "i" $ SBin (SymVar Int "n") Ge (SBin (SymVar Int "i") Sub (SymInt 1))
==========
15)
(i + 1) * 2 > n ==> Just (i > (n / 2) - 1)
-- (i+1)*2 > n
isolate "i" $ SBin (SBin (SBin (SymVar Int "i") Add (SymInt 1)) Mul (SymInt 2)) Gt (SymVar Int "n")
==========
16)
2 * (i - 3) <= n ==> Just (i <= (n / 2) + 3)
-- 2*(i-3) <= n
isolate "i" $ SBin (SBin (SymInt 2) Mul (SBin (SymVar Int "i") Sub (SymInt 3))) Le (SymVar Int "n")
==========
17)
2 - (i + 1) > n ==> Just (i < (2 - n) - 1)
-- 2-(i+1) > n
isolate "i" $ SBin (SBin (SymInt 2) Sub (SBin (SymVar Int "i") Add (SymInt 1))) Gt (SymVar Int "n")
==========
18)
i % 2 == 0 ==> Nothing
-- i%2 == 0
isolate "i" $ SBin (SBin (SymVar Int "i") Mod (SymInt 2)) Eq (SymInt 0)
==========
19)
i * j > n ==> Nothing
-- i*j > n
isolate "i" $ SBin (SBin (SymVar Int "i") Mul (SymVar Int "j")) Gt (SymVar Int "n")
==========
20)
i + j > n ==> Just (i > n - j)
-- i+j > n
isolate "i" $ SBin (SBin (SymVar Int "i") Add (SymVar Int "j")) Gt (SymVar Int "n")
==========
21)
i + i > n ==> Nothing
-- i+i > n
isolate "i" $ SBin (SBin (SymVar Int "i") Add (SymVar Int "i")) Gt (SymVar Int "n")
==========
22)
i > i + 1 ==> Nothing
-- i > i+1
isolate "i" $ SBin (SymVar Int "i") Gt (SBin (SymVar Int "i") Add (SymInt 1))
==========
23)
i * 0 > n ==> Nothing
-- i*0 > n
isolate "i" $ SBin (SBin (SymVar Int "i") Mul (SymInt 0)) Gt (SymVar Int "n")
==========
24)
-- i/j > n
isolate "i" $ SBin (SBin (SymVar Int "i") Div (SymVar Int "j")) Gt (SymVar Int "n")
==========
25)
j / i > n ==> Nothing
-- j/i > n
isolate "i" $ SBin (SBin (SymVar Int "j") Div (SymVar Int "i")) Gt (SymVar Int "n")
==========
26)
i + 1 == n ==> Just (i == n - 1)
-- i+1 == n
isolate "i" $ SBin (SBin (SymVar Int "i") Add (SymInt 1)) Eq (SymVar Int "n")
==========
27)
i + 1 /= n ==> Just (i /= n - 1)
-- i+1 /= n
isolate "i" $ SBin (SBin (SymVar Int "i") Add (SymInt 1)) Neq (SymVar Int "n")
==========
28)
not (i + 1 > n) ==> Just (i <= n - 1)
-- !(i+1 > n)
isolate "i" $ SNot $ SBin (SBin (SymVar Int "i") Add (SymInt 1)) Gt (SymVar Int "n")
==========
29)
(i + 1 > n) && (j > 0) ==> Just ((i > n - 1) && (j > 0))
-- (i+1>n) && (j>0)
isolate "i" $ SBin (SBin (SBin (SymVar Int "i") Add (SymInt 1)) Gt (SymVar Int "n")) And
                   (SBin (SymVar Int "j") Gr (SymInt 0))
==========
30)
(j > 0) || (n < i + 1) ==> Just ((j > 0) || (i > n - 1))
-- (j>0) || (n<i+1)
isolate "i" $ SBin (SBin (SymVar Int "j") Gt (SymInt 0)) Or (SBin (SymVar Int "n") Lt (SBin (SymVar Int "i") Add (SymInt 1)))
==========
31)
(i + 1 > n) && (i - 1 < m) ==> Just ((i > n - 1) && (i < m + 1))
-- (i+1>n) && (i-1<m)
isolate "i" $ SBin (SBin (SBin (SymVar Int "i") Add (SymInt 1)) Gt (SymVar Int "n")) And (SBin (SBin (SymVar Int "i") Sub (SymInt 1)) Lt (SymVar Int "m"))
==========
32)
not ((i + 1 > n) && (j > 0)) ==> Just ((i <= n - 1) || (j <= 0))
-- not ((i+1>n) && (j>0))
isolate "i" $ SNot $ SBin (SBin (SBin (SymVar Int "i") Add (SymInt 1)) Gt (SymVar Int "n")) And (SBin (SymVar Int "j") Gt (SymInt 0))
==========
33)
-- 2*i+j > i+1
isolate "i" $ SBin (SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymVar Int "j")) Gt (SBin (SymVar Int "i") Add (SymInt 1))
==========
34)
-- i+j > i+1
isolate "i" $ SBin (SBin (SymVar Int "i") Add (SymVar Int "j")) Gt (SBin (SymVar Int "i") Add (SymInt 1))
==========
35)
-- i-j > i+1
isolate "i" $ SBin (SBin (SymVar Int "i") Sub (SymVar Int "j")) Gt (SBin (SymVar Int "i") Add (SymInt 1))
==========
36)
-- j-i > i+1
isolate "i" $ SBin (SBin (SymVar Int "j") Sub (SymVar Int "i")) Gt (SBin (SymVar Int "i") Add (SymInt 1))
==========
37)
-- i+1 > i+j
isolate "i" $ SBin (SBin (SymVar Int "i") Add (SymInt 1)) Gt (SBin (SymVar Int "i") Add (SymVar Int "j"))
==========
38)
-- 2*i+j <= i+n
isolate "i" $ SBin (SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Add (SymVar Int "j")) Le (SBin (SymVar Int "i") Add (SymVar Int "n"))
==========
39)
-- 2*i-j <= i+n
isolate "i" $ SBin (SBin (SBin (SymInt 2) Mul (SymVar Int "i")) Sub (SymVar Int "j")) Le (SBin (SymVar Int "i") Add (SymVar Int "n"))
==========
40)
-- i-3 >= i+n
isolate "i" $ SBin (SBin (SymVar Int "i") Sub (SymInt 3)) Ge (SBin (SymVar Int "i") Add (SymVar Int "n"))
==========
41)
-- (i+j)-(i+1) > n
isolate "i" $ SBin (SBin (SBin (SymVar Int "i") Add (SymVar Int "j")) Sub (SBin (SymVar Int "i") Add (SymInt 1))) Gt (SymVar Int "n")
==========
 -}
data IsolationFailureReason
  = VarAbsent            -- n + 1 > 0 ==> i does not exist
  | Eliminated SymExpr   -- i + j > i + 1 ==> 0 > 1-j ==> i eliminated
  | AlwaysTrue           -- i >= i ==> 0 >= 0 ==> always true
  | AlwaysFalse          -- i > i + 1 ==> i-i > 1 ==> 0 > 1 ==> always false
  | AmbiguousSign String -- i * j > n ==> i can't be isolated because j's sign is ambiguous
  deriving (Eq, Show)
----------
-- This function was mainly created to be used in `getLoopCountersBounds`
-- so that a loop counter can be separated from the rest of the expression.
----------
isolate :: String -> SymExpr -> SymbolicExecutionMonad (Either IsolationFailureReason SymExpr)
isolate varName expr = do
  let innerLoc = loc ++ ".isolate"
  constructLog innerLoc "isolate" [("varName",varName),("expr",show expr)]
  -- calculated_before is the calculator applied to expr before isolating
  let calculated_before = calculator expr
  if expr == calculated_before
    then return ()
    else constructLog innerLoc "new expr after calculation"
           [("old expr",show expr)
           ,("calculated before isolating",show calculated_before)] $> ()
  if | not (varName `existsIn` expr) -> return $ Left VarAbsent
     | calculated_before == SBool False -> return $ Left AlwaysFalse
     | calculated_before == SBool True  -> return $ Left AlwaysTrue
     | varName `existsIn` calculated_before -> do
         constructLog innerLoc
           (printf "varName <%s> exists in <%s>" varName (show calculated_before)) []
         isolated <- incrementLogDepth *>
                       isolateExpr varName calculated_before
                         <* decrementLogDepth
         let calculated_after = calculator <$> isolated
         constructLog innerLoc "Isolation & Calculation"
           [("Isolation output",show isolated)
           ,("Then Calculation",show calculated_after)]
         case calculated_after of
           Right (SBool False) -> return $ Left AlwaysFalse
           Right (SBool True) -> return $ Left AlwaysTrue
           _ -> return calculated_after
     | varName `existsIn` expr -> return $ Left $ Eliminated calculated_before
     | otherwise -> throwError $ printf
         "TODO in %s\n\
         \%s" innerLoc
         (constructLogContents [
            ("varName",varName),
            ("expr",show expr),
            ("calculated before isolating",show calculated_before)])

----------
----------
----------

isolateExpr :: String -> SymExpr -> SymbolicExecutionMonad (Either IsolationFailureReason SymExpr)
isolateExpr varName expr = do
  let innerLoc = loc ++ ".isolateExpr"
  constructLog innerLoc "isolateExpr" [("varName",varName),("expr",show expr)]
  case expr of
    SymVar _ vn _
      | varName == vn ->
          return $ Right expr
      | otherwise -> return $ Left VarAbsent
    ----------
    SBin expr1 op expr2
      | op `elem` [And, Or] -> do
          constructLog innerLoc
            (printf "%s is a Logical statement due to <%s>" (show expr) (show op))
            [("expr1",show expr1),("expr2",show expr2)]
          incrementLogDepth *>
            isolateLogic varName (expr1,op,expr2)
              <* decrementLogDepth
    ----------
    SBin expr1 op expr2
      | op `elem` [Eq, Neq, Lt, Le, Gt, Ge] -> do
          constructLog innerLoc
            (printf "%s is a Relational statement due to <%s>" (show expr) (show op))
            [("expr1",show expr1),("expr2",show expr2)]
          incrementLogDepth *>
            isolateRelation varName (expr1,op,expr2)
              <* decrementLogDepth
    ----------
    SBin expr1 op expr2 -> do
      constructLog innerLoc
        (printf "%s is a Term due to <%s>" (show expr) (show op))
            [("expr1",show expr1),("expr2",show expr2)]
      incrementLogDepth *>
        (Right <$> makeMostLeft varName (expr1,op,expr2))
          <* decrementLogDepth
    ----------
    SNot negatedExpr -> do
      constructLog innerLoc
        (printf "%s is a relation due to <SNot>" (show expr))
        [("Expression to negate",show negatedExpr)]
      
      either_isolated <- incrementLogDepth *>
        isolateExpr varName negatedExpr
          <* decrementLogDepth
      
      either
        (return . Left)
        (\isolated -> do
           incrementLogEnumeration
           negated <- incrementLogDepth *>
             negateBool isolated
               <* decrementLogDepth
           return $ Right negated)
        either_isolated
    ----------
    _ -> do
      constructLog innerLoc "TODO" [("expr",show expr)]
      error $ printf "TODO in %s ==> %s" innerLoc (show expr)

----------
----------
----------

negateBool :: SymExpr -> SymbolicExecutionMonad SymExpr
negateBool expr = do
  let innerLoc = "SymbolicExecution.Internal.Math.Isolator.negateBool"
  constructLog innerLoc "negateBool"
    [("expr",show expr)]
  toReturn <- case expr of
    --
    SBin l And r -> do
      new_l <- do
        incrementLogEnumeration
        incrementLogDepth *> negateBool l <* decrementLogDepth
      new_r <- do
        incrementLogEnumeration
        incrementLogDepth *> negateBool r <* decrementLogDepth
      return $ SBin new_l Or new_r
    --
    SBin l Or r -> do
      new_l <- do
        incrementLogEnumeration
        incrementLogDepth *> negateBool l <* decrementLogDepth
      new_r <- do
        incrementLogEnumeration
        incrementLogDepth *> negateBool r <* decrementLogDepth
      return $ SBin new_l And new_r
    --
    SBin l op r -> return
      $ SBin l (negateRelationalOperator op) r
    --
    SNot e -> return e
    --
    _ -> do
      constructLog innerLoc "TODO" [("expr",show expr)]
      undefined
  (tellNextLog $ Log.Return innerLoc (show toReturn)) $> toReturn
  where
  negateRelationalOperator :: SymBinOp -> SymBinOp
  negateRelationalOperator op = case op of
    Eq  -> Neq
    Neq -> Eq
    Lt  -> Ge
    Le  -> Gt
    Gt  -> Le
    Ge  -> Lt
    _   -> error $ printf "TODO in %s ==> %s"
      "SymbolicExecution.Internal.Math.Isolator.negateBool.negateRelationalOperator"
      (show op)

----------
----------
----------

isolateLogic :: String -> (SymExpr,SymBinOp,SymExpr) -> SymbolicExecutionMonad (Either IsolationFailureReason SymExpr)
isolateLogic varName (expr1,op,expr2) = do
  let innerLoc = loc ++ ".isolateLogic"
      logContentsList = [
        ("varName",varName)
       ,("expr1",show expr1)
       ,("op",show op)
       ,("expr2",show expr2)]
  constructLog innerLoc "isolateLogic" logContentsList
  incrementLogDepth
  whichSide0 <- whichSide varName (expr1,expr2)
  decrementLogDepth
  toReturn :: Either IsolationFailureReason SymExpr <- case whichSide0 of
    LeftSide -> do
      either_newExpr1 <- do
        incrementLogEnumeration
        incrementLogDepth *>
          isolateExpr varName expr1
            <* decrementLogDepth
      return $ (\expr1 -> SBin expr1 op expr2) <$> either_newExpr1
    RightSide -> do
      either_newExpr2 <- do
        incrementLogEnumeration
        incrementLogDepth *>
          isolateExpr varName expr2
            <* decrementLogDepth
      return $ (\expr2 -> SBin expr1 op expr2) <$> either_newExpr2
    BothSides -> do
      -- isolate left side
      leftSideIsolated :: Either IsolationFailureReason SymExpr <- do
        incrementLogEnumeration
        incrementLogDepth *>
          censor (map $ \(Log.Log num logTag) -> Log.Log num $ Log.Nested "Left Side" logTag)
                 (isolateExpr varName expr1)
            <* decrementLogDepth

      -- isolate right side
      rightSideIsolated :: Either IsolationFailureReason SymExpr <- do
        incrementLogEnumeration
        incrementLogDepth *>
          censor (map $ \(Log.Log num logTag) -> Log.Log num $ Log.Nested "Right Side" logTag)
                 (isolateExpr varName expr2)
            <* decrementLogDepth
      --
      case (leftSideIsolated,rightSideIsolated) of
        (Right l,Right r) -> return $ Right $ SBin l op r
        (Left _,Left _) -> throwError $ printf
          "TODO in %s\n\
          \%s" loc
          (constructLogContents [
             ("leftSideIsolated",show leftSideIsolated),
             ("rightSideIsolated",show rightSideIsolated)])
        (Left reason,_) -> return leftSideIsolated
        (_,Left reason) -> return rightSideIsolated
  (tellNextLog $ Log.Return innerLoc (show toReturn)) $> toReturn

----------
----------
----------

isolateRelation :: String -> (SymExpr,SymBinOp,SymExpr) -> SymbolicExecutionMonad (Either IsolationFailureReason SymExpr)
isolateRelation varName tu@(expr1,op,expr2) = do
  let innerLoc = loc ++ ".isolateRelation"
      logContentsList = [
        ("varName",varName)
       ,("expr1",show expr1)
       ,("op",show op)
       ,("expr2",show expr2)]
  constructLog innerLoc "isolateRelation" logContentsList
  incrementLogDepth
  whichSide0 <- whichSide varName (expr1,expr2)
  decrementLogDepth
  incrementLogEnumeration
  toReturn <- case whichSide0 of
    LeftSide ->
      incrementLogDepth *> isolateTerm varName tu <* decrementLogDepth
    RightSide ->
      incrementLogDepth *>
        isolateTerm varName (expr2,flipRelationalOperator op,expr1)
          <* decrementLogDepth
    BothSides -> do
      -- This is not isolation anymore,
      -- this is linear normalization / collection of like terms.
      
      -- isolate left side
      leftSideIsolated :: Either IsolationFailureReason SymExpr <-
        incrementLogDepth *>
          censor (map $ \(Log.Log num logTag) -> Log.Log num $ Log.Nested "Left Side" logTag)
                 (isolateExpr varName expr1)
            <* decrementLogDepth

      incrementLogEnumeration
      -- isolate right side
      rightSideIsolated :: Either IsolationFailureReason SymExpr <-
        incrementLogDepth *>
          censor (map $ \(Log.Log num logTag) -> Log.Log num $ Log.Nested "Right Side" logTag)
                 (isolateExpr varName expr2)
            <* decrementLogDepth
      
      incrementLogEnumeration
      -- collect the variable from the right side
      -- then displace it to the left side
      -- and then move the not-to-be-isolated expressions to the right side
      do
        incrementLogDepth
        newSymExpr <- case (leftSideIsolated,rightSideIsolated) of
          (Right l,Right r) -> Right <$> collectBothSides varName l op r
          _ -> throwError $ printf
            "TODO in %s\n\
            \%s" loc
            (constructLogContents [
              ("leftSideIsolated",show leftSideIsolated),
              ("rightSideIsolated",show rightSideIsolated)])
        decrementLogDepth
        return newSymExpr
  (tellNextLog $ Log.Return innerLoc (show toReturn)) $> toReturn

----------
----------
----------

isolateTerm :: String -> (SymExpr,SymBinOp,SymExpr) -> SymbolicExecutionMonad (Either IsolationFailureReason SymExpr)
isolateTerm varName tu@(term,op,rhs) = do
  let innerLoc = loc ++ ".isolateTerm"
      logContentsList = [
        ("varName",varName)
       ,("term",show term)
       ,("op",show op)
       ,("rhs",show rhs)]
  constructLog innerLoc "isolateTerm" logContentsList
  toReturn <- case term of
    -- Term has +
    SBin a Add b -> do
      whichSide0 <- incrementLogDepth *> whichSide varName (a,b) <* decrementLogDepth
      case whichSide0 of
        LeftSide -> incrementLogEnumeration >>
          incrementLogDepth *>
            isolateTerm varName (a,op,SBin rhs Sub b)
              <* decrementLogDepth
        RightSide -> incrementLogEnumeration >>
          incrementLogDepth *>
            isolateTerm varName (b,op,SBin rhs Sub a)
              <* decrementLogDepth
        BothSides -> do
          constructLog innerLoc "TODO1: BothSides" logContentsList
          undefined
    -- Term has -
    SBin a Sub b -> do
      whichSide0 <- incrementLogDepth *> whichSide varName (a,b) <* decrementLogDepth
      case whichSide0 of
        LeftSide -> incrementLogEnumeration >>
          incrementLogDepth *>
            isolateTerm varName (a,op,SBin rhs Add b)
              <* decrementLogDepth
        RightSide -> incrementLogEnumeration >>
          incrementLogDepth *>
            isolateTerm varName (b,flipRelationalOperator op,SBin a Sub rhs)
              <* decrementLogDepth
        BothSides -> do
          constructLog innerLoc "TODO2: BothSides" logContentsList
          undefined
    -- Term has %
    SBin a Mod _ -> case a of
      SymVar _ vn _
        | vn == varName -> return $ Right $ SBin term op rhs
      _ -> throwError $ printf
             "TODO in %s\n\
             \%s" loc
             (constructLogContents [("term",show term)])
    -- Term has *
    -- Term has /
    SBin a termOp b -> do
      let flipFactorOp = case termOp of
            Mul -> Div
            Div -> Mul
      whichSide0 <- incrementLogDepth *> whichSide varName (a,b) <* decrementLogDepth
      case whichSide0 of
        LeftSide -> do
          either_newOp_newRhs{-(newOp,newRhs)-} <- do
            incrementLogEnumeration
            incrementLogDepth *> moveTermToRhs op (rhs,flipFactorOp,b) <* decrementLogDepth
          either
            (return . Left)
            (\(newOp,newRhs) -> do
              incrementLogEnumeration
              incrementLogDepth *>
                isolateTerm varName (a,newOp,newRhs)
                  <* decrementLogDepth)
            either_newOp_newRhs
        RightSide -> do
          either_newOp_newRhs{-(newOp,newRhs)-} <- do
            incrementLogEnumeration
            incrementLogDepth *> moveTermToRhs op (rhs,flipFactorOp,a) <* decrementLogDepth
          either
            (return . Left)
            (\(newOp,newRhs) -> do
              incrementLogEnumeration
              incrementLogDepth *>
                isolateTerm varName (b,newOp,newRhs)
                  <* decrementLogDepth)
            either_newOp_newRhs
    -- Term is a var
    SymVar _ vn _
      | vn == varName -> return $ Right $ SBin term op rhs
      | otherwise -> throwError $ printf
          "won't happen in %s\n%s" innerLoc (constructLogContents [("term",show term)])
    --
    _ -> constructLog innerLoc "TODO1" logContentsList >> undefined
  (tellNextLog $ Log.Return innerLoc (show toReturn)) $> toReturn
  where
  moveTermToRhs :: SymBinOp -> (SymExpr,SymBinOp,SymExpr) -> SymbolicExecutionMonad (Either IsolationFailureReason (SymBinOp,SymExpr))
  moveTermToRhs relationalOp (rhs,termOp,symExpr) = do
    let innerLoc = loc ++ ".isolateTerm.moveTermToRhs"
    constructLog innerLoc "isolateTerm.moveTermToRhs"
      [("relationalOp",show relationalOp)
      ,("rhs",show rhs)
      ,("symExpr",show symExpr)]
    let newSymExpr = SBin rhs termOp symExpr
    let eitherNewRelationalOp = flip fmap (knowSign symExpr)
          $ \case PositiveSign -> relationalOp
                  NegativeSign -> flipRelationalOperator relationalOp
    
    let toReturn = bimap
          AmbiguousSign
          (\e -> (e,newSymExpr))
          eitherNewRelationalOp
    case eitherNewRelationalOp of
      Left vn -> do
        constructLog innerLoc "unknown sign prevents isolation"
          [("sign of",vn)
          ,("is unknown due to", show newSymExpr)] $> ()
      Right newRelationalOp
        | relationalOp /= newRelationalOp ->
            constructLog innerLoc "relaional operation is flipped"
              [("new relational operator",show newRelationalOp)] $> ()
        | otherwise -> return ()
    (tellNextLog $ Log.Return innerLoc (show toReturn)) $> toReturn

----------
----------
----------

-- this function gets called only when `varName` exists on both sides of a relation.
collectBothSides :: String -> SymExpr -> SymBinOp -> SymExpr -> SymbolicExecutionMonad SymExpr
collectBothSides varName expr1 op expr2 = do
  let innerLoc = loc ++ ".collectBothSides"
  let logContents = 
        [("varName",varName)
        ,("expr1",show expr1)
        ,("op",show op)
        ,("expr2",show expr2)]
  constructLog innerLoc "collectBothSides" logContents
  
  incrementLogEnumeration
  (targetL,opL,otherL) <- 
    incrementLogDepth *>
      censor (map $ \(Log.Log num logTag) -> Log.Log num $ Log.Nested "Left Side" logTag)
             (collectTerms varName expr1)
        <* decrementLogDepth
  incrementLogEnumeration
  (targetR,opR,otherR) <-
    incrementLogDepth *>
      censor (map $ \(Log.Log num logTag) -> Log.Log num $ Log.Nested "Right Side" logTag)
             (collectTerms varName expr2)
        <* decrementLogDepth
  
  let combine :: (Maybe SymExpr,SymBinOp,Maybe SymExpr) -> Maybe SymExpr
      combine tu@(maybeL,innerOp,maybeR) = case (maybeL,maybeR) of
        (Just l,Just r) -> Just $ SBin l innerOp r
        (Just l,Nothing) -> Just l
        (Nothing,Nothing) -> Nothing
        (Nothing,Just r)  -> Just $ buildSignedTerm innerOp r

  case (combine (targetL,flipTermOperator opR,targetR)
       ,combine (otherR ,flipTermOperator opL,otherL)) of
    (Just sideL,Just sideR) -> return $ SBin sideL op sideR
    _ -> do
      constructLog innerLoc "TODO"
        $ logContents
        ++ [("targetL",show targetL)
           ,("otherL",show otherL)
           ,("targetR",show targetR)
           ,("otherR",show otherR)]
      undefined

----------
----------
----------

collectTerms :: String -> SymExpr -> SymbolicExecutionMonad (Maybe SymExpr,SymBinOp,Maybe SymExpr)
collectTerms varName symExpr = do
  let innerLoc = loc ++ ".collectTerms"
      logContents =
        [("varName",varName)
        ,("symExpr",show symExpr)]
  constructLog innerLoc "collectTerms" logContents
  toReturn <- case symExpr of
    SBin symExpr1 Add symExpr2 -> do
      -- seperate in the left
      (maybe_targetL,_,maybe_otherL) <- do
        incrementLogEnumeration
        incrementLogDepth *>
          collectTerms varName symExpr1
            <* decrementLogDepth
      -- seperate in the right
      (maybe_targetR,_,maybe_otherR) <- do
        incrementLogEnumeration
        incrementLogDepth *>
          collectTerms varName symExpr2
            <* decrementLogDepth
      -- combining
      let combine :: (Maybe SymExpr,Maybe SymExpr) -> Maybe SymExpr
          combine tu@(maybeL,maybeR) = case tu of
            (Just l,Just r) -> Just $ SBin l Add r
            (Just l,Nothing) -> Just l
            (Nothing,Nothing) -> Nothing
            (Nothing,Just r)  -> Just r
      -- done
      return (combine (maybe_targetL,maybe_targetR)
             ,Add
             ,combine (maybe_otherR,maybe_otherL))
    --
    SBin symExpr1 Sub symExpr2 -> do
      -- seperate in the left
      (maybe_targetL,_,maybe_otherL) <- do
        incrementLogEnumeration
        incrementLogDepth *>
          collectTerms varName symExpr1
            <* decrementLogDepth
      -- seperate in the right
      (maybe_targetR,_,maybe_otherR) <- do
        incrementLogEnumeration
        incrementLogDepth *>
          collectTerms varName symExpr2
            <* decrementLogDepth
      -- combining
      let combine :: (Maybe SymExpr,Maybe SymExpr) -> Maybe SymExpr
          combine tu@(maybeL,maybeR) = case tu of
            (Just l,Just r) -> Just $ SBin l Sub r
            (Just l,Nothing) -> Just l
            (Nothing,Nothing) -> Nothing
            (Nothing,Just r)  -> Just r
      -- done
      return (combine (maybe_targetL,maybe_targetR)
             ,Sub
             ,combine (maybe_otherR,maybe_otherL))
    _
      | varName `existsIn` symExpr -> return (Just symExpr,Add,Nothing)
      | otherwise -> return (Nothing,Add,Just symExpr)
  (tellNextLog $ Log.Return innerLoc (show toReturn)) $> toReturn
----------
----------
----------

makeMostLeft :: String -> (SymExpr,SymBinOp,SymExpr) -> SymbolicExecutionMonad SymExpr
makeMostLeft varName (expr1,op,expr2) = do
  let innerLoc = loc ++ ".makeMostLeft"
      logContentsList = [
        ("varName",varName)
       ,("expr1",show expr1)
       ,("op",show op)
       ,("expr2",show expr2)]
  constructLog innerLoc "makeMostLeft" logContentsList
  incrementLogDepth
  whichSide0 <- whichSide varName (expr1,expr2)
  decrementLogDepth
  toReturn <- case whichSide0 of
    LeftSide -> return $ SBin expr1 op expr2
    RightSide -> do
      let moving = buildSumTerm expr2 (op,Add) expr1
      constructLog innerLoc "moving right to left"
        $ logContentsList
        ++ [("result",show moving)]
      case moving of
        SBin newExpr1 newOp newExpr2 -> do
          incrementLogEnumeration
          incrementLogDepth *>
            makeMostLeft varName (newExpr1,newOp,newExpr2)
              <* decrementLogDepth
    BothSides -> throwError $ printf
      "TODO (BothSides) in %d:\n%s" innerLoc (
        intercalate "\n"
        $ map (\(counter,tu) -> printf "%d) %s" counter (show tu))
        $ zip [1::Int ..] logContentsList)
  (tellNextLog $ Log.Return innerLoc (show toReturn)) $> toReturn

----------
----------
----------

flipRelationalOperator :: SymBinOp -> SymBinOp
flipRelationalOperator = \case 
  Eq  -> Eq
  Neq -> Neq
  Lt  -> Gt
  Le  -> Ge
  Gt  -> Lt
  Ge  -> Le

----------
----------
----------

flipTermOperator :: SymBinOp -> SymBinOp
flipTermOperator = \case
  Add -> Sub
  Sub -> Add

----------
----------
----------

data Sign =
    PositiveSign
  | NegativeSign
  deriving Show

knowSign :: SymExpr -> Either String Sign
knowSign symExpr = case symExpr of
  SymVar _ vn _ -> Left vn
  SymInt n
    | n > 0 -> Right PositiveSign
    | n < 0 -> Right NegativeSign
  SymNum n
    | n > 0 -> Right PositiveSign
    | n < 0 -> Right NegativeSign
  SymFloat n
    | n > 0 -> Right PositiveSign
    | n < 0 -> Right NegativeSign
  SymDouble n
    | n > 0 -> Right PositiveSign
    | n < 0 -> Right NegativeSign
  SBin expr1 op expr2
    | op `elem` [Mul,Div] -> case (knowSign expr1,knowSign expr2) of
        (Left vn,_) -> Left vn
        (_,Left vn) -> Left vn
        (Right PositiveSign,Right PositiveSign) -> Right PositiveSign
        (Right NegativeSign,Right NegativeSign) -> Right PositiveSign
        (Right PositiveSign,Right NegativeSign) -> Right NegativeSign
        (Right NegativeSign,Right PositiveSign) -> Right NegativeSign
    | otherwise -> Right PositiveSign
  _ -> error $ printf "TODO in %s:\n"
    "SymbolicExecution.Internal.Math.Isolator.knowSign"
    (constructLogContents [("symExpr",show symExpr)])

buildSumTerm :: SymExpr -> (SymBinOp,SymBinOp) -> SymExpr -> SymExpr
buildSumTerm l (signL,signR) r = let
  innerLoc = loc ++ ".buildSumTerm"
  typeL = toSymType2 l
  typeR = toSymType2 r
  mutualType
    | typeL `isInstanceOf` typeR = typeL
    | typeR `isInstanceOf` typeL = typeR
    | otherwise = error $ constructLogContents
        [("l",show l)
        ,("signL",show signL)
        ,("signR",show signR)
        ,("r",show r)
        ,("typeL",show typeL)
        ,("typeR",show typeR)]
  in case (signL,signR) of
    (Add,Add) -> SBin l Add r
    (Add,Sub) -> SBin l Sub r
    (Sub,Add) -> SBin
      (SBin (cast mutualType $ SymNum (-1)) Mul l) Add r
    (Sub,Sub) ->
      SBin (cast mutualType $ SymNum (-1)) Mul (SBin l Add r)

----------
----------
----------

buildSignedTerm :: SymBinOp -> SymExpr -> SymExpr
buildSignedTerm op symExpr = case op of
  Add -> symExpr
  Sub -> SBin (cast (toSymType2 symExpr) $ SymNum (-1))
              Mul
              symExpr

----------
----------
----------

data Side = LeftSide | RightSide | BothSides deriving (Show,Eq)

whichSide :: String -> (SymExpr,SymExpr) -> SymbolicExecutionMonad Side
whichSide varName (expr1,expr2) = do
  let innerLoc = loc ++ ".whichSide"
  constructLog innerLoc "whichSide"
    [("varName",varName)
    ,("expr1",show expr1)
    ,("expr2",show expr2)]
  let toReturn = case (varName `existsIn` expr1,varName `existsIn` expr2) of
        (True,True) -> BothSides
        (True,False) -> LeftSide
        (False,True) -> RightSide
        (False,False) -> error $ printf "Won't happen in %s ==> (%s,%s)" innerLoc (show expr1) (show expr2)
  (tellNextLog $ Log.Return innerLoc (show toReturn)) $> toReturn
  
----------
----------
----------

run_isolate :: SymbolicExecutionMonad (Either IsolationFailureReason SymExpr) -> (String,Either String (Either IsolationFailureReason SymExpr))
run_isolate = runMonad
