{-# Language LambdaCase #-}
module SymbolicExecution.PrettyPrint where

import SymbolicExecution.Types (SymExpr, LoopExitFact, LoopSummary(..), LoopPattern(..), LoopSummaryTag(..))
import qualified Parser.Types as AST
import qualified CFG.Types as CFGT (CFG, NodeID, Node, ScopeRange, Node_Coor, Kind)
import qualified Data.Map as Map (Map)
import Text.Printf (printf)
import Data.List (intercalate)

ppLoopSummary :: LoopSummary -> String
ppLoopSummary ls =
  "LoopSummary:\n" ++
  "  loopSyntax: " ++ (show $ loopSyntax ls) ++ "\n" ++
  "  loopReadOnlyVars: " ++ (ifEmpty $ show $ loopReadOnlyVars ls) ++ "\n" ++
  "  loopFrameTargets: " ++ (ifEmpty $ show $ loopFrameTargets ls) ++ "\n" ++
  "  loopInitFacts:\n    " ++ (ifEmpty $ intercalate "\n    " (map show $ loopInitFacts ls)) ++ "\n" ++
  "  loopGuard: " ++ (ifEmpty $ show $ loopGuard ls) ++ "\n" ++
  "  loopEnteringCondition: " ++ (ifEmpty $ show $ loopEnteringCondition ls) ++ "\n" ++
  "  loopSkipCondition: " ++ (ifEmpty $ show $ loopSkipCondition ls) ++ "\n" ++
  "  loopExitingConditions:\n    " ++ (ifEmpty $ intercalate "\n    " (map ppLoopExitingCondition $ loopExitingConditions ls)) ++ "\n" ++
  "  loopExitViaBreakFacts:\n    " ++ (ifEmpty $ intercalate "\n    " (map show $ loopExitViaBreakFacts ls)) ++ "\n" ++
  "  loopExitViaReturnFacts:\n    " ++ (ifEmpty $ intercalate "\n    " (map show $ loopExitViaReturnFacts ls)) ++ "\n" ++
  "  loopCounters: " ++ (ifEmpty $ show (loopCounters ls)) ++ "\n" ++
  "  dynamicallyAccessedArrays:\n    " ++ (ifEmpty $ intercalate "\n    " (map show $ dynamicallyAccessedArrays ls)) ++ "\n" ++
  "  loopAssignments: " ++ (ifEmpty $ show (loopAssignments ls)) ++ "\n" ++
  "  loopFrameTargetsDevelopmentTrajectory:\n    " ++ (ifEmpty $ intercalate "\n    " (map show $ loopFrameTargetsDevelopmentTrajectory ls)) ++ "\n" ++
  "  loopExitFacts:\n    " ++ (ifEmpty $ intercalate "\n    " (map ppLoopExitFacts $ loopExitFacts ls)) ++ "\n" ++
  "  loopCountersBounds:\n    " ++ (ifEmpty $ intercalate "\n    " (map show $ loopCountersBounds ls)) ++ "\n" ++
  "  loopBoundStabilityFacts:\n    " ++ (ifEmpty $ intercalate "\n    " (map show $ loopBoundStabilityFacts ls)) ++ "\n" ++
  "  loopDecreasesCandidate:\n    " ++ (ifEmpty $ intercalate "\n    " (map show $ loopDecreasesCandidate ls))
  where
  ifEmpty :: String -> String
  ifEmpty = \case
    "" -> "NONE"
    s  -> s
  ppLoopExitingCondition :: (CFGT.Node_Coor,SymExpr) -> String
  ppLoopExitingCondition (one,two) = printf
    "(%s,\n     %s)" (show one) (show two)
  ppLoopExitFacts :: (CFGT.Node_Coor,LoopExitFact) -> String
  ppLoopExitFacts (one,two) = printf
    "(%s,\n     %s)" (show one) (show two)

ppLoopPatterns :: [(LoopPattern,[LoopSummaryTag])] -> String
ppLoopPatterns li = "LoopPatterns:\n  " ++ intercalate "\n  " (map f li) where
  f :: (LoopPattern,[LoopSummaryTag]) -> String
  f (one,two) = printf "(%s,\n   [%s])" (show one) (intercalate "\n   ," $ map show two)
