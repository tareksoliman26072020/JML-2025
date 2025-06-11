{-# Language MultiParamTypeClasses, FunctionalDependencies,
    TypeSynonymInstances, FlexibleInstances,
    LambdaCase #-}
module SymbolTable.API.Visitor where

import SymbolTable.API.SymbolTable
import qualified Parser.Types as AST
import Data.Map.Ordered (OMap(..), singleton, (>|), elemAt)

class Visitor k v e | k v -> e where
  enterMethod :: String -> OMap k v
  exitMethod  :: OMap k v -> OMap k v
  
  enterIf     :: OMap k v
  exitIf      :: OMap k v -> OMap k v
  
  enterElse   :: OMap k v
  exitElse    :: OMap k v -> OMap k v
  
  enterFor    :: OMap k v
  exitFor     :: OMap k v -> OMap k v
  
  enterWhile  :: OMap k v
  exitWhile   :: OMap k v -> OMap k v

  enterTry    :: OMap k v
  exitTry     :: OMap k v -> OMap k v

  enterCatch  :: OMap k v
  exitCatch   :: OMap k v -> OMap k v
  
  addToScope  :: OMap k v -> Int -> e -> OMap k v
  
  getMethodScope :: [OMap k v] -> Maybe (OMap k v)

------------------------------

-- type ScopeKey = (Int,Maybe String)
-- type ScopeValue = (Maybe SymbolType,ExplanationTag)
class Expression e where
  entryName :: e -> Maybe String
  entryType :: e -> Maybe SymbolType
class Statement s e | s -> e where
  isBranch :: s -> Bool
  getExpression :: s -> Maybe e
class Method m s e | m -> s e where
  getMethodNameExpr :: m -> e
  getMethodName :: m -> String
  getParameters :: m -> [e]
  getBlock :: m -> [s]

------------------------------

instance Expression AST.Expression where
  entryName = \case
  --VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
    a@AST.VarExpr{} -> Just $ AST.varName a
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
    _ -> undefined

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
  getMethodNameExpr m = AST.funName $ AST.funCall $ AST.funDecl m
  getMethodName m = AST.varName $ AST.funName $ AST.funCall $ AST.funDecl m
  getParameters m = AST.funArgs $ AST.funCall $ AST.funDecl m
  getBlock m = case AST.funBody m of
    a@AST.CompStmt{} -> AST.statements a
    _                -> error "it should be CompStmt"

------------------------------

instance Visitor ScopeKey ScopeValue AST.Expression where
--enterMethod :: String -> scope
  enterMethod name = singleton ((1,Just name),(Nothing,Enter MethodScope))
--exitMethod  :: scope -> scope
  exitMethod scope = scope >| ((length scope+1,Nothing),(Nothing,Exit MethodScope))
  
--enterIf     :: scope
  enterIf = singleton ((1,Nothing),(Nothing,Enter IfScope))
--exitIf      :: scope -> scope
  exitIf scope = scope >| ((length scope+1,Nothing),(Nothing,Exit IfScope))
  
--enterElse   :: scope
  enterElse = singleton ((1,Nothing),(Nothing,Enter ElseScope))
--exitElse    :: scope -> scope
  exitElse scope = scope >| ((length scope+1,Nothing),(Nothing,Exit ElseScope))

--enterFor    :: scope
  enterFor = singleton ((1,Nothing),(Nothing,Enter ForScope))
--exitFor     :: scope -> scope
  exitFor scope = scope >| ((length scope+1,Nothing),(Nothing,Exit ForScope))
  
--enterWhile  :: scope
  enterWhile = singleton ((1,Nothing),(Nothing,Enter WhileScope))
--exitWhile   :: scope -> scope
  exitWhile scope = scope >| ((length scope+1,Nothing),(Nothing,Exit WhileScope))

--enterTry    :: scope
  enterTry = singleton ((1,Nothing),(Nothing,Enter TryScope))
--exitTry     :: scope -> scope
  exitTry scope = scope >| ((length scope+1,Nothing),(Nothing,Exit TryScope))

--enterCatch  :: scope
  enterCatch = singleton ((1,Nothing),(Nothing,Enter CatchScope))
--exitCatch   :: scope -> scope
  exitCatch scope = scope >| ((length scope+1,Nothing),(Nothing,Exit CatchScope))
  
  addToScope scope num expr = scope >| ((num,entryName expr),(entryType expr,Parameter))

  -- The first entry in a method scope refers to it
  -- That's why 0
  -- elemAt :: OMap k v -> Index -> Maybe (k, v) 
  getMethodScope [] = Nothing
  getMethodScope (m:_) = case elemAt m 0 of
    Just (_, (_,Enter MethodScope)) -> Just m
    _                               -> Nothing

