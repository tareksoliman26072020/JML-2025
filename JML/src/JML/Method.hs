{-# Language LambdaCase #-}
module JML.Method where

import Visitors.API
import JML.Types
import JML.Internal
import qualified JML.Logs.Log as Log
import qualified SymbolicExecution.Types as SYT (SymbolicExecution)
import qualified SymbolicExecution.Internal.Internal as SY (getFunName)
import qualified Data.Map as Map

import Text.Printf

import Control.Monad.Writer
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Reader

globalLoc :: String
globalLoc = "JML.Method"

instance SymbolicExecutionVisitor MethodProcessor where
--visitSymExpr :: (SYM.SymStateKey,SY.SymExpr) -> MethodProcessor
  visitSymExpr tu@(key,value) = MethodProcessor $ case tu of
    _ ->
      let loc = globalLoc ++ ".visitSymExpr"
      in throwError $ printf
        "TODO:\n\
        \1) %s\n\
        \2) key = %s\n\
        \3) value = %s"
        loc (show key) (show value)

-----------------------------
-----------------------------
-----------------------------

runSE :: Map.Map String SYT.SymbolicExecution -> SYT.SymbolicExecution -> (String,[Log.Log],JMLState)
runSE sys sy =
  let loc = globalLoc ++ ".runSE"
      runner :: JMLMonad ()
      runner = do
        visited <- flip Map.traverseWithKey sy $ \k v -> do
          tellNextLog $ Log.NextSymExpr loc (show k) (show v)
          methodProcessorMonad $ visitSymExpr (k,v)
        return ()

      initialJMLState :: JMLState
      initialJMLState = JMLState {
        method = Method {
          name = SY.getFunName sy,
          clauses = []
        },
        logHeader = Log.Header 1 [0]
      }

      run_e :: ReaderT (Map.Map String SYT.SymbolicExecution) (WriterT [Log.Log] (State JMLState)) (Either String ())
      run_e = runExceptT runner

      run_r :: WriterT [Log.Log] (State JMLState) (Either String ())
      run_r = runReaderT run_e sys

      run_w :: State JMLState ((Either String ()),[Log.Log])
      run_w = runWriterT run_r

      run_s :: ((Either String (),[Log.Log]),JMLState)
      run_s@((er,logs),s) = runState run_w initialJMLState

  in (either id (const "") er,logs,s)
