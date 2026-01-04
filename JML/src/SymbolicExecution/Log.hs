{-# Language LambdaCase #-}
module SymbolicExecution.Log where

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
         | UpdateVariable String String
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
         | Return String String
         | RunCFGFormalMethodCall String
         | RunSymStateActualMethodCall String
         | Nested String Log
         | SymExpr_2_Handle String String
         | GlobalVar String String
         | Meow String String
         | MethodStatementIfCondition String String
         | ProcessPredefinedFunCall String String String
         deriving Eq

-- Look up the usage of the function `tell` in SymbolicExecution
-- to best relate to `Log`
instance Show Log where
  show = \case
    MethodEnd loc           -> printf "(%s): %s" (cyan loc) (yellow "Method End")
    Void loc                -> printf "(%s): %s" (cyan loc) (yellow "Void")
    MethodStart str loc     -> printf "(%s): %s: %s" (cyan loc) (yellow "Method Start") str
    MethodStatement loc str -> printf "(%s): %s: %s" (cyan loc) (yellow "Method Statement") str
    MethodStatementIfCondition loc str
                            -> printf "(%s): %s: %s" (cyan loc) (yellow "If condition") str
    Expression_2_Handle
      str loc               -> printf "(%s): %s: %s" (cyan loc) (yellow "handling expression") str
    SymExpr_2_Handle
      str loc               -> printf "(%s): %s: %s" (cyan loc) (yellow "handling SymExpr") str
    ReturnStatement str loc -> printf "(%s): %s: %s" (cyan loc) (yellow "handling return expression") str
    AssignStatement str loc -> printf "(%s): %s: %s" (cyan loc) (yellow "handling assign statement") str
    Edge_2_Handle str loc   -> printf "(%s): %s: %s" (cyan loc) (yellow "running CFG") str
    Meow str1 str2          -> printf "Meow: %s %s" str1 str2
    HorizontalLine str      -> printf ">>>>>>>>>> %s <<<<<<<<<<" (yellow str)
    NewVariable tn vn loc   -> printf "(%s): %s %s %s" (cyan loc) (yellow "New Variable") tn vn
    UpdateVariable vn loc   -> printf "(%s): %s %s" (cyan loc) (yellow "Update Variable") vn
    LookUpEnvTable
      key val loc           -> printf "(%s): %s: (%s ~~> %s) " (cyan loc) (yellow "Look up in environmane table") key val
    GlobalVar key loc       -> printf "(%s): %s: %s " (cyan loc) (yellow "Global Variable Detected") key
    MethodFormalParams
      args loc              -> printf "(%s): %s: %s" (cyan loc) (yellow "Visiting formal parameters") args
    NextNode nodeStr        -> printf "%s: %s" (yellow "Next Node") nodeStr
    NextMethodCallSymExpr methodCall (key,symExpr)
                            -> printf "%s (%s ==> %s) in Method Call: %s" (yellow "Next symExpr") key symExpr methodCall
    Affected loc exprs      -> printf "(%s): %s: %s" (cyan loc) (yellow "Affected") (intercalate ", " exprs)
    ProcessPredefinedFunCall
      loc funName funArgs   -> printf "(%s): %s: %s%s" (cyan loc) (yellow "Processing Predefined FunCall") funName funArgs
    ModifyState loc (k,v)   -> printf "(%s): %s: (%s,%s)" (cyan loc) (yellow "Modifying State") k v
    ForStatementHasNoAccumulationVariable loc
                            -> printf "(%s): %s" (cyan loc) (yellow "For statement has no Accumulation variable")
    StateNotModified loc    -> printf "(%s): %s" (cyan loc) (yellow "State Not Modified")
    NoElseBranch loc        -> printf "(%s): %s" (cyan loc) (yellow "No Else Branch")
    AddVarBinding loc val   -> printf "(%s): %s: %s" (cyan loc) (yellow "Adding Var Binding") val
    AddVarAssignment loc val-> printf "(%s): %s: %s" (cyan loc) (yellow "Adding Var Assignment") val
    ReportTheState s        -> printf "(%s):\n%s" (yellow "Reporting The State") (show s)
    Skip thing              -> printf "(%s):\n%s" (yellow "Skip") (show thing)
    Return loc val          -> printf "(%s): %s: %s" (cyan loc) (yellow "Returning") val
    RunCFGFormalMethodCall
      symState              -> printf "%s: %s" (yellow "Method Call formal SymState") symState
    RunSymStateActualMethodCall
      symState              -> printf "%s: %s" (yellow "Method Call actual SymState") symState
    Nested funCallTag log   -> printf "%s ==> %s" (red funCallTag) (show log)

cyan :: String -> String
cyan = printf "\ESC[1;36m%s\ESC[m"

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

red :: String -> String
red = printf "\ESC[1;41m%s\ESC[m"

ppLogs :: [Log] -> [String]
ppLogs = snd . foldl' enumerated (1,[])
  where
  enumerated :: (Int,[String]) -> Log -> (Int,[String])     
  enumerated (num,res) log@(HorizontalLine _) = (num,res ++ [show log])
  enumerated (num,res) x = (num+1,res ++ [printf "%d) %s" num (show x)])
