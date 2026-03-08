{-# Language LambdaCase, MultiWayIf #-}
module SymbolicExecution.Internal.Internal where

import SymbolicExecution.Types
import qualified SymbolicExecution.Logs.Log as Log
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Writer
import qualified CFG.Types as CFGT
import qualified CFG.Internal as CFG (getPathToScope)
import qualified Parser.Types as AST
import Text.Printf (printf)
import Control.Applicative (Alternative(empty),asum,(<|>))
import qualified Data.Map as Map
import Prelude hiding (negate)
import Data.List (nub,find,foldl',intercalate)
import Control.Monad (forM_, foldM_)
import Data.Functor (($>))

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
  AST.Mod -> Mod
  _ -> error "toSymBinOp ~~> TODO"

fromSymBinOp :: SymBinOp -> AST.BinOp
fromSymBinOp = \case
  Add -> AST.Plus
  Mul -> AST.Mult
  Sub -> AST.Minus
  Div -> AST.Div
  _   -> error "fromSymBinOp ~~> TODO"

isArithmeticOperator :: SymBinOp -> Bool
isArithmeticOperator op = elem op [Add, Sub, Mul, Div, Mod]

isBooleanOperator :: SymBinOp -> Bool
isBooleanOperator = flip elem [Eq, Neq, Lt, Le, Gt, Ge, And, Or]

isFormalParameter :: SymExpr -> Map.Map SymStateKey SymExpr -> Bool
isFormalParameter symExpr ma = case symExpr of
  SymVar _ varName -> hasFormalParameter varName ma
  _ -> False

isGlobalVariable :: SymExpr -> Map.Map SymStateKey SymExpr -> Bool
isGlobalVariable symExpr ma = case symExpr of
  SymVar _ varName -> hasGlobalVariable varName ma
  _ -> False

-- a sign that a global variable exists is that
-- it either exists in SGlobalVars,
-- or it does not exist in both SFormalParms or in SVarBindings
isGlobalVariable2 :: String -> SymStateEnv -> Bool
isGlobalVariable2 varName ma = isGlobalVariable3
  (Map.lookup GlobalVars ma,Map.lookup FormalParms ma,Map.lookup VarBindings ma)
  varName

isGlobalVariable3 :: (Maybe SymExpr,Maybe SymExpr,Maybe SymExpr) -> String -> Bool
isGlobalVariable3 tu{-@(globals,formals,locals)-} varName =
  let isGlobal s = varName `elem` s
      isNotFormal s = varName `notElem` s
      isNotLocal s = varName `Map.notMember` s
  in case tu of
    (Nothing,Nothing,Nothing) -> False
    (Just (SGlobalVars globals),Nothing,Nothing)
      -> isGlobal globals
    (Nothing,Just (SFormalParms formals),Nothing)
      -> isNotFormal formals
    (Nothing,Nothing,Just (SVarBindings bindings))
      -> isNotLocal bindings
    (Nothing,Just (SFormalParms formals),Just (SVarBindings bindings))
      -> isNotFormal formals && isNotLocal bindings
    (Just (SGlobalVars globals),Nothing,Just (SVarBindings bindings))
      -> isGlobal globals || isNotLocal bindings
    (Just (SGlobalVars globals),Just (SFormalParms formals),Nothing)
      -> isGlobal globals || isNotFormal formals
    (Just (SGlobalVars globals),Just (SFormalParms formals),Just (SVarBindings bindings))
      -> isGlobal globals || (isNotFormal formals && isNotLocal bindings)

-- type SymReason = ([(CFGT.Kind,CFGT.ScopeRange)],Int)
hasForReason :: [SymReason] -> Bool
hasForReason = \case
  [] -> False
  ((li,_) : _) -> case li of
    [] -> error "hasForReason ==> won't happen"
    ((CFGT.For,_) : _) -> True
    _ -> False

hasIfReason :: [SymReason] -> Bool
hasIfReason = \case
  [] -> False
  ((li,_) : _) -> case li of
    [] -> error "hasIfReason ==> won't happen"
    ((CFGT.If,_) : _) -> True
    _ -> False

alterList :: Eq a => (Maybe a -> Maybe a) -> a -> [a] -> [a]
alterList f elm li
  | elm `elem` li = flip concatMap li $ \n ->
      if n==elm then fun (Just elm)
      else [n]
  | otherwise = li ++ fun Nothing
  where
  fun m = case f m of
    Nothing -> []
    Just newElm -> [newElm]

hasFormalParameter :: String -> Map.Map SymStateKey SymExpr -> Bool
hasFormalParameter varName ma = case Map.lookup FormalParms ma of
  Nothing -> False
  Just (SFormalParms li) -> varName `elem` li

hasGlobalVariable :: String -> Map.Map SymStateKey SymExpr -> Bool
hasGlobalVariable varName ma = case Map.lookup GlobalVars ma of
  Nothing -> False
  Just (SGlobalVars li) -> varName `elem` li

nodeHasGlobalVar :: Map.Map SymStateKey SymExpr -> CFGT.Node -> Bool
nodeHasGlobalVar ma = \case
  CFGT.Node _ (CFGT.Statement stmt) _ ->
    let varNames = AST.getVarNames (AST.getStatementExpression stmt)
    in any (\vn -> isGlobalVariable2 vn ma) varNames
  CFGT.Node _ (CFGT.BooleanExpression CFGT.For mExpr) _ ->
    let mVarNames = fmap AST.getVarNames mExpr
    in process_mVarNames mVarNames
  CFGT.Node _ (CFGT.ForStep mStmt) _ ->
    let mVarNames :: Maybe [String]
        mVarNames = fmap (AST.getVarNames . AST.getStatementExpression) mStmt
    in process_mVarNames mVarNames
  node -> error $ "TODO: nodeHasGlobalVar: " ++ show node
  where
  process_mVarNames :: Maybe [String] -> Bool
  process_mVarNames = maybe False (\varNames -> any (\vn -> isGlobalVariable2 vn ma) varNames)

nodeHasFormalParm :: Map.Map SymStateKey SymExpr -> CFGT.Node -> Bool
nodeHasFormalParm ma = \case
  CFGT.Node _ (CFGT.Statement stmt) _ ->
    let varNames = AST.getVarNames (AST.getStatementExpression stmt)
    in any (\vn -> hasFormalParameter vn ma) varNames
  CFGT.Node _ (CFGT.BooleanExpression CFGT.For mExpr) _ ->
    let mVarNames = fmap AST.getVarNames mExpr
    in process_mVarNames mVarNames
  CFGT.Node _ (CFGT.ForStep mStmt) _ ->
    let mVarNames :: Maybe [String]
        mVarNames = fmap (AST.getVarNames . AST.getStatementExpression) mStmt
    in process_mVarNames mVarNames
  node -> error $ "TODO: nodeHasLocalParm: " ++ show node
  where
  process_mVarNames :: Maybe [String] -> Bool
  process_mVarNames = maybe False (\varNames -> any (\vn -> hasFormalParameter vn ma) varNames)

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
  case Map.lookup GlobalVars ma of
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
  SymVar String _ -> True
  SBin sExpr1 op sExpr2 ->
    all isSymString [sExpr1, sExpr2] && op == Add
  _ -> False

isSymVar :: SymExpr -> Bool
isSymVar = \case
  SymVar _ _ -> True
  _ -> False

-- `isSymVar2` returns True
-- 1) if the SymExpr is SymVar
-- 2) and if the given SymType matches the SymType of that SymVar
isSymVar2 :: SymExpr -> SymType -> Bool
isSymVar2 (SymVar t _) symType = t == symType
isSymVar2 _ _ = False

isSymFun :: SymExpr -> Bool
isSymFun = \case
  SymFun _ _ -> True
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
  SymVar _ _ -> True
  SymString _ -> False
  SymUnknown _ _ -> True
  SymFun _ symExpr -> isVar symExpr
  expr -> error $ "TODO: isVar: " ++ show expr

isArray :: SymExpr -> Bool
isArray = \case
  SymArray _ _ _ -> True
  SymVar (Array _) _ -> True
  _ -> False

isSymUnknown :: SymExpr -> Bool
isSymUnknown = \case
  SymUnknown _ _ -> True
  _ -> False

getSymUnknownReasons :: SymExpr -> [SymReason]
getSymUnknownReasons = \case
  SymUnknown _ reasons -> reasons
  symExpr -> error $ "getSymUnknownReasons ==> won't happen ==> " ++ show symExpr

-- get SymType via AST.Type
toSymType1 :: AST.Type AST.Types -> SymType
toSymType1 = \case
  AST.BuiltInType t -> case t of
    AST.Int     -> Int
    AST.Void    -> Void
    AST.String  -> String
    AST.Boolean -> Bool
    AST.Double  -> Double
    AST.Float   -> Float
    _           -> error $ "toSymType1 ==> TODO ==> " ++ show t

-- ArrayType {baseType :: Type a}
  AST.ArrayType t ->
    let rec = toSymType1 t
    in Array rec
  AST.AnyType "String" _ -> String
  e -> error $ "TODO: toSymType1: " ++ show e

arrayElementSymType :: SymType -> SymType
arrayElementSymType = \case
  Array t -> t
  t -> t

-- get SymType via SymExpr
toSymType2 :: SymExpr -> SymType
toSymType2 = \case
  SymInt _ -> Int
  SymDouble _ -> Double
  SymFloat _ -> Float
  SBool _ -> Bool
  SymNull t -> t
  SymVar t _ -> t
  SObjAcc li -> case li of
    [_,"length"] -> Int
    _ -> error $ "TODO1: toSymType2 ==> " ++ show (SObjAcc li)
  (SymUnknown expr _) -> toSymType2 expr
  SBin a _ b -> pick_known_symType (toSymType2 a,toSymType2 b)
  SymNum _ -> UnknownNumSymType
  SymString _ -> String
  SException symType _ _ -> symType
  SymArray mt _ li -> Array $
    pick_known_symType2 $ maybe [] ((: []) . id) mt ++ map toSymType2 li
  SymFun t symExpr
    | t == ToString -> String
    | otherwise -> toSymType2 symExpr
  SArrayIndexAccess arrName arrPosSymExpr -> toSymType2 arrPosSymExpr
  symExpr -> error $ "TODO2: toSymType2 ==> " ++ show symExpr

pick_known_symType :: (SymType,SymType) -> SymType
pick_known_symType = \case
  -- 2 unknown nums
  (UnknownNumSymType,UnknownNumSymType) -> UnknownNumSymType
  -- 2 unknown global
  (UnknownGlobalVarSymType,UnknownGlobalVarSymType) -> UnknownGlobalVarSymType
  -- unknown num + unknown global
  (UnknownGlobalVarSymType,UnknownNumSymType) -> UnknownNumSymType
  (UnknownNumSymType,UnknownGlobalVarSymType) -> UnknownNumSymType
  -- unknown + known
  (UnknownGlobalVarSymType,symType) -> symType
  (symType,UnknownGlobalVarSymType) -> symType
  (UnknownNumSymType,symType) -> symType
  (symType,UnknownNumSymType) -> symType
  (s1,_) -> s1

pick_known_symType2 :: [SymType] -> SymType
pick_known_symType2 = \case
  [] -> error "pick_known_symType2 ==> won't happen"
  [t] -> t
  (t1 : t2 : rest) -> pick_known_symType2 $ pick_known_symType (t1,t2) : rest

getReturnSymExpr :: SymState -> Maybe SymExpr
getReturnSymExpr = Map.lookup Return . env

getSymExpr :: ExecutionResult -> Maybe SymExpr
getSymExpr = \case
  ER_Expr symExpr -> Just symExpr
  ER_SymStateMapEntry _ symExpr -> Just symExpr
  ER_FunCall symState -> getReturnSymExpr symState
  ER_ArrayCallExpr _ symExpr -> Just symExpr
  ER_PredefinedFunCall symExpr -> Just symExpr
  ER_VarExprObjAccess _ symExpr -> Just symExpr
  er -> error $ "getSymExpr ~~> TODO: " ++ show er

tellNextLog :: Log.LogTag -> SymbolicExecutionMonad String
tellNextLog logTag
  | Log.isHorizontalLine logTag =
      tell [Log.Log "?" logTag] $> "?"
  | otherwise = do
      logNum <- incrementLogEnumeration
      tell [Log.Log logNum logTag] $> logNum

tellNextNestedLog :: [Int] -> [String] -> Log.Log -> SymbolicExecutionMonad String
tellNextNestedLog baseCounter nestedLogTagStrs (Log.Log nestedCounterStr logTag) = do
  let logNum = (intercalate "." $ map show $ baseCounter) ++ "." ++ nestedCounterStr
      nestedLogTag = foldl' (\tag str ->
        Log.Nested str tag) logTag nestedLogTagStrs
  tell [Log.Log logNum nestedLogTag] $> logNum

incrementLogEnumeration :: SymbolicExecutionMonad String
incrementLogEnumeration = do
  a@(Log.Header depth counter) <- logHeader <$> get
  let logNum = intercalate "." . map show
      f = return . logNum
      --tellingIt :: (Int,String) -> (Int,String) -> SymbolicExecutionMonad ()
      --tellingIt old new = tell [Log.Log "?" $ Log.NextLogNum old new]
      --oldCounterStr = logNum counter
  if
    | depth == length counter + 1 -> do
        let newCounter = counter ++ [1]
        modify $ \symState -> SymState {
          env = env symState,
          logHeader = Log.Header depth newCounter
        }
        --tellingIt (depth,oldCounterStr) (depth,logNum newCounter)
        f newCounter
    | depth <= length counter -> do
        let newCounter = take (depth-1) counter ++ [(counter !! (depth-1)) + 1]
        modify $ \symState -> SymState {
          env = env symState,
          logHeader = Log.Header depth newCounter
        }
        --tellingIt (depth,oldCounterStr) (depth,logNum newCounter)
        f newCounter
    | otherwise -> throwError $ printf "SymbolicExecutionn.Internal.incrementLogEnumeration ==> won't happen ==> %s" (show a)

incrementLogDepth :: SymbolicExecutionMonad ()
incrementLogDepth = do
  Log.Header depth counter <- logHeader <$> get
  modify $ \symState -> SymState {
    env = env symState,
    logHeader = Log.Header (depth+1) counter
  }
  --tell [Log.Log "?" $ Log.IncrementLogDepth depth (depth+1)]

decrementLogDepth :: SymbolicExecutionMonad ()
decrementLogDepth = do
  Log.Header depth counter <- logHeader <$> get
  modify $ \symState -> SymState {
    env = env symState,
    logHeader = Log.Header (depth-1) counter
  }
  --tell [Log.Log "?" $ Log.DecrementLogDepth depth (depth-1)]
  

-- alters the type of a global variable based on the expression and the scope it exists in
-- It is used in visitExpr ==> AssignExpr / ==> BinOpExpr
{-
 example: both z and t are global variables mentioned for the first time
    z = t;
    z = 1;
in the first expression, both z and t are of `UnknownGlobalVarSymType`
but the second expression tells me that both of them are of `UnknownNumSymType`
so when this function is used on them, for the type
 -}
inferGlobalVarType :: SymType -> ExecutionResult -> SymbolicExecutionMonad ()
inferGlobalVarType newType er = do
  let loc = "SymbolicExecution.Internal.inferGlobalVarType"
  tellNextLog $ Log.Affected loc ["SymType: " ++ show newType , "ExecutionResult: " ++ show er]
  case er of
    ER_SymStateMapEntry (VarName key) val -> do
      theEnv <- env <$> get
      logH <- logHeader <$> get
      let vns :: [String] -- vns are global variables mentioned in val
          vns = filter (flip isGlobalVariable2 theEnv) (nub $ key : getVarNames2 (VarName key,val))
      case vns of
        [] -> tellNextLog (Log.Skip loc "Nothing to infer") $> ()
        _ ->
          -- search for each occurrence of `vn` in `vns` in `theEnv`
          --     and adjust its type
          foldM_ (\ma vn -> do
            ma2 <- Map.alterF (\case
                  Nothing -> pure $ Just
                    $ SymVar newType vn
                  Just oldSymExpr ->
                    let newType2 = pick_known_symType2
                          $ toSymType2 oldSymExpr : toSymType2 val : [newType]
                    in if newType2 == toSymType2 oldSymExpr
                         then pure $ Just oldSymExpr
                       else do
                         let newSymExpr :: SymExpr
                             newSymExpr = cast newType2 oldSymExpr
                         tellNextLog $ Log.UpdateVariable (vn,show oldSymExpr,show newSymExpr) "inferGlobalVarType"
                         pure $ Just newSymExpr)
                  (VarName vn) ma
            let mNewVarType = fmap toSymType2 $ Map.lookup (VarName vn) ma2
            -- the global variable vn may get mentioned in expressions other than VarName,
            -- and their types may need casting
            let ma3 = flip Map.mapWithKey ma2 $ \k v -> case (k,v) of
                  (VarName _,_) -> v
                  (_,symExpr) -> let
                    innerSymExprs = lookupPartialSymExprs vn (k,symExpr)
                    newType2 = pick_known_symType2
                      $ (map toSymType2 innerSymExprs) ++ maybe [] (: []) mNewVarType
                    in cast2 vn newType2 (k,symExpr)
            -- modify the state accordingly
            modify $ \symState -> SymState {
              env = ma3,
              logHeader = logHeader symState
            }
            return ma3
            ) theEnv vns
    _ -> tellNextLog (Log.Skip loc "Nothing to infer") $> ()

------------------------------
------------------------------
------------------------------

getVarName :: SymExpr -> String
getVarName = \case
  SymVar _ varName -> varName
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

findVarName_via_coor :: (String,CFGT.ScopeRange) -> Map.Map SymStateKey SymExpr -> Maybe SymExpr
findVarName_via_coor (varName,br) s = do
  symExpr <- Map.lookup (ScopeRange br) s
  case symExpr of
    SIte _ ifBranchSymStateEnv mElseBranchSymStateEnv ->
      let mSearch1 = Map.lookup (VarName varName) ifBranchSymStateEnv
          mSearch2 = mElseBranchSymStateEnv >>= Map.lookup (VarName varName)
      in mSearch1 <|> mSearch2
    tu -> error $ "TODO: findVarName_via_coor ==> " ++ show tu
{-
simplify :: SymExpr -> SymExpr
simplify = \case
  SymFormalParam _ _ (Just expr) -> expr
  SymGlobalVar _ _ (Just expr) -> expr
  e -> e
-}

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

isTypeNumeric :: SymType -> Bool
isTypeNumeric = \case
  Int -> True
  Double -> True
  Float -> True
  UnknownNumSymType -> True
  _ -> False

-- The type of the variable in `symExpr` needs to conform to `symType`.
-- This matters in the context of `AssignExpr`, and `BinOpExpr`
cast :: SymType -> SymExpr -> SymExpr
cast symType symExpr = case (symType,symExpr) of
  ----------
  
  ----------
  (_,SymVar t vn)
    | symType `isInstanceOf` t ->
        SymVar symType vn
  ----------
  (String, SymString _) -> symExpr
  (String, SymFun ToString _) -> symExpr
  (String, _)
    | not (symType `isInstanceOf` toSymType2 symExpr) ->
        SymFun ToString symExpr
  ----------
  (_,SBin expr1 op expr2) -> SBin (cast symType expr1) op (cast symType expr2)
  ----------
  (Int,SymInt num) -> SymInt num
  (UnknownNumSymType,SymInt _) -> symExpr
  (UnknownGlobalVarSymType,SymInt _) -> symExpr
  ----------
  (_,SymNull t)
    | symType `isInstanceOf` t -> SymNull symType
  ----------
  (Int,SymNum num) -> SymInt (round num)
  (Double,SymNum num) -> SymDouble (toDouble num)
  (Float,SymNum num) -> SymFloat num
  (UnknownNumSymType, SymNum _) -> symExpr
  (UnknownGlobalVarSymType,SymNum _) -> symExpr
  ----------
  (UnknownNumSymType,SymVar UnknownGlobalVarSymType vn) ->
    SymVar UnknownNumSymType vn
  ----------
  (UnknownGlobalVarSymType,SymString _) -> symExpr
  ----------
  (_,SymUnknown expr reasons) ->
    let t3 = toSymType2 expr
    in if symType `isInstanceOf` t3
         then let newType = pick_known_symType2 [symType,t3]
              in SymUnknown (cast newType expr) reasons
       else error
         $ printf "TODO1 ~~> cast (%s) (%s)" (show symType) (show symExpr)
  ----------
  --SymArray (Maybe SymType) (Maybe Int) [SymExpr]
  (Array t,SymArray mt2 mInt symExprs)
    | any (t `isInstanceOf`)
          (maybe [] ((: []) . id) mt2 ++ map toSymType2 symExprs) ->
        SymArray (Just t) mInt
          $ map (cast t) symExprs
    | otherwise -> error
        $ printf "TODO2 ~~> cast (%s) (%s)" (show symType) (show symExpr)
  ----------
  (t1,SymFun pf expr) ->
    SymFun pf $ cast t1 expr
  ----------
  _
    | toSymType2 symExpr `isInstanceOf` symType -> symExpr
    | symType `isInstanceOf` toSymType2 symExpr -> error
        $ printf "TODO3 ~~> make type %s ~~> cast (%s) (%s)" (show symType) (show symType) (show symExpr)
    | otherwise -> error $ printf "TODO4 ~~> cast (%s) (%s)" (show symType) (show symExpr)

-- this function checks the relatability of two SymTypes to each other
-- Int and String are not related (therefore you can't cast one to the other)
-- `UnknownNumSymType` is related to Int, Double, etc..., but not to String
-- `UnknownGlobalVarSymType` is related to all types
isInstanceOf :: SymType -> SymType -> Bool
isInstanceOf UnknownGlobalVarSymType UnknownGlobalVarSymType = True
isInstanceOf UnknownGlobalVarSymType _ = False
isInstanceOf _ UnknownGlobalVarSymType = True
----------
isInstanceOf UnknownNumSymType UnknownNumSymType = True
isInstanceOf UnknownNumSymType _ = False
isInstanceOf t1 UnknownNumSymType = isTypeNumeric t1
----------
isInstanceOf t1 t2 = t1 == t2

-- the difference between `cast` and `cast2`
--     is that `cast` adjusts the type of the SymExpr,
--     while `cast2` adjusts SymExpr partially

-- `vn` is searched in `symExpr`,
--     and only that parts in `symExpr` which contain `vn`
--     are being casted

-- SBin is treated as atomic,
--     which means this functions is only relevant for SIte, SFor, etc
cast2 :: String -> SymType -> (SymStateKey,SymExpr) -> SymExpr
cast2 vn newType tu@(symStateKey,symExpr) = case symStateKey of
  VarName vn0
    | vn == vn0 -> cast newType symExpr
  _ -> case symExpr of
         SIte ifCond ifSymStateEnv maybeElseSymStateEnv ->
           let ifCond2 :: SymExpr
               ifCond2 = cast2 vn newType (symStateKey,ifCond)
               ifSymStateEnv2 :: SymStateEnv
               ifSymStateEnv2 = Map.map
                 (cast2 vn newType . (,) symStateKey) ifSymStateEnv
               maybeElseSymStateEnv2 :: Maybe SymStateEnv
               maybeElseSymStateEnv2 = flip fmap maybeElseSymStateEnv $ \elseSymStateEnv ->
                 Map.map (cast2 vn newType . (,) symStateKey) elseSymStateEnv
           in SIte ifCond2 ifSymStateEnv2 maybeElseSymStateEnv2
         SymVar _ vn2
           | vn == vn2 -> cast newType symExpr
           | otherwise -> symExpr
         SGlobalVars _ -> symExpr
         SMethodHandle _ _ -> symExpr
         SFormalParms _ -> symExpr
         SBin _ op _
           | vn `existsIn` tu -> cast newType symExpr
           | otherwise -> symExpr
         SVarAssignments li -> SVarAssignments $ flip map li $ \(vn2,(expr,coor)) -> --symExpr
           (vn2,(cast2 vn newType (VarName vn2,expr),coor))
         SymUnknown expr reasons -> SymUnknown (cast2 vn newType (symStateKey,expr)) reasons 
         SVarBindings _ -> symExpr
         SActions _ -> symExpr
         SymNum _ -> symExpr
         SymInt _ -> symExpr
         SymString _ -> symExpr
         SymArray mt ms li -> SymArray mt ms $ map (cast2 vn newType . (,) symStateKey) li
         SymNull _ -> symExpr
         _ -> error $ printf "SymbolicExecution.Internal.cast2 ==> TODO ==> (%s ,, %s)" vn (show tu)

-- A non-atomic SymExpr contains a plural number of SymExprs.
-- This function returns all inner SymExprs inside that non-atomic SymExpr
--     which contain that VarName `vn`
-- So far, this function is relevant in finding out the types of SymExprs
--     that is why in SymUnknown, the SymExpr gets mutated (SymUnknown is not returned)
lookupPartialSymExprs :: String -> (SymStateKey,SymExpr) -> [SymExpr]
lookupPartialSymExprs vn tu@(symStateKey,symExpr) = case symStateKey of
  VarName vn0
    | vn0 == vn -> [symExpr]
  _ -> case symExpr of
      ----------
      SIte ifCond ifSymStateEnv maybeElseSymStateEnv ->
        lookupPartialSymExprs vn (symStateKey,ifCond) ++
        foldl' (\l -> lookupPartialSymExprs vn . (,) symStateKey) [] ifSymStateEnv ++
        case maybeElseSymStateEnv of
          Just elseSymStateEnv -> foldl' (\l -> lookupPartialSymExprs vn . (,) symStateKey) [] elseSymStateEnv
          Nothing -> []
      ----------
      SymVar _ vn2
        | vn == vn2 -> [symExpr]
        | otherwise -> []
      ----------
      SGlobalVars _ -> []
      ----------
      SActions symExprs -> concatMap (lookupPartialSymExprs vn . (,) symStateKey) symExprs
      ----------
      SMethodHandle _ _ -> []
      ----------
      SFormalParms _ -> []
      ----------
      SVarBindings _ -> []
      ----------
      SBin symExpr1 _ symExpr2 ->
        let one = concatMap (lookupPartialSymExprs vn . (,) symStateKey) [symExpr1,symExpr2]
        in if null one
             then []
           else one ++ [symExpr] -- because SBin is somehow atomic even though it is not :/
      ----------
      SVarAssignments li -> flip concatMap li $ \(vn2,(symExpr,_)) ->
        lookupPartialSymExprs vn (VarName vn2,symExpr)
        --(lookupPartialSymExprs vn . (,) symStateKey)
      ----------
      SymUnknown ex _ -> lookupPartialSymExprs vn (symStateKey,ex)
      ----------
      SymNum _ -> []
      ----------
      SymInt _ -> []
      ----------
      SymString _ -> []
      ----------
      SymFun pf innerSymExpr ->
        let x = lookupPartialSymExprs vn (symStateKey,innerSymExpr)
        in if null x
             then []
           else x ++ [symExpr]
      ----------
      _ -> error
        $ printf "SymbolicExecution.Internal.lookupPartialSymExprs ==> TODO ==> (%s ,, %s)" vn (show tu)

-- it tells whether a VarName exists in a SymExpr
-- This function was originally written to test `inferGlobalVarType`
existsIn :: String -> (SymStateKey,SymExpr) -> Bool
existsIn vn tu@(symStateKey,symExpr) = (case symStateKey of
  VarName vn0 -> vn0 == vn
  _ -> False) || case symExpr of
    SIte ifCond ifSymStateEnv maybeElseSymStateEnv ->
      vn `existsIn` (symStateKey,ifCond)
      || any ((vn `existsIn`) . (,) symStateKey) ifSymStateEnv
      || case (fmap (any ((vn `existsIn`) . (,) symStateKey)) maybeElseSymStateEnv) of
           Nothing -> False
           Just False -> False
           Just True -> True
    SymVar _ vn2 -> vn == vn2
    SymNum _ -> False
    SymInt _ -> False
    SymString _ -> False
    SGlobalVars _ -> False
    SMethodHandle _ _ -> False
    SFormalParms _ -> False
    SBin symExpr1 _ symExpr2 -> any ((vn `existsIn`) . (,) symStateKey) [symExpr1,symExpr2]
    SVarAssignments _ -> False
    SymUnknown expr _ -> existsIn vn (symStateKey,expr)
    SymFun _ expr -> existsIn vn (symStateKey,expr)
    _ -> error
      $ printf "SymbolicExecution.Internal.existsIn ==> TODO ==> (%s ,, %s)" vn (show tu)

isUnknownGlobalVarSymType :: SymType -> Bool
isUnknownGlobalVarSymType = \case
  UnknownGlobalVarSymType -> True
  _ -> False

isUnknownNumSymType :: SymType -> Bool
isUnknownNumSymType = \case
  UnknownNumSymType -> True
  _ -> False

toDouble :: Float -> Double
toDouble = read . show

getIntegralArithBinOp :: Integral a => SymBinOp -> (a -> a -> a)
getIntegralArithBinOp = \case
    Add -> (+)
    Mul -> (*)
    Sub -> (-)
    Mod -> mod

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
  op -> error $ "getArithBoolOp:: " ++ show op

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

getVarBindings :: SymStateEnv -> Map.Map String CFGT.Node_Coor
getVarBindings symStateEnv = case Map.lookup VarBindings symStateEnv of
  Nothing -> Map.empty
  Just (SVarBindings li) -> li

getNewVarBinding :: CFGT.Node_Coor -> AST.Statement -> Maybe (String,CFGT.Node_Coor)
getNewVarBinding nodeCoor = \case
  -- AssignStmt {varModifier :: [Modifier], assign :: Expression}
  AST.AssignStmt _ expr -> case expr of
    --AssignExpr {assEleft :: Expression, assEright :: Expression}
    AST.AssignExpr left _ -> case left of
      AST.VarExpr{} -> case AST.varType left of
        Just _ ->
          Just (AST.varName left,
                nodeCoor)
        Nothing -> Nothing
      AST.ArrayCallExpr{} -> Nothing
      _ -> error $ "getNewVarBinding -> won't happen1: " ++ show left
    _ -> error "getNewVarBinding -> won't happen2"
  ----------
  --VarStmt {var = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "y"}}
  stmt@AST.VarStmt{} -> case AST.var stmt of
    AST.VarExpr varType _ varName -> case varType of
      Just _ -> Just (varName,nodeCoor)
      Nothing -> Nothing
    _ -> error "getNewVarBinding -> won't happen3"
  ----------
  _ -> Nothing

-- `allVarNames` are all VarNames. I search that one specific SymExpr from it using `itsSymExpr`
getNewVarAssignment :: (Map.Map SymStateKey SymExpr,CFGT.Node_Coor) -> AST.Statement -> Maybe (String,(SymExpr,CFGT.Node_Coor))
getNewVarAssignment (allVarNames,nodeCoor) = \case
  -- AssignStmt {varModifier :: [Modifier], assign :: Expression}
  AST.AssignStmt _ expr -> case expr of
    --AssignExpr {assEleft :: Expression, assEright :: Expression}
    AST.AssignExpr left _ -> case left of
      AST.VarExpr{} ->
        let vn = AST.varName left
        in Just (vn,(itsSymExpr vn,nodeCoor))
      AST.ArrayCallExpr{} ->
        let vn = AST.getVarName left
        in Just (vn,(itsSymExpr vn,nodeCoor))
      _ -> error $ "TODO :: getNewVarAssignment: " ++ show left
    _ -> error "getNewVarAssignment -> won't happen1"
  ----------
  stmt@AST.VarStmt{} -> Nothing{-case AST.var stmt of
    AST.VarExpr varType _ varName -> case varType of
      Just _ -> Just (varName,nodeCoor)
      Nothing -> Nothing
    _ -> error "getNewVarAssignment -> won't happen3"-}
  ----------
  stmt@AST.FunCallStmt{} -> Nothing
  ----------
  stmt -> error $ printf "getNewVarAssignment ==> TODO: (%s,%s)" (show nodeCoor) (show stmt)
  where
  itsSymExpr :: String -> SymExpr
  itsSymExpr vn = case Map.lookup (VarName vn) allVarNames of
    Nothing -> error $ printf "SymbolicExecution.Internal.getNewVarAssignment ==> won't happen:\n%s\n%s" vn (show allVarNames)
    Just symExpr -> symExpr

getVarNames :: SymStateEnv -> SymStateEnv
getVarNames symStateEnv = flip Map.filterWithKey symStateEnv $ \k _ -> case k of
  VarName _ -> True
  _ -> False

getVarNames2 :: (SymStateKey,SymExpr) -> [String]
getVarNames2 (symStateKey,symExpr) = (case symStateKey of
  VarName vn -> [vn]
  _ -> []) ++ case symExpr of
    SymVar _ varName -> [varName]
    SBin symExpr1 _ symExpr2 ->
      getVarNames2 (symStateKey,symExpr1) ++ getVarNames2 (symStateKey,symExpr2)
    SNot symExpr -> getVarNames2 (symStateKey,symExpr)
    SArrayIndexAccess s1 s2 -> error $ "TODO1:: getVarNames2 ==> " ++ show (SArrayIndexAccess s1 s2)
    SymArray onw two three -> []
    SymUnknown _ _ -> []
    SymNull _ -> []
    SymDouble _ -> []
    SymInt _ -> []
    SymString _ -> []
    SymNum _ -> []
    SException _ _ _ -> []
    SObjAcc [arrName,"length"] -> [arrName]
    SymFun _ expr -> getVarNames2 (symStateKey,expr)
    symExpr -> error $ "TODO3:: getVarNames2 ==> " ++ show symExpr

-- `getVarNames4` is to be used exclusively on if, for, and other kinds of `SymExpr`s
-- which cause new branching
-- it traverses the inner SymStates, and returns their VarNames
getVarNames4 :: SymExpr -> [SymStateEnv]
getVarNames4 = \case
  SIte _ ifSymStateEnv mElseSymStateEnv ->
    getVarNames ifSymStateEnv : case mElseSymStateEnv of
      Nothing -> []
      Just elseSymStateEnv -> [getVarNames elseSymStateEnv]
  symExpr -> error $ "TODO: SymbolicExecution.Internal.getVarNames4" ++ show symExpr

getVarNameSymType :: String -> SymStateEnv -> Maybe SymType
getVarNameSymType varName ma = fmap toSymType2 (Map.lookup (VarName varName) ma)

getVarNameSymExpr :: String -> SymStateEnv -> Maybe SymExpr
getVarNameSymExpr varName ma = fmap id (Map.lookup (VarName varName) ma)

getActions :: SymStateEnv -> [SymExpr]
getActions = maybe [] (\(SActions li) -> li) . Map.lookup Actions

getVarAssignments :: SymStateEnv -> [(String,(SymExpr,CFGT.Node_Coor))]
getVarAssignments = maybe [] (\(SVarAssignments li) -> li) . Map.lookup VarAssignments

getVarAssignments2 :: SymStateEnv -> [(String,(SymExpr,CFGT.Node_Coor))]
getVarAssignments2 = maybe [] (\(SVarAssignments li) -> li) . Map.lookup VarAssignments

getGlobalVars :: SymStateEnv -> [String]
getGlobalVars = maybe [] (\(SGlobalVars li) -> li) . Map.lookup GlobalVars

getGlobalVars2 :: SymStateEnv -> SymStateEnv
getGlobalVars2 ma =
  let --isGlobalVariable2 :: String -> SymStateEnv -> Bool
      --isGlobalVariable3 :: (Maybe SymExpr,Maybe SymExpr,Maybe SymExpr) -> String -> Bool
      tu@(globals,formals,locals) = (Map.lookup GlobalVars ma,Map.lookup FormalParms ma,Map.lookup VarBindings ma)
  in flip Map.filterWithKey ma $ \k _ -> case k of
       VarName vn -> isGlobalVariable3 tu vn
       _ -> False

getFormalParms :: Map.Map SymStateKey SymExpr -> [String]
getFormalParms = maybe [] (\(SFormalParms li) -> li) . Map.lookup FormalParms

getFormalParms2 :: Map.Map SymStateKey SymExpr -> Map.Map SymStateKey SymExpr
getFormalParms2 ma =
  let formalPs = getFormalParms ma
  in flip Map.filterWithKey ma $ \k _ -> case k of
       VarName vn -> vn `elem` formalPs
       _ -> False

-- `getScopedGlobalVarsSymExpr` returns all the SymExprs
--     which are related to all Global variables
--     which occur in a specific scope

-- The scope is passed via an SymExpr, such as `SIte SymExpr SymState (Maybe SymState)`

{-
Example: Observe the following example:
public int ifFun4(int n) {
  if(y>=0) {
    y += n;
  }
  return y;
}

symExpr =
    SIte (SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0))
    (SymState {env = fromList [
        (MethodHandle,SMethodHandle (Int,"ifFun4")),
        (GlobalVars,SGlobalVars ["y"]),
        (FormalParms,SFormalParms ["n"]),
        (VarAssignments,SVarAssignments [("y",Node_Coor {varDeclAt = 2, varFrame = SR {branchStart = 1, branchEnd = 3}})]),
        (VarName "n",SymVar Int "n"),
        (VarName "y",SBin (SymVar Int "y") Add (SymVar Int "n"))
    ], pc = []})
    Nothing

getScopedGlobalVarsSymExpr symExpr =
    [
     ("y",[SymVar UnknownNumSymType "y",
           SBin (SymVar UnknownNumSymType "y") Ge (SymNum 0.0),
           SymVar Int "y",
           SBin (SymVar Int "y") Add (SymVar Int "n"),
           SBin (SymVar Int "y") Add (SymVar Int "n")])
    ]
-}
getScopedGlobalVarsSymExprs :: (SymStateKey,SymExpr) -> SymbolicExecutionMonad [(String,[SymExpr])]
getScopedGlobalVarsSymExprs (symStateKey,symExpr) = do
  theEnv <- env <$> get
  let global_vns = getGlobalVars theEnv
      -- `varNames_with_exprs1` gives me all the SymExprs
      -- which were mentioned in the ifSymState and elseSymState
      -- VarNames are excluded. `varNames_with_exprs2` gives me the VarNames
      varNames_with_exprs1 :: [(String,[SymExpr])]
      varNames_with_exprs1 = flip map global_vns $ \vn ->
        (vn,lookupPartialSymExprs vn (symStateKey,symExpr))
      varNames_with_exprs2 :: [(String,SymExpr)]
      varNames_with_exprs2 = flip concatMap (getVarNames4 symExpr)
        $ (map (\(VarName vn,e) -> (vn,e))
           . Map.toList
           . Map.filterWithKey (\(VarName vn) _ -> vn `elem` global_vns))
      -- `varNameInfo` returns all its info mentioned in `varNames_with_exprs1` and `varNames_with_exprs1`
      varNameSymExprs :: [(String,[SymExpr])]
      varNameSymExprs = flip map global_vns $ \vn -> (,) vn
        $ concat [symExprs | (vn2,symExprs) <- varNames_with_exprs1, vn2 == vn] ++
          [expr | (vn2,expr) <- varNames_with_exprs2, vn2 == vn]
  return varNameSymExprs
------------------------------
------------------------------
------------------------------
{- type SymReason = ([(ScopeKind,ScopeRange)],Int)
input:
kind: For
sr: SR {branchStart = 2, branchEnd = 15}
node_coors: [
 Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 2, branchEnd = 15}},
 Node_Coor {varDeclAt = 9, varFrame = SR {branchStart = 7, branchEnd = 11}},
 Node_Coor {varDeclAt = 12, varFrame = SR {branchStart = 2, branchEnd = 15}}
]

output:
[
 ([For SR {branchStart = 2, branchEnd = 15}],4),
 ([For SR {branchStart = 2, branchEnd = 15}, If SR {branchStart = 7, branchEnd = 11}],9),
 ([For SR {branchStart = 2, branchEnd = 15}],12)
}
 -}
 -- sr: the range of the if branch, or for branch, in which this fun is being called
 -- cfg: the CFG of the current method
 -- the list: the coordinates in which the var is being assigned / reassigned
createSymReason :: (CFGT.Kind,CFGT.ScopeRange) -> CFGT.CFG -> [CFGT.Node_Coor] -> [SymReason]
createSymReason (kind,sr) cfg = map $ \node_coor ->
  let one
        | CFGT.varFrame node_coor == sr = [(kind,sr)]
        | otherwise = CFG.getPathToScope (CFGT.varFrame node_coor) cfg
  in (one,CFGT.varDeclAt node_coor)

------------------------------
------------------------------
------------------------------
