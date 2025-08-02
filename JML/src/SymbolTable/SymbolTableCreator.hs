{-# Language LambdaCase #-}
module SymbolTable.SymbolTableCreator where

import Parser.Types as AST
import SymbolTable.Types as ST
import Visitors.API
import Data.List(foldl')

newtype SymbolTableCreator = SymbolTableCreator {symbolTable :: ST.Entry}

instance Show SymbolTableCreator where
  show (SymbolTableCreator entry) = show entry

instance ASTVisitor SymbolTableCreator where
--visitMethod :: AST.Method -> SymbolTableCreator
  visitMethod fun = 
    let (vars_,branches) = separate_stmts (funBody fun)
    in SymbolTableCreator $ ST.Scope {
         outsiderVars = map (symbolTable . visitStatement . AST.VarStmt) (funArgs $ funCall $ funDecl fun),
         size         = scopeSize $ statements $ funBody fun,
         vars         = map (\(pos,a) -> (pos,symbolTable $ visitStatement a)) vars_,
         scopes       = visitStatements branches
       }
--visitStatement :: AST.Statement -> SymbolTableCreator
  visitStatement a@AST.AssignStmt{} = case assign a of
    b@AST.AssignExpr{} ->
      let (name0,type0) = case assEleft b of
            c@VarExpr{}       -> (varName c, fmap from_AST_to_type (AST.varType c))
            c@ArrayCallExpr{} -> (varName $ arrName c, Nothing)
            _                 -> error "left operand of AssignExpr is either VarExpr or ArrayCallExpr"
      in SymbolTableCreator $ ST.Variable {
        name       = name0,
        ST.varType = type0,
        val        = Just $ assEright b
      }
    _ -> error "Each AssignStmt contains AssignExpr"
  visitStatement a@AST.VarStmt{} = SymbolTableCreator $ ST.Variable {
    name       = varName $ var a,
    ST.varType = fmap from_AST_to_type (AST.varType $ var a),
    val        = Nothing
  }
  visitStatement a@CompStmt{} =
    let (vars_,branches) = separate_stmts a
    in SymbolTableCreator $ ST.Scope { 
    --outsiderVars :: [Variable],
      outsiderVars = [],
    --size         :: Int,
      size         = scopeSize $ statements a,
    --vars         :: [(Pos,Variable)],
      vars         = map (\(pos,s) -> (pos,symbolTable $ visitStatement s)) vars_,
    --scopes       :: [(Pos,Kind,Scope)]
      scopes       = visitStatements branches
    }
  visitStatement _               = error "won't happen"

------------------------------
------------------------------
-----------helpers------------
------------------------------
------------------------------

-- | receives all statements in a scope,
-- | and separates them between variables and branches 
separate_stmts :: AST.Statement -> ([(ST.Pos,AST.Statement)],[(ST.Pos,AST.Statement)])
separate_stmts a@CompStmt{} =
  let enumerated = zip [1 ..] (statements a)
      vars_      = flip filter enumerated $ \case
          (_,AssignStmt{}) -> True
          (_,VarStmt{})    -> True
          _                -> False
      branches   = flip filter enumerated $ \case
          (_,CondStmt{})     -> True
          (_,ForStmt{})      -> True
          (_,WhileStmt{})    -> True
          (_,TryCatchStmt{}) -> True
          _                  -> False
  in (vars_,branches)
separate_stmts _ = error "this function is meant only for CompStmt"

-- | receives statements that have a body (a scope),
-- and calls the function `visitStatement` on each of them (only those with AssignStmt and branches),
-- | and calculates pos (mind CondStmt)
-- | and calculates outsiderVars in case of ForStmt
visitStatements :: [(Pos,AST.Statement)] -> [(ST.Pos,ST.Kind,ST.Entry)]
--CondStmt {condition :: Expression, siff :: Statement, selsee :: Statement}
visitStatements ((pos, a@CondStmt{}) : rest) =
  (pos, ST.If (condition a), symbolTable $ visitStatement (siff a))
  : (pos, ST.Else, symbolTable $ visitStatement (selsee a))
  : visitStatements (map (\(p,s) -> (p+2,s)) rest)
--WhileStmt {condition :: Expression, whileBody :: Statement}
visitStatements ((pos, a@WhileStmt{}) : rest) =
  (pos, ST.While (condition a), symbolTable $ visitStatement (whileBody a))
  : visitStatements rest
--ForStmt {acc :: Statement, cond :: Expression, step :: Statement, forBody :: Statement}
visitStatements ((pos, a@ForStmt{}) : rest) =
  (pos, ST.For (cond a),
   add_step_to_for_scope (step a) 
   $ add_acc_to_for_scope (acc a)
   $ symbolTable
   $ visitStatement (forBody a)
  ) : visitStatements rest
visitStatements ((pos, a@TryCatchStmt{}) : rest) =
  (pos, ST.Try, symbolTable $ visitStatement (tryBody a))
  : (pos, ST.Catch (catchExcp a), symbolTable $ visitStatement (catchBody a))
  : (pos, ST.Finally, symbolTable $ visitStatement (finallyBody a))
  : visitStatements (map (\(p,s) -> (p+3,s)) rest)
visitStatements [] = []
visitStatements (_ : rest) = visitStatements rest

-- | the accumulator in the for statement becomes an outsider variable
add_acc_to_for_scope :: AST.Statement -> ST.Entry -> ST.Entry
add_acc_to_for_scope a@AssignStmt{} scope_ = ST.Scope {
--outsiderVars :: [Variable],
  outsiderVars = [symbolTable $ visitStatement a],
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
add_step_to_for_scope :: AST.Statement -> ST.Entry -> ST.Entry
add_step_to_for_scope a@AssignStmt{} scope_ =
  let newSize = size scope_ + 1
  in Scope {
     --outsiderVars :: [Variable],
       outsiderVars = outsiderVars scope_,
     --size         :: Int,
       size         = newSize,
     --vars         :: [(Pos,Variable)],
       vars         = vars scope_ ++ [(newSize, symbolTable $ visitStatement a)],
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
  a@AST.AnyType{}
    | typee a == "String" -> ST.String
    | otherwise           -> error "This won't be implemented for this master thesis"
  AST.ArrayType t -> ST.Array $ from_AST_to_type t

scopeSize :: [AST.Statement] -> Int
scopeSize = foldl' f 0
  where
  f acc_ TryCatchStmt{} = acc_+2
  f acc_ _              = acc_+1
 
--------------------

exec :: AST.Method -> ST.Entry
exec = symbolTable . visitMethod

--------------------

