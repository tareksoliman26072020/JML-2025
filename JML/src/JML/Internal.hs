{-# Language MultiWayIf, LambdaCase, ScopedTypeVariables #-}
module JML.Internal where

import Prelude hiding (negate)
import Control.Monad (foldM)
import Control.Monad.Writer
import Control.Monad.State (get,modify)
import Control.Monad.Except (throwError)
import Text.Printf (printf)
import Data.List
import Data.Functor (($>))
import Data.Foldable (forM_)
import Data.Traversable (forM)
import qualified Data.Map as Map

import JML.Types
import JML.PrettyPrint (ppBehavior, ppBehaviors, ppColoredClause)
import qualified JML.Logs.Log as Log
import Data.Maybe (isJust,catMaybes)

import qualified CFG.Types as CFGT (ScopeRange)

import qualified SymbolicExecution.Types as SYT (SymbolicExecution, SymbolicExecutionKey, SymStateKey(VarName), SymbolicExecutionValue, SymExpr(..), SymBinOp(..), SymType(..), DefinedFun(..))
import qualified SymbolicExecution.Internal.Internal as SY.Internal (
  getFunName, toSymType2)

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

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

se_2_map :: [SYT.SymbolicExecution] -> Map.Map String SYT.SymbolicExecution
se_2_map = Map.fromList . map (\se -> (SY.Internal.getFunName se,se))

isReassigned :: String -> JMLState -> Bool
isReassigned vn jmlState = vn `elem` reAssigned jmlState

-- converts SymExpr to Expr
symExprToExpr :: JMLState -> SYT.SymbolicExecutionValue -> Expr
symExprToExpr jmlState symExpr =
  let loc = "JML.Internal.symExprToExpr"
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
       SYT.SymUnknown (vn,symExpr) _ -> JMLVarUnknown
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

toDefinedFun :: SYT.DefinedFun -> DefinedFun
toDefinedFun = \case
  SYT.ToString -> ToString
  SYT.Print -> Print
  SYT.Println -> Println
  SYT.UserDefined str -> UserDefined str

toJMLType :: SYT.SymType -> JMLType
toJMLType symType = let
  loc = "JML.Internal.toJMLType" in
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
  loc = "JML.Internal.toJMLType2" in
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
  loc = "JML.Internal.inferJMLType" in
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
    JMLVarUnknown t _ _ -> t
    JMLBool _ -> Bool_Type
    SymFun ToString _ -> String_Type
    _ -> error $ printf "%s: TODO: %s" loc (show expr)

-- Bin (Var "i") Gt (Int 10)
negate :: Expr -> Expr
negate expr = let
  loc = "JML.Internal.negate" in
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
  _ -> error $ printf "JML.Internal.symBinOpToOp: TODO: %s" (show symBinOp)

hasReturn :: [ExecutionResult] -> Bool
hasReturn ers = case flip find ers (\case
  ER_ReturnException _ -> True
  ER_Return _ -> True
  ER_ReturnVoid -> True
  _ -> False) of
  Just _ -> True
  Nothing -> False

addToDefaultClause :: ClauseValue -> JMLMonad ()
addToDefaultClause clauseValue = do
  let loc = "JML.Internal.addToDefaultClause"
  tellNextLog $ Log.Location loc (show clauseValue)
  modify $ \(JMLState jmlMethod stack jmlLogHeader formal local global reAss pathNum) -> JMLState {
    method = jmlMethod,
    jmlStack  = flip map stack $ \case
      Requires (Nothing,Nothing) values ->
        Requires (Nothing,Nothing)
                 (values ++ [clauseValue])
      re -> re,
    logHeader = jmlLogHeader,
    formalParms = formal,
    localVars = local,
    globalVars = global,
    reAssigned = reAss,
    pathCreationEnumeration = pathNum
  }
  tellingReportTheState loc $> ()

emptyNormalBehavior :: Behavior
emptyNormalBehavior = NormalBehavior {
  scopeRange = Nothing,
  requires = Nothing,
  assignable = [],
  vars = [],
  hasSideEffect = False,
  ensures = []
}

addBehavior :: SYT.SymbolicExecution -> ExecutionResult -> JMLMonad ()
addBehavior sy er = do
  let loc = "JML.Internal.addBehavior"
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
      do incrementLogEnumeration
         incrementLogDepth *> addToDefaultClause (Assignable [vn]) <* decrementLogDepth
      do jmlState <- get
         let newVarAssignment = VarAssignment (
               toJMLType $ SY.Internal.toSymType2 symExpr,
               vn,
               symExprToExpr jmlState symExpr)
         incrementLogEnumeration
         incrementLogDepth
         addToDefaultClause newVarAssignment
         decrementLogDepth
      -- determine the left and right operand for the `Ensures` annotation
      do jmlState <- get
         let rightOperand = symExprToExpr jmlState symExpr
             ensuresExpr = JMLVar (inferJMLType rightOperand) vn `JMLEquals` rightOperand
         incrementLogEnumeration
         incrementLogDepth *> addToDefaultClause (Ensures ensuresExpr) <* decrementLogDepth
    --
    ER_VarName vn symExpr mSR -> do
      jmlState <- get
      incrementLogEnumeration
      incrementLogDepth
      addToDefaultClause $ VarAssignment (
        toJMLType $ SY.Internal.toSymType2 symExpr,
        vn,
        symExprToExpr jmlState symExpr)
      decrementLogDepth
    --
    ER_VarName_Unassigned _ _ _ -> logSkipping loc
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
    ER_IfThenElse scopeRange (ifRequires,ifJMLState,if_ers) maybeElse -> do
      tellingReportTheState loc
      ---------- if
      -- add the behaviors of the if body
      ifBehaviors :: [Behavior] <- do
        let newIfBehaviors = flip map (behaviors $ method ifJMLState)
              (flip addClauseToBehavior (Requires (Just scopeRange,Just ifRequires) []))
        forM newIfBehaviors $ \b -> do
          incrementLogEnumeration
          incrementLogDepth *> addBehaviorToState b <* decrementLogDepth
      --
      tellNextLog
        $ Log.IfBehavior loc (show ifBehaviors) (map ppBehavior ifBehaviors)
      tellingReportTheState loc
      ---------- else
      -- add the behaviors of the else body
      maybeElseAfter <- case maybeElse of
        Nothing -> tellNextLog (Log.NoElseBody loc) $> Nothing
        Just (elseRequires,elseJMLState,else_ers) -> do
          elseBehaviors :: [Behavior] <- do
            let newElseBehaviors = flip map (behaviors $ method elseJMLState)
                  (flip addClauseToBehavior (Requires (Just scopeRange,Just elseRequires) []))
            forM newElseBehaviors $ \b -> do
              incrementLogEnumeration
              incrementLogDepth *> addBehaviorToState b <* decrementLogDepth
          --
          tellNextLog
            $ Log.ElseBehavior loc (show elseBehaviors) (map ppBehavior elseBehaviors)
          tellingReportTheState loc
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
         tellingReportTheStack loc "deleting original clauses" originalStack
         modify $ \jmlState -> JMLState {
           method   = method jmlState,
           jmlStack = [cl | cl <- jmlStack jmlState, cl `notElem` originalStack],
           logHeader = logHeader jmlState,
           formalParms = formalParms jmlState,
           localVars = localVars jmlState,
           globalVars = globalVars jmlState,
           reAssigned = reAssigned jmlState,
           pathCreationEnumeration = pathCreationEnumeration jmlState
         }
         -- tell state after deleting original clauses
         tellingReportTheState (loc ++ " <<after delelting original clauses>>")
         if -- both if and else body have return statement
            | ifBodyHasReturn && elseBodyHasReturn -> return ()
            -- both if and else body don't have return statement
            | not (ifBodyHasReturn || elseBodyHasReturn) -> do
                tellNextLog
                  $ Log.LogTag loc "both if and else body don't have return statement" ""
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
      tellingReportTheState loc
      return ()
      ---------- 
    _ -> createError_er "TODO2" loc er
  where
  addBehaviorViaReturn :: ExecutionResult -> JMLMonad ()
  addBehaviorViaReturn er = do
    let loc = "JML.Internal.addBehavior.addBehaviorViaReturn"
    tellNextLog $ Log.Location loc (show er)
    tellingReportTheState loc
    jmlState <- get
    let theJMLResult = case er of
          ER_Return symExpr -> [JMLResult $ symExprToExpr jmlState symExpr]
          ER_ReturnVoid -> [JMLResult JMLVoid]
          ER_ReturnException exceptionName -> []
        noRequireBehavior = case er of
          ER_Return symExpr -> NormalBehavior {
            scopeRange = Nothing,
            requires = Nothing,
            assignable = [],
            vars = [],
            hasSideEffect = False,
            ensures = theJMLResult
          }
          ER_ReturnVoid -> NormalBehavior {
            scopeRange = Nothing,
            requires = Nothing,
            assignable = [],
            vars = [],
            hasSideEffect = False,
            ensures = theJMLResult
          }
          ER_ReturnException exceptionName -> ExceptionalBehavior {
            scopeRange = Nothing,
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
    let loc = "JML.Internal.addBehavior.addBehaviorToState"
    tellNextLog $ Log.AddBehaviorToState loc (show newBehavior)
    modify $ \(JMLState jmlMethod stack jmlLogHeader formal local global reAss pathNum) -> JMLState {
      method = Method {
        name = name jmlMethod,
        behaviors = behaviors jmlMethod ++ [newBehavior]
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
    loc = "JML.Internal.addBehavior.addClauseToBehavior"
    gettingAssignable = concat [li | Assignable li <- values]
    gettingVars = [JMLVar t vn `JMLEquals` expr | VarAssignment (t,vn,expr) <- values]
    gettingSideEffect = HasSideEffect `elem` values
    gettingEnsures = [expr | Ensures expr <- values]
    newPreCondition = combinePreconditions thePreCondition (requires behavior)
    processing = processJMLVarUnknown_behavior $ case behavior of
      NormalBehavior{} -> NormalBehavior {
        scopeRange = theScopeRange,
        requires = newPreCondition,
        assignable = nub $ assignable behavior ++ gettingAssignable,
        vars = {-(if newPreCondition == Nothing
                  then id
                else nubVars . processJMLVarUnknown_vars) $-} vars behavior ++ gettingVars,
        hasSideEffect = hasSideEffect behavior || gettingSideEffect,
        ensures = ensures behavior ++ gettingEnsures
      }
      ExceptionalBehavior{} -> ExceptionalBehavior {
        scopeRange = theScopeRange,
        requires = newPreCondition,
        signals = signals behavior,
        assignable = nub $ assignable behavior ++ gettingAssignable,
        vars = {-(if newPreCondition == Nothing
                  then id
                else nubVars . processJMLVarUnknown_vars) $-} vars behavior ++ gettingVars,
        hasSideEffect = hasSideEffect behavior || gettingSideEffect,
        ensures = ensures behavior ++ gettingEnsures
      } in
    processing
  --
  combinePreconditions :: Maybe Expr -> Maybe Expr -> Maybe Expr
  combinePreconditions mPre1 mPre2 = case (mPre1,mPre2) of
    (Nothing,Nothing) -> Nothing
    (Nothing,Just pre2) -> Just pre2
    (Just pre1,Nothing) -> Just pre1
    (Just pre1,Just pre2) -> Just $ JMLBin pre1 And pre2
  --
  -- if a defaut clause exists, it gets replaced
  -- otherwise, a new clause is created
  -- this was first used in ER_IfThenElse
  createClause :: [Clause] -> Clause -> JMLMonad ()
  createClause originalClauses cl@(Requires (mSR,mPreCondition) newValues) = do
    let loc = "JML.Internal.addBehavior.createClause"
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
    let new_unprocessed_Clause = Requires (mSR,mPreCondition)
          $ defaultClauseVals ++ newValues
    tellNextLog
      $ Log.LogTag loc "new clause <unprocessed>"
      $ ppColoredClause new_unprocessed_Clause
    let new_processed_Clause = nubClause $ processJMLVarUnknown_clause new_unprocessed_Clause
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
  --
  inheritClausesFromInnerState :: [Clause] -> [Clause] -> (CFGT.ScopeRange,Maybe Expr) -> String -> JMLMonad ()
  inheritClausesFromInnerState originalStack innerStateClauses (new_scopeRange,new_mPreCondition) nestedMsg = do
    let loc = "JML.Internal.addBehavior.inheritClausesFromInnerState"
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
           {-_ -> throwError $ printf
                 "MEOW:\n\
                 \  originalStack: %s\n\
                 \  innerStateClauses: %s"
                 (show originalStack) (show innerStateClauses)-}
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
    loc = "JML.Internal.addBehavior.processJMLVarUnknown_behavior"
    traverseExprs vars = map helper vars
    helper = \case
      expr@(JMLVarUnknown _ vn oldExpr) -> case lookUpVar_behavior vn behavior of
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
      scopeRange = scopeRange behavior,
      requires = requires behavior,
      assignable = assignable behavior,
      vars = vars behavior,--traverseExprs (vars behavior),
      hasSideEffect = hasSideEffect behavior,
      ensures = traverseExprs (ensures behavior)
    }
    ExceptionalBehavior{} -> ExceptionalBehavior {
      scopeRange = scopeRange behavior,
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
    loc = "JML.Internal.addBehavior.processJMLVarUnknown_clause"
    helper originalExpr = \case
      expr1 `JMLEquals` expr2 -> expr1 `JMLEquals` (helper originalExpr expr2)
      JMLVarUnknown _ vn innerExpr -> case lookUpVar_clause vn vals of
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
    loc = "JML.Internal.addBehavior.processJMLVarUnknown_vars"
    helper exprVal = case exprVal of
      JMLVarUnknown _ vn expr ->
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
      JMLVarUnknown _ _ exprIn -> Just exprIn
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
  --
  isJMLVarUnknown :: Expr -> Bool
  isJMLVarUnknown = \case
    JMLVarUnknown _ _ _ -> True
    _ -> False
  -- does an expression has JMLVarUnknown for `vn`?
  hasJMLVarUnknown :: String -> Expr -> Bool
  hasJMLVarUnknown vn expr = let
    loc = "JML.Internal.addBehavior.hasJMLVarUnknown" in
    case expr of
      JMLBin expr1 op expr2 -> hasJMLVarUnknown vn expr1 || hasJMLVarUnknown vn expr2
      JMLVarUnknown _ vn2 _ -> vn == vn2
      JMLInt _ -> False
      JMLString _ -> False
      JMLVar _ _ -> False
      JMLBool _ -> False
      SymFun ToString expr -> hasJMLVarUnknown vn expr
      _ -> error $ printf "TODO in %s ==> %s" loc (show expr)
  -- is JMLVar concrete?
  isJMLVarConcrete :: Expr -> Bool
  isJMLVarConcrete expr = let
    loc = "JML.Internal.addBehavior.isJMLVarConcrete" in
    case expr of
      JMLInt _ -> True
      JMLDouble _ -> True
      JMLNum _ -> True
      JMLBool _ -> True
      JMLString _ -> True
      JMLNull _ -> True
      _ -> error $ printf "TODO in %s ==> %s" loc (show expr)
  -- mergeInto ("res",JMLInt 1)
  --           (JMLBin (JMLVarUnknown Int_Type "res" (JMLInt 0)) Mul (JMLInt 3))
  --           ==>
  --           JMLBin (JMLInt 1) Mul (JMLInt 3)
  -- mergeInto is useful when a variable is known in an expr1, but unknown in expr2
  mergeInto :: (String,Expr) -> Expr -> Expr
  mergeInto (name,expr1) expr2 = let
    loc = "JML.Internal.addBehavior.mergeInto" in
    case expr2 of
      JMLVarUnknown t name2 expr
        | name == name2 -> expr1
        | otherwise -> JMLVarUnknown t name2 $ (name,expr1) `mergeInto` expr
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
  JMLState (Method _ behaviors) _ _ formals locals _ _ _ <- get
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
    (ppBehaviors $ behaviors $ method s)

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
  let loc = "JML.Internal.checkRemovingDefaultBehavior"
  tellNextLog $ Log.Location loc ""
  tellingReportTheState (loc ++ " <<before checking>>")
  b <- (behaviors . method) <$> get
  if length b > 1
    then do
      modify $ \jmlState -> JMLState {
        method    = Method {
          name      = name $ method jmlState,
          behaviors = [behavior | behavior <- behaviors $ method jmlState
                                , isJust $ requires behavior]
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
