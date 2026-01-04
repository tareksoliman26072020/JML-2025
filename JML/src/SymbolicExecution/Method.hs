{-# Language LambdaCase #-}
module SymbolicExecution.Method where

import qualified SymbolicExecution.Log as Log
import SymbolicExecution.Types
import qualified CFG.Types as CFG
import qualified Data.Map as Map
import Control.Monad.Reader (runReaderT,ask)
import Control.Monad.State
import Control.Monad.Except
import Control.Monad (forM_, zipWithM)
import qualified Parser.Types as AST
import Visitors.API
import SymbolicExecution.MethodCall (runSymState)
import Control.Monad.Writer
import Text.Printf (printf)
import Data.Functor (($>))
import Data.List (foldl',nub)
import SymbolicExecution.Internal.Internal
import SymbolicExecution.Internal.Calculator (numericCalculator, booleanCalculator, objAccCalculator, stringCalculator, funCallCalculator)

instance CFGVisitor Method_SymExec where
--visitNode :: CFG.Node -> Method_SymExec
  visitNode node = Method_SymExec $ tell [Log.HorizontalLine "visitNode"] >> case node of
    CFG.Entry t mn args -> do
      tell [Log.MethodStart mn "visitNode -> Entry"]
      case null args of
        True  -> tell [Log.Return "visitNode -> Entry -> method with no args" "()"] $> ()
        False -> do
          tell [Log.MethodFormalParams (show args) "visitNode -> Entry -> method with args"]
          mapM visitExpr args $> ()
          mapM (\arg -> do
                   argVisited <- visitExpr arg
                   case argVisited of
                     ER_SymStateMapEntry (VarName name) (SymNull symType) -> do
                       let newVal = SymFormalParam symType name Nothing
                       tell [Log.ModifyState "visitNode -> Entry -> method with args" (name,show newVal)]
                       modify $ \symState ->
                         SymState {
                           env = recordFormalParm name $ Map.insert (VarName name) newVal (env symState),
                           pc = pc symState
                         }
                     _ -> throwError "won't happen"
               ) args $> ()
      toReturn <- ER_State <$> get
      tell [Log.Return "visitNode -> Entry -> method has args" (show toReturn)] $> toReturn
    ----------------------------------------
    ----------------------------------------
    ----------------------------------------
    n@CFG.End{} -> do
      tell [Log.MethodEnd "visitNode -> End"]
      case CFG.mExpr n of
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
    n@CFG.Node{} -> case CFG.nodeData n of
      CFG.Statement stmt -> do
        tell [Log.MethodStatement "visitNode -> case nodeData of Node -> Statement" (show stmt)]
        toReturn <- visitStmt stmt
        --addVarBinding (CFG.id n) (CFG.parent n) stmt
        -- Var Bindings
        case getNewVarBinding (CFG.id n) (CFG.parent n) stmt of
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
        case getNewVarAssignment (CFG.id n) (CFG.parent n) stmt of
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
          _ -> return ER_Void
        tell [Log.Return "visitNode -> Node -> Statement" (show toReturn)] $> toReturn
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      -- BooleanExpression Kind AST.Expression
      CFG.BooleanExpression CFG.If Nothing ->
        throwError "visitNode ==> case nodeData of Node ==> BooleanExpression If ==> won't happen"
      CFG.BooleanExpression CFG.If (Just expr) -> do
        tell [Log.MethodStatementIfCondition (printf "visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: %d" (CFG.id n)) (show expr)]
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
            branches = case CFG.findEdge_via_id cfg (CFG.id n) of
                      Just (_,xs) -> xs
                      Nothing     -> error $ "visitNode -> Node -> BooleanExpression -> won't happen"
        let branches_paths :: [[CFG.Node]]
            branches_paths = flip map branches $ \branchStartId ->
              let thePath = CFG.getPath branchStartId cfg
              in flip takeWhile thePath $ \case
                   CFG.Node _ (CFG.Meet CFG.If) _ -> False
                   _                              -> True
        --throwError $ "visitNode ==> Node ==> BooleanExpression ==> " ++ show branches_paths
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
                        newCondSymState = SymState {
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
                                      $ \(name,_) -> maybe False (const True)
                                           (lookup name mainVarAssignments)
                                  ) VarAssignments
                                      addActions
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
                        newCondSymState = SymState {
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
                                      $ \(name,_) -> maybe False (const True)
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
                symExpr <- case branches_paths of
                  [_] -> return $ SIte expr2 ifSymState Nothing
                  [_,pElse] -> do
                    let (elseLogs,elseSymState) = runCFG cfgs cfg (Just pElse) (Just state)
                    flip mapM_ elseLogs $ \log ->
                      tell [Log.Nested "else statement" log]
                    return $ SIte expr2 ifSymState (Just elseSymState)
                let condVarAssignments s = flip filter (getVarAssignments s) $
                      \(name,_) -> maybe False (const True) $ lookup name mainVarAssignments
                    newMainVarAssignments = case symExpr of
                      SIte _ ifSymState mElseSymState -> nub $
                        condVarAssignments ifSymState ++
                        maybe [] condVarAssignments mElseSymState
                tell [Log.ModifyState "visitNode -> Node -> BooleanExpression if -> recording symbolic branching" (printf "if node num: %d" (CFG.id n),show symExpr)]
                modify $ \symState ->
                  SymState {
                    env =
                      let addNode = Map.insert (NodeNr $ CFG.id n) symExpr (env symState)
                          addVarAssignments = Map.insert
                            VarAssignments (SVarAssignments newMainVarAssignments) addNode
                      in addVarAssignments,
                    pc = pc symState
                  }
                return (ER_Expr symExpr)
        
        tell [Log.Return "visitNode -> Node -> BooleanExpression" (show toReturn)] $> toReturn
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      {-
         Node {
           id = 2,
           nodeData = ForInitialization (Just (
             AssignExpr {
               assEleft = VarExpr {varType = Just (BuiltInType Int), varObj = [], varName = "i"}, 
               assEright = VarExpr {varType = Nothing, varObj = [], varName = "n"}
             }))
           , parent = 0
         }
       -}
      CFG.ForInitialization mAccumulationVar -> do
        tell [Log.MethodStatementIfCondition (printf "visitNode -> case nodeData of Node -> ForInitialization -> Accumulation Variable -> Node num: %d" (CFG.id n)) (show mAccumulationVar)]
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
              CFG.Node (CFG.id n) (CFG.Statement $ AST.AssignStmt [] v) 0
        {-
        -- process the accumulation variable, if it exists
        accumulationVar_visited <- case mAccumulationVar of
          -- no accumulation variable
          Nothing -> do
            tell [Log.ForStatementHasNoAccumulationVariable $ "visitNode -> case nodeData of Node -> ForInitialization -> Accumulation Variable -> Node num: " ++ show (CFG.id n)]
            return ER_Void
          -- yes accumulation variable
          Just accumulationVar -> do
            -- variable will be added to a new state, custom-made for the for body
            let (accLogs,accState) = runCFG cfgs cfg (Just [CFG.Node (CFG.id n) (CFG.Statement $ AST.AssignStmt [] accumulationVar) 0]) (Just originalState)
            let accVarNameString = AST.getVarName accumulationVar
            let Just accVarNameVal = findVarName accVarNameString (env accState)
            return $ ER_Triplet (ER_Logs accLogs,ER_Expr accVarNameVal,ER_State accState)
         -}
        -- process SymState of for body
        -- branches: start id for the for body branch.
        --           return is a list of one int.
        let forCondNodeId = CFG.id n + 1
        let forCondNode = CFG.findNode_via_id cfg forCondNodeId
        let forBodyBranch = case CFG.findEdge_via_id cfg forCondNodeId of
                  Just (_,(x : _)) -> x
                  Nothing     -> error $ "visitNode -> Node -> ForInitialization -> won't happen"

        let forBody_forStep_path :: [CFG.Node]
            forBody_forStep_path = flip takeWhile (CFG.getPath forBodyBranch cfg) $ \case
              CFG.Entry _ _ _ -> error "won't happen"
              CFG.End _ _ _ -> error "won't happen"
              CFG.Node theId _ _ -> theId /= forCondNodeId
        -- implement a helper that takes as input `(accLogs,accState)`
        -- call it `visitForLoop`
        visitForLoop m_Acc forCondNode forBody_forStep_path (CFG.id n) (env originalState)
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      _ -> throwError
        $ "TODO -> visitNode -> Node -> nodeData -> otherwise" ++ show n
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
      
      visitForLoop :: Maybe CFG.Node -> CFG.Node -> [CFG.Node] -> Int -> Map.Map SymStateKey SymExpr -> Method_R
      visitForLoop m_Acc forCondNode forBody_forStep_path nodeNr ma
        -- if any of the variables has a global variable or formal parameter,
        -- then add SLoop to the state and end without visiting nodes
        | (maybe True
                 (\node -> nodeHasGlobalVar ma node || nodeHasFormalParm ma node)
                 m_Acc)
          || any (\node -> nodeHasGlobalVar ma node || nodeHasFormalParm ma node) (forCondNode : forBody_forStep_path) = do
            let symExpr = SLoop
                  m_Acc
                  forCondNode
                  forBody_forStep_path
                toReturn = ER_SymStateMapEntry (NodeNr nodeNr) symExpr
            tell [Log.ModifyState "visitNode ==> ForInitialization ==> visitForLoop" (show nodeNr,"SLoop")]
            modify $ \symState -> SymState {
              env = Map.insert (NodeNr nodeNr) symExpr (env symState),
              pc = pc symState
            }
            return toReturn
        | otherwise = throwError "TODO2:: visitForLoop"

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
  varNames <- getVarNames <$> get
  let symExpr = case er of
        ER_Expr symExpr_ -> symExpr_ 
        ER_SymStateMapEntry _ val -> val
        ER_FunCall funCallSymState -> case getReturnSymExpr funCallSymState of
          Just symExpr -> symExpr
          Nothing -> error $ "visitStmt ==> ReturnStmt: TODO: Nothing: \n" ++ show funCallSymState
        ER_FunCall funCallSymState -> error
          $ "visitStmt ==> ReturnStmt: " ++ (show $ env funCallSymState)
        ER_ArrayCallExpr _ val -> val
        x                -> error $ "visitStmt -> ReturnStmt -> won't happen: " ++ show x
  tell [Log.ModifyState "visitStmt -> ReturnStmt -> method with args" ("return",show symExpr)]
  modify $ \symState ->
    SymState {
      env = Map.insert Return symExpr (env symState),
      pc = pc symState
    }
  toReturn <- ER_State <$> get
  tell [Log.Return "visitStmt -> ReturnStmt" (show toReturn)] $> toReturn
-- AssignStmt {varModifier :: [Modifier], assign :: Expression}
visitStmt stmt@AST.AssignStmt{} = do
  tell [Log.AssignStatement (show $ AST.assign stmt) "visitStmt -> pattern matching: AssignStmt"]
  _ <- visitExpr $ AST.assign stmt
  toReturn <- ER_State <$> get
  tell [Log.Return "visitStmt -> AssignStmt" (show toReturn)] $> toReturn
-- VarStmt {var :: Expression}
visitStmt stmt@AST.VarStmt{} = do
  _ <- visitExpr $ AST.var stmt
  toReturn <- ER_State <$> get
  tell [Log.Return "visitStmt -> VarStmt" (show toReturn)] $> toReturn
visitStmt stmt@(AST.FunCallStmt expr) = case expr of
  AST.FunCallExpr{} -> do
    toReturn <- visitExpr expr
    case toReturn of
      ER_Print str -> do 
        tell [Log.ModifyState "visitStmt -> FunCallStmt" ("SActions",str)]
        modify $ \symState ->
          SymState {
            -- alter :: Ord k => (Maybe a -> Maybe a) -> k -> Map k a -> Map k a 
            env = Map.alter (\case
                    Nothing -> Just $ SActions [str]
                    Just (SActions li) -> Just $ SActions $ li ++ [str]) Actions (env symState),
            pc = pc symState
          }
        tell [Log.Return "visitStmt -> FunCallStmt" (show toReturn)] $> toReturn
      ER_FunCall state -> do
        {-
        let actions = getActions state
        tell [Log.ModifyState "visitStmt -> FunCallStmt -> inheriting actions" ("Actions",show actions)]
        modify $ \symState ->
          SymState {
            env = Map.alter (\case
                    Nothing -> Just $ SActions actions
                    Just (SActions li) -> Just $ SActions $ li ++ actions) Actions (env symState),
            pc = pc symState
          }
         -}
        return ER_Void
      _ -> throwError $ "visitStmt ==> FunCallStmt ==> won't happen 1: " ++ show toReturn
  _ -> throwError $ "visitStmt ==> FunCallStmt ==> won't happen 2: " ++ show expr
visitStmt stmt = throwError $ "TODO -> visitStmt -> " ++ show stmt

{-
data Expression
  = NumberLiteral Float
  | BoolLiteral Bool
  | CharLiteral Char
  | StringLiteral String
  | Null
  | ArrayCallExpr {arrName :: Expression, index :: Maybe Expression}
  | ArrayInstantiationExpr {arrType :: Maybe (Type Types), arrSize :: Maybe Expression, arrElems :: [Expression]}
  | UnOpExpr {unOp :: UnOp, expr :: Expression}
  | CondExpr {eiff :: Expression, ethenn :: Expression, eelsee :: Expression}
  | ExcpExpr {excpName :: Exception, excpmsg :: Maybe String}
  | ReturnExpr {returnE :: Maybe Expression}
  deriving (Eq, Show)
-}
{-
data Types
  = Int
  | Void
  | Char
  | String
  | Boolean
  | Double
  | Short
  | Float
  | Long
  | Byte
-}
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
{-
data SymState = SymState
 { env :: Map.Map String SymExpr
 , methodType :: AST.Types
 , pc  :: [SymExpr]
 }
-}
-- FunCallExpr {funName :: Expression, funArgs :: [Expression]}
visitExpr (expr@AST.FunCallExpr{}) = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> FunCallExpr"]
  (_,cfgs) <- ask
  let funCallName = AST.getFunCallName $ AST.FunCallStmt expr
  -- Search for the CFG of the method call
  case CFG.findCFGByName funCallName cfgs of
    -- CFG found
    Just cfg0 -> do
      -- get SymState of the formal method call
      let (funCallLogs1,funCallSymState1) = runCFG cfgs cfg0 Nothing Nothing
      -- edit its logs
      mapM_ (\log -> tell [Log.Nested ("formal: " ++ funCallName) log]) funCallLogs1
      tell [Log.RunCFGFormalMethodCall (show funCallSymState1)]
      -- See if the method call has parameters
      case CFG.getCFGFormalParams cfg0 of
        -- if it has parameters
        formalParms -> do
          -- get the ExecutionResults of the actual parameters
          let actualParms :: [Method_R]
              actualParms = flip map (AST.funArgs expr) $ \exp ->
                let logging = Log.Nested (printf "SymExec of actual parameter: %s(%s)" funCallName (AST.getActualParmName exp))
                in censor (map logging) $ visitExpr exp
               
          tus <- zipWithM (\fParm act -> (,) (let Just t = AST.varType fParm in toSymType1 t,AST.getVarName fParm) <$> act)
                   formalParms
                   actualParms
          
          -- get SymState due to insertion of actual parameters
          let (funCallLogs2,funCallSymState2) = runSymState funCallSymState1 funCallName tus False
              actions = getActions funCallSymState2
          if null actions
            then return ER_Void
            else do
              tell [Log.ModifyState "visitExpr -> FunCallExpr -> inheriting actions" ("Actions",show actions)]
              modify $ \symState ->
                SymState {
                  env = Map.alter (\case
                          Nothing -> Just $ SActions actions
                          Just (SActions li) -> Just $ SActions $ li ++ actions) Actions (env symState),
                  pc = pc symState
                }
              return ER_Void
          -- edit its logs
          mapM_ (\log -> tell [Log.Nested ("actual: " ++ funCallName) log]) funCallLogs2
          tell [Log.RunSymStateActualMethodCall (show funCallSymState2)]
          let toReturn = ER_FunCall funCallSymState2
          tell [Log.Return "visitExpr -> FunCallExpr -> with parameters" (show toReturn)] $> toReturn
        -- if it has no parameters
        []   ->
          let actions = getActions funCallSymState1
          in case getReturnSymExpr funCallSymState1 of
          Just symExpr -> do
            let toReturn = ER_Expr symExpr
            modify $ \symState ->
              SymState {
                env = Map.alter (\case
                        Nothing -> Just $ SActions actions
                        Just (SActions li) -> Just $ SActions $ li ++ actions) Actions (env symState),
                pc = pc symState
              }
            tell [Log.Return "visitExpr -> FunCallExpr -> no parameters" (show toReturn)] $> toReturn
          Nothing      -> throwError "visitExpr ==> FunCallExpr ==> fun returns nothing ==> TODO"
    -- CFG not found
    Nothing
      | funCallName `elem` predefinedFuns -> do
          tell [Log.ProcessPredefinedFunCall "visitExpr ==> FunCallExpr" (show $ AST.funName expr) (show $ AST.funArgs expr)]
          -- get SymExprs of args
          funArgsExprs <- mapM (\ex -> do
            v <- visitExpr ex
            case v of
              ER_SymStateMapEntry _ val -> return val
              ER_Expr expr -> return expr
            ) $ AST.funArgs expr
          let toReturn = funCallCalculator (AST.getFunCallName $ AST.FunCallStmt expr,funArgsExprs)
          tell [Log.Return "visitExpr ==> FunCallExpr" (show toReturn)] $> toReturn
      | otherwise -> throwError $ "visitExpr => FunCallExpr: Method " ++ funCallName ++ " does not exist"
--BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
visitExpr expr@AST.BinOpExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> BinOpExpr"]
  one <- visitExpr (AST.expr1 expr)
  two <- visitExpr (AST.expr2 expr)
  tell [Log.Affected "visitExpr -> BinOpExpr" [show one,show $ AST.binOp expr,show two]]
  case (one,two) of
    (ER_Expr op1,ER_Expr op2) -> helper op1 op2
    (ER_SymStateMapEntry _ op1, ER_Expr op2) -> helper op1 op2
    (ER_Expr op1, ER_SymStateMapEntry _ op2) -> helper op1 op2
    (ER_Expr op1, fun@(ER_FunCall symState)) -> helper op1 (getReturnSymExpr symState)
    (fun@(ER_FunCall symState), ER_Expr op2) -> helper (getReturnSymExpr symState) op2
    (ER_SymStateMapEntry _ op1, ER_SymStateMapEntry _ op2) -> helper op1 op2
    _ -> throwError $ "visitExpr ~~> BinOpExpr: " ++ show (one,two)
  where
  helper :: SymExpr -> SymExpr -> Method_R
  helper op1 op2 =
    let isNumericOp = AST.binOp expr `elem` [AST.Plus, AST.Mult, AST.Minus, AST.Div]
        whichFun = case isNumericOp of
          True | all isSymString [op1,op2] -> stringCalculator
               | otherwise -> numericCalculator
          False -> booleanCalculator
        toReturn = ER_Expr $ whichFun (SBin (simplify op1) (toSymBinOp $ AST.binOp expr) (simplify op2))
    in tell [Log.Return (printf "visitExpr -> BinOpExpr -> %s"
                                (if isNumericOp then "numericCalculator"
                                 else "booleanCalculator")) (show toReturn)
            ] $> toReturn
  getReturnSymExpr :: SymState -> SymExpr
  getReturnSymExpr = maybe (error "visitExpr ~~> BinOpExpr ~~> getReturnSymExpr ~~> no return value found") id . (Map.!? Return) . env
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
       ER_Expr ex -> error $ printf "visitExpr ==> AssignExpr: (%s,%s,%s)" (show expr) (show ex) (show $ AST.assEleft expr)
  two <- visitExpr (AST.assEright expr)
  let e2 = case two of
          ER_Expr e2_ -> cast (toSymType2 one_val) e2_
          ER_FunCall funCallState ->
            case getReturnSymExpr funCallState of
              Nothing -> error $ printf "visitExpr ~~> AssignExpr ~~> won't happen"
              Just e2_ -> e2_
          ER_SymStateMapEntry _ e2_ -> e2_
  tell [Log.Affected "visitExpr -> AssignExpr" [show one, show two]]
  -- newVal is a transformation of e2. it's the new value
  -- inside of newVal, casting is done
  varNames <- getVarNames <$> get
  let newVal = case one of
        ER_ArrayCallExpr (SArrayIndexAccess arrName index) _ ->
          let Just theArray@(SymArray mt ml elems) = Map.lookup (VarName arrName) varNames
          in case index of
               SymInt num ->
                 let int = fromIntegral num
                 in SymArray mt ml (take int elems ++ [cast (toSymType2 one_val) e2] ++ drop (int+1) elems)
               _ -> error $ "TODO: visitExpr ==> AssignExpr: " ++ show index
        _ -> cast (toSymType2 one_val) e2
  -- inserting new value in map
  tell [Log.ModifyState "visitExpr -> AssignExpr" (show one_svn,show newVal)]
  modify $ \symState ->
    SymState {
      env = Map.insert one_svn newVal (env symState),
      pc = pc symState
    }
  let toReturn = ER_SymStateMapEntry one_svn e2
  tell [Log.Return "visitExpr -> AssignExpr" (show toReturn)] $> toReturn

-- VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
visitExpr expr@AST.VarExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> VarExpr"]
  case AST.varObj expr of
    [] -> do
      let varName_ = AST.varName expr
      case AST.varType expr of
        Nothing -> do
          tell [Log.UpdateVariable varName_ "visitExpr -> VarExpr"]
          mVal <- (Map.!? VarName varName_) <$> env <$> get
          case mVal of
            Just val -> do
              tell [Log.LookUpEnvTable varName_ (show val) "visitExpr -> VarExpr"]
              let toReturn = ER_SymStateMapEntry (VarName varName_) val
              tell [Log.Return "visitExpr -> VarExpr -> Updating" (show toReturn)] $> toReturn
            Nothing -> do
              tell [Log.GlobalVar varName_ "visitExpr -> VarExpr"]
              ER_FunHandle t _ <- getFunHandle
              let toReturn = ER_SymStateMapEntry (VarName varName_) (SymGlobalVar t varName_ Nothing)
              modify $ \symState -> SymState {
                env = recordGlobalVar varName_ (env symState),
                pc = pc symState
              }
              tell [Log.Return "visitExpr -> VarExpr -> Recording Global Variable" (show toReturn)] $> toReturn
        Just t -> do
          tell [Log.NewVariable (show t) varName_ "visitExpr -> VarExpr"]
          let sExpr = SymNull $ toSymType1 t
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
      --throwError $ "TODO: visitExpr ==> VarExpr ==> object access ==> " ++ (show $ li ++ [AST.varName expr]) ++ " ,,, " ++ show expr
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
  let symExpr = SException
        (case AST.excpName expr of
           AST.Exception str -> str
           _ -> error "visitExpr -> ExcpExpr -> won't happen")
        (case AST.excpmsg expr of
           Nothing -> ""
           Just str -> str)
  let toReturn = ER_Expr symExpr
  tell [Log.Return "visitExpr -> ExcpExpr" (show toReturn)] $> toReturn  
{-
ArrayInstantiationExpr {
  arrType = Just (ArrayType {baseType = BuiltInType Int}),
  arrSize = Nothing,
  arrElems = [NumberLiteral 6.0,NumberLiteral 5.0,NumberLiteral 4.0,NumberLiteral 7.0,NumberLiteral 8.0]
}
-}
-- SymArray SymType (Maybe Int) [SymExpr]
visitExpr expr@AST.ArrayInstantiationExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitStmt -> ArrayInstantiationExpr"]
  let mArrType = fmap toSymType1 $ AST.arrType expr
  -- process elements in the array, if they exist
  exprs <- flip mapM (AST.arrElems expr) $ \ex -> do
    er <- visitExpr ex
    case (er,mArrType) of
      (ER_Expr expr2,Nothing) -> return $ expr2
      (ER_Expr expr2,Just t) -> return $ cast t expr2
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
        (Just num,[]) -> replicate num (SymNull $ maybe (error "visitExpr ==> ArrayInstantiationExpr") (\(Array t) -> t) mArrType)
        (Just num,_) -> exprs
  let symExpr = SymArray
        mArrType
        m_arr_size
        exprs_
  --throwError $ "visitExpr ==> ArrayInstantiationExpr ==> " ++ show symExpr
  return $ ER_Expr symExpr
visitExpr expr = error $ "What this is: " ++ show expr

------------------------------

{-
data CFG = CFG {
  nodes :: [Node],
  edges :: [(NodeID,[NodeID])]
} deriving Show

----------

data Node = Entry | End {
    id :: NodeID,
    parent :: NodeID,
    mExpr :: Maybe AST.Expression
  } | Node {
    id :: NodeID,
    nodeData :: NodeData,
    parent :: NodeID
  } deriving Show

----------

data SymState = SymState
 { env :: Map.Map String SymExpr
 , pc  :: [SymExpr]
-}

type Path = [CFG.Node]
runCFG :: [CFG.CFG] -> CFG.CFG -> Maybe Path -> Maybe SymState -> ([Log.Log],SymState)
runCFG cfgs cfg mPath mSymState =
  let path :: [CFG.Node]
      path = maybe (CFG.getPath 0 cfg) id mPath
      runner = flip mapM_ path $ \node -> do
        tell [Log.NextNode (show node)]
        state <- get
        case getReturnSymExpr state of
          Just _ -> tell [Log.Skip $ printf "%s" (show node)] $> ER_Void
          Nothing -> getReader_Method_R $ visitNode node
      initialSymState = maybe (SymState (Map.insert (MethodName $ CFG.getCFGName cfg) (SMethodType $ toSymType1 $ CFG.getCFGType cfg) Map.empty) []) id mSymState
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
         in (logs,either error (const (SymState m2 ps)) ei)

