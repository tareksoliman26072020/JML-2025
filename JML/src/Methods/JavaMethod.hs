module Methods.JavaMethod where

ifFun7 :: String
ifFun7 = "public void ifFun7(int n) {\n\
         \  if(n % 2 == 0) {\n\
         \    v = \"hi\";\n\
         \  }\n\
         \  else {\n\
         \    w = \"bye\";\n\
         \  }\n\
         \}"

ifFun7Call :: String
ifFun7Call = "public void ifFun7Call() {\n\
             \  ifFun7(4);\n\
             \}"

ifFun7Call2 :: String
ifFun7Call2 = "public void ifFun7Call2() {\n\
              \  ifFun7(4);\n\
              \  ifFun7(5);\n\
              \}"

ifFun7Call3 :: String
ifFun7Call3 = "public void ifFun7Call3() {\n\
              \  ifFun7(t);\n\
              \}"
