module Main (main) where

import Test.Tasty
import Test.Tasty.HUnit
import Text.Printf (printf)
import Data.Either (fromRight)
import Text.ParserCombinators.Parsec (parse)

import Methods.JavaMethod
import qualified CFG.Types as CFGT
import qualified CFG.CFG as CFG1 (exec)

import Parser.Types (Method)
import Parser.ParseStmt (parseExtDecl)

import qualified SymbolicExecution.Types as SYT
import SymbolicExecution.Method (runCFG)

import JML.Method (runSE)
import qualified JML.Internal (se_2_map)

import qualified JML.Types as JMLT
import qualified TargetState as Correct (target)
import qualified JML.Logs.PrettyPrint as Log

import Text.Printf (printf)

javaMethodTests :: TestTree
javaMethodTests =
  let li = getSymbolicExecutions $ getCFGs javaMethodInputs
      sys = JML.Internal.se_2_map $ map snd li
  in testGroup "All tests" (do
       (name, symbolicExecution) <- li
       let jml@(_,logs,jmlMethod) = runSE sys symbolicExecution
       return $ testCase (printf "Testing %s" (yellow name)) $
         assertBool (printf "\n\n%s\n\n" (show jmlMethod)) (jmlMethod == Correct.target name))

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

getCFGs :: [(String,String)] -> [(String,CFGT.CFG)]
getCFGs = map $ \(funName,source) ->
  (funName, CFG1.exec $ fromRight undefined $ parse parseExtDecl "" source)

getSymbolicExecutions :: [(String,CFGT.CFG)] -> [(String,SYT.SymbolicExecution)]
getSymbolicExecutions li = let
  cfgs :: [CFGT.CFG]
  cfgs = map snd li
  symbolicExecutions0 :: [(String,SYT.SymbolicExecution)]
  symbolicExecutions0 = flip map li $ \(methodName,cfg) -> let
    (_,_,symbolicExecution) = runCFG cfgs cfg Nothing Nothing
    in (methodName,symbolicExecution)
  in symbolicExecutions0
{-
getJMLs :: [(String,CFGT.CFG)] -> [(String,Method)]
getJMLs li = let
  symbolicExecutions0 :: [(String,SYT.SymbolicExecution)]
  symbolicExecutions0 = flip map li $ \(methodName,cfg) -> let
    (_,_,symbolicExecution) = runCFG cfgs cfg Nothing Nothing
    in (methodName,symbolicExecution)
  
  symbolicExecutions :: [SYT.SymbolicExecution]
  symbolicExecutions = map snd symbolicExecutions0
  
  sys :: [SYT.SymbolicExecution] -> Map.Map String SYT.SymbolicExecution
  sys = JML.Internal.se_2_map
  
  methods0 :: [(String,Method)]
  methods0 = flip map symbolicExecutions0 $ \(methodName,sy) ->
    (methodName,JML.runSE sys sy)
  in methods0-}

main :: IO ()
main = defaultMain javaMethodTests
