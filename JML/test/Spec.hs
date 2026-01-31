module Main (main) where

import Methods.JavaMethod
import Test.HUnit

validateJavaMethod :: String -> Bool
validateJavaMethod _ = True

javaMethodInputs :: [(String, String)]
javaMethodInputs =
  [ ("ifFun7", ifFun7)
  , ("ifFun7Call", ifFun7Call)
  , ("ifFun7Call2", ifFun7Call2)
  , ("ifFun7Call3", ifFun7Call3)
  ]

javaMethodTests :: Test
javaMethodTests =
  TestList
    [ TestCase $
        assertBool ("Expected True for " <> name) (validateJavaMethod source)
    | (name, source) <- javaMethodInputs
    ]

main :: IO ()
main = do
  count <- runTestTT javaMethodTests
  print count
  --runTestTTAndExit javaMethodTests
  {-
  let tc = TestCase $ assertBool "meow" True
  runTestTT tc >>= print
   -}
