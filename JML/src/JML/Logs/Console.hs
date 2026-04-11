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
  Meow str1 str2          -> printf "%s: %s %s" (cyan "red") str1 str2
  HorizontalLine str      -> printf "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> %s <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n" (yellow str)
  NextSymExpr loc k v     -> printf "%s: %s" (cyan loc) (yellow "Next SymExpr") k v
  Nested nestedStr logTag -> printf "%s ==> %s" (red nestedStr) (ppConsoleLogTag logTag)

  logTag -> error $ "JML.Logs.Console ==> TODO: " ++ show logTag
