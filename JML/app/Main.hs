module Main (main) where

import Text.ParserCombinators.Parsec
import Parser.ParseStmt
import SymbolTable.API (Visitor(visitMethod))
import Data.Either (fromRight)
import Parser.Types (Method)
import SymbolTable.SymbolTableCreator

main :: IO ()
main = putStrLn "Hi"
