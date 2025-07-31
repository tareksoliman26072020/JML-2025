module Main (main) where

import Text.ParserCombinators.Parsec
import Parser.ParseStmt
import Data.Either (fromRight)
import Parser.Types (Method)

import qualified SymbolTable.SymbolTableCreator as ST (exec)
import qualified SymbolTable.Types as STT (Entry,showEntry)

import qualified CFG.CFG as CFG (exec)
import qualified CFG.Types as CFGT (CFG,showCFG)

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
  . CFG.exec . fromRight undefined . parse parseExtDecl ""

showCFG :: IO ()
showCFG = readFile "test2.java" >>= putStrLn
  . CFGT.showCFG . CFG.exec
  . fromRight undefined . parse parseExtDecl ""

------------------------------
