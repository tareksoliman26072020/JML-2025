{-# Language LambdaCase, MultiWayIf #-}
module JML.Method where

import Prelude hiding (negate)
import Visitors.API
import JML.Types
import JML.Internal
import qualified JML.Logs.Log as Log
import JML.PrettyPrint (ppBehavior, ppBehaviors)
import qualified SymbolicExecution.Types as SYT (
  SymStateKey(..), SymExpr(..),
  SymbolicExecution, SymbolicExecutionKey, SymbolicExecutionValue)
import qualified SymbolicExecution.Internal.Internal as SY (
  getFunName, isGlobalVariable2, hasReturn, isLocalVar, hasFormalParameter,
  isNotAssigned)
import qualified Data.Map as Map

import Text.Printf

import Control.Monad.Writer
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Reader

import Data.Functor (($>))

globalLoc :: String
globalLoc = "JML.Method"

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
      let toReturn = ER_GlobalVars globalVars
      tellingThenReturning loc toReturn
    -----------------------------
    (SYT.FormalParms,SYT.SFormalParms formalParms) -> do
      let loc = globalLoc ++ ".visitSymExpr.FormalParms"
      tellNextLog
        $ Log.Skip loc (show tu) "nothing to do with formalParms"
      let toReturn = ER_FormalParms formalParms
      tellingThenReturning loc toReturn
    -----------------------------
    (SYT.VarAssignments,SYT.SVarAssignments varAssignments) -> do
      let loc = globalLoc ++ ".visitSymExpr.VarAssignments"
      tellNextLog
        $ Log.Skip loc (show tu) "nothing to do with varAssignments"
      let toReturn = ER_VarAssignments varAssignments
      tellingThenReturning loc toReturn
    -----------------------------
    (SYT.VarBindings,SYT.SVarBindings varBindings) -> do
      let loc = globalLoc ++ ".visitSymExpr.VarBindings"
      tellNextLog
        $ Log.Skip loc (show tu) "nothing to do with VarBindings"
      let toReturn = ER_VarBindings varBindings
      tellingThenReturning loc toReturn
    -----------------------------
    (SYT.Return,SYT.SymReturnVoid) -> do
      let loc = globalLoc ++ ".visitSymExpr.Return Void"
      tellNextLog
        $ Log.Skip loc (show tu) "return nothing because the method is of void"
      tellNextLog $ Log.Location loc (show tu)
      let toReturn = ER_ReturnVoid
      tellingThenReturning loc toReturn
    -----------------------------
    (SYT.Return,SYT.SException exceptionType exceptionName exceptionMessage) -> do
      let loc = globalLoc ++ ".visitSymExpr.Return Exception"
      tellNextLog $ Log.Location loc (show tu)
      let toReturn = ER_ReturnException exceptionName
      tellingThenReturning loc toReturn
    -----------------------------
    (SYT.Return,symExpr) -> do
      let loc = globalLoc ++ ".visitSymExpr.Return " ++ show symExpr
      tellNextLog $ Log.Location loc (show tu)
      let toReturn = ER_Return symExpr
      tellingThenReturning loc toReturn
    -----------------------------
    -- a global variable `vn` has been re-assigned
    -- this denotes `assignable` in JML
    (SYT.VarName vn,symExpr)
      | SY.isGlobalVariable2 vn sy &&
        not (SY.isNotAssigned vn symExpr) -> do
          let loc = globalLoc ++ ".visitSymExpr.VarName (1)"
          tellNextLog $ Log.Location loc (show tu)
          let toReturn = ER_VarName_Global_Reassigned vn symExpr Nothing
          tellingThenReturning loc toReturn
    -----------------------------
    -- a local variable `vn` has been re-assigned
    -- this denotes `vars` in JML
    (SYT.VarName vn,symExpr)
      |  not (SY.isNotAssigned vn symExpr) -> do
          let loc = globalLoc ++ ".visitSymExpr.VarName (2)"
          tellNextLog $ Log.Location loc (show tu)
          let toReturn = ER_VarName vn symExpr Nothing
          tellingThenReturning loc toReturn
      | otherwise -> do
          let loc = globalLoc ++ ".visitSymExpr.VarName (3)"
          tellNextLog $ Log.Location loc (show tu)
          tellNextLog $ Log.Skip loc (show tu) "varname remained unassigned"
          let toReturn = ER_VarName_Unassigned vn symExpr Nothing
          tellingThenReturning loc toReturn
    -----------------------------
    (SYT.Actions,SYT.SActions li) -> do
      let loc = globalLoc ++ ".visitSymExpr.Actions"
      tellNextLog $ Log.Location loc (show tu)
      if | null li -> do
             tellNextLog $ Log.Skip loc (show tu) "no actions"
             tellingThenReturning loc ER_Void
         | otherwise -> do
             jmlState <- get
             let toReturn = ER_Actions $ symExprToExpr jmlState value
             tellingThenReturning loc toReturn
    -----------------------------
    (SYT.ScopeRange scopeRange,SYT.SIte cond ifBody maybeElseBody) -> do
      let loc = globalLoc ++ ".visitSymExpr.SIte"
      tellNextLog $ Log.Location loc (show tu)
      -- SIte SymExpr SymbolicExecution (Maybe SymbolicExecution)
      -- process if
      (ifRequires,ifJMLState,if_ers) <- do
        tellNextLog $ Log.ProcessIfBody loc
        jmlState <- get
        let ifRequires = symExprToExpr jmlState cond
        tellNextLog $ Log.IfConditionPreCondition loc (show ifRequires)
        incrementLogEnumeration >> incrementLogDepth
        
        res@(if_error_er,ifLogs,ifJMLState) <- do
          sys <- ask
          return $ runSE sys ifBody
        
        -- is there an error
        let if_ers = case if_error_er of
              Right if_ers -> if_ers
              Left ifError -> createError_sy ("TODO1: " ++ ifError) loc key value
        
        -- if logs
        flip mapM_ ifLogs $ \log -> do
          Log.Header _ baseCounter <- logHeader <$> get
          tellNextNestedLog baseCounter ["if body"] log
        decrementLogDepth
        
        tellNextLog $ Log.IfInnerJMLState loc (show if_error_er)
          (show $ method ifJMLState) (map (\(Requires one two) -> (show one,map show two)) $ jmlStack ifJMLState) (show $ logHeader ifJMLState)
          (show $ formalParms ifJMLState) (show $ localVars ifJMLState) (show $ globalVars ifJMLState)
          (ppBehaviors $ behaviors $ method ifJMLState)
        
        return (ifRequires,ifJMLState,if_ers)
      -- process else
      maybeElse <- do
        case maybeElseBody of
          -- no else body
          Nothing -> do
            tellNextLog $ Log.NoElseBody loc
            --throwError $ createError_sy "TODO2" loc key value
            return Nothing
          -- yes else body
          Just elseBody -> do
            tellNextLog $ Log.ProcessElseBody loc
            let elseRequires = negate ifRequires
            tellNextLog $ Log.ElseConditionPreCondition loc (show elseRequires)
            incrementLogEnumeration >> incrementLogDepth
            
            (else_error_er,elseLogs,elseJMLState) <- do
              sys <- ask
              return $ runSE sys elseBody
            
            -- is there an error
            let else_ers = case else_error_er of
                  Right else_ers -> else_ers
                  Left elseError -> createError_sy ("TODO3: " ++ elseError) loc key value
            -- else logs
            flip mapM_ elseLogs $ \log -> do
              Log.Header _ baseCounter <- logHeader <$> get
              tellNextNestedLog baseCounter ["else body"] log
            decrementLogDepth
            
            tellNextLog $ Log.ElseInnerJMLState loc (show else_error_er)
              (show $ method ifJMLState) (map (\(Requires one two) -> (show one,map show two)) $ jmlStack ifJMLState) (show $ logHeader ifJMLState)
              (show $ formalParms ifJMLState) (show $ localVars ifJMLState) (show $ globalVars ifJMLState)
              (ppBehaviors $ behaviors $ method ifJMLState)
            return $ Just (elseRequires,elseJMLState,else_ers)

      return $ ER_IfThenElse scopeRange (ifRequires,ifJMLState,if_ers) maybeElse
    -----------------------------
    _ ->
      let loc = globalLoc ++ ".visitSymExpr"
      in throwError $ createError_sy "TODO" loc key value

-----------------------------
-----------------------------
-----------------------------

runSE :: Map.Map String SYT.SymbolicExecution -> SYT.SymbolicExecution -> (Either String [ExecutionResult],[Log.Log],JMLState)
runSE sys sy =
  let loc = globalLoc ++ ".runSE"
      runner :: JMLMonad [ExecutionResult]
      runner = do
      --visited :: Map.Map SYT.SymbolicExecutionValue ExecutionResult
        visited <- flip Map.traverseWithKey
          (flip Map.filterWithKey sy $ \case
             SYT.MethodHandle -> const False
             _ -> const True) $ \k v -> do
            tellNextLog $ Log.HorizontalLine "Next SymExpr"
            tellNextLog $ Log.NextSymExpr loc (show k) (show v)
            incrementLogDepth >> incrementLogEnumeration
            -- visiting
            visited <- visitingSymExpr sy (k,v)
            -- modifying the state
            addingBehavior sy visited
            decrementLogDepth
            return visited
        return $ Map.elems visited

      initialJMLState :: JMLState
      initialJMLState = JMLState {
        method = Method {
          name = SY.getFunName sy,
          behaviors = []
        },
        jmlStack = [Requires (Nothing,Nothing) []],
        logHeader = Log.Header 1 [0],
        formalParms = [],
        localVars = [],
        globalVars = [],
        reAssigned = []
      }

      run_e :: ReaderT (Map.Map String SYT.SymbolicExecution) (WriterT [Log.Log] (State JMLState)) (Either String [ExecutionResult])
      run_e = runExceptT runner

      run_r :: WriterT [Log.Log] (State JMLState) (Either String [ExecutionResult])
      run_r = runReaderT run_e sys

      run_w :: State JMLState ((Either String [ExecutionResult]),[Log.Log])
      run_w = runWriterT run_r

      run_s :: ((Either String [ExecutionResult],[Log.Log]),JMLState)
      run_s@((er,logs),s) = runState run_w initialJMLState

  in (er,logs,s)
  where
  visitingSymExpr :: SYT.SymbolicExecution -> (SYT.SymbolicExecutionKey,SYT.SymbolicExecutionValue) -> JMLMonad ExecutionResult
  visitingSymExpr sy tu =
    incrementLogDepth *>
      (methodProcessorMonad $ visitSymExpr sy tu)
      <* decrementLogDepth
  addingBehavior :: SYT.SymbolicExecution -> ExecutionResult -> JMLMonad ()
  addingBehavior sy visited = do
    incrementLogEnumeration
    incrementLogDepth *> addBehavior sy visited <* decrementLogDepth
