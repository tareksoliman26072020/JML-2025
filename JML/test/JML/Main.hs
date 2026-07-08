{-# Language LambdaCase, MultiWayIf #-}
module Main (main) where

import Test.Tasty
import Test.Tasty.HUnit

import Text.Printf (printf)
import Data.List (find, intercalate)
import Data.Either (lefts, rights)

import Methods.JavaMethod
import Methods.Executions

import JML.Method (runSE)
import JML.Types (method, LoopInvariantTemplate, JMLState)
import JML.Internal.LoopInvariants (run_inferLoopInvariantTemplates, inferLoopInvariantTemplates)

import qualified SymbolicExecution.Types as SYT (SymbolicExecutionValue, SymExpr(SLoop), LoopSummary, LoopSummaryTag, LoopPattern, SymbolicExecution)
----------
import qualified TargetState as Correct (target)
import qualified Internal.LoopInvariants as LoopInvariants.Correct (allTargets)
----------

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

globalLoc = "test/JML.Main"

lookup3 :: Eq a => a -> [(a, b, c)] -> Maybe c
lookup3 key li = let
  finding = flip find li $ \(key2,_,_) -> key == key2
  in case finding of
       Just (_,_,value) -> Just value
       _ -> Nothing

javaMethodTests :: Int -> TestTree
javaMethodTests groupNumber =
  testGroup (printf "Methods (%d)" groupNumber) $ do
    (name, groupNum, symbolicExecution) <- getSymbolicExecutions
    if | groupNum == groupNumber -> let
           jml@(_,logs,jmlState) = runSE symbolicExecutions symbolicExecution
           jmlMethod = method jmlState
           jmlMethod2 = case groupNumber of
             2 -> jmlMethod
             _ -> jmlMethod
           in return
              $ testCase (printf "Testing %s" (yellow name))
              $ assertBool (printf "\n\n%s\n\n" (show jmlMethod)) (jmlMethod == Correct.target name)
       | otherwise -> fail ""

loopInvariantsTests :: TestTree
loopInvariantsTests = let
  loc = globalLoc ++ ".loopInvariantsTests" in
  testGroup "JML.Internal.LoopInvariants" $ do
    (counter,funName,loopInvariantTemplates_correct) <- zipWith (\a (b,c) -> (a,b,c)) [1::Int ..] LoopInvariants.Correct.allTargets
    let --jml@(_,logs,jmlState) = runSE symbolicExecutions symbolicExecution
        symbolicExecution :: SYT.SymbolicExecution
        symbolicExecution = case lookup3 funName getSymbolicExecutions of
          Just sy -> sy
          Nothing -> error $ printf "won't happen1 in %s" loc 
        li :: [(SYT.LoopSummary,[(SYT.LoopPattern,[SYT.LoopSummaryTag])])]
        li = case lookup3 funName getSLoops of
          Just li -> [(loopSummary,loopPatterns)
            | SYT.SLoop _ _ _ (Just loopSummary) loopPatterns <- li]
          Nothing -> error $ printf "won't happen2 in %s" loc
        run :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> Either String [LoopInvariantTemplate]
        run a b = (\(ei,_,_) -> ei)
          $ run_inferLoopInvariantTemplates symbolicExecutions funName
          $ inferLoopInvariantTemplates a b
        ei_templates :: [Either String [LoopInvariantTemplate]]
        ei_templates = [ei
          | (loopSummary,loopPatterns) <- li
          , let ei = run loopSummary loopPatterns
          ]
        errors :: [String]
        errors = lefts ei_templates
        templates :: [[LoopInvariantTemplate]]
        templates = rights ei_templates
    return $ testCase (yellow $ printf "%d) %s" counter funName)
           $ case errors of
               [] -> assertBool (printf "\n\n%s\n\n" (show templates))
                                (templates == loopInvariantTemplates_correct)
               _  -> assertBool (intercalate "\n\n" errors) False

main :: IO ()
main = defaultMain
  $ testGroup "All tests" [
        javaMethodTests 1,javaMethodTests 2,javaMethodTests 3,
        loopInvariantsTests
      ]
