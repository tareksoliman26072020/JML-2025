module Main (main) where

import Text.ParserCombinators.Parsec
import Parser.ParseStmt
import Data.Either (fromRight)
import Parser.Types (Method)

import qualified Parser.Types as AST

import qualified SymbolTable.SymbolTableCreator as ST (exec)
import qualified SymbolTable.Types as STT (Entry,showEntry)

import qualified CFG.CFG as CFG (exec)
import qualified CFG.Types as CFGT (CFG(..), showCFG, Node(..), findCFGByName)

import qualified SymbolicExecution.Types as SYT
import qualified SymbolicExecution.SymbolicExecution as SY (runCFG)

cfg = CFGT.CFG {
  CFGT.nodes = [
    CFGT.Entry AST.Int "boo21",
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

getCFGs :: IO [CFGT.CFG]
getCFGs = readFile "test3.java" >>= return
  . map CFG.exec
  . fromRight undefined . parse parseDeclList ""

getSymState :: String -> IO SYT.SymState
getSymState funName = readFile "test3.java" >>= return
  . (\cfgs -> case CFGT.findCFGByName funName cfgs of
                Just cfg0 -> SY.runCFG cfgs cfg0
                Nothing   -> error "won't happen")
  . map CFG.exec
  . fromRight undefined . parse parseDeclList ""
{-
getSymState :: IO SYT.SymState
getSymState = readFile "test2.java" >>= return
  . SY.runCFG undefined
  . CFG.exec
  . fromRight undefined . parse parseExtDecl ""
-}
