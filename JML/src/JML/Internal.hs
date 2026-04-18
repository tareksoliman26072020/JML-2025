{-# Language MultiWayIf, LambdaCase #-}
module JML.Internal where

import Control.Monad.Writer
import Control.Monad.State (get,modify)
import Control.Monad.Except (throwError)
import Text.Printf (printf)
import Data.List
import Data.Functor (($>))
import qualified Data.Map as Map

import JML.Types
import JML.PrettyPrint (ppBehavior, ppBehaviors)
import qualified JML.Logs.Log as Log

import qualified SymbolicExecution.Types as SYT (SymbolicExecution, SymbolicExecutionKey, SymbolicExecutionValue, SymExpr(..), SymBinOp(..), SymType(..))
import qualified SymbolicExecution.Internal.Internal as SY.Internal (getFunName, isReassigned)

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
          logHeader = Log.Header depth newCounter
        }
        --tellingIt (depth,oldCounterStr) (depth,logNum newCounter)
        f newCounter
    | depth <= length counter -> do
        let newCounter = take (depth-1) counter ++ [(counter !! (depth-1)) + 1]
        modify $ \jmlState -> JMLState {
          method = method jmlState,
          jmlStack = jmlStack jmlState,
          logHeader = Log.Header depth newCounter
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
    logHeader = Log.Header (depth+1) counter
  }
  --tell [Log.Log "?" $ Log.IncrementLogDepth depth (depth+1)]

decrementLogDepth :: JMLMonad ()
decrementLogDepth = do
  Log.Header depth counter <- logHeader <$> get
  modify $ \jmlState -> JMLState {
    method = method jmlState,
    jmlStack = jmlStack jmlState,
    logHeader = Log.Header (depth-1) counter
  }
  --tell [Log.Log "?" $ Log.DecrementLogDepth depth (depth-1)]

se_2_map :: [SYT.SymbolicExecution] -> Map.Map String SYT.SymbolicExecution
se_2_map = Map.fromList . map (\se -> (SY.Internal.getFunName se,se))

-- converts SymExpr to Expr
symExprToExpr :: SYT.SymbolicExecution -> SYT.SymbolicExecutionValue -> Expr
symExprToExpr sy symExpr =
  let loc = "JML.Internal.symExprToExpr"
  in case symExpr of
       SYT.SymDouble num -> JMLDouble num
       SYT.SymInt num -> JMLInt (fromIntegral num)
       SYT.SymVar t vn
         | SY.Internal.isReassigned vn sy -> JMLOld $ JMLVar (toJMLType t) vn
         | otherwise -> JMLVar (toJMLType t) vn
       SYT.SymNum num -> JMLNum num
       SYT.SBin symExpr1 op symExpr2 ->
         JMLBin (symExprToExpr sy symExpr1) (symBinOpToOp op) (symExprToExpr sy symExpr2)
       SYT.SymString str -> JMLString str
       SYT.SActions symExprs -> JMLActions $ map (symExprToExpr sy) symExprs
       _ -> error $ printf "%s: TODO: %s" loc (show symExpr)

toJMLType :: SYT.SymType -> JMLType
toJMLType symType = let
  loc = "JML.Internal.toJMLType" in
  case symType of
    SYT.Int -> Int_Type
    _ -> error $ printf "%s: TODO: %s" loc (show symType)

inferJMLType :: Expr -> JMLType
inferJMLType expr = let
  loc = "JML.Internal.inferJMLType" in
  case expr of
    JMLInt _ -> Int_Type
    JMLDouble _ -> Double_Type
    JMLNum _ -> Num_Type
    JMLString _ -> String_Type
    JMLBin expr1 op expr2
      | op `elem` [Gt,Ge,Lt,Le,Eq,Neq] -> Bool_Type
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
    _ `JMLAnd` _ -> Bool_Type
    JMLResult expr -> inferJMLType expr
    _ -> error $ printf "%s: TODO: %s" loc (show expr)

-- Bin (Var "i") Gt (Int 10)
negate :: Expr -> Expr
negate expr = let
  loc = "JML.Internal.negate" in
  case expr of
     JMLBin expr1 op expr2
       | op `elem` [Gt,Ge,Lt,Le,Eq,Neq] -> let
           newOp = case op of
             Gt  -> Le
             Ge  -> Lt
             Lt  -> Ge
             Le  -> Gt
             Eq  -> Neq
             Neq -> Eq
           in JMLBin expr1 newOp expr2
     _ -> error $ printf "%s: TODO: %s" loc (show expr)

symBinOpToOp :: SYT.SymBinOp -> Op
symBinOpToOp symBinOp = case symBinOp of
  SYT.Add -> Add
  SYT.Mul -> Mul
  SYT.Sub -> Sub
  SYT.Gt  -> Gt
  _ -> error $ printf "JML.Internal.symBinOpToOp: TODO: %s" (show symBinOp)

emptyNormalBehavior :: Behavior
emptyNormalBehavior = NormalBehavior {
  requires = Nothing,
  assignable = [],
  ensures = []
}

addBehavior :: SYT.SymbolicExecution -> ExecutionResult -> JMLMonad ()
addBehavior sy er = do
  let loc = "JML.Internal.addBehavior"
  tellNextLog $ Log.Location loc (show er)
  case er of
    ER_ReturnException (behavior@ExceptionalBehavior{}) -> addBehaviorToState loc behavior
    ER_ReturnVoid -> addBehaviorToState loc emptyNormalBehavior
    ER_Actions _ -> logSkipping loc
    ER_Return (behavior@NormalBehavior{}) -> addBehaviorToState loc behavior
    --
    ER_VarName_Global_Reassigned vn symExpr -> do
      addClauseToStack loc (Assignable [vn])
      -- determine the left and right operand for the `Ensures` annotation
      let rightOperand = symExprToExpr sy symExpr
          ensuresExpr = JMLVar (inferJMLType rightOperand) vn `JMLEquals` rightOperand
      addClauseToStack loc (Ensures ensuresExpr)
    ER_VarBindings _ -> logSkipping loc
    ER_VarName_Skipped _ _ -> logSkipping loc
    ER_VarAssignments _ -> logSkipping loc
    ER_NoGlobalVars -> logSkipping loc
    ER_FormalParms _ -> logSkipping loc
    --
    ER_IfThenElse (ifRequires,ifMethod) (elseRequires,elseMethod) -> do
      originalStack <- jmlStack <$> get
      ---------- if
      newIfMethod <- do
        -- add if cond to the main jmlstack
        do incrementLogEnumeration
           incrementLogDepth
           flip censor (addClauseToStack loc (Requires ifRequires)) (map $ \(Log.Log str logTag) ->
             Log.Log str $ Log.Nested "if requires" logTag)
           decrementLogDepth
        -- add main jmlStack to all the behaviors in ifMethod
        newIfMethod <- do
          mainStack <- jmlStack <$> get
          return $ Method {
            name      = name ifMethod,
            behaviors = map (addJMLStackToBehavior mainStack) (behaviors ifMethod)
          }
        tellNextLog $ Log.IfBranchBehaviors loc
                    $ map (\behavior -> (show behavior,ppBehavior behavior))
                    $ behaviors newIfMethod
        -- remove the added if cond from the main jmlStack
        modify $ \jmlState -> JMLState {
          method    = method jmlState,
          jmlStack  = originalStack,
          logHeader = logHeader jmlState
        }
        return newIfMethod
      ---------- else
      newElseMethod <- do
        -- add else cond to the main jmlstack
        do incrementLogEnumeration
           incrementLogDepth
           flip censor (addClauseToStack loc (Requires elseRequires)) (map $ \(Log.Log str logTag) ->
             Log.Log str $ Log.Nested "else requires" logTag)
           decrementLogDepth
        -- add main jmlStack to all the behaviors in elseMethod
        newElseMethod <- do
          mainStack <- jmlStack <$> get
          return $ Method {
            name      = name elseMethod,
            behaviors = map (addJMLStackToBehavior mainStack) (behaviors elseMethod)
          }
        tellNextLog $ Log.ElseBranchBehaviors loc
                    $ map (\behavior -> (show behavior,ppBehavior behavior))
                    $ behaviors newElseMethod
        -- remove the added else cond from the main jmlStack
        modify $ \jmlState -> JMLState {
          method    = method jmlState,
          jmlStack  = originalStack,
          logHeader = logHeader jmlState
        }
        return newElseMethod
      ---------- add all behaviors in newIfMethod and newElseMethod to main behaviors
      do mapM_ (addBehaviorToState loc) (behaviors newIfMethod)
         mapM_ (addBehaviorToState loc) (behaviors newElseMethod)
      {-get >>= \s -> throwError $ printf
        "MEOW: %s\n\
        \  1) main method: %s\n\
        \  2) main stack: %s\n\
        \  3) if method: %s\n\
        \  4) new if method: %s\n\
        \  5) else method: %s\n\
        \  6) new else method: %s" loc
        (show $ method s) (show $ jmlStack s)
        (show ifMethod) (show newIfMethod)
        (show elseMethod) (show newElseMethod)-}
    _ -> createError_er "TODO" loc er
  where
  -- adding the behavior
  addBehaviorToState :: String -> Behavior -> JMLMonad ()
  addBehaviorToState loc0 newBehavior = do
    let loc = loc0 ++ ".addBehaviorToState"
    tellNextLog $ Log.AddBehaviorToState loc (show newBehavior)
    modify $ \(JMLState jmlMethod stack jmlLogHeader) -> JMLState {
      method = Method {
        name = name jmlMethod,
        behaviors = behaviors jmlMethod ++ [addJMLStackToBehavior stack newBehavior]
      },
      jmlStack = stack,
      logHeader = jmlLogHeader
    }
    get >>= \s -> tellNextLog $ Log.ReportTheState loc
      (show $ method s) (show $ jmlStack s) (show $ logHeader s)
      (ppBehaviors $ behaviors $ method s)
    return ()
  -- adding clause to stack
  addClauseToStack :: String -> Clause -> JMLMonad ()
  addClauseToStack loc0 clause = do
    let loc = loc0 ++ ".addClauseToStack"
    tellNextLog $ Log.AddClauseToState loc (show clause)
    modify $ \(JMLState jmlMethod stack jmlLogHeader) -> JMLState {
      method = jmlMethod,
      jmlStack = case clause of
        Assignable li -> addAssignableToStack stack li
        Ensures expr -> addEnsuresToStack stack expr
        Requires expr -> addRequiresToStack stack expr
        _ -> error $ printf "TODO: %s ==> %s" (loc ++ ".addClauseToStack") (show clause),
      logHeader = jmlLogHeader
    }
    get >>= \s -> tellNextLog $ Log.ReportTheState loc
      (show $ method s) (show $ jmlStack s) (show $ logHeader s)
      (ppBehaviors $ behaviors $ method s)
    return ()
  --
  logSkipping :: String -> JMLMonad ()
  logSkipping loc0 = do
    let loc = loc0 ++ ".logSkipping"
    tellNextLog
      $ Log.Skip loc (show er) "no changes"
    return ()
  -- adding jmlstack to behavior
  addJMLStackToBehavior :: [Clause] -> Behavior -> Behavior
  addJMLStackToBehavior clauses behavior =
    foldl' addJMLClauseToBehavior behavior clauses
  -- adding jml clause to behavior (helper for `addJMLStackToBehavior`)
  addJMLClauseToBehavior :: Behavior -> Clause -> Behavior
  addJMLClauseToBehavior behavior clause = 
    let loc = "JML.Internal.addBehavior.addJMLClauseToBehavior"
    in case clause of
      ---------- Requires
      Requires expr -> case behavior of
        NormalBehavior{} -> NormalBehavior {
          requires = case requires behavior of
            Just expr0 -> Just $ expr0 `JMLAnd` expr
            Nothing    -> Just expr,
          assignable = assignable behavior,
          ensures = ensures behavior
        }
        ExceptionalBehavior{} -> ExceptionalBehavior {
          requires = case requires behavior of
            Just expr0 -> Just $ expr0 `JMLAnd` expr
            Nothing    -> Just expr,
          signals = signals behavior,
          assignable = assignable behavior,
          ensures = ensures behavior
        }
      ---------- Assignable
      Assignable li -> case behavior of
        NormalBehavior{} -> NormalBehavior {
          requires = requires behavior,
          assignable = assignable behavior ++ li,
          ensures = ensures behavior
        }
        ExceptionalBehavior{} -> ExceptionalBehavior {
          requires = requires behavior,
          signals = signals behavior,
          assignable = assignable behavior ++ li,
          ensures = ensures behavior
        }
      ---------- Ensures
      Ensures expr -> case behavior of
        NormalBehavior{} -> NormalBehavior {
          requires = requires behavior,
          assignable = assignable behavior,
          ensures = ensures behavior ++ [expr]
        }
        ExceptionalBehavior{} -> ExceptionalBehavior {
          requires = requires behavior,
          signals = signals behavior,
          assignable = assignable behavior,
          ensures = ensures behavior ++ [expr]
        }
      ----------
      _ -> error $ printf "%s: TODO3: %s" loc (show clause)
  -- looking up Assignable in jmlStack
  getStackAssignable :: [Clause] -> Maybe Clause
  getStackAssignable = find $ \case
    Assignable _ -> True
    _ -> False
  getStackRequires :: [Clause] -> Maybe Clause
  getStackRequires = find $ \case
    Requires _ -> True
    _ -> False
  -- adding Assignable to jmlStack
  addAssignableToStack :: [Clause] -> [String] -> [Clause]
  addAssignableToStack clauses li = case getStackAssignable clauses of
    Nothing -> clauses ++ [Assignable li]
    Just _ -> flip map clauses $ \case
      Assignable li0 -> Assignable $ li0 ++ li
      clause -> clause
  -- adding Required to jmlStack
  addRequiresToStack :: [Clause] -> Expr -> [Clause]
  addRequiresToStack clauses expr = case getStackRequires clauses of
    Nothing -> clauses ++ [Requires expr]
    Just _ -> flip map clauses $ \case
      Requires expr0 -> Requires $ expr0 `JMLAnd` expr
      clause -> clause
  -- adding Ensures to jmlStack
  addEnsuresToStack :: [Clause] -> Expr -> [Clause]
  addEnsuresToStack clauses expr = clauses ++ [Ensures expr]

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

extractEnsures :: SYT.SymbolicExecution -> SYT.SymbolicExecutionValue -> [Expr]
extractEnsures sy symExpr = [JMLResult $ symExprToExpr sy symExpr]

