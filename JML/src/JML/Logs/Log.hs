{-# Language LambdaCase #-}
module JML.Logs.Log where

import Text.Printf (printf)

data Log = Log String LogTag
         deriving (Show,Eq)

data LogTag =
    HorizontalLine String
  | Nested String LogTag
  | NextSymExpr String String String
  | Location String String
  | Skip String String String
  | AddBehaviorToState String String
  | AddClauseToState String String
  | Return String String
  | ReportTheState String String String String
  | Meow String String
  deriving (Show,Eq)

-- Look up the usage of the function `tell` in SymbolicExecution
-- to best relate to `Log`
ppLogTag :: LogTag -> String
ppLogTag = \case
  Meow str1 str2          -> printf "%s: %s %s" "red" str1 str2
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
  ReportTheState loc method jmlStack logHeader -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s: %s\n\
    \  %s: %s"
    "Report The State" loc
    "method"    method
    "jmlStack"  jmlStack
    "logHeader" logHeader
  Skip loc contents thing -> printf
    "%s in %s\n\
    \  %s: %s\n\
    \  %s"
    "Skip" loc
    "Contents" contents
    thing
  AddBehaviorToState loc contents -> printf
    "%s in %s\n\
    \  %s: %s"
    "Add behavior to state" loc
    "Contents" contents
  AddClauseToState loc contents -> printf
    "%s in %s\n\
    \  %s: %s"
    "Add clause to state" loc
    "Contents" contents
  log -> error $ "SymbolicExecution.Logs.Log ==> TODO: " ++ show log

data Header = Header {
    logScopeDepth :: Int,
    logCounter :: [Int]
  } deriving (Eq,Show)

isHorizontalLine :: LogTag -> Bool
isHorizontalLine = \case
  HorizontalLine _ -> True
  Nested _ log -> isHorizontalLine log
  _ -> False
