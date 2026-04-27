module Main (main) where

import Test.Tasty
import Test.Tasty.HUnit
import Text.Printf (printf)

import Methods.JavaMethod
import Methods.Executions

import JML.Method (runSE)
import JML.Types (method)

import qualified TargetState as Correct (target)

import Text.Printf (printf)

javaMethodTests :: TestTree
javaMethodTests =
  testGroup "All tests" (do
    (name, symbolicExecution) <- getSymbolicExecutions
    let jml@(_,logs,jmlState) = runSE symbolicExecutions symbolicExecution
        jmlMethod = method jmlState
    return $ testCase (printf "Testing %s" (yellow name)) $
      assertBool (printf "\n\n%s\n\n" (show jmlMethod)) (jmlMethod == Correct.target name))

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

main :: IO ()
main = defaultMain javaMethodTests
