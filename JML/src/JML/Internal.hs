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
import qualified JML.Logs.Log as Log

import qualified SymbolicExecution.Types as SYT (SymbolicExecution, SymbolicExecutionValue, SymExpr(..), SymBinOp(..))
import qualified SymbolicExecution.Internal.Internal as SY.Internal (getFunName, isReassigned)

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
       SYT.SymDouble num -> Double num
       SYT.SymInt num -> Int (fromIntegral num)
     --SYT.SymVar _ vn -> Var vn
       SYT.SymVar _ vn
         | SY.Internal.isReassigned vn sy -> Old $ Var vn
         | otherwise -> Var vn
       SYT.SymNum num -> Num num
       SYT.SBin symExpr1 op symExpr2 ->
         Bin (symExprToExpr sy symExpr1) (symBinOpToOp op) (symExprToExpr sy symExpr2)
       SYT.SymString str -> String str
       _ -> error $ printf "%s: TODO: %s" loc (show symExpr)

symBinOpToOp :: SYT.SymBinOp -> Op
symBinOpToOp symBinOp = case symBinOp of
  SYT.Add -> Add
  _ -> error $ printf "JML.Internal.symBinOpToOp: TODO: %s" (show symBinOp)

addBehavior :: SYT.SymbolicExecution -> ExecutionResult -> JMLMonad ()
addBehavior sy er = do
  let loc = "JML.Internal.addBehavior"
  tellNextLog $ Log.Location loc (show er)
  case er of
    ER_ReturnException (behavior@ExceptionalBehavior{}) -> addBehaviorToState loc behavior
    ER_Return (behavior@NormalBehavior{}) -> addBehaviorToState loc behavior
    ER_VarName_Global_Reassigned vn symExpr -> do
      addClauseToStack loc (Assignable [vn])
      -- determine the left and right operand for the `Ensures` annotation
      let rightOperand = symExprToExpr sy symExpr
          {-rightOperand = case symExprToExpr sy symExpr of
            expr@(Var _) -> expr
            expr@(Num _) -> expr
            expr -> error $ printf
              "%s: TODO:\n\
              \1) ER_VarName_Global_Reassigned %s %s\n\
              \2) %s" loc
              vn (show symExpr)
              (show expr)-}
          ensuresExpr = Var vn `Equals` rightOperand
      addClauseToStack loc (Ensures ensuresExpr)
    ER_VarBindings _ -> logSkipping loc
    ER_VarName_Skipped _ _ -> logSkipping loc
    ER_VarAssignments _ -> logSkipping loc
    ER_NoGlobalVars -> logSkipping loc
    ER_FormalParms _ -> logSkipping loc
    _ -> createError_er "TODO2" loc er
  where
  -- adding the behavior
  addBehaviorToState :: String -> Behavior -> JMLMonad ()
  addBehaviorToState loc0 newBehavior = do
    let loc = loc0 ++ ".addBehaviorToState"
    tellNextLog $ Log.AddBehaviorToState loc (show er)
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
        _ -> error $ printf "TODO: %s ==> %s" (loc ++ ".addClauseToStack") (show clause),
      logHeader = jmlLogHeader
    }
    get >>= \s -> tellNextLog $ Log.ReportTheState loc
      (show $ method s) (show $ jmlStack s) (show $ logHeader s)
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
      Assignable li -> case behavior of
        NormalBehavior{} -> NormalBehavior {
          requires = requires behavior,
          assignable = assignable behavior ++ map Var li,
          ensures = ensures behavior
        }
        _ -> error $ printf
          "%s: TODO1:\n\
          \1) %s\n\
          \2) %s" loc (show clause) (show behavior)
      Ensures expr -> case behavior of
        NormalBehavior{} -> NormalBehavior {
          requires = requires behavior,
          assignable = assignable behavior,
          ensures = ensures behavior ++ [expr]
        }
        _ -> error $ printf
          "%s: TODO2:\n\
          \1) %s\n\
          \2) %s" loc (show clause) (show behavior)
      _ -> error $ printf "%s: TODO3: %s" loc (show clause)
  -- looking up Assignable in jmlStack
  getStackAssignable :: [Clause] -> Maybe Clause
  getStackAssignable = find $ \case
    Assignable li -> True
    _ -> False
  -- adding Assignable to jmlStack
  addAssignableToStack :: [Clause] -> [String] -> [Clause]
  addAssignableToStack clauses li = case getStackAssignable clauses of
    Nothing -> clauses ++ [Assignable li]
    Just _ -> flip map clauses $ \case
      Assignable li0 -> Assignable $ li0 ++ li
      clause -> clause
  -- adding Ensures to jmlStack
  addEnsuresToStack :: [Clause] -> Expr -> [Clause]
  addEnsuresToStack clauses expr = clauses ++ [Ensures expr]

createError_er :: String -> String -> ExecutionResult -> a
createError_er prefix loc er = error $ printf
  "%s:\n\
  \1) %s\n\
  \2) ExecutionResult = %s"
  prefix
  {-1)-}(loc ++ " ==> throwTheError")
  {-2)-}(show er)

extractEnsures :: SYT.SymbolicExecution -> SYT.SymbolicExecutionValue -> [Expr]
extractEnsures sy symExpr = [Result $ symExprToExpr sy symExpr]

