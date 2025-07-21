module Main (main) where

import Text.ParserCombinators.Parsec
import Parser.ParseStmt
import Visitors.API (ASTVisitor(visitMethod))
import Data.Either (fromRight)
import Parser.Types (Method)
import SymbolTable.SymbolTableCreator(SymbolTableCreator)
import qualified CFG.CFG as CFG
import qualified CFG.Types as CFGT

main :: IO ()
main = putStrLn "Hi"

getCFG :: IO CFGT.CFG
getCFG = readFile "test2.java" >>= return
  . CFG.exec . fromRight undefined . parse parseExtDecl ""

showCFG :: IO ()
showCFG = readFile "test2.java" >>= putStrLn
  . CFG.showCFGCreator . visitMethod
  . fromRight undefined . parse parseExtDecl ""
