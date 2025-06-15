{-# Language LambdaCase #-}
module SymbolTable.VariablesCollector where

import Parser.Types as AST
import SymbolTable.Types as ST
import SymbolTable.API

newtype VariablesCollector = VariablesCollector ST.Scope

instance ASTVisitor VariablesCollector where
{-
data Scope = Scope {
  outsiderVars :: [Variable],
  size         :: Int,
  vars         :: [(Pos,Variable)],
  scopes       :: [(Pos,Kind,Scope)]
}
-}
--visitMethod :: AST.Method -> VariablesCollector
  visitMethod fun = VariablesCollector $ Scope {
  outsiderVars = map from_funarg_To_Var (funArgs $ funCall $ funDecl fun),
  size         = length $ statements $ funBody fun,
  vars         = map (\(pos,a) -> (pos,from_assign_to_Var a))
                 $ fst $ separate_stmts (funBody fun),
  scopes       = visitStatements
                 $ snd $ separate_stmts (funBody fun)
}
--visitStatement :: AST.Statement -> VariablesCollector
  visitStatement = undefined
--visitExpression :: AST.Expression -> VariablesCollector
  visitExpression = undefined

------------------------------
------------------------------
-----------helpers------------
------------------------------
------------------------------

-- | receives all statements in a scope,
-- | and separates them between variables and branches 
separate_stmts :: AST.Statement -> ([(Pos,AST.Statement)],[(Pos,AST.Statement)])
separate_stmts a@CompStmt{} =
  let enumerated = zip [1 ..] (statements a)
      vars_      = get_vars_from_block enumerated
      branches   = get_branches_from_block enumerated
  in (vars_,branches)
separate_stmts _ = error "this function is meant only for CompStmt"

-- | receives the body of some scope,
-- and calls the function `visitStatement` on each of them (only those with AssignStmt and branches),
-- | and calculates pos (mind CondStmt)
-- | and calculates outsiderVars in case of ForStmt
visitStatements :: [(ST.Pos,AST.Statement)] -> [(ST.Pos,ST.Kind,ST.Scope)]
--CondStmt {condition :: Expression, siff :: Statement, selsee :: Statement}
visitStatements ((pos, a@CondStmt{}) : rest) = undefined
--ForStmt {acc :: Statement, cond :: Expression, step :: Statement, forBody :: Statement}
visitStatements ((pos, a@ForStmt{}) : rest) = undefined
--WhileStmt {condition :: Expression, whileBody :: Statement}
--TryCatchStmt {tryBody :: Statement,
--              catchExcp :: Type Exception, catchBody :: Statement,
--              finallyBody :: Statement}
visitStatements ((pos, a@TryCatchStmt{}) : rest) = undefined
visitStatements [] = []
visitStatements (_ : rest) = visitStatements rest

-- receives method, and returns the its name
getMethodName :: AST.Method -> String
getMethodName m = case funName $ funCall $ funDecl m of
  a@AST.VarExpr{} -> varName a
  _               -> error "Every method has a name"

-- returns type of method
getMethodType :: AST.Method -> ST.Type
getMethodType m = case funName $ funCall $ funDecl m of
--VarExpr {varType :: Maybe (Type Types), varObj :: [String], varName :: String}
  a@AST.VarExpr{} -> case AST.varType a of
    Just t -> from_AST_to_type t
    _      -> error "Every method has a type"
  _        -> error "won't happen"

-- converts a type from AST to type from ST
from_AST_to_type :: AST.Type AST.Types -> ST.Type
from_AST_to_type = \case
  AST.BuiltInType t -> case t of
    AST.Int     -> ST.Int
    AST.Void    -> ST.Void
    AST.Char    -> ST.Char
    AST.String  -> ST.String
    AST.Boolean -> ST.Boolean
    AST.Double  -> ST.Double
    AST.Short   -> ST.Short
    AST.Float   -> ST.Float
    AST.Long    -> ST.Long
    AST.Byte    -> ST.Byte
  AST.AnyType{}   -> error "This won't be implemented for this master thesis"
  AST.ArrayType t -> ST.Array $ from_AST_to_type t

-- converts expressions of parameters to ST.variable
from_funarg_To_Var :: AST.Expression -> ST.Variable
from_funarg_To_Var a@AST.VarExpr{} = ST.Variable {
  name       = varName a,
  ST.varType = fmap from_AST_to_type (AST.varType a),
  val        = Nothing
}
from_funarg_To_Var a = error $ "This must be VarExpr, but it's " ++ show a

--------------------

-- returns only all AssignStmts 
get_vars_from_block :: [(Pos,AST.Statement)] -> [(Pos,AST.Statement)]
get_vars_from_block = filter $ \case
  (_,AssignStmt{}) -> True
  _                -> False

-- returns only all Statements with branches
get_branches_from_block :: [(Pos,AST.Statement)] -> [(Pos,AST.Statement)]
get_branches_from_block = filter $ \case
  (_,CondStmt{})     -> True
  (_,ForStmt{})      -> True
  (_,WhileStmt{})    -> True
  (_,TryCatchStmt{}) -> True
  _                  -> False
  
--------------------

-- converts AST.AssignStmt to ST.Variable
from_assign_to_Var :: AST.Statement -> ST.Variable
from_assign_to_Var a@AST.AssignStmt{} = case assign a of
  --AssignExpr {assEleft :: Expression, assEright :: Expression}
  --AssignExpr {
  --  assEleft = VarExpr {
  --    varType = Just (BuiltInType Int),
  --    varObj = [],
  --    varName = "x"
  --  },
  --  assEright = NumberLiteral 1.0
  --}
  b@AST.AssignExpr{} -> Variable {
    name       = varName $ assEleft b,
    ST.varType = fmap from_AST_to_type (AST.varType $ assEleft b),
    val        = Just $ assEright b
  }
  _                  -> error "Each AssignStmt contains AssignExpr"
from_assign_to_Var _ = error "this function is meant only for AssignStmt"
