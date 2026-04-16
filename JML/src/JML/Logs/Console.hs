{-# Language LambdaCase #-}
module JML.Logs.Console where

import JML.Logs.Log
import Text.Printf (printf)
import Data.List (intercalate)

cyan :: String -> String
cyan = printf "\ESC[1;36m%s\ESC[m"

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

red :: String -> String
red = printf "\ESC[1;41m%s\ESC[m"

ppConsoleLog :: Log -> String
ppConsoleLog (Log counter logTag)
  | isHorizontalLine logTag = ppConsoleLogTag logTag
  | otherwise = printf "%s. %s" counter (ppConsoleLogTag logTag)

ppConsoleLogTag :: LogTag -> String
ppConsoleLogTag = \case
  Meow str1 str2          -> printf "%s: %s %s" (cyan "Meow") str1 str2
  HorizontalLine str      -> printf "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> %s <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n" (yellow str)
  NextSymExpr loc k v     -> printf
    "%s: %s\n\
    \  1) %s = %s\n\
    \  2) %s = %s"
    (cyan loc) (yellow "Next SymExpr") (yellow "Key") k (yellow "Value") v
  Nested nestedStr logTag -> printf "%s ==> %s" (red nestedStr) (ppConsoleLogTag logTag)
  Location loc contents   -> printf
    "%s in %s\n\
    \  %s: %s" (yellow "Location") (cyan loc) (yellow "Contents") contents
  Return loc contents   -> printf
    "%s in %s\n\
    \  %s: %s" (yellow "Return") (cyan loc) (yellow "Contents") contents
  ReportTheState loc method jmlStack logHeader -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s"
    (yellow "Report The State") (cyan loc)
    (yellow "method")    method
    (yellow "jmlStack")  jmlStack
    (yellow "logHeader") logHeader
  Skip loc contents thing -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s"
    (yellow "Skip") (cyan loc)
    (yellow "Contents") contents
    (yellow thing)
  AddBehaviorToState loc contents -> printf
    "%s in %s\n\
    \  %s: %s"
    (yellow "Add behavior to state") (cyan loc)
    (yellow "Contents") contents
  AddClauseToState loc contents -> printf
    "%s in %s\n\
    \  %s: %s"
    (yellow "Add clause to state") (cyan loc)
    (yellow "Contents") contents
  logTag -> error $ "JML.Logs.Console ==> TODO: " ++ show logTag
