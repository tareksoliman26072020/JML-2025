{-# Language LambdaCase #-}
module SymbolicExecution.Internal where

import SymbolicExecution.Types
import qualified SymbolicExecution.Log as Log
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer
import qualified CFG.Types as CFG
import qualified Parser.Types as AST
import Text.Printf (printf)
import Control.Applicative (Alternative(empty),asum)
import qualified Data.Map as Map (lookup)
import Prelude hiding (negate)

------------------------------
------------------------------
------------------------------

toSymBinOp :: AST.BinOp -> SymBinOp
toSymBinOp AST.Plus = Add
toSymBinOp AST.Mult = Mul
toSymBinOp AST.Minus = Sub
toSymBinOp AST.Div = Div
toSymBinOp _ = error "toSymBinOp ~~> TODO"

fromSymBinOp :: SymBinOp -> AST.BinOp
fromSymBinOp = \case
  Add -> AST.Plus
  Mul -> AST.Mult
  Sub -> AST.Minus
  Div -> AST.Div
  _   -> error "fromSymBinOp ~~> TODO"

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
toSymType2 symExpr = error $ "toSymType2 ~~> TODO: " ++ show symExpr

-- will be used in `calculate`
toSymType3 :: SymExpr -> Maybe SymType
toSymType3 = \case
  SymNum _ -> empty
  SymInt _ -> pure Int
  SymDouble _ -> pure Double
  SymFloat _ -> pure Float
  SBool _ -> pure Bool
  SBin symExpr1 _ symExpr2 -> asum $ map toSymType3 [symExpr1,symExpr2]
  SNot symExpr -> toSymType3 symExpr
--SymFormalParam SymType String (Maybe SymExpr)
  SymFormalParam t _ mSymExpr -> pure t
  symExpr -> error $ "toSymType3 ~~> TODO: " ++ show symExpr

findSymType :: [SymExpr] -> Maybe SymType
findSymType = asum . map toSymType3

getReturnSymExpr :: SymState -> Maybe SymExpr
getReturnSymExpr = Map.lookup "return" . env

getSymExpr :: ExecutionResult -> SymExpr
getSymExpr er@(ER_Expr symExpr) = symExpr
getSymExpr er = error $ "getSymExpr ~~> TODO: " ++ show er

------------------------------
------------------------------
------------------------------

isSymInt :: SymExpr -> Bool
isSymInt = \case
  SymInt _ -> True
  _        -> False

isSymDouble :: SymExpr -> Bool
isSymDouble = \case
  SymDouble _ -> True
  _           -> False

isSymFloat :: SymExpr -> Bool
isSymFloat = \case
  SymFloat _ -> True
  _          -> False

calculate :: SymBinOp -> (SymExpr, SymExpr) -> SymExpr
calculate op = \case
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
  --
  (a@(SymFormalParam _ _ _), b@(SymFormalParam _ _ _)) ->
    SBin a op b
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
  (a, b@(SymFormalParam t _ _)) ->
    SBin (cast t a) op b
  (a@(SymFormalParam t _ _), b) ->
    SBin a op (cast t b)
----------
  (a, b@(SymGlobalVar t _)) ->
    SBin (cast t a) op b
  (a@(SymGlobalVar t _), b) ->
    SBin a op (cast t b)
----------
-- determine SymType and cast it on the other SymExprs.
-- if not found, then java syntactical error,
--     which will not happen, because safety of type checking is assumed.
  (a@(SBin symExpr1 op1 symExpr2), b) ->
    maybe (error "calculate ~~> won't happen 1") id $ do
      symType <- findSymType [a,b]
      let expr1 = calculate op1 (cast symType symExpr1,cast symType symExpr2)
          expr2 = cast symType b
      return $ (if all isAtomic [expr1,expr2] then calculate0 else id)
             $ SBin expr1 op expr2
  (a, b@(SBin symExpr1 op1 symExpr2)) ->
    maybe (error "calculate ~~> won't happen 2") id $ do
      symType <- findSymType [a,b]
      let expr1 = cast symType a
          expr2 = calculate op1 (cast symType symExpr1,cast symType symExpr2)
      return $ (if all isAtomic [expr1,expr2] then calculate0 else id)
             $ SBin expr1 op expr2
----------
  (a,b) -> error $ printf "calculate: %s %s %s" (show a) (show op) (show b)

calculate0 :: SymExpr -> SymExpr
calculate0 (SBin expr1 op expr2) = calculate op (expr1,expr2)

negate :: SymExpr -> SymExpr
negate symExpr = error $ "TODO: negate ~~> " ++ show symExpr

isAtomic :: SymExpr -> Bool
isAtomic = \case
  SymNum _ -> True
  SymInt _ -> True
  SymDouble _ -> True
  SymFloat _ -> True
  SymFormalParam _ _ _ -> False
  SymGlobalVar _ _ -> False
  SBin expr1 _ expr2 -> all isAtomic [expr1,expr2]
  expr -> error $ printf "TODO: isAtomic: %s" (show expr)

{-
Add (SymInt 0, SymNum 2) = cast Int (SymNum 2)
                         = calculate Add (SymNum 2, SymInt 0)
-}
-- The type of the variable in `symExpr` needs to conform to `symType`.
-- This matters in the context of `AssignExpr`, and `BinOpExpr`
cast :: SymType -> SymExpr -> SymExpr
cast symType symExpr = case symExpr of
  SymNum num -> case symType of
                Int    -> SymInt (round num)
                Double -> SymDouble (toDouble num)
                Float  -> SymFloat num
                Bool   -> error "cast ~~> won't happen"
                Void   -> error "cast ~~> won't happen"
  a -> a
--a -> error $ printf "TODO ~~> cast (%s) (%s)" (show symType) (show symExpr)

toDouble :: Float -> Double
toDouble = read . show

getIntegralArithBinOp :: Integral a => SymBinOp -> (a -> a -> a)
getIntegralArithBinOp = \case
    Add -> (+)
    Mul -> (*)
    Sub -> (-)

getFractionalArithBinOp :: Fractional a => SymBinOp -> (a -> a -> a)
getFractionalArithBinOp = \case
    Add -> (+)
    Mul -> (*)
    Sub -> (-)
    Div -> (/)

------------------------------
------------------------------
------------------------------

-- replaces an occurrance of formalParam with the given actualParam
-- useful in MethodCall.hs
substitute :: String -> SymExpr -> SymExpr
substitute formalParam = \case
  actualParam@(SBin symExpr1 symBinOp symExpr2) ->
    SBin (substitute formalParam symExpr1) symBinOp (substitute formalParam symExpr2)
  actualParam@(SymFormalParam symType _ Nothing) -> actualParam
    --SymActualParam symType formalParam actualParam
  SymFormalParam symType _ _ -> error "substitute ~~> TODO1"
  actualParam@(SymInt _) -> actualParam
  --numExpr@(NumberLiteral num) -> --cast :: SymType -> SymExpr -> SymExpr
    --cast numExpr
  act -> error $ printf "substitute ~~> TODO2: (%s,%s)" formalParam (show act)

-- Extracting ExecutionResult from the monadic type Method_R
-- useful for debugging
method_R_2_ExecutionResult ::((Config,[CFG.CFG]),SymState) -> Method_R -> ExecutionResult
method_R_2_ExecutionResult (r,s) mo =
  let run_r :: ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))) ExecutionResult
      run_r = runReaderT mo r--(defaultConfig,cfgs)
      run_e :: WriterT [Log.Log] (StateT SymState (Either String)) (Either String ExecutionResult)
      run_e = runExceptT run_r
      run_w :: StateT SymState (Either String) (Either String ExecutionResult,[Log.Log])
      run_w = runWriterT run_e
      mRun_s :: Either String ((Either String ExecutionResult,[Log.Log]),SymState)
      mRun_s = runStateT run_w s
  in case mRun_s of
       Left str -> error $ "method_R_2_ExecutionResult: 1: " ++ str
     --Right ((ei,logs),SymState m ps) ->
       Right ((ei,_),_) -> either
         (\e -> error $ "method_R_2_ExecutionResult: 2: " ++ e)
         id ei
