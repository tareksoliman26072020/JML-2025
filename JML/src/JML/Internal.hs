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

import qualified SymbolicExecution.Types as SY (SymbolicExecution)
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

se_2_map :: [SY.SymbolicExecution] -> Map.Map String SY.SymbolicExecution
se_2_map = Map.fromList . map (\se -> (SY.Internal.getFunName se,se))
