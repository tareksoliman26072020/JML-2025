{-# Language OverloadedStrings, LambdaCase #-}
module SymbolicExecution.Logs.Markdown where

import SymbolicExecution.Logs.Log
import Data.List (intercalate)
import Text.Printf (printf)
import Data.String(IsString(..))

data HTMLColor = Orangered | Cyan | Purple
instance Show HTMLColor where
  show = \case
    Orangered -> "orangered"
    Cyan -> "cyan"
    Purple -> "purple"

data HTMLText = HTMLText {
  text :: String,
  color :: Maybe HTMLColor,
  isUnderlined :: Bool
  }
instance IsString HTMLText where
  fromString str = HTMLText {
    text = str,
    color = Nothing,
    isUnderlined = False
  }

instance Show HTMLText where
  show html@HTMLText{} = case (color html,isUnderlined html) of
    -- no formal
    (Nothing,False) -> text html
    -- underlined
    (Nothing,True) -> printf "<u>%s</u>" (text html)
    -- colored
    (Just c,False) -> printf "<span style=\"color: %s;\">%s</span>" (show c) (text html)
    -- colored and underlined
    (Just c,True) -> printf "<u style=\"color: %s;\">%s</u>" (show c) (text html)

purple :: HTMLText -> HTMLText
purple htmlText = HTMLText {
  text = text htmlText,
  color = Just Purple,
  isUnderlined = isUnderlined htmlText
  }

orangered :: HTMLText -> HTMLText
orangered htmlText = HTMLText {
  text = text htmlText,
  color = Just Orangered,
  isUnderlined = isUnderlined htmlText
  }

cyan :: HTMLText -> HTMLText
cyan htmlText = HTMLText {
  text = text htmlText,
  color = Just Cyan,
  isUnderlined = isUnderlined htmlText
  }

underline :: HTMLText -> HTMLText
underline htmlText = HTMLText {
  text = text htmlText,
  color = color htmlText,
  isUnderlined = True
  }

ppMarkdownLog :: Log -> String
ppMarkdownLog = \case
    MethodEnd loc           -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangered "Method End")
    Void loc                -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangered "Void")
    MethodStart str loc     -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "Method Start") str
    MethodStatement loc str -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "Method Statement") str
    MethodStatementIfCondition loc str
                            -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "If condition") str
    Expression_2_Handle
      str loc               -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "handling expression") str
    SymExpr_2_Handle
      str loc               -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "handling SymExpr") str
    ReturnStatement str loc -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "handling return expression") str
    AssignStatement str loc -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "handling assign statement") str
    Edge_2_Handle str loc   -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "running CFG") str
    Meow str1 str2          -> printf "Meow: %s %s" str1 str2
    HorizontalLine str      -> printf "---\n\\>\\>\\>\\>\\>\\>\\>\\>\\>\\> %s <<<<<<<<<<\n\n---" (show $ orangered $ fromString str)
    NewVariable tn vn loc   -> printf "(%s): %s %s %s" (show $ cyan $ fromString loc) (show $ orangered "New Variable") tn vn
    UpdateVariable (vn,old,new) loc
                            -> printf "(%s): %s\n    %s: %s\n    %s: %s\n    %s: %s" (show $ cyan $ fromString loc) (show $ orangered "Update Variable")
                                 (show $ orangered "Var Name") vn
                                 (show $ orangered "Old Value") old
                                 (show $ orangered "New Value") new
    LookUpEnvTable
      key val loc           -> printf "(%s): %s: (%s ~~> %s) " (show $ cyan $ fromString loc) (show $ orangered "Look up in environmane table") key val
    GlobalVar key loc       -> printf "(%s): %s: %s " (show $ cyan $ fromString loc) (show $ orangered "Global Variable Detected") key
    MethodFormalParams
      args loc              -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "Visiting formal parameters") args
    NextNode nodeStr        -> printf "%s: %s" ("### " ++ show (orangered "Next Node")) nodeStr
    NextMethodCallSymExpr methodCall (key,symExpr)
                            -> printf "%s (%s ==> %s) in Method Call: %s" (show $ orangered "Next symExpr") key symExpr methodCall
    Affected loc exprs      -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "Affected") (intercalate ", " exprs)
    ProcessPredefinedFunCall
      loc funName funArgs   -> printf "(%s): %s: %s%s" (show $ cyan $ fromString loc) (show $ orangered "Processing Predefined FunCall") funName funArgs
    ModifyState loc (k,v)   -> printf "(%s): %s: (%s,%s)" (show $ cyan $ fromString loc) (show $ orangered "Modifying State") k v
    ForStatementHasNoAccumulationVariable loc
                            -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangered "For statement has no Accumulation variable")
    StateNotModified loc    -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangered "State Not Modified")
    NoElseBranch loc        -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangered "No Else Branch")
    AddVarBinding loc val   -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "Adding Var Binding") val
    AddVarAssignment loc val-> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "Adding Var Assignment") val
    ReportTheState s        -> printf "(%s):\n%s" (show $ orangered "Reporting The State") (show s)
    Skip thing              -> printf "(%s):\n%s" (show $ orangered "Skip") (show thing)
    ForLoopDone loc         -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangered "For Loop Done")
    UnvisitedForLoop loc expr
                            -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "Unregistered For Loop") expr
    ForLoopConditionUndetermined loc val
                            -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "For Loop Condition Undetermined") val
    ForLoopRound n loc      -> printf "(%s): %s: %d" (show $ cyan $ fromString loc) (show $ orangered "For Loop cound") n
    ForLoopLimitReached loc -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangered "For Loop limit reached")
    Return loc val          -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangered "Returning") val
    RunCFGFormalMethodCall
      symState              -> printf "%s: %s" (show $ orangered "Method Call formal SymState") symState
    RunSymStateActualMethodCall
      symState              -> printf "%s: %s" (show $ orangered "Method Call actual SymState") symState
    Nested funCallTag log   -> printf "%s ==> %s" (show $ underline $ purple $ fromString funCallTag) (ppMarkdownLog log)

