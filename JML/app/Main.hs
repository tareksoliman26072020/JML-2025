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
import qualified CFG.Types as CFGT (CFG(..), showCFG, Node(..), ScopeRange(..), Kind(..), NodeData(..))

import qualified SymbolicExecution.Types as SYT
import qualified SymbolicExecution.Method as SYM (runCFG)
import qualified SymbolicExecution.Logs.PrettyPrint as SY.PP.Log
import qualified SymbolicExecution.Internal.Math.Calculator as SY.Calculator
import qualified SymbolicExecution.Internal.Internal as SY.Internal (cast, toSymType2, getFunName, modifyVoidMethod)

import qualified JML.Types as JMLT
import qualified JML.Internal.Internal as JML.Internal
import qualified JML.PrettyPrint as JML.PP (ppBehaviors, pp_CFG_JML)
import qualified JML.Logs.Log as JML.Log (Log)
import qualified JML.Logs.PrettyPrint as JML.PP.Log (ppLogs, LogKind(Console))
import qualified JML.Method as JML (runSE)

import qualified Methods.JavaMethod as JavaMethod

import Text.Printf (printf)


-------------------------

import SymbolicExecution.Internal.Math.Isolator (isolate, run_isolate, IsolationFailureReason)
import qualified SymbolicExecution.Logs.Log as Log (Log, Header(..))
import Control.Monad.Except
import Control.Monad.Writer
import Control.Monad.Reader
import qualified Control.Monad.State as MonadicState

-------------------------

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

printSymState0 :: String -> String -> Bool -> IO SYT.SymbolicExecution
printSymState0 fileName funName withLogs = readFile fileName >>=
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

-- print specific given java method SymState to the console
printSymState1 :: String -> Bool -> IO SYT.SymbolicExecution
printSymState1 funName withLogs = printSymState0 "test1.java" funName withLogs

-- print specific given method in `JavaMethod.javaMethodInputs` to the console
printSymState2 :: String -> IO SYT.SymbolicExecution
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
      let li2 = map (\(funName,_,source) ->
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
  $ map (\(counter,(funName,_,source)) -> (counter,(funName,CFG1.exec $ fromRight undefined $ parse parseExtDecl "" source)))
  -- [(Int,(String, String))]
  $ zip [1 :: Int ..] JavaMethod.javaMethodInputs

-- write logs of specific given java method from test1.java to logs/
writeSymState :: String -> IO SYT.SymbolicExecution
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

printJMLMethod0 :: String -> String -> Bool -> IO JMLT.Method
printJMLMethod0 fileName funName withLogs = do
  unparsed <- readFile fileName
  let loc = "Main.printJMLMethod0"
  let parsed :: [AST.Method]
      parsed = fromRight undefined (parse parseDeclList "" unparsed)
      
      cfgs :: [CFGT.CFG]
      cfgs = map CFG1.exec parsed
      
      cfg :: CFGT.CFG
      cfg = case CFG2.findCFGByName funName cfgs of
        Just cfg -> cfg
        Nothing -> error $ printf
          "Error1: %s\n\
          \  funName: %s"
          loc funName
      
      ses :: [SYT.SymbolicExecution]
      ses = flip map cfgs $ \cfg ->
        let (er,logs,s) = SYM.runCFG cfgs cfg Nothing Nothing
        in case er of
             "" -> s
             _  -> error $ printf
               "Error2: %s\n\
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
      
      jml :: (Either String [JMLT.ExecutionResult],[JML.Log.Log],JMLT.JMLState)
      jml@(error_ers,logs,jmlState) = JML.runSE (JML.Internal.se_2_map ses) se
      
      jmlMethod = JMLT.method jmlState

  if withLogs
    then putStrLn $ (JML.PP.Log.ppLogs JML.PP.Log.Console logs ++ "\n")
    else return ()

  case error_ers of
    Right _ -> do
      putStrLn $ JML.PP.pp_CFG_JML cfg (JMLT.jmlSpecifications jmlMethod)
      return jmlMethod
    Left er -> do
      putStrLn $ replicate 50 '='
      print jmlMethod
      putStrLn $ replicate 50 '='
      putStrLn $ printf
        "Error3 in %s\n\
        \%s" loc er
      return jmlMethod

printJMLMethod :: String -> Bool -> IO JMLT.Method
printJMLMethod funName withLogs = printJMLMethod0 "test1.java" funName withLogs

-----------------------------

symExpr1 :: SYT.SymExpr
symExpr1 = SYT.SymVar SYT.Int "i"

symExpr2 :: SYT.SymExpr
symExpr2 = SYT.SBin (SYT.SymVar SYT.Int "i") SYT.Add (SYT.SymInt 1)

symExpr :: SYT.SymExpr
symExpr = SYT.SBin symExpr1 SYT.Gt symExpr2

main :: IO ()
main = print $ SY.Calculator.booleanCalculator symExpr

run :: SYT.SymType
run = SY.Internal.toSymType2
  $ SYT.SymArray (Just SYT.Int) (Just $ SYT.SymInt 2) [SYT.SymInt 99,SYT.SymInt 5]

printMethod :: String -> IO ()
printMethod methodName = maybe (putStrLn "Method does not exist!") putStrLn 
  $ lookup3 methodName JavaMethod.javaMethodInputs

lookup3 :: Eq a => a -> [(a,b,c)] -> Maybe c
lookup3 elm li = let
  filtering = [c | (a,_,c) <- li, a == elm] in
  case filtering of
    [] -> Nothing
    (x:_) -> Just x

-----------------------------

method :: JMLT.Method
method = JMLT.Method {
  JMLT.name = "idByLoop",
  JMLT.jmlSpecifications = [
    JMLT.LoopSpecification
      $ JMLT.LoopInvariants {
          JMLT.loopScopeRange = CFGT.SR {CFGT.branchStart = 2, CFGT.branchEnd = 4},
          JMLT.loopClauses = [
            JMLT.CounterBoundsTemplate (JMLT.JMLInt 0) "i" (JMLT.JMLVar JMLT.Int_Type "n"),
            JMLT.LoopFrameTemplate ["i"],
            JMLT.DecreasesTemplate $ JMLT.JMLBin (JMLT.JMLVar JMLT.Int_Type "n") JMLT.Sub (JMLT.JMLVar JMLT.Int_Type "i")
          ]
        },
    JMLT.MethodSpecification
      $ JMLT.NormalBehavior {
          JMLT.behaviorScopeRange = Nothing,
          JMLT.requires = Nothing,
          JMLT.assignable = [],
          JMLT.vars = [
            JMLT.JMLVar JMLT.Int_Type "i"
              `JMLT.JMLEquals`
                JMLT.JMLVarUnknown [CFGT.SR {CFGT.branchStart = 2, CFGT.branchEnd = 4}]
                                   JMLT.Int_Type "i" (JMLT.JMLInt 0)], 
          JMLT.hasSideEffect = False,
          JMLT.ensures = [JMLT.JMLResult
            $ JMLT.JMLVarUnknown [CFGT.SR {CFGT.branchStart = 2, CFGT.branchEnd = 4}]
                                 JMLT.Int_Type "i" (JMLT.JMLInt 0)]
        }
  ]
}

cfg :: CFGT.CFG
cfg = CFGT.CFG {
  CFGT.nodes = [
    CFGT.Entry (AST.BuiltInType AST.Int) "idByLoop" [AST.VarExpr {AST.varType = Just (AST.BuiltInType AST.Int), AST.varObj = [], AST.varName = "n"}],
    CFGT.Node {CFGT.id = 1, CFGT.nodeData = CFGT.Statement (AST.AssignStmt {AST.varModifier = [], AST.assign = AST.AssignExpr {AST.assEleft = AST.VarExpr {AST.varType = Just (AST.BuiltInType AST.Int), AST.varObj = [], AST.varName = "i"}, AST.assEright = AST.NumberLiteral 0.0}}), CFGT.parent = 0},
    CFGT.Node {CFGT.id = 2, CFGT.nodeData = CFGT.BooleanExpression CFGT.While (Just (AST.BinOpExpr {AST.expr1 = AST.VarExpr {AST.varType = Nothing, AST.varObj = [], AST.varName = "i"}, AST.binOp = AST.Less, AST.expr2 = AST.VarExpr {AST.varType = Nothing, AST.varObj = [], AST.varName = "n"}})), CFGT.parent = 0},
    CFGT.Node {CFGT.id = 3, CFGT.nodeData = CFGT.Statement (AST.AssignStmt {AST.varModifier = [], AST.assign = AST.AssignExpr {AST.assEleft = AST.VarExpr {AST.varType = Nothing, AST.varObj = [], AST.varName = "i"}, AST.assEright = AST.BinOpExpr {AST.expr1 = AST.VarExpr {AST.varType = Nothing, AST.varObj = [], AST.varName = "i"}, AST.binOp = AST.Plus, AST.expr2 = AST.NumberLiteral 1.0}}}), CFGT.parent = 2},
    CFGT.Node {CFGT.id = 4, CFGT.nodeData = CFGT.Meet CFGT.While, CFGT.parent = 0},
    CFGT.End {CFGT.id = 5, CFGT.parent = 0, CFGT.mExpr = Just (AST.VarExpr {AST.varType = Nothing, AST.varObj = [], AST.varName = "i"})}
  ], CFGT.edges = [(0,[1]),(1,[2]),(2,[3,4]),(3,[2]),(4,[5])]
}

ppMethod = putStrLn $ JML.PP.pp_CFG_JML cfg $ JMLT.jmlSpecifications method

----------

f = run_isolate
  $ isolate "i" 
  $ SYT.SBin (SYT.SBin (SYT.SymVar SYT.Int "i") SYT.Lt (SYT.SymVar SYT.Int "n"))
             SYT.Add
             (SYT.SymInt 2)
