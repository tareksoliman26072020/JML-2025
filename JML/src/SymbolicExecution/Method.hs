{-# Language LambdaCase #-}
module SymbolicExecution.Method where

import qualified SymbolicExecution.Logs.Log as Log
import SymbolicExecution.Types
import qualified CFG.Types as CFGT
import qualified CFG.Internal as CFG
import qualified Data.Map as Map
import Data.Maybe (mapMaybe)
import Control.Monad.Reader (runReaderT,ask)
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

instance CFGVisitor Method_SymExec where
--visitNode :: CFGT.Node -> Method_SymExec
  visitNode node = Method_SymExec $ tell [Log.HorizontalLine "visitNode"] >> case node of
    CFGT.Entry t mn args -> do
      tell [Log.MethodStart mn "visitNode -> Entry"]
      let (methodNameKey,methodNameValue) =
              (MethodName mn,
               SMethodType $ toSymType1 t)
      tell [Log.FunHandle "visitNode -> Entry" mn (show methodNameValue)]
      tell [Log.ModifyState "visitNode -> Entry" (mn,show methodNameValue)]
      modify $ \symState -> SymState {
        env = Map.insert methodNameKey methodNameValue $ env symState,
        pc = pc symState  
      }
      case null args of
        True  -> tell [Log.Return "visitNode -> Entry -> method with no args" "()"] $> ()
        False -> do
          tell [Log.MethodFormalParams (show args) "visitNode -> Entry -> method with args"]
          mapM_ (\arg -> do
                   argVisited <- visitExpr arg
                   case argVisited of
                     ER_SymStateMapEntry (VarName name) val@(SymVar _ _) -> do
                       alreadyExist <- env <$> get >>= return . Map.lookup (VarName name)
                       case alreadyExist of
                         Nothing -> throwError "TODO: visitNode -> Entry"
                         Just (SymVar _ _) -> do
                           tell [Log.ModifyState "visitNode -> Entry -> arg" (name,show val)]
                           modify $ \symState -> SymState {
                               env = recordFormalParm name $ Map.insert (VarName name) val (env symState),
                               pc = pc symState
                           }
                         Just _ -> return ()
                     ER_ActualParameterDetected -> return ()
                     _ -> throwError $ "visitNode ==> Entry ==> won't happen ==> " ++ show argVisited
               ) args
      toReturn <- ER_State <$> get
      tell [Log.Return "visitNode -> Entry -> method has args" (show toReturn)] $> toReturn
    ----------------------------------------
    ----------------------------------------
    ----------------------------------------
    n@CFGT.End{} -> do
      tell [Log.MethodEnd "visitNode -> End"]
      case CFGT.mExpr n of
        Nothing       -> do
          tell [Log.Void "visitNode -> End -> return nothing"]
          toReturn <- ER_State <$> get
          tell [Log.Return "visitNode -> End -> void method" (show toReturn)] $> toReturn
        a@(Just expr) -> do
          tell [Log.ReturnStatement (show expr) "visitNode -> End -> return something"]
          toReturn <- visitStmt (AST.ReturnStmt a)
          tell [Log.Return "visitNode -> End -> method returns" (show toReturn)] $> toReturn
    ----------------------------------------
    ----------------------------------------
    ----------------------------------------
    n@CFGT.Node{} -> case CFGT.nodeData n of
      CFGT.Statement stmt -> do
        tell [Log.MethodStatement "visitNode -> case nodeData of Node -> Statement" (show stmt)]
        toReturn <- visitStmt stmt
        ER_FunHandle _ funName <- getFunHandle
        (_,cfgs) <- ask
        let cfg = case CFG.findCFGByName funName cfgs of
              -- CFG not found
              Nothing   -> error $ "visitNode -> Node -> Sattement " ++ funName ++ " does not exist"
                    -- CFG found
              Just cfg0 -> cfg0
        let newVarCoor = CFGT.Node_Coor {
              CFGT.varDeclAt = CFGT.id n,
              CFGT.varFrame =
                let bStart = CFGT.parent n
                in CFGT.SR bStart $ CFG.getBranchEnd bStart cfg
            }
        case getNewVarBinding newVarCoor stmt of
          Just new -> do          
            old <- getVarBindings <$> get
            tell [Log.AddVarBinding "visitNode -> Node -> Statement" (show new)]
            modify $ \state ->
              SymState {
                env = Map.insert VarBindings (SVarBindings $ Map.insert (fst new) (snd new) old) (env state),
                pc = pc state
              }
            return ER_Void
          _ -> return ER_Void
        case getNewVarAssignment newVarCoor stmt of
          Just new -> do
            tell [Log.AddVarAssignment "visitNode -> Node -> Statement" (show new)]
            state_map <- env <$> get
            let varAssignmentsList = case Map.lookup VarAssignments state_map of
                  Nothing -> []
                  Just (SVarAssignments li) -> li
            modify $ \s ->
              SymState {
                env = Map.insert VarAssignments (SVarAssignments $ varAssignmentsList ++ [new]) (env s),
                pc = pc s
              }
            return ER_Void
            -- Just ("y",Node_Coor {varDeclAt = 2, varFrame = 1})
          _ -> return ER_Void
        tell [Log.Return "visitNode -> Node -> Statement" (show toReturn)] $> toReturn
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      -- BooleanExpression Kind AST.Expression
      CFGT.BooleanExpression CFGT.If Nothing ->
        throwError "visitNode ==> case nodeData of Node ==> BooleanExpression If ==> won't happen"
      CFGT.BooleanExpression CFGT.If (Just expr) -> do
        tell [Log.MethodStatementIfCondition (printf "visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: %d" (CFGT.id n)) (show expr)]
        ER_FunHandle _ funName <- getFunHandle
        (_,cfgs) <- ask
        let cfg = case CFG.findCFGByName funName cfgs of
                    -- CFG not found
                    Nothing   -> error $ "visitNode -> Node -> BooleanExpression " ++ funName ++ " does not exist"
                    -- CFG found
                    Just cfg0 -> cfg0
            -- branches: start id for the if branch, and the else branch if it exists.
            --           return is a list of one or two ints.
            --           if there is no else branch, then the list has only one int.
            branches = case CFG.findEdge_via_id cfg (CFGT.id n) of
                      Just (_,xs) -> xs
                      Nothing     -> error $ "visitNode -> Node -> BooleanExpression if -> won't happen1"
        let branches_paths :: [[CFGT.Node]]
            branches_paths = filter (not . null) $ flip map branches $ \branchStartId ->
              let thePath = CFG.getPath branchStartId cfg
              in flip takeWhile thePath $ \case
                   CFGT.Node _ (CFGT.Meet CFGT.If) _ -> False
                   _                                 -> True
        
        ER_Expr expr2 <- visitExpr expr
        state <- get
        let mainActions = getActions state
        let mainVarAssignments = getVarAssignments state
        
        toReturn <- case expr2 of
              SBool b -> do
                case branches_paths of
                  [ifB] | b -> do
                    let (logs,condSymState) = runCFG cfgs cfg (Just ifB) (Just state)
                    flip mapM_ logs $ \log ->
                      tell [Log.Nested "if statement" log]
                    -- remove vars declared in that scope
                    -- use vars bindings to do so
                    let s = removeDeletedVars state condSymState
                    let newCondSymState = SymState {
                          env =
                            let addActions = Map.alter (\case
                                  Nothing -> Just $ SActions mainActions
                                  Just (SActions li) -> Just
                                    $ SActions $ mainActions ++ li) Actions
                                    $ env s
                                deleteVarAssignments = Map.alter (\case
                                  Nothing -> Nothing
                                  Just (SVarAssignments li) -> Just $ SVarAssignments
                                    $ flip filter li
                                      $ \(name,_) ->
                                          isGlobalVariable2 name addActions ||
                                          maybe False (const True)
                                           (lookup name mainVarAssignments)
                                  ) VarAssignments addActions
                            in deleteVarAssignments,
                          pc = pc s
                        }
                    tell [Log.ModifyState (printf "visitNode -> Node -> BooleanExpression if -> overwriting if") ("<new state>",show newCondSymState)]
                    modify (const newCondSymState)
                    return $ ER_State newCondSymState
                  [ifB] | not b -> do
                    tell [Log.NoElseBranch "visitNode -> Node -> BooleanExpression if"]
                    return $ ER_Void
                  [ifB,elseB] -> do
                    let (logs,condSymState) = runCFG cfgs cfg (Just $ if b then ifB else elseB) (Just state)
                    flip mapM_ logs $ \log ->
                      tell [Log.Nested (printf "%s statement" $ if b then "if" else "else") log]
                    -- remove vars declared in that scope
                    -- use vars bindings to do so
                    let s = removeDeletedVars state condSymState
                    let newCondSymState = SymState {
                          env =
                            let addActions = Map.alter (\case
                                  Nothing -> Just $ SActions mainActions
                                  Just (SActions li) -> Just
                                      $ SActions $ mainActions ++ li) Actions
                                      $ env s
                                deleteVarAssignments = Map.alter (\case
                                  Nothing -> Nothing
                                  Just (SVarAssignments li) -> Just $ SVarAssignments
                                    $ flip filter li
                                      $ \(name,_) ->
                                          isGlobalVariable2 name addActions ||
                                          maybe False (const True)
                                           (lookup name mainVarAssignments)
                                  ) VarAssignments
                                      addActions
                            in deleteVarAssignments,
                          pc = pc s
                        }
                    tell [Log.ModifyState (printf "visitNode -> Node -> BooleanExpression if -> overwriting %s" $ if b then "if" else "else") ("<new state>",show newCondSymState)]
                    modify (const newCondSymState)
                    return $ ER_State newCondSymState
              SBin _ _ _ -> do
                let (ifLogs,ifSymState) = runCFG cfgs cfg (Just $ branches_paths !! 0) (Just state)
                flip mapM_ ifLogs $ \log ->
                  tell [Log.Nested "if statement" log]
                -- symExpr is the SIte with the two conditional states
                symExpr@(SIte ifCond ifSymState mElseSymState) <- case branches_paths of
                  [_] -> return $ SIte expr2 ifSymState Nothing
                  [_,pElse] -> do
                    let (elseLogs,elseSymState) = runCFG cfgs cfg (Just pElse) (Just state)
                    flip mapM_ elseLogs $ \log ->
                      tell [Log.Nested "else statement" log]
                    return $ SIte expr2 ifSymState (Just elseSymState)
                -- condVarAssignments gives me
                -- 1) the VarAssignments in the if/else branch,
                --    which were originally defined outside of them
                -- 2) the VarAssignments of global variables
                let condVarAssignments s = flip filter (getVarAssignments s) $
                      \(name,_) -> maybe
                          (isGlobalVariable2 name (env s))
                          (const True) $ lookup name mainVarAssignments
                    newMainVarAssignments = nub $
                        condVarAssignments ifSymState ++
                        maybe [] condVarAssignments mElseSymState
                    newMainGlobalVars = nub $
                        filter (\vn -> isGlobalVariable2 vn (env state)) (getVarNames2 ifCond)
                        ++ getGlobalVars (env ifSymState)
                        ++ maybe [] (getGlobalVars . env) mElseSymState
                tell [Log.ModifyState "visitNode -> Node -> BooleanExpression if -> recording symbolic branching" (printf "if node num: %d" (CFGT.id n),show symExpr)]
                modify $ \symState ->
                  let condBranchRange = CFGT.SR {
                        CFGT.branchStart = CFGT.id n,
                        CFGT.branchEnd = CFG.getBranchEnd (CFGT.id n) cfg
                      }
                      -- `s1` has the new conditional branchs (addNode)
                      --  and has the new VarAssignments from the conditional branches
                      ma1 =
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
                        (_,CFGT.Node_Coor _ frameCoor) ->
                          CFGT.branchStart frameCoor == CFGT.branchStart condBranchRange
                      -- will be used in ma2
                      -- gets SymType of `varAssName`,
                      -- which is the one of the vars mentioned in `unknownVarAssigns`
                      getUnknownVarSymType_in_if_template varAssName =
                        let seeking = asum $ map (getVarNameSymType varAssName)
                              $ env ifSymState : maybe [] ((: []) . env) mElseSymState
                        in case seeking of
                             Nothing -> error $ "visitNode -> Node -> BooleanExpression if -> won't happen2"
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
                      ma2 = foldl' (\ma (varAssName,coor) ->
                        Map.alter (\case
                          Nothing -> Just $ SymUnknown (
                            getUnknownVarSymType_in_if_template varAssName,
                            varAssName,
                            Nothing) $ newReason_template [coor]
                          Just (SymUnknown (t,n,v) oldReasons) -> Just $
                            SymUnknown
                              (pick_known_symType (
                                  t,
                                  (getUnknownVarSymType_in_if_template varAssName)),
                              n,v)
                            $ oldReasons ++ newReason_template [coor]
                          Just val -> Just $ SymUnknown (
                            pick_known_symType (
                              toSymType2 val,
                              (getUnknownVarSymType_in_if_template varAssName)),
                            varAssName,Just val)
                            $ newReason_template [coor]) (VarName varAssName) ma)
                            ma1 unknownVarAssigns
                  
                  in SymState {
                    env = ma2,
                    pc = pc symState
                  }
                -- the branching for the if and else
                -- may provide more concrete informations about
                -- global VarNames in the main branch
                --
                -- Extract types of global VarNames from the if and else branches
                -- and use them to cast the global VarNames in the main branch
                -- symExpr@(SIte ifCond ifSymState mElseSymState)
                -- varNameSymExprs :: [(String,[SymExpr])]
                varNameSymExprs <- getScopedGlobalVarsSymExprs symExpr
                -- `varNameSymExprs` provides all needed info for the most concrete type
                -- of all global variables available at this point
                -- record it:
                modify $ \symState -> SymState {
                  env = flip Map.mapWithKey (env symState) $ \k v -> case k of
                    VarName vn -> case lookup vn varNameSymExprs of
                      Nothing -> v
                      Just symExprs ->
                        let newType = pick_known_symType2
                              $ map toSymType2
                              $ v : symExprs
                        in cast newType v
                    _ -> v,
                  pc = pc symState
                }
                return (ER_Expr symExpr)
        
        tell [Log.Return "visitNode -> Node -> BooleanExpression If" (show toReturn)] $> toReturn
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      CFGT.ForInitialization mAccumulationVar -> do
        tell [Log.MethodStatementIfCondition (printf "visitNode -> case nodeData of Node -> ForInitialization -> Accumulation Variable -> Node num: %d" (CFGT.id n)) (show mAccumulationVar)]
        ER_FunHandle _ funName <- getFunHandle
        originalState <- get
        (_,cfgs) <- ask
        let varNames = getVarNames originalState
        let cfg = case CFG.findCFGByName funName cfgs of
              -- CFG not found
              Nothing   -> error $ "visitNode -> Node -> ForInitialization " ++ funName ++ " does not exist"
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
                  Nothing     -> error $ "visitNode -> Node -> ForInitialization -> won't happen"

        let forBody_forStep_path :: [CFGT.Node]
            forBody_forStep_path = flip takeWhile (CFG.getPath forBodyBranch cfg) $ \case
              CFGT.Entry _ _ _ -> error "won't happen"
              CFGT.End _ _ _ -> error "won't happen"
              CFGT.Node theId _ _ -> theId /= forCondNodeId
        -- implement a helper that takes as input `(accLogs,accState)`
        -- call it `visitForLoop`
        visitForLoop cfg m_Acc
          (let CFGT.Node _ (CFGT.BooleanExpression CFGT.For mForCondExpr) _ = forCondNode 
           in mForCondExpr)
          forBody_forStep_path
          (CFGT.SR (CFGT.id n)
              (CFG.getNodeId $ CFG.getEndForNode cfg $ (CFG.findNode_via_id cfg $ CFGT.id n)))
          (env originalState)
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      _ -> throwError
        $ "TODO -> visitNode -> Node -> nodeData -> otherwise: " ++ show n
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      where
      removeDeletedVars :: SymState -> SymState -> SymState
      removeDeletedVars state condSymState =
        let outerVarBindings = getVarBindings state
            condVarBindings = getVarBindings condSymState
            varsToDelete = condVarBindings Map.\\ outerVarBindings
            newCondSymStateEnv = flip Map.foldMapWithKey (env condSymState) $
              \key val -> case (key,val) of
                 (VarName varName,_)
                    | varName `Map.member` varsToDelete -> Map.empty
                    | otherwise -> Map.singleton key val
                 (VarBindings,_) -> Map.singleton VarBindings (SVarBindings outerVarBindings)
                 (_,_) -> Map.singleton key val
            newCondSymState = SymState newCondSymStateEnv (pc condSymState)
        in newCondSymState

----------------------------------------
----------------------------------------
----------------------------------------

getFunHandle :: Method_R
getFunHandle = (\(Just t,Just k) -> case k of
                    MethodName k2 -> ER_FunHandle t k2
                    _ -> error "getFunHandle ==> won't happen")
  <$> Map.foldlWithKey'
        (\acc k -> \case
                      SMethodType t -> (Just t,Just k)
                      _             -> acc) (Nothing,Nothing)
  <$> env <$> get

visitStmt :: AST.Statement -> Method_R
--ReturnStmt {returnS :: Maybe Expression}
visitStmt (AST.ReturnStmt (Just expr)) = do
  tell [Log.ReturnStatement (show expr) "visitStmt -> ReturnStmt"]
  er <- visitExpr expr
{- er
ER_SymStateMapEntry {
  er_key = VarName "numbers",
  er_val = SymArray (Just Int) (Just 2) [SymInt 99,SymInt 5]
}
-}
  ER_FunHandle t _ <- getFunHandle
{- t
Array Int
-}
  let symExpr = cast t $ case getSymExpr er of
        Just symExpr -> symExpr
        Nothing      -> error $ "visitStmt -> ReturnStmt -> won't happen: " ++ show er

  castGlobalVar t er
  tell [Log.ModifyState "visitStmt -> ReturnStmt -> method with args" ("return",show symExpr)]
  modify $ \symState ->
    SymState {
      env = Map.insert Return symExpr (env symState),
      pc = pc symState
    }
  tell [Log.Return "visitStmt -> ReturnStmt" (show er)] $> er
-- AssignStmt {varModifier :: [Modifier], assign :: Expression}
visitStmt stmt@AST.AssignStmt{} = do
  tell [Log.AssignStatement (show $ AST.assign stmt) "visitStmt -> pattern matching: AssignStmt"]
  mapEntry <- visitExpr $ AST.assign stmt
  tell [Log.Return "visitStmt -> AssignStmt" (show mapEntry)] $> mapEntry
-- VarStmt {var :: Expression}
visitStmt stmt@AST.VarStmt{} = do
  d <- visitExpr $ AST.var stmt
  tell [Log.Return "visitStmt -> VarStmt" (show d)] $> d
visitStmt stmt@(AST.FunCallStmt expr) = case expr of
  AST.FunCallExpr{} -> do
    toReturn <- visitExpr expr
    case toReturn of
      ER_PredefinedFunCall symExpr -> do
        tell [Log.ModifyState "visitStmt -> FunCallStmt" ("SActions",show symExpr)]
        modify $ \symState ->
          SymState {
            -- alter :: Ord k => (Maybe a -> Maybe a) -> k -> Map k a -> Map k a 
            env = Map.alter (\case
                    Nothing -> Just $ SActions [symExpr]
                    Just (SActions li) -> Just $ SActions $ li ++ [symExpr]) Actions (env symState),
            pc = pc symState
          }
        tell [Log.Return "visitStmt -> FunCallStmt" (show toReturn)] $> toReturn
      ER_FunCall _ -> do
        return ER_Void
      _ -> throwError $ "visitStmt ==> FunCallStmt ==> won't happen 1: " ++ show toReturn
  _ -> throwError $ "visitStmt ==> FunCallStmt ==> won't happen 2: " ++ show expr
visitStmt stmt = throwError $ "TODO -> visitStmt -> " ++ show stmt

visitExpr :: AST.Expression -> Method_R
visitExpr expr@(AST.NumberLiteral float) = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> NumberLiteral"]
  let toReturn = ER_Expr (SymNum float)
  tell [Log.Return "visitExpr -> NumberLiteral" (show toReturn)] $> toReturn
-- StringLiteral String
visitExpr expr@(AST.StringLiteral str) = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> StringLiteral"]
  let toReturn = ER_Expr (SymString str)
  tell [Log.Return "visitExpr -> StringLiteral" (show toReturn)] $> toReturn

-- FunCallExpr {funName :: Expression, funArgs :: [Expression]}
visitExpr (expr@AST.FunCallExpr{}) = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> FunCallExpr"]
  (_,cfgs) <- ask
  let funCallName = AST.getFunCallName $ AST.FunCallStmt expr
  -- Search for the CFG of the method call
  case CFG.findCFGByName funCallName cfgs of
    -- CFG found
    Just cfg0 -> do
      -- See if the method call has parameters
      case CFG.getCFGFormalParams cfg0 of
        formalParms -> do
          -- get the ExecutionResults of the actual parameters
          let actualParms :: [Method_R]
              actualParms = flip map (AST.funArgs expr) $ \exp ->
                let logging = Log.Nested (printf "SymExec of actual parameter: %s(%s)" funCallName (AST.getActualParmName exp))
                in censor (map logging) $ visitExpr exp
               
        --actualParms of the method call
        --actualParms1 :: [(SymStateKey,SymExpr)]
          actualParms1 <- zipWithM (\fParm act -> do
            maybeActual <- getSymExpr <$> act
            case maybeActual of
              Nothing -> throwError "TODO ==> visitExpr -> FunCallExpr"
              Just actual ->
                let Just t = fmap toSymType1 $ AST.varType fParm
                in return $ (VarName $ AST.getVarName fParm,cast t actual) 
              ) formalParms actualParms
          -- global vars to be inserted into the method call Map.Map
          -- (globalVars,globalVarsMap) :: ([String],Map.Map SymStateKey SymExpr)
          (globalVars,globalVarsMap) <- do
            ma0 <- env <$> get
            let theMap = flip Map.filter (getGlobalVars2 ma0) $ \case
                  SymVar _ _ -> False
                  _ -> True
                globalVars = flip map (Map.keys theMap) $ \(VarName vn) -> vn
            return (globalVars,theMap)
          let funCallMap0 =
                Map.union globalVarsMap
                $ Map.union (Map.fromList actualParms1)
                $ Map.insert GlobalVars (SGlobalVars globalVars)
                $ Map.insert FormalParms (SFormalParms $ map AST.getVarName formalParms)
                Map.empty
          let (funCallLogs2,funCallSymState2) = runCFG cfgs cfg0 Nothing
                $ Just $ SymState funCallMap0 []
          -- tell formalParms
          tell [Log.Nested ("actual: " ++ funCallName) $ Log.MethodFormalParams
              (show formalParms)
              "visitExpr -> FunCallExpr"]
          -- tell actualParms
          tell [Log.Nested ("actual: " ++ funCallName) $ Log.MethodActualParms
              (show actualParms1)
              "visitExpr -> FunCallExpr"]
          if null globalVars
            then return ER_Void
            else do
              -- tell global vars
              tell [Log.Nested ("actual: " ++ funCallName) $ Log.GlobalVars
                  (show $ Map.toList globalVarsMap)
                  "visitExpr -> FunCallExpr"]
              return ER_Void
          
          let inherit_actions = getActions funCallSymState2
              inherit_globalVars = getGlobalVars (env funCallSymState2)
          let inherit_globalVars_varNames = flip Map.filterWithKey (getVarNames3 $ env funCallSymState2) $ \k _ -> case k of
                VarName vn
                  | vn `elem` inherit_globalVars -> True
                _ -> False
          mainFunFormalParms <- (getFormalParms . env) <$> get
          let inherit_formalParms :: [(String,SymExpr)]
              inherit_formalParms =
                {-
                   public void succFun(int i) {
                     i += 1;
                   }

                   public int callSuccFun(int n) {
                     succFun(n);
                     return n;
                   }
                 -}
                -- pair formals of the funcall `callSuccFun` with formals of the fun `succFun`
                -- [(n,i)]
                let funCallFormalParms = zip mainFunFormalParms (map AST.getVarName formalParms)
                -- replace the key `i` with its value `SBin (SymVar Int "n") Add (SymInt 1)`
                -- [(n,SBin (SymVar Int "n") Add (SymInt 1))]
                    getFunCallFormalVal = flip map funCallFormalParms $
                      \tu -> flip fmap tu $ \vn ->
                        case findVarName vn (env funCallSymState2) of
                          Nothing -> error "visitExpr -> FunCallExpr -> inherit_formalParms -> won't happen1"
                          Just symExpr -> symExpr
                in getFunCallFormalVal
          ----------
          -- inheriting the method call's global vars list
          if null inherit_globalVars
            then return ER_Void
            else do
              tell [Log.ModifyState "visitExpr -> FunCallExpr -> inheriting global vars list" ("GlobalVars",show inherit_globalVars)]
              modify $ \symState ->
                SymState {
                  env = Map.alter (\case
                          Nothing -> Just $ SGlobalVars inherit_globalVars
                          Just (SGlobalVars li) -> Just
                            $ SGlobalVars $ nub $ li ++ inherit_globalVars)
                        GlobalVars (env symState),
                  pc = pc symState
                }
              return ER_Void
          ----------
          -- inheriting the method call's global vars var names
          if null inherit_globalVars_varNames
            then return ER_Void
            else do
              tell [Log.ModifyState "visitExpr -> FunCallExpr -> inheriting global vars varnames" ("VarNames",show inherit_globalVars_varNames)]
              modify $ \symState ->
                SymState {
                  env = Map.union inherit_globalVars_varNames (env symState),
                  pc = pc symState
                }
              return ER_Void
          ----------
          -- inheriting the method call's actions
          if null inherit_actions
            then return ER_Void
            else do
              tell [Log.ModifyState "visitExpr -> FunCallExpr -> inheriting actions" ("Actions",show inherit_actions)]
              modify $ \symState ->
                SymState {
                  env = Map.alter (\case
                          Nothing -> Just $ SActions inherit_actions
                          Just (SActions li) -> Just
                            $ SActions $ li ++ inherit_actions)
                        Actions (env symState),
                  pc = pc symState
                }
              return ER_Void
          ----------
          if null inherit_formalParms
            then return ER_Void
            else do
              tell [Log.ModifyState "visitExpr -> FunCallExpr -> inheriting formalParms" ("FormalParms",show inherit_formalParms)]
              modify $ \symState ->
                SymState {
                  env = foldl' (\ma (k,newVal) -> Map.alter (\case
                    Nothing -> error "visitExpr -> FunCallExpr -> inherit_formalParms -> won't happen2"
                    Just _ -> Just newVal) (VarName k) ma) (env symState) inherit_formalParms,
                  pc = pc symState
                }
              return ER_Void
          ----------
          -- edit its logs and tell them
          flip mapM_ funCallLogs2 $ \log ->
            tell [Log.Nested ("actual: " ++ funCallName) log]
          -- TODO
          {-
          -- edit the injection logs and tell them
          -- flip mapM_ globalVarsInjectionLogs $ \log ->
          --   tell [Log.Nested ("Global Var Injection: " ++ funCallName) log]
           -}
          tell [Log.RunSymStateActualMethodCall (show funCallSymState2)]
          let toReturn = ER_FunCall funCallSymState2
          tell [Log.Return "visitExpr -> FunCallExpr" (show toReturn)] $> toReturn
    -- CFG not found
    Nothing
      | funCallName `elem` predefinedFuns -> do
          tell [Log.ProcessPredefinedFunCall "visitExpr ==> FunCallExpr" (show $ AST.funName expr) (show $ AST.funArgs expr)]
          -- get SymExprs of args
          funArgsExprs <- flip mapM (AST.funArgs expr) $ \ex -> do
            v <- visitExpr ex
            case v of
              ER_SymStateMapEntry _ val -> return val
              ER_Expr expr -> return expr
          -- funArgsExprs = [SBin (SymInt 1) Add (SymVar Int "n")]
          -- toReturn = ER_Expr (SBin (SymInt 1) Add (SymVar Int "n"))
          let toReturn = ER_PredefinedFunCall $ funCallCalculator (toPredefinedFun $ AST.getFunCallName $ AST.FunCallStmt expr,funArgsExprs)
          --throwError $ "WFF:: " ++ show toReturn
          tell [Log.Return "visitExpr ==> FunCallExpr" (show toReturn)] $> toReturn
      | otherwise -> throwError $ "visitExpr => FunCallExpr: Method " ++ funCallName ++ " does not exist"
--BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
visitExpr expr@AST.BinOpExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> BinOpExpr"]
  er_one <- visitExpr (AST.expr1 expr)
  er_two <- visitExpr (AST.expr2 expr)

  let mOne = getSymExpr er_one
      mTwo = getSymExpr er_two
  case (mOne,mTwo) of
    (Just one,Just two) -> do
      let newUnifiedSymType = pick_known_symType (toSymType2 one,toSymType2 two)
      mapM_ (castGlobalVar newUnifiedSymType) [er_one,er_two]
      tell [Log.Affected "visitExpr -> BinOpExpr" [show one,show $ AST.binOp expr,show two]]
      let op1 = cast newUnifiedSymType one
          operator = toSymBinOp $ AST.binOp expr
          op2 = cast newUnifiedSymType two
          calculatorType = whichCalculator2 op1 operator op2
          calculator = case calculatorType of
            "stringCalculator"  -> stringCalculator
            "numericCalculator" -> numericCalculator
            "booleanCalculator" -> booleanCalculator
          calculating = calculator (SBin op1 operator op2)
          toReturn = ER_Expr $ calculating
      tell [Log.Return (printf "visitExpr -> BinOpExpr -> %s"
                          calculatorType) (show toReturn)
           ] $> toReturn
    _ -> throwError $ printf "visitExpr -> BinOpExpr -> won't happen -> (%s,%s)" (show mOne) (show mTwo)
-- UnOpExpr {unOp :: UnOp, expr :: Expression}
visitExpr expr@AST.UnOpExpr{} = throwError "visitExpr ==> UnOpExpr ==> TODO"
-- AssignExpr {assEleft :: Expression, assEright :: Expression}
visitExpr expr@AST.AssignExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> AssignExpr"]

  one <- visitExpr (AST.assEleft expr)

  -- one_val's sole purpose is its type
  -- one_svn is important to find key in the map
  let (one_svn,one_val) = case one of
       ER_SymStateMapEntry svn val -> (svn,val)
       ER_ArrayCallExpr (SArrayIndexAccess arrName _) val ->
         --call = SArrayIndexAccess "strs" (SymInt 1)
         --val = SymNull String
         (VarName arrName,val)
       ER_Expr ex -> error $ printf "visitExpr ==> AssignExpr: (%s,%s,%s)"
           (show expr) (show ex) (show $ AST.assEleft expr)

  two <- visitExpr (AST.assEright expr)

{-
1) expr = AssignExpr {
    assEleft = VarExpr {varType = Nothing, varObj = [], varName = "z"},
    assEright = BinOpExpr {
        expr1 = BinOpExpr {expr1 = FunCallExpr {funName = VarExpr {varType = Nothing, varObj = [], varName = "toString"}, funArgs = [VarExpr {varType = Nothing, varObj = [], varName = "x"}]}, 
                           binOp = +,
                           expr2 = StringLiteral " "},
        binOp = +,
        expr2 = VarExpr {varType = Nothing, varObj = [], varName = "y"}}}

2) one_svn = VarName "z"

3) one_val = SymVar UnknownGlobalVarSymType "z"

4) two = ER_Expr (SBin (SBin (SymFun ToString (SymFun ToString (SBin (SymInt 1) Add (SymVar Int "n")))) Add (SymString " ")) Add (SymString "is one"))
-}
  {-case one_svn of
    VarName "z" -> throwError
      $ printf "MEOW::\n\n1) expr = %s\n\n2) one_svn = %s\n\n3) one_val = %s\n\n4) two = %s"
          (show expr) (show one_svn) (show one_val) (show two)
    _ -> return ER_Void-}
  let two_val = case two of
          ER_Expr e2_@(SymArray mType1 mSize1 elms1) -> case one_val of
            SymVar (Array type2) _ ->
              let newType = pick_known_symType2
                    $ maybe UnknownGlobalVarSymType id mType1
                    : map toSymType2 elms1
                    ++ [type2]
              in cast newType e2_
            _ -> error $ "TODO1: SymbolicExecution.Method.visitExpr.AssignExpr.e2 ==> " ++ show one_val
          ER_Expr e2_ -> cast (toSymType2 one_val) e2_
          ER_FunCall funCallState ->
            case getReturnSymExpr funCallState of
              Nothing -> error $ printf "visitExpr ~~> AssignExpr ~~> won't happen"
              Just e2_ -> e2_
          ER_SymStateMapEntry _ e2_ -> e2_
          ER_PredefinedFunCall e2_ -> cast (toSymType2 one_val) e2_
          _ -> error $ "TODO2: SymbolicExecution.Method.visitExpr.AssignExpr.e2 ==> " ++ show two

  tell [Log.Affected "visitExpr -> AssignExpr" [show one, show two]]
  -- newVal is a transformation of two_val. it's the new value
  -- inside of newVal, casting is done
  varNames <- getVarNames <$> get
  let two_newVal = case (one,two_val) of
        (ER_ArrayCallExpr (SArrayIndexAccess arrName index) _,_) ->
          let Just theArray@(SymArray mt ml elems) = Map.lookup (VarName arrName) varNames
          in case index of
               SymInt num ->
                 let int = fromIntegral num
                 in SymArray mt ml (
                     take int elems ++
                     [cast (toSymType2 one_val) two_val] ++
                     drop (int+1) elems)
               _ -> error $ "TODO1: visitExpr ==> AssignExpr: " ++ show index
        (_,SymArray _ _ _) -> -- casting is done during the creation of two_val
          two_val
        _ -> cast (toSymType2 one_val) two_val
  -- this case-of sole purpose is creating Log.UpdateVariable
  case one_svn of
    VarName _ ->
      ((Map.lookup one_svn . env) <$> get) >>= \case
        Just oldVal
          | oldVal /= two_newVal -> do
              tell [Log.UpdateVariable (show one_svn,show oldVal,show two_newVal) "visitExpr ==> AssignExpr"]
              return ER_Void
          | oldVal == two_newVal -> return ER_Void
        Nothing -> do
          tell [Log.UpdateVariable (show one_svn,"No previous value",show two_newVal) "visitExpr ==> AssignExpr"]
          return ER_Void
  -- inserting new value in map
  tell [Log.ModifyState "visitExpr ==> AssignExpr" (show one_svn,show two_newVal)]
  modify $ \symState ->
    SymState {
      env = Map.insert one_svn two_newVal (env symState),
      pc = pc symState
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
  castGlobalVar (toSymType2 two_newVal) one

  -- consider the AssignExpr:
  --   double x;
  --   x = c;
  -- c is a global variable, used for the first time in this assignment
  -- c is a double, and its VarName in the SymState need to be updated accordingly
  castGlobalVar (toSymType2 two_newVal) two
  
  let toReturn = ER_SymStateMapEntry one_svn two_val
  tell [Log.Return "visitExpr -> AssignExpr" (show toReturn)] $> toReturn

-- VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
visitExpr expr@AST.VarExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> VarExpr"]
  case AST.varObj expr of
    [] -> do
      let varName_ = AST.varName expr
      case AST.varType expr of
        Nothing -> do
          mVal <- (Map.!? VarName varName_) <$> env <$> get
          case mVal of
            Just val -> do
              tell [Log.LookUpEnvTable varName_ (show val) "visitExpr -> VarExpr"]
              let toReturn = ER_SymStateMapEntry (VarName varName_) val
              tell [Log.Return "visitExpr -> VarExpr -> Updating" (show toReturn)] $> toReturn
            Nothing -> do
              tell [Log.GlobalVar varName_ "visitExpr -> VarExpr"]
              -- TODELETE let symExpr = SymGlobalVar UnknownGlobalVarSymType varName_ Nothing
              let symExpr = SymVar UnknownGlobalVarSymType varName_
                  toReturn = ER_SymStateMapEntry
                    (VarName varName_)
                    symExpr
              tell [Log.ModifyState "visitExpr -> VarExpr" (varName_,show symExpr)]
              modify $ \symState -> SymState {
                env = Map.insert (VarName varName_) symExpr
                      $ recordGlobalVar varName_ (env symState),
                pc = pc symState
              }
              tell [Log.Return "visitExpr -> VarExpr -> Recording Global Variable" (show toReturn)] $> toReturn
        Just t -> do
          alreadyExist <- env <$> get >>= return . Map.lookup (VarName varName_)
          case alreadyExist of
            Just expr -> do
              tell [Log.ActualParameterDetected (show t) varName_ (show expr) "visitExpr -> VarExpr -> "]
              return ER_ActualParameterDetected
            Nothing -> do
              tell [Log.NewVariable (show t) varName_ "visitExpr -> VarExpr"]
              let sExpr = SymVar(toSymType1 t) varName_
              tell [Log.ModifyState "visitExpr -> VarExpr" (varName_,show sExpr)]
              modify $ \symState ->
                SymState {
                  env = Map.insert (VarName varName_) sExpr (env symState),
                  pc = pc symState
                }
              let toReturn = ER_SymStateMapEntry (VarName varName_) sExpr
              tell [Log.Return "visitExpr -> VarExpr -> Declaring Local Variable" (show toReturn)] $> toReturn
    li -> do
      state <- get
      let symExpr0@(SObjAcc exprs) = SObjAcc $ li ++ [AST.varName expr]
      let toReturn = ER_SymStateMapEntry (VarName $ last $ init exprs) (objAccCalculator (getVarNames state) symExpr0)
      tell [Log.Return "visitExpr ==> VarExpr" (show toReturn)] $> toReturn

-- ArrayCallExpr {arrName :: Expression, index :: Maybe Expression}
{-
ArrayCallExpr {
  arrName = VarExpr {varType = Nothing, varObj = [], varName = "arr"},
  index = Just (VarExpr {varType = Nothing, varObj = [], varName = "pos"})
}
-}
visitExpr expr@AST.ArrayCallExpr{} = do
  -- Array name
  ER_SymStateMapEntry (VarName arrName) _ <- visitExpr $ AST.arrName expr
  -- Array index
  index_er <- case AST.index expr of
    Nothing -> throwError "visitExpr ==> ArrayCallExpr ==> won't happen"
    Just expr_ -> do
      indexExpr <- visitExpr expr_
      return $ case indexExpr of
        ER_SymStateMapEntry _ indexExpr2 -> indexExpr2
        ER_Expr indexExpr2 -> cast Int indexExpr2
        e -> error $ "TODO1: visitExpr ==> ArrayCallExpr ==> " ++ show e
  varNames <- getVarNames <$> get
  let symExprCall = SArrayIndexAccess arrName index_er
      symExprVal = objAccCalculator varNames symExprCall
      toReturn = ER_ArrayCallExpr symExprCall symExprVal
  tell [Log.Return "visitExpr ==> ArrayCallExpr" (show toReturn)] $> toReturn

visitExpr expr@(AST.BoolLiteral b) = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> BoolLiteral"]
  let toReturn = ER_Expr (SBool b)
  tell [Log.Return "visitExpr -> BoolLiteral" (show toReturn)] $> toReturn
--ExcpExpr {excpName :: Exception, excpmsg :: Maybe String}
visitExpr expr@AST.ExcpExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitStmt -> ExcpExpr"]
  tell [Log.ModifyState "visitExpr -> ExcpExpr" ("Exception",show expr)]
  ER_FunHandle funType _ <- getFunHandle
  let symExpr = SException funType
        (case AST.excpName expr of
           AST.Exception str -> str
           _ -> error "visitExpr -> ExcpExpr -> won't happen")
        (case AST.excpmsg expr of
           Nothing -> ""
           Just str -> str)
  let toReturn = ER_Expr symExpr
  tell [Log.Return "visitExpr -> ExcpExpr" (show toReturn)] $> toReturn

visitExpr expr@AST.ArrayInstantiationExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitStmt -> ArrayInstantiationExpr"]
  let mArrType = fmap toSymType1 $ AST.arrType expr
  -- process elements in the array, if they exist
  exprs <- flip mapM (AST.arrElems expr) $ \ex -> do
    er <- visitExpr ex
    case (er,mArrType) of
      (ER_Expr expr2,Nothing) -> return $ expr2
      (ER_Expr expr2,Just t) -> return $ cast (arrayElementSymType t) expr2
      _ -> throwError $ "visitExpr ==> ArrayInstantiationExpr: " ++ show er
  -- get array size
  m_arr_size <- case (AST.arrSize expr,length exprs) of
        (Nothing,l) -> return $ Just l
        (Just ex,l)
          | l > 0 -> return $ Just l
          | otherwise -> do
              er <- visitExpr ex
              case er of
                ER_Expr (SymNum num) -> return $ Just $ round num
                _ -> throwError $ "visitExpr ==> ArrayInstantiationExpr: " ++ show (expr,er)
        (Nothing,0) -> return Nothing
  -- potentially add nulls as elements if size is present, but no elements are present.
  let exprs_ = case (m_arr_size,exprs) of
        (Nothing,[]) -> []
        (Nothing,_) -> exprs
        (Just num,[]) -> replicate num (SymNull $ maybe (error "visitExpr ==> ArrayInstantiationExpr") arrayElementSymType mArrType)
        (Just num,_) -> exprs

  let symExpr = SymArray
        (fmap arrayElementSymType mArrType)
        m_arr_size
        exprs_

  return $ ER_Expr symExpr
visitExpr expr = error $ "What this is: " ++ show expr

------------------------------

visitForLoop :: CFGT.CFG -> Maybe CFGT.Node -> Maybe AST.Expression -> [CFGT.Node] -> CFGT.ScopeRange -> Map.Map SymStateKey SymExpr -> Method_R
visitForLoop cfg m_Acc mForCondExpr forBody_forStep_path branchRange ma = do
  originalState <- get
  ER_State state_With_Acc <- do
    case m_Acc of
      Nothing -> ER_State <$> get
      Just acc -> do
        getReader_Method_R $ visitNode acc
        ER_State <$> get
  ER_Expr forCondExpr_visited <- case fmap (censor (map (Log.Nested "For Loop Condition")) . visitExpr) mForCondExpr of
    Nothing -> return $ ER_Expr $ SBool True
    Just v -> v
  case forCondExpr_visited of
    -- visit for loop body
    SBool True -> do
      forLoopVisited <- visitForLoop1 1 state_With_Acc cfg m_Acc mForCondExpr forBody_forStep_path branchRange ma
      case forLoopVisited of
        -- for visitation was completed
        ER_ForLoopDone -> do
          s <- get
          throwError $ printf "visitForLoop ==> TODO ::\n\n%s\n\n%s" (show originalState) (show s)
    -- for loop condition was not met
    SBool False -> do
      tell [Log.ForLoopDone "visitForLoop1"]
      modify (const originalState)
      return ER_ForLoopDone
    _ -> do modify (const originalState)
            visitForLoop2 cfg m_Acc mForCondExpr forBody_forStep_path branchRange ma

------------------------------

visitForLoop1 :: Int -> SymState -> CFGT.CFG -> Maybe CFGT.Node -> Maybe AST.Expression -> [CFGT.Node] -> CFGT.ScopeRange -> Map.Map SymStateKey SymExpr -> Method_R
visitForLoop1 loopCounter originalState cfg m_Acc mForCondExpr forBody_forStep_path branchRange ma = do
  -- whether there's a loop condition
  ER_Expr forCondExpr_visited <- case fmap (censor (map (Log.Nested "For Loop Condition")) . visitExpr) mForCondExpr of
    Nothing -> return $ ER_Expr $ SBool True
    Just v -> v
  -- whether the loop condition is atomic
  case forCondExpr_visited of
    -- it's atomic, and do a round
    SBool True -> do
      (config,_) <- ask
      if iterationMaxBound config >= loopCounter
        then do
          tell [Log.ForLoopRound loopCounter "visitForLoop1"]
          flip mapM_ forBody_forStep_path $ \node ->
            censor (map (Log.Nested "For Loop Body")) $ getReader_Method_R (visitNode node)
          visitForLoop1 (loopCounter+1) originalState cfg m_Acc mForCondExpr forBody_forStep_path branchRange ma
      else do
        tell [Log.ForLoopLimitReached "visitForLoop1"]
        visitForLoop2 cfg m_Acc mForCondExpr forBody_forStep_path branchRange ma
    -- it's atomic, and terminate
    SBool False -> do
      tell [Log.ForLoopDone "visitForLoop1"]
      return ER_ForLoopDone
   -- it's not atomic
    _ -> do tell [Log.ForLoopConditionUndetermined "visitForLoop1" (show forCondExpr_visited)]
            modify (const originalState)
            visitForLoop2 cfg m_Acc mForCondExpr forBody_forStep_path branchRange ma

------------------------------

visitForLoop2 :: CFGT.CFG -> Maybe CFGT.Node -> Maybe AST.Expression -> [CFGT.Node] -> CFGT.ScopeRange -> Map.Map SymStateKey SymExpr -> Method_R
visitForLoop2 cfg m_Acc mForCondExpr forBody_forStep_path branchRange ma = do
    tell [Log.UnvisitedForLoop "visitForLoop2" (show mForCondExpr)]
    (_,cfgs) <- ask
    let path = maybe [] (\acc -> [acc]) m_Acc
               ++ (flip mapMaybe forBody_forStep_path $ \node -> case CFGT.nodeData node of
                     CFGT.ForStep _ -> CFG.convert node
                     _ -> Just node)
    originalState <- get
    {-
    -- modify `originalState` so that we only keep
    -- MethodName, GlobalVars, FormalParms, VarBindings, VarNames
    -- in a new modified Map.Map, because that's all we need
    -- when we generate the inner state
    let modifiedOriginalMap = flip Map.filterWithKey (env originalState) $ \k _ -> case k of
          GlobalVars -> True
          FormalParms -> True
          VarBindings -> True
          VarName _ -> True
          VarAssignments -> True
          _ -> False
     -}
    let (forBodyLogs,forBodySymState) = runCFG cfgs cfg (Just path)
          (Just $ SymState (env originalState) (pc originalState))
    -- record unregistered logs
    forM_ forBodyLogs $ \log ->
      tell [Log.Nested "For Loop Body" $ Log.Nested "Unregistered" log]
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
            val -> error $ "visitForLoop2 ==> won't happen 1 ==> " ++ show val)
            $ Map.lookup GlobalVars (env originalState) 
        -- VarBindings from `originalState`
        originalVarBindings = maybe [] (\case
            SVarBindings m -> Map.keys m
            val -> error $ "visitForLoop2 ==> won't happen 2 ==> " ++ show val)
            $ Map.lookup VarBindings (env originalState)
        -- FormalParms from `originalState`
        originalFormalParms = maybe [] (\case
            SFormalParms li -> li
            val -> error $ "visitForLoop2 ==> won't happen 3 ==> " ++ show val)
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
             val -> error $ "visitForLoop2 ==> won't happen 4 ==> " ++ show val)
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
            val -> error $ "visitForLoop2 ==> won't happen 5 ==> " ++ show val
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
                  \(vn2,node_coor) ->
                      vn2 == vn &&
                      CFGT.varDeclAt node_coor >= CFGT.branchStart branchRange &&
                      CFGT.varDeclAt node_coor <= CFGT.branchEnd branchRange
                node_coors = map snd vn_forbody_varAssigns
            in case vn_forbody_varAssigns of
                 [] -> ma
                 _ -> Map.alter (\case
                   ---createSymReason :: (CFGT.Kind,CFGT.ScopeRange) -> CFGT.CFG -> [CFGT.Node_Coor] -> [SymReason]
                   Nothing -> Just $ SymUnknown (toSymType2 val,vn,Nothing)
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
                     pick_known_symType (toSymType2 oldVal,toSymType2 val),
                     vn,
                     Just oldVal) $ createSymReason (CFGT.For,branchRange) cfg node_coors 
                   ) (VarName vn) ma
            ) map_withVarAssignments forBody_Some_VarNames

    let symExpr = SLoop m_Acc mForCondExpr forBody_forStep_path
        toReturn = ER_SymStateMapEntry (ScopeRange branchRange) symExpr
    tell [Log.ModifyState "visitForLoop2" (show branchRange,show symExpr)]
    modify $ \symState -> SymState {
      env = Map.insert (ScopeRange branchRange) symExpr map_withVarNames,
      pc = pc symState
      }
    tell [Log.Return "visitForLoop2" (show toReturn)] $> toReturn

------------------------------

type Path = [CFGT.Node]
runCFG :: [CFGT.CFG] -> CFGT.CFG -> Maybe Path -> Maybe SymState -> ([Log.Log],SymState)
runCFG cfgs cfg mPath mSymState =
  let path :: [CFGT.Node]
      path = maybe (CFG.getPath 0 cfg) id mPath
      runner = flip mapM_ path $ \node -> do
        tell [Log.NextNode (show node)]
        state_ <- get
        case getReturnSymExpr state_ of
          Just _ -> tell [Log.Skip $ printf "%s" (show node)] $> ER_Void
          Nothing -> getReader_Method_R $ visitNode node
      (methodNameKey,methodNameValue) = (MethodName $ CFG.getCFGName cfg , SMethodType $ toSymType1 $ CFG.getCFGType cfg)
      {-
      initialSymState = maybe
          (SymState (Map.insert methodNameKey methodNameValue Map.empty) [])
          id mSymState
       -}
      initialSymState = maybe
          (SymState Map.empty [])
          id mSymState
      run_r :: ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))) ()
      run_r = runReaderT runner (defaultConfig,cfgs)
      run_e :: WriterT [Log.Log] (StateT SymState (Either String)) (Either String ())
      run_e = runExceptT run_r
      run_w :: StateT SymState (Either String) (Either String (),[Log.Log])
      run_w = runWriterT run_e
      mRun_s :: Either String ((Either String (),[Log.Log]),SymState)
      mRun_s = runStateT run_w initialSymState
  in case mRun_s of
       Left str -> error str
       Right ((ei,logs),SymState m ps) ->
         let m2 = flip Map.mapWithKey m $ \k v -> case (CFG.getCFGType cfg,k,v) of
                    (AST.BuiltInType AST.Int, Return, SymNum float)    ->
                        SymInt (round float)
                    (AST.BuiltInType AST.Double, Return, SymNum float) ->
                        SymDouble (realToFrac float)
                    (AST.BuiltInType AST.Float, Return, SymNum float)  ->
                        SymFloat float
                    (_,_,_) -> v
         in (logs,either (\l -> error $ printf "error in method name (%s) thrown from Method.hs:\n%s" (CFG.getCFGName cfg) l) (const (SymState m2 ps)) ei)

