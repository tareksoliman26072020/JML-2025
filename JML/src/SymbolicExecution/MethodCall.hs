{-# Language LambdaCase #-}
module SymbolicExecution.MethodCall where

import Visitors.API (SymStateVisitor(..))
import qualified CFG.Types as CFGT (CFG)
import SymbolicExecution.Types
import SymbolicExecution.Internal.Internal
import SymbolicExecution.Internal.Calculator (numericCalculator, booleanCalculator)
import qualified SymbolicExecution.Log as Log
import Control.Monad.Writer
import Control.Monad.Reader
import Control.Monad.State
import qualified Data.Map as Map
import Control.Monad.Except
import Data.Functor (($>), void)
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
        tell [Log.ModifyState "visitSymExpr -> SymFormalParam" (show key,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
        let toReturn = ER_SymStateMapEntry key newSymExpr
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
        tell [Log.ModifyState (printf "visitSymExpr -> SymFormalParam %s" (show symExpr)) (show key,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
      --throwError $ "visitSymExpr ~~> SymFormalParam " ++ show symExpr ++ " ~~> TODO"
        let toReturn = ER_SymStateMapEntry key newSymExpr
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
        tell [Log.ModifyState "visitSymExpr -> SBin" (show key,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
        let toReturn = ER_SymStateMapEntry key newSymExpr
        tell [Log.Return "visitSymExpr -> SBin" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      SymInt _ -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SymInt"]
        tell [Log.ModifyState "visitSymExpr -> SymInt" (show key,show val)]
        modify $ \symState ->
          SymState {
            env = Map.insert key val (env symState),
            pc  = pc symState
          }
        let toReturn = ER_SymStateMapEntry key val
        tell [Log.Return "visitSymExpr -> SymInt" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      SMethodType _ -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SMethodType"]
        tell [Log.ModifyState "visitSymExpr -> SMethodType" (show key,show val)]
        modify $ \symState ->
          SymState {
            env = Map.insert key val (env symState),
            pc  = pc symState
          }
        let toReturn = ER_SymStateMapEntry key val
        tell [Log.Return "visitSymExpr -> SMethodType" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      val@(SIte boolSymExpr ifSymState maybeElseSymState) -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SIte"]
        condVisited <- visitSymExpr0 boolSymExpr
        (_,methodCall,tus) <- ask
        case condVisited of
          ----------
          ER_Expr a@(SBin _ _ _) -> do
            let (ifLogs,newIfSymState) = runSymState ifSymState methodCall tus True
                maybeElse = flip fmap maybeElseSymState $ \e -> runSymState e methodCall tus True
            -- logs
            mapM_ (\log -> tell [log]) ifLogs
            flip mapM_ maybeElse $
              \(elseLogs,_) -> mapM_ (\log -> tell [log]) elseLogs
            --modify state
            let newSymExpr = SIte a newIfSymState $ fmap snd maybeElse
            tell [Log.ModifyState "visitSymExpr -> SIte -> unresolved condition" (show key,show newSymExpr)]
            modify $ \symState ->
              SymState {
                env = Map.insert key newSymExpr (env symState),
                pc  = pc symState
              }
            let toReturn = ER_SymStateMapEntry key newSymExpr
            tell [Log.Return "visitSymExpr -> SIte -> unresolved condition" (show toReturn)] $> toReturn
          ----------
          ER_Expr a@(SBool True) -> do
            let (ifLogs,newIfSymState) = runSymState ifSymState methodCall tus True
            mapM_ (\log -> tell [log]) ifLogs
            tell [Log.ModifyState "visitSymExpr -> SIte -> resolved condition is True -> else body exists" ("<no key>","<whole state is updated>: " ++ show newIfSymState)]
            modify (const newIfSymState)
            return $ ER_Expr a
          ----------
          ER_Expr a@(SBool False) -> do
            -- pattern matching for logs and recording state
            case maybeElseSymState of
              Just elseSymState -> do
                let (elseLogs,newElseSymState) = runSymState elseSymState methodCall tus True
                mapM_ (\log -> tell [log]) elseLogs
                tell [Log.ModifyState "visitSymExpr -> SIte -> resolved condition is False" ("<no key>","<whole state is updated>: " ++ show newElseSymState)]
                modify (const newElseSymState)
              Nothing -> do
                tell [Log.StateNotModified "visitSymExpr -> SIte -> resolved condition is False -> no else body"]
            -- return expr
            return $ ER_Expr a
  ------------------------------
  ------------------------------
  ------------------------------
      SymNull _ -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SymNull"]
        tell [Log.ModifyState "visitSymExpr -> SymNull" (show key,show val)]
        modify $ \symState ->
          SymState {
            env = Map.insert key val (env symState),
            pc  = pc symState
          }
        let toReturn = ER_SymStateMapEntry key val
        tell [Log.Return "visitSymExpr -> SymNull" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      SymGlobalVar t varName mExpr -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SymGlobalVar"]
        ER_Expr newSymExpr <- case mExpr of
          Nothing -> return ER_Void
          Just expr -> do
            visited <- visitSymExpr0 expr
            case visited of
              a@(ER_Expr symExpr) -> return a
              _ -> error $ printf "visitSymExpr ~~> SymGlobalVar ~~> %s ~~> %s ~~> won't happen" (show val) (show visited)
        tell [Log.ModifyState "visitSymExpr -> SymGlobalVar" (show key,show newSymExpr)]
        modify $ \symState ->
          SymState {
            env = Map.insert key newSymExpr (env symState),
            pc  = pc symState
          }
        let toReturn = ER_SymStateMapEntry key newSymExpr
        tell [Log.Return (printf "visitSymExpr -> SymGlobalVar -> %s" (show newSymExpr)) (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      SVarBindings _ -> return ER_Void
  ------------------------------
  ------------------------------
  ------------------------------
      SymString _ -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SymString"]
        tell [Log.ModifyState "visitSymExpr -> SymString" (show key,show val)]
        modify $ \symState ->
          SymState {
            env = Map.insert key val (env symState),
            pc  = pc symState
          }
        let toReturn = ER_SymStateMapEntry key val
        tell [Log.Return "visitSymExpr -> SymString" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      SActions _ -> do
        tell [Log.SymExpr_2_Handle (show val) "visitSymExpr -> SActions"]
        tell [Log.ModifyState "visitSymExpr -> SActions" (show key,show val)]
        modify $ \symState ->
          SymState {
            env = Map.insert key val (env symState),
            pc  = pc symState
          }
        let toReturn = ER_SymStateMapEntry key val
        tell [Log.Return "visitSymExpr -> SActions" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
      ex ->
        throwError $ "visitSymExpr -> TODO: " ++ show ex

------------------------------
------------------------------
------------------------------

visitSymExpr0 :: SymExpr -> MethodCall_R
visitSymExpr0 = \case
  val@(SymFormalParam symType formalParam Nothing) -> do
    tell [Log.SymExpr_2_Handle (show val) "visitSymExpr0 -> SymFormalParam"]
    (_,_,tupels) <- ask
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
    toReturn <- (\e1 e2 ->
      let isNumericOp = symBinOp `elem` [Add, Mul, Sub, Div]
          whichFun = case isNumericOp of
            True -> numericCalculator
            False -> booleanCalculator
      in 
      ER_Expr $ whichFun (SBin (simplify $ getSymExpr e1) symBinOp (simplify $ getSymExpr e2)))
      <$> (visitSymExpr0 symExpr1)
      <*> (visitSymExpr0 symExpr2)
    tell [Log.Return "visitSymExpr -> SBin" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
  val@(SymInt _) -> do
    tell [Log.SymExpr_2_Handle (show val) "visitSymExpr0 -> SymInt"]
    let toReturn = ER_Expr val
    tell [Log.Return "visitSymExpr0 -> SymInt" (show toReturn)] $> toReturn
  val@(SMethodType _) -> do
    tell [Log.SymExpr_2_Handle (show val) "visitSymExpr0 -> SMethodType"]
    let toReturn = ER_Expr val
    tell [Log.Return "visitSymExpr0 -> SMethodType" (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
  ex ->
    throwError $ "visitSymExpr0 -> TODO: " ++ show ex
------------------------------
------------------------------
------------------------------

--                                     formalParms, actualParms
runSymState :: SymState -> String -> [(FormalParm, ActualParm_post_Visitation)] -> Bool -> ([Log.Log],SymState)
runSymState symState methodCall tus isInNestedScope =
  let -- mapM :: Monad m => (a -> m b) -> Map k a -> m (Map k b)
      runner :: Map.Map SymStateKey MethodCall_R
      runner = flip Map.mapWithKey (env symState) $ \key symExpr -> do
        tell [Log.NextMethodCallSymExpr methodCall (show key,show symExpr)]
        st <- get
        case getReturnSymExpr st of
          Just _
            | not isInNestedScope -> tell [Log.Skip $ printf "(%s,%s)" (show key) (show symExpr)]
                $> ER_Void
          _ -> getReader_MethodCall_R $ visitSymExpr (key,symExpr)
      initialSymState :: SymState
      initialSymState = SymState Map.empty (pc symState)
      run_r :: ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))) ()
      run_r = runReaderT (sequence_ runner) (defaultConfig,methodCall,tus)
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
