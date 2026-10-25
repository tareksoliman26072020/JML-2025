{-# Language LambdaCase #-}
module SymbolicExecution.PrettyPrint where

import SymbolicExecution.Types (LoopSummary(..),LoopPattern(..))
import qualified Parser.Types as AST
import qualified CFG.Types as CFGT (CFG, NodeID, Node, ScopeRange, Node_Coor, Kind)
import qualified Data.Map as Map (Map)
import Text.Printf (printf)
import Data.List (intercalate)

ppLoopSummary :: LoopSummary -> String
ppLoopSummary = undefined

ppLoopPatterns :: [LoopPattern] -> String
ppLoopPatterns = undefined
