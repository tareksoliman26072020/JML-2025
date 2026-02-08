{-# Language LambdaCase #-}
module SymbolicExecution.VarsInjection where

import Visitors.API (SymStateVisitor(..))
import SymbolicExecution.Types
import qualified Data.Map.Lazy as Map
import qualified SymbolicExecution.Logs.Log as Log
import Control.Monad.State
import Control.Monad.Writer
import Control.Monad.Except
import Control.Monad.Reader
import SymbolicExecution.Internal.Calculator (whichCalculator)
import Text.Printf (printf)
import Data.Functor (($>), void)

instance SymStateVisitor VarsInjection_SymExec where
{-
`visitSymExpr` returns ER_SymStateMapEntry
but also it returns E_Void when if (False) + there is no else body
 -}
--visitSymExpr :: (String,SymExpr) -> VarsInjection_SymExec
  visitSymExpr (key,val) = VarsInjection_SymExec $ 
    tell [Log.HorizontalLine "visitSymExpr"] >> case val of
    {-
    (VarName vn,_) -> do
      tell [Log.SymExpr_2_Handle (printf "%s ~~> %s") (show key) (show val) "visitSymExpr -> VarName"]
      ER_Expr newSymExpr <- inject vn val
      modifySymState "visitSymExpr -> VarName" key newSymExpr
      let toReturn = ER_SymStateMapEntry key newSymExpr
      tell [Log.Return "visitSymExpr -> VarName" (show toReturn)] $> toReturn
     -}
    ------------------------------
    ------------------------------
    ------------------------------
    SymVar _ vn -> do
      let loc = "SymbolicExecution.VarsInjection.visitSymExpr -> SymVar"
      tell [Log.SymExpr_2_Handle (show key) loc]
      ER_Expr newSymExpr <- visitSymExpr0 val
      modifySymState loc key newSymExpr
      let toReturn = ER_SymStateMapEntry key newSymExpr
      tell [Log.Return loc (show toReturn)] $> toReturn
    ------------------------------
    ------------------------------
    ------------------------------
    SBin expr1 op expr2 -> do
      let loc = "SymbolicExecution.VarsInjection.visitSymExpr -> SBin"
      tell [Log.SymExpr_2_Handle (show key) loc]
      ER_Expr newSymExpr <- visitSymExpr0 val
      modifySymState loc key newSymExpr
      let toReturn = ER_SymStateMapEntry key newSymExpr
      tell [Log.Return loc (show toReturn)] $> toReturn
    ------------------------------
    ------------------------------
    ------------------------------
    SMethodType _ -> do
      let loc = "SymbolicExecution.VarsInjection.visitSymExpr -> SMethodType"
      tell [Log.SymExpr_2_Handle ((printf "%s ~~> %s") (show key) (show val)) loc]
      modifySymState loc key val
      let toReturn = ER_SymStateMapEntry key val
      tell [Log.Return loc (show toReturn)] $> toReturn
    ------------------------------
    ------------------------------
    ------------------------------
    SGlobalVars _ -> do
      let loc = "SymbolicExecution.VarsInjection.visitSymExpr -> SGlobalVars"
      tell [Log.SymExpr_2_Handle ((printf "%s ~~> %s") (show key) (show val)) loc]
      modifySymState loc key val
      let toReturn = ER_SymStateMapEntry key val
      tell [Log.Return loc (show toReturn)] $> toReturn
    ------------------------------
    ------------------------------
    ------------------------------
    SFormalParms _ -> do
      let loc = "SymbolicExecution.VarsInjection.visitSymExpr -> SFormalParms"
      tell [Log.SymExpr_2_Handle ((printf "%s ~~> %s") (show key) (show val)) loc]
      modifySymState loc key val
      let toReturn = ER_SymStateMapEntry key val
      tell [Log.Return loc (show toReturn)] $> toReturn
    ------------------------------
    ------------------------------
    ------------------------------
    SVarAssignments _ -> do
      let loc = "SymbolicExecution.VarsInjection.visitSymExpr -> SVarAssignments"
      tell [Log.SymExpr_2_Handle ((printf "%s ~~> %s") (show key) (show val)) loc]
      modifySymState loc key val
      let toReturn = ER_SymStateMapEntry key val
      tell [Log.Return loc (show toReturn)] $> toReturn
    ------------------------------
    ------------------------------
    ------------------------------
    SymInt _ -> do
      let loc = "SymbolicExecution.VarsInjection.visitSymExpr -> SymInt"
      tell [Log.SymExpr_2_Handle ((printf "%s ~~> %s") (show key) (show val)) loc]
      modifySymState loc key val
      let toReturn = ER_SymStateMapEntry key val
      tell [Log.Return loc (show toReturn)] $> toReturn
    ------------------------------
    ------------------------------
    ------------------------------
    SymString _ -> do
      let loc = "SymbolicExecution.VarsInjection.visitSymExpr -> SymString"
      tell [Log.SymExpr_2_Handle ((printf "%s ~~> %s") (show key) (show val)) loc]
      modifySymState loc key val
      let toReturn = ER_SymStateMapEntry key val
      tell [Log.Return loc (show toReturn)] $> toReturn
    ------------------------------
    ------------------------------
    ------------------------------
    SIte ifCond ifSymState maybeElseSymState -> do
      let loc = "SymbolicExecution.VarsInjection.visitSymExpr -> SIte"
      tell [Log.SymExpr_2_Handle ((printf "%s ~~> %s") (show key) (show val)) loc]
      (_,methodCall,toInject) <- ask
      ER_Expr newIfCond <- visitSymExpr0 ifCond
      case newIfCond of
        -- take if
        SBool True -> do
          -- visit
          let (ifLogs,newIfSymState) = runSymState ifSymState methodCall toInject
          -- log
          flip mapM_ ifLogs $ \log -> tell [log]
          modify (const newIfSymState)
          let toReturn = ER_SymStateMapEntry key val
          tell [Log.Return loc (show toReturn)] $> toReturn
        -- take else
        SBool False -> case maybeElseSymState of
          Just elseSymState -> do
            -- visit
            let (elseLogs,newElseSymState) = runSymState elseSymState methodCall toInject
            -- log
            flip mapM_ elseLogs $ \log -> tell [log]
            modify (const newElseSymState)
            let toReturn = ER_SymStateMapEntry key val
            tell [Log.Return loc (show toReturn)] $> toReturn
          Nothing -> do
            tell [Log.StateNotModified $ loc ++ " -> resolved condition is False -> no else body"]
            return ER_Void
        _ -> do
          let (ifLogs,newIfSymState)     = runSymState ifSymState methodCall toInject
              mTu = flip fmap maybeElseSymState $ \s -> runSymState s methodCall toInject
          -- log
          flip mapM_ ifLogs $ \log -> tell [log]
          flip mapM_ mTu $
              \(elseLogs,_) -> mapM_ (\log -> tell [log]) elseLogs
          modifySymState loc key (SIte newIfCond newIfSymState $ fmap snd mTu)
          let toReturn = ER_SymStateMapEntry key val
          tell [Log.Return loc (show toReturn)] $> toReturn
    ------------------------------
    ------------------------------
    ------------------------------
    _ -> throwError $ printf "TODO: SymbolicExecution.VarsInjection.visitSymExpr ->\nkey: %s\nvalue: %s" (show key) (show val)

-- visitSymExpr0 returns always `ER_expr <SymExpr>`
visitSymExpr0 :: SymExpr -> VarsInjection_R
visitSymExpr0 = \case
  symExpr@(SymVar _ vn) -> do
    let loc = "SymbolicExecution.VarsInjection.visitSymExpr0 -> SymVar"
    tell [Log.SymExpr_2_Handle (show symExpr) loc]
    ER_Expr newSymExpr <- inject vn symExpr
    let toReturn = ER_Expr newSymExpr
    tell [Log.Return loc (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
  symExpr@(SBin expr1 op expr2) -> do
    let loc = "SymbolicExecution.VarsInjection.visitSymExpr0 -> SBin"
    tell [Log.SymExpr_2_Handle (show symExpr) loc]
    ER_Expr newExpr1 <- visitSymExpr0 expr1
    ER_Expr newExpr2 <- visitSymExpr0 expr2
    let calculator = whichCalculator newExpr1 op newExpr2
        newSymExpr = calculator $ SBin newExpr1 op newExpr2
    let toReturn = ER_Expr newSymExpr
    tell [Log.Return loc (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
  symExpr@(SymNum _) -> do
    let loc = "SymbolicExecution.VarsInjection.visitSymExpr0 -> SymNum"
    tell [Log.SymExpr_2_Handle (show symExpr) loc]
    let toReturn = ER_Expr symExpr
    tell [Log.Return loc (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
  symExpr@(SymInt _) -> do
    let loc = "SymbolicExecution.VarsInjection.visitSymExpr0 -> SymInt"
    tell [Log.SymExpr_2_Handle (show symExpr) loc]
    let toReturn = ER_Expr symExpr
    tell [Log.Return loc (show toReturn)] $> toReturn
  ------------------------------
  ------------------------------
  ------------------------------
  symExpr -> throwError $ "TODO: SymbolicExecution.VarsInjection.visitSymExpr0 ==> " ++ show symExpr

inject :: String -> SymExpr -> VarsInjection_R
inject key val = do
  tell [Log.Location $ "SymbolicExecution.VarsInjection.inject " ++ key]
  (_,_,toInject) <- ask
  case Map.lookup (VarName key) toInject of
    Nothing -> return $ ER_Expr val
    Just newVal -> do
      tell [Log.UpdateVariable
              (key,show val,show newVal)
              "SymbolicExecution.VarsInjection.inject"]
      return $ ER_Expr newVal

modifySymState :: String -> SymStateKey -> SymExpr -> VarsInjection_R
modifySymState loc key newSymExpr = do
  tell [Log.ModifyState loc (show key,show newSymExpr)]
  modify $ \symState ->
    SymState {
      env = Map.insert key newSymExpr (env symState),
      pc  = pc symState
    }
  return ER_Void

runSymState :: SymState -> String -> ToInject -> ([Log.Log],SymState)
runSymState symState methodCall toInject = let
  runner :: Typed_Method_R (Config,MethodName,ToInject) (Map.Map SymStateKey ExecutionResult)
  runner = flip Map.traverseWithKey (env symState) $ \key val -> do
    tell [Log.NextMethodCallSymExpr methodCall (show key,show val)]
    getReader_VarsInjection_R $ visitSymExpr (key,val)
    return ER_Void

  initialSymState :: SymState
  initialSymState = SymState Map.empty (pc symState)

  run_r :: ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))) ()
  run_r = runReaderT (void runner) (defaultConfig,methodCall,toInject)

  run_e :: WriterT [Log.Log] (StateT SymState (Either String)) (Either String ())
  run_e = runExceptT run_r
  
  run_w :: StateT SymState (Either String) (Either String (),[Log.Log])
  run_w = runWriterT run_e
  
  mRun_s :: Either String ((Either String (),[Log.Log]),SymState)
  mRun_s = runStateT run_w initialSymState
  
  in case mRun_s of
       Left str -> error str
       Right ((ei,logs),symState2) ->
         (logs,either (\l -> error $ printf
             "error in method name (%s) thrown from VarsInjection.hs:\n%s" methodCall l) (const symState2) ei)
