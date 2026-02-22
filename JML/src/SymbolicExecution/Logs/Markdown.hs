{-# Language OverloadedStrings, LambdaCase #-}
module SymbolicExecution.Logs.Markdown where

import SymbolicExecution.Logs.Log
import Data.List (intercalate)
import Text.Printf (printf)
import Data.String(IsString(..))

data HTMLColor = OrangeRed | Cyan | Purple | BrightPurple
instance Show HTMLColor where
  show = \case
    OrangeRed -> "orangered"
    Cyan -> "cyan"
    Purple -> "purple"
    BrightPurple -> "rgb(191, 64, 191)"

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

brightPurple :: HTMLText -> HTMLText
brightPurple htmlText = HTMLText {
  text = text htmlText,
  color = Just BrightPurple,
  isUnderlined = isUnderlined htmlText
  }

orangeRed :: HTMLText -> HTMLText
orangeRed htmlText = HTMLText {
  text = text htmlText,
  color = Just OrangeRed,
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
ppMarkdownLog (Log counter logTag) = printf "%s. %s" counter (ppMarkdownLogTag logTag)

ppMarkdownLogTag :: LogTag -> String
ppMarkdownLogTag = \case
    FunHandle loc name t    -> printf "(%s): %s: %s %s"
        (show $ cyan $ fromString loc) (show $ orangeRed "Fun infos") (show t) name
    MethodEnd loc           -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangeRed "Method End")
    Void loc                -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangeRed "Void")
    Location loc            -> printf "%s: %s" (show $ orangeRed "Location") (show $ cyan $ fromString loc)
    MethodStart str loc     -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "Method Start") str
    MethodStatement loc str -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "Method Statement") str
    MethodStatementIfCondition loc str
                            -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "If condition") str
    Expression_2_Handle
      str loc               -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "handling expression") str
    SymExpr_2_Handle
      str loc               -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "handling SymExpr") str
    ReturnStatement str loc -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "handling return expression") str
    AssignStatement str loc -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "handling assign statement") str
    Edge_2_Handle str loc   -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "running CFG") str
    Meow str1 str2          -> printf "Meow: %s %s" str1 str2
    HorizontalLine str      -> printf "---\n\n\\>\\>\\>\\>\\>\\>\\>\\>\\>\\> %s <<<<<<<<<<\n\n---" (show $ orangeRed $ fromString str)
    NewVariable tn vn loc   -> printf "(%s): %s %s %s" (show $ cyan $ fromString loc) (show $ orangeRed "New Variable") tn vn
    ActualParameterDetected
              tn vn val loc -> printf "(%s): %s %s %s ==> %s" (show $ cyan $ fromString loc) (show $ orangeRed "Actual Parameter Detected") tn vn val
    UpdateVariable (vn,old,new) loc
                            -> printf "(%s): %s\n    %s: %s\n    %s: %s\n    %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "Update Variable")
                                 (show $ orangeRed "Var Name") vn
                                 (show $ orangeRed "Old Value") old
                                 (show $ orangeRed "New Value") new
    LookUpEnvTable
      key val loc           -> printf "(%s): %s: (%s ~~> %s) " (show $ cyan $ fromString loc) (show $ orangeRed "Look up in environmane table") key val
    GlobalVar key loc       -> printf "(%s): %s: %s " (show $ cyan $ fromString loc) (show $ orangeRed "Global Variable Detected") key
    GlobalVars key loc      -> printf "(%s): %s: %s " (show $ cyan $ fromString loc) (show $ orangeRed "Global Variables") key
    MethodFormalParams
      args loc              -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "formal parameters") args
    MethodActualParms
      args loc              -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "actual parameters") args
    NextNode nodeStr        -> printf "%s: %s" ("### " ++ show (orangeRed "Next Node")) nodeStr
    NextMethodCallSymExpr methodCall (key,symExpr)
                            -> printf "%s (%s ==> %s) in Method Call: %s" (show $ orangeRed "Next symExpr") key symExpr methodCall
    Affected loc exprs      -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "Affected") (intercalate ", " exprs)
    ProcessPredefinedFunCall
      loc funName funArgs   -> printf "(%s): %s: %s%s" (show $ cyan $ fromString loc) (show $ orangeRed "Processing Predefined FunCall") funName funArgs
    ModifyState loc (k,v)   -> printf "(%s): %s: (%s,%s)" (show $ cyan $ fromString loc) (show $ orangeRed "Modifying State") k v
    ForStatementHasNoAccumulationVariable loc
                            -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangeRed "For statement has no Accumulation variable")
    StateNotModified loc    -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangeRed "State Not Modified")
    NoElseBranch loc        -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangeRed "No Else Branch")
    AddVarBinding loc val   -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "Adding Var Binding") val
    AddVarAssignment loc val-> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "Adding Var Assignment") val
    ReportTheState s        -> printf "(%s):\n%s" (show $ orangeRed "Reporting The State") (show s)
    Skip thing              -> printf "(%s):\n%s" (show $ orangeRed "Skip") (show thing)
    ForLoopDone loc         -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangeRed "For Loop Done")
    UnvisitedForLoop loc expr
                            -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "Unregistered For Loop") expr
    ForLoopConditionUndetermined loc val
                            -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "For Loop Condition Undetermined") val
    ForLoopRound n loc      -> printf "(%s): %s: %d" (show $ cyan $ fromString loc) (show $ orangeRed "For Loop cound") n
    ForLoopLimitReached loc -> printf "(%s): %s" (show $ cyan $ fromString loc) (show $ orangeRed "For Loop limit reached")
    Return loc val          -> printf "(%s): %s: %s" (show $ cyan $ fromString loc) (show $ orangeRed "Returning") val
    RunCFGFormalMethodCall
      symState              -> printf "%s: %s" (show $ orangeRed "Method Call formal SymState") symState
    RunSymStateActualMethodCall
      symState              -> printf "%s: %s" (show $ orangeRed "Method Call actual SymState") symState
    Nested funCallTag logTag-> printf "%s ==> %s" (show $ underline $ brightPurple $ fromString funCallTag) (ppMarkdownLogTag logTag)
    logTag -> error "Logs.Markdown ==> TODO"

