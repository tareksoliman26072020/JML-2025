{-# Language LambdaCase #-}
module Main (main) where

import Text.ParserCombinators.Parsec
import Parser.ParseStmt
import Data.Either (fromRight)
import Parser.Types (Method)
import Data.List (intercalate, find)

import qualified Parser.Types as AST

import qualified SymbolTable.SymbolTableCreator as ST (exec)
import qualified SymbolTable.Types as STT (Entry,showEntry)

import qualified CFG.CFG as CFG1 (exec)
import qualified CFG.Internal as CFG2 (findCFGByName, getPath, getCFGName)
import qualified CFG.Types as CFGT (CFG(..), showCFG, Node(..))

import qualified SymbolicExecution.Types as SYT
import qualified SymbolicExecution.Method as SYM (runCFG)
import qualified SymbolicExecution.Logs.PrettyPrint as SYT.Log
import SymbolicExecution.Internal.Internal (findSymType, cast)
import SymbolicExecution.Internal.Calculator (numericCalculator, booleanCalculator)

import qualified Methods.JavaMethod as Method

import Text.Printf (printf)

cfg = CFGT.CFG {
  CFGT.nodes = [
    CFGT.Entry (AST.BuiltInType AST.Int) "boo21" [],
    CFGT.End {CFGT.id = 1, CFGT.parent = 0, CFGT.mExpr = Just (AST.NumberLiteral 5.0)}],
    CFGT.edges = [(0,[1])]
}

main :: IO ()
main = putStrLn $ Method.ifFun7Call3

getAST :: String -> IO AST.Method
getAST methodName = readFile "test3.java" >>=
  (\case Just x -> return x
         Nothing -> fail $ printf "method: %s does not exist in test3.java" methodName)
  . find ((== methodName) . snd . AST.getMethodDecl)
  . fromRight undefined . parse parseDeclList ""

getSymbolTable :: IO STT.Entry
getSymbolTable = readFile "test2.java" >>= return
  . ST.exec
  . fromRight undefined . parse parseExtDecl ""

showSymbolTable :: IO ()
showSymbolTable = readFile "test2.java" >>= putStrLn
  . STT.showEntry . ST.exec
  . fromRight undefined . parse parseExtDecl ""

------------------------------

getCFG :: String -> IO CFGT.CFG
getCFG methodName = readFile "test3.java" >>=
  (\case Just x -> return $ CFG1.exec x
         Nothing -> fail $ printf "method: %s does not exist in test3.java" methodName)
  . find ((== methodName) . snd . AST.getMethodDecl)
  . fromRight undefined . parse parseDeclList ""

showCFG :: String -> IO ()
showCFG methodName = readFile "test3.java" >>= putStrLn
  . CFGT.showCFG
  . (\case Just x -> CFG1.exec x
           Nothing -> error $ printf "method: %s does not exist in test3.java" methodName)
  . find ((== methodName) . snd . AST.getMethodDecl)
  . fromRight undefined . parse parseDeclList ""

------------------------------

getCFGs :: IO [CFGT.CFG]
getCFGs = readFile "test3.java" >>= return
  . map CFG1.exec
  . fromRight undefined . parse parseDeclList ""

getSymState :: String -> IO SYT.SymState
getSymState funName = readFile "test3.java" >>=
  (\cfgs -> case CFG2.findCFGByName funName cfgs of
              Just cfg0 ->
                let (logs,s) = SYM.runCFG cfgs cfg0 Nothing Nothing
                in do putStrLn $ (SYT.Log.ppLogs SYT.Log.Console logs)
                      return s
              Nothing   -> error $ "method " ++ funName ++ " does not exist")
  . map CFG1.exec
  . fromRight undefined . parse parseDeclList ""

getSymStates2 :: String -> IO ()
getSymStates2 fileName = readFile fileName >>=
  (\cfgs ->
      let size = length cfgs
      in mapM_ (\(counter,cfg) ->
           let (logs,s) = SYM.runCFG cfgs cfg Nothing Nothing
               funName = CFG2.getCFGName cfg
           in do putStrLn $ printf "%d/%d ==> %s" counter size funName
                 writeFile
                   (printf "logs/%s.md" funName)
                   (SYT.Log.ppLogs SYT.Log.Markdown logs ++ "\n\nSymState:\n" ++ show s))
      $ zip [1 :: Int ..] cfgs)
  . map CFG1.exec
  . fromRight undefined . parse parseDeclList ""

------------------------------

getPath :: String -> Int -> IO [CFGT.Node]
getPath funName startNodeId = readFile "test3.java" >>= return
  . CFG2.getPath startNodeId
  . (\cfgs -> case CFG2.findCFGByName funName cfgs of
                Just cfg0 -> cfg0
                Nothing   -> error $ "method " ++ funName ++ " does not exist")
  . map CFG1.exec
  . fromRight undefined . parse parseDeclList ""

------------------------------

expr :: AST.Expression
expr = AST.BinOpExpr {
  AST.expr1 = AST.BinOpExpr {
    AST.expr1 = AST.NumberLiteral 0.0,
    AST.binOp = AST.Mult,
    AST.expr2 = AST.VarExpr {AST.varType = Nothing, AST.varObj = [], AST.varName = "i"}
  },
  AST.binOp = AST.Plus,
  AST.expr2 = AST.NumberLiteral 2.0
}

