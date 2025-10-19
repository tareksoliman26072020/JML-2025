{-# Language LambdaCase #-}
module SymbolicExecution.MethodCall where

import Visitors.API (SymStateVisitor(..))
import qualified CFG.Types as CFGT (CFG)
import SymbolicExecution.Types
import qualified SymbolicExecution.Log as Log
import SymbolicExecution.Method
import Control.Monad.Writer
import Control.Monad.Reader
import Control.Monad.State
import qualified Data.Map as Map
import Control.Monad.Except

type MethodCall_Map_R =
    ReaderT (Config,[(FormalParm, ActualParm_post_Execution)])
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))))
    (Map.Map String ExecutionResult)
    
instance SymStateVisitor MethodCall_SymExec where
--visitSymExpr :: SymExpr -> MethodCall_R
  visitSymExpr = \case
    SymFormalParam symType formalParam Nothing -> MethodCall_SymExec $ do
      (_,tupels) <- ask
      let newSymExpr :: SymExpr
          newSymExpr = case lookup formalParam tupels of
            Just er@ER_SymStateMapEntry{} -> formal_to_actual_2 (symStateVal er) formalParam
            Just (ER_Expr symExpr) -> formal_to_actual_2 symExpr formalParam
            Just er -> error $ "insertActualParams: " ++ show er
            Nothing -> error "won't happen"
      modify $ \symState ->
        SymState {
          env = undefined,--Map.insert k a (env symState),
          pc  = pc symState
        }
      return $ ER_Formal_2_Actual formalParam newSymExpr
    SymFormalParam symType formalParam _ -> MethodCall_SymExec
      $ throwError "visitSymExpr -> SymFormalParam -> TODO"
    ex -> MethodCall_SymExec
      $ throwError "visitSymExpr -> TODO"

formal_to_actual_2 :: SymExpr -> String -> SymExpr
formal_to_actual_2 actualParam formalParam = case actualParam of
  SBin symExpr1 symBinOp symExpr2 ->
    SBin (formal_to_actual_2 symExpr1 formalParam) symBinOp (formal_to_actual_2 symExpr2 formalParam)
  SymFormalParam symType _ Nothing -> actualParam
    --SymActualParam symType formalParam actualParam
  SymFormalParam symType _ _ -> error "formal_to_actual_2 ==> TODO"
  e@(SymInt _) -> e

--                         formalParms, actualParms
runSymState :: SymState -> String -> ([Log.Log],SymState)
runSymState symState methodCall =
  let -- mapM :: Monad m => (a -> m b) -> Map k a -> m (Map k b)
      runner :: MethodCall_Map_R
      runner = flip mapM (env symState) $ \symExpr -> do
        tell [Log.NextMethodCallSymExpr methodCall (show symExpr)]
        getReader_MethodCall_R $ visitSymExpr symExpr
      initialSymState :: SymState
      initialSymState = SymState Map.empty (pc symState)
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
