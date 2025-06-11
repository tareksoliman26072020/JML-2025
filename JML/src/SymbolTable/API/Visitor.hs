{-# Language MultiParamTypeClasses, FunctionalDependencies,
    TypeSynonymInstances, FlexibleInstances,
    LambdaCase #-}
module SymbolTable.API.Visitor where

import SymbolTable.API.SymbolTable
import qualified Parser.Types as AST-- (ExternalDeclaration(..), Statement(..), Expression(..))
import Data.Map.Ordered ((>|),singleton)

class Visitor sc where
  enterMethod :: sc
  exitMethod  :: sc -> sc
  
  enterIf     :: sc
  exitIf      :: sc -> sc
  
  enterElse   :: sc
  exitElse    :: sc -> sc
  
  enterFor    :: sc
  exitFor     :: sc -> sc
  
  enterWhile  :: sc
  exitWhile   :: sc -> sc

  enterTry    :: sc
  exitTry     :: sc -> sc

  enterCatch  :: sc
  exitCatch   :: sc -> sc

------------------------------

class Expression e where
  entryName :: e -> String
  entryType :: e -> Maybe SymbolType
class Statement s e | s -> e where
  isBranch :: s -> Bool
  getExpression :: s -> Maybe e
class Method m s e | m -> s e where
  getParameters :: m -> [e]
  getBlock :: m -> [s]

------------------------------

instance Expression AST.Expression where
{-
  = NumberLiteral Float
  | BoolLiteral Bool
  | CharLiteral Char
  | StringLiteral String
  | Null
  | ArrayInstantiationExpr {arrType :: Maybe (Type Types), arrSize :: Maybe Expression, arrElems :: [Expression]}
  | ArrayCallExpr {arrName :: Expression, index :: Maybe Expression}
  | BinOpExpr {expr1 :: Expression, binOp :: BinOp, expr2 :: Expression}
  | UnOpExpr {unOp :: UnOp, expr :: Expression}
  | FunCallExpr {funName :: Expression, funArgs :: [Expression]}
  | CondExpr {eiff :: Expression, ethenn :: Expression, eelsee :: Expression}
  | AssignExpr {assEleft :: Expression, assEright :: Expression}
  | ExcpExpr {excpName :: Exception, excpmsg :: Maybe String}
  | ReturnExpr {returnE :: Maybe Expression}
-}
  entryName = \case
  --VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
    a@AST.VarExpr{} -> AST.varName a
    _               -> undefined
  entryType = \case
    --VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
    a@AST.VarExpr{} -> do
      t <- AST.varType a -- :: Maybe (AST.Type AST.Types)
      return $ from_type t
      where from_type = \case
              --BuiltInType a
              AST.BuiltInType t -> from_built_in_type t
              --AnyType {typee :: String, generic :: Maybe (Type a)}
              AST.AnyType{}    -> undefined
              --ArrayType {baseType :: Type a}
              AST.ArrayType bt -> Array $ from_type bt
            from_built_in_type = \case
              AST.Int     -> Int
              AST.Void    -> Void
              AST.Char    -> Char
              AST.String  -> String
              AST.Boolean -> Boolean
              AST.Double  -> Double
              AST.Short   -> Short
              AST.Float   -> Float
              AST.Long    -> Long
              AST.Byte    -> Byte
    _ -> error "TODO"

------------------------------

instance Statement AST.Statement AST.Expression where
  isBranch = \case
    --CondStmt {condition :: Expression, siff :: Statement, selsee :: Statement}
    AST.CondStmt{}     -> True
    --ForStmt {acc :: Statement, cond :: Expression, step :: Statement, forBody :: Statement}
    AST.ForStmt{}      -> True
    --WhileStmt {condition :: Expression, whileBody :: Statement}
    AST.WhileStmt{}    -> True
    --TryCatchStmt {tryBody :: Statement,
    --              catchExcp :: Type Exception, catchBody :: Statement,
    --              finallyBody :: Statement}
    AST.TryCatchStmt{} -> True
    _                  -> False
    
  getExpression s
    | isBranch s = error "it must denote a singular expression"
    | otherwise = case s of
        --VarStmt {var :: Expression}
        AST.VarStmt expr      -> Just expr
        --AssignStmt {varModifier :: [Modifier], assign :: Expression}
        AST.AssignStmt _ expr -> Just expr
        --FunCallStmt {funCall :: Expression}
        AST.FunCallStmt expr  -> Just expr
        --ReturnStmt {returnS :: Maybe Expression}
        AST.ReturnStmt mExpr  -> mExpr
        _                     -> error "it should be var or assign or funcall or return"

instance Method AST.ExternalDeclaration AST.Statement AST.Expression where
  getParameters m = AST.funArgs $ AST.funCall $ AST.funDecl m
  getBlock m = case AST.funBody m of
    a@AST.CompStmt{} -> AST.statements a
    _                -> error "it should be CompStmt"

------------------------------

instance Visitor Scope where
--enterMethod :: SymbolTable
  enterMethod = singleton ((1,Nothing),(Nothing,Enter MethodScope))
--exitMethod  :: v -> v
  exitMethod st = st >| ((length st+1,Nothing),(Nothing,Exit MethodScope))
  
--enterIf     :: v
  enterIf = singleton ((1,Nothing),(Nothing,Enter IfScope))
--exitIf      :: v -> v
  exitIf st = st >| ((length st+1,Nothing),(Nothing,Exit IfScope))
  
--enterElse   :: v
  enterElse = singleton ((1,Nothing),(Nothing,Enter ElseScope))
--exitElse    :: v -> v
  exitElse st = st >| ((length st+1,Nothing),(Nothing,Exit ElseScope))

--enterFor    :: v
  enterFor = singleton ((1,Nothing),(Nothing,Enter ForScope))
--exitFor     :: v -> v
  exitFor st = st >| ((length st+1,Nothing),(Nothing,Exit ForScope))
  
--enterWhile  :: v
  enterWhile = singleton ((1,Nothing),(Nothing,Enter WhileScope))
--exitWhile   :: v -> v
  exitWhile st = st >| ((length st+1,Nothing),(Nothing,Exit WhileScope))

--enterTry    :: v
  enterTry = singleton ((1,Nothing),(Nothing,Enter TryScope))
--exitTry     :: v -> v
  exitTry st = st >| ((length st+1,Nothing),(Nothing,Exit TryScope))

--enterCatch  :: v
  enterCatch = singleton ((1,Nothing),(Nothing,Enter CatchScope))
--exitCatch   :: v -> v
  exitCatch st = st >| ((length st+1,Nothing),(Nothing,Exit CatchScope))

