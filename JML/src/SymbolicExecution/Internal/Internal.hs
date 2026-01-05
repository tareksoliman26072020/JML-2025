{-# Language LambdaCase #-}
module SymbolicExecution.Internal.Internal where

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
import qualified Data.Map as Map (lookup,empty,Map,filterWithKey,insert,foldMapWithKey)
import Prelude hiding (negate)
import Data.List (nub)

------------------------------
------------------------------
------------------------------

toSymBinOp :: AST.BinOp -> SymBinOp
toSymBinOp = \case
  AST.Plus -> Add
  AST.Mult -> Mul
  AST.Minus -> Sub
  AST.Div -> Div
  AST.Less -> Lt
  AST.LessEq -> Le
  AST.Greater -> Gt
  AST.GreaterEq -> Ge
  AST.Eq -> Eq
  AST.Neq -> Neq
  AST.And -> And
  AST.Or -> Or
  _ -> error "toSymBinOp ~~> TODO"

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
isGlobalVariable (SymGlobalVar _ _ _) = True
isGlobalVariable _ = False

nodeHasGlobalVar :: Map.Map SymStateKey SymExpr -> CFG.Node -> Bool
nodeHasGlobalVar ma = \case
  CFG.Node _ (CFG.Statement stmt) _ ->
    let varName = AST.getVarName (AST.getExpression stmt)
    in case Map.lookup GlobalVars ma of
         Nothing -> False
         Just (SGlobalVars li) -> varName `elem` li
  node -> error $ "TODO: nodeHasGlobalVar: " ++ show node

nodeHasFormalParm :: Map.Map SymStateKey SymExpr -> CFG.Node -> Bool
nodeHasFormalParm ma = \case
  CFG.Node _ (CFG.Statement stmt) _ ->
    let varName = AST.getVarName (AST.getExpression stmt)
    in case Map.lookup FormalParms ma of
         Nothing -> False
         Just (SGlobalVars li) -> varName `elem` li
  node -> error $ "TODO: nodeHasLocalParm: " ++ show node

recordFormalParm :: String -> Map.Map SymStateKey SymExpr -> Map.Map SymStateKey SymExpr
recordFormalParm varName ma =
  let lookingup = Map.lookup FormalParms ma
  in case lookingup of
       Nothing -> Map.insert FormalParms (SFormalParms [varName]) ma
       Just (SFormalParms li)
         | varName `elem` li -> ma
         | otherwise -> Map.insert FormalParms (SFormalParms $ li ++ [varName]) ma

recordGlobalVar :: String -> Map.Map SymStateKey SymExpr -> Map.Map SymStateKey SymExpr
recordGlobalVar varName ma =
  let lookingup = Map.lookup GlobalVars ma
  in case lookingup of
       Nothing -> Map.insert GlobalVars (SGlobalVars [varName]) ma
       Just (SGlobalVars li)
         | varName `elem` li -> ma
         | otherwise -> Map.insert GlobalVars (SGlobalVars $ li ++ [varName]) ma

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

isSymString :: SymExpr -> Bool
isSymString = \case
  SymString _ -> True
  _ -> False

isVar :: SymExpr -> Bool
isVar = \case
  SymNum _ -> False
  SymInt _ -> False             -- ^ concrete integer literal
  SymDouble _ -> False
  SymFloat _ -> False
  SBool _ -> False
  SBin expr1 _ expr2 -> any isVar [expr1,expr2]
  SNot expr -> isVar expr
  SymFormalParam _ _ Nothing -> True
  SymFormalParam _ _ (Just expr) -> isVar expr
  SymGlobalVar _ _ Nothing -> True
  SymGlobalVar _ _ (Just expr) -> isVar expr
  expr -> error $ "TODO: isVar: " ++ show expr

isArray :: SymExpr -> Bool
isArray = \case
  SymArray _ _ _ -> True
  SymFormalParam (Array _) _ _ -> True
  SymGlobalVar (Array _) _ _ -> True
  _ -> False

-- get SymType via AST.Type
toSymType1 :: AST.Type AST.Types -> SymType
toSymType1 = \case
  AST.BuiltInType t -> case t of
    AST.Int     -> Int
    AST.Void    -> Void
    AST.Char    -> undefined
    AST.String  -> String
    AST.Boolean -> Bool
    AST.Double  -> Double
    AST.Short   -> undefined
    AST.Float   -> Float
    AST.Long    -> undefined
    AST.Byte    -> undefined
-- ArrayType {baseType :: Type a}
  AST.ArrayType t ->
    let rec = toSymType1 t
    in Array rec
  AST.AnyType "String" _ -> String
  e -> error $ "TODO: toSymType1: " ++ show e

-- get SymType via SymExpr
toSymType2 :: SymExpr -> SymType
toSymType2 (SymInt _) = Int
toSymType2 (SymDouble _) = Double
toSymType2 (SymFloat _) = Float
toSymType2 (SBool _) = Bool
toSymType2 (SymNull t) = t
toSymType2 (SymFormalParam t _ _) = t
toSymType2 (SymGlobalVar t _ _) = t
toSymType2 (SObjAcc li) = case li of
  [_,"length"] -> Int
  _ -> error $ "TODO1: toSymType2 ==> " ++ show (SObjAcc li)
toSymType2 symExpr = error $ "TODO2: toSymType2 ==> " ++ show symExpr

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
  SymFormalParam t _ mSymExpr -> pure t
  SymGlobalVar t _ mSymExpr -> pure t
  symExpr -> error $ "toSymType3 ~~> TODO: " ++ show symExpr

findSymType :: [SymExpr] -> Maybe SymType
findSymType = asum . map toSymType3

getReturnSymExpr :: SymState -> Maybe SymExpr
getReturnSymExpr = Map.lookup Return . env

getSymExpr :: ExecutionResult -> SymExpr
getSymExpr er@(ER_Expr symExpr) = symExpr
getSymExpr er = error $ "getSymExpr ~~> TODO: " ++ show er

------------------------------
------------------------------
------------------------------

getVarName :: SymExpr -> String
getVarName = \case
  SymFormalParam _ varName _ -> varName
  SymGlobalVar _ varName _ -> varName
  e@(SBin expr1 _ expr2) ->
    let n1 = if isVar expr1 then Just $ getVarName expr1 else Nothing
        n2 = if isVar expr2 then Just $ getVarName expr2 else Nothing
    in case (n1,n2) of
         (Nothing,Nothing) -> error $ "won't happen1: getVarName: " ++ show e
         (Just n,Nothing) -> n
         (Nothing,Just n) -> n
         (Just x,Just y) -> error $ "TODO: getVarName: " ++ show e
  symExpr -> error $ "won't happen2: getVarName: " ++ show symExpr

get_SItes :: Map.Map SymStateKey SymExpr -> Map.Map SymStateKey SymExpr
get_SItes m = flip Map.filterWithKey m $ \_ -> \case
  SIte _ _ _ -> True
  _ -> False

get_SLoops :: Map.Map SymStateKey SymExpr -> Map.Map SymStateKey SymExpr
get_SLoops m = flip Map.filterWithKey m $ \_ -> \case
  SLoop _ _ _ -> True
  _ -> False
  
findVarName :: String -> Map.Map SymStateKey SymExpr -> Maybe SymExpr
findVarName str = Map.lookup (VarName str)

findVarNameOccurrence :: String -> Map.Map SymStateKey SymExpr -> [SymExpr]
findVarNameOccurrence varName ma = nub $ flip Map.foldMapWithKey ma $ \k v -> case (k,v) of
  (VarName vn,_) -> [v]
  (BranchRange _, SIte _ ifSymState mElseSymState) ->
    findVarNameOccurrence varName (env ifSymState) ++
    maybe [] (\s -> findVarNameOccurrence varName (env s)) mElseSymState
  (BranchRange _, SLoop _ _ _) -> error "findVarNameOccurrence ==> won't happen"

simplify :: SymExpr -> SymExpr
simplify = \case
  SymFormalParam _ _ (Just expr) -> expr
  SymGlobalVar _ _ (Just expr) -> expr
  e -> e

multiplyOps :: SymBinOp -> SymBinOp -> SymBinOp
multiplyOps op1 op2 = case (op1,op2) of
  (Add,Add) -> Add
  (Add,Sub) -> Sub
  (Sub,Add) -> Sub
  (Sub,Sub) -> Add
  _ -> error "won't happen"

-- `newSymNum` is used to create either SymNum 1 or SymNum -1
-- This comes in handy while using multiplOps in Calculator.hs
newSymNum :: SymBinOp -> SymExpr
newSymNum = \case
  Add -> SymNum 1
  Sub -> SymNum (-1)
  _   -> error "won't happen"
{-
Add (SymInt 0, SymNum 2) = cast Int (SymNum 2)
                         = SymInt 2
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
                Array t -> cast t (SymNum num)
                _ -> error $ "TODO: cast ==> " ++ show symType
  SBin expr1 op expr2 -> SBin (cast symType expr1) op (cast symType expr2)
  --SymArray (Maybe SymType) (Maybe Int) [SymExpr]
  SymArray _ mInt symExprs -> SymArray (Just symType) mInt (map (cast symType) symExprs)
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

getArithBoolOp :: Ord a => SymBinOp -> (a -> a -> Bool)
getArithBoolOp = \case
  Eq -> (==)
  Neq -> (/=)
  Lt -> (<)
  Le -> (<=)
  Gt -> (>)
  Ge -> (>=)

getBoolOp :: SymBinOp -> (Bool -> Bool -> Bool)
getBoolOp = \case
  And -> (&&)
  Or -> (||)

toBinSymExpr :: SymBinOp -> (SymExpr, SymExpr) -> SymExpr
toBinSymExpr op (expr1,expr2) = SBin expr1 op expr2

negate :: SymExpr -> SymExpr
negate symExpr = error $ "TODO: negate ~~> " ++ show symExpr

negateOp :: SymBinOp -> SymBinOp
negateOp = \case
  Add -> Sub
  Sub -> Add
  _   -> error "negateOP ==> won't happen"

------------------------------
------------------------------
------------------------------

getVarBindings :: SymState -> Map.Map String Node_Coor
getVarBindings symState = case Map.lookup VarBindings (env symState) of
  Nothing -> Map.empty
  Just (SVarBindings li) -> li

getNewVarBinding :: Int -> Int -> AST.Statement -> Maybe (String,Node_Coor)
getNewVarBinding nodeId branchId = \case
  -- AssignStmt {varModifier :: [Modifier], assign :: Expression}
  AST.AssignStmt _ expr -> case expr of
    --AssignExpr {assEleft :: Expression, assEright :: Expression}
    AST.AssignExpr left _ -> case left of
      AST.VarExpr{} -> case AST.varType left of
        Just _ ->
          Just (AST.varName left,Node_Coor nodeId branchId)
        Nothing -> Nothing
      AST.ArrayCallExpr{} -> Nothing
      _ -> error $ "getNewVarBinding -> won't happen1: " ++ show left
    _ -> error "getNewVarBinding -> won't happen2"
  ----------
  --VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}}
  stmt@AST.VarStmt{} -> case AST.var stmt of
    AST.VarExpr varType _ varName -> case varType of
      Just _ -> Just (varName,Node_Coor nodeId branchId)
      Nothing -> Nothing
    _ -> error "getNewVarBinding -> won't happen3"
  ----------
  _ -> Nothing

getNewVarAssignment :: Int -> Int -> AST.Statement -> Maybe (String,Node_Coor)
getNewVarAssignment nodeId branchId = \case
  -- AssignStmt {varModifier :: [Modifier], assign :: Expression}
  AST.AssignStmt _ expr -> case expr of
    --AssignExpr {assEleft :: Expression, assEright :: Expression}
    AST.AssignExpr left _ -> case left of
      AST.VarExpr{} ->
        Just (AST.varName left,Node_Coor nodeId branchId)
      AST.ArrayCallExpr{} ->
          Just (AST.getVarName left,Node_Coor nodeId branchId)
      _ -> error $ "TODO :: getNewVarAssignment: " ++ show left
    _ -> error "getNewVarAssignment -> won't happen1"
  ----------
  --VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}}
  stmt@AST.VarStmt{} -> case AST.var stmt of
    AST.VarExpr varType _ varName -> case varType of
      Just _ -> Just (varName,Node_Coor nodeId branchId)
      Nothing -> Nothing
    _ -> error "getNewVarBinding -> won't happen3"

getVarNames :: SymState -> Map.Map SymStateKey SymExpr
getVarNames symState = flip Map.filterWithKey (env symState) $ \k _ -> case k of
  VarName _ -> True
  _ -> False

getActions :: SymState -> [String]
getActions = maybe [] (\(SActions li) -> li) . Map.lookup Actions . env

getVarAssignments :: SymState -> [(String,Node_Coor)]
getVarAssignments = maybe [] (\(SVarAssignments li) -> li) . Map.lookup VarAssignments . env
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
    --SymGlobalVar SymType String (Maybe SymExpr)
  actualParam@(SymGlobalVar t n Nothing) -> actualParam
  actualParam@(SymGlobalVar _ _ (Just expr)) -> expr
  actualParam@(SymArray _ _ _) -> actualParam
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
