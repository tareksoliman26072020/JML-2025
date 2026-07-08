{-# Language MultiWayIf, LambdaCase, ScopedTypeVariables #-}
module JML.Internal.LoopInvariants where

import Control.Monad.State (get)
import Text.Printf (printf)
import Data.List
import Data.Functor (($>))
import qualified Data.Map as Map (Map)

import JML.Types
import JML.Internal.Internal
import qualified JML.Logs.Log as Log

import qualified CFG.Types as CFGT (ScopeRange)

import qualified SymbolicExecution.Types as SYT (
  SymbolicExecution, SymbolicExecutionKey, SymStateKey(VarName), SymbolicExecutionValue, 
  SymExpr(..), SymBinOp(..),
  LoopSummary(..), LoopPattern(..), LoopSummaryTag(..),
  CounterPattern(..))
import qualified SymbolicExecution.Internal.Internal as SY.Internal (
  getFunName, toSymType2, getVarNameSymType,
  isLoopCountersTag)

globalLoc = "JML.Internal.LoopInvariants"

inferLoopInvariantTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferLoopInvariantTemplates loopSummary allLoopPatternsInfos = do
  let loc = globalLoc ++ ".inferLoopInvariantTemplates"
      logContents = [
        ("loopSummary",show loopSummary),
        ("allLoopPatternsInfos",show allLoopPatternsInfos)]
  constructLog loc "inferLoopInvariantTemplates" logContents
  ----------------------------
  -- theCounterBoundsTemplates
  ----------------------------
  theCounterBoundsTemplates <- let
    relevantLoopPatternsInfos = [(loopPattern,relevantTags)
      | (loopPattern,tags) <- allLoopPatternsInfos
      , isCounterBoundsTemplatePattern loopPattern
      , let relevantTags = filter isCounterBoundsTemplateTag tags
      ] in do
    incrementLogEnumeration
    incrementLogDepth *>
      inferCounterBoundsTemplates loopSummary relevantLoopPatternsInfos
        <* decrementLogDepth
  ------------------------
  -- theLoopFrameTemplates
  ------------------------
  theLoopFrameTemplates <- let
    relevantLoopPatternsInfos = [(loopPattern,relevantTags)
      | (loopPattern,tags) <- allLoopPatternsInfos
      , isLoopFrameTemplatePattern loopPattern
      , let relevantTags = filter isLoopFrameTemplateTag tags
      ] in do
    incrementLogEnumeration
    incrementLogDepth *>
      inferLoopFrameTemplates loopSummary relevantLoopPatternsInfos
        <* decrementLogDepth
  ------------------------
  -- theDecreasesTemplates
  ------------------------
  theDecreasesTemplates <- let
    relevantLoopPatternsInfos = [(loopPattern,relevantTags)
      | (loopPattern,tags) <- allLoopPatternsInfos
      , isDecreasesTemplatePattern loopPattern
      , let relevantTags = filter isDecreasesTemplateTag tags
      ] in do
    incrementLogEnumeration
    incrementLogDepth *>
      inferDecreasesTemplates loopSummary relevantLoopPatternsInfos
        <* decrementLogDepth
  -----------
  -- toReturn
  -----------
  let toReturn =
        theCounterBoundsTemplates ++
        theLoopFrameTemplates ++
        theDecreasesTemplates
  constructLog loc "Summary" $ logContents ++
    [("theCounterBoundsTemplates",show theCounterBoundsTemplates)
    ,("theLoopFrameTemplates",show theLoopFrameTemplates)
    ,("theDecreasesTemplates",show theDecreasesTemplates)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn
{-
data LoopPattern
  = CounterPattern CounterPattern
  | BoundPattern BoundPattern
  | TraversalPattern TraversalPattern
  | MutationPattern MutationPattern
  | AccumulatorPattern AccumulatorPattern
  | SearchPattern SearchPattern
  | ControlFlowPattern ControlFlowPattern
  | HelperCallPattern
  | TwoFrontierPattern
  | UnknownPattern
 -}
-- CounterPattern ==> loopCountersBounds ==> CounterBoundsTemplate
inferCounterBoundsTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferCounterBoundsTemplates loopSummary loopPatternsInfos = do
  let loc = globalLoc ++ ".inferCounterBoundsTemplates"
      logContents = [("loopPatternsInfos",show loopPatternsInfos)]
  constructLog loc "inferCounterBoundsTemplates" logContents
  let checkPatterns = [tu
        | tu@(SYT.CounterPattern _,[SYT.LoopCountersBounds]) <- loopPatternsInfos
        ]
  let toReturn :: [LoopInvariantTemplate]
      toReturn = case checkPatterns of
        [] -> []
        [_] -> [res
          | (l,c,u) <- SYT.loopCountersBounds loopSummary
          , let res = CounterBoundsTemplate
                  (symExprToExpr2 l) c (symExprToExpr2 u)
          ]
        _ -> error $ constructErrorMsg loc "won't happen" $ logContents
          ++ [("checkPatterns",show checkPatterns)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-- CounterPattern ==> LoopFrameTargets ==> LoopFrameTemplate
inferLoopFrameTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferLoopFrameTemplates loopSummary loopPatternsInfos = do
  let loc = globalLoc ++ ".inferLoopFrameTemplates"
      logContents = [("loopPatternsInfos",show loopPatternsInfos)]
  constructLog loc "inferLoopFrameTemplates" logContents
  let checkPatterns = [tu
        | tu@(SYT.CounterPattern _,[SYT.LoopFrameTargets]) <- loopPatternsInfos
        ]
  let toReturn = case checkPatterns of
        [] -> []
        [_] -> [LoopFrameTemplate $ SYT.loopFrameTargets loopSummary]
        _ -> error $ constructErrorMsg loc "won't happen" $ logContents
          ++ [("checkPatterns",show checkPatterns)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-- CounterPattern ==> LoopDecreasesCandidate ==> DecreasesTemplate
inferDecreasesTemplates :: SYT.LoopSummary -> [(SYT.LoopPattern,[SYT.LoopSummaryTag])] -> JMLMonad [LoopInvariantTemplate]
inferDecreasesTemplates loopSummary loopPatternsInfos = do
  let loc = globalLoc ++ ".inferDecreasesTemplates"
      logContents = [("loopSummary",show loopSummary),("loopPatternsInfos",show loopPatternsInfos)]
  constructLog loc "inferDecreasesTemplates" logContents
  let checkPatterns = [tu
        | tu@(SYT.CounterPattern _,[SYT.LoopDecreasesCandidate]) <- loopPatternsInfos
        ]
  let toReturn = case checkPatterns of
        [] -> []
        [_] -> [res
          | candidate <- SYT.loopDecreasesCandidate loopSummary
          , let res = DecreasesTemplate $ symExprToExpr2 candidate
          ]
        _ -> error $ constructErrorMsg loc "won't happen" $ logContents
          ++ [("checkPatterns",show checkPatterns)]
  (tellNextLog $ Log.Return loc (show toReturn)) $> toReturn

-----------
-----------
-----------

run_inferLoopInvariantTemplates :: Map.Map String SYT.SymbolicExecution -> String -> JMLMonad [LoopInvariantTemplate] -> (Either String [LoopInvariantTemplate],[Log.Log],JMLState)
run_inferLoopInvariantTemplates = runMonad
  
