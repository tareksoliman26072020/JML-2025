module JML.Types where

data JOp       = JAdd | JSub | JMul | JDiv | JGt | JGe | JLt | JLe | JEq | JNe

data JMLExpr   = JVar String | JNum Int | JBin JOp JMLExpr JMLExpr | JNot JMLExpr | JOld JMLExpr

data JMLClause = Requires JMLExpr
               | Ensures JMLExpr
               | LoopInvariant JMLExpr
               | Signals String JMLExpr
               | Assignable [String]

data JMLMethod = JMLMethod
               { jmName    :: String
               , jmParams  :: [(String,String)]
               , jmClauses :: [JMLClause]
               , jmBody    :: Maybe String
               }

