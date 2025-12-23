{-# Language LambdaCase #-}
module SymbolicExecution.Method where

import qualified SymbolicExecution.Log as Log
import SymbolicExecution.Types
import qualified CFG.Types as CFG
import qualified Data.Map as Map
import Control.Monad.Reader (runReaderT)
import Control.Monad.State
import Control.Monad.Except
import Control.Monad (forM_, zipWithM)
import qualified Parser.Types as AST
import Visitors.API
import SymbolicExecution.MethodCall (runSymState)
import Control.Monad.Reader
import Control.Monad.Writer
import Text.Printf (printf)
import Data.Functor (($>))
import Data.List (foldl')
import SymbolicExecution.Internal.Internal
import SymbolicExecution.Internal.Calculator (numericCalculator, booleanCalculator)

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
                     ER_SymStateMapEntry name (SymNull symType) -> do
                       let newVal = SymFormalParam symType name Nothing
                       tell [Log.ModifyState "visitNode -> Entry -> method with args" (name,show newVal)]
                       modify $ \symState ->
                         SymState {
                           env = Map.insert name newVal (env symState),
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
        tell [Log.Return "visitNode -> Node -> Statement" (show toReturn)] $> toReturn
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      -- BooleanExpression Kind AST.Expression
      CFG.BooleanExpression CFG.If expr -> do
        tell [Log.MethodStatementIfCondition (printf "visitNode -> case nodeData of Node -> BooleanExpression If -> Node num: %d" (CFG.id n)) (show expr)]
        ER_FunHandle _ funName <- getFunHandle
        (_,cfgs) <- ask
        let cfg = case CFG.findCFGByName funName cfgs of
                    -- CFG not found
                    Nothing   -> error $ "visitNode -> Node -> BooleanExpression " ++ funName ++ " does not exist"
                    -- CFG found
                    Just cfg0 -> cfg0
            -- findEdge_via_id :: CFG -> NodeID -> Maybe (NodeID,[NodeID])
            branches = case CFG.findEdge_via_id cfg (CFG.id n) of
                      Just (_,xs) -> xs
                      Nothing     -> error $ "visitNode -> Node -> BooleanExpression -> won't happen"
        let branches_paths :: [[CFG.Node]]
            branches_paths = flip map branches $ \branchStartId ->
              let thePath = CFG.getPath branchStartId cfg
              in flip takeWhile thePath $ \case
                   CFG.Node _ (CFG.Meet CFG.If) _ -> False
                   _                              -> True
        ER_Expr expr2 <- visitExpr expr
        state <- get
        toReturn <- case expr2 of
              SBool b -> do
                let (logs,condSymState) = runCFG cfgs cfg (Just $ branches_paths !! (if b then 0 else 1)) (Just state)
                flip mapM_ logs $ \log ->
                  tell [Log.Nested (printf "%s statement" $ if b then "if" else "else") log]
                tell [Log.ModifyState (printf "visitNode -> Node -> BooleanExpression if -> overwriting %s" $ if b then "if" else "else") ("<new state>",show condSymState)]
                modify (const condSymState)
                return $ ER_State condSymState
              SBin _ _ _ -> do
                let (ifLogs,ifSymState) = runCFG cfgs cfg (Just $ branches_paths !! 0) (Just state)
                    (elseLogs,elseSymState) = runCFG cfgs cfg (Just $ branches_paths !! 1) (Just state)
                flip mapM_ ifLogs $ \log ->
                  tell [Log.Nested "if statement" log]
                flip mapM_ elseLogs $ \log ->
                  tell [Log.Nested "else statement" log]
                let symExpr = SIte expr2 ifSymState elseSymState
                tell [Log.ModifyState "visitNode -> Node -> BooleanExpression if -> recording symbolic branching" (show $ CFG.id n,show symExpr)]
                modify $ \symState ->
                  SymState {
                    env = Map.insert (show $ CFG.id n) symExpr (env symState),
                    pc = pc symState
                  }
                return (ER_Expr symExpr)
        
        tell [Log.Return "visitNode -> Node -> BooleanExpression" (show toReturn)] $> toReturn
      ----------------------------------------
      ----------------------------------------
      ----------------------------------------
      _ -> throwError
        $ "TODO -> visitNode -> Node -> nodeData -> otherwise" ++ show n

getFunHandle :: Method_R
getFunHandle = (\(Just t,Just k) -> ER_FunHandle t k)
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
  let symExpr = case er of
        ER_Expr symExpr_ -> symExpr_ 
        ER_SymStateMapEntry _ val -> val
        ER_FunCall funCallSymState -> case getReturnSymExpr funCallSymState of
          Just symExpr -> symExpr
          Nothing -> error $ "visitStmt ==> ReturnStmt: TODO: Nothing: \n" ++ show funCallSymState
        ER_FunCall funCallSymState -> error
          $ "visitStmt ==> ReturnStmt: " ++ (show $ env funCallSymState)
        x                -> error $ "visitStmt -> ReturnStmt -> won't happen: " ++ show x
  tell [Log.ModifyState "visitStmt -> ReturnStmt -> method with args" ("return",show symExpr)]
  modify $ \symState ->
    SymState {
      env = Map.insert "return" symExpr (env symState),
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
visitStmt _ = throwError "TODO -> visitStmt -> 2"

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
    -- CFG not found
    Nothing   -> throwError $ "visitExpr => FunCallExpr: Method " ++ funCallName ++ " does not exist"
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
          let (funCallLogs2,funCallSymState2) = runSymState funCallSymState1 funCallName tus
          -- edit its logs
          mapM_ (\log -> tell [Log.Nested ("actual: " ++ funCallName) log]) funCallLogs2
          tell [Log.RunSymStateActualMethodCall (show funCallSymState2)]
          let toReturn = ER_FunCall funCallSymState2
          tell [Log.Return "visitExpr -> FunCallExpr -> with parameters" (show toReturn)] $> toReturn
        -- if it has no parameters
        []   -> case getReturnSymExpr funCallSymState1 of
          Just symExpr -> 
            let toReturn = ER_Expr symExpr
            in tell [Log.Return "visitExpr -> FunCallExpr -> no parameters" (show toReturn)] $> toReturn
          Nothing      -> throwError "visitExpr ==> FunCallExpr ==> fun returns nothing ==> TODO"
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
          True -> numericCalculator
          False -> booleanCalculator
        toReturn = ER_Expr $ whichFun (SBin (simplify op1) (toSymBinOp $ AST.binOp expr) (simplify op2))
    in tell [Log.Return (printf "visitExpr -> BinOpExpr -> %s"
                                (if isNumericOp then "numericCalculator"
                                 else "booleanCalculator")) (show toReturn)
            ] $> toReturn
  getReturnSymExpr :: SymState -> SymExpr
  getReturnSymExpr = maybe (error "visitExpr ~~> BinOpExpr ~~> getReturnSymExpr ~~> no return value found") id . (Map.!? "return") . env
-- UnOpExpr {unOp :: UnOp, expr :: Expression}
visitExpr expr@AST.UnOpExpr{} = throwError "visitExpr ==> UnOpExpr ==> TODO"
-- AssignExpr {assEleft :: Expression, assEright :: Expression}
visitExpr expr@AST.AssignExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> AssignExpr"]
  one@(ER_SymStateMapEntry svn val) <- visitExpr (AST.assEleft expr)
--two@(ER_Expr e2) <- visitExpr (AST.assEright expr)
  two <- visitExpr (AST.assEright expr)
  let e2 = case two of
          ER_Expr e2_ -> e2_
          ER_FunCall funCallState ->
            case getReturnSymExpr funCallState of
              Nothing -> error $ printf "visitExpr ~~> AssignExpr ~~> won't happen"
              Just e2_ -> e2_
  tell [Log.Affected "visitExpr -> AssignExpr" [show one, show two]]
  let newVal = case val of
        SymFormalParam t n _ ->
          let v = cast (toSymType2 val) e2
          in SymFormalParam t n (Just v)
        SymGlobalVar t n _ ->
          let v = cast (toSymType2 val) e2
          in SymGlobalVar t n (Just v)
        _ -> cast (toSymType2 val) e2
  tell [Log.ModifyState "visitExpr -> AssignExpr" (svn,show newVal)]
  modify $ \symState ->
    SymState {
      env = Map.insert svn newVal (env symState),
      pc = pc symState
    }
  let toReturn = ER_SymStateMapEntry svn e2
  tell [Log.Return "visitExpr -> AssignExpr" (show toReturn)] $> toReturn

-- VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
visitExpr expr@AST.VarExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> VarExpr"]
  let varName_ = AST.varName expr
  case AST.varType expr of
    Nothing -> do
      tell [Log.UpdateVariable varName_ "visitExpr -> VarExpr"]
      mVal <- (Map.!? varName_) <$> env <$> get
      case mVal of
        Just val -> do
          tell [Log.LookUpEnvTable varName_ (show val) "visitExpr -> VarExpr"]
          let toReturn = ER_SymStateMapEntry varName_ val
          tell [Log.Return "visitExpr -> VarExpr -> Updating" (show toReturn)] $> toReturn
        Nothing -> do
          tell [Log.GlobalVar varName_ "visitExpr -> VarExpr"]
          ER_FunHandle t _ <- getFunHandle
          let toReturn = ER_SymStateMapEntry varName_ (SymGlobalVar t varName_ Nothing)
          tell [Log.Return "visitExpr -> VarExpr -> Recording Global Variable" (show toReturn)] $> toReturn
    Just t -> do
      tell [Log.NewVariable (show t) varName_ "visitExpr -> VarExpr"]
      let sExpr = SymNull $ toSymType1 t
      tell [Log.ModifyState "visitExpr -> VarExpr" (varName_,show sExpr)]
      modify $ \symState ->
        SymState {
          env = Map.insert varName_ sExpr (env symState),
          pc = pc symState
        }
      let toReturn = ER_SymStateMapEntry varName_ sExpr
      tell [Log.Return "visitExpr -> VarExpr -> Declaring Local Variable" (show toReturn)] $> toReturn
visitExpr expr@AST.ArrayCallExpr{} = throwError "TODO: visitExpr -> ArrayCallExpr"
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
    {-
      runner :: ReaderT (Config,[CFGT.CFG])
                        (ExceptT String (WriterT [Log] (StateT SymState (Either String))))
                        [ExecutionResult]
     -}
      runner = flip mapM path $ \node -> do
        tell [Log.NextNode (show node)]
        getReader_Method_R $ visitNode node
      initialSymState = maybe (SymState (Map.insert (CFG.getCFGName cfg) (SMethodType $ toSymType1 $ CFG.getCFGType cfg) Map.empty) []) id mSymState
      run_r :: ExceptT String (WriterT [Log.Log] (StateT SymState (Either String))) ()
      run_r = runReaderT (runner $> ()) (defaultConfig,cfgs)
      run_e :: WriterT [Log.Log] (StateT SymState (Either String)) (Either String ())
      run_e = runExceptT run_r
      run_w :: StateT SymState (Either String) (Either String (),[Log.Log])
      run_w = runWriterT run_e
      mRun_s :: Either String ((Either String (),[Log.Log]),SymState)
      mRun_s = runStateT run_w initialSymState
  in case mRun_s of
       Left str -> error str
       Right ((ei,logs),SymState m ps) ->
         let mReturnValue = --m Map.! "return"
                            m Map.!? "return"
             m2 = flip (Map.insert "return") m $
                    case (CFG.getCFGType cfg, mReturnValue) of
                      (AST.BuiltInType AST.Int, Just (SymNum float))    ->
                        SymInt (round float)
                      (AST.BuiltInType AST.Double, Just (SymNum float)) ->
                        SymDouble (realToFrac float)
                      (AST.BuiltInType AST.Float, Just (SymNum float))  ->
                        SymFloat float
                      (t, Nothing) ->
                        SymNull $ toSymType1 t
                      (_, Just expr)                  ->
                        expr
         in (logs,either error (const (SymState m2 ps)) ei)

