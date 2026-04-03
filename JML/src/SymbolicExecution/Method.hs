{-# Language LambdaCase, MultiWayIf, ScopedTypeVariables #-}
module SymbolicExecution.Method where

import qualified SymbolicExecution.Logs.Log as Log
import SymbolicExecution.Types
import qualified CFG.Types as CFGT
import qualified CFG.Internal as CFG
import qualified Data.Map as Map
import Data.Maybe (mapMaybe)
import Control.Monad (foldM, zipWithM_)
import Control.Monad.Reader (ReaderT,runReaderT,ask)
import Control.Monad.State
import Control.Monad.Except
import Control.Monad (zipWithM,forM_)
import Control.Applicative (asum)
import qualified Parser.Types as AST
import Visitors.API
import Control.Monad.Writer
import Text.Printf (printf)
import Data.Functor (($>))
import Data.List (foldl',nub,intercalate)
import SymbolicExecution.Internal.Internal
import SymbolicExecution.Internal.Calculator (whichCalculator2, objAccCalculator, numericCalculator, booleanCalculator, objAccCalculator, stringCalculator, funCallCalculator)

instance CFGVisitor MethodProcessor where
--visitNode :: CFGT.Node -> MethodProcessor
  visitNode node = MethodProcessor $ tellNextLog (Log.HorizontalLine "visitNode") >> case node of
    CFGT.Entry t mn args -> do
      let loc = "SymbolicExecution.Method.visitNode.Entry"
      tellNextLog $ Log.MethodStart mn loc
      let (methodHandleKey,methodHandleValue) =
              (MethodHandle,
               SMethodHandle (toSymType1 t) mn)
      tellNextLog $ Log.FunHandle loc mn (show methodHandleValue)
      tellNextLog $ Log.ModifyState loc (mn,show methodHandleValue)
      modify $ \symState -> SymState {
        env = Map.insert methodHandleKey methodHandleValue $ env symState,
        logHeader = logHeader symState
      }
      case null args of
        True  -> tellNextLog (Log.Return (loc ++ " ==> method with no args") "()") $> ()
        False -> do
          tellNextLog $ Log.MethodFormalParams (show args) (loc ++ " ==> method with args")
          mapM_ (\arg -> do
                   incrementLogEnumeration
                   argVisited <- incrementLogDepth *> visitExpr arg
                   case argVisited of
                     ER_SymStateMapEntry (VarName name) val@(SymVar _ _) -> do
                       alreadyExist <- env <$> get >>= return . Map.lookup (VarName name)
                       case alreadyExist of
                         Nothing -> throwError $ "TODO: " ++ loc
                         Just (SymVar _ _) -> do
                           tellNextLog $ Log.ModifyState (loc ++ " ==> arg") (name,show val)
                           modify $ \symState -> SymState {
                               env = recordFormalParm name $ Map.insert (VarName name) val (env symState),
                               logHeader = logHeader symState
                           }
                         Just _ -> return ()
                     ER_ActualParameterDetected _ _ -> return ()
                     _ -> throwError $ loc ++ " ==> won't happen ==> " ++ show argVisited
                   decrementLogDepth
               ) args
      toReturn <- ER_State <$> get
      tellNextLog (Log.Return (loc ++ " ==> method has args") (show toReturn)) $> toReturn
    ----------------------------------------
    ----------------------------------------
    ----------------------------------------
    n@CFGT.End{} -> do
      let loc = "SymbolicExecution.Method.visitNode.End"
      tellNextLog $ Log.MethodEnd loc
      case CFGT.mExpr n of
        Nothing       -> do
          -- is it a void method or not?
          methodType <- do
            visited <- getFunHandle
            case visited of
              ER_FunHandle methodType _ -> return methodType
              _ -> error $ printf "%s ==> won't happen" loc
          -- 
          case methodType of
            Void -> do
              tellNextLog
                $ Log.Void $ printf "%s -> return nothing" loc
              let toReturn = ER_ReturnVoid
              tellNextLog
                $ Log.ModifyState (printf "%s ==> returning void" loc)
                                  ("Return","SymReturnVoid")
              modify $ \symState -> SymState
                (Map.insert Return SymReturnVoid (env symState))
                (logHeader symState)
              tellNextLog (Log.Return "visitNode -> End -> void method" (show toReturn)) $> toReturn
            _ -> return ER_Void
        a@(Just expr) -> do
          tellNextLog $ Log.ReturnStatement (show expr) "visitNode -> End -> return something"
          toReturn <- visitStmt (AST.ReturnStmt a)
          tellNextLog (Log.Return "visitNode -> End -> method returns" (show toReturn)) $> toReturn
    ----------------------------------------
    ----------------------------------------
    ----------------------------------------
    n@CFGT.Node{} -> case CFGT.nodeData n of
      CFGT.Statement stmt -> do
        let loc = "SymbolicExecution.Method.visitNode.Node.Statement"
        tellNextLog $ Log.MethodStatement (loc ++ " ==> Statement") (show stmt)
        incrementLogDepth
        toReturn <- visitStmt stmt
        decrementLogDepth
        -- get fun name
        funName <- do
          visited <- getFunHandle
          return $ case visited of
            ER_FunHandle _ funName -> funName
            _ -> error $ printf "won't happen1: %s ==> %s" loc (show visited)
        
        (_,cfgs) <- ask
        let cfg = case CFG.findCFGByName funName cfgs of
              -- CFG not found
              Nothing   -> error $ printf "%s ==> %s does not exist" loc funName
                    -- CFG found
              Just cfg0 -> cfg0
        let newVarCoor = CFGT.Node_Coor {
              CFGT.varDeclAt = CFGT.id n,
              CFGT.varFrame =
                let bStart = CFGT.parent n
                in CFGT.SR bStart $ CFG.getBranchEnd bStart cfg
            }
        env <$> get >>= \theEnv -> do
          case getNewVarBinding newVarCoor stmt of
            Just new -> do          
              old <- (getVarBindings . env) <$> get
              tellNextLog $ Log.AddVarBinding loc (show new)
              modify $ \symState ->
                SymState {
                  env = Map.insert VarBindings (SVarBindings $ Map.insert (fst new) (snd new) old) (env symState),
                  logHeader = logHeader symState
                }
              return ER_Void
            _ -> return ER_Void
          case getNewVarAssignment (
              flip Map.filterWithKey theEnv $ \case
                VarName _ -> (const True)
                _ -> (const False),
              newVarCoor) stmt of
            Just new -> do
              tellNextLog $ Log.AddVarAssignment loc (show new)
              state_map <- env <$> get
              let varAssignmentsList = case Map.lookup VarAssignments state_map of
                    Nothing -> []
                    Just (SVarAssignments li) -> li
              modify $ \s ->
                SymState {
                  env = Map.insert VarAssignments (SVarAssignments $ varAssignmentsList ++ [new]) (env s),
                  logHeader = logHeader s
                }
              return ER_Void
              -- Just ("y",Node_Coor {varDeclAt = 2, varFrame = 1})
            _ -> return ER_Void
        tellNextLog (Log.Return "visitNode -> Node -> Statement" (show toReturn)) $> toReturn
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      -- BooleanExpression Kind AST.Expression
      CFGT.BooleanExpression CFGT.If Nothing ->
        throwError "visitNode ==> case nodeData of Node ==> BooleanExpression If ==> won't happen"
      CFGT.BooleanExpression CFGT.If (Just expr) -> do
        let loc = "SymbolicExecution.Method.visitNode.Node.BooleanExpression If"
        tellNextLog $ Log.MethodStatementIfCondition (printf "%s ==> Node num: %d" loc (CFGT.id n)) (show expr)
        -- get fun name
        funName <- do
          visited <- getFunHandle
          return $ case visited of
            ER_FunHandle _ funName -> funName
            _ -> error $ printf "won't happen1: %s ==> %s" loc (show visited)
        (_,cfgs) <- ask
        let cfg = case CFG.findCFGByName funName cfgs of
                    -- CFG not found
                    Nothing   -> error $ printf "%s %s does not exist" loc funName
                    -- CFG found
                    Just cfg0 -> cfg0
            -- branches: start id for the if branch, and the else branch if it exists.
            --           return is a list of one or two ints.
            --           if there is no else branch, then the list has only one int.
            branches = case CFG.findEdge_via_id cfg (CFGT.id n) of
                      Just (_,xs) -> xs
                      Nothing     -> error $ printf "%s ==> won't happen1" loc
        let -- `branches_paths` is empty if the if/else body is empty
            branches_paths :: [[CFGT.Node]]
            branches_paths = filter (not . null) $ flip map branches $ \branchStartId ->
              let thePath = CFG.getPath branchStartId cfg
              in flip takeWhile thePath $ \case
                   CFGT.Node _ (CFGT.Meet CFGT.If) _ -> False
                   _                                 -> True

        expr2 <- do
          incrementLogEnumeration
          incrementLogDepth
          re <- censor (map $ \(Log.Log num tag) -> Log.Log num $ Log.Nested "if condition" tag)
                   (visitExpr expr)
          decrementLogDepth
          return $ case re of
            ER_Expr expr2 -> expr2
            _ -> error $ printf "%s ==> %s" loc (show re)
        (state,stateEnv) <- (,) <$> get <*> (env <$> get) 
        let mainActions = getActions stateEnv
        let mainVarAssignments = getVarAssignments stateEnv
        let mainVarNames = getVarNames stateEnv

        toReturn <- case expr2 of
              SBool b -> do
                case branches_paths of
                  [ifB] | b -> do
                    let (logs,condSymState) = let
                          (er,logs,condSymState) = runCFG cfgs cfg (Just ifB)
                            (Just $ SymState stateEnv (Log.Header 1 [0]))
                          in case er of
                               "" -> (logs,condSymState)
                               _  -> error $ printf "%s ==> if condition is true: %s" loc er
                    do
                      incrementLogEnumeration
                      flip mapM_ logs $ \log -> do
                        Log.Header _ baseCounter <- logHeader <$> get
                        tellNextNestedLog baseCounter ["if statement"] log
                    -- remove vars declared in that scope
                    -- use vars bindings to do so
                    let sEnv = removeDeletedVars stateEnv (env condSymState)
                    let newCondSymStateEnv =
                          let addActions = Map.alter (\case
                                Nothing -> Just $ SActions mainActions
                                Just (SActions li) -> Just
                                  $ SActions $ mainActions ++ li) Actions sEnv
                              deleteVarAssignments = Map.alter (\case
                                Nothing -> Nothing
                                Just (SVarAssignments li) -> Just $ SVarAssignments
                                  $ flip filter li
                                    $ \(name,_) ->
                                        isGlobalVariable2 name addActions ||
                                        maybe False (const True)
                                         (lookup name mainVarAssignments)
                                ) VarAssignments addActions
                          in deleteVarAssignments

                    env <$> get >>= \theEnv -> tellNextLog
                      $ Log.ModifyState
                          (printf "%s ==> overwriting if" loc)
                          (printf "old state: %s\n\n\
                                  \condSymState: %s\n\n\
                                  \sEnv: %s" (show theEnv) (show condSymState) (show sEnv),
                           printf "new state: %s" (show newCondSymStateEnv))
                    modify $ \symState -> SymState {
                        env = newCondSymStateEnv,
                        logHeader = logHeader symState
                      }
                    ER_State <$> get
                  [ifB] | not b -> do
                    tellNextLog $ Log.NoElseBranch loc
                    return ER_Void
                  [ifB,elseB] -> do
                    let choiceStr = if b then "if" else "else"
                        (logs,condSymState) = let
                          (er,logs,condSymState) = runCFG cfgs cfg (Just $ if b then ifB else elseB)
                            (Just $ SymState (env state) (Log.Header 1 [0]))
                          in case er of
                               "" -> (logs,condSymState)
                               _  -> error $ printf "%s ==> %s branch ==> %s" loc choiceStr er
                    do
                      tellNextLog (Log.HorizontalLine $ printf "In %s branch" choiceStr)
                      incrementLogEnumeration
                      flip mapM_ logs $ \log -> do
                        Log.Header _ baseCounter <- logHeader <$> get
                        tellNextNestedLog baseCounter [printf "%s statement" choiceStr] log
                    -- remove vars declared in that scope
                    -- use vars bindings to do so
                    let sEnv = removeDeletedVars stateEnv (env condSymState)
                    let newCondSymStateEnv =
                          let addActions = Map.alter (\case
                                Nothing -> Just $ SActions mainActions
                                Just (SActions li) -> Just
                                    $ SActions $ mainActions ++ li) Actions sEnv
                              deleteVarAssignments = Map.alter (\case
                                Nothing -> Nothing
                                Just (SVarAssignments li) -> Just $ SVarAssignments
                                  $ flip filter li
                                    $ \(name,_) ->
                                        isGlobalVariable2 name addActions ||
                                        maybe False (const True)
                                         (lookup name mainVarAssignments)
                                ) VarAssignments addActions
                          in deleteVarAssignments
                    tellNextLog $ Log.ModifyState (printf "%s ==> overwriting %s" loc (if b then "if" else "else")) ("<new state>",show newCondSymStateEnv)
                    modify $ \symState -> SymState {
                      env = newCondSymStateEnv,
                      logHeader = logHeader symState
                    }
                    ER_State <$> get
              SBin _ _ _ -> do
                let (ifLogs,ifSymState0) = let
                      ifInitState = SymState (env state) (Log.Header 1 [0])
                      (er,ifLogs,ifSymState0) = case branches_paths of
                        -- `branches_paths` is empty when the if body has no statements
                        -- in this case there's nothing to be done
                        [] -> ("",[],ifInitState)
                        _ -> runCFG cfgs cfg (Just $ branches_paths !! 0)
                          (Just ifInitState)
                      in case er of
                           "" -> (ifLogs,ifSymState0)
                           _  -> error $ printf "%s ==> unevaluated if condition ==> if ==> %s" loc er

                tellNextLog (Log.HorizontalLine "if branch")
                
                -- tell the logs of the if body 
                do
                  incrementLogEnumeration
                  flip mapM_ ifLogs $ \log -> do
                    Log.Header _ baseCounter <- logHeader <$> get
                    tellNextNestedLog baseCounter ["if statement"] log
                
                (ifCond,ifSymStateEnv,mElseSymStateEnv) <- case branches_paths of
                  -- if `branches_paths` is empty then there is no if or else body 
                  []  -> return (expr2,(env ifSymState0),Nothing)
                  -- if `branches_paths` has one elem then there is no else body
                  [_] -> return (expr2,(env ifSymState0),Nothing)
                  [_,pElse] -> do
                    let (elseLogs,elseSymState) = let
                          (er,elseLogs,elseSymState) = runCFG cfgs cfg (Just pElse)
                            (Just $ SymState (env state) (Log.Header 1 [0]))
                          in case er of
                               "" -> (elseLogs,elseSymState)
                               _  -> error $ printf "%s ==> unevaluated if condition ==> else ==> %s" loc er
                    
                    tellNextLog (Log.HorizontalLine "else branch")

                    flip mapM_ elseLogs $ \log -> do
                      Log.Header _ baseCounter <- logHeader <$> get
                      tellNextNestedLog baseCounter ["else statement"] log

                    return (expr2,env ifSymState0,Just $ env elseSymState)
                -- symExpr is the SIte with the two conditional states
                let symExpr = SIte ifCond ifSymStateEnv mElseSymStateEnv
                let condBranchRange = CFGT.SR {
                      CFGT.branchStart = CFGT.id n,
                      CFGT.branchEnd = CFG.getBranchEnd (CFGT.id n) cfg
                    }
                -- condVarAssignments gives me
                -- 1) the VarAssignments in the if/else branch,
                --    which were originally defined outside of them
                -- 2) the VarAssignments of global variables
                let condVarAssignments sEnv = flip filter (getVarAssignments sEnv) $
                      \(name,_) ->
                        Map.member (VarName name) mainVarNames ||
                        (isGlobalVariable2 name sEnv)
                      
                    newMainVarAssignments = nub $
                        condVarAssignments ifSymStateEnv ++
                        maybe [] condVarAssignments mElseSymStateEnv
                    newMainGlobalVars = nub $
                        filter (\vn -> isGlobalVariable2 vn stateEnv)
                               (getVarNames2 (ScopeRange condBranchRange,ifCond))
                        ++ getGlobalVars ifSymStateEnv
                        ++ maybe [] getGlobalVars mElseSymStateEnv
                tellNextLog $ Log.ModifyState (printf "%s ==> recording symbolic branching" loc) (printf "if node num: %d" (CFGT.id n),show symExpr)
                modify $ \symState ->
                      -- `ma1` has the new conditional branchs (addNode)
                      --  and has the new VarAssignments from the conditional branches
                  let ma1 =
                        let addNode = Map.insert
                              (ScopeRange condBranchRange)
                              symExpr (env symState)
                            addVarAssignments = Map.insert
                              VarAssignments (SVarAssignments newMainVarAssignments) addNode
                            addGlobalVars = Map.insert
                              GlobalVars (SGlobalVars newMainGlobalVars) addVarAssignments
                        in addGlobalVars
                      -- if there's a VarName that was assigned between `condBranchRange`
                      -- then make it unknown
                      unknownVarAssigns = flip filter (getVarAssignments2 ma1) $ \case
                        (_,(_,CFGT.Node_Coor _ frameCoor)) ->
                          CFGT.branchStart frameCoor == CFGT.branchStart condBranchRange
                      -- will be used in ma2
                      -- gets SymType of `varAssName`,
                      -- which is the one of the vars mentioned in `unknownVarAssigns`
                      getUnknownVarSymType_in_if_template varAssName =
                        let seeking = asum $ map (getVarNameSymType varAssName)
                              $ ifSymStateEnv : maybe [] (: []) mElseSymStateEnv
                        in case seeking of
                             Nothing -> error $ printf "%s ==> won't happen2" loc
                             Just t -> t
                      -- will be used in ma2
                      -- creates new reason, based in this if scope 
                      newReason_template :: [CFGT.Node_Coor] -> [SymReason]
                      newReason_template coors = createSymReason
                          (CFGT.If,
                           CFGT.SR (CFGT.id n)
                                   (CFG.getNodeId $ CFG.getEndIfNode cfg n)) cfg coors
                      -- ma2 traverses each (varAssName,coors) mentioned in `unknownVarAssigns`
                      -- and uses them to Map.alter every mention of the varName in ma1
                      -- This will yield new SymUnknown as SymExpr to each varAssName
                      -- `getUnknownVarSymType_in_if_template` and `newReason_template`
                      -- will be used inside
                      ma2 = foldl' (\ma (varAssName,(_,coor)) ->
                        Map.alter (\case
                          Nothing -> Just $ SymUnknown (
                            SymVar (getUnknownVarSymType_in_if_template varAssName) varAssName)
                              $ newReason_template [coor]
                          Just (SymUnknown v oldReasons) -> Just $
                            SymUnknown
                              (cast (getUnknownVarSymType_in_if_template varAssName) v)
                            $ oldReasons ++ newReason_template [coor]
                          Just val -> Just $ SymUnknown (
                            cast (pick_known_symType (
                              toSymType2 val,
                              (getUnknownVarSymType_in_if_template varAssName))) val)
                            $ newReason_template [coor]) (VarName varAssName) ma)
                            ma1 unknownVarAssigns
                  
                  in SymState {
                    env = ma2,
                    logHeader = logHeader symState
                  }
                -- the branching for the if and else
                -- may provide more concrete informations about
                -- global VarNames in the main branch
                --
                -- Extract types of global VarNames from the if and else branches
                -- and use them to cast the global VarNames in the main branch
                -- symExpr@(SIte ifCond ifSymStateEnv mElseSymStateEnv)
                -- varNameSymExprs :: [(String,[SymExpr])]
                varNameSymExprs <- getScopedGlobalVarsSymExprs (ScopeRange condBranchRange,symExpr)
                -- `varNameSymExprs` provides all needed info for the most concrete type
                -- of all global variables available at this point
                -- record it:
                modify $ \symState -> SymState {
                  env = flip Map.mapWithKey (env symState) $ \k v -> case k of
                    VarName vn -> case lookup vn varNameSymExprs of
                      Nothing -> v
                      Just symExprs ->
                        let symExprs_ = flip filter symExprs $ \symExpr ->
                              toSymType2 symExpr `isInstanceOf` toSymType2 v
                            newType = pick_known_symType2
                              $ map toSymType2 (v : symExprs_)
                        in cast newType v
                    _ -> v,
                  logHeader = logHeader symState
                }
                return $ ER_Expr symExpr
              _ -> throwError $ printf "TODO: %s: %s" loc (show expr2)
        tellNextLog (Log.Return loc (show toReturn)) $> toReturn
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      CFGT.ForInitialization mAccumulationVar -> do
        let loc = "SymbolicExecution.Method.visitNode.Node.ForInitialization"
        tellNextLog $ Log.MethodStatementForInitialization (printf "%s ==> Accumulation Variable ==> Node num: %d" loc (CFGT.id n)) (show mAccumulationVar)
        -- get fun name
        funName <- do
          visited <- getFunHandle
          return $ case visited of
            ER_FunHandle _ funName -> funName
            _ -> error $ printf "won't happen1: %s ==> %s" loc (show visited)
        (_,cfgs) <- ask
        varNames <- (getVarNames . env) <$> get
        let cfg = case CFG.findCFGByName funName cfgs of
              -- CFG not found
              Nothing   -> error $ printf "%s %s does not exist" loc funName
                    -- CFG found
              Just cfg0 -> cfg0
        let m_Acc = flip fmap mAccumulationVar $ \v ->
              CFGT.Node (CFGT.id n) (CFGT.Statement $ AST.AssignStmt [] v) (CFGT.parent n)
        -- process SymState of for body
        -- branches: start id for the for body branch.
        --           return is a list of one int.
        let forCondNodeId = CFGT.id n + 1
        let forCondNode = CFG.findNode_via_id cfg forCondNodeId
        let forBodyBranch = case CFG.findEdge_via_id cfg forCondNodeId of
                  Just (_,(x : _)) -> x
                  Nothing     -> error $ printf "%s ==> won't happen" loc

        let forBody_forStep_path :: [CFGT.Node]
            forBody_forStep_path = flip takeWhile (CFG.getPath forBodyBranch cfg) $ \case
              CFGT.Entry _ _ _ -> error $ printf "%s won't happen" loc
              CFGT.End _ _ _ -> error $ printf "%s won't happen" loc
              CFGT.Node theId _ _ -> theId /= forCondNodeId
        -- implement a helper that takes as input `(accLogs,accState)`
        -- call it `visitForLoop`
        visitLoop cfg m_Acc
          (let CFGT.Node _ (CFGT.BooleanExpression CFGT.For mForCondExpr) _ = forCondNode 
           in mForCondExpr)
          forBody_forStep_path
          (CFGT.SR (CFGT.id n)
              (CFG.getNodeId $ CFG.getEndForNode cfg $ (CFG.findNode_via_id cfg $ CFGT.id n)))
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      CFGT.ForStep mStmt -> do
        let loc = "SymbolicExecution.Method.visitNode.Node.ForStep"
        tellNextLog $ Log.MethodStatementForStep (printf "%s ==> Node num: %d" loc (CFGT.id n)) (show mStmt)
        case fmap visitStmt mStmt of
          Nothing -> do
            tellNextLog $ Log.Skip loc "there exists no ForStep"
            return ER_Void
          Just symbolicExecutionMonadValue -> do
            er <- symbolicExecutionMonadValue
            case er of
              ER_SymStateMapEntry _ _ -> return er
              _ -> throwError $ printf "%s ==> TODO: %s" loc (show er)
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      CFGT.BooleanExpression CFGT.While mExpr -> do
        let loc = "SymbolicExecution.Method.visitNode.Node.BooleanExpression While"
        tellNextLog $ Log.MethodStatementWhileCondition (printf "%s ==> Node num: %d" loc (CFGT.id n)) (show mExpr)
        -- get fun name
        funName <- do
          visited <- getFunHandle
          return $ case visited of
            ER_FunHandle _ funName -> funName
            _ -> error $ printf "won't happen1: %s ==> %s" loc (show visited)
        (_,cfgs) <- ask
        varNames <- (getVarNames . env) <$> get
        let cfg = case CFG.findCFGByName funName cfgs of
              -- CFG not found
              Nothing   -> error $ printf "%s %s does not exist" loc funName
                    -- CFG found
              Just cfg0 -> cfg0
        let m_Acc = Nothing
        -- process SymState of while body
        -- branches: start id for the while body branch.
        --           return is a list of one int.
        let whileCondNodeId = CFGT.id n
        let whileCondNode = n
        let whileBodyBranch = case CFG.findEdge_via_id cfg whileCondNodeId of
                  Just (_,(x : _)) -> x
                  Nothing     -> error $ printf "%s ==> won't happen" loc

        let whileBody_path :: [CFGT.Node]
            whileBody_path = flip takeWhile (CFG.getPath whileBodyBranch cfg) $ \case
              CFGT.Entry _ _ _ -> error $ printf "%s won't happen" loc
              CFGT.End _ _ _ -> error $ printf "%s won't happen" loc
              CFGT.Node theId _ _ -> theId /= whileCondNodeId
        -- implement a helper that takes as input `(accLogs,accState)`
        -- call it `visitForLoop`
        visitLoop cfg m_Acc
          mExpr
          whileBody_path
          (CFGT.SR (CFGT.id n)
              (CFG.getNodeId $ CFG.getEndWhileNode cfg whileCondNode))
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      _ -> throwError
        $ "TODO -> visitNode -> Node -> nodeData -> otherwise: " ++ show n
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      where
      removeDeletedVars :: SymStateEnv -> SymStateEnv -> SymStateEnv
      removeDeletedVars stateEnv condSymStateEnv =
        let outerVarBindings = getVarBindings stateEnv
            condVarBindings = getVarBindings condSymStateEnv
            varsToDelete = condVarBindings Map.\\ outerVarBindings
            newCondSymStateEnv = flip Map.foldMapWithKey condSymStateEnv $
              \key val -> case (key,val) of
                 (VarName varName,_)
                    | varName `Map.member` varsToDelete -> Map.empty
                    | otherwise -> Map.singleton key val
                 (VarBindings,_) -> Map.singleton VarBindings (SVarBindings outerVarBindings)
                 (_,_) -> Map.singleton key val
        in newCondSymStateEnv

----------------------------------------
----------------------------------------
----------------------------------------

getFunHandle :: SymbolicExecutionMonad ExecutionResult
getFunHandle = do
  theEnv <- env <$> get
  case Map.lookup MethodHandle theEnv of
    Nothing -> throwError $ "SymbolicExecution.Method.getFunHandle ==> fun handle does not exist"
    -- it will always be a `Just` when `getFunHandle` is called
    -- for any node after the `Entry` node.
    Just (SMethodHandle methodType methodName) -> return
      $ ER_FunHandle methodType methodName

visitStmt :: AST.Statement -> SymbolicExecutionMonad ExecutionResult
--ReturnStmt {returnS :: Maybe Expression}
visitStmt (AST.ReturnStmt (Just expr)) = do
  let loc = "SymbolicExecution.Method.visitStmt.ReturnStmt"
  tellNextLog $ Log.ReturnStatement (show expr) loc
  er <- incrementLogDepth *> visitExpr expr <* decrementLogDepth
  
  -- get fun type
  (t,funName) <- do
    visited <- getFunHandle
    return $ case visited of
      ER_FunHandle t n -> (t,n)
      _ -> error $ printf "won't happen1: %s ==> %s" loc (show visited)

  let symExpr = case getSymExpr er of
        Just expr@(SLoopFailure _ _) -> expr
        Just symExpr -> case t of
          Void -> symExpr
          _    -> cast t symExpr
        Nothing      -> error $ "visitStmt -> ReturnStmt -> won't happen: " ++ show er

  incrementLogEnumeration >>
    incrementLogDepth *> inferGlobalVarType t er <* decrementLogDepth

  tellNextLog $ Log.ModifyState "visitStmt -> ReturnStmt -> method with args" ("return",show symExpr)
  modify $ \symState ->
    SymState {
      env = Map.insert Return symExpr (env symState),
      logHeader = logHeader symState
    }

  tellNextLog (Log.Return "visitStmt -> ReturnStmt" (show er)) $> er

-- AssignStmt {varModifier :: [Modifier], assign :: Expression}
visitStmt stmt@AST.AssignStmt{} = do
  tellNextLog $ Log.AssignStatement (show $ AST.assign stmt) "visitStmt -> pattern matching: AssignStmt"
  mapEntry <- visitExpr $ AST.assign stmt
  tellNextLog (Log.Return "visitStmt -> AssignStmt" (show mapEntry)) $> mapEntry
-- VarStmt {var :: Expression}
visitStmt stmt@AST.VarStmt{} = do
  d <- visitExpr $ AST.var stmt
  tellNextLog (Log.Return "visitStmt -> VarStmt" (show d)) $> d
visitStmt stmt@(AST.FunCallStmt expr) = case expr of
  AST.FunCallExpr{} -> do
    toReturn <- visitExpr expr
    case toReturn of
      ER_PredefinedFunCall symExpr -> do
        tellNextLog (Log.ModifyState "visitStmt -> FunCallStmt" ("SActions",show symExpr))
        modify $ \symState ->
          SymState {
            env = Map.alter (\case
                    Nothing -> Just $ SActions [symExpr]
                    Just (SActions li) -> Just $ SActions $ li ++ [symExpr]) Actions (env symState),
            logHeader = logHeader symState
          }
        tellNextLog (Log.Return "visitStmt -> FunCallStmt" (show toReturn)) $> toReturn
      ER_FunCall _ ->
        return ER_Void
      _ -> throwError $ "visitStmt ==> FunCallStmt ==> won't happen 1: " ++ show toReturn
  _ -> throwError $ "visitStmt ==> FunCallStmt ==> won't happen 2: " ++ show expr
visitStmt stmt = throwError $ "TODO -> visitStmt -> " ++ show stmt

visitExpr :: AST.Expression -> SymbolicExecutionMonad ExecutionResult
visitExpr expr@(AST.NumberLiteral float) = do
  tellNextLog $ Log.Expression_2_Handle (show expr) "visitExpr -> NumberLiteral"
  let toReturn = ER_Expr (SymNum float)
  tellNextLog (Log.Return "visitExpr -> NumberLiteral" (show toReturn)) $> toReturn
-- StringLiteral String
visitExpr expr@(AST.StringLiteral str) = do
  tellNextLog $ Log.Expression_2_Handle (show expr) "visitExpr -> StringLiteral"
  let toReturn = ER_Expr (SymString str)
  tellNextLog (Log.Return "visitExpr -> StringLiteral" (show toReturn)) $> toReturn

-- FunCallExpr {funName :: Expression, funArgs :: [Expression]}
visitExpr (expr@AST.FunCallExpr{}) = do
  let loc = "SymbolicExecution.Method.visitExpr.FunCallExpr"
  tellNextLog $ Log.Expression_2_Handle (show expr) "visitExpr -> FunCallExpr"
  (_,cfgs) <- ask
  let funCallName = AST.getFunCallName $ AST.FunCallStmt expr
  -- Search for the CFG of the method call
  case CFG.findCFGByName funCallName cfgs of
    -- CFG found
    Just cfg0 -> do
      -- See if the method call has parameters
      case CFG.getCFGFormalParams cfg0 of
        formalParms -> do
          let funCall_formalParms_varNames :: [String]
              funCall_formalParms_varNames = map AST.getVarName formalParms
          -- get the ExecutionResults of the actual parameters
          --actualParms :: [ExecutionResult]
          actualParms <- do
            flip mapM (zip formalParms (AST.funArgs expr))
            $ \tu@(formalParm,actualParm_exp) -> do
              incrementLogEnumeration
              let newLogTagStrs = [
                    printf "%s(%s = %s)" funCallName
                      (AST.ppExpr_no_type formalParm) (AST.ppExpr_no_type actualParm_exp),
                    "actual parameter in Method Call"]
              let prependLogs :: [Log.Log] -> [Log.Log]
                  prependLogs = map (\(Log.Log innerCounterStr logTag) ->
                    Log.Log innerCounterStr $ foldl' (\tag str ->
                      Log.Nested str tag) logTag newLogTagStrs)
              censor prependLogs $ do
                er <- incrementLogDepth *> visitExpr actualParm_exp <* decrementLogDepth
                return er
                
          -- `actualParms1` keeps track of where actual parameters come from
          -- in the following example, you see how `arr` in `manyArrs7`
          --     originates from `brand` in `manyArrs7Call2`
          -- actualParms1 = [
          --   (VarName "brand",
          --    (VarName "arr",
          --     SymArray (Just String) (Just 5) [SymString "Toyota",SymString "Mercedes",SymString "BMW",SymString "Volkswagen",SymString "Skoda"]
          --    ))]
          {-
          public static void manyArrs7Call2() {
            String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
            manyArrs7(brand);
          }

          public void manyArrs7(String[] arr) {
            for(int i=0; i<arr.length; i++) {
              arr[i] = toString(i+1) + ". " + arr[i];
            }
            println(arr);
          }
           -}
          let actualParms1 :: [(Maybe SymStateKey,(SymStateKey,SymExpr))]
              actualParms1 = zipWith (\fParm act ->
                let originalVarName = case act of
                      ER_SymStateMapEntry key symExpr -> Just key
                      ER_Expr (SymNum _) -> Nothing
                      ER_Expr (SymArray _ _ _) -> Nothing
                      ER_Expr (SymInt _) -> Nothing
                      ER_Expr (SBin _ _ _) -> Nothing
                      ER_Expr (SymString _) -> Nothing
                      ER_Expr (SymNull _) -> Nothing
                      _ -> error $ "TODO1 ==> visitExpr -> FunCallExpr -> " ++ show act
                    maybeActual = getSymExpr act
                in case maybeActual of
                     Nothing -> error "TODO2 ==> visitExpr -> FunCallExpr"
                     Just actual ->
                       let Just t = fmap toSymType1 $ AST.varType fParm
                       in (originalVarName,(VarName $ AST.getVarName fParm,cast t actual))
                ) formalParms actualParms
          
          {-
          look at `x` in `sum1Call3`. it is of `UnknownNumSymType`.
          But the fact that it is passed as actual parameter to `sum1`
          infers `x` to `Int`.
          Therefore `inferGlobalVarType` needs to be used on `x` to do that.
          public int sum1(int n) {
            int res = 0;
            for(; n>0; n--) {
              res += n;
            }
            return res;
          }

          public String sum1Call3() {
            x = 3;
            return toString(sum1(x));
          }
           -}
          {-
          actualParms = [ER_SymStateMapEntry (VarName "x") (SymNum 3.0)]
          actualParms1 = [(VarName "x",(VarName "n",SymInt 3))]
           -}
          zipWithM_ (\er (_,symExpr1) -> case er of
            ER_SymStateMapEntry vn@(VarName _) symExpr2 ->
              inferGlobalVarType
                (pick_known_symType2
                 $ map toSymType2 [symExpr1,symExpr2])
                (ER_SymStateMapEntry vn symExpr1)
            ER_Expr symExpr2 -> return ()
            _ -> throwError $ "TODO3 ==> visitExpr -> FunCallExpr: " ++ show er)
            actualParms (map snd actualParms1)
          -- global vars to be inserted into the method call Map.Map
          -- Global vars which have the same name of formal parms get excluded
          -- (globalVars,globalVarsMap) :: ([String],Map.Map SymStateKey SymExpr)
          (globalVars,globalVarsMap) <- do
            ma0 <- env <$> get
            let theMap = flip Map.filterWithKey (getGlobalVars2 ma0) $ \case
                  -- if a global variable has the same name as a formal parameter
                  -- then we don't want it inserted into the state of the method call
                  VarName vn
                    | vn `elem` funCall_formalParms_varNames -> const False
                  _ -> \case
                    -- `SymVar` occurs when the global variable was not assigned
                    -- in the method of `ma0`
                    SymVar _ _ -> False
                    _ -> True
                globalVars = flip map (Map.keys theMap) $ \(VarName vn) -> vn
            return (globalVars,theMap)
          let funCallMap0 =
                Map.union globalVarsMap
                $ Map.union (Map.fromList (map snd actualParms1))
                $ Map.insert FormalParms (SFormalParms funCall_formalParms_varNames)
                $ Map.insert GlobalVars (SGlobalVars globalVars)
                Map.empty
          let (funCallLogs2,funCallSymState2) = let
                (er,funCallLogs2,funCallSymState2) = runCFG cfgs cfg0 Nothing
                  $ Just $ SymState funCallMap0 (Log.Header 1 [0])
                in case er of
                     "" -> (funCallLogs2,funCallSymState2)
                     _  -> error $ printf "%s ==> funcall runner ==> %s" loc er
          if null globalVars
            then return ()
            else do
              -- tell global vars
              tellNextLog $ Log.Nested ("actual: " ++ funCallName) $ Log.GlobalVars
                  (show $ Map.toList globalVarsMap)
                  "visitExpr -> FunCallExpr"
              return ()
          
          -- tell formalParms
          tellNextLog $ Log.Nested ("actual: " ++ funCallName) $ Log.MethodFormalParams
              (show funCall_formalParms_varNames)
              "visitExpr -> FunCallExpr"
          -- tell actualParms1
          tellNextLog $ Log.Nested ("actual: " ++ funCallName) $ Log.MethodActualParms
              (show actualParms1)
              "visitExpr -> FunCallExpr"
          -- edit its logs and tell them
          flip mapM_ funCallLogs2 $ \log -> do
            Log.Header _ baseCounter <- logHeader <$> get
            tellNextNestedLog baseCounter ["actual: " ++ funCallName] log
          
          let inherit_actions = getActions $ env funCallSymState2
              inherit_globalVars = getGlobalVars (env funCallSymState2)
          let inherit_globalVars_varNames = flip Map.filterWithKey (getVarNames $ env funCallSymState2) $ \k _ -> case k of
                VarName vn
                  | vn `elem` inherit_globalVars -> True
                _ -> False
          ----------
          -- inheriting the method call's actual parms (only when the actual parameter is an array)
          -- if they are defined outside the method call.
          -- Example:
          --     1) notice how `arr` is defined before `swap(arr,0,1)`.
          --     2) notice how `arr` before and after `swap(arr,0,1)` diverges
          --     3) `inherit_actualParms` keeps `arr` in sight
          {-
          private static void swapCall() {
            int[] arr = new int[] {5,4,6,4,7,8,9,0,1};
            swap(arr,0,1);
            println(arr);
          }
          
          private static void swap(int[] arr, int i, int j) {
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
          }
           -}
          {-
          Why only arrays? look at the following example, sucFun does not update n, because
            1) n is of primitive type,
            2) Java passes arguments by value,
            3) n + 1 is evaluated first, producing a new value,
            4) that value is copied into i,
            5) i is local to succFun, so this change is lost when the method ends,
            6) return n; returns the original n, which is still 1.
            So n remains unchanged.
            
          public static void succFun(int i) {
            i += 1;
          }

          public static void succFunCall() {
            int n = 2;
            succFun(n);
            println(n);
          }
           -}
        --inherit_actualParms :: Map.Map SymStateKey SymExpr
          inherit_actualParms <- do
            theEnv <- env <$> get
            let -- `mainFunVarNames` has formal parameters + local variables
                mainFunVarNames :: [String]
                mainFunVarNames = flip foldMap theEnv $ \case
                  SVarBindings m  -> Map.keys m
                  SFormalParms li -> li
                  _ -> []
            let funCallSymState2Env = env funCallSymState2
            let relevantActualParms :: [(String,String)]
                relevantActualParms = [(vn2,vn)
                  | (Just (VarName vn),(VarName vn2,symExpr)) <- actualParms1
                  , case symExpr of
                      SymArray _ _ _ -> True
                      _              -> False]
            let funCallVarNames = getVarNames funCallSymState2Env
            return $ Map.fromList $ flip map relevantActualParms
                  $ \(fromCall,fromOrig) -> case Map.lookup (VarName fromCall) funCallVarNames of
                    Just symExpr -> (VarName fromOrig,symExpr)
                    Nothing -> error $ printf "%s ==> relevantMapEntries ==> won't happen" loc
          ----------
          -- inheriting the method call's global vars list
          if null inherit_globalVars
            then return ()
            else do
              tellNextLog $ Log.ModifyState "visitExpr -> FunCallExpr -> inheriting global vars list" ("GlobalVars",show inherit_globalVars)
              modify $ \symState ->
                SymState {
                  env = Map.alter (\case
                          Nothing -> Just $ SGlobalVars inherit_globalVars
                          Just (SGlobalVars li) -> Just
                            $ SGlobalVars $ nub $ li ++ inherit_globalVars)
                        GlobalVars (env symState),
                  logHeader = logHeader symState
                }
          ----------
          -- inheriting the method call's global vars var names
          if null inherit_globalVars_varNames
            then return ()
            else do
              tellNextLog $ Log.ModifyState "visitExpr -> FunCallExpr -> inheriting global vars varnames" ("VarNames",show inherit_globalVars_varNames)
              modify $ \symState ->
                SymState {
                  env = Map.union inherit_globalVars_varNames (env symState),
                  logHeader = logHeader symState
                }
              flip Map.traverseWithKey inherit_globalVars_varNames $ \k v ->
                inferGlobalVarType (toSymType2 v) $ ER_SymStateMapEntry k v
              return ()
          ----------
          -- inheriting the method call's actions
          if null inherit_actions
            then return ()
            else do
              tellNextLog $ Log.ModifyState "visitExpr -> FunCallExpr -> inheriting actions" ("Actions",show inherit_actions)
              modify $ \symState ->
                SymState {
                  env = Map.alter (\case
                          Nothing -> Just $ SActions inherit_actions
                          Just (SActions li) -> Just
                            $ SActions $ li ++ inherit_actions)
                        Actions (env symState),
                  logHeader = logHeader symState
                }
          ----------
          if Map.null inherit_actualParms
            then return ()
            else do
              tellNextLog $ Log.ModifyState (loc ++ " -> inheriting actualParms") ("ActualParms",show inherit_actualParms)
              modify $ \symState -> SymState
                (Map.union inherit_actualParms (env symState)) (logHeader symState)
          ----------
          tellNextLog $ Log.RunSymStateActualMethodCall (show funCallSymState2)
          let toReturn = ER_FunCall funCallSymState2
          tellNextLog (Log.Return "visitExpr -> FunCallExpr ==> 1" (show toReturn)) $> toReturn
    -- CFG not found
    Nothing
      | funCallName `elem` predefinedFuns -> do
          tellNextLog $ Log.ProcessPredefinedFunCall "visitExpr ==> FunCallExpr" (show $ AST.funName expr) (show $ AST.funArgs expr)
          -- get SymExprs of args
          ers <- flip mapM (AST.funArgs expr) $ \ex -> do
            er <- visitExpr ex
            return er
            --return (er,let Just e = getSymExpr er in e)

          let funArgsExprs = flip map ers $ \er -> let Just e = getSymExpr er in e
{-
          funArgsExprs <- flip mapM (AST.funArgs expr) $ \ex ->
            ((\m -> let Just e = m in e) . getSymExpr) <$> visitExpr ex
 -}         
          -- funArgsExprs = [SBin (SymInt 1) Add (SymVar Int "n")]
          -- toReturn = ER_Expr (SBin (SymInt 1) Add (SymVar Int "n"))
          let toReturn =
                ER_PredefinedFunCall
                  $ funCallCalculator (
                      toDefinedFun $ AST.getFunCallName $ AST.FunCallStmt expr,
                      funArgsExprs)
          tellNextLog (Log.Return "visitExpr ==> FunCallExpr ==> 2" (show toReturn)) $> toReturn
      | otherwise -> throwError $ "visitExpr => FunCallExpr: Method " ++ funCallName ++ " does not exist"
--BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
visitExpr expr@AST.BinOpExpr{} = do
  tellNextLog $ Log.Expression_2_Handle (show expr) "visitExpr -> BinOpExpr"
  er_one <- do
    incrementLogEnumeration
    incrementLogDepth *>
      censor (map $ \(Log.Log num tag) -> Log.Log num $ Log.Nested "Left operand" tag)
             (visitExpr (AST.expr1 expr))
        <* decrementLogDepth
  
  er_two <- do
    incrementLogEnumeration
    incrementLogDepth *>
      censor (map $ \(Log.Log num tag) -> Log.Log num $ Log.Nested "Right operand" tag)
             (visitExpr (AST.expr2 expr)) <* decrementLogDepth

  let mOne = getSymExpr er_one
      mTwo = getSymExpr er_two
  case (mOne,mTwo) of
    (Just one,Just two) -> do
      let newUnifiedSymType = pick_known_symType (toSymType2 one,toSymType2 two)
      flip mapM_ [er_one,er_two] $ \expr -> do
        incrementLogEnumeration
        incrementLogDepth *> inferGlobalVarType newUnifiedSymType expr <* decrementLogDepth

      tellNextLog $ Log.Affected "visitExpr -> BinOpExpr" [show one,show $ AST.binOp expr,show two]
      let op1 = cast newUnifiedSymType one
          operator = toSymBinOp $ AST.binOp expr
          op2 = cast newUnifiedSymType two
          calculatorType = whichCalculator2 op1 operator op2
          calculator = case calculatorType of
            "stringCalculator"  -> stringCalculator
            "numericCalculator" -> numericCalculator
            "booleanCalculator" -> booleanCalculator
          calculating = calculator (SBin op1 operator op2)
          toReturn = ER_Expr calculating
      tellNextLog (Log.Return (printf "visitExpr -> BinOpExpr -> %s"
                          calculatorType) (show toReturn)
           ) $> toReturn
    _ -> throwError $ printf "visitExpr -> BinOpExpr -> won't happen -> (%s,%s)" (show mOne) (show mTwo)
-- UnOpExpr {unOp :: UnOp, expr :: Expression}
visitExpr expr@AST.UnOpExpr{} = throwError "visitExpr ==> UnOpExpr ==> TODO"
-- AssignExpr {assEleft :: Expression, assEright :: Expression}
visitExpr expr@AST.AssignExpr{} = do
  let loc = "SymbolicExecution.Method.visitExpr.AssignExpr"
  tellNextLog $ Log.Expression_2_Handle (show expr) loc

  one <- do
    incrementLogEnumeration
    incrementLogDepth *>
      censor (map $ \(Log.Log num tag) -> Log.Log num $ Log.Nested "Left Operand" tag)
             (visitExpr (AST.assEleft expr))
        <* decrementLogDepth

  two <- do
    incrementLogEnumeration
    incrementLogDepth *>
      censor (map $ \(Log.Log num tag) -> Log.Log num $ Log.Nested "Right Operand" tag)
             (visitExpr (AST.assEright expr))
        <* decrementLogDepth

  -- one_val's sole purpose is its type
  -- one_svn is important to find key in the map
  let (one_svn,one_val,(leftOpKeyStr,leftOpValStr)) = case one of
       ER_SymStateMapEntry svn val ->
         let theStr = case svn of
               VarName s -> (s,ppSymExpr_no_symType val)
               _         -> error $ "TODO1: " ++ show one_svn
         in (svn,val,theStr)
       ER_ArrayCallExpr s@(SArrayIndexAccess arrType arrName _) val ->
         --call = SArrayIndexAccess "strs" (SymInt 1)
         --val = SymNull String
         (VarName arrName,val,(ppSymExpr_no_symType s,ppSymExpr_no_symType val))
       ER_Expr ex -> error $ printf "%s: (%s,%s,%s)" loc
           (show expr) (show ex) (show $ AST.assEleft expr)
       _ -> error $ printf "TODO2: %s: %s" loc (show one)

  let two_val = case two of
          ER_Expr e2_@(SymArray mType1 mSize1 elms1) -> case one_val of
            SymVar (Array type2) _ ->
              let newType = pick_known_symType2
                    $ maybe UnknownGlobalVarSymType id mType1
                    : map toSymType2 elms1
                    ++ [type2]
              in cast (Array newType) e2_
            _ -> error $ printf "TODO3: %s ==> e2 ==> %s" loc (show one_val)
          ER_Expr e2_ -> cast (toSymType2 one_val) e2_
          ER_FunCall funCallState ->
            case getReturnSymExpr funCallState of
              Nothing -> error $ printf "%s ~~> won't happen" loc
              Just e2_ -> e2_
          ER_SymStateMapEntry _ e2_ -> e2_
          ER_PredefinedFunCall e2_ -> cast (toSymType2 one_val) e2_
          {-
          ER_ArrayCallExpr {
            arrayIndexCall = SArrayIndexAccess (Array Int) "arr" (SymInt 0),
            arrayIndexCallValue = SArrayIndexAccess (Array Int) "arr" (SymInt 0)
          }
           -}
          ER_ArrayCallExpr _ arrayCallVal ->
            let t = pick_known_symType (toSymType2 arrayCallVal, toSymType2 one_val)
            in cast t arrayCallVal
          ER_VarExprObjAccess _ e2_ -> e2_
          _ -> error $ printf "TODO4: %s ==> e2 ==> %s" loc (show two)

  tellNextLog $ Log.Affected loc [show one, show two]
  -- newVal is a transformation of two_val. it's the new value
  -- inside of newVal, casting is done
  two_newVal <- do
    varNames <- (getVarNames . env) <$> get
    case (one,two_val) of
      (ER_ArrayCallExpr (SArrayIndexAccess arrType arrName index) _,_) ->
        case Map.lookup (VarName arrName) varNames of
          Just (SymArray mt ml elems) -> case index of
            SymInt num ->
              let int = fromIntegral num
              in return $ SymArray mt ml (
                  take int elems ++
                  [cast (toSymType2 one_val) two_val] ++
                  drop (int+1) elems)
            _ -> error $ "TODO5: visitExpr ==> AssignExpr: " ++ show index
          Just e@(SymVar (Array t) arrName) ->
            let newType = pick_known_symType2 [arrType, toSymType2 e, toSymType2 two_val]
            in return $ cast newType e
          Just e@(SymUnknown _ _) ->
            let newType = pick_known_symType2 [arrType, toSymType2 e, toSymType2 two_val]
            in return $ cast newType e
          y -> error $ "TODO5: visitExpr ==> AssignExpr: " ++ show y
      (_,SymArray _ _ _) -> -- casting is done during the creation of two_val
        return two_val
      _ -> return $ cast (toSymType2 one_val) two_val
  let rightOpValStr = ppSymExpr_no_symType two_newVal
{-
two_newVal = SymArray (Just (Array Int)) (Just 2) [SymNull Int,SymNull Int]
-}
  -- this case-of sole purpose is creating Log.UpdateVariable
  case one_svn of
    VarName _ ->
      ((Map.lookup one_svn . env) <$> get) >>= \case
        Just oldVal
          | oldVal /= two_newVal -> do
              tellNextLog $ Log.UpdateVariable (show one_svn,show oldVal,show two_newVal) "visitExpr ==> AssignExpr"
              return ()
          | oldVal == two_newVal -> return ()
        Nothing -> do
          tellNextLog $ Log.UpdateVariable (show one_svn,"No previous value",show two_newVal) "visitExpr ==> AssignExpr"
          return ()
  -- inserting new value in map
  tellNextLog $ Log.ModifyState "visitExpr ==> AssignExpr" (leftOpKeyStr,rightOpValStr)
  modify $ \symState ->
    SymState {
      env = Map.insert one_svn two_newVal (env symState),
      logHeader = logHeader symState
    }
  
  -- Sometimes, the `two_newVal` of `one_svn` can tell us more about the type of `one_val`
  -- which may be unknown, while the type of `two_newVal` is more known.
  -- This happens mainly only when `one_val` is a global variable of unknown type
  -- example: both z and t are global variables mentioned for the first time
  --    z = t;
  --    z = 1;
  -- in the beginning, z and t are related to each other, however their type is unknown
  -- then the z = 1 tells us that z is numerical, which means t must be also marked
  -- as numerical.
  -- The following takes care of t in that context while z = 1 gets processed.
  -- one: the value of z before it gets updated to 1
  --s1 <- env <$> get
  incrementLogDepth *> inferGlobalVarType (toSymType2 two_newVal) one <* decrementLogDepth

  -- consider the AssignExpr:
  --   double x;
  --   x = c;
  -- c is a global variable, used for the first time in this assignment
  -- c is a double, and its VarName in the SymState need to be updated accordingly
  incrementLogEnumeration >>
    incrementLogDepth *> inferGlobalVarType (toSymType2 two_newVal) two <* decrementLogDepth
  
  let toReturn = ER_SymStateMapEntry one_svn two_val
  tellNextLog (Log.Return "visitExpr -> AssignExpr"
    (printf "%s\n\n%s was %s\n%s is %s" (show toReturn)
       leftOpKeyStr leftOpValStr
       leftOpKeyStr rightOpValStr)) $> toReturn

-- VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
visitExpr expr@AST.VarExpr{} = do
  tellNextLog $ Log.Expression_2_Handle (show expr) "visitExpr -> VarExpr"
  case AST.varObj expr of
    [] -> do
      let varName_ = AST.varName expr
      case AST.varType expr of
        Nothing -> do
          mVal <- (Map.!? VarName varName_) <$> env <$> get
          case mVal of
            Just val -> do
              tellNextLog $ Log.LookUpEnvTable varName_ (show val) "visitExpr -> VarExpr"
              let toReturn = ER_SymStateMapEntry (VarName varName_) val
              tellNextLog (Log.Return "visitExpr -> VarExpr -> Updating" (show toReturn)) $> toReturn
            Nothing -> do
              tellNextLog $ Log.GlobalVar varName_ "visitExpr -> VarExpr"
              let symExpr = SymVar UnknownGlobalVarSymType varName_
                  toReturn = ER_SymStateMapEntry (VarName varName_) symExpr
              tellNextLog $ Log.ModifyState "visitExpr -> VarExpr" (varName_,show symExpr)
              modify $ \symState -> SymState {
                env = Map.insert (VarName varName_) symExpr
                      $ recordGlobalVar varName_ (env symState),
                logHeader = logHeader symState
              }
              tellNextLog (Log.Return "visitExpr -> VarExpr -> Recording Global Variable" (show toReturn)) $> toReturn
        Just t -> do
          isActualParm <- env <$> get >>= \theEnv -> return $
            if hasFormalParameter varName_ theEnv
              then let Just x = Map.lookup (VarName varName_) theEnv
                   in Just x
              else Nothing
          case isActualParm of
            Just expr -> do
              tellNextLog $ Log.ActualParameterDetected (show t) varName_ (show expr) "visitExpr -> VarExpr"
              return $ ER_ActualParameterDetected varName_ expr
            Nothing -> do
              tellNextLog $ Log.NewVariable (show t) varName_ "visitExpr -> VarExpr"
              let sExpr = SymVar(toSymType1 t) varName_
              tellNextLog $ Log.ModifyState "visitExpr -> VarExpr" (varName_,show sExpr)
              modify $ \symState ->
                SymState {
                  env = Map.insert (VarName varName_) sExpr (env symState),
                  logHeader = logHeader symState
                }
              let toReturn = ER_SymStateMapEntry (VarName varName_) sExpr
              tellNextLog (Log.Return "visitExpr -> VarExpr -> Declaring Local Variable" (show toReturn)) $> toReturn
    li -> do
      stateEnv <- env <$> get
      let symExpr0@(SObjAcc exprs) = SObjAcc $ li ++ [AST.varName expr]
      let toReturn = ER_VarExprObjAccess (intercalate "." $ li ++ [AST.varName expr]) (objAccCalculator (getVarNames stateEnv) symExpr0)
      tellNextLog (Log.Return "visitExpr ==> VarExpr" (show toReturn)) $> toReturn

-- ArrayCallExpr {arrName :: Expression, index :: Maybe Expression}
{-
ArrayCallExpr {
  arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"},
  index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})
}
-}
visitExpr expr@AST.ArrayCallExpr{} = do
  let loc = "SymbolicExecution.Method.visitExpr.ArrayCallExpr"
  tellNextLog
    $ Log.Expression_2_Handle (show expr) loc
  -- Array name
  arrName <- do
    visited <- incrementLogEnumeration >>
      incrementLogDepth *>
        censor (map $ \(Log.Log str tag) -> Log.Log str $ Log.Nested ("calling array " ++ AST.getVarName expr) tag)
           (visitExpr $ AST.arrName expr)
        <* decrementLogDepth
    return $ case visited of
          ER_SymStateMapEntry (VarName arrName) _ -> arrName
          _ -> error $ printf "won't happen1: %s ==> %s" loc (show visited)
  index_er <- case AST.index expr of
    Nothing -> throwError $ "won't happen2 ==> " ++ loc
    Just expr_ -> do
      indexExpr <- do
        incrementLogEnumeration
        incrementLogDepth *>
          censor (map $ \(Log.Log str tag) -> Log.Log str
              $ Log.Nested ("at pos " ++ AST.ppExpr_no_type expr_) tag)
                 (visitExpr expr_)
            <* decrementLogDepth
      return $ case indexExpr of
        ER_SymStateMapEntry _ indexExpr2 -> indexExpr2
        ER_Expr indexExpr2 -> cast Int indexExpr2
        e -> error $ printf "TODO2: %s ==> %s" loc (show e)
  varNames <- (getVarNames . env) <$> get
  arrType <- do
    theEnv <- env <$> get
    case Map.lookup (VarName arrName) theEnv of
      Nothing -> throwError $ "won't happen3 ==> " ++ loc
      Just symExpr -> return $ toSymType2 symExpr
  let symExprCall = SArrayIndexAccess arrType arrName index_er
      symExprVal = objAccCalculator varNames symExprCall
      toReturn = ER_ArrayCallExpr symExprCall symExprVal
  tellNextLog (Log.Return loc (show toReturn)) $> toReturn

visitExpr expr@(AST.BoolLiteral b) = do
  tellNextLog $ Log.Expression_2_Handle (show expr) "visitExpr -> BoolLiteral"
  let toReturn = ER_Expr (SBool b)
  tellNextLog (Log.Return "visitExpr -> BoolLiteral" (show toReturn)) $> toReturn
--ExcpExpr {excpName :: Exception, excpmsg :: Maybe String}
visitExpr expr@AST.ExcpExpr{} = do
  let loc = "SymbolicExecution.Method.visitExpr.ExcpExpr"
  tellNextLog $ Log.Expression_2_Handle (show expr) loc
  tellNextLog $ Log.ModifyState loc ("Exception",show expr)
  -- get fun type
  funType <- do
    visited <- getFunHandle
    return $ case visited of
      ER_FunHandle funType _ -> funType
      _ -> error $ printf "won't happen1: %s ==> %s" loc (show visited)
  let symExpr = SException funType
        (case AST.excpName expr of
           AST.Exception str -> str
           _ -> error $ loc ++ " ==> won't happen")
        (case AST.excpmsg expr of
           Nothing -> ""
           Just str -> str)
  let toReturn = ER_Expr symExpr
  tellNextLog (Log.Return loc (show toReturn)) $> toReturn

visitExpr expr@AST.ArrayInstantiationExpr{} = do
  tellNextLog $ Log.Expression_2_Handle (show expr) "visitStmt -> ArrayInstantiationExpr"
  let mArrType = fmap toSymType1 $ AST.arrType expr
  -- process elements in the array, if they exist
  exprs <- do
    flip mapM (zip [0 :: Int ..] $ AST.arrElems expr) $ \(i,ex) -> do
      incrementLogEnumeration
      er <- incrementLogDepth *>
              censor (map $ \(Log.Log num tag) ->
                Log.Log num $ Log.Nested (printf "<arr>[%d]" i) tag)
                (visitExpr ex)
                              <* decrementLogDepth
      case (er,mArrType) of
        (ER_Expr expr2,Nothing) -> return $ expr2
        (ER_Expr expr2,Just t) -> return $ cast (arrayElementSymType t) expr2
        _ -> throwError $ "visitExpr ==> ArrayInstantiationExpr ==> 1: " ++ show er
  -- get array size
  (m_arr_size :: Maybe SymExpr) <- case (AST.arrSize expr,length exprs) of
        (Nothing,l) -> return $ Just $ SymInt $ fromIntegral l
        (Just ex,l)
          | l > 0 -> return $ Just $ SymInt $ fromIntegral l
          | otherwise -> do
              er <- do incrementLogEnumeration
                       incrementLogDepth *> visitExpr ex <* decrementLogDepth
              case er of
                ER_Expr (SymNum num) -> return $ Just $ SymInt (round num)
                ER_Expr expr@(SBin _ _ _) -> return $ Just expr
                ER_Expr s@(SymInt _) -> return $ Just s
                ER_SymStateMapEntry _ symExpr -> return $ Just symExpr
                _ -> throwError $ "visitExpr ==> ArrayInstantiationExpr ==> 2: " ++ show (expr,er)
        (Nothing,0) -> return Nothing
  -- potentially add nulls as elements if size is present, but no elements are present.
  let exprs_ = case (m_arr_size,exprs) of
        (Nothing,[]) -> []
        (Nothing,_) -> exprs
        (Just (SymInt num),[]) -> replicate (fromIntegral num) (SymNull $ maybe (error "visitExpr ==> ArrayInstantiationExpr ==> 3") arrayElementSymType mArrType)
        (Just num,_) -> exprs

  let symExpr = SymArray
        (fmap arrayElementSymType mArrType)
        m_arr_size
        exprs_

  let toReturn = ER_Expr symExpr
  tellNextLog (Log.Return "SymbolicExecution.Method.visitExpr.ArrayInstantiationExpr" (show toReturn)) $> toReturn

visitExpr expr@AST.Null = do
  let loc = "SymbolicExecution.Method.visitExpr"
  tellNextLog $ Log.Expression_2_Handle (show expr) loc
  let toReturn = ER_Expr $ SymNull UnknownGlobalVarSymType
  tellNextLog (Log.Return loc (show toReturn)) $> toReturn
visitExpr expr = error $ "TODO: visitExpr ==> What this is: " ++ show expr

------------------------------

visitLoop :: CFGT.CFG -> Maybe CFGT.Node -> Maybe AST.Expression -> [CFGT.Node] -> CFGT.ScopeRange -> SymbolicExecutionMonad ExecutionResult
visitLoop cfg m_Acc mForCondExpr forBody_forStep_path branchRange = do
  let loc = "SymbolicExecution.Method.visitLoop"
  tellNextLog (Log.Location "SymbolicExecution.Method.visitLoop")
  env_Before_Acc <- env <$> get
  let prependLogs :: String -> [Log.Log] -> [Log.Log]
      prependLogs newLogTagStr = map (\(Log.Log innerCounterStr logTag) ->
        Log.Log innerCounterStr $ Log.Nested newLogTagStr logTag)
  (hasAcc,env_With_Acc) <- do
    case m_Acc of
      Nothing -> ((,) False . env) <$> get
      Just acc -> do
        tellNextLog (Log.HorizontalLine "For Accumulator")
        incrementLogDepth *>
          censor (prependLogs "For Accumulator") (methodProcessorMonad $ visitNode acc)
                           <* decrementLogDepth
        ((,) True . env) <$> get
  (hasCond,forCondExpr_visited) <- case mForCondExpr of
    Nothing -> return (False,SBool True)
    Just forCondExpr -> do
       tellNextLog (Log.HorizontalLine "For Cond")
       if hasAcc
         then incrementLogEnumeration $> ()
         else return ()
       re <- incrementLogDepth *>
         censor (prependLogs "For Loop Condition") (visitExpr forCondExpr)
                          <* decrementLogDepth
       return $ (,) True $ case re of
         ER_Expr forCondExpr_visited -> forCondExpr_visited
         _ -> error $ printf "won't happen1: %s ==> %s" loc (show re)
  
  case forCondExpr_visited of
    -- visit for loop body
    SBool True -> do
      forLoopVisited <- visitRegisteredLoop 1 env_Before_Acc cfg m_Acc mForCondExpr forBody_forStep_path branchRange
      case forLoopVisited of
        -- for visitation was completed
        ER_ForLoopDone -> do
          -- After leaving the for body,
          -- variables which were defined locally need to be removed
          newEnv <- env <$> get
              -- `varnames_to_delete`: collect varnames in `newEnv` which are not present in env_Before_Acc
          let varnames_to_delete :: [String]
              varnames_to_delete = Map.foldlWithKey' (\acc k _ -> case k of
                VarName vn
                  | Map.notMember k env_Before_Acc -> acc ++ [vn]
                _ -> acc
                  ) [] newEnv
              -- `newEnv2`:
              --     1) delete all `varnames_to_delete` mentioned in `newEnv`
              --     2) delete `varnames_to_delete` mentioned in VarBindings in `newEnv`
              --     3) delete `varnames_to_delete` mentioned in VarAssignments in `newEnv`
              newEnv2 = Map.foldMapWithKey (\case
                k@(VarName vn)
                  | vn `notElem` varnames_to_delete -> Map.singleton k
                  | otherwise -> const Map.empty
                k@VarBindings -> \case
                  SVarBindings li -> Map.singleton k $ SVarBindings
                    $ flip Map.filterWithKey li $
                      (const . (`notElem` varnames_to_delete))
                  x -> error $ printf "%s: won't happen2: %s" loc (show x)
                k@VarAssignments -> \case
                  SVarAssignments li -> Map.singleton k $ SVarAssignments
                    $ filter ((`notElem` varnames_to_delete) . fst) li
                  x -> error $ printf "%s: won't happen3: %s" loc (show x)
                k -> Map.singleton k) newEnv
          tellNextLog $ Log.ModifyState loc ("deleting",show varnames_to_delete)
          modify $ \symState -> SymState {
            env = newEnv2,
            logHeader = logHeader symState
            }
          return ER_ForLoopDone
        -- `ER_SymStateMapEntry` is returned when the for loop is too big
        -- then `visitRegisteredLoop` leads to `visitUnregisteredLoop`
        ER_SymStateMapEntry _ _ -> return forLoopVisited
    -- for loop condition was not met
    SBool False -> do
      tellNextLog $ Log.ForLoopDone "visitRegisteredLoop"
      modify $ \symState -> SymState env_Before_Acc (logHeader symState)
      return ER_ForLoopDone
    _ -> do modify $ \symState -> SymState env_Before_Acc (logHeader symState)
            visitUnregisteredLoop cfg m_Acc mForCondExpr forBody_forStep_path branchRange

------------------------------

visitRegisteredLoop :: Int -> Map.Map SymStateKey SymExpr -> CFGT.CFG -> Maybe CFGT.Node -> Maybe AST.Expression -> [CFGT.Node] -> CFGT.ScopeRange -> SymbolicExecutionMonad ExecutionResult
visitRegisteredLoop loopCounter env_Before_Acc cfg m_Acc mForCondExpr forBody_forStep_path branchRange = do
  let loc = "SymbolicExecution.Method.visitRegisteredLoop"
  tellNextLog $ Log.Location loc
  -- whether there's a loop condition
  forCondExpr_visited <- case mForCondExpr of
    Nothing -> return $ SBool True
    Just forCondExpr -> do
      incrementLogDepth
      res <- censor (map $ \(Log.Log num tag) ->
               Log.Log num $ Log.Nested "For Loop Condition" tag)
                    (visitExpr forCondExpr)
      decrementLogDepth
      return $ case res of
        ER_Expr forCondExpr_visited -> forCondExpr_visited
        _ -> error $ printf "won't happen1: %s ==> %s" loc (show res)

  -- whether the loop condition is atomic
  case forCondExpr_visited of
    -- it's atomic, and do a round
    SBool True -> do
      forLoopLimit <- iterationMaxBound . fst <$> ask
      if forLoopLimit >= loopCounter
        then do
          tellNextLog $ Log.ForLoopRound loopCounter "visitRegisteredLoop"
          -- add the loop condition entry:
          --loopConditionEntry :: Map.Map String SymExpr
          loopConditionEntry <- do
            incrementLogEnumeration
            incrementLogDepth *>
              censor
                (map $ \(Log.Log num tag) -> Log.Log num $ Log.Nested "Atomizing For Loop Condition Expression" tag)
                (createLoopCondition (maybe undefined id mForCondExpr))
              <* decrementLogDepth
              
          newEnv <- Map.alter (\case
            Nothing -> Just
              $ SLoopConditions [loopConditionEntry]
            Just (SLoopConditions li) -> Just
              $ SLoopConditions $ li ++ [loopConditionEntry])
            (LoopConditions branchRange) . env <$> get
          modify $ \symState -> SymState newEnv (logHeader symState)
          -- tell the created loop condition entries:
          do theEnv <- env <$> get
             case Map.lookup (LoopConditions branchRange) theEnv of
               Nothing -> throwError $ printf "%s ==> won't happen2" loc
               Just (SLoopConditions mas) ->
                 tellNextLog $ Log.AtomizeRoundLoopCondition loc
                               (show $ Map.toList $ mas !! (loopCounter - 1))
          -- visit for body nodes
          flip mapM_ forBody_forStep_path $ \node -> do
            incrementLogDepth
            censor (map (\(Log.Log num tag) ->
              Log.Log num $ Log.Nested "For Loop Body" $ Log.Nested "Registering" tag))
              (methodProcessorMonad (visitNode node))
            decrementLogDepth
          -- it's a good idea to log the current state before staring the next loop round
          get >>= tellNextLog . Log.ReportTheState loc . show . env
          visitRegisteredLoop (loopCounter+1) env_Before_Acc cfg m_Acc mForCondExpr forBody_forStep_path branchRange
        else do
          tellNextLog $ Log.ForLoopLimitReached loc (show forLoopLimit)
          theEnv <- env <$> get
          tellNextLog $ Log.Skip loc $ printf "The following state will be ignored due to the limit set for for loop: %d:\n%s" forLoopLimit (show theEnv)
        -- restore symState to `env_Before_Acc`
          do
            tellNextLog $ Log.ModifyState "visitRegisteredLoop" ("Undo SymState to before the loop",show env_Before_Acc)
            modify $ \symState -> SymState env_Before_Acc (logHeader symState)
        
          er <- visitUnregisteredLoop cfg m_Acc mForCondExpr forBody_forStep_path branchRange
          -- add entry to SymState to report about the reached limit loop failure
          do
            tellNextLog $ Log.ModifyState "visitRegisteredLoop" ("LoopFailure",show $ SLoopFailure branchRange forLoopLimit)
            modify $ \symState -> SymState
              (Map.insert LoopFailure (SLoopFailure branchRange forLoopLimit) (env symState))
              (logHeader symState)
          return er
    -- it's atomic, and terminate
    SBool False -> do
      tellNextLog $ Log.ForLoopDone loc
      get >>= \theEnv -> tellNextLog $ Log.ReportTheState loc (show theEnv)
      return ER_ForLoopDone
   -- it's not atomic
    _ -> throwError $ printf "%s ==> won't happen3" loc
         {-
         do tellNextLog $ Log.ForLoopConditionUndetermined "visitRegisteredLoop" (show forCondExpr_visited)
            -- restore symState to that or `env_Before_Acc`
            modify $ \symState -> SymState env_Before_Acc (logHeader symState)
            visitUnregisteredLoop cfg m_Acc mForCondExpr forBody_forStep_path branchRange-}

------------------------------

createLoopCondition :: AST.Expression -> SymbolicExecutionMonad (Map.Map String SymExpr)
createLoopCondition expr = do
  let loc = "SymbolicExecution.Internal.createLoopCondition"
  -- `stateBefore` will only be used to restore the state to its previous state in case
  -- it was updated due to visitation of expressions
  stateBefore <- get
  case expr of
    AST.BinOpExpr{} -> do
      map1 <- createLoopCondition (AST.expr1 expr)
      map2 <- createLoopCondition (AST.expr2 expr)
      return $ Map.union map1 map2
  --VarExpr {varType = Nothing, varObj = [], varName = "i"}
    AST.VarExpr{}
      | null (AST.varObj expr) -> let
          varName = AST.varName expr
          in case Map.lookup (VarName $ AST.varName expr) (env stateBefore) of
               Just symExpr -> return $ Map.singleton varName symExpr
               Nothing -> throwError $ printf "%s ==> won't happen" loc
      -- it's a method call:
      | otherwise -> do
          -- We don't care about the logs, therefore `filter (const False)`
          -- And we need to restore the state in case it was edited, therefore `put origState`
          er <- do
            origState <- get
            censor (filter $ const False) (visitExpr expr) <* put origState
          case er of
            ER_VarExprObjAccess name value -> return
              $ Map.singleton name value
            _ -> throwError
              $ printf "%s ==> TODO1: %s ==>\n\n%s" loc (show expr) (show er)
   {-ER_PredefinedFunCall val -> return
       $ Map.singleton (intercalate "." $ AST.varObj expr ++ [AST.varName expr]) val
     ER_FunCall funCallSymState -> throwError
       $ printf "%s ==> TODO: %s" loc (show expr)-}
    AST.NumberLiteral _ -> return $ Map.empty
    _ -> throwError $ printf "%s ==> TODO: %s" loc (show expr)

------------------------------

visitUnregisteredLoop :: CFGT.CFG -> Maybe CFGT.Node -> Maybe AST.Expression -> [CFGT.Node] -> CFGT.ScopeRange -> SymbolicExecutionMonad ExecutionResult
visitUnregisteredLoop cfg m_Acc mForCondExpr forBody_forStep_path branchRange = do
    let loc = "SymbolicExecution.Method.visitUnregisteredLoop"
    tellNextLog $ Log.UnvisitedForLoop "visitUnregisteredLoop" (show mForCondExpr)
    (_,cfgs) <- ask
    let path = maybe [] (\acc -> [acc]) m_Acc
               ++ (flip mapMaybe forBody_forStep_path $ \node -> case CFGT.nodeData node of
                     CFGT.ForStep _ -> CFG.convert node
                     _ -> Just node)
    originalState <- get
    let (forBodyLogs,forBodySymState) = let
          (er,forBodyLogs,forBodySymState) = runCFG cfgs cfg (Just path)
            (Just $ SymState (env originalState) (Log.Header 1 [0]))
          in case er of
               "" -> (forBodyLogs,forBodySymState)
               _  -> error $ printf "%s ==> error in for body runner ==> %s" loc er
    -- record unregistered logs
    flip mapM_ forBodyLogs $ \log -> do
      Log.Header _ baseCounter <- logHeader <$> get
      tellNextNestedLog baseCounter ["For Loop Body","Unregistered"] log
{-
Seien
  1) env originalState
  2) forBodySymState
------------------------------
* Lets: a) GlobalVars from 2)
        b) VarAssignments from 2) which have
            GlobalVar
            any VarBinding from 1)
            FormalParm from 1)
        c) VarNames in 2) with
            with GlobalVars
            with VarNames mentioned in 1)
------------------------------
d) take GlobalVars from 2) and add them to 1)
e) ignore FormalParms and VarBindings in 2)
f) take every VarAssignment from 2) which concerns
      * any GlobalVar
      * and any VarBinding from 1)
      * and FormalParm from 1)
g) check VarNames in 2)
      * observe and take only VarNames which concern GlobalVars and VarNames mentioned in 1)
      * and make them SymUnknown only if for the VarNames whose values in 2) are different from their values in 1)
      * VarNames of GlobalVars in 2) may not be mentioned in 1). That is fine, take them too.
h) if there are GlobalVars that are mentioned for the first time in 2) and have no VarName
  then create VarName for them in 1) (Siehe dazu "c")
 -}
        -- GlobalVars from `originalState`
    let originalGlobalVars = maybe [] (\case
            SGlobalVars li -> li
            val -> error $ "visitUnregisteredLoop ==> won't happen 1 ==> " ++ show val)
            $ Map.lookup GlobalVars (env originalState) 
        -- VarBindings from `originalState`
        originalVarBindings = maybe [] (\case
            SVarBindings m -> Map.keys m
            val -> error $ "visitUnregisteredLoop ==> won't happen 2 ==> " ++ show val)
            $ Map.lookup VarBindings (env originalState)
        -- FormalParms from `originalState`
        originalFormalParms = maybe [] (\case
            SFormalParms li -> li
            val -> error $ "visitUnregisteredLoop ==> won't happen 3 ==> " ++ show val)
            $ Map.lookup FormalParms (env originalState)
        -- VarNames from `originalState`
        originalVarNames = flip Map.filterWithKey (env originalState) $ \k _ ->
          case k of VarName _ -> True
                    _         -> False
        -- in the for condition, GlobalVars may be present.
        -- this function delivers them if they exist
        condNode_globalVars :: [String]
        condNode_globalVars =
          let from_acc :: Maybe String
              from_acc = do
                acc <- m_Acc
                if CFG.isNewlyDeclaredNode acc
                  then Just $ CFG.getVarName acc
                  else Nothing
              from_cond :: [String]
              from_cond =
                flip (maybe []) mForCondExpr $ \forCondExpr -> do
                  vr <- AST.getVarNames forCondExpr :: [String]
                  let predicates
                        | vr == "length" = []
                        | isGlobalVariable2 vr (env forBodySymState) = [vr]
                        | otherwise = []
                  -- reject every vr that is same as from_acc
                  case from_acc of
                    Just acc_varName
                      | acc_varName == vr -> []
                      | otherwise -> predicates
                    Nothing -> predicates
          in from_cond
        -- a) GlobalVars from `forBodySymState`
        forBodyGlobalVars = nub $ condNode_globalVars ++ (flip (maybe [])
          (Map.lookup GlobalVars (env forBodySymState)) $ \case
             SGlobalVars li -> li
             val -> error $ "visitUnregisteredLoop ==> won't happen 4 ==> " ++ show val)
        -- b) VarAssignments from `forBodySymState` which have
        --        (GlobalVar,
        --         any VarBinding from `originalState`,
        --         any FormalParm from `originalState`)
        forBody_Some_VarAssignments = flip (maybe [])
          (Map.lookup VarAssignments (env forBodySymState)) $ \case
            SVarAssignments li -> flip filter li $ \(str,coor) ->
                str `elem` originalGlobalVars ||
                str `elem` forBodyGlobalVars ||
                str `elem` originalVarBindings ||
                str `elem` originalFormalParms
            val -> error $ "visitUnregisteredLoop ==> won't happen 5 ==> " ++ show val
        -- c) VarNames in `forBodySymState` with
        --        (GlobalVars,
        --         VarNames mentioned in `originalState`)
        forBody_Some_VarNames = flip Map.filterWithKey (env forBodySymState) $ \k _ ->
            case k of
              VarName vn
                | vn `elem` originalGlobalVars ||
                  vn `elem` forBodyGlobalVars  ||
                  VarName vn `Map.member` originalVarNames -> True
              _ -> False
        -- d) add `forBodyGlobalVars` to `env originalState`
        map_withGlobalVars = Map.alter (\case
          Nothing -> Just $ SGlobalVars forBodyGlobalVars
          Just (SGlobalVars _) -> Just $ SGlobalVars forBodyGlobalVars)
          GlobalVars (env originalState)
        -- f) add `forBody_Some_VarAssignments` to `map_withGlobalVars`
        map_withVarAssignments = Map.alter (\case
          Nothing -> Just $ SVarAssignments forBody_Some_VarAssignments
          Just (SVarAssignments _) -> Just $ SVarAssignments forBody_Some_VarAssignments)
          VarAssignments map_withGlobalVars
        -- g), h) VarNames in the forbody (see `branchRange`) mentioned in `forBody_Some_VarNames`
        --    need to be SymUnknown, then add them to `map_withVarAssignments`
        map_withVarNames = Map.foldlWithKey' (\ma key val -> case key of
          VarName vn ->
            let vn_forbody_varAssigns = flip filter forBody_Some_VarAssignments $
                  \(vn2,(_,node_coor)) ->
                      vn2 == vn &&
                      CFGT.varDeclAt node_coor >= CFGT.branchStart branchRange &&
                      CFGT.varDeclAt node_coor <= CFGT.branchEnd branchRange
                node_coors = map (snd . snd) vn_forbody_varAssigns
            in case vn_forbody_varAssigns of
                 [] -> ma
                 _ -> Map.alter (\case
                   ---createSymReason :: (CFGT.Kind,CFGT.ScopeRange) -> CFGT.CFG -> [CFGT.Node_Coor] -> [SymReason]
                   Nothing -> Just $ SymUnknown (SymVar (toSymType2 val) vn)
                     $ createSymReason (CFGT.For,branchRange) cfg node_coors
                   ---
                   Just (SymUnknown tu reasons) -> Just $ SymUnknown tu
                     $ reasons ++ createSymReason (CFGT.For,branchRange) cfg node_coors
                   ---
                   Just oldVal
                     -- if the reassignment inside the for body doesn't change the value
                     -- then there's no point in making it SymUnknown
                     -- Example (look at `res`):
                     {-
                       int res = 0;
                       for(int i=n; i>0; i--) {
                         res += i;
                         res = 0;
                       }
                      -}
                     | oldVal == val -> Just oldVal
                     | otherwise ->  Just $ SymUnknown (
                     cast (pick_known_symType (toSymType2 oldVal,toSymType2 val)) oldVal) $ createSymReason (CFGT.For,branchRange) cfg node_coors 
                   ) (VarName vn) ma
            ) map_withVarAssignments forBody_Some_VarNames

    let symExpr = SLoop m_Acc mForCondExpr forBody_forStep_path
        toReturn = ER_SymStateMapEntry (ScopeRange branchRange) symExpr
    tellNextLog $ Log.ModifyState "visitUnregisteredLoop" (show branchRange,show symExpr)
    modify $ \symState -> SymState {
      env = Map.insert (ScopeRange branchRange) symExpr map_withVarNames,
      logHeader = logHeader symState
      }
    tellNextLog (Log.Return "visitUnregisteredLoop" (show toReturn)) $> toReturn

------------------------------

type Path = [CFGT.Node]
runCFG :: [CFGT.CFG] -> CFGT.CFG -> Maybe Path -> Maybe SymState -> (String,[Log.Log],SymState)
runCFG cfgs cfg mPath mSymState =
  let loc = "SymbolicExecution.Method.runCFG"
      path :: [CFGT.Node]
      path = maybe (CFG.getPath 0 cfg) id mPath
      runner :: SymbolicExecutionMonad ()
      runner = flip mapM_ path $ \node -> do
        tellNextLog $ Log.NextNode (show node)
        state_ <- get
        case getReturnSymExpr state_ of
          Just _ -> tellNextLog (Log.Skip loc ("The following node doesn't return a SymExpr: " ++ show node))
                      $> ER_Void
          Nothing ->
            incrementLogDepth *> methodProcessorMonad (visitNode node) <* decrementLogDepth
      (methodNameKey,methodNameValue) =
        (MethodHandle , 
         (toSymType1 $ CFG.getCFGType cfg,CFG.getCFGName cfg))
      initialSymState = maybe
          (SymState Map.empty $ Log.Header 1 [0])
          id mSymState
      
      run_e :: ReaderT (Config,[CFGT.CFG]) (WriterT [Log.Log] (State SymState)) (Either String ())
      run_e = runExceptT runner
      
      run_r :: WriterT [Log.Log] (State SymState) (Either String ())
      run_r = runReaderT run_e (defaultConfig,cfgs)
      
      run_w :: State SymState ((Either String ()),[Log.Log])
      run_w = runWriterT run_r
      
      run_s :: ((Either String (),[Log.Log]),SymState)
      run_s@((er,logs),s) = runState run_w initialSymState
      
  in (either id (const "") er,logs,s)
