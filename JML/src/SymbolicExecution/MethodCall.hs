{-# Language LambdaCase #-}
module SymbolicExecution.MethodCall where

import Visitors.API (SymStateVisitor(..))
import SymbolicExecution.Types
import qualified SymbolicExecution.Log as Log
import Control.Monad.Writer
import Control.Monad.Reader
import Control.Monad.State
import qualified Data.Map as Map
import Control.Monad.Except
import qualified CFG.Types as CFGT (CFG)

type MethodCall_Map_R =
    ReaderT (Config,[CFGT.CFG])
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))))
    (Map.Map String ExecutionResult)
    
instance SymStateVisitor MethodCall_SymExec where
--visitSymExpr :: SymExpr -> MethodCall_R
  visitSymExpr = undefined

runSymState :: SymState -> String -> ([Log.Log],SymState)
runSymState symState methodCall =
  let -- mapM :: Monad m => (a -> m b) -> Map k a -> m (Map k b)
      runner :: MethodCall_Map_R
      runner = flip mapM (env symState) $ \symExpr -> do
        tell [Log.NextMethodCallSymExpr methodCall (show symExpr)]
        getReader_MethodCall_R $ visitSymExpr symExpr
  in undefined
  
  
  
  
  
  
  
  
  
  
  
  
{-
      run_r :: ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))) ()
      run_r = runReaderT (runner $> ()) (defaultConfig,cfgs)
      run_e :: WriterT [Log.Log] (StateT SymState (Either String)) (Either String ())
      run_e = runExceptT run_r
      run_w :: StateT SymState (Either String) (Either String (),[Log.Log])
      run_w = runWriterT run_e
      mRun_s :: Either String ((Either String (),[Log.Log]),SymState)
      mRun_s = runStateT run_w initialSymState
  in case mRun_s of
       Left str -> error str
       Right ((ei,logs),SymState m ps) ->
         let returnValue = m Map.! "return"
             m2 = flip (Map.insert "return") m $
                    case (CFG.getCFGType cfg, returnValue) of
                      (AST.Int, SymNum float)    ->
                        SymInt (round float)
                      (AST.Double, SymNum float) ->
                        SymDouble (realToFrac float)
                      (AST.Float, SymNum float)  ->
                        SymFloat float
                      (_, expr)                  ->
                        expr
         in (logs,either error (const (SymState m2 ps)) ei)
-}
