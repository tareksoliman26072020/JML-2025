module Main (main) where

import Text.ParserCombinators.Parsec
import Parser.ParseStmt
import Data.Either (fromRight)
import Parser.Types (Method)

import qualified Parser.Types as AST

import qualified SymbolTable.SymbolTableCreator as ST (exec)
import qualified SymbolTable.Types as STT (Entry,showEntry)

import qualified CFG.CFG as CFG (exec)
import qualified CFG.Types as CFGT (CFG(..), showCFG, Node(..))

import qualified SymbolicExecution.Types as SYT
import qualified SymbolicExecution.SymbolicExecution as SY (runCFG)

cfg = CFGT.CFG {
  CFGT.nodes = [
    CFGT.Entry AST.Int,
    CFGT.End {CFGT.id = 1, CFGT.parent = 0, CFGT.mExpr = Just (AST.NumberLiteral 5.0)}],
    CFGT.edges = [(0,[1])]
}

main :: IO ()
main = putStrLn "Hi"

getSymbolTable :: IO STT.Entry
getSymbolTable = readFile "test2.java" >>= return
  . ST.exec
  . fromRight undefined . parse parseExtDecl ""

showSymbolTable :: IO ()
showSymbolTable = readFile "test2.java" >>= putStrLn
  . STT.showEntry . ST.exec
  . fromRight undefined . parse parseExtDecl ""

------------------------------

getCFG :: IO CFGT.CFG
getCFG = readFile "test2.java" >>= return
  . CFG.exec
  . fromRight undefined . parse parseExtDecl ""

showCFG :: IO ()
showCFG = readFile "test2.java" >>= putStrLn
  . CFGT.showCFG . CFG.exec
  . fromRight undefined . parse parseExtDecl ""

------------------------------

getSymState :: IO SYT.SymState
getSymState = readFile "test2.java" >>= return
  . SY.runCFG
  . CFG.exec
  . fromRight undefined . parse parseExtDecl ""
