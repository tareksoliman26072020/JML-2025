{-# Language LambdaCase #-}
module JML.Method where

import Visitors.API
import JML.Types
import JML.Internal
import qualified JML.Logs.Log as Log
import qualified SymbolicExecution.Types as SYT (
  SymStateKey(..), SymExpr(..),
  SymbolicExecution, SymbolicExecutionKey, SymbolicExecutionValue)
import qualified SymbolicExecution.Internal.Internal as SY (getFunName, isGlobalVariable2)
import qualified Data.Map as Map

import Text.Printf

import Control.Monad.Writer
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Reader

import Data.Functor (($>))

globalLoc :: String
globalLoc = "JML.Method"

createError :: String -> String
  -> SYT.SymbolicExecutionKey -> SYT.SymbolicExecutionValue
  -> a
createError prefix loc key value = error $ printf
  "%s:\n\
  \1) %s\n\
  \2) key = %s\n\
  \3) value = %s"
  prefix
  {-1)-}(loc ++ " ==> createError")
  {-2)-}(show key)
  {-3)-}(show value)

instance SymbolicExecutionVisitor MethodProcessor where
--visitSymExpr :: SYT.SymbolicExecution -> (SYT.SymStateKey,SYT.SymbolicExecutionValue) -> MethodProcessor
  visitSymExpr sy tu@(key,value) = MethodProcessor $ case tu of
    (SYT.MethodHandle,_) -> do
      let loc = globalLoc ++ ".visitSymExpr.MethodHandle"
      tellNextLog $ Log.Location loc (show tu)
      throwError $ printf
        "%s: won't happen: %s" loc (show tu)
    -----------------------------
    (SYT.GlobalVars,SYT.SGlobalVars globalVars) -> do
      let loc = globalLoc ++ ".visitSymExpr.GlobalVars"
      tellNextLog $ Log.Location loc (show tu)
      tellNextLog
        $ Log.Skip loc (show tu) "no global vars were mentioned"
      let toReturn = ER_NoGlobalVars
      tellNextLog (Log.Return loc (show toReturn)) $> toReturn
    -----------------------------
    (SYT.FormalParms,SYT.SFormalParms formalParms) -> do
      let loc = globalLoc ++ ".visitSymExpr.FormalParms"
      tellNextLog
        $ Log.Skip loc (show tu) "nothing to do with formalParms"
      let toReturn = ER_FormalParms formalParms
      tellNextLog (Log.Return loc (show toReturn)) $> toReturn
    -----------------------------
    (SYT.VarAssignments,SYT.SVarAssignments varAssignments) -> do
      let loc = globalLoc ++ ".visitSymExpr.VarAssignments"
      tellNextLog
        $ Log.Skip loc (show tu) "nothing to do with varAssignments"
      let toReturn = ER_VarAssignments varAssignments
      tellNextLog (Log.Return loc (show toReturn)) $> toReturn
    -----------------------------
    (SYT.VarBindings,SYT.SVarBindings varBindings) -> do
      let loc = globalLoc ++ ".visitSymExpr.VarBindings"
      tellNextLog
        $ Log.Skip loc (show tu) "nothing to do with VarBindings"
      let toReturn = ER_VarBindings varBindings
      tellNextLog (Log.Return loc (show toReturn)) $> toReturn
    -----------------------------
    (SYT.Return,SYT.SException exceptionType exceptionName exceptionMessage) -> do
      let loc = globalLoc ++ ".visitSymExpr.Return Exception"
      tellNextLog $ Log.Location loc (show tu)
      let newClause = ExceptionalBehavior {
            requires = Nothing,
            signals = exceptionName,
            assignable = [],
            ensures = Nothing
          }
      let toReturn = ER_ReturnException newClause
      tellNextLog (Log.Return loc (show toReturn)) $> toReturn
    -----------------------------
    (SYT.Return,symExpr) -> do
      let loc = globalLoc ++ ".visitSymExpr.Return " ++ show symExpr
      tellNextLog $ Log.Location loc (show tu)
      let newClause = NormalBehavior {
            requires = Nothing,
            assignable = [],
            ensures = extractEnsures sy symExpr
          }
      let toReturn = ER_Return newClause
      tellNextLog (Log.Return loc (show toReturn)) $> toReturn
    -----------------------------
    -- a global variable `vn` has been re-assigned
    -- this denotes `assignable` in JML
    (SYT.VarName vn,symExpr)
      | SY.isGlobalVariable2 vn sy &&
        (case symExpr of
           SYT.SymVar _ vn2 -> vn2 /= vn
           _ -> True) -> do
          let loc = globalLoc ++ ".visitSymExpr.VarName (1)"
          tellNextLog $ Log.Location loc (show tu)
          let toReturn = ER_VarName_Global_Reassigned vn symExpr
          tellNextLog (Log.Return loc (show toReturn)) $> toReturn
    -----------------------------
    (SYT.VarName vn,symExpr) -> do
      let loc = globalLoc ++ ".visitSymExpr.VarName (2)"
      tellNextLog $ Log.Location loc (show tu)
      tellNextLog
        $ Log.Skip loc (show tu) "nothing to do with VarName"
      let toReturn = ER_VarName_Skipped vn symExpr
      tellNextLog (Log.Return loc (show toReturn)) $> toReturn
    -----------------------------
    _ ->
      let loc = globalLoc ++ ".visitSymExpr"
      in throwError $ createError "TODO" loc key value

-----------------------------
-----------------------------
-----------------------------

runSE :: Map.Map String SYT.SymbolicExecution -> SYT.SymbolicExecution -> (String,[Log.Log],Method)
runSE sys sy =
  let loc = globalLoc ++ ".runSE"
      runner :: JMLMonad ()
      runner = do
        visited <- flip Map.traverseWithKey
          (flip Map.filterWithKey sy $ \case
             SYT.MethodHandle -> const False
             _ -> const True) $ \k v -> do
            tellNextLog $ Log.HorizontalLine "Next SymExpr"
            tellNextLog $ Log.NextSymExpr loc (show k) (show v)
            incrementLogDepth >> incrementLogEnumeration
            -- visiting
            visited <-
               incrementLogDepth *>
                 (methodProcessorMonad $ visitSymExpr sy (k,v))
                     <* decrementLogDepth
            -- modifying the state
            do incrementLogEnumeration
               incrementLogDepth *> addBehavior visited <* decrementLogDepth
            decrementLogDepth
        --get >>= \theEnv -> throwError $ printf "MEOW::\n%s" (show theEnv)
        return ()

      initialJMLState :: JMLState
      initialJMLState = JMLState {
        method = Method {
          name = SY.getFunName sy,
          behaviors = []
        },
        jmlStack = [],
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

  in (either id (const "") er,logs,method s)
