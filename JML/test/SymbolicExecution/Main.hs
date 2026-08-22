{-# Language LambdaCase, MultiWayIf #-}
module Main (main) where

import Test.Tasty
import Test.Tasty.HUnit
import Text.Printf (printf)
import Data.Either (fromRight)
import Text.ParserCombinators.Parsec (parse)
import Control.Monad (forM)
import Text.Printf (printf)
import Data.List (find,zipWith3,intercalate)
import qualified Data.Map as Map
------------------
import Methods.JavaMethod
import Methods.Executions
import SymbolicExecution.Types
import qualified SymbolicExecution.Logs.PrettyPrint as Log
------------------
import SymbolicExecution.Internal.Math.Isolator (isolate, run_isolate)
import SymbolicExecution.Internal.LoopPattern (inferLoopPatterns, run_inferLoopPatterns)
import SymbolicExecution.Method (runCFG)
-----------------
import qualified TargetState as Correct (target)
import qualified Internal.Math.Isolator as Isolator.Correct (allTargets)
import qualified Internal.LoopSummary as LoopSummary.Correct (allTargets)
import qualified Internal.LoopPattern as LoopPattern.Correct (allTargets)
-----------------

yellow :: String -> String
yellow = printf "\ESC[1;33m%s\ESC[m"

globalLoc = "test/SymbolicExecution.Main"

javaMethodTests :: Int -> TestTree
javaMethodTests groupNumber = testGroup (printf "Methods (%d)" groupNumber)
  $ do
      (name, groupNum, cfg) <- getCFGs
      if | groupNum == groupNumber -> let
             (_,logs,_,s) = runCFG cfgs cfg Nothing Nothing
             s2 = case groupNumber of
               2 -> normalizeSLoop s
               _ -> s
             in return
                $ testCase (printf "Testing %s" (yellow name))
                $ assertBool (printf "\n\n%s\n\n" (show s2)) (s2 == Correct.target name)
         | otherwise -> fail "" where
  normalizeSLoop :: SymStateEnv -> SymStateEnv
  normalizeSLoop = Map.map $ \case
    SLoop a b c _ _ -> SLoop a b c Nothing []
    SIte ifCondSymExpr ifBodyEnv maybe_elseBodyEnv -> SIte ifCondSymExpr
      (normalizeSLoop ifBodyEnv) (normalizeSLoop <$> maybe_elseBodyEnv)
    val -> val

isolatorTests :: TestTree
isolatorTests = testGroup "SymbolicExecution.Internal.Math.Isolator.isolate" $ do
  (counter,pp,symExpr,symExpr_correct) <- zipWith
    (\counter (q,w,e) -> (counter,q,w,e))
      [1::Int ..] Isolator.Correct.allTargets
  let (_,er) = run_isolate $ isolate "i" symExpr
  return $ testCase (yellow $ printf "%d) %s" counter pp) $ case er of
    Left err -> assertBool err False
    Right symExpr_actual ->
      assertBool (printf "\n\n%s\n\n" (show symExpr_actual))
                 (symExpr_actual == symExpr_correct)

loopSummaryTests :: TestTree
loopSummaryTests = let
  loc = globalLoc ++ ".loopSummaryTests" in
  testGroup "SymbolicExecution.Method.createLoopSummary" $ do
    (counter,funName,loopSummary_li_correct) <- zipWith
      (\counter (q,w) -> (counter,q,w))
        [1::Int ..] LoopSummary.Correct.allTargets
    -- find the CFG of the method with the same name of `funName`
    let cfg = case find (\(funName_,_,cfg_) -> funName == funName_) getCFGs of
          Nothing -> error $ printf "<%s>: missing cfg for method %s" loc funName
          Just (_,_,cfg_) -> cfg_
        (_,logs,_,s) = runCFG cfgs cfg Nothing Nothing
        sloops :: [SymExpr]
        sloops = Map.elems $ flip Map.filterWithKey s $ \case
          ScopeRange _ -> \case
            SLoop _ _ _ _ _ -> True
            _ -> False
          _ -> const False
        loopSummaries :: [LoopSummary]
        loopSummaries = [loopSummary | SLoop _ _ _ (Just loopSummary) _ <- sloops]
    return $ testCase (yellow $ printf "%d) %s" counter funName)
           $ assertBool (printf "\n\n%s\n\n" (show loopSummaries))
           $ loopSummaries == loopSummary_li_correct

loopPatternTests :: TestTree
loopPatternTests = let
  loc = globalLoc ++ ".loopPatternTests" in
  testGroup "SymbolicExecution.Internal.LoopPattern.inferLoopPatterns" $ do
    (counter,funName,loopSummary_li_correct,loopPattern_li_correct) <- zipWith3
      (\counter (_,ls) (funName,lp) -> (counter,funName,ls,lp))
        [1::Int ..] LoopSummary.Correct.allTargets LoopPattern.Correct.allTargets
    let ran_li :: [(String,Either String [(LoopPattern,[LoopSummaryTag])])]
        ran_li = map (run_inferLoopPatterns . inferLoopPatterns) loopSummary_li_correct
        errors = [err | (_,Left err) <- ran_li]
        loopPatterns = [li | (_,Right li) <- ran_li]
    return $ testCase (yellow $ printf "%d) %s" counter funName) $ case errors of
      [] -> assertBool (printf "\n\n%s\n\n" (show loopPatterns))
            $ loopPatterns == loopPattern_li_correct
      _ -> assertBool (intercalate "\n\n" errors) False

main :: IO ()
--main = defaultMain isolatorTests

main = defaultMain
  $ testGroup "All tests" [
      isolatorTests,
      loopSummaryTests,
      loopPatternTests,
      javaMethodTests 1,javaMethodTests 2,javaMethodTests 3
    ]

