{-# Language LambdaCase #-}
module SymbolicExecution.SymbolicExecution where

import qualified SymbolicExecution.Log as Log
import SymbolicExecution.Types
import qualified CFG.Types as CFG
import qualified Data.Map as Map
import Control.Monad.Reader (runReaderT)
import Control.Monad.State
import Control.Monad.Except
import Control.Monad (forM_)
import qualified Parser.Types as AST
import Visitors.API
import Control.Monad.Reader
import Control.Monad.Writer
import Text.Printf (printf)
import Data.Functor (($>))
import Data.List (foldl')

instance CFGVisitor SymExec where
--visitNode :: CFG.Node -> SymExec
  visitNode node = SymExec $ tell [Log.HorizontalLine "visitNode"] >> case node of
    CFG.Entry t mn args -> do
      tell [Log.MethodStart mn "visitNode -> Entry"]
      case null args of
        True  -> return ()
        False -> do
          tell [Log.MethodFormalParams (show args) "visitNode -> Entry"]
          mapM visitExpr args $> ()
          mapM (\arg -> do
                   argVisited <- visitExpr arg
                   case argVisited of
                     ER_SymStateMapEntry name (SymNull symType) ->
                       modify $ \symState ->
                         SymState {
                           env = Map.insert name (SymFormalParam symType name) (env symState),
                           pc = pc symState
                         }
                     _ -> throwError "won't happen"
               ) args $> ()
      ER_State <$> get
    n@CFG.End{} -> do
      tell [Log.MethodEnd "visitNode -> End"]
      case CFG.mExpr n of
        Nothing       -> do
          tell [Log.Void "visitNode -> End -> return nothing"]
          ER_State <$> get
        a@(Just expr) -> do
          tell [Log.ReturnStatement (show expr) "visitNode -> End -> return something"]
          visitStmt (AST.ReturnStmt a)
{-
Node {
    id :: NodeID,
    nodeData :: NodeData,
    parent :: NodeID
  }

>>>>>>>>>> <<<<<<<<<<

data NodeData = ForInitialization AST.Expression
              | BooleanExpression Kind AST.Expression
              | ForStep AST.Statement 
              | TryNode | CatchNode (AST.Type AST.Exception) | FinallyNode
              | Meet Kind
-}
    n@CFG.Node{} -> case CFG.nodeData n of
      CFG.Statement stmt -> do
        tell [Log.MethodStatement "visitNode -> case nodeData of Node -> Statement"]
        visitStmt stmt
      _ -> throwError
        $ "TODO -> visitNode -> Node -> nodeData -> otherwise" ++ show n

visitStmt :: AST.Statement -> R
--ReturnStmt {returnS :: Maybe Expression}
visitStmt (AST.ReturnStmt (Just expr)) = do
  tell [Log.ReturnStatement (show expr) "visitStmt -> pattern matching: ReturnStmt"]
  er <- visitExpr expr
  let symExpr = case er of
        ER_Expr symExpr_ -> symExpr_ 
        er@ER_SymStateMapEntry{} -> symStateVal er
        ER_FunCall funCallSymState -> case getReturnSymExpr funCallSymState of
          Just symExpr -> symExpr
          Nothing -> error "visitStmt ==> ReturnStmt: TODO"
        ER_FunCall funCallSymState -> error
          $ "visitStmt ==> ReturnStmt: " ++ (show $ env funCallSymState)
        x                -> error $ "visitStmt -> ReturnStmt -> won't happen: " ++ show x
  modify $ \symState ->
    SymState {
      env = Map.insert "return" symExpr (env symState),
      pc = pc symState
    }
  ER_State <$> get
-- AssignStmt {varModifier :: [Modifier], assign :: Expression}
visitStmt stmt@AST.AssignStmt{} = do
  tell [Log.AssignStatement (show $ AST.assign stmt) "visitStmt -> pattern matching: AssignStmt"]
  (visitExpr $ AST.assign stmt) *> (ER_State <$> get)
-- VarStmt {var :: Expression}
visitStmt stmt@AST.VarStmt{} =
  (visitExpr $ AST.var stmt) *> (ER_State <$> get)
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
visitExpr :: AST.Expression -> R
visitExpr expr@(AST.NumberLiteral float) = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> pattern matching: NumberLiteral"]
  return $ ER_Expr (SymNum float)
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
  case CFG.findCFGByName funCallName cfgs of
    Nothing   -> throwError $ "Method " ++ funCallName ++ " does not exist"
    Just cfg0 ->
      let (_,funCallSymState) = runCFG cfgs cfg0
      in case CFG.getCFGFormalParams cfg0 of
        formalParms -> --throwError "visitExpr ==> FunCallExpr ==> TODO"
              -- [(formal parameters,actual parameters)] 
              --m = zip (map AST.getVarName args) (map AST.getVarName $ CFG.getCFGFormalParams cfg0)
          --visitFunCall (map AST.getVarName formalParms) (AST.funArgs expr)
          --get >>= \s -> throwError $ "visitExpr ==> FunCallExpr:\n" ++ show (env s)
          --throwError $ "visitExpr ==> FunCallExpr:\n" ++ show funCallSymState
          let zipped = zip (map AST.getVarName formalParms) (AST.funArgs expr)
          in insertActualParams zipped funCallSymState
        []   -> case getReturnSymExpr funCallSymState of
          Just symExpr -> return $ ER_Expr symExpr
          Nothing      -> throwError "visitExpr ==> FunCallExpr ==> fun returns nothing ==> TODO"
--BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
visitExpr expr@AST.BinOpExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> BinOpExpr"]
  one <- visitExpr (AST.expr1 expr)
  two <- visitExpr (AST.expr2 expr)
  case (one,two) of
    (ER_Expr op1,ER_Expr op2) -> f op1 op2
    (ER_SymStateMapEntry _ op1, ER_Expr op2) -> f op1 op2
    (ER_Expr op1, ER_SymStateMapEntry _ op2) -> f op1 op2
    _ -> throwError $ "visitExpr ~~> BinOpExpr: " ++ show (one,two)
  where
  f :: SymExpr -> SymExpr -> R
  f op1 op2 = case AST.binOp expr `elem` [AST.Plus, AST.Mult, AST.Minus, AST.Div] of
      True -> return $ ER_Expr $ getBinSymExpr (op1, op2) (AST.binOp expr)
      False -> throwError "TODO: visitExpr -> BinOpExpr"
-- UnOpExpr {unOp :: UnOp, expr :: Expression}
visitExpr expr@AST.UnOpExpr{} = throwError "visitExpr ==> UnOpExpr ==> TODO"
-- AssignExpr {assEleft :: Expression, assEright :: Expression}
visitExpr expr@AST.AssignExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> AssignExpr"]
  ER_SymStateMapEntry svn val <- visitExpr (AST.assEleft expr)
  ER_Expr e2 <- visitExpr (AST.assEright expr)
  tell [Log.Assign svn (show e2) "visitExpr -> AssignExpr"]
  modify $ \symState ->
    SymState {
      env = Map.insert svn (cast (toSymType2 val) e2) (env symState),
      pc = pc symState
    }
  return $ ER_SymStateMapEntry svn e2
-- VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
visitExpr expr@AST.VarExpr{} = do
  tell [Log.Expression_2_Handle (show expr) "visitExpr -> VarExpr"]
  let varName_ = AST.varName expr
  case AST.varType expr of
    Nothing -> do
      tell [Log.UpdateVariable varName_ "visitExpr -> VarExpr -> update variable"]
      val <- (Map.! varName_) <$> env <$> get
      tell [Log.LookUpEnvTable varName_ (show val) "visitExpr -> VarExpr -> update variable"]
      return $ ER_SymStateMapEntry varName_ val
    Just t -> do
      tell [Log.NewVariable (show t) varName_ "visitExpr -> VarExpr -> new variable"]
      let sExpr = SymNull $ toSymType1 t
      modify $ \symState ->
        SymState {
          env = Map.insert varName_ sExpr (env symState),
          pc = pc symState
        }
      return $ ER_SymStateMapEntry varName_ sExpr
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

runCFG :: [CFG.CFG] -> CFG.CFG -> ([Log.Log],SymState)
runCFG cfgs cfg =
  let path :: [CFG.Node]
      path = CFG.getPath 0 cfg
    {-
      runner :: ReaderT (Config,[CFGT.CFG])
                        (ExceptT String (WriterT [Log] (StateT SymState (Either String))))
                        [ExecutionResult]
     -}
      runner = flip mapM path $ \node -> do
        tell [Log.NextNode (show node)]
        getReader $ visitNode node
      initialSymState = SymState Map.empty []
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
         let returnValue = m Map.! "return"
             m2 = flip (Map.insert "return") m $
                    case (CFG.getCFGType cfg, returnValue) of
                      (AST.Int, SymNum float)    ->
                        SymInt (round float)
                      (AST.Double, SymNum float) ->
                        SymDouble (realToFrac float)
                      (AST.Float, SymNum float)  ->
                        SymFloat float
                      (_, expr)                  ->
                        expr
         in (logs,either error (const (SymState m2 ps)) ei)

getBinSymExpr :: (SymExpr, SymExpr) -> AST.BinOp -> SymExpr
getBinSymExpr (SymNum num1, SymNum num2) op =
  SymNum (getFractionalArithBinOp op num1 num2)
getBinSymExpr (SymInt num1, SymInt num2) op =
  SymInt (getIntegralArithBinOp op num1 num2)
getBinSymExpr (SymDouble num1, SymDouble num2) op =
  SymDouble (getFractionalArithBinOp op num1 num2)
getBinSymExpr (SymFloat num1, SymFloat num2) op =
  SymFloat (getFractionalArithBinOp op num1 num2)
getBinSymExpr (a@(SymFormalParam _ _), b@(SymFormalParam _ _)) op =
  SBin a (toSymBinOp op) b
getBinSymExpr (a@(SymGlobalVar _ _), b@(SymGlobalVar _ _)) op =
  SBin a (toSymBinOp op) b
----------
getBinSymExpr (SymNum num1, SymInt num2) op =
  SymInt (getIntegralArithBinOp op (round num1) num2)
getBinSymExpr (SymInt num1, SymNum num2) op =
  SymInt (getIntegralArithBinOp op num1 (round num2))
----------
getBinSymExpr (SymNum num1, SymDouble num2) op =
  SymDouble (getFractionalArithBinOp op (toDouble num1) num2)
getBinSymExpr (SymDouble num1, SymNum num2) op =
  SymDouble (getFractionalArithBinOp op num1 (toDouble num2))
----------
getBinSymExpr (SymNum num1, SymFloat num2) op =
  SymFloat (getFractionalArithBinOp op num1 num2)
getBinSymExpr (SymFloat num1, SymNum num2) op =
  SymFloat (getFractionalArithBinOp op num1 num2)
----------
getBinSymExpr (a, b@(SymFormalParam t _)) op = SBin (cast t a) (toSymBinOp op) b
getBinSymExpr (a@(SymFormalParam t _), b) op = SBin a (toSymBinOp op) (cast t b)
----------
getBinSymExpr (a, b@(SymGlobalVar t _)) op = SBin (cast t a) (toSymBinOp op) b
getBinSymExpr (a@(SymGlobalVar t _), b) op = SBin a (toSymBinOp op) (cast t b)
----------
getBinSymExpr tu _ = error $ "getBinSymExpr: " ++ show tu

-- The type of the variable in `symExpr` needs to conform to `symType`.
-- This matters in the context of `AssignExpr`
cast :: SymType -> SymExpr -> SymExpr
cast symType symExpr = case symExpr of
  SymNum _ -> case symType of
                Int    -> getBinSymExpr (symExpr, SymInt 0) AST.Plus
                Double -> getBinSymExpr (symExpr, SymDouble 0) AST.Plus
                Float  -> getBinSymExpr (symExpr, SymFloat 0) AST.Plus
                Bool   -> error "won't happen"
                Void   -> error "won't happen"
  a -> a

toDouble :: Float -> Double
toDouble = read . show

getIntegralArithBinOp :: Integral a => AST.BinOp -> (a -> a -> a)
getIntegralArithBinOp = \case
    AST.Plus  -> (+)
    AST.Mult  -> (*)
    AST.Minus -> (-)

getFractionalArithBinOp :: Fractional a => AST.BinOp -> (a -> a -> a)
getFractionalArithBinOp = \case
    AST.Plus  -> (+)
    AST.Mult  -> (*)
    AST.Minus -> (-)
    AST.Div   -> (/)

{-
1) When a function call with actual parameters is passed to visitExpr ==> FunCallExpr,
corresponding formal parameters are paired to their actual parameters,
they are then passed to `insertActualParams` along with the state of this function call.

2) `insertActualParams` alters this state so that every presence of the formal parameters
is replaced with actual parameters.

3) In the end this function releases the ExecutionResult `ER_FunCall` which encapsulates
the state of this funcation call after it was altered using the actual parameters

4) This altered state may still have non-atomic ExecutionResults which then will processed 
using `visitSymExpr`
-}
-- This function will only be used within visitExpr ==> FunCallExpr
-- upon calling a function with actual parameters.
{-
("i",VarExpr {varType = Nothing, varObj = [], varName = "i"}) ==>
("i",ER_SymStateMapEntry {symStateKey = "i", symStateVal = SymFormalParam Int "i"})

[("i",SymFormalParm Int "i"),("return",SymFormalParm Int "i")] ==>
[
("i",SymActualParam {
   symActualParam = Int,
   symFormalParamName = "i",
   symActualParamName = SymFormalParam Int "i"
 }),
("return",SymActualParam {
   symActualParam = Int,
   symFormalParamName = "i",
   symActualParamName = SymFormalParam Int "i"
 }
)
]
-}
                     -- formalParms  actualParms
insertActualParams :: [(String     , AST.Expression)] -> SymState -> R
insertActualParams tus funCallState = do
  tus2 <- mapM (\(a,b) -> ((,) a) <$> visitExpr b) tus
  {-
  tus = [
    ("i",ER_SymStateMapEntry {symStateKey = "i", symStateVal = SymFormalParam Int "i"})
  ]
  -}
  -- `newFunCallEnv` is the new adjustment of `funCallEnv`
  -- that I get after I insert actual parameters
  let newFunCallEnv = flip Map.map (env funCallState) $ \case
        SymFormalParam symType formalParam -> case lookup formalParam tus2 of
          Just er@ER_SymStateMapEntry{} -> SymActualParam symType formalParam (symStateVal er)
          Nothing -> error "won't happen"
        ex -> ex
  return $ ER_FunCall $ SymState newFunCallEnv (pc funCallState)

-----------------------------
-----------------------------
-----------------------------

--instance CFGVisitor SymExec where
