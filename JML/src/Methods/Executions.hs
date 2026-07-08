{-# Language LambdaCase #-}
module Methods.Executions where

import Text.ParserCombinators.Parsec (parse)
import Data.Either (fromRight)
import Methods.JavaMethod (javaMethodInputs)
import Parser.ParseStmt (parseExtDecl)

import qualified CFG.Types as CFGT (CFG)
import qualified SymbolicExecution.Types as SYT (SymbolicExecution, SymbolicExecutionValue, SymExpr(..), SymbolicExecutionKey, SymStateKey(..))
import qualified JML.Types as JMLT
import qualified Data.Map as Map

import SymbolicExecution.Method (runCFG)
import JML.Method (runSE)
import JML.Internal.Internal (se_2_map)

import CFG.CFG (exec)

getCFGs :: [(String,Int,CFGT.CFG)]
getCFGs = flip map javaMethodInputs $ \(funName,groupNumber,source) ->
  (funName, groupNumber, exec $ fromRight undefined $ parse parseExtDecl "" source)

thrd :: (a,b,c) -> c
thrd (_,_,elm) = elm

cfgs :: [CFGT.CFG]
cfgs = map thrd getCFGs

getSymbolicExecutions :: [(String,Int,SYT.SymbolicExecution)]
getSymbolicExecutions = flip map getCFGs $ \(methodName,groupNumber,cfg) -> let
    (_,_,symbolicExecution) = runCFG cfgs cfg Nothing Nothing
    in (methodName,groupNumber,symbolicExecution)

getSLoops :: [(String,Int,[SYT.SymbolicExecutionValue])]
getSLoops = do
  (funName,groupNumber,sy) <- getSymbolicExecutions
  return
    $ (,,) funName groupNumber
    $ Map.elems
    $ flip Map.filterWithKey sy
    $ \case SYT.ScopeRange _ -> \case
              SYT.SLoop _ _ _ _ _ -> True
              _ -> False
            _ -> const False

symbolicExecutions :: Map.Map String SYT.SymbolicExecution
symbolicExecutions = se_2_map $ map thrd getSymbolicExecutions
{-
isInGroup :: Int -> String -> Bool
isInGroup groupNumber methodName = let
  finding = find (\(name,num,_) -> name==methodName && groupNumber==num) javaMethodInputs in
  case finding of
    Just _ -> True
    _ -> False
 -}
