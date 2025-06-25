module Main (main) where

import Text.ParserCombinators.Parsec
import Parser.ParseStmt
import SymbolTable.API (Visitor(visit))
import Data.Either (fromRight)
import SymbolTable.Types (MethodVisitor)
import Parser.Types (Method)
import SymbolTable.MethodVisitor

main :: IO ()
main = putStrLn "Hi"
