{-# Language LambdaCase #-}
module SymbolicExecution.MethodCall where

import Visitors.API (SymStateVisitor(..))
import qualified CFG.Types as CFGT (CFG)
import SymbolicExecution.Types
import qualified SymbolicExecution.Log as Log
import Control.Monad.Writer
import Control.Monad.Reader
import Control.Monad.State
import qualified Data.Map as Map
import Control.Monad.Except
import Data.Functor (($>))

type MethodCall_Map_R =
    ReaderT (Config,[(FormalParm, ActualParm_post_Execution)])
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))))
    (Map.Map String ExecutionResult)
    
instance SymStateVisitor MethodCall_SymExec where
--visitSymExpr :: (String,SymExpr) -> MethodCall_SymExec
  visitSymExpr (key,val) = MethodCall_SymExec $ do
    tell [Log.HorizontalLine "visitSymExpr"] >> case val of
      SymFormalParam symType formalParam Nothing -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SymFormalParam"]
        (_,tupels) <- ask
        let newSymExpr :: SymExpr
            newSymExpr = case lookup formalParam tupels of
              Just er@ER_SymStateMapEntry{} -> formal_to_actual_2 (symStateVal er) formalParam
              Just (ER_Expr symExpr) -> formal_to_actual_2 symExpr formalParam
              Just er -> error $ "insertActualParams: " ++ show er
              Nothing -> error "won't happen"
        tell [Log.ModifyState "visitSymExpr -> SymFormalParam" (formalParam,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
        let toReturn = ER_Formal_2_Actual formalParam newSymExpr
        tell [Log.Return "visitSymExpr -> SymFormalParam" (show toReturn)] $> toReturn
      SymFormalParam symType formalParam _ ->
        throwError "visitSymExpr -> SymFormalParam -> TODO"
      ex ->
        throwError "visitSymExpr -> TODO"

formal_to_actual_2 :: SymExpr -> String -> SymExpr
formal_to_actual_2 actualParam formalParam = case actualParam of
  SBin symExpr1 symBinOp symExpr2 ->
    SBin (formal_to_actual_2 symExpr1 formalParam) symBinOp (formal_to_actual_2 symExpr2 formalParam)
  SymFormalParam symType _ Nothing -> actualParam
    --SymActualParam symType formalParam actualParam
  SymFormalParam symType _ _ -> error "formal_to_actual_2 ==> TODO"
  e@(SymInt _) -> e

--                         formalParms, actualParms
runSymState :: SymState -> String -> [(FormalParm, ActualParm_post_Execution)] -> ([Log.Log],SymState)
runSymState symState methodCall tus =
  let -- mapM :: Monad m => (a -> m b) -> Map k a -> m (Map k b)
      runner :: Map.Map String MethodCall_R--[MethodCall_Map_R]
      runner = flip Map.mapWithKey (env symState) $ \key symExpr -> do
        tell [Log.NextMethodCallSymExpr methodCall (show symExpr)]
        getReader_MethodCall_R $ visitSymExpr (key,symExpr)
      initialSymState :: SymState
      initialSymState = SymState Map.empty (pc symState)
      run_r :: ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))) ()
      run_r = runReaderT (sequence_ runner) (defaultConfig,tus)
      run_e :: WriterT [Log.Log] (StateT SymState (Either String)) (Either String ())
      run_e = runExceptT run_r
      run_w :: StateT SymState (Either String) (Either String (),[Log.Log])
      run_w = runWriterT run_e
      mRun_s :: Either String ((Either String (),[Log.Log]),SymState)
      mRun_s = runStateT run_w initialSymState
  in case mRun_s of
       Left str -> error str
       Right ((ei,logs),symState2) ->
         (logs,either error (const symState2) ei)
