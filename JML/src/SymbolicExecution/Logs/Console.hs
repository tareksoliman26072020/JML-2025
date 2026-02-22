{-# Language LambdaCase #-}
module SymbolicExecution.Logs.Console where
import SymbolicExecution.Logs.Log
import Text.Printf (printf)
import Data.List (intercalate)

cyan :: String -> String
cyan = printf "\ESC[1;36m%s\ESC[m"

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

red :: String -> String
red = printf "\ESC[1;41m%s\ESC[m"

ppConsoleLog :: Log -> String
ppConsoleLog (Log counter logTag) = printf "%s. %s" counter (ppConsoleLogTag logTag)

ppConsoleLogTag :: LogTag -> String
ppConsoleLogTag = \case
    FunHandle loc name t    -> printf "(%s): %s: %s %s"
        (cyan loc) (yellow "Fun infos") (show t) name
    MethodEnd loc           -> printf "(%s): %s" (cyan loc) (yellow "Method End")
    Void loc                -> printf "(%s): %s" (cyan loc) (yellow "Void")
    Location loc            -> printf "%s: %s" (yellow "Location") (cyan loc)
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
    ActualParameterDetected
              tn vn val loc -> printf "(%s): %s %s %s ==> %s" (cyan loc) (yellow "Actual Parameter Detected") tn vn val
    UpdateVariable (vn,old,new) loc
                            -> printf "(%s): %s\n    %s: %s\n    %s: %s\n    %s: %s" (cyan loc) (yellow "Update Variable")
                                 (yellow "Var Name") vn
                                 (yellow "Old Value") old
                                 (yellow "New Value") new
    LookUpEnvTable
      key val loc           -> printf "(%s): %s: (%s ~~> %s) " (cyan loc) (yellow "Look up in environmane table") key val
    GlobalVar key loc       -> printf "(%s): %s: %s " (cyan loc) (yellow "Global Variable Detected") key
    GlobalVars key loc      -> printf "(%s): %s: %s " (cyan loc) (yellow "Global Variables") key
    MethodFormalParams
      args loc              -> printf "(%s): %s: %s" (cyan loc) (yellow "formal parameters") args
    MethodActualParms
      args loc              -> printf "(%s): %s: %s" (cyan loc) (yellow "actual parameters") args
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
    ForLoopDone loc         -> printf "(%s): %s" (cyan loc) (yellow "For Loop Done")
    UnvisitedForLoop loc expr
                            -> printf "(%s): %s: %s" (cyan loc) (yellow "Unregistered For Loop") expr
    ForLoopConditionUndetermined loc val
                            -> printf "(%s): %s: %s" (cyan loc) (yellow "For Loop Condition Undetermined") val
    ForLoopRound n loc      -> printf "(%s): %s: %d" (cyan loc) (yellow "For Loop cound") n
    ForLoopLimitReached loc -> printf "(%s): %s" (cyan loc) (yellow "For Loop limit reached")
    Return loc val          -> printf "(%s): %s: %s" (cyan loc) (yellow "Returning") val
    RunCFGFormalMethodCall
      symState              -> printf "%s: %s" (yellow "Method Call formal SymState") symState
    RunSymStateActualMethodCall
      symState              -> printf "%s: %s" (yellow "Method Call actual SymState") symState
    Nested funCallTag logTag-> printf "%s ==> %s" (red funCallTag) (ppConsoleLogTag logTag)
    logTag -> error "Logs.Console ==> TODO"
