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
  LogTag loc tag contents -> printf
    "%s in %s\n\
    \%s" (yellow tag) (cyan loc) contents
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
  ToBeProcessed loc contents -> printf
    "%s in %s\n\
    \  %s: %s" (yellow "To Be Processed") (cyan loc) (yellow "Contents") contents
  ProcessIfBody loc -> printf
    "%s in %s" (yellow "Process If Body") (cyan loc)
  ProcessElseBody loc -> printf
    "%s in %s" (yellow "Process Else Body") (cyan loc)
  NoElseBody loc -> printf
    "%s in %s" (yellow "No Else Body") (cyan loc)
  IfConditionPreCondition loc contents -> printf
    "%s in %s\n\
    \  %s: %s" (yellow "If Condition PreCondition") (cyan loc) (yellow "Expr") contents
  ElseConditionPreCondition loc contents -> printf
    "%s in %s\n\
    \  %s: %s" (yellow "Else Condition PreCondition") (cyan loc) (yellow "Expr") contents
  Behavior loc contents pp -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s:\n\
    \    %s"
    (yellow "Behavior") (cyan loc)
    (yellow "Contents") contents
    (yellow "Pretty Printed")
    (concatMap (\case '\n' -> "\n  "; ch -> [ch]) pp)
  IfBehavior loc contents ppContents -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s:\n\
    \    %s"
    (yellow "If Behavior") (cyan loc)
    (yellow "Contents") contents
    (yellow "Pretty Printed")
    (intercalate "\n    " $ map (concatMap (\case '\n' -> "\n  "; ch -> [ch])) ppContents)
  ElseBehavior loc contents ppContents -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s:\n\
    \    %s"
    (yellow "Else Behavior") (cyan loc)
    (yellow "Contents") contents
    (yellow "Pretty Printed")
    (intercalate "\n    " $ map (concatMap (\case '\n' -> "\n  "; ch -> [ch])) ppContents)
  IfBranchBehaviors loc behaviors -> printf
    "%s in %s\n\
    \  %s"
    (yellow "If Branch Behaviors") (cyan loc)
    (intercalate "\n  "
     $ map (\(num,(behavior,pp)) -> printf
         "%s %s: %s\n\
         \    %s:\n\
         \      %s"
         (yellow "behavior") (yellow $ show num) behavior
         (yellow "Pretty Printed") (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp))
     $ zip [1 :: Int ..] behaviors)
  ElseBranchBehaviors loc behaviors -> printf
    "%s in %s\n\
    \  %s"
    (yellow "Else Branch Behaviors") (cyan loc)
    (intercalate "\n  "
     $ map (\(num,(behavior,pp)) -> printf
         "%s %s: %s\n\
         \    %s:\n\
         \      %s"
         (yellow "behavior") (yellow $ show num) behavior
         (yellow "Pretty Printed") (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp))
     $ zip [1 :: Int ..] behaviors)
  ReportTheState loc method jmlStack logHeader formals locals globals pp -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s:\n\
    \    %s"
    (yellow "Report The State") (cyan loc)
    (yellow "method") method
    (yellow "jmlStack")
    (callReportTheState jmlStack)
    {-(concatMap (\ch -> if
       ch == '\n' then "\n  "
       else [ch])
     $ dropWhile (/= '\n')
     $ ppConsoleLogTag $ ReportTheStack "" "" jmlStack)-}
    (yellow "logHeader") logHeader
    (yellow "formals") formals
    (yellow "locals") locals
    (yellow "globals") globals
    (yellow "Pretty Printed") (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp)
  ReportTheStack loc tag li -> (printf "%s in %s\n" (yellow tag) (cyan loc) :: String) ++ (printf
    $ intercalate "\n----------\n"
    $ map (\(counter,(cond,vals)) -> printf
        "  %s %s\n\
        \  %s %s"
        (yellow $ printf "%d.%d)" counter (1::Int) :: String) cond
        (yellow $ printf "%d.%d" counter (2::Int) :: String)
        (intercalate ("\n" ++ replicate 6 ' ')
         $ map (\(counter2,val) -> printf "%s %s" (yellow $ printf "%d)" counter2 :: String) val)
         $ zip [1::Int ..] vals))
    $ zip [1::Int .. length li] li)
  IfInnerJMLState loc err method jmlStack logHeader formals locals globals pp -> printf
    "%s in %s\n\
    \  %s: %s\n\ 
    \  %s: %s\n\
    \  %s:\
    \    %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s:\n\
    \    %s"
    (yellow "Report If Inner State") (cyan loc) 
    (yellow "error or ExecutionResults") err
    (yellow "method") method
    (yellow "jmlStack")
    (callReportTheState jmlStack)
    (yellow "logHeader") logHeader
    (yellow "formals") formals
    (yellow "locals") locals
    (yellow "globals") globals
    (yellow "Pretty Printed") (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp)
  ElseInnerJMLState loc err method jmlStack logHeader formals locals globals pp -> printf
    "%s in %s\n\
    \  %s: %s\n\ 
    \  %s: %s\n\
    \  %s:\
    \    %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s:\n\
    \    %s"
    (yellow "Report Else Inner State") (cyan loc)
    (yellow "error or ExecutionResults") err
    (yellow "method") method
    (yellow "jmlStack")
    (callReportTheState jmlStack)
    (yellow "logHeader") logHeader
    (yellow "formals") formals
    (yellow "locals") locals
    (yellow "globals") globals
    (yellow "Pretty Printed") (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp)
  Skip loc contents thing -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s"
    (yellow "Skipping") (cyan loc)
    (yellow "Contents") contents
    (yellow thing)
  AddBehaviorToState loc contents -> printf
    "%s in %s\n\
    \  %s: %s"
    (yellow "Adding behavior to state") (cyan loc)
    (yellow "Contents") contents
  AddClauseToState loc contents -> printf
    "%s in %s\n\
    \  %s: %s"
    (yellow "Adding clause to state") (cyan loc)
    (yellow "Contents") contents
  logTag -> error $ "JML.Logs.Console ==> TODO: " ++ show logTag
  where
  callReportTheState jmlStack =
   concatMap (\ch -> if
     ch == '\n' then "\n  "
     else [ch])
   $ dropWhile (/= '\n')
   $ ppConsoleLogTag $ ReportTheStack "" "" jmlStack
