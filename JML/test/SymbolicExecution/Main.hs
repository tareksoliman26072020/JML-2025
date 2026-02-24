module SymbolicExecution.Main (main) where

import Test.Tasty
import Test.Tasty.HUnit
import Text.Printf (printf)
import Data.Either (fromRight)
import Text.ParserCombinators.Parsec (parse)

import Color
import Methods.JavaMethod
import qualified CFG.Types as CFGT
import qualified CFG.CFG as CFG1 (exec)
import Parser.Types (Method)
import Parser.ParseStmt (parseExtDecl)
import SymbolicExecution.Method (runCFG)
import SymbolicExecution.Types

import qualified SymbolicExecution.TargetState as Correct (target)
import qualified SymbolicExecution.Logs.PrettyPrint as Log

javaMethodTests :: TestTree
javaMethodTests =
  let li = getCFGs javaMethodInputs
      cfgs = map snd li
  in testGroup "All tests" (do
       (name, cfg) <- li
       let (logs,s) = runCFG cfgs cfg Nothing Nothing
       return $ testCase (printf "Testing %s" (yellow name)) $
         assertBool (printf "\n\n%s\n\n" (show $ env s)) (env s == Correct.target name))

getCFGs :: [(String,String)] -> [(String,CFGT.CFG)]
getCFGs = map $ \(funName,source) ->
  (funName, CFG1.exec $ fromRight undefined $ parse parseExtDecl "" source)

main :: IO ()
main = defaultMain javaMethodTests

