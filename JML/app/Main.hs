{-# Language LambdaCase, ScopedTypeVariables #-}
module Main where

import Text.ParserCombinators.Parsec
import Parser.ParseStmt
import Data.Either (fromRight)
import Parser.Types (Method)
import Data.List (intercalate, find)
import System.Directory (doesDirectoryExist, createDirectory)
import qualified Data.Map.Lazy as Map

import qualified Parser.Types as AST

import qualified SymbolTable.SymbolTableCreator as ST (exec)
import qualified SymbolTable.Types as STT (Entry,showEntry)

import qualified CFG.CFG as CFG1 (exec)
import qualified CFG.Internal as CFG2 (findCFGByName, getPath, getCFGName)
import qualified CFG.Types as CFGT (CFG(..), showCFG, Node(..))

import qualified SymbolicExecution.Types as SYT
import qualified SymbolicExecution.Method as SYM (runCFG)
import qualified SymbolicExecution.Logs.PrettyPrint as SY.PP.Log
import qualified SymbolicExecution.Internal.Calculator as SY.Calculator
import qualified SymbolicExecution.Internal.Internal as SY.Internal (cast, toSymType2, getFunName)

import qualified JML.Types as JMLT
import qualified JML.Internal as JML.Internal
import qualified JML.PrettyPrint as JML.PP (ppClauses)
import qualified JML.Logs.Log as JML.Log (Log)
import qualified JML.Logs.PrettyPrint as JML.PP.Log (ppLogs, LogKind(Console))
import qualified JML.Method as JML (runSE)

import qualified Methods.JavaMethod as JavaMethod

import Text.Printf (printf)

getAST :: String -> IO AST.Method
getAST methodName = readFile "test1.java" >>=
  (\case Just x -> return x
         Nothing -> fail $ printf "method: %s does not exist in test1.java" methodName)
  . find ((== methodName) . snd . AST.getMethodDecl)
  . fromRight undefined . parse parseDeclList ""

getAST2 ::IO (Either ParseError Method)
getAST2 = readFile "test2.java" >>= return .
  parse parseExtDecl ""

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
getCFG methodName = readFile "test1.java" >>=
  (\case Just x -> return $ CFG1.exec x
         Nothing -> fail $ printf "method: %s does not exist in test1.java" methodName)
  . find ((== methodName) . snd . AST.getMethodDecl)
  . fromRight undefined . parse parseDeclList ""

showCFG :: String -> IO ()
showCFG methodName = readFile "test1.java" >>= putStrLn
  . CFGT.showCFG
  . (\case Just x -> CFG1.exec x
           Nothing -> error $ printf "method: %s does not exist in test1.java" methodName)
  . find ((== methodName) . snd . AST.getMethodDecl)
  . fromRight undefined . parse parseDeclList ""

------------------------------

getCFGs :: IO [CFGT.CFG]
getCFGs = readFile "test1.java" >>= return
  . map CFG1.exec
  . fromRight undefined . parse parseDeclList ""

-- print specific given java method SymState to the console
printSymState1 :: String -> Bool -> IO SYT.SymState
printSymState1 funName withLogs = readFile "test1.java" >>=
  (\cfgs -> case CFG2.findCFGByName funName cfgs of
              Just cfg0 ->
                let (er,logs,s) = SYM.runCFG cfgs cfg0 Nothing Nothing
                in case er of
                     "" -> do if withLogs
                                then putStrLn $ (SY.PP.Log.ppLogs SY.PP.Log.Console logs)
                                else return ()
                              return s
                                        
                     _  -> do if withLogs
                                then putStrLn $ (SY.PP.Log.ppLogs SY.PP.Log.Console logs)
                                else return ()
                              putStrLn $ replicate 50 '='
                              print s
                              putStrLn $ replicate 50 '='
                              putStrLn $ "Error: " ++ er
                              return s
              Nothing   -> error $ "method " ++ funName ++ " does not exist")
  . map CFG1.exec
  . fromRight undefined . parse parseDeclList ""

-- print specific given method in `JavaMethod.javaMethodInputs` to the console
printSymState2 :: String -> IO SYT.SymState
printSymState2 funName =
  (\(cfg,cfgs) ->
      let (er,logs,s) = SYM.runCFG cfgs cfg Nothing Nothing
      in case er of
           "" -> do putStrLn $ (SY.PP.Log.ppLogs SY.PP.Log.Console logs)
                    return s
           _  -> do putStrLn $ (SY.PP.Log.ppLogs SY.PP.Log.Console logs)
                    putStrLn $ replicate 50 '='
                    print s
                    putStrLn $ replicate 50 '='
                    putStrLn $ "Error: " ++ er
                    return s)
  -- (CFGT.CFG,[CFGT.CFG])
  $ (\li ->
      let li2 = map (\(funName,source) ->
            (funName,CFG1.exec $ fromRight undefined $ parse parseExtDecl "" source)) li
          search = case lookup funName li2 of
                     Nothing -> error
                       $ printf "Main.hs ==> getSymState2 ==> %s was not found in javaMethodInputs" funName
                     Just cfg -> cfg
      in (search, map snd li2)) JavaMethod.javaMethodInputs

-- write all logs to logs/
writeSymStates1 :: String -> IO ()
writeSymStates1 fileName = readFile fileName >>=
  (\cfgs ->
      let size = length cfgs
      in mapM_ (\(counter,cfg) ->
           let (er,logs,s) = SYM.runCFG cfgs cfg Nothing Nothing
               funName = CFG2.getCFGName cfg
           in do putStrLn $ printf "%d/%d ==> %s" counter size funName
                 let writingFun = writeFile
                       (printf "logs/%s.md" funName)
                       (case er of
                          "" -> SY.PP.Log.ppLogs SY.PP.Log.Markdown logs ++ "\n\n# SymState:\n" ++ show s
                          _  -> SY.PP.Log.ppLogs SY.PP.Log.Markdown logs ++ "\n\n# SymState:\n" ++ show s ++  "\n\n# error:\n" ++ er)
                 isFolderThere <- doesDirectoryExist "logs"
                 if isFolderThere
                   then writingFun
                   else createDirectory "logs" >> writingFun)
      $ zip [1 :: Int ..] cfgs)
  . map CFG1.exec
  . fromRight undefined . parse parseDeclList ""

-- write all logs of java methods in `JavaMethod.javaMethodInputs` to logs/
writeSymStates2 :: IO ()
writeSymStates2 =
  (\(li,cfgs) ->
      let size = length cfgs
      in mapM_ (\(counter,(funName,cfg)) ->
           let (er,logs,s) = SYM.runCFG cfgs cfg Nothing Nothing
           in do putStrLn $ printf "%d/%d ==> %s" counter size funName
                 let writingFun = writeFile
                       (printf "logs/%s.md" funName)
                       (case er of
                          "" -> SY.PP.Log.ppLogs SY.PP.Log.Markdown logs ++ "\n\n# SymState:\n" ++ show s
                          _  -> SY.PP.Log.ppLogs SY.PP.Log.Markdown logs ++ "\n\n# SymState:\n" ++ show s ++  "\n\n# error:\n" ++ er)
                 isFolderThere <- doesDirectoryExist "logs"
                 if isFolderThere
                   then writingFun
                   else createDirectory "logs" >> writingFun) li)
  -- ([(Int, (String,CFGT.CFG))], [CFGT.CFG])
  $ (\li -> (li, map (snd . snd) li))
  -- [(Int, (String,AST.CFGT.CFG))]
  $ map (\(counter,(funName,source)) -> (counter,(funName,CFG1.exec $ fromRight undefined $ parse parseExtDecl "" source)))
  -- [(Int,(String, String))]
  $ zip [1 :: Int ..] JavaMethod.javaMethodInputs

-- write logs of specific given java method from test1.java to logs/
writeSymState :: String -> IO SYT.SymState
writeSymState funName = readFile "test1.java" >>=
  (\cfgs -> case CFG2.findCFGByName funName cfgs of
              Just cfg0 -> do
                let (er,logs,s) = SYM.runCFG cfgs cfg0 Nothing Nothing
                    writingFun = writeFile
                       (printf "logs/%s.md" funName)
                       (case er of
                          "" -> SY.PP.Log.ppLogs SY.PP.Log.Markdown logs ++ "\n\n# SymState:\n" ++ show s
                          _  -> SY.PP.Log.ppLogs SY.PP.Log.Markdown logs ++ "\n\n# SymState:\n" ++ show s ++  "\n\n# error:\n" ++ er)
                isFolderThere <- doesDirectoryExist "logs"
                if isFolderThere
                  then writingFun
                  else createDirectory "logs" >> writingFun
                return s
              Nothing   -> error $ "method " ++ funName ++ " does not exist")
  . map CFG1.exec
  . fromRight undefined . parse parseDeclList ""

------------------------------

getPath :: String -> Int -> IO [CFGT.Node]
getPath funName startNodeId = readFile "test1.java" >>= return
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

-----------------------------

{-
printSymState1 :: String -> Bool -> IO SYT.SymState
printSymState1 funName withLogs = readFile "test1.java" >>=
  (\cfgs -> case CFG2.findCFGByName funName cfgs of
              Just cfg0 ->
                let (er,logs,s) = SYM.runCFG cfgs cfg0 Nothing Nothing
                in case er of
                     "" -> do if withLogs
                                then putStrLn $ (SY.PP.Log.ppLogs SY.PP.Log.Console logs)
                                else return ()
                              return s
                                        
                     _  -> do if withLogs
                                then putStrLn $ (SY.PP.Log.ppLogs SY.PP.Log.Console logs)
                                else return ()
                              putStrLn $ replicate 50 '='
                              print s
                              putStrLn $ replicate 50 '='
                              putStrLn $ "Error: " ++ er
                              return s
              Nothing   -> error $ "method " ++ funName ++ " does not exist")
  . map CFG1.exec
  . fromRight undefined . parse parseDeclList ""
 -}
printJMLMethod :: String -> Bool -> IO JMLT.Method
printJMLMethod funName withLogs = do
  unparsed <- readFile "test1.java"
  let loc = "Main.printJMLMethod"
  let parsed :: [AST.Method]
      parsed = fromRight undefined (parse parseDeclList "" unparsed)
      
      cfgs :: [CFGT.CFG]
      cfgs = map CFG1.exec parsed
      
      ses :: [SYT.SymbolicExecution]
      ses = flip map cfgs $ \cfg ->
        let (er,logs,s) = SYM.runCFG cfgs cfg Nothing Nothing
        in case er of
             "" -> SYT.env s
             _  -> error $ printf
               "Error1: %s\n\
               \1) funName: %s\n\n\
               \2) %s"
               loc funName er

      se :: SYT.SymbolicExecution
      se = case find (\s -> SY.Internal.getFunName s == funName) ses of
        Just se -> se
        Nothing -> error $ printf
          "Error2: %s\n\
          \%s not found"
          loc funName
      
      jml :: (String,[JML.Log.Log],JMLT.JMLState)
      jml@(er,logs,jmlState) = JML.runSE (JML.Internal.se_2_map ses) se

      method :: JMLT.Method
      method = JMLT.method jmlState

  if withLogs
    then putStrLn $ (JML.PP.Log.ppLogs JML.PP.Log.Console logs ++ "\n")
    else return ()

  case er of
    "" -> do
      putStrLn $ JML.PP.ppClauses (JMLT.clauses method)
      return method
    _  -> do
      putStrLn $ replicate 50 '='
      print method
      putStrLn $ replicate 50 '='
      putStrLn $ printf
        "Error3 in %s\n\
        \%s" loc er
      return method

-----------------------------

symExpr1 :: SYT.SymExpr
symExpr1 = SYT.SymFun SYT.ToString
  $ SYT.SBin (SYT.SymInt 1) SYT.Add (SYT.SymVar SYT.Int "n")

symExpr2 :: SYT.SymExpr
symExpr2 = SYT.SymString "!"

symExpr :: SYT.SymExpr
symExpr = SYT.SBin symExpr1 SYT.Add symExpr2

main :: IO ()
main = print $ SY.Calculator.booleanCalculator $ SYT.SBin (SYT.SymInt 0) SYT.Lt (SYT.SymInt 0)

run :: SYT.SymType
run = SY.Internal.toSymType2
  $ SYT.SymArray (Just SYT.Int) (Just $ SYT.SymInt 2) [SYT.SymInt 99,SYT.SymInt 5]

printMethod :: String -> IO ()
printMethod methodName = maybe (putStrLn "Method does not exist!") putStrLn 
  $ lookup methodName JavaMethod.javaMethodInputs

