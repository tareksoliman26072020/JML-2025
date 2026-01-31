{-# Language LambdaCase #-}
module SymbolicExecution.Logs.Log where

import Text.Printf (printf)
import Data.List (foldl', intercalate)
-- "\ESC[1;31mTarek\ESC[m"
data Log = Expression_2_Handle String String
         | MethodStart String String
         | MethodEnd String
         | Void String
         | ReturnStatement String String
         | Edge_2_Handle String String
         | Node_2_Handle String String
         | HorizontalLine String
         | MethodStatement String String
         | AssignStatement String String
         | NewVariable String String String
         | UpdateVariable (String,String,String) String
         | LookUpEnvTable String String String
         | NextNode String
         | ForStatementHasNoAccumulationVariable String
         | MethodFormalParams String String
         | NextMethodCallSymExpr String (String,String)
         | Affected String [String]
         | ModifyState String (String,String)
         | StateNotModified String
         | NoElseBranch String
         | AddVarBinding String String
         | AddVarAssignment String String
         | ReportTheState String
         | Skip String
         | ForLoopDone String
         | UnvisitedForLoop String String
         | ForLoopConditionUndetermined String String
         | ForLoopRound Int String
         | ForLoopLimitReached String
         | Return String String
         | RunCFGFormalMethodCall String
         | RunSymStateActualMethodCall String
         | Nested String Log
         | SymExpr_2_Handle String String
         | GlobalVar String String
         | Meow String String
         | MethodStatementIfCondition String String
         | ProcessPredefinedFunCall String String String
         deriving (Show,Eq)


-- Look up the usage of the function `tell` in SymbolicExecution
-- to best relate to `Log`
ppLog :: Log -> String
ppLog = \case
    MethodEnd loc           -> printf "(%s): %s" loc "Method End"
    Void loc                -> printf "(%s): %s" loc "Void"
    MethodStart str loc     -> printf "(%s): %s: %s" loc "Method Start" str
    MethodStatement loc str -> printf "(%s): %s: %s" loc "Method Statement" str
    MethodStatementIfCondition loc str
                            -> printf "(%s): %s: %s" loc "If condition" str
    Expression_2_Handle
      str loc               -> printf "(%s): %s: %s" loc "handling expression" str
    SymExpr_2_Handle
      str loc               -> printf "(%s): %s: %s" loc "handling SymExpr" str
    ReturnStatement str loc -> printf "(%s): %s: %s" loc "handling return expression" str
    AssignStatement str loc -> printf "(%s): %s: %s" loc "handling assign statement" str
    Edge_2_Handle str loc   -> printf "(%s): %s: %s" loc "running CFG" str
    Meow str1 str2          -> printf "Meow: %s %s" str1 str2
    HorizontalLine str      -> printf ">>>>>>>>>> %s <<<<<<<<<<" str
    NewVariable tn vn loc   -> printf "(%s): %s %s %s" loc "New Variable" tn vn
    UpdateVariable (vn,old,new) loc
                            -> printf "(%s): %s\n    %s: %s\n    %s: %s\n    %s: %s" loc "Update Variable"
                                 "Var Name" vn
                                 "Old Value" old
                                 "New Value" new
    LookUpEnvTable
      key val loc           -> printf "(%s): %s: (%s ~~> %s) " loc "Look up in environmane table" key val
    GlobalVar key loc       -> printf "(%s): %s: %s " loc "Global Variable Detected" key
    MethodFormalParams
      args loc              -> printf "(%s): %s: %s" loc "Visiting formal parameters" args
    NextNode nodeStr        -> printf "%s: %s" "Next Node" nodeStr
    NextMethodCallSymExpr methodCall (key,symExpr)
                            -> printf "%s (%s ==> %s) in Method Call: %s" "Next symExpr" key symExpr methodCall
    Affected loc exprs      -> printf "(%s): %s: %s" loc "Affected" (intercalate ", " exprs)
    ProcessPredefinedFunCall
      loc funName funArgs   -> printf "(%s): %s: %s%s" loc "Processing Predefined FunCall" funName funArgs
    ModifyState loc (k,v)   -> printf "(%s): %s: (%s,%s)" loc "Modifying State" k v
    ForStatementHasNoAccumulationVariable loc
                            -> printf "(%s): %s" loc "For statement has no Accumulation variable"
    StateNotModified loc    -> printf "(%s): %s" loc "State Not Modified"
    NoElseBranch loc        -> printf "(%s): %s" loc "No Else Branch"
    AddVarBinding loc val   -> printf "(%s): %s: %s" loc "Adding Var Binding" val
    AddVarAssignment loc val-> printf "(%s): %s: %s" loc "Adding Var Assignment" val
    ReportTheState s        -> printf "(%s):\n%s" "Reporting The State" (show s)
    Skip thing              -> printf "(%s):\n%s" "Skip" (show thing)
    ForLoopDone loc         -> printf "(%s): %s" loc "For Loop Done"
    UnvisitedForLoop loc expr
                            -> printf "(%s): %s: %s" loc "Unregistered For Loop" expr
    ForLoopConditionUndetermined loc val
                            -> printf "(%s): %s: %s" loc "For Loop Condition Undetermined" val
    ForLoopRound n loc      -> printf "(%s): %s: %d" loc "For Loop cound" n
    ForLoopLimitReached loc -> printf "(%s): %s" loc "For Loop limit reached"
    Return loc val          -> printf "(%s): %s: %s" loc "Returning" val
    RunCFGFormalMethodCall
      symState              -> printf "%s: %s" "Method Call formal SymState" symState
    RunSymStateActualMethodCall
      symState              -> printf "%s: %s" "Method Call actual SymState" symState
    Nested funCallTag log   -> printf "%s ==> %s" funCallTag (ppLog log)

