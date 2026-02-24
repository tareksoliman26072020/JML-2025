{-# Language LambdaCase #-}
module SymbolicExecution.Logs.PrettyPrint where
import SymbolicExecution.Logs.Log (Log, LogTag(HorizontalLine))
import SymbolicExecution.Logs.Console (ppConsoleLog)
import SymbolicExecution.Logs.Markdown (ppMarkdownLog)

import Text.Printf (printf)
import Data.List (intercalate,foldl')

data LogKind = Console | Markdown

ppLogs :: LogKind -> [Log] -> String
ppLogs logKind =
  let whichFun = case logKind of
        Console -> ppConsoleLog
        Markdown -> ppMarkdownLog
  in addHeader . intercalate "\n\n" . map whichFun
  where
  addHeader :: String -> String
  addHeader logs = case logKind of
    Console ->
      "================\n" ++
      "===Begin Logs===\n" ++
      "================\n" ++
      logs ++ "\n" ++
      "==============\n" ++
      "===End Logs===\n" ++
      "==============\n"
    Markdown ->
      "# Begin Logs\n" ++
      logs ++ "\n" ++
      "# End Logs\n"
