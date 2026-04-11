{-# Language LambdaCase #-}
module JML.Logs.Log where

import Text.Printf (printf)

data Log = Log String LogTag
         deriving (Show,Eq)

data LogTag =
    HorizontalLine String
  | Nested String LogTag
  | NextSymExpr String String String
  | Meow String String
  deriving (Show,Eq)

-- Look up the usage of the function `tell` in SymbolicExecution
-- to best relate to `Log`
ppLogTag :: LogTag -> String
ppLogTag = \case
  Meow str1 str2          -> printf "%s: %s %s" "red" str1 str2
  NextSymExpr loc k v -> printf "%s: %s" "Next SymExpr" loc k v
  HorizontalLine str  -> printf "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> %s <<<<<<<<<<<<<<<<<<<<\n" str
  Nested nestedStr logTag -> printf "%s ==> %s" nestedStr (ppLogTag logTag)
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
