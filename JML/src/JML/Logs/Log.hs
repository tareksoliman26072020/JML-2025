{-# Language LambdaCase #-}
module JML.Logs.Log where

import Text.Printf (printf)
import Data.List (intercalate)

data Log = Log String LogTag
         deriving (Show,Eq)

data LogTag =
    HorizontalLine String
  | LogTag String String String
  | Nested String LogTag
  | NextSymExpr String String String
  | Location String String
  | Skip String String String
  | AddBehaviorToState String String
  | AddClauseToState String String
  | Return String String
  | ReportTheState String String [(String,[String])] String String String String String
  | ReportTheStack String String [(String,[String])]
  | IfInnerJMLState String String String [(String,[String])] String String String String String
  | ElseInnerJMLState String String String [(String,[String])] String String String String String
  | ProcessIfBody String
  | ProcessElseBody String
  | NoElseBody String
  | IfConditionPreCondition String String
  | ElseConditionPreCondition String String
  | Behavior String String String
  | IfBehavior String String [String]
  | ElseBehavior String String [String]
  | IfBranchBehaviors String [(String,String)]
  | ElseBranchBehaviors String [(String,String)]
  | ToBeProcessed String String
  | BranchNumIncremented String String
  | Meow String String
  deriving (Show,Eq)

-- Look up the usage of the function `tell` in SymbolicExecution
-- to best relate to `Log`
ppLogTag :: LogTag -> String
ppLogTag = \case
  Meow str1 str2          -> printf "%s: %s %s" "red" str1 str2
  LogTag loc tag contents -> printf
    "%s in %s\n\
    \%s" tag loc contents
  NextSymExpr loc k v -> printf
    "%s: %s\n\
    \1) key = %s\n\
    \2) value = %s"
    "Next SymExpr" loc k v
  HorizontalLine str  -> printf "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> %s <<<<<<<<<<<<<<<<<<<<\n" str
  Nested nestedStr logTag -> printf "%s ==> %s" nestedStr (ppLogTag logTag)
  Location loc contents   -> printf
    "%s in %s\n\
    \  %s: %s" "Location" loc "Contents" contents
  Return loc contents   -> printf
    "%s in %s\n\
    \  %s: %s" "Return" loc "Contents" contents
  BranchNumIncremented loc newNum -> printf
    "%s in %s\n\
    \  %s = %s"
    "Branch Num Incremented" loc
    "New Value" newNum
  ToBeProcessed loc contents -> printf
    "%s in %s\n\
    \  %s: %s" "To Be Processed" loc "Contents" contents
  ProcessIfBody loc -> printf
    "%s in %s" "Process If Body" loc
  ProcessElseBody loc -> printf
    "%s in %s" "Process Else Body" loc
  NoElseBody loc -> printf
    "%s in %s" "No Else Body" loc
  IfConditionPreCondition loc contents -> printf
    "%s in %s\n\
    \  %s: %s" "If Condition PreCondition" loc "Expr" contents
  ElseConditionPreCondition loc contents -> printf
    "%s in %s\n\
    \  %s: %s" "Else Condition PreCondition" loc "Expr" contents
  Behavior loc contents pp -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s:\n\
    \    %s"
    "Behavior" loc
    "Contents" contents
    "Pretty Printed"
    (concatMap (\case '\n' -> "\n  "; ch -> [ch]) pp)
  IfBehavior loc contents ppContents -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s:\n\
    \    %s"
    "If Behavior" loc
    "Contents" contents
    "Pretty Printed"
    (intercalate "\n    " $ map (concatMap (\case '\n' -> "\n  "; ch -> [ch])) ppContents)
  ElseBehavior loc contents ppContents -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s:\n\
    \    %s"
    "Else Behavior" loc
    "Contents" contents
    "Pretty Printed"
    (intercalate "\n    " $ map (concatMap (\case '\n' -> "\n  "; ch -> [ch])) ppContents)
  IfBranchBehaviors loc behaviors -> printf
    "%s in %s\n\
    \  %s"
    "If Branch Behaviors" loc
    (intercalate "\n  "
     $ map (\(num,(behavior,pp)) -> printf
         "%s %s: %s\n\
         \    %s:\n\
         \      %s"
         "behavior" (show num) behavior
         "Pretty Printed" (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp))
     $ zip [1 :: Int ..] behaviors)
  ElseBranchBehaviors loc behaviors -> printf
    "%s in %s\n\
    \  %s"
    "Else Branch Behaviors" loc
    (intercalate "\n  "
     $ map (\(num,(behavior,pp)) -> printf
         "%s %s: %s\n\
         \    %s:\n\
         \      %s"
         "behavior" (show num) behavior
         "Pretty Printed" (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp))
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
    "Report The State" loc
    "method" method
    "jmlStack"
    (callReportTheState jmlStack)
    {-(concatMap (\ch -> if
       ch == '\n' then "\n  "
       else [ch])
     $ dropWhile (/= '\n')
     $ ppLogTag $ ReportTheStack "" "" jmlStack)-}
    "logHeader" logHeader
    "formals" formals
    "locals" locals
    "globals" globals
    "Pretty Printed" (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp)
  ReportTheStack loc tag li -> (printf "%s in %s\n" tag loc :: String) ++ (printf
    $ intercalate "\n----------\n"
    $ map (\(counter,(cond,vals)) -> printf
        "  %s %s\n\
        \  %s %s"
       -- "stack before creating new behaviors" loc
        (printf "%d.%d)" counter (1::Int) :: String) cond
        (printf "%d.%d" counter (2::Int) :: String)
        (intercalate ("\n" ++ replicate 6 ' ')
         $ map (\(counter2,val) -> printf "%s %s" (printf "%d)" counter2 :: String) val)
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
    "Report If Inner State" loc 
    "error or ExecutionResults" err
    "method" method
    "jmlStack"
    (callReportTheState jmlStack)
    "logHeader" logHeader
    "formals" formals
    "locals" locals
    "globals" globals
    "Pretty Printed" (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp)
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
    "Report Else Inner State" loc 
    "error or ExecutionResults" err
    "method" method
    "jmlStack"
    (callReportTheState jmlStack)
    "logHeader" logHeader
    "formals" formals
    "locals" locals
    "globals" globals
    "Pretty Printed" (concatMap (\case '\n' -> "\n    "; ch -> [ch]) pp)
  Skip loc contents thing -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s"
    "Skipping" loc
    "Contents" contents
    thing
  AddBehaviorToState loc contents -> printf
    "%s in %s\n\
    \  %s: %s"
    "Adding behavior to state" loc
    "Contents" contents
  AddClauseToState loc contents -> printf
    "%s in %s\n\
    \  %s: %s"
    "Adding clause to state" loc
    "Contents" contents
  log -> error $ "SymbolicExecution.Logs.Log ==> TODO: " ++ show log
  where
  callReportTheState jmlStack =
   concatMap (\ch -> if
     ch == '\n' then "\n  "
     else [ch])
   $ dropWhile (/= '\n')
   $ ppLogTag $ ReportTheStack "" "" jmlStack

data Header = Header {
    logScopeDepth :: Int,
    logCounter :: [Int]
  } deriving (Eq,Show)

isHorizontalLine :: LogTag -> Bool
isHorizontalLine = \case
  HorizontalLine _ -> True
  Nested _ log -> isHorizontalLine log
  _ -> False
