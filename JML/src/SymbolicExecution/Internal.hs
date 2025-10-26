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

-- will be used in `sumUpSymExprs`
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

sumUpSymExprs :: AST.BinOp -> (SymExpr, SymExpr) -> SymExpr
sumUpSymExprs op = \case
  (SymNum num1, SymNum num2) ->
    SymNum (getFractionalArithBinOp op num1 num2)
  (SymInt num1, SymInt num2) ->
    SymInt (getIntegralArithBinOp op num1 num2)
  (SymDouble num1, SymDouble num2) ->
    SymDouble (getFractionalArithBinOp op num1 num2)
  (SymFloat num1, SymFloat num2) ->
    SymFloat (getFractionalArithBinOp op num1 num2)
  (a@(SymFormalParam _ _ _), b@(SymFormalParam _ _ _)) ->
    SBin a (toSymBinOp op) b
  (a@(SymGlobalVar _ _), b@(SymGlobalVar _ _)) ->
    SBin a (toSymBinOp op) b
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
    SBin (cast t a) (toSymBinOp op) b
  (a@(SymFormalParam t _ _), b) ->
    SBin a (toSymBinOp op) (cast t b)
----------
  (a, b@(SymGlobalVar t _)) ->
    SBin (cast t a) (toSymBinOp op) b
  (a@(SymGlobalVar t _), b) ->
    SBin a (toSymBinOp op) (cast t b)
----------
-- determine SymType and cast it on the other SymExprs.
-- if not found, then java syntactical error,
--     which will not happen, because safety of type checking is assumed.
  (a@(SBin symExpr1 op1 symExpr2), b) ->
    let op2 = toSymBinOp op
    in maybe (error "sumUpSymExprs ~~> won't happen 1") id $ do
    symType <- findSymType [a,b]
    return $ SBin (SBin (cast symType symExpr1) op1 (cast symType symExpr2)) op2 (cast symType b)
  (a, b@(SBin symExpr1 op1 symExpr2)) ->
    let op2 = toSymBinOp op
    in maybe (error "sumUpSymExprs ~~> won't happen 2") id $ do
    symType <- findSymType [a,b]
    return $ SBin a op2 (SBin (cast symType symExpr1) op1 (cast symType symExpr2))
----------
  (a,b) -> error $ printf "sumUpSymExprs: %s %s %s" (show a) (show op) (show b)

-- The type of the variable in `symExpr` needs to conform to `symType`.
-- This matters in the context of `AssignExpr`, and `BinOpExpr`
cast :: SymType -> SymExpr -> SymExpr
cast symType symExpr = case symExpr of
  SymNum _ -> case symType of
                Int    -> sumUpSymExprs AST.Plus (symExpr, SymInt 0)
                Double -> sumUpSymExprs AST.Plus (symExpr, SymDouble 0)
                Float  -> sumUpSymExprs AST.Plus (symExpr, SymFloat 0)
                Bool   -> error "cast ~~> won't happen"
                Void   -> error "cast ~~> won't happen"
  a -> a

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
  SymFormalParam symType _ _ -> error "substitute ==> TODO"
  actualParam@(SymInt _) -> actualParam

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
