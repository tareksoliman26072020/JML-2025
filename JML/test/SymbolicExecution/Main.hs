module Main (main) where

import Test.Tasty
import Test.Tasty.HUnit
import Text.Printf (printf)
import Data.Either (fromRight)
import Text.ParserCombinators.Parsec (parse)

import Methods.JavaMethod
import Methods.Executions
import SymbolicExecution.Method (runCFG)
import SymbolicExecution.Types

import qualified TargetState as Correct (target)
import qualified SymbolicExecution.Logs.PrettyPrint as Log

import Text.Printf (printf)

javaMethodTests :: TestTree
javaMethodTests =
  testGroup "All tests" (do
    (name, cfg) <- getCFGs
    let (_,logs,s) = runCFG cfgs cfg Nothing Nothing
    return $ testCase (printf "Testing %s" (yellow name)) $
      assertBool (printf "\n\n%s\n\n" (show s)) (s == Correct.target name))

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

main :: IO ()
main = defaultMain javaMethodTests

