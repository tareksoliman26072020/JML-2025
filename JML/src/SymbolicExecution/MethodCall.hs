{-# Language LambdaCase #-}
module SymbolicExecution.MethodCall where

import Visitors.API (SymStateVisitor(..))
import qualified CFG.Types as CFGT (CFG)
import SymbolicExecution.Types
import SymbolicExecution.Internal
import qualified SymbolicExecution.Log as Log
import Control.Monad.Writer
import Control.Monad.Reader
import Control.Monad.State
import qualified Data.Map as Map
import Control.Monad.Except
import Data.Functor (($>))
import Text.Printf (printf)

type MethodCall_Map_R =
    ReaderT (Config,[(FormalParm, ActualParm_post_Visitation)])
    (ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))))
    (Map.Map String ExecutionResult)
    
instance SymStateVisitor MethodCall_SymExec where
--visitSymExpr :: (String,SymExpr) -> MethodCall_SymExec
  ------------------------------
  ------------------------------
  ------------------------------
  visitSymExpr (key,val) = MethodCall_SymExec $ do
    tell [Log.HorizontalLine "visitSymExpr"] >> case val of
      SymFormalParam _ _ Nothing -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SymFormalParam"]
        toReturn@(ER_Formal_2_Actual formalParam newSymExpr) <- visitSymExpr0 val
        tell [Log.ModifyState "visitSymExpr -> SymFormalParam" (formalParam,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
        tell [Log.Return "visitSymExpr -> SymFormalParam" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      SymFormalParam _ _ (Just symExpr) -> do
        tell [Log.SymExpr_2_Handle (show val) (printf "visitSymExpr -> SymFormalParam %s" (show symExpr))]
        toReturn <- visitSymExpr0 val
        throwError $ "visitSymExpr ~~> SymFormalParam " ++ show symExpr ++ " ~~> TODO"
  ------------------------------
  ------------------------------
  ------------------------------
      SBin _ _ _ -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SBin"]
        throwError $ "visitSymExpr -> SBin ~~> TODO: " ++ show val
      --tell [Log.Return "visitSymExpr -> SBin" (show toReturn)] $> toReturn
      --throwError $ "visitSymExpr -> SBin -> " ++ show val
      ex ->
        throwError $ "visitSymExpr -> TODO: " ++ show ex

------------------------------
------------------------------
------------------------------

visitSymExpr0 :: SymExpr -> MethodCall_R
visitSymExpr0 = \case
  val@(SymFormalParam symType formalParam Nothing) -> do
    tell [Log.SymExpr_2_Handle (show val) "visitSymExpr0 -> SymFormalParam"]
    (_,tupels) <- ask
    let newSymExpr :: SymExpr
        newSymExpr = case lookup formalParam tupels of
          Just er@ER_SymStateMapEntry{} -> substitute formalParam (er_val er)
          Just (ER_Expr symExpr) -> substitute formalParam symExpr
          Just er -> error $ "insertActualParams: " ++ show er
          Nothing -> error "won't happen"
        toReturn = ER_Formal_2_Actual formalParam newSymExpr
    tell [Log.Return "visitSymExpr0 -> SymFormalParam" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
  val@(SymFormalParam symType formalParam (Just symExpr)) -> do
    tell [Log.SymExpr_2_Handle (show val) (printf "visitSymExpr0 -> SymFormalParam %s" (show symExpr))]
    toReturn <- visitSymExpr0 symExpr
    case toReturn of
      ER_Formal_2_Actual formalParam newSymExpr ->
        throwError $ "visitSymExpr0 ~~> SymFormalParam _ _ Just ~~> TODO1: " ++ show val
      _ -> throwError $ "visitSymExpr0 ~~> TODO2: " ++ show val
  ------------------------------
  ------------------------------
  ------------------------------
  val@(SBin symExpr1 symBinOp symExpr2) -> do
    tell [Log.SymExpr_2_Handle (show val) "visitSymExpr0 -> SBin"]
    toReturn <- (\e1 e2 -> ER_Expr $ SBin (getSymExpr e1) symBinOp (getSymExpr e2))
      <$> (visitSymExpr0 symExpr1)
      <*> (visitSymExpr0 symExpr2)
  --tell [Log.Return "visitSymExpr -> SBin" (show toReturn)] $> toReturn
  --throwError $ "visitSymExpr -> SBin -> " ++ show val
    throwError $ "visitSymExpr0 -> SBin ~~> TODO: " ++ show val
  ex ->
    throwError $ "visitSymExpr0 -> TODO: " ++ show ex

------------------------------
------------------------------
------------------------------

--                         formalParms, actualParms
runSymState :: SymState -> String -> [(FormalParm, ActualParm_post_Visitation)] -> ([Log.Log],SymState)
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
