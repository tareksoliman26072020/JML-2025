{-# Language MultiWayIf #-}
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

import qualified SymbolicExecution.Types as SYT (SymbolicExecution, SymbolicExecutionValue, SymExpr(..))
import qualified SymbolicExecution.Internal.Internal as SY.Internal (getFunName)

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
          logHeader = Log.Header depth newCounter
        }
        --tellingIt (depth,oldCounterStr) (depth,logNum newCounter)
        f newCounter
    | depth <= length counter -> do
        let newCounter = take (depth-1) counter ++ [(counter !! (depth-1)) + 1]
        modify $ \jmlState -> JMLState {
          method = method jmlState,
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
    logHeader = Log.Header (depth+1) counter
  }
  --tell [Log.Log "?" $ Log.IncrementLogDepth depth (depth+1)]

decrementLogDepth :: JMLMonad ()
decrementLogDepth = do
  Log.Header depth counter <- logHeader <$> get
  modify $ \jmlState -> JMLState {
    method = method jmlState,
    logHeader = Log.Header (depth-1) counter
  }
  --tell [Log.Log "?" $ Log.DecrementLogDepth depth (depth-1)]

se_2_map :: [SYT.SymbolicExecution] -> Map.Map String SYT.SymbolicExecution
se_2_map = Map.fromList . map (\se -> (SY.Internal.getFunName se,se))

addClause :: ExecutionResult -> JMLMonad ()
addClause er = do
  let loc = "JML.Internal.addClause"
  tellNextLog $ Log.Location loc (show er)
  let maybeNewClause = case er of
        ER_ReturnException (clause@ExceptionalBehavior{}) -> Just clause
        ER_Return (clause@NormalBehavior{}) -> Just clause
        ER_VarBindings _ -> Nothing
        ER_VarName_Skipped _ _ -> Nothing
        ER_VarAssignments _ -> Nothing
        ER_NoGlobalVars -> Nothing
        ER_FormalParms _ -> Nothing
        _ -> createError_er "TODO" loc er
  case maybeNewClause of
    Nothing -> do
      tellNextLog
        $ Log.Skip loc (show er) "no clause will be added"
      return ()
    Just newClause -> do
      tellNextLog $ Log.AddClauseToState loc (show er)
      modify $ \(JMLState jmlMethod jmlLogHeader) -> JMLState {
        method = Method {
          name = name jmlMethod,
          clauses = clauses jmlMethod ++ [newClause]
        },
        logHeader = jmlLogHeader
      }

createError_er :: String -> String -> ExecutionResult -> a
createError_er prefix loc er = error $ printf
  "%s:\n\
  \1) %s\n\
  \2) ExecutionResult = %s"
  prefix
  {-1)-}(loc ++ " ==> throwTheError")
  {-2)-}(show er)

extractEnsures :: SYT.SymbolicExecution -> SYT.SymbolicExecutionValue -> Maybe Expr
extractEnsures sy symExpr = case symExpr of
  SYT.SymInt num -> Just $ Int (fromIntegral num)
  SYT.SymDouble num -> Just $ Double num
  _ -> error $ "TODO: JML.Internal.extractEnsures: " ++ show symExpr
