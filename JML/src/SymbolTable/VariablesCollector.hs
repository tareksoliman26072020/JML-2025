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
  visitMethod fun = 
    let (vars_,branches) = separate_stmts (funBody fun)
    in VariablesCollector $ Scope {
         outsiderVars = map from_funarg_To_Var (funArgs $ funCall $ funDecl fun),
         size         = length $ statements $ funBody fun,
         vars         = map (\(pos,a) -> (pos,from_assign_to_Var a)) vars_,
         scopes       = visitStatements branches
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

-- | receives statements that have a body (a scope),
-- and calls the function `visitStatement` on each of them (only those with AssignStmt and branches),
-- | and calculates pos (mind CondStmt)
-- | and calculates outsiderVars in case of ForStmt
visitStatements :: [(ST.Pos,AST.Statement)] -> [(ST.Pos,ST.Kind,ST.Scope)]
--CondStmt {condition :: Expression, siff :: Statement, selsee :: Statement}
visitStatements ((pos, a@CondStmt{}) : rest) =
  (pos, ST.If (condition a), from_compStmt_to_scope (siff a))
  : (pos+1, ST.Else, from_compStmt_to_scope (selsee a))
  : visitStatements (map (\(p,s) -> (p+1,s)) rest)
--WhileStmt {condition :: Expression, whileBody :: Statement}
visitStatements ((pos, a@WhileStmt{}) : rest) =
  (pos, ST.While (condition a), from_compStmt_to_scope (whileBody a))
  : visitStatements rest
--ForStmt {acc :: Statement, cond :: Expression, step :: Statement, forBody :: Statement}
visitStatements ((pos, a@ForStmt{}) : rest) =
  (pos, ST.For (cond a),
   add_step_to_for_scope (step a) 
   $ add_acc_to_for_scope (acc a)
   $ from_compStmt_to_scope (forBody a)
  ) : visitStatements rest
--WhileStmt {condition :: Expression, whileBody :: Statement}
--TryCatchStmt {tryBody :: Statement,
--              catchExcp :: Type Exception, catchBody :: Statement,
--              finallyBody :: Statement}
visitStatements ((pos, a@TryCatchStmt{}) : rest) = undefined
visitStatements [] = []
visitStatements (_ : rest) = visitStatements rest

-- | converts the bodis of if, else, while, for to ST.Scope
from_compStmt_to_scope :: AST.Statement -> ST.Scope
from_compStmt_to_scope al@CompStmt{} =
  let (vars_,branches) = separate_stmts al
  in ST.Scope { 
  --outsiderVars :: [Variable],
    outsiderVars = [],
  --size         :: Int,
    size         = length $ statements al,
  --vars         :: [(Pos,Variable)],
    vars         = map (\(pos,a) -> (pos,from_assign_to_Var a)) vars_,
  --scopes       :: [(Pos,Kind,Scope)]
    scopes       = visitStatements branches
  }
from_compStmt_to_scope _ = error "this function is meant only for CompStmt"

-- | the accumulator in the for statement becomes an outsider variable
add_acc_to_for_scope :: AST.Statement -> ST.Scope -> ST.Scope
add_acc_to_for_scope a@AssignStmt{} scope_ = ST.Scope {
--outsiderVars :: [Variable],
  outsiderVars = [from_assign_to_Var a],
--size         :: Int,
  size         = size scope_,
--vars         :: [(Pos,Variable)],
  vars         = vars scope_,
--scopes       :: [(Pos,Kind,Scope)]
  scopes       = scopes scope_
}
add_acc_to_for_scope _ _ = error "This function is only meant for AssignStmt"

-- | the step in the for statement becomes an outsider variable
-- AssignStmt {varModifier :: [Modifier], assign :: Expression}
add_step_to_for_scope :: AST.Statement -> ST.Scope -> ST.Scope
add_step_to_for_scope a@AssignStmt{} scope_ =
  let newSize = size scope_ + 1
  in ST.Scope {
     --outsiderVars :: [Variable],
       outsiderVars = outsiderVars scope_,
     --size         :: Int,
       size         = newSize,
     --vars         :: [(Pos,Variable)],
       vars         = vars scope_ ++ [(newSize, from_assign_to_Var a)],
     --scopes       :: [(Pos,Kind,Scope)]
       scopes       = scopes scope_
  }
add_step_to_for_scope _ _ = error "This function is only meant for AssignStmt"

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
