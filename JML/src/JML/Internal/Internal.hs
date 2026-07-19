{-# Language MultiWayIf, LambdaCase, ScopedTypeVariables #-}
module JML.Internal.Internal where

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
import JML.PrettyPrint (ppBehavior, ppBehaviors, ppColoredClause)
import qualified JML.Logs.Log as Log
import Data.Maybe (isJust,catMaybes,fromJust,mapMaybe)

import qualified CFG.Types as CFGT (ScopeRange, ScopeRange(SR))

import qualified SymbolicExecution.Types as SYT
import qualified SymbolicExecution.Internal.Internal as SY.Internal

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

cyan :: String -> String
cyan = printf "\ESC[1;36m%s\ESC[m"

green :: String -> String
green = printf "\ESC[1;32m%s\ESC[m"

tellNextLog :: Log.LogTag -> JMLMonad String
tellNextLog logTag
  | Log.isHorizontalLine logTag =
      tell [Log.Log "?" logTag] $> "?"
  | otherwise = do
      logNum <- incrementLogEnumeration
      tell [Log.Log logNum logTag] $> logNum

tellNextNestedLog :: [Int] -> [String] -> Log.Log -> JMLMonad String
tellNextNestedLog baseCounter nestedLogTagStrs (Log.Log nestedCounterStr logTag) = do
  let logNum = (intercalate "." $ map show $ baseCounter) ++ "." ++ nestedCounterStr
      nestedLogTag = foldl' (\tag str ->
        Log.Nested str tag) logTag nestedLogTagStrs
  tell [Log.Log logNum nestedLogTag] $> logNum

incrementLogEnumeration :: JMLMonad String
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
        modify $ \jmlState -> JMLState {
          method = method jmlState,
          jmlStack = jmlStack jmlState,
          logHeader = Log.Header depth newCounter,
          formalParms = formalParms jmlState,
          localVars = localVars jmlState,
          globalVars = globalVars jmlState,
          reAssigned = reAssigned jmlState,
          pathCreationEnumeration = pathCreationEnumeration jmlState
        }
        --tellingIt (depth,oldCounterStr) (depth,logNum newCounter)
        f newCounter
    | depth <= length counter -> do
        let newCounter = take (depth-1) counter ++ [(counter !! (depth-1)) + 1]
        modify $ \jmlState -> JMLState {
          method = method jmlState,
          jmlStack = jmlStack jmlState,
          logHeader = Log.Header depth newCounter,
          formalParms = formalParms jmlState,
          localVars = localVars jmlState,
          globalVars = globalVars jmlState,
          reAssigned = reAssigned jmlState,
          pathCreationEnumeration = pathCreationEnumeration jmlState
        }
        --tellingIt (depth,oldCounterStr) (depth,logNum newCounter)
        f newCounter
    | otherwise -> throwError $ printf "JML.Internal.incrementLogEnumeration ==> won't happen ==> %s" (show a)

incrementLogDepth :: JMLMonad ()
incrementLogDepth = do
  Log.Header depth counter <- logHeader <$> get
  modify $ \jmlState -> JMLState {
    method = method jmlState,
    jmlStack = jmlStack jmlState,
    logHeader = Log.Header (depth+1) counter,
    formalParms = formalParms jmlState,
    localVars = localVars jmlState,
    globalVars = globalVars jmlState,
    reAssigned = reAssigned jmlState,
    pathCreationEnumeration = pathCreationEnumeration jmlState
  }
  --tell [Log.Log "?" $ Log.IncrementLogDepth depth (depth+1)]

decrementLogDepth :: JMLMonad ()
decrementLogDepth = do
  Log.Header depth counter <- logHeader <$> get
  modify $ \jmlState -> JMLState {
    method = method jmlState,
    jmlStack = jmlStack jmlState,
    logHeader = Log.Header (depth-1) counter,
    formalParms = formalParms jmlState,
    localVars = localVars jmlState,
    globalVars = globalVars jmlState,
    reAssigned = reAssigned jmlState,
    pathCreationEnumeration = pathCreationEnumeration jmlState
  }
  --tell [Log.Log "?" $ Log.DecrementLogDepth depth (depth-1)]

constructLog :: String -> String -> [(String,String)] -> JMLMonad String
constructLog loc tag contents = tellNextLog
  $ Log.LogTag (cyan loc) (green tag)
  $ ("  " ++)
  $ constructLogContents contents

constructLogContents :: [(String,String)] -> String
constructLogContents contents = intercalate "\n\n  "
  $ map (\(counter,(key,value)) -> printf "%s %s"
            (yellow $ printf "%d) %s:" counter key) value)
  $ zip [1::Int ..] contents

constructLogMsg :: String -> String -> [(String,String)] -> String
constructLogMsg loc tag contents = printf
  "%s in %s\n\
  \  %s"
  (green tag) (cyan loc) (constructLogContents contents)

constructErrorMsg = constructLogMsg

se_2_map :: [SYT.SymbolicExecution] -> Map.Map String SYT.SymbolicExecution
se_2_map = Map.fromList . map (\se -> (SY.Internal.getFunName se,se))

getFunName :: JMLMonad String
getFunName = (name . method) <$> get

isReassigned :: String -> JMLState -> Bool
isReassigned vn jmlState = vn `elem` reAssigned jmlState

isFormalParm :: String -> JMLState -> Bool
isFormalParm varName jmlState = varName `elem` formalParms jmlState

isGlobalVar :: String -> JMLState -> Bool
isGlobalVar varName jmlState = varName `elem` globalVars jmlState

-- converts SymExpr to Expr
symExprToExpr :: JMLState -> SYT.SymbolicExecutionValue -> Expr
symExprToExpr jmlState symExpr =
  let loc = "JML.Internal.Internal.symExprToExpr"
  in case symExpr of
       SYT.SymDouble num -> JMLDouble num
       SYT.SymInt num -> JMLInt (fromIntegral num)
       SYT.SymVar t vn
         | isReassigned vn jmlState -> JMLOld $ JMLVar (toJMLType t) vn
         | otherwise -> JMLVar (toJMLType t) vn
       SYT.SymNum num -> JMLNum num
       SYT.SBin symExpr1 op symExpr2 ->
         JMLBin (symExprToExpr jmlState symExpr1)
                (symBinOpToOp op)
                (symExprToExpr jmlState symExpr2)
       SYT.SymString str -> JMLString str
       SYT.SActions symExprs -> JMLActions $ map (symExprToExpr jmlState) symExprs
       SYT.SymUnknown (vn,symExpr) symReasons -> let
         scopeRanges :: [CFGT.ScopeRange]
         scopeRanges = concatMap SY.Internal.getScopeRangesFromSymReason symReasons
         in JMLVarUnknown scopeRanges
              (toJMLType $ SY.Internal.toSymType2 symExpr) vn (symExprToExpr jmlState symExpr)
       SYT.SException t str1 str2 -> JMLException (toJMLType t) str1 str2
       SYT.SBool b -> JMLBool b
       SYT.SObjAcc li -> JMLObjAcc li
       SYT.SArrayIndexAccess arrType arrName arrIndexSymExpr ->
         JMLArrayIndexAccess (toJMLType arrType) arrName (symExprToExpr jmlState arrIndexSymExpr)
       SYT.SymArray mElemType mArrSize symExprs ->
         JMLArray (toJMLType <$> mElemType) (symExprToExpr jmlState <$> mArrSize) (map (symExprToExpr jmlState) symExprs)
       SYT.SymFun definedFun symExpr -> SymFun
         (toDefinedFun definedFun) (symExprToExpr jmlState symExpr)
       SYT.SymNull symType -> JMLNull (toJMLType symType)
       _ -> error $ printf "%s: TODO: %s" loc (show symExpr)

-- is similar to `symExprToExpr` but with one difference (when `symExpr` ==> `SYT.SymVar`).
-- This is used in `JML.Internal.LoopInvariants`
symExprToExpr2 :: SYT.SymbolicExecutionValue -> Expr
symExprToExpr2 symExpr =
  let loc = "JML.Internal.Internal.symExprToExpr2"
  in case symExpr of
       SYT.SymDouble num -> JMLDouble num
       SYT.SymInt num -> JMLInt (fromIntegral num)
       SYT.SymVar t vn -> JMLVar (toJMLType t) vn
       SYT.SymNum num -> JMLNum num
       SYT.SBin symExpr1 op symExpr2 ->
         JMLBin (symExprToExpr2 symExpr1)
                (symBinOpToOp op)
                (symExprToExpr2 symExpr2)
       SYT.SymString str -> JMLString str
       SYT.SActions symExprs -> JMLActions $ map symExprToExpr2 symExprs
       SYT.SymUnknown (vn,symExpr) symReasons ->  let
         scopeRanges :: [CFGT.ScopeRange]
         scopeRanges = concatMap SY.Internal.getScopeRangesFromSymReason symReasons
         in JMLVarUnknown scopeRanges
              (toJMLType $ SY.Internal.toSymType2 symExpr) vn (symExprToExpr2 symExpr)
       SYT.SException t str1 str2 -> JMLException (toJMLType t) str1 str2
       SYT.SBool b -> JMLBool b
       SYT.SObjAcc li -> JMLObjAcc li
       SYT.SArrayIndexAccess arrType arrName arrIndexSymExpr ->
         JMLArrayIndexAccess (toJMLType arrType) arrName (symExprToExpr2 arrIndexSymExpr)
       SYT.SymArray mElemType mArrSize symExprs ->
         JMLArray (toJMLType <$> mElemType) (symExprToExpr2 <$> mArrSize) (map symExprToExpr2 symExprs)
       SYT.SymFun definedFun symExpr -> SymFun
         (toDefinedFun definedFun) (symExprToExpr2 symExpr)
       SYT.SymNull symType -> JMLNull (toJMLType symType)
       _ -> error $ printf "%s: TODO: %s" loc (show symExpr)

toDefinedFun :: SYT.DefinedFun -> DefinedFun
toDefinedFun = \case
  SYT.ToString -> ToString
  SYT.Print -> Print
  SYT.Println -> Println
  SYT.UserDefined str -> UserDefined str

toJMLType :: SYT.SymType -> JMLType
toJMLType symType = let
  loc = "JML.Internal.Internal.toJMLType" in
  case symType of
    SYT.Int -> Int_Type
    SYT.Double -> Double_Type
    SYT.String -> String_Type
    SYT.UnknownGlobalVarSymType -> Unknown_Type
    SYT.Bool -> Bool_Type
    SYT.UnknownNumSymType -> Num_Type
    SYT.Array symType -> Array_Type (toJMLType symType)
    _ -> error $ printf "%s: TODO: %s" loc (show symType)

toJMLType2 :: Expr -> JMLType
toJMLType2 expr = let
  loc = "JML.Internal.Internal.toJMLType2" in
  case expr of
    JMLInt _ -> Int_Type
    JMLDouble _ -> Double_Type
    JMLNum _ -> Unknown_Type
    JMLString _ -> String_Type
    JMLVar t _ -> t
    JMLBin expr1 op expr2
      | op `elem` [Gt,Ge,Lt,Le,Eq,Neq] -> Bool_Type
      | otherwise -> let
          t1 = toJMLType2 expr1
          t2 = toJMLType2 expr2
          in if t1 == t2 then
               t1
             else error $ printf "%s: TODO1: %s" loc (show expr)
    JMLOld expr -> toJMLType2 expr
    JMLException t _ _ -> t
    JMLBool _ -> Bool_Type
    _ -> error $ printf "%s: TODO2: %s" loc (show expr)

inferJMLType :: Expr -> JMLType
inferJMLType expr = let
  loc = "JML.Internal.Internal.inferJMLType" in
  case expr of
    JMLInt _ -> Int_Type
    JMLDouble _ -> Double_Type
    JMLNum _ -> Num_Type
    JMLString _ -> String_Type
    JMLBin expr1 op expr2
      | op `elem` [Gt,Ge,Lt,Le,Eq,Neq,And,Or] -> Bool_Type
      | otherwise -> let
          type1 = inferJMLType expr1
          type2 = inferJMLType expr2 in
          if type1 /= type2 then
             error $ printf
               "%s: won't happen:\n\
               \  expr = %s\n\
               \  type1 = %s\n\
               \  type2 = %s" loc
               (show expr)
               (show type1)
               (show type2)
          else type1
    JMLVar t _ -> t
    JMLNot _ -> Bool_Type
    JMLOld expr -> inferJMLType expr
    JMLResult expr -> inferJMLType expr
    JMLVarUnknown _ t _ _ -> t
    JMLBool _ -> Bool_Type
    SymFun ToString _ -> String_Type
    _ -> error $ printf "%s: TODO: %s" loc (show expr)

convertImplication :: ClauseValue -> Expr
convertImplication val = let
  loc = "JML.Internal.Internal.convertImplication" in
  case val of
    Implication cond (VarAssignment (_,vn,implicationVal)) -> let
      left = JMLVar (toJMLType2 implicationVal) vn
      right = cond `JMLImplies` implicationVal
      in left `JMLEquals` right
    Implication cond (VarInRange (_,vn,(from,to))) -> let
      left = JMLVar (toJMLType2 from) vn
      right = cond `JMLImplies` JMLRange vn from to
      in left `JMLEquals` right
    _ -> error $ constructErrorMsg loc "TODO" [("val",show val)]

-- Bin (Var "i") Gt (Int 10)
negate :: Expr -> Expr
negate expr = let
  loc = "JML.Internal.Internal.negate" in
  case expr of
     JMLBin expr1 op expr2
       | op `elem` [Gt,Ge,Lt,Le,Eq,Neq,Mod] -> let
           newOp = case op of
             Gt  -> Le
             Ge  -> Lt
             Lt  -> Ge
             Le  -> Gt
             Eq  -> Neq
             Neq -> Eq
           in JMLBin expr1 newOp expr2
       | op `elem` [And,Or] -> let
           newOp = case op of
             And -> Or
             Or -> And
           in JMLBin (negate expr1) newOp (negate expr2)
     _ -> error $ printf "%s: TODO: %s" loc (show expr)

symBinOpToOp :: SYT.SymBinOp -> Op
symBinOpToOp symBinOp = case symBinOp of
  SYT.Add -> Add
  SYT.Mul -> Mul
  SYT.Sub -> Sub
  SYT.Gt  -> Gt
  SYT.Ge  -> Ge
  SYT.Lt  -> Lt
  SYT.Le  -> Le
  SYT.Eq  -> Eq
  SYT.Mod -> Mod
  SYT.Or  -> Or
  _ -> error $ printf "JML.Internal.symBinOpToOp: TODO: %s" (show symBinOp)

hasReturn :: [ExecutionResult] -> Bool
hasReturn ers = case flip find ers (\case
  ER_ReturnException _ -> True
  ER_Return _ -> True
  ER_ReturnVoid -> True
  _ -> False) of
  Just _ -> True
  Nothing -> False

clauseValueHasJMLVarUnknown :: ClauseValue -> Bool
clauseValueHasJMLVarUnknown clauseValue = case clauseValue of
  Ensures expr -> hasJMLVarUnknown0 expr
  LoopInvariant expr -> hasJMLVarUnknown0 expr
  Signals _ expr -> hasJMLVarUnknown0 expr
  Assignable _ -> False
  VarAssignment (_,_,expr) -> hasJMLVarUnknown0 expr
  HasSideEffect -> False

-- does an expression has JMLVarUnknown for `vn`?
hasJMLVarUnknown :: String -> Expr -> Bool
hasJMLVarUnknown vn expr = let
  loc = "JML.Internal.Internal.hasJMLVarUnknown" in
  case expr of
    JMLBin expr1 op expr2 -> hasJMLVarUnknown vn expr1 || hasJMLVarUnknown vn expr2
    JMLVarUnknown _ _ vn2 _ -> vn == vn2
    JMLInt _ -> False
    JMLString _ -> False
    JMLVar _ _ -> False
    JMLBool _ -> False
    SymFun ToString expr -> hasJMLVarUnknown vn expr
    JMLOld expr -> hasJMLVarUnknown vn expr
    JMLNum _ -> False
    JMLArrayIndexAccess _ _ expr -> hasJMLVarUnknown vn expr
    _ -> error $ printf "TODO in %s ==> %s" loc (show expr)

hasJMLVarUnknown0 :: Expr -> Bool
hasJMLVarUnknown0 expr = let
  loc = "JML.Internal.Internal.hasJMLVarUnknown0" in
  case expr of
    JMLBin expr1 op expr2 -> hasJMLVarUnknown0 expr1 || hasJMLVarUnknown0 expr2
    JMLVarUnknown _ _ _ _ -> True
    JMLInt _ -> False
    JMLString _ -> False
    JMLVar _ _ -> False
    JMLBool _ -> False
    SymFun ToString expr -> hasJMLVarUnknown0 expr
    JMLOld expr -> hasJMLVarUnknown0 expr
    JMLNum _ -> False
    JMLArrayIndexAccess _ _ expr -> hasJMLVarUnknown0 expr
    _ -> error $ printf "TODO in %s ==> %s" loc (show expr)

substitute_JMLVarUnknown :: (CFGT.ScopeRange,String) -> Expr -> Expr -> Expr
substitute_JMLVarUnknown (sr,vn) old_expr new_expr = let
  loc = "JML.Internal.Internal.substitute_JMLVarUnknown"
  logContents = [
    ("old_expr",show old_expr),
    ("new_expr",show new_expr),
    ("sr",show sr),
    ("vn",vn)] in
  case old_expr of
    JMLVarUnknown scopeRanges _ _ _
      | sr `elem` scopeRanges -> new_expr
      | otherwise -> error $ constructErrorMsg loc "TODO1" logContents
    _ -> error $ constructErrorMsg loc "TODO2" logContents

-- is JMLVar concrete?
isJMLVarConcrete :: Expr -> Bool
isJMLVarConcrete expr = let
  loc = "JML.Internal.Internal.isJMLVarConcrete" in
  case expr of
    JMLInt _ -> True
    JMLDouble _ -> True
    JMLNum _ -> True
    JMLBool _ -> True
    JMLString _ -> True
    JMLNull _ -> True
    _ -> error $ printf "TODO in %s ==> %s" loc (show expr)

-- when an array is accessed by an index,
-- the expression of this index is returned.
-- JMLArrayIndexAccess <array type> <array name> <index expression>
--   ==> <index expression>
-- JMLArrayIndexAccess (Array_Type Int_Type) "arr" (JMLVar Int_Type "i")
--   ==> JMLVar Int_Type "i"
getArrayAccessIndex :: String -> Expr -> Expr
getArrayAccessIndex arrName expr = let
  loc = "JML.Internal.Internal.getArrayAccessIndex" in
  case expr of
    JMLArrayIndexAccess _ arrName2 resExpr
      | arrName == arrName2 -> resExpr
    _ -> error $ constructErrorMsg loc "TODO" [("expr",show expr)]

addToDefaultClause :: ClauseValue -> JMLMonad ()
addToDefaultClause clauseValue = do
  let loc = "JML.Internal.Internal.addToDefaultClause"
  tellNextLog $ Log.Location loc (show clauseValue)
  modify $ \(JMLState jmlMethod stack jmlLogHeader formal local global reAss pathNum) -> JMLState {
    method = jmlMethod,
    jmlStack = [res
      | Requires (a,b) values <- stack
      , let res = Requires (a,b) $ values ++ [clauseValue]],
    logHeader = jmlLogHeader,
    formalParms = formal,
    localVars = local,
    globalVars = global,
    reAssigned = reAss,
    pathCreationEnumeration = pathNum
  }
  tellingReportTheState loc $> ()

combinePreconditions :: Maybe Expr -> Op -> Maybe Expr -> Maybe Expr
combinePreconditions mPre1 op mPre2 = case (mPre1,mPre2) of
  (Nothing,Nothing) -> Nothing
  (Nothing,Just pre2) -> Just pre2
  (Just pre1,Nothing) -> Just pre1
  (Just pre1,Just pre2) -> Just $ JMLBin pre1 op pre2

-- when default clause has a precondition
mutateDefaultClause :: Expr -> JMLMonad ()
mutateDefaultClause newPrecondition = do
  let loc = "JML.Internal.Internal.mutateDefaultClause"
  constructLog loc "mutateDefaultClause"
    [("newPrecondition",show newPrecondition)]
  modify $ \jmlState -> JMLState {
    method   = method jmlState,
    jmlStack = [Requires (maybe_sr,res) li
      | Requires (maybe_sr,maybe_preCondition) li <- jmlStack jmlState
      , let res = combinePreconditions
              maybe_preCondition And (Just newPrecondition)
      ],
    logHeader = logHeader jmlState,
    formalParms = formalParms jmlState,
    localVars = localVars jmlState,
    globalVars = globalVars jmlState,
    reAssigned = reAssigned jmlState,
    pathCreationEnumeration = pathCreationEnumeration jmlState
  }
  tellingReportTheState $ loc ++ " <<look at the stack>>"
  return ()

processJMLVarUnknown_via_loopExitFacts :: CFGT.ScopeRange ->
  [(String,SYT.SymbolicExecutionValue)] ->
  Maybe SYT.SymbolicExecutionValue ->
  Maybe SYT.SymbolicExecutionValue ->
  [SYT.LoopExitFact]
  -> JMLMonad ()
processJMLVarUnknown_via_loopExitFacts scopeRange
  loopInitFacts loopInitialGuardCondition loopSkipCondition loopExitFacts = do
  let loc = "JML.Internal.Internal.processJMLVarUnknown_via_loopExitFacts"
      logContents = [
        ("scopeRange",show scopeRange),
        ("loopInitFacts",show loopInitFacts),
        ("loopInitialGuardCondition",show loopInitialGuardCondition),
        ("loopSkipCondition",show loopSkipCondition),
        ("loopExitFacts",show loopExitFacts)]
  constructLog loc "processJMLVarUnknown_via_loopExitFacts" logContents
  clauses <- jmlStack <$> get
  newClauses <- forM clauses $ \(Requires tu vals) -> do
    newVals <- forM vals $ \clauseValue -> case clauseValue of
      Ensures ((JMLVar _ vn) `JMLEquals` expr) -> case get_fact vn of
        Nothing -> return [clauseValue]
        Just fact -> err loc expr fact 1
      Ensures ((JMLVar _ vn) `JMLNotEquals` expr) -> case get_fact vn of
        Nothing -> return [clauseValue]
        Just fact -> err loc expr fact 2
      LoopInvariant _ -> return [clauseValue]
      Signals vn expr -> case get_fact vn of
        Nothing -> return [clauseValue]
        Just fact -> err loc expr fact 3
      Assignable _ -> return [clauseValue]
      VarAssignment _ -> processVarAssignment clauseValue
      HasSideEffect -> return [clauseValue]
    return $ Requires tu (concat newVals)
  tellingReportTheStack loc "<new clauses>" newClauses
  modify $ \jmlState -> JMLState {
    method    = method jmlState,
    jmlStack  = newClauses,
    logHeader = logHeader jmlState,
    formalParms = formalParms jmlState,
    localVars = localVars jmlState,
    globalVars = globalVars jmlState,
    reAssigned = reAssigned jmlState,
    pathCreationEnumeration = pathCreationEnumeration jmlState
  }
  return () where
  ----------
  err :: String -> Expr -> SYT.LoopExitFact -> Int -> a
  err place expr fact num = error
    $ constructErrorMsg place (printf "TODO%d" num) [
        ("expr",show expr),
        ("fact",show fact)]
  ----------
  studyFact :: SYT.LoopExitFact -> Expr -> [Expr]
  studyFact fact old_expr = let
    loc = "JML.Internal.Internal.processJMLVarUnknown_via_loopExitFacts.studyFact"
    logContents = [("fact",show fact),("old_expr",show old_expr)] in
    case fact of
      SYT.LoopExitFactValue vn new_expr -> [
        substitute_JMLVarUnknown (scopeRange,vn) old_expr
        $ symExprToExpr2 new_expr]
      SYT.LoopExitFactRange vn expr1 expr2 -> map
        (substitute_JMLVarUnknown (scopeRange,vn) old_expr . symExprToExpr2)
        [expr1,expr2]
  ----------
  get_fact :: String -> Maybe SYT.LoopExitFact
  get_fact = SY.Internal.getFactAbout loopExitFacts
  ----------
  processVarAssignment :: ClauseValue -> JMLMonad [ClauseValue]
  processVarAssignment clauseValue@(VarAssignment (t,vn,expr)) = do
    let loc = "JML.Internal.Internal.processJMLVarUnknown_via_loopExitFacts.processVarAssignment"
        logContents = [("clauseValue",show clauseValue)]
    constructLog loc "processVarAssignment" logContents
    case get_fact vn of
      Nothing -> let
        toReturn = [clauseValue]
        in (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
      Just fact -> do
        constructLog loc "fact found" $ logContents ++ [
          ("fact",show fact),("expr",show expr)]
        incrementLogDepth
        res <- case studyFact fact expr of
          ---
          [new_expr] -> let
            newVal1 = case loopInitialGuardCondition of
              Nothing -> err loc expr fact 1
              Just cond -> Implication (symExprToExpr2 cond) $
                VarAssignment (t,vn,new_expr)
            newVal2 = case loopSkipCondition of
              Nothing -> err loc expr fact 2
              Just cond -> case lookup vn loopInitFacts of
                Just init_expr -> Implication (symExprToExpr2 cond) $
                  VarAssignment (t,vn,symExprToExpr2 init_expr)
                Nothing -> err loc expr fact 3
            in do constructLog loc "fact creates new value" [
                    ("new_expr",show new_expr),
                    ("newVal1",show newVal1),
                    ("newVal2",show newVal2)]
                  return [newVal1,newVal2]
          ---
          [from_expr,to_expr] -> let
            newVal1 = case loopInitialGuardCondition of
              Nothing -> err loc expr fact 4
              Just cond -> Implication (symExprToExpr2 cond) $
                VarInRange (t,vn,(from_expr,to_expr))
            newVal2 = case loopSkipCondition of
              Nothing -> err loc expr fact 5
              Just cond -> case lookup vn loopInitFacts of
                Just init_expr -> Implication (symExprToExpr2 cond) $
                  VarAssignment (t,vn,symExprToExpr2 init_expr)
            in do constructLog loc "fact creates range" [
                    ("from_expr",show from_expr),
                    ("to_expr",show to_expr),
                    ("newVal1",show newVal1),
                    ("newVal2",show newVal2)]
                  return [newVal1,newVal2]
        decrementLogDepth
        (tellNextLog $ Log.Return loc (show res)) $> res

emptyNormalBehavior :: Behavior
emptyNormalBehavior = NormalBehavior {
  behaviorScopeRange = Nothing,
  requires = Nothing,
  assignable = [],
  vars = [],
  hasSideEffect = False,
  ensures = []
}

getSymbolicExecution :: JMLMonad SYT.SymbolicExecution
getSymbolicExecution = (Map.!) <$>
  ask <*> ((name . method) <$> get)

-- creates a pre condition such as `requires <arrName> != null`
--     when array is accessed
createExpr_arr_not_null :: Expr -> SYT.SymbolicExecution -> [Expr]
createExpr_arr_not_null expr symExec = flip map (whichArrsAccessed expr) $ \case
  (Just arrType,arrName) ->
    JMLBin (JMLVar arrType arrName) Neq (JMLNull arrType)
  (Nothing,arrName) -> let
    Just arrType = toJMLType
      <$> SY.Internal.getVarNameSymType arrName symExec in
    JMLBin (JMLVar arrType arrName) Neq (JMLNull arrType)

createExpr_arr_not_null2 :: (JMLType,String) -> Expr
createExpr_arr_not_null2 (arrType,arrName) = JMLBin
  (JMLVar arrType arrName) Neq (JMLNull arrType)

createExpr_arrIndex_within_range :: (String,Expr) -> Expr
createExpr_arrIndex_within_range (arrName,index) =
  let left = JMLBin (JMLInt 0) Le index
      right = JMLBin index Lt (JMLObjAcc [arrName,"length"])
  in JMLBin left NonFlattableAnd right 

-- This functions gets passed an array name `arrName`
--     and a jml-expression.
-- Then this jml-expression will get scanned for this `arrName`
--     to find an expression of the form <JMLBin (JMLVar _ <arrName>) _ (JMLNull _)>
-- if such expression is found, then return True.
equalsNullIn :: String -> Expr -> Bool
equalsNullIn arrName expr = let
  loc = "JML.Internal.Internal.equalsNullIn" in case expr of
  JMLBin (JMLVar (Array_Type _) arrName2) _ (JMLNull _) -> arrName == arrName2
  JMLBin expr1 _ expr2 -> any (arrName `equalsNullIn`) [expr1,expr2]
  JMLVar _ _ -> False
  JMLInt _ -> False
  JMLDouble _ -> False
  JMLNum _ -> False
  JMLBool _ -> False
  JMLString _ -> False
  JMLNull _ -> False
  JMLObjAcc _ -> False
  JMLArrayIndexAccess _ _ _ -> False
  _ -> error $ printf "TODO1 in %s ==> %s" loc (show expr)

isJMLVarUnknown :: Expr -> Bool
isJMLVarUnknown = \case
  JMLVarUnknown _ _ _ _ -> True
  _ -> False

whichArrsAccessed :: Expr -> [(Maybe JMLType,String)]
whichArrsAccessed expr = let
  loc = "JML.Internal.Internal.whichArrsAccessed" in case expr of
  JMLObjAcc [arrName,"length"] -> [(Nothing,arrName)]
  JMLArrayIndexAccess arrType arrName _ -> [(Just arrType,arrName)]
  JMLArray _ _ arrElems -> concatMap whichArrsAccessed arrElems
  JMLArray _ _ _ -> error $ printf "TODO3 in %s ==> %s" loc (show expr)
  JMLVar _ _ -> []
  JMLVarUnknown _ _ _ expr -> whichArrsAccessed expr
  JMLInt _ -> []
  JMLDouble _ -> []
  JMLNum _ -> []
  JMLBool _ -> []
  JMLString _ -> []
  JMLNull _ -> []
  JMLBin expr1 _ expr2 -> concatMap whichArrsAccessed [expr1,expr2]
  JMLOld expr -> whichArrsAccessed expr
  JMLException _ _ _ -> []
  SymFun _ expr -> whichArrsAccessed expr
  _ -> error $ printf "TODO4 in %s ==> %s" loc (show expr)

addBehavior :: SYT.SymbolicExecution -> ExecutionResult -> JMLMonad ()
addBehavior sy er = do
  let loc = "JML.Internal.Internal.addBehavior"
  tellNextLog $ Log.Location loc (show er)
  case er of
    ER_ReturnException _ -> addBehaviorViaReturn er
    ER_Void -> logSkipping loc
    ER_ReturnVoid -> addBehaviorViaReturn er
    ER_LoopConditions _ _ -> logSkipping loc
    ER_Actions _ -> do
      incrementLogEnumeration
      incrementLogDepth *> addToDefaultClause HasSideEffect <* decrementLogDepth
    ER_Return _ -> addBehaviorViaReturn er
    --
    ER_VarName_Global_Reassigned vn symExpr mSR -> do
      let innerLoc = printf "%s ==> ER_VarName_Global_Reassigned" loc
      do incrementLogEnumeration
         incrementLogDepth *> addToDefaultClause (Assignable [vn]) <* decrementLogDepth
      jmlState <- get
      let expr = symExprToExpr jmlState symExpr
      do let newVarAssignment = VarAssignment (
               toJMLType $ SY.Internal.toSymType2 symExpr,
               vn,
               expr)
         incrementLogEnumeration
         incrementLogDepth
         addToDefaultClause newVarAssignment
         decrementLogDepth
         
      -- determine the left and right operand for the `Ensures` annotation
      do let rightOperand = expr
             ensuresExpr = JMLVar (inferJMLType rightOperand) vn `JMLEquals` rightOperand
         incrementLogEnumeration
         incrementLogDepth *> addToDefaultClause (Ensures ensuresExpr) <* decrementLogDepth
      
      -- if an array is being accessed, then add required arr != null
      case whichArrsAccessed expr of
        [] -> return ()
        x -> throwError $ constructErrorMsg innerLoc "TODO"
          [("er",show er),("x",show x)]
    --
    ER_VarName vn symExpr mSR -> do
      let innerLoc = printf "%s ==> ER_VarName" loc :: String
      jmlState <- get
      -- logging
      do tellingReportTheState (loc ++ " <<before adding new clause value to default Clause>>")
         (jmlStack <$> get) >>= tellingReportTheStack loc
           "<<before adding new clause value to default Clause>>"
      expr <- flip symExprToExpr symExpr <$> get
      let newClauseValue1 = VarAssignment (
            toJMLType $ SY.Internal.toSymType2 symExpr,
            vn,
            expr)
      -- add to default clause
      do incrementLogEnumeration
         incrementLogDepth
         addToDefaultClause newClauseValue1
         decrementLogDepth
      -- logging
      constructLog innerLoc "new Clause Value added to default Clause"
        [("newClauseValue1",show newClauseValue1)]
      -- logging
      do tellingReportTheState (loc ++ " <<after adding new clause value to default Clause>>")
         (jmlStack <$> get) >>= tellingReportTheStack loc
           "<<after adding new clause value to default Clause>>"
      return ()
    --
    ER_VarName_Unassigned _ _ _ -> logSkipping loc
    --
    ER_ArrayAccess li -> do
      let innerLoc = printf "%s ==> ER_ArrayAccess" loc :: String
          logContents = [("li",show li)]
      constructLog innerLoc "ER_ArrayAccess" logContents
      -- `extractArrays` gets mentioned arrays
      let extractArray :: (SYT.SymType,String,SYT.SymbolicExecutionValue) -> (SYT.SymType,String)
          extractArray (arrType,arrName,_) = (arrType,arrName)
          thrdTu_li :: (Either b a,Maybe a,Either b a) -> [a]
          thrdTu_li tu@(x1,x2,x3) = let
            two = maybe [] ((:[]) . id) x2 in case (x1,x3) of
            (Right one,Right three) -> [one] ++ two ++ [three]
            (Right one,Left _)   -> one : two
            (Left _,Right three) -> two ++ [three]
            (Left _,Left _)      -> two
          extractArrays :: [(SYT.SymType,String)]
          extractArrays = concatMap (map extractArray . thrdTu_li) li

      jmlState <- get
      -- `nonNullableArrays` is a collections of arrays that has the form:
      -- Just JMLBin (JMLVar <array type> <array name>) Neq (JMLNull <array type>)
      -- The goal is to denote the fact that the arrays has to not be null in order to be accessed--createExpr_arr_not_null2
      let nonNullableArrays :: Maybe Expr
          nonNullableArrays = case nub extractArrays of
            [] -> error $ constructErrorMsg innerLoc "won't happen" logContents
            ((symType1,arrName1) : rest) -> foldl'
              (\l (symType2,arrName2) -> combinePreconditions
                l And (Just $ createExpr_arr_not_null2 (toJMLType symType2,arrName2)))
              (Just $ createExpr_arr_not_null2 (toJMLType symType1,arrName1)) rest
      {-
      li: [(Nothing,Nothing,Just (Array Int,"arr",SymVar Int "i"))
          ,(Just (Array Int,"arr",SymVar Int "i"),Nothing,Just (Array Int,"arr",SymVar Int "j"))
          ,(Just (Array Int,"arr",SymVar Int "j"),Nothing,Nothing)]
      output: Just
        $ JMLBin (JMLBin (JMLBin (JMLInt 0) Le (JMLVar Int_Type "i"))
                         NonFlattableAnd
                         (JMLBin (JMLVar Int_Type "i") Lt (JMLObjAcc ["arr","length"])))
                 And
                 (JMLBin (JMLBin (JMLInt 0) Le (JMLVar Int_Type "j"))
                         NonFlattableAnd
                         (JMLBin (JMLVar Int_Type "j") Lt (JMLObjAcc ["arr","length"])))
       -}
      let requires_access_indexes_within_range :: Maybe Expr
          requires_access_indexes_within_range = case [res
            | (_,arrName,indexSymExpr) <- nub $ concatMap thrdTu_li li
            , let res = createExpr_arrIndex_within_range (arrName,symExprToExpr jmlState indexSymExpr)
            ] of
            [] -> error $ constructErrorMsg innerLoc "won't happen" logContents
            (first : rest) -> foldl'
              (\l r -> combinePreconditions l And (Just r))
              (Just first) rest
      let arrAssignable :: ClauseValue
          arrAssignable = Assignable
            [res | (Right (_,arrName,SYT.SymVar _ indexName),_,_) <- li
                 , let res = printf "%s[%s]" arrName indexName]
      {-
      li: [(Left (SymVar Int "temp"),Nothing,Right (Array Int,"arr",SymVar Int "i")),
           (Right (Array Int,"arr",SymVar Int "i"),Nothing,Right (Array Int,"arr",SymVar Int "j")),
           (Right (Array Int,"arr",SymVar Int "j"),Nothing,Left (SArrayIndexAccess (Array Int) "arr" (SymVar Int "i")))]
      output: [
        Ensures $
          JMLArrayIndexAccess (Array_Type Int_Type) "arr" (JMLVar Int_Type "i")
            `JMLEquals`
              JMLOld (JMLArrayIndexAccess (Array_Type Int_Type) "arr" (JMLVar Int_Type "j")),
        Ensures $
          JMLArrayIndexAccess (Array_Type Int_Type) "arr" (JMLVar Int_Type "j")
            `JMLEquals`
              JMLOld (JMLArrayIndexAccess (Array_Type Int_Type) "arr" (JMLVar Int_Type "i"))]
       -}
      let arrIndexesEnsures :: [ClauseValue]
          arrIndexesEnsures = [Ensures expr
            | (Right (arrType1,arrName1,arrIndexSymExpr1),_,rightSide) <- li
            , let f (arrType2,arrName2,arrIndexSymExpr2) = symExprToExpr jmlState
                    $ SYT.SArrayIndexAccess arrType2 arrName2 arrIndexSymExpr2
            , let leftExpr = symExprToExpr jmlState
                    $ SYT.SArrayIndexAccess arrType1 arrName1 arrIndexSymExpr1
                  rightExpr = JMLOld $ either (symExprToExpr jmlState) f rightSide
                  expr = leftExpr `JMLEquals` rightExpr
                  
            ]
      -- add new preconditions (nonNullableArrays) and (requires_access_indexes_within_range)
      -- to default clause
      do incrementLogEnumeration
         incrementLogDepth
         mutateDefaultClause $ let
           Just newPreCondition = combinePreconditions
             nonNullableArrays And requires_access_indexes_within_range
           in newPreCondition
         decrementLogDepth
      -- add (arrAssignable) and (arrIndexesEnsures) to default clause
      do incrementLogEnumeration
         incrementLogDepth
         addToDefaultClause arrAssignable
         forM_ arrIndexesEnsures addToDefaultClause
         decrementLogDepth
      --
      (jmlStack <$> get) >>=
        tellingReportTheStack innerLoc "stack in the end"
      --
      constructLog innerLoc "summary in the end" $ logContents
        ++ [("nonNullableArrays",show nonNullableArrays)
           ,("requires_access_indexes_within_range",show requires_access_indexes_within_range)
           ,("arrAssignable",show arrAssignable)
           ,("arrIndexesEnsures",show arrIndexesEnsures)]
      return ()
    --
    ER_VarBindings ma -> modify $ \jmlState -> JMLState {
      method    = method jmlState,
      jmlStack  = jmlStack jmlState,
      logHeader = logHeader jmlState,
      formalParms = formalParms jmlState,
      localVars = Map.keys ma,
      globalVars = globalVars jmlState,
      reAssigned = reAssigned jmlState,
      pathCreationEnumeration = pathCreationEnumeration jmlState
    }
    ER_VarAssignments li -> modify $ \jmlState -> JMLState {
      method    = method jmlState,
      jmlStack  = jmlStack jmlState,
      logHeader = logHeader jmlState,
      formalParms = formalParms jmlState,
      localVars = localVars jmlState,
      globalVars = globalVars jmlState,
      reAssigned = map fst li,
      pathCreationEnumeration = pathCreationEnumeration jmlState
    }
    ER_GlobalVars li -> modify $ \jmlState -> JMLState {
      method    = method jmlState,
      jmlStack  = jmlStack jmlState,
      logHeader = logHeader jmlState,
      formalParms = formalParms jmlState,
      localVars = localVars jmlState,
      globalVars = li,
      reAssigned = reAssigned jmlState,
      pathCreationEnumeration = pathCreationEnumeration jmlState
    }
    ER_FormalParms li -> modify $ \jmlState -> JMLState {
      method    = method jmlState,
      jmlStack  = jmlStack jmlState,
      logHeader = logHeader jmlState,
      formalParms = li,
      localVars = localVars jmlState,
      globalVars = globalVars jmlState,
      reAssigned = reAssigned jmlState,
      pathCreationEnumeration = pathCreationEnumeration jmlState
    }
    --
    ER_IfThenElse (_,scopeRange) (ifRequires,ifJMLState,if_ers) maybeElse -> do
      let innerLoc = printf "%s ==> ER_IfThenElse" loc :: String
      tellingReportTheState innerLoc
      ---------- if
      -- add the behaviors of the if body
      ifBehaviors :: [Behavior] <- do
        -- check if an array is accessed (read).
        -- if yes, then modify the precondition correspondingly
        modified_ifRequires <- do
          jmlState <- get
          symExec <- getSymbolicExecution
          let new_preConds = flip filter (createExpr_arr_not_null ifRequires symExec)
                $ \(JMLBin (JMLVar _ arrName) _ _) ->
                     (not $ arrName `equalsNullIn` ifRequires) &&
                     (any (\f -> f arrName jmlState) [isFormalParm,isGlobalVar])
          return $ case new_preConds of
            [] -> Just ifRequires
            li -> foldl' (\l r -> combinePreconditions (Just r) And l) (Just ifRequires) li
        let newIfBehaviors =
              [res | MethodSpecification b <- jmlSpecifications $ method ifJMLState
                   , let clause = Requires (Just scopeRange,modified_ifRequires) []
                   , let res = addClauseToBehavior b clause
                   ]
        forM newIfBehaviors $ \b -> do
          incrementLogEnumeration
          incrementLogDepth *> addBehaviorToState b <* decrementLogDepth
      --
      tellNextLog
        $ Log.IfBehavior innerLoc (show ifBehaviors) (map ppBehavior ifBehaviors)
      tellingReportTheState innerLoc
      ---------- else
      -- add the behaviors of the else body
      maybeElseAfter <- case maybeElse of
        Nothing -> tellNextLog (Log.NoElseBody innerLoc) $> Nothing
        Just (elseRequires,elseJMLState,else_ers) -> do
          elseBehaviors :: [Behavior] <- do
            -- check if an array is accessed (read).
            -- if yes, then modify the precondition correspondingly
            modified_elseRequires <- do
              jmlState <- get
              symExec <- getSymbolicExecution
              let new_preConds = flip filter (createExpr_arr_not_null elseRequires symExec)
                    $ \(JMLBin (JMLVar _ arrName) _ _) ->
                         (not $ arrName `equalsNullIn` elseRequires) &&
                         (any (\f -> f arrName jmlState) [isFormalParm,isGlobalVar])
              return $ case new_preConds of
                [] -> Just elseRequires
                li -> foldl' (\l r -> combinePreconditions (Just r) And l) (Just elseRequires) li
            let newElseBehaviors =
                  [res | MethodSpecification b <- jmlSpecifications $ method elseJMLState
                       , let clause = Requires (Just scopeRange,modified_elseRequires) []
                             res = addClauseToBehavior b clause
                       ]
            forM newElseBehaviors $ \b -> do
              incrementLogEnumeration
              incrementLogDepth *> addBehaviorToState b <* decrementLogDepth
          --
          tellNextLog
            $ Log.ElseBehavior innerLoc (show elseBehaviors) (map ppBehavior elseBehaviors)
          tellingReportTheState innerLoc
          return $ Just (elseRequires,elseJMLState,else_ers,elseBehaviors)
      ---------- What happens after if and else
      -- if the „if body“ doesn't have a return statement,
      -- then a clause with the negated precondition of the if condition is to be created
      do let ifBodyHasReturn = hasReturn if_ers
             hasElseBody = maybe False (const True) maybeElseAfter
             elseBodyHasReturn = case maybeElseAfter of
               Just (elseRequires,_,else_ers,_) -> hasReturn else_ers
               _ -> False
             (elseRequires,elseJMLState,else_ers) = case maybeElseAfter of
               Just (elseRequires_,elseJMLState_,else_ers_,_) ->
                 (elseRequires_,elseJMLState_,else_ers_)
               _ -> undefined
         originalStack <- jmlStack <$> get
         -- tell clauses to be deleted
         -- these clauses will be passed to `inheritClausesFromInnerState`,
         -- and will be replaced with appropriate clauses,
         -- therefore it si to be deleted
         tellingReportTheStack innerLoc "deleting original clauses" originalStack
         modify $ \jmlState -> JMLState {
           method   = method jmlState,
           jmlStack = [],
           logHeader = logHeader jmlState,
           formalParms = formalParms jmlState,
           localVars = localVars jmlState,
           globalVars = globalVars jmlState,
           reAssigned = reAssigned jmlState,
           pathCreationEnumeration = pathCreationEnumeration jmlState
         }
         -- tell state after deleting original clauses
         tellingReportTheState (innerLoc ++ " <<after delelting original clauses>>")
         if -- both if and else body have return statement
            | ifBodyHasReturn && elseBodyHasReturn -> return ()
            -- both if and else body don't have return statement
            | not (ifBodyHasReturn || elseBodyHasReturn) -> do
                tellNextLog
                  $ Log.LogTag innerLoc "both if and else body don't have return statement" ""
                incrementLogEnumeration
                do incrementLogDepth
                   inheritClausesFromInnerState originalStack (jmlStack ifJMLState) (scopeRange,Just ifRequires)
                     "inheriting clauses from ifJMLState"
                   decrementLogDepth
                if | hasElseBody -> do
                       incrementLogDepth
                       inheritClausesFromInnerState originalStack (jmlStack elseJMLState) (scopeRange,Just elseRequires)
                         "inheriting clauses from elseJMLState"
                       decrementLogDepth
                   | otherwise -> do
                       incrementLogDepth
                       inheritClausesFromInnerState originalStack [] (scopeRange,Just $ negate ifRequires)
                         "no clauses to inherit (1)"
                       decrementLogDepth
            -- if body returns, else body returns nothing
            | ifBodyHasReturn -> do
                if | hasElseBody -> inheritClausesFromInnerState originalStack (jmlStack elseJMLState)
                       (scopeRange,Just elseRequires) "inheriting clauses from elseJMLState"
                   | otherwise -> inheritClausesFromInnerState originalStack []
                       (scopeRange,Just $ negate ifRequires) "no clauses to inherit (2)"
            -- if body returns nothing, else body returns
            | elseBodyHasReturn -> do
                inheritClausesFromInnerState originalStack (jmlStack ifJMLState) (scopeRange,Just ifRequires) "inheriting clauses from ifJMLState"
            | otherwise -> return ()
      ----------
      tellingReportTheState innerLoc
      return ()
    -- 
    ER_LoopSummary scopeRange invariantTemplates loopSummary -> do
      let innerLoc = printf "%s ==> ER_LoopSummary" loc :: String
          logContents = [
             ("scopeRange",show scopeRange),
             ("invariantTemplates",show invariantTemplates)
            ]
          newLoopSpecification = LoopInvariants scopeRange invariantTemplates
      constructLog innerLoc "ER_LoopSummary" logContents
      -- add to state
      modify $ \jmlState -> JMLState {
        method = Method {
          name = name $ method jmlState,
          jmlSpecifications = jmlSpecifications (method jmlState)
            ++ [LoopSpecification newLoopSpecification]
        },
        jmlStack = jmlStack jmlState,
        logHeader = logHeader jmlState,
        formalParms = formalParms jmlState,
        localVars = localVars jmlState,
        globalVars = globalVars jmlState,
        reAssigned = reAssigned jmlState,
        pathCreationEnumeration = pathCreationEnumeration jmlState
      }
      constructLog innerLoc "new loop specification added" [("newLoopSpecification",show newLoopSpecification)]
      -- check if there are JMLUnknownVars among the ClauseValues
      -- which can be solved with help of loopExitFacts
      do incrementLogEnumeration
         incrementLogDepth *>
           processJMLVarUnknown_via_loopExitFacts scopeRange
             (SYT.loopInitFacts loopSummary)
             (SYT.loopInitialGuardCondition loopSummary)
             (SYT.loopSkipCondition loopSummary)
             (SYT.loopExitFacts loopSummary)
             <* decrementLogDepth
      tellingReportTheState innerLoc
      return ()
    _ -> throwError $ constructErrorMsg loc "TODO" [("er",show er)]
  where
  addBehaviorViaReturn :: ExecutionResult -> JMLMonad ()
  addBehaviorViaReturn er = do
    let loc = "JML.Internal.Internal.addBehavior.addBehaviorViaReturn"
    tellNextLog $ Log.Location loc (show er)
    tellingReportTheState loc
    -- `maybeArrAccessed` denotes requires <arrName> != null
    -- `symExec` is used to figure out the type of the array
    -- that is accessed
    (theJMLResult,maybeArrAccessed) <- case er of
      ER_Return symExpr -> do
        jmlState <- get
        symExec <- getSymbolicExecution
        let expr = symExprToExpr jmlState symExpr
        constructLog loc "inferring JMLResult" [("expr",show expr)]
        let jmlResults = case expr of
              -- an unknown value may be known with help of implications
              -- so far, implications are the child of `ER_LoopSummary`
              JMLVarUnknown _ _ vn1 _ -> let
                implications = concat [implications
                  | Requires (Nothing,Nothing) vals <- jmlStack jmlState
                  , let implications = flip mapMaybe vals $ \val -> case val of
                          Implication _ (VarAssignment (_,vn2,_))
                            | vn1 == vn2 -> case convertImplication val of
                                JMLVar _ _ `JMLEquals` expr -> Just $ JMLResult expr
                            | otherwise -> Nothing
                          {-
Implication (JMLBin (JMLInt 0) Lt (JMLVar Int_Type "n"))
            (VarInRange (Int_Type,"i",(JMLVar Int_Type "n",JMLBin (JMLVar Int_Type "n") Add (JMLInt 2))))
                           -}
                          Implication _ (VarInRange (_,vn2,(from,to)))
                            | vn1 == vn2 -> case convertImplication val of
                                JMLVar _ _ `JMLEquals` expr -> Just $ JMLResult expr
                            | otherwise -> Nothing
                  ] in
                case implications of
                  [] -> [JMLResult expr]
                  _  -> implications
              _ -> [JMLResult expr]
        -- Every expression in `accessedArrays` has the form:
        -- JMLBin <JMLVar _ <Array Name>> Neq (JMLNull _)
        accessedArrays :: [Expr] <- do
          jmlState <- get
          return $ flip filter (createExpr_arr_not_null expr symExec)
            $ \(JMLBin (JMLVar _ arrName) _ _) ->
                (not $ arrName `equalsNullIn` expr) &&
                (any (\f -> f arrName jmlState) [isFormalParm,isGlobalVar])
        return $ (,) jmlResults
               $ case accessedArrays of
                   [] -> Nothing
                   (firstExpr : rest) -> foldl'
                     (\l r -> combinePreconditions l And (Just r))
                     (Just firstExpr) rest
      ER_ReturnVoid -> return $ (,) [JMLResult JMLVoid] Nothing
      ER_ReturnException exceptionName -> return $ (,) [] Nothing
    let noRequireBehavior = case er of
          ER_Return symExpr -> NormalBehavior {
            behaviorScopeRange = Nothing,
            requires = maybeArrAccessed,
            assignable = [],
            vars = [],
            hasSideEffect = False,
            ensures = theJMLResult
          }
          ER_ReturnVoid -> NormalBehavior {
            behaviorScopeRange = Nothing,
            requires = maybeArrAccessed,
            assignable = [],
            vars = [],
            hasSideEffect = False,
            ensures = theJMLResult
          }
          ER_ReturnException exceptionName -> ExceptionalBehavior {
            behaviorScopeRange = Nothing,
            requires = Nothing,
            signals = exceptionName,
            assignable = [],
            vars = [],
            hasSideEffect = False,
            ensures = []
          }
    allRequires <- jmlStack <$> get
    tellNextLog $ Log.Behavior (loc ++ " <<„empty“ behavior before adding stack to it>>") (show noRequireBehavior) (ppBehavior noRequireBehavior)
    tellingReportTheStack loc "stack <<before creating new behaviors>>" allRequires
    let newBehaviors :: [Behavior]
        newBehaviors
          | null allRequires = [noRequireBehavior]
          | otherwise = map (addClauseToBehavior noRequireBehavior) allRequires
        len = length newBehaviors
    forM_ (zip [1::Int ..] newBehaviors) $ \(counter,newBehavior) -> do
      tellNextLog $ Log.Behavior (loc ++ " <<new stacked behavior before it's added to state>>") (show newBehavior) (ppBehavior newBehavior)
      incrementLogDepth
      flip censor (addBehaviorToState newBehavior)
        (map $ \(Log.Log str logTag) ->
           Log.Log str
           $ flip Log.Nested logTag
           $ printf "Adding behavior %d/%d" counter len)
      decrementLogDepth
      tellingReportTheState loc
      return ()
  -- adding the behavior
  addBehaviorToState :: Behavior -> JMLMonad Behavior
  addBehaviorToState newBehavior = do
    let loc = "JML.Internal.Internal.addBehavior.addBehaviorToState"
    tellNextLog $ Log.AddBehaviorToState loc (show newBehavior)
    modify $ \(JMLState jmlMethod stack jmlLogHeader formal local global reAss pathNum) -> JMLState {
      method = Method {
        name = name jmlMethod,
        jmlSpecifications = jmlSpecifications jmlMethod ++ [MethodSpecification newBehavior]
      },
      jmlStack = stack,
      logHeader = jmlLogHeader,
      formalParms = formal,
      localVars = local,
      globalVars = global,
      reAssigned = reAss,
      pathCreationEnumeration = pathNum
    }
    return newBehavior
  -- adding clause to behavior
  addClauseToBehavior :: Behavior -> Clause -> Behavior
  addClauseToBehavior behavior clause@(Requires (theScopeRange,thePreCondition) values) = let
    loc = "JML.Internal.Internal.addBehavior.addClauseToBehavior"
    gettingAssignable = concat [li | Assignable li <- values]
    gettingVars = flip mapMaybe values $ \val -> case val of
      VarAssignment (t,vn,expr) -> Just $ JMLVar t vn `JMLEquals` expr
      Implication _ _ -> Just $ convertImplication val
      _ -> Nothing
    gettingSideEffect = HasSideEffect `elem` values
    gettingEnsures = [expr | Ensures expr <- values]
    newPreCondition = combinePreconditions (requires behavior) And thePreCondition
    processing = processJMLVarUnknown_behavior $ case behavior of
      NormalBehavior{} -> NormalBehavior {
        behaviorScopeRange = theScopeRange,
        requires = newPreCondition,
        assignable = nub $ assignable behavior ++ gettingAssignable,
        vars = vars behavior ++ gettingVars,
        hasSideEffect = hasSideEffect behavior || gettingSideEffect,
        ensures = ensures behavior ++ gettingEnsures
      }
      ExceptionalBehavior{} -> ExceptionalBehavior {
        behaviorScopeRange = theScopeRange,
        requires = newPreCondition,
        signals = signals behavior,
        assignable = nub $ assignable behavior ++ gettingAssignable,
        vars = vars behavior ++ gettingVars,
        hasSideEffect = hasSideEffect behavior || gettingSideEffect,
        ensures = ensures behavior ++ gettingEnsures
      } in
    processing
  --
  check_if_assignables_missing :: [String] -> Clause -> [(JMLType,String,Expr)]
  check_if_assignables_missing allGlobalVars (Requires _ clauseValues) = let
    loc = "JML.Internal.Internal.addBehavior.check_if_assignables_missing"
    clause_globalVars_exprs = [(t,vn,expr)
      | VarAssignment (t,vn,expr) <- clauseValues
      , vn `elem` allGlobalVars
      , let isReassigned = \case
              JMLOld ex -> isReassigned ex
              JMLVar _ vn2 -> vn /= vn2
              JMLString _ -> False
              ex -> error $ printf "TODO in %s: %s" loc (show ex)
      , isReassigned expr]
    clause_assignables = concat [li | Assignable li <- clauseValues]
    to_be_assignable = [(t,v,expr) | (t,v,expr) <- clause_globalVars_exprs, v `notElem` clause_assignables]
    in to_be_assignable
  --
  -- if a defaut clause exists, it gets replaced
  -- otherwise, a new clause is created
  -- this was first used in ER_IfThenElse
  createClause :: [Clause] -> Clause -> JMLMonad ()
  createClause originalClauses cl@(Requires (mSR,mPreCondition) newValues) = do
    let loc = "JML.Internal.Internal.addBehavior.createClause"
    tellNextLog $ Log.Location loc $ printf
      "\n\n\
      \*) %s:\n\
      \%s\n\n\
      \======\n\
      \======\n\
      \*) %s:\n\
      \%s"
      (yellow "original Clauses")
      (intercalate "\n------\n" $ map ppColoredClause originalClauses)
      (yellow "New Clause")
      (ppColoredClause cl)
    -- tell state
    tellingReportTheState (loc ++ " <<before creating the clause>>")
    num <- getPathEnumeration
    let defaultClauseVals :: [ClauseValue]
        defaultClauseVals = case (num,originalClauses) of
          (1,[Requires (Nothing,Nothing) vals]) -> vals
          _     -> []
    -- new clause <<unprocessed>>
    let new_unprocessed_Clause = Requires (mSR,mPreCondition)
          $ defaultClauseVals ++ newValues
    tellNextLog
      $ Log.LogTag loc "new clause <unprocessed>"
      $ ppColoredClause new_unprocessed_Clause
    -- new clause <<processed>>
    new_processed_Clause <- do
      let processed = nubClause $ processJMLVarUnknown_clause new_unprocessed_Clause
      -- if there are no new values, then there may be a reassigned globalvar
      --     which was not marked as assignable yet
      if null newValues then do
           allGlobalVars <- globalVars <$> get
           case check_if_assignables_missing allGlobalVars processed of
             [] -> return processed
             globalVars_to_add -> do
               tellNextLog $ Log.LogTag loc
                 "missing Assignables detected"
                 $ intercalate "\n"
                 $ map (\(counter,(_,v,_)) -> printf
                     "  %s %s"
                     (yellow $ printf "%d)" counter) v)
                 $ zip [1::Int ..] globalVars_to_add
               tellNextLog
                 $ Log.LogTag loc "new clause <semi processed>"
                 $ ppColoredClause processed
               let Requires tu vals = processed
               let gs = map (\(_,vn,_) -> vn) globalVars_to_add
               return $ Requires tu
                      $ -- add assignable(s)
                        alterList
                          (\case
                              Just (Assignable li) ->
                                [Assignable (li ++ gs)]
                              Nothing ->
                                [Assignable gs]
                          )
                          (\case
                              Assignable _ -> True
                              _ -> False
                          )
                          vals
                        -- add ensure(s)
                        ++ map (\(t,vn,expr) -> Ensures $ JMLVar t vn `JMLEquals` expr)
                               globalVars_to_add
         else return processed
    tellNextLog
      $ Log.LogTag loc "new clause <processed>"
      $ ppColoredClause new_processed_Clause
    -- add new clause
    modify $ \jmlState -> JMLState {
      method    = method jmlState,
      jmlStack = jmlStack jmlState ++ [new_processed_Clause],
      logHeader = logHeader jmlState,
      formalParms = formalParms jmlState,
      localVars = localVars jmlState,
      globalVars = globalVars jmlState,
      reAssigned = reAssigned jmlState,
      pathCreationEnumeration = pathCreationEnumeration jmlState
    }
    let logging logTag = tellNextLog $ Log.LogTag loc logTag
          $ printf "  %s: %s\n\
                   \  %s:\n\
                   \    %s"
                   (yellow "mPreCondition") (show mPreCondition)
                   (yellow "newValues")
                   (intercalate "\n    "
                    $ flip map (zip [1::Int ..] newValues) $ \(counter,newValue) ->
                        printf "%s %s" (yellow $ show counter ++ ")") (show newValue))
    tellingReportTheState loc
    return ()
  --
  isDefaultClause :: Clause -> Bool
  isDefaultClause = \case
    Requires (Nothing,Nothing) _ -> True
    _ -> False
  {-
  alterDefaultClausesPreCondition :: [Clause] -> Maybe Expr -> String -> JMLMonad ()
  alterDefaultClausesPreCondition originalStack new_mPreCondition nestedMsg = do
    
    inheritClausesFromInnerState originalStack [] (Nothing,new_mPreCondition) nestedMsg
  -}
  inheritClausesFromInnerState :: [Clause] -> [Clause] -> (CFGT.ScopeRange,Maybe Expr) -> String -> JMLMonad ()
  inheritClausesFromInnerState originalStack innerStateClauses (new_scopeRange,new_mPreCondition) nestedMsg = do
    let loc = "JML.Internal.Internal.addBehavior.inheritClausesFromInnerState"
    tellNextLog $ Log.Location loc $ printf
      "\n\
      \** %s:\n\
      \%s\n\n\
      \======\n\
      \======\n\
      \** %s:\n\
      \%s\n\n\
      \======\n\
      \======\n\
      \** %s: %s\n\n\
      \======\n\
      \======\n\
      \** %s: %s"
      (yellow "original stack") (intercalate "\n------\n" $ map ppColoredClause originalStack)
      (yellow "Inner State Clauses") (intercalate "\n------\n" $ map ppColoredClause innerStateClauses)
      (yellow "new scope Range") (show new_scopeRange)
      (yellow "new mPreCondition") (show new_mPreCondition)
    let helper (_,old_mPreCondition) vals nestedMsg = let
          -- new pre condition of the to-be-created clause
          mPreCondition = case catMaybes [old_mPreCondition,new_mPreCondition] of
            [] -> Nothing
            [cond] -> Just cond
            [oldCond,newCond] -> Just $ JMLBin oldCond And newCond in do
          incrementLogEnumeration
          incrementLogDepth
          flip censor
            (createClause originalStack $ Requires (Just new_scopeRange,mPreCondition) vals)
            (map $ \(Log.Log str logTag) ->
              Log.Log str $ Log.Nested nestedMsg logTag)
          decrementLogDepth
    if -- no clauses ==> createClause with no clauses + new pre condition
       | null innerStateClauses -> case originalStack of
           [clause]
             | isDefaultClause clause -> do
                 tellNextLog $ Log.LogTag loc
                   "no innerstateClauses, originalStack is default clause" ""
                 helper (Nothing,Nothing) [] nestedMsg
           _ -> let
             len = length originalStack in do
               tellNextLog $ Log.LogTag loc
                 "no innerstateClauses, originalStack is not default clause" ""
               forM_ (zip [1::Int ..] originalStack) $
                 \(counter,Requires old values) ->
                   helper old values (printf "%s %d of %d" nestedMsg counter len)
       -- yes clauses ==> createClause with no clauses + new pre condition
       | otherwise -> let
           len = length innerStateClauses in do
           tellNextLog $ Log.LogTag loc
             "yes innerstateClauses" ""
           forM_ (zip [1::Int ..] innerStateClauses) $
             \(counter,Requires old values) ->
               helper old values (printf "%s %d of %d" nestedMsg counter len)
  --
  logSkipping :: String -> JMLMonad ()
  logSkipping loc0 = do
    let loc = loc0 ++ ".logSkipping"
    tellNextLog
      $ Log.Skip loc (show er) "no changes"
    return ()
  -- find out the value of JMLVarUnknown using searching in the behavior
  processJMLVarUnknown_behavior :: Behavior -> Behavior
  processJMLVarUnknown_behavior behavior = let
    loc = "JML.Internal.Internal.addBehavior.processJMLVarUnknown_behavior"
    traverseExprs vars = map helper vars
    helper = \case
      expr@(JMLVarUnknown _ _ vn oldExpr) -> case lookUpVar_behavior vn behavior of
        Just val -> val
        Nothing -> oldExpr
      JMLBin expr1 op expr2 -> JMLBin (helper expr1) op (helper expr2)
      JMLNot expr -> JMLNot (helper expr)
      expr1 `JMLEquals` expr2 -> expr1 `JMLEquals` (helper expr2)
      JMLResult expr -> JMLResult (helper expr)
      JMLActions exprs -> JMLActions $ traverseExprs exprs
      expr -> expr
    in case behavior of
    NormalBehavior{} -> NormalBehavior {
      behaviorScopeRange = behaviorScopeRange behavior,
      requires = requires behavior,
      assignable = assignable behavior,
      vars = vars behavior,--traverseExprs (vars behavior),
      hasSideEffect = hasSideEffect behavior,
      ensures = traverseExprs (ensures behavior)
    }
    ExceptionalBehavior{} -> ExceptionalBehavior {
      behaviorScopeRange = behaviorScopeRange behavior,
      requires = requires behavior,
      signals = signals behavior,
      assignable = assignable behavior,
      vars = vars behavior,--traverseExprs (vars behavior),
      hasSideEffect = hasSideEffect behavior,
      ensures = traverseExprs (ensures behavior)
    }
  -- look up var in behavior
  lookUpVar_behavior :: String -> Behavior -> Maybe Expr
  lookUpVar_behavior vn behavior = case [ exprVal
    | JMLVar _ vn2 `JMLEquals` exprVal <- vars behavior
    , vn == vn2
    ] of [expr] -> Just expr
         []     -> Nothing
         vars   -> error $ printf
           "TODO in JML.Internal.addBehavior.lookUpVar_behavior::\n\
           \1) %s\n\
           \2) %s\n\
           \3) %s"
           vn
           (show behavior)
           (show vars)
  processJMLVarUnknown_clause :: Clause -> Clause
  processJMLVarUnknown_clause (Requires tu vals) = let
    loc = "JML.Internal.Internal.addBehavior.processJMLVarUnknown_clause"
    helper originalExpr = \case
      expr1 `JMLEquals` expr2 -> expr1 `JMLEquals` (helper originalExpr expr2)
      JMLVarUnknown _ _ vn innerExpr -> case lookUpVar_clause vn vals of
        Just val
          -- this means that looking up didn't find any expr other than originalExpr
          -- this means the old expr is valid
          | val == originalExpr -> innerExpr
          | otherwise -> val
        Nothing -> error $ printf
          "error in %s  \n\
          \  looking for %s\n\
          \  in %s"
          loc
          vn
          (show vals)
      JMLBin expr1 op expr2 -> JMLBin (helper originalExpr expr1) op (helper originalExpr expr2)
      JMLNot expr -> JMLNot (helper originalExpr expr)
      JMLResult expr -> JMLResult (helper originalExpr expr)
      JMLActions exprs -> JMLActions $ map (helper originalExpr) exprs
      expr -> expr
    helper2 = \case
      Ensures expr -> Ensures $ helper expr expr
      LoopInvariant expr -> LoopInvariant $ helper expr expr
      Signals name expr -> Signals name $ helper expr expr
      val@(Assignable _) -> val
      VarAssignment (t,name,expr) -> VarAssignment (t,name,helper expr expr)
      val@HasSideEffect -> val
    in Requires tu (map helper2 vals)
  --
  processJMLVarUnknown_vars :: [Expr] -> [Expr]
  processJMLVarUnknown_vars vars = let
    loc = "JML.Internal.Internal.addBehavior.processJMLVarUnknown_vars"
    helper exprVal = case exprVal of
      JMLVarUnknown _ _ vn expr ->
        let same_vn = [var | var@(JMLVar _ vn2 `JMLEquals` exprVal2) <- vars
                           , (vn == vn2) && (exprVal /= exprVal2)]
        in case same_vn of
             [] -> expr
             [JMLVar _ _ `JMLEquals` expr2] -> expr2
             _ -> error $ printf "TODO1 in %s" loc
      JMLBin expr1 op expr2 -> JMLBin (helper expr1) op (helper expr2)
      JMLNot expr -> JMLNot (helper expr)
      JMLInt _ -> exprVal
      JMLDouble _ -> exprVal
      JMLNum _ -> exprVal
      JMLBool _ -> exprVal
      JMLString _ -> exprVal
      JMLVar _ _ -> exprVal
      JMLArray mt ms elems -> JMLArray mt ms (map helper elems)
      SymFun ToString expr -> SymFun ToString $ helper expr
      _ -> error $ printf "TODO2 in %s: %s" loc (show exprVal)
    in flip map vars $ \(JMLVar t vn `JMLEquals` exprVal) ->
         JMLVar t vn `JMLEquals` helper exprVal
  -- look up var in clause values
  lookUpVar_clause :: String -> [ClauseValue] -> Maybe Expr
  lookUpVar_clause vn vals = let
    -- helper1
    helper1 = \case
      JMLVarUnknown _ _ _ exprIn -> Just exprIn
      expr -> Just expr
    -- helper2
    helper2 = \case
      [expr] -> helper1 expr
      [] -> Nothing
      exprs -> let
        noUnknown = filter (not . hasJMLVarUnknown vn) exprs
        in helper2 noUnknown
    in helper2 [ exprVal
        | VarAssignment (_,vn2,exprVal) <- vals
        , vn == vn2
        ]
  -- mergeInto ("res",JMLInt 1)
  --           (JMLBin (JMLVarUnknown Int_Type "res" (JMLInt 0)) Mul (JMLInt 3))
  --           ==>
  --           JMLBin (JMLInt 1) Mul (JMLInt 3)
  -- mergeInto is useful when a variable is known in an expr1, but unknown in expr2
  mergeInto :: (String,Expr) -> Expr -> Expr
  mergeInto (name,expr1) expr2 = let
    loc = "JML.Internal.Internal.addBehavior.mergeInto" in
    case expr2 of
      JMLVarUnknown srs t name2 expr
        | name == name2 -> expr1
        | otherwise -> JMLVarUnknown srs t name2 $ (name,expr1) `mergeInto` expr
      JMLInt _ -> expr2
      JMLBin ex1 op ex2 -> let
        new_ex1 = (name,expr1) `mergeInto` ex1
        new_ex2 = (name,expr1) `mergeInto` ex2
        in JMLBin new_ex1 op new_ex2
      _ -> error $ printf
        "TODO in %s ==>\n\
        \  1) name = %s\n\
        \  2) expr1 = %s\n\
        \  3) expr2 = %s" loc
        name (show expr1) (show expr2)
  -- nub, but for clause
  nubClause :: Clause -> Clause
  nubClause (Requires tu vals) = let
    helper [] = []
    helper [val] = [val]
    helper (val1@(VarAssignment (t1,vn1,expr1)) : rest) =
      let same_vn = [val2 | val2@(VarAssignment (_,vn2,_)) <- rest, vn1 == vn2]
          no_vn = flip filter rest $ \case
            VarAssignment (_,vn2,_) -> vn1 /= vn2
            _ -> True
      in case same_vn of
           [] -> val1 : helper rest
           [VarAssignment (_,_,expr2)]
             | isJMLVarUnknown expr1 -> helper rest
             | hasJMLVarUnknown vn1 expr1 && isJMLVarConcrete expr2 ->
                 VarAssignment (t1,vn1,(vn1,expr2) `mergeInto` expr1) : helper no_vn
             | otherwise -> val1 : helper no_vn
           _ -> error $ "TODO1 in JML.Internal.addBehavior.nubClause:: " ++ show (Requires tu vals)
    helper (val1@(Ensures (JMLVar _ vn1 `JMLEquals` expr1)) : rest) =
      let same_vn = [val2 | val2@(Ensures (JMLVar _ vn2 `JMLEquals` _)) <- rest, vn1 == vn2]
          no_vn = flip filter rest $ \case
            Ensures (JMLVar _ vn2 `JMLEquals` _) -> vn1 /= vn2
            _ -> True
      in case same_vn of
           [] -> val1 : helper rest
           [Ensures (JMLVar _ _ `JMLEquals` expr2)]
             | isJMLVarUnknown expr1 -> helper rest
             | otherwise -> val1 : helper no_vn
           _ -> error $ "TODO2 in JML.Internal.addBehavior.nubClause:: " ++ show (Requires tu vals)
    helper (val1 : rest) = val1 : helper rest
    in Requires tu $ nub $ helper vals
  --
  nubVars :: [Expr] -> [Expr]
  nubVars [] = []
  nubVars [var] = [var]
  nubVars vars@(var1@(JMLVar t1 vn1 `JMLEquals` exprVal1) : rest) =
    let same_vn = [var | var@(JMLVar _ vn2 `JMLEquals` _) <- rest, vn1 == vn2]
        no_vn   = [var | var@(JMLVar _ vn2 `JMLEquals` _) <- rest, vn1 /= vn2]
    in case same_vn of
         [] -> var1 : nubVars rest
         [JMLVar _ _ `JMLEquals` exprVal2]
           | isJMLVarUnknown exprVal1 -> nubVars rest
           | hasJMLVarUnknown vn1 exprVal1 && isJMLVarConcrete exprVal2 ->
               (JMLVar t1 vn1 `JMLEquals` ((vn1,exprVal2) `mergeInto` exprVal1)) : nubVars no_vn
           | otherwise -> var1 : nubVars no_vn
         _ -> error $ "TODO in JML.Internal.addBehavior.nubVars:: " ++ show vars

-- look up vars in a specific behavior
-- which has a speicific scope range, and a specific pre-condition (requires)
extractVarsFromState :: CFGT.ScopeRange -> Expr -> JMLMonad [Expr]
extractVarsFromState theScopeRange theRequires = do
  JMLState (Method _ specs) _ _ formals locals _ _ _ <- get
  let behaviors = [b | MethodSpecification b <- specs]
  let vars = flip concatMap behaviors $ \case
        -- which behaviors exist in `theScopeRange`, and has `ifRequire`?
        -- there should be exactly one
        NormalBehavior (Just sr) (Just re) _ vars _ _ ->
          helper (sr,re,formals,locals) vars
        ExceptionalBehavior (Just sr) (Just re) _ _ vars _ _ ->
          helper (sr,re,formals,locals) vars
        _ -> []
  return vars
  where
  helper (sr,re,formals,locals) vars
    | sr == theScopeRange &&
      re == theRequires = flip filter vars $ \var -> case var of
        JMLVar _ vn `JMLEquals` _ -> vn `elem` (formals ++ locals)
        _ -> False
    | otherwise = []

-- throws error and reporting the relevant „ExecutionResult“
createError_er :: String -> String -> ExecutionResult -> a
createError_er prefix loc er = error $ printf
  "%s:\n\
  \1) %s\n\
  \2) ExecutionResult = %s"
  prefix
  {-1)-}(loc ++ " ==> throwTheError")
  {-2)-}(show er)

-- throws error and reporting the relevant entry in „SymbolicExecution“
createError_sy :: String -> String
  -> SYT.SymbolicExecutionKey -> SYT.SymbolicExecutionValue
  -> a
createError_sy prefix loc key value = error $ printf
  "%s:\n\
  \1) %s\n\
  \2) key = %s\n\
  \3) value = %s"
  prefix
  {-1)-}(loc ++ " ==> createError")
  {-2)-}(show key)
  {-3)-}(show value)

tellingThenReturning :: String -> ExecutionResult -> JMLMonad ExecutionResult
tellingThenReturning loc toReturn = do
  tellNextLog $ Log.Return loc (show toReturn)
  return toReturn

tellingReportTheState :: String -> JMLMonad String
tellingReportTheState loc = do
  s <- get
  tellNextLog $ Log.ReportTheState loc
    (show $ method s) (map (\(Requires one two) -> (show one,map show two)) $ jmlStack s) (show $ logHeader s)
    (show $ formalParms s) (show $ localVars s) (show $ globalVars s)
    (ppBehaviors [b | MethodSpecification b <- jmlSpecifications $ method s])

tellingReportTheStack :: String -> String -> [Clause] -> JMLMonad String
tellingReportTheStack loc tag clauses =
  tellNextLog $ Log.ReportTheStack loc tag
  $ map (\(Requires one two) -> (show one,map show two)) clauses

incrementPathEnumeration :: JMLMonad ()
incrementPathEnumeration = modify $ \jmlState -> JMLState {
  method    = method jmlState,
  jmlStack  = jmlStack jmlState,
  logHeader = logHeader jmlState,
  formalParms = formalParms jmlState,
  localVars = localVars jmlState,
  globalVars = globalVars jmlState,
  reAssigned = reAssigned jmlState,
  pathCreationEnumeration = pathCreationEnumeration jmlState + 1
}

getPathEnumeration :: JMLMonad Int
getPathEnumeration = pathCreationEnumeration <$> get

-- if all behaviors other than the default behavior (Requires == Nothing)
-- cover all possible paths,
-- then the default behavior is to be deleted
checkRemovingDefaultBehavior :: JMLMonad ()
checkRemovingDefaultBehavior = do
  let loc = "JML.Internal.Internal.checkRemovingDefaultBehavior"
  tellNextLog $ Log.Location loc ""
  tellingReportTheState (loc ++ " <<before checking>>")
  behaviors <- (\s -> [b | MethodSpecification b <- jmlSpecifications $ method s]) <$> get
  if length behaviors > 1
    then do
      modify $ \jmlState -> JMLState {
        method    = Method {
          name      = name $ method jmlState,
          jmlSpecifications = [spec
            | spec <- jmlSpecifications $ method jmlState
            , case spec of
                MethodSpecification behavior -> isJust $ requires behavior
                LoopSpecification _ -> True
            ]
        },
        jmlStack  = jmlStack jmlState,
        logHeader = logHeader jmlState,
        formalParms = formalParms jmlState,
        localVars = localVars jmlState,
        globalVars = globalVars jmlState,
        reAssigned = reAssigned jmlState,
        pathCreationEnumeration = pathCreationEnumeration jmlState
      }
      tellingReportTheState (loc ++ " <<default behavior deleted>>") $> ()
    else tellNextLog (Log.LogTag loc "default behavior is not deleted" "") $> ()

alterList :: (Maybe a -> [a]) -> (a -> Bool) -> [a] -> [a]
alterList f p li = let
  new_li = concat
    [res | element <- li
         , let--res :: [a]
               res
                 | p element = f $ Just element
                 | otherwise = [element]
    ] in
  case find p new_li of
    Just _ -> new_li
    Nothing -> li ++ f Nothing

------------------------------------
-- Helpers for CounterBoundsTemplate
------------------------------------

isCounterBoundsTemplatePattern :: SYT.LoopPattern -> Bool
isCounterBoundsTemplatePattern loopPattern = SY.Internal.isCounterPattern loopPattern

isCounterBoundsTemplateTag :: SYT.LoopSummaryTag -> Bool
isCounterBoundsTemplateTag loopSummaryTag = let
  loc = "JML.Internal.Internal.isCounterBoundsTemplateTag"
  in SY.Internal.isLoopCountersBoundsTag loopSummaryTag

------------------------------------
-- Helpers for StridedCounterTemplate
------------------------------------

isStridedCounterTemplatePattern :: SYT.LoopPattern -> Bool
isStridedCounterTemplatePattern loopPattern = case loopPattern of
  SYT.CounterPattern SYT.StridedCounting -> True
  _ -> False

isStridedCounterTemplateTag :: SYT.LoopSummaryTag -> Bool
isStridedCounterTemplateTag loopSummaryTag = let
  loc = "JML.Internal.Internal.isStridedCounterTemplateTag"
  in any (\p -> p loopSummaryTag) [
       SY.Internal.isLoopFrameTargetsTag,
       SY.Internal.isLoopInitFactsTag,
       SY.Internal.isLoopFrameTargetsDevelopmentTrajectoryTag]

--------------------------------
-- Helpers for LoopFrameTemplate
--------------------------------

isLoopFrameTemplatePattern :: SYT.LoopPattern -> Bool
isLoopFrameTemplatePattern loopPattern = SY.Internal.isCounterPattern loopPattern

isLoopFrameTemplateTag :: SYT.LoopSummaryTag -> Bool
isLoopFrameTemplateTag loopSummaryTag = let
  loc = "JML.Internal.Internal.isLoopFrameTemplateTag"
  in SY.Internal.isLoopFrameTargetsTag loopSummaryTag

--------------------------------
-- Helpers for DecreasesTemplate
--------------------------------

isDecreasesTemplatePattern :: SYT.LoopPattern -> Bool
isDecreasesTemplatePattern loopPattern = SY.Internal.isCounterPattern loopPattern

isDecreasesTemplateTag :: SYT.LoopSummaryTag -> Bool
isDecreasesTemplateTag loopSummaryTag = let
  loc = "JML.Internal.Internal.isDecreasesTemplateTag"
  in SY.Internal.isLoopDecreasesCandidateTag loopSummaryTag

--
{-
type JMLMonad =
  ExceptT String (ReaderT (Map.Map String SYT.SymbolicExecution)
                          (WriterT [Log.Log] (State JMLState)))
 -}
runMonad :: Map.Map String SYT.SymbolicExecution -> String -> JMLMonad a -> (Either String a,[Log.Log],JMLState)
runMonad sys funName runner = let
  initialJMLState :: JMLState
  initialJMLState = JMLState {
    method = Method {
      name = funName,
      jmlSpecifications = []
    },
    jmlStack = [Requires (Nothing,Nothing) []],
    logHeader = Log.Header 1 [0],
    formalParms = [],
    localVars = [],
    globalVars = [],
    reAssigned = [],
    pathCreationEnumeration = 0
  }
    
--run_e :: ReaderT (Map.Map String SYT.SymbolicExecution) (WriterT [Log.Log] (State JMLState)) (Either String a)
  run_e = runExceptT runner

--run_r :: WriterT [Log.Log] (State JMLState) (Either String a)
  run_r = runReaderT run_e sys

--run_w :: State JMLState ((Either String a),[Log.Log])
  run_w = runWriterT run_r

--run_s :: ((Either String a,[Log.Log]),JMLState)
  run_s@((er,logs),s) = runState run_w initialJMLState

  in (er,logs,s)

{-
type SymbolicExecutionMonad =
    ExceptT String (ReaderT (Config,[CFGT.CFG]) (WriterT [Log.Log] (State SymState)))

runMonad :: SymbolicExecutionMonad a -> (String,Either String a)
runMonad runner = let
  initialSymState = SymState
    { env = Map.empty
    , logHeader = Log.Header
        { Log.logScopeDepth = 1
        , Log.logCounter = []
        }
    }

--run_e :: ReaderT (Config,[CFGT.CFG]) (WriterT [Log.Log] (State SymState)) (Either String a)
  run_e = runExceptT runner

--run_r :: WriterT [Log.Log] (State SymState) (Either String a)
  run_r = runReaderT run_e (defaultConfig,[])

--run_w :: State SymState ((Either String a),[Log.Log])
  run_w = runWriterT run_r

--run_s :: ((Either String a,[Log.Log]),SymState)
  run_s@((er,logs),s) = runState run_w initialSymState

  in (,) (Log.PP.ppLogs Log.PP.Console logs) er
 -}
