module Methods.Executions where

import Text.ParserCombinators.Parsec (parse)
import Data.Either (fromRight)
import Methods.JavaMethod (javaMethodInputs)
import Parser.ParseStmt (parseExtDecl)

import qualified CFG.Types as CFGT (CFG)
import qualified SymbolicExecution.Types as SYT (SymbolicExecution)
import qualified JML.Types as JMLT
import qualified Data.Map as Map

import SymbolicExecution.Method (runCFG)
import JML.Method (runSE)
import JML.Internal (se_2_map)

import CFG.CFG (exec)

getCFGs :: [(String,CFGT.CFG)]
getCFGs = flip map javaMethodInputs $ \(funName,source) ->
  (funName, exec $ fromRight undefined $ parse parseExtDecl "" source)

cfgs :: [CFGT.CFG]
cfgs = map snd getCFGs

getSymbolicExecutions :: [(String,SYT.SymbolicExecution)]
getSymbolicExecutions = flip map getCFGs $ \(methodName,cfg) -> let
    (_,_,symbolicExecution) = runCFG cfgs cfg Nothing Nothing
    in (methodName,symbolicExecution)

symbolicExecutions :: Map.Map String SYT.SymbolicExecution
symbolicExecutions = JML.Internal.se_2_map $ map snd getSymbolicExecutions
