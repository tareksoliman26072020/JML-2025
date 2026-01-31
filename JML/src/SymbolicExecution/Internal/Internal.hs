{-# Language LambdaCase #-}
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
import qualified Data.Map as Map (lookup,empty,Map,filterWithKey,insert,foldMapWithKey,toList,alter,notMember,alterF)
import Prelude hiding (negate)
import Data.List (nub,find)
import Control.Monad (forM_, foldM_)

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

{-
isFormalParameter :: SymExpr -> Bool
isFormalParameter (SymFormalParam _ _ _) = True
isFormalParameter _ = False

isGlobalVariable :: SymExpr -> Bool
isGlobalVariable (SymGlobalVar _ _ _) = True
isGlobalVariable _ = False
-}
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
isGlobalVariable2 :: String -> Map.Map SymStateKey SymExpr -> Bool
isGlobalVariable2 varName ma =
  let isGlobal globals = varName `elem` globals
      isNotFormal formals = varName `notElem` formals
      isNotLocal bindings = varName `Map.notMember` bindings
  in case (Map.lookup GlobalVars ma,Map.lookup FormalParms ma,Map.lookup VarBindings ma) of
  --(globals,formals,locals)
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

{-
hasForReason li = maybe False (const True) $ flip find li $ \case
  ForBranchingReason _ -> True
  _ -> False

hasIfReason :: [SymReason] -> Bool
hasIfReason li = maybe False (const True) $ flip find li $ \case
  IfBranchingReason _ -> True
  _ -> False
-}
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

{-
makeVarSymUnknown :: (String,SymReason) -> Map.Map SymStateKey SymExpr -> Map.Map SymStateKey SymExpr
makeVarSymUnknown (varName,symReason) ma =
  Map.alter (\case
    Nothing -> error
      $ printf "makeVarSymUnknown ==> won't happen because varName (%s) should exist" varName
    Just expr -> Just $ SymUnknown (toSymType2 expr,varName,Just expr) symReason) 
            (VarName varName) ma
-}
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
--  SymFormalParam _ _ Nothing -> True
--  SymFormalParam _ _ (Just expr) -> isVar expr
--  SymGlobalVar _ _ Nothing -> True
--  SymGlobalVar _ _ (Just expr) -> isVar expr
  SymVar _ _ -> True
  SymUnknown _ _ -> True
  expr -> error $ "TODO: isVar: " ++ show expr

isArray :: SymExpr -> Bool
isArray = \case
  SymArray _ _ _ -> True
--  SymFormalParam (Array _) _ _ -> True
--  SymGlobalVar (Array _) _ _ -> True
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
toSymType2 = \case
  SymInt _ -> Int
  SymDouble _ -> Double
  SymFloat _ -> Float
  SBool _ -> Bool
  SymNull t -> t
--  SymFormalParam t _ _ -> t
--  SymGlobalVar t _ _ -> t
  SymVar t _ -> t
  SObjAcc li -> case li of
    [_,"length"] -> Int
    _ -> error $ "TODO1: toSymType2 ==> " ++ show (SObjAcc li)
  (SymUnknown (t,_,_) mExpr) -> t
  SBin a _ b -> pick_known_symType (toSymType2 a,toSymType2 b)
  SymNum _ -> UnknownNumSymType
  SymString _ -> String
  SException symType _ _ -> symType
  SymArray (mt) _ li ->
    pick_known_symType2 $ maybe [] ((: []) . id) mt ++ map toSymType2 li
  symExpr -> error $ "TODO2: toSymType2 ==> " ++ show symExpr

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
--  SymFormalParam t _ mSymExpr -> pure t
--  SymGlobalVar t _ mSymExpr -> pure t
  SymVar t _ -> pure t
  symExpr -> error $ "toSymType3 ~~> TODO: " ++ show symExpr

findSymType :: [SymExpr] -> Maybe SymType
findSymType = asum . map toSymType3

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
  er -> error $ "getSymExpr ~~> TODO: " ++ show er

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
castGlobalVar :: SymType -> ExecutionResult -> Typed_Method_R ()
castGlobalVar newType = \case
  er@(ER_SymStateMapEntry (VarName key) val) -> do
    theEnv <- env <$> get
    let vns :: [String] -- vns are global variables mentioned in val
        vns = filter (flip isGlobalVariable2 theEnv) (nub $ key : getVarNames2 val)
    -- foldM_ :: (Foldable t, Monad m) => (b -> a -> m b) -> b -> t a -> m ()
    foldM_ (\ma vn -> do
      ma2 <- Map.alterF (\case
            Nothing -> pure $ Just
              -- $ SymGlobalVar newType vn Nothing
              $ SymVar newType vn
            Just oldSymExpr ->
              let newType2 = pick_known_symType2
                    $ toSymType2 oldSymExpr : toSymType2 val : [newType]
              in if newType2 == toSymType2 oldSymExpr
                   then pure $ Just oldSymExpr
                 else do
                   let newSymExpr :: SymExpr
                       newSymExpr = cast newType2 oldSymExpr
                         --error $ printf "W::: (%s,%s)" (show newType2) (show oldSymExpr)
                         --changeSymExprType newType2 oldSymExpr
                   tell [Log.UpdateVariable (vn,show oldSymExpr,show newSymExpr) "castGlobalVar"]
                   pure $ Just newSymExpr)
            (VarName vn) ma
      
      modify $ \symState -> SymState {
        env = ma2,
        pc = pc symState
      }
      return ma2
      ) theEnv vns
  _ -> return ()

------------------------------
------------------------------
------------------------------

getVarName :: SymExpr -> String
getVarName = \case
--  SymFormalParam _ varName _ -> varName
--  SymGlobalVar _ varName _ -> varName
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
    SIte _ ifBranchSymState mElseBranchSymState ->
      let mSearch1 = Map.lookup (VarName varName) (env ifBranchSymState)
          mSearch2 = mElseBranchSymState >>= Map.lookup (VarName varName) . env
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

-- The type of the variable in `symExpr` needs to conform to `symType`.
-- This matters in the context of `AssignExpr`, and `BinOpExpr`
cast :: SymType -> SymExpr -> SymExpr
cast symType symExpr = case (symType,symExpr) of
  (Int,SymNum num) -> SymInt (round num)
  (Double,SymNum num) -> SymDouble (toDouble num)
  (Float,SymNum num) -> SymFloat num
  (Bool,SymNum num) -> error "cast ~~> won't happen1"
  (Void,SymNum num) -> error "cast ~~> won't happen2"
  (Array t,SymNum num) -> cast t (SymNum num)
  (UnknownGlobalVarSymType,SymNum _) -> symExpr
  (UnknownNumSymType,SymNum _) -> symExpr
  (_,SymNum _) -> error $ printf "TODO: cast ==> cast (%s) (%s)" (show symType) (show symExpr)
  (_,SBin expr1 op expr2) -> SBin (cast symType expr1) op (cast symType expr2)
  --SymArray (Maybe SymType) (Maybe Int) [SymExpr]
  (_,SymArray _ mInt symExprs) -> SymArray (Just symType) mInt (map (cast symType) symExprs)
  --
{-
  (_,SymGlobalVar t s m) ->
    let t2 = pick_known_symType (symType,t)
    in maybe (SymGlobalVar t2 s Nothing) (cast symType) m
-}
  (_,SymVar t s) ->
    let t2 = pick_known_symType (symType,t)
    in SymVar t2 s

  --a -> error $ printf "TODO ~~> cast (%s) (%s)" (show symType) (show symExpr)
  (_,a) -> a

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

getVarBindings :: SymState -> Map.Map String CFGT.Node_Coor
getVarBindings symState = case Map.lookup VarBindings (env symState) of
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

getNewVarAssignment :: CFGT.Node_Coor -> AST.Statement -> Maybe (String,CFGT.Node_Coor)
getNewVarAssignment nodeCoor = \case
  -- AssignStmt {varModifier :: [Modifier], assign :: Expression}
  AST.AssignStmt _ expr -> case expr of
    --AssignExpr {assEleft :: Expression, assEright :: Expression}
    AST.AssignExpr left _ -> case left of
      AST.VarExpr{} ->
        Just (AST.varName left,nodeCoor)
      AST.ArrayCallExpr{} ->
          Just (AST.getVarName left,nodeCoor)
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

getVarNames :: SymState -> Map.Map SymStateKey SymExpr
getVarNames symState = flip Map.filterWithKey (env symState) $ \k _ -> case k of
  VarName _ -> True
  _ -> False

getVarNames2 :: SymExpr -> [String]
getVarNames2 = \case
--  SymGlobalVar _ vn mExpr -> vn : maybe [] getVarNames2 mExpr
--  SymFormalParam _ vn mExpr -> vn : maybe [] getVarNames2 mExpr
  SymVar _ varName -> [varName]
  SBin symExpr1 _ symExpr2 -> getVarNames2 symExpr1 ++ getVarNames2 symExpr2
  SNot symExpr -> getVarNames2 symExpr
  SArrayIndexAccess s1 s2 -> error $ "TODO1:: getVarNames2 ==> " ++ show (SArrayIndexAccess s1 s2)
  -- SymArray (Just (Array Int)) (Just 2) [SymInt 99,SymInt 5]
  SymArray onw two three -> []
  SymUnknown (_,vn,_) _ -> [vn]
  SymNull _ -> []
  SymDouble _ -> []
  SymInt _ -> []
  SymString _ -> []
  SymNum _ -> []
  SException _ _ _ -> []
  SObjAcc [arrName,"length"] -> [arrName]
  symExpr -> error $ "TODO3:: getVarNames2 ==> " ++ show symExpr

getVarNames3 :: Map.Map SymStateKey SymExpr -> Map.Map SymStateKey SymExpr
getVarNames3 ma = flip Map.filterWithKey ma $ \k _ -> case k of
  VarName _ -> True
  _ -> False

getVarNameSymType :: String -> Map.Map SymStateKey SymExpr -> Maybe SymType
getVarNameSymType varName ma = fmap toSymType2 (Map.lookup (VarName varName) ma)

getVarNameSymExpr :: String -> Map.Map SymStateKey SymExpr -> Maybe SymExpr
getVarNameSymExpr varName ma = fmap id (Map.lookup (VarName varName) ma)

getActions :: SymState -> [String]
getActions = maybe [] (\(SActions li) -> li) . Map.lookup Actions . env

getVarAssignments :: SymState -> [(String,CFGT.Node_Coor)]
getVarAssignments = maybe [] (\(SVarAssignments li) -> li) . Map.lookup VarAssignments . env

getVarAssignments2 :: Map.Map SymStateKey SymExpr -> [(String,CFGT.Node_Coor)]
getVarAssignments2 = maybe [] (\(SVarAssignments li) -> li) . Map.lookup VarAssignments

getGlobalVars :: Map.Map SymStateKey SymExpr -> [String]
getGlobalVars = maybe [] (\(SGlobalVars li) -> li) . Map.lookup GlobalVars

------------------------------
------------------------------
------------------------------
{-
input:
kind: For
br: BR {branchStart = 2, branchEnd = 15}
node_coors: [
 Node_Coor {varDeclAt = 4, varFrame = BR {branchStart = 2, branchEnd = 15}},
 Node_Coor {varDeclAt = 9, varFrame = BR {branchStart = 7, branchEnd = 11}},
 Node_Coor {varDeclAt = 12, varFrame = BR {branchStart = 2, branchEnd = 15}}
]

type SymReason = ([(ScopeKind,ScopeRange)],Int)

output:
[
 ([For BR {branchStart = 2, branchEnd = 15}],4),
 ([For BR {branchStart = 2, branchEnd = 15}, If BR {branchStart = 7, branchEnd = 11}],9),
 ([For BR {branchStart = 2, branchEnd = 15}],12)
}
 -}
createSymReason :: (CFGT.Kind,CFGT.ScopeRange) -> CFGT.CFG -> [CFGT.Node_Coor] -> [SymReason]
createSymReason (kind,br) cfg = map $ \node_coor ->
  let one
        | CFGT.varFrame node_coor == br = [(kind,br)]
        | otherwise = CFG.getPathToScope (CFGT.varFrame node_coor) cfg
  in (one,CFGT.varDeclAt node_coor)

------------------------------
------------------------------
------------------------------

-- replaces an occurrance of formalParam with the given actualParam
-- useful in MethodCall.hs
substitute :: String -> SymExpr -> SymExpr
substitute formalParam = \case
  actualParam@(SBin symExpr1 symBinOp symExpr2) ->
    SBin (substitute formalParam symExpr1) symBinOp (substitute formalParam symExpr2)
  {-
  actualParam@(SymFormalParam symType _ Nothing) -> actualParam
    --SymActualParam symType formalParam actualParam
  SymFormalParam symType _ _ -> error "substitute ~~> TODO1"
    --SymGlobalVar SymType String (Maybe SymExpr)
  actualParam@(SymGlobalVar t n Nothing) -> actualParam
  actualParam@(SymGlobalVar _ _ (Just expr)) -> expr
   -}
  actualParam@(SymVar _ _) -> actualParam
  actualParam@(SymInt _) -> actualParam
  actualParam@(SymArray _ _ _) -> actualParam
  act -> error $ printf "substitute ~~> TODO2: (%s,%s)" formalParam (show act)

-- Extracting ExecutionResult from the monadic type Method_R
-- useful for debugging
method_R_2_ExecutionResult ::((Config,[CFGT.CFG]),SymState) -> Method_R -> ExecutionResult
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
