{-# Language LambdaCase #-}
module SymbolicExecution.Logs.Log where

import Text.Printf (printf)
import Data.List (foldl', intercalate)
-- 🠗 ⮩ ↘ ↳ ⤷ ⮱

data Log = Log String LogTag
         deriving (Show,Eq)

getLogTag :: Log -> LogTag
getLogTag (Log _ tag) = tag

ppLog :: Log -> String
ppLog (Log counter logTag)
  | isHorizontalLine logTag = ppLogTag logTag
  | otherwise = printf "%s. %s" counter (ppLogTag logTag)

isHorizontalLine :: LogTag -> Bool
isHorizontalLine = \case
  HorizontalLine _ -> True
  Nested _ log -> isHorizontalLine log
  _ -> False

--https://symbl.cc/en/collections/arrow-symbols/
data LogTag =
           FunHandle String String String
         | Expression_2_Handle String String
         | MethodStart String String
         | MethodEnd String
         | Void String
         | ReturnStatement String String
         | Edge_2_Handle String String
         | Node_2_Handle String String
         | HorizontalLine String
         | MethodStatement String String
         | AssignStatement String String
         | ContinueStatement String
         | BreakStatement String
         | NewVariable String String String
         | ActualParameterDetected String String String String
         | UpdateVariable (String,String,String) String
         | LookUpEnvTable String String String
         | NextNode String
         | ForStatementHasNoAccumulationVariable String
         | MethodFormalParams String String
         | MethodActualParms String String
         | NextMethodCallSymExpr String (String,String)
         | Affected String [String]
         | ModifyState String (String,String)
         | StateNotModified String
         | NoElseBranch String
         | AddVarBinding String String
         | AddVarAssignment String String
         | ReportTheState String String
         | Skip String String
         | ForLoopDone String
         | ForLoopDoneViaReturnStmt String
         | ForLoopDoneViaBreakStmt String
         | UnvisitedForLoop String String
         | ForLoopConditionUndetermined String String
         | ForLoopRound Int String
         | AtomizeRoundLoopCondition String String
         | ForLoopLimitReached String String
         | Return String String
         | RunCFGFormalMethodCall String
         | RunSymStateActualMethodCall String
         | Nested String LogTag
         | SymExpr_2_Handle String String
         | GlobalVar String String
         | GlobalVars String String
         | Meow String String
         | MethodStatementIfCondition String String
         | MethodStatementForInitialization String String
         | MethodStatementForStep String String
         | MethodStatementWhileCondition String String
         | ProcessPredefinedFunCall String String String
         | Location String
         | NextLogNum (Int,String) (Int,String)
         | IncrementLogDepth Int Int
         | DecrementLogDepth Int Int
         deriving (Show,Eq)


-- Look up the usage of the function `tell` in SymbolicExecution
-- to best relate to `Log`
ppLogTag :: LogTag -> String
ppLogTag = \case
    FunHandle loc name t    -> printf "(%s): %s: %s %s" loc "Fun infos" (show t) name
    MethodEnd loc           -> printf "(%s): %s" loc "Method End"
    Void loc                -> printf "(%s): %s" loc "Void"
    Location loc            -> printf "%s: %s" "Location" loc
    MethodStart str loc     -> printf "(%s): %s: %s" loc "Method Start" str
    MethodStatement loc str -> printf "(%s): %s: %s" loc "Method Statement" str
    MethodStatementIfCondition loc str
                            -> printf "(%s): %s: %s" loc "If condition" str
    MethodStatementWhileCondition loc str
                            -> printf "(%s): %s: %s" loc "While condition" str
    MethodStatementForInitialization loc str
                            -> printf "(%s): %s: %s" loc "For Initialization" str
    MethodStatementForStep loc str
                            -> printf "(%s): %s: %s" loc "For Step" str
    Expression_2_Handle
      str loc               -> printf "(%s): %s: %s" loc "handling expression" str
    SymExpr_2_Handle
      str loc               -> printf "(%s): %s: %s" loc "handling SymExpr" str
    ReturnStatement str loc -> printf "(%s): %s: %s" loc "handling return expression" str
    AssignStatement str loc -> printf "(%s): %s: %s" loc "handling assign statement" str
    ContinueStatement loc   -> printf "(%s): %s" loc "handling continue statement"
    BreakStatement loc      -> printf "(%s): %s" loc "handling break statement"
    Edge_2_Handle str loc   -> printf "(%s): %s: %s" loc "running CFG" str
    Meow str1 str2          -> printf "Meow: %s %s" str1 str2
    HorizontalLine str      -> printf "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> %s <<<<<<<<<<<<<<<<<<<<\n" str
    NewVariable tn vn loc   -> printf "(%s): %s %s %s" loc "New Variable" tn vn
    ActualParameterDetected
              tn vn val loc -> printf "(%s): %s %s %s ==> %s" loc "Actual Parameter Detected" tn vn val
    UpdateVariable (vn,old,new) loc
                            -> printf "(%s): %s\n    %s: %s\n    %s: %s\n    %s: %s" loc "Update Variable"
                                 "Var Name" vn
                                 "Old Value" old
                                 "New Value" new
    LookUpEnvTable
      key val loc           -> printf "(%s): %s: (%s ~~> %s) " loc "Look up in environmane table" key val
    GlobalVar key loc       -> printf "(%s): %s: %s " loc "Global Variable Detected" key
    GlobalVars key loc      -> printf "(%s): %s: %s " loc "Global Variables" key
    MethodFormalParams
      args loc              -> printf "(%s): %s: %s" loc "formal parameters" args
    MethodActualParms
      args loc              -> printf "(%s): %s: %s" loc "actual parameters" args
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
    ReportTheState loc s    -> printf "(%s): %s\n%s" loc "Reporting The State" s
    Skip loc thing          -> printf "(%s): %s ==> %s" "Skip" loc (show thing)
    ForLoopDone loc         -> printf "(%s): %s" loc "For Loop Done"
    ForLoopDoneViaReturnStmt
                loc         -> printf "(%s): %s" loc "For Loop Done due to return statement"
    ForLoopDoneViaBreakStmt
                loc         -> printf "(%s): %s" loc "For Loop Done due to break statement"
    UnvisitedForLoop loc expr
                            -> printf "(%s): %s: %s" loc "Unregistered For Loop" expr
    ForLoopConditionUndetermined loc val
                            -> printf "(%s): %s: %s" loc "For Loop Condition Undetermined" val
    ForLoopRound n loc      -> printf "(%s): %s: %d" loc "For Loop count" n
    AtomizeRoundLoopCondition loc tus
                            -> printf "(%s): %s: %s" loc "For Loop Condition Atomized" tus
    ForLoopLimitReached loc limit
                            -> printf "(%s): %s: %s" loc "For Loop limit reached" limit
    Return loc val          -> printf "(%s): %s: %s" loc "Returning" val
    RunCFGFormalMethodCall
      symState              -> printf "%s: %s" "Method Call formal SymState" symState
    RunSymStateActualMethodCall
      symState              -> printf "%s: %s" "Method Call actual SymState" symState
    Nested funCallTag logTag-> printf "%s ==> %s" funCallTag (ppLogTag logTag)
    NextLogNum
      (oldDepth,oldCounter)
      (newDepth,newCounter) -> printf 
          "NextLogNum:\n\
          \  oldDepth: %d, oldCounter: %s\n\
          \  newDepth: %d, newCounter: %s"
          oldDepth oldCounter newDepth newCounter
    IncrementLogDepth oldDepth newDepth -> printf
        "IncrementLogDepth:\n\
        \  oldDepth: %d\n\
        \  newDepth: %d"
        oldDepth newDepth
    DecrementLogDepth oldDepth newDepth -> printf
        "DecrementLogDepth:\n\
        \  oldDepth: %d\n\
        \  newDepth: %d"
        oldDepth newDepth
    log -> error "Logs.Log ==> TODO"

data Header = Header {
    logScopeDepth :: Int,
    logCounter :: [Int]
  } deriving (Eq,Show)
