{-# Language LambdaCase #-}
module SymbolicExecution.MethodCall where

import Visitors.API (SymStateVisitor(..))
import qualified CFG.Types as CFGT (CFG)
import SymbolicExecution.Types
import SymbolicExecution.Internal.Internal
import SymbolicExecution.Internal.Calculator (calculate)
import qualified SymbolicExecution.Log as Log
import Control.Monad.Writer
import Control.Monad.Reader
import Control.Monad.State
import qualified Data.Map as Map
import Control.Monad.Except
import Data.Functor (($>))
import Text.Printf (printf)
import Data.List (find)

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
        visited <- visitSymExpr0 val
        let newSymExpr = case visited of
              ER_Expr symExpr -> symExpr
              _ -> error $ printf "visitSymExpr ~~> SymFormalParam ~~> %s ~~> won't happen" (show visited)
        tell [Log.ModifyState "visitSymExpr -> SymFormalParam" (key,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
        let toReturn = ER_Expr_WithKey key newSymExpr
        tell [Log.Return "visitSymExpr -> SymFormalParam" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      SymFormalParam _ _ (Just symExpr) -> do
        tell [Log.SymExpr_2_Handle (show val) (printf "visitSymExpr -> SymFormalParam %s" (show symExpr))]
        visited <- visitSymExpr0 val
        let newSymExpr = case visited of
              ER_Expr symExpr2 -> symExpr2
              _ -> error $ printf "visitSymExpr ~~> SymFormalParam %s ~~> %s ~~> won't happen" (show symExpr) (show visited)
        tell [Log.ModifyState (printf "visitSymExpr -> SymFormalParam %s" (show symExpr)) (key,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
      --throwError $ "visitSymExpr ~~> SymFormalParam " ++ show symExpr ++ " ~~> TODO"
        let toReturn = ER_Expr_WithKey key newSymExpr
        tell [Log.Return (printf "visitSymExpr -> SymFormalParam %s" (show symExpr)) (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      SBin _ _ _ -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SBin"]
        --throwError $ "visitSymExpr ~~> SBin ~~> TODO: " ++ show val
        visited <- visitSymExpr0 val
        let newSymExpr = case visited of
              ER_Expr res -> res
              _ -> error $ printf "visitSymExpr ~~> SBin ~~> %s ~~> won't happen" (show visited)
        tell [Log.ModifyState "visitSymExpr -> SBin" (key,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
        let toReturn = ER_Expr_WithKey key newSymExpr
        tell [Log.Return "visitSymExpr -> SBin" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      SymInt _ -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SymInt"]
        visited <- visitSymExpr0 val
        let newSymExpr = case visited of
              ER_Expr res -> res
              _ -> error $ printf "visitSymExpr ~~> SymInt ~~> %s ~~> won't happen" (show visited)
        tell [Log.ModifyState "visitSymExpr -> SymInt" (key,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
        let toReturn = ER_Expr_WithKey key newSymExpr
        tell [Log.Return "visitSymExpr -> SymInt" (show toReturn)] $> toReturn
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
        newSymExpr = case lookup_formalParam_info formalParam tupels of
          Just (t,er@ER_SymStateMapEntry{}) -> substitute formalParam (cast t (er_val er))
          Just (t,(ER_Expr symExpr)) -> substitute formalParam (cast t symExpr)
          Just er -> error $ "insertActualParams: " ++ show er
          Nothing -> error "won't happen"
        toReturn = ER_Expr newSymExpr
    tell [Log.Return "visitSymExpr0 -> SymFormalParam" (show toReturn)] $> toReturn
    where
    lookup_formalParam_info :: String -> [(FormalParm, ActualParm_post_Visitation)] -> Maybe (SymType,ActualParm_post_Visitation)
    lookup_formalParam_info fParm list =
      let finding = find (\((_,b),_) -> b == fParm) list
      in fmap (\((t,_),actual) -> (t,actual)) finding
  
  ------------------------------
  ------------------------------
  ------------------------------
  val@(SymFormalParam symType formalParam (Just symExpr)) -> do
    tell [Log.SymExpr_2_Handle (show val) (printf "visitSymExpr0 -> SymFormalParam %s" (show symExpr))]
    visited <- visitSymExpr0 symExpr
    case visited of
      -- ER_Expr (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2))
      ER_Expr newSymExpr -> do
        let toReturn = ER_Expr $ SymFormalParam symType formalParam (Just newSymExpr)
        tell [Log.Return (printf "visitSymExpr0 -> SymFormalParam %s" (show symExpr)) (show toReturn)] $> toReturn
      -- SymFormalParam Int "i" (Just (SBin (SymFormalParam Int "i" Nothing) Add (SymInt 2)))
      _ -> throwError $ printf "visitSymExpr0 ~~> SymFormalParam %s ~~> TODO: %s" (show symExpr) (show visited)
  ------------------------------
  ------------------------------
  ------------------------------
  val@(SBin symExpr1 symBinOp symExpr2) -> do
    tell [Log.SymExpr_2_Handle (show val) "visitSymExpr0 -> SBin"]
    toReturn <- (\e1 e2 -> ER_Expr
                    $ calculate symBinOp (getSymExpr e1,getSymExpr e2))
      <$> (visitSymExpr0 symExpr1)
      <*> (visitSymExpr0 symExpr2)
    tell [Log.Return "visitSymExpr -> SBin" (show toReturn)] $> toReturn
  --throwError $ "visitSymExpr -> SBin -> " ++ show val
  --throwError $ "visitSymExpr0 -> SBin ~~> TODO: " ++ show val
    
  val@(SymInt _) -> do
    tell [Log.SymExpr_2_Handle (show val) "visitSymExpr0 -> SymInt"]
    let toReturn = ER_Expr val
    tell [Log.Return "visitSymExpr0 -> SymInt" (show toReturn)] $> toReturn
  ex ->
    throwError $ "visitSymExpr0 -> TODO: " ++ show ex

------------------------------
------------------------------
------------------------------

--                                     formalParms, actualParms
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
