module Internal.Math.Isolator where

import CFG.Types (ScopeRange(..))
import qualified SymbolicExecution.Types as SYT (SymType(..))
import SymbolicExecution.Types (SymExpr(..), SymBinOp(..))
import SymbolicExecution.Internal.Math.Isolator (IsolationFailureReason(..))

allTargets :: [(String,SymExpr,Either IsolationFailureReason SymExpr)]
allTargets = [
  ("5"                     ,example1,example1_correct)
 ,("j"                     ,example2,example2_correct)
 ,("i"                     ,example3,example3_correct)
 ,("i+1"                   ,example4,example4_correct)
 ,("i+1 > n"               ,example5,example5_correct)
 ,("1+i <= n"              ,example6,example6_correct)
 ,("i-1 >= n"              ,example7,example7_correct)
 ,("1-i < n"               ,example8,example8_correct)
 ,("2*i == n"              ,example9,example9_correct)
 ,("i*(-2) > n"            ,example10,example10_correct)
 ,("i/2 <= n"              ,example11,example11_correct)
 ,("i/(-2) < n"            ,example12,example12_correct)
 ,("n < i+1"               ,example13,example13_correct)
 ,("n >= i-1"              ,example14,example14_correct)
 ,("(i+1)*2 > n"           ,example15,example15_correct)
 ,("2*(i-3) <= n"          ,example16,example16_correct)
 ,("2-(i+1) > n"           ,example17,example17_correct)
 ,("i%2 == 0"              ,example18,example18_correct)
 ,("i*j > n"               ,example19,example19_correct)
 ,("i+j > n"               ,example20,example20_correct)
 ,("i+i > n"               ,example21,example21_correct)
 ,("i > i+1"               ,example22,example22_correct)
 ,("i*0 > n"               ,example23,example23_correct)
 ,("i/j > n"               ,example24,example24_correct)
 ,("j/i > n"               ,example25,example25_correct)
 ,("i+1 == n"              ,example26,example26_correct)
 ,("i+1 /= n"              ,example27,example27_correct)
 ,("!(i+1 > n)"            ,example28,example28_correct)
 ,("(i+1>n) && (j>0)"      ,example29,example29_correct)
 ,("(j>0) || (n<i+1)"      ,example30,example30_correct)
 ,("(i+1>n) && (i-1<m)"    ,example31,example31_correct)
 ,("not ((i+1>n) && (j>0))",example32,example32_correct)
 ,("2*i+j > i+1"           ,example33,example33_correct)
 ,("i+j > i+1"             ,example34,example34_correct)
 ,("i-j > i+1"             ,example35,example35_correct)
 ,("j-i > i+1"             ,example36,example36_correct)
 ,("i+1 > i+j"             ,example37,example37_correct)
 ,("2*i+j <= i+n"          ,example38,example38_correct)
 ,("2*i-j <= i+n"          ,example39,example39_correct)
 ,("i-3 >= i+n"            ,example40,example40_correct)
 ,("(i+j)-(i+1) > n"       ,example41,example41_correct)
 ]

--------------------

-- 5
example1 :: SymExpr
example1 = SymInt 5

example1_correct = Left VarAbsent

--------------------

-- j
example2 :: SymExpr
example2 = SymVar SYT.Int "j" []

example2_correct = Left VarAbsent

--------------------

-- i
example3 :: SymExpr
example3 = SymVar SYT.Int "i" []

example3_correct = Right $ SymVar SYT.Int "i" []

--------------------

-- i+1
example4 = SBin
  (SymVar SYT.Int "i" [])
  Add
  (SymInt 1)

example4_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Add
         (SymInt 1)

--------------------

-- i+1>n
example5 = SBin
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))
  Gt
  (SymVar SYT.Int "n" [])

-- i>n-1
example5_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Gt
         (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1))

--------------------

-- 1+i <= n
example6 = SBin
  (SBin (SymInt 1) Add (SymVar SYT.Int "i" []))
  Le
  (SymVar SYT.Int "n" [])
-- i <= n-1
example6_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Le
         (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1))

--------------------

-- i-1 >= n
example7 = SBin
  (SBin (SymVar SYT.Int "i" []) Sub (SymInt 1))
  Ge
  (SymVar SYT.Int "n" [])
-- i >= n+1
example7_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Ge
         (SBin (SymVar SYT.Int "n" []) Add (SymInt 1))

--------------------

-- 1-i < n
example8 = SBin
  (SBin (SymInt 1) Sub (SymVar SYT.Int "i" []))
  Lt
  (SymVar SYT.Int "n" [])
-- i > 1-n
example8_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Gt
         (SBin (SymInt 1) Sub (SymVar SYT.Int "n" []))

--------------------

-- 2*i == n
example9 = SBin
  (SBin (SymInt 2) Mul (SymVar SYT.Int "i" []))
  Eq
  (SymVar SYT.Int "n" [])
-- i == n/2
example9_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Eq
         (SBin (SymVar SYT.Int "n" []) Div (SymInt 2))

--------------------

-- i*(-2) > n
example10 = SBin
  (SBin (SymVar SYT.Int "i" []) Mul (SymInt (-2)))
  Gt
  (SymVar SYT.Int "n" [])
-- i < n/(-2)
example10_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Lt
         (SBin (SymVar SYT.Int "n" []) Div (SymInt (-2)))

--------------------

-- i/2 <= n
example11 = SBin
  (SBin (SymVar SYT.Int "i" []) Div (SymInt 2))
  Le
  (SymVar SYT.Int "n" [])
-- i <= n*2
example11_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Le
         (SBin (SymVar SYT.Int "n" []) Mul (SymInt 2))

--------------------

-- i/(-2) < n
example12 = SBin
  (SBin (SymVar SYT.Int "i" []) Div (SymInt (-2)))
  Lt
  (SymVar SYT.Int "n" [])
-- i > n*(-2)
example12_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Gt
         (SBin (SymVar SYT.Int "n" []) Mul (SymInt (-2)))

--------------------

-- n < i+1
example13 = SBin
  (SymVar SYT.Int "n" [])
  Lt
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))
-- i > n-1
example13_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Gt
         (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1))

--------------------

-- n >= i-1
example14 = SBin
  (SymVar SYT.Int "n" [])
  Ge
  (SBin (SymVar SYT.Int "i" []) Sub (SymInt 1))

-- i <= n+1
example14_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Le
         (SBin (SymVar SYT.Int "n" []) Add (SymInt 1))

--------------------

-- (i+1)*2 > n
example15 = SBin
  (SBin (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))
        Mul
        (SymInt 2))
  Gt
  (SymVar SYT.Int "n" [])

-- i > ((n/2) - 1)
example15_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Gt
         (SBin (SBin (SymVar SYT.Int "n" []) Div (SymInt 2))
               Sub
               (SymInt 1))

--------------------

-- 2*(i-3) <= n
example16 = SBin
  (SBin (SymInt 2)
        Mul
        (SBin (SymVar SYT.Int "i" []) Sub (SymInt 3)))
  Le
  (SymVar SYT.Int "n" [])

-- i <= (n/2) + 3
example16_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Le
         (SBin (SBin (SymVar SYT.Int "n" []) Div (SymInt 2)) Add (SymInt 3))

--------------------

-- 2-(i+1) > n
example17 = SBin
  (SBin (SymInt 2)
        Sub
        (SBin (SymVar SYT.Int "i" []) Add (SymInt 1)))
  Gt
  (SymVar SYT.Int "n" [])

-- i < (1-n)
example17_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Lt
         (SBin (SymInt 1) Sub (SymVar SYT.Int "n" []))

--------------------

-- i%2 == 0
example18 = SBin
  (SBin (SymVar SYT.Int "i" []) Mod (SymInt 2))
  Eq
  (SymInt 0)

example18_correct = Right example18

--------------------

-- i*j > n
example19 = SBin
  (SBin (SymVar SYT.Int "i" []) Mul (SymVar SYT.Int "j" []))
  Gt
  (SymVar SYT.Int "n" [])

example19_correct = Left $ AmbiguousSign "j"

--------------------

-- i+j > n
example20 = SBin
  (SBin (SymVar SYT.Int "i" []) Add (SymVar SYT.Int "j" []))
  Gt
  (SymVar SYT.Int "n" [])

-- i > n-j
example20_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Gt
         (SBin (SymVar SYT.Int "n" []) Sub (SymVar SYT.Int "j" []))

--------------------

-- i+i > n
example21 = SBin
  (SBin (SymVar SYT.Int "i" []) Add (SymVar SYT.Int "i" []))
  Gt
  (SymVar SYT.Int "n" [])

-- i > n/2
example21_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Gt
         (SBin (SymVar SYT.Int "n" []) Div (SymInt 2))


--------------------

-- i > i+1
example22 = SBin
  (SymVar SYT.Int "i" [])
  Gt
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))

-- false
example22_correct = Left AlwaysFalse

--------------------

-- i*0 > n
example23 = SBin
  (SBin (SymVar SYT.Int "i" []) Mul (SymInt 0))
  Gt
  (SymVar SYT.Int "n" [])

-- Nothing
example23_correct = Left $ Eliminated (SBin (SymInt 0) Gt (SymVar SYT.Int "n" []))

--------------------

-- i/j > n
example24 = SBin
  (SBin (SymVar SYT.Int "i" []) Div (SymVar SYT.Int "j" []))
  Gt
  (SymVar SYT.Int "n" [])

-- i > n*j
example24_correct = Left $ AmbiguousSign "j"

--------------------

-- j/i > n
example25 = SBin
  (SBin (SymVar SYT.Int "j" []) Div (SymVar SYT.Int "i" []))
  Gt
  (SymVar SYT.Int "n" [])

-- i < j/n
example25_correct = Left $ AmbiguousSign "j"

--------------------

-- i+1 == n
example26 = SBin
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))
  Eq
  (SymVar SYT.Int "n" [])

-- i == n-1
example26_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Eq
         (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1))

--------------------

-- i+1 /= n
example27 = SBin
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))
  Neq
  (SymVar SYT.Int "n" [])

-- i /= n-1
example27_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Neq
         (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1))

--------------------

-- !(i+1 > n)
example28 = SNot $
  SBin (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))
  Gt
  (SymVar SYT.Int "n" [])

-- i <= n-1
example28_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Le
         (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1))

--------------------

-- (i+1>n) && (j>0)
example29 = SBin
  (SBin (SBin (SymVar SYT.Int "i" []) Add (SymInt 1)) Gt (SymVar SYT.Int "n" []))
  And
  (SBin (SymVar SYT.Int "j" []) Gt (SymInt 0))

-- (i>n-1) && (j>0)
example29_correct = Right
  $ SBin (SBin (SymVar SYT.Int "i" []) Gt (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1)))
         And
         (SBin (SymVar SYT.Int "j" []) Gt (SymInt 0))

--------------------

-- (j>0) || (n<i+1)
example30 = SBin
  (SBin (SymVar SYT.Int "j" []) Gt (SymInt 0))
  Or
  (SBin (SymVar SYT.Int "n" [])
        Lt
        (SBin (SymVar SYT.Int "i" []) Add (SymInt 1)))

-- (j>0) || (i>n-1)
example30_correct = Right
  $ SBin (SBin (SymVar SYT.Int "j" []) Gt (SymInt 0))
         Or
         (SBin (SymVar SYT.Int "i" [])
               Gt
               (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1)))

--------------------

-- (i+1>n) && (i-1<m)
example31 = SBin
  (SBin (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))
        Gt
        (SymVar SYT.Int "n" []))
  And
  (SBin (SBin (SymVar SYT.Int "i" []) Sub (SymInt 1)) Lt (SymVar SYT.Int "m" []))

-- (i>n-1) && (i<m+1)
example31_correct = Right
  $ SBin (SBin (SymVar SYT.Int "i" [])
               Gt
               (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1)))
         And
         (SBin (SymVar SYT.Int "i" []) Lt (SBin (SymVar SYT.Int "m" []) Add (SymInt 1)))

--------------------

-- not ((i+1>n) && (j>0))
example32 = SNot $ SBin
  (SBin (SBin (SymVar SYT.Int "i" []) Add (SymInt 1)) Gt (SymVar SYT.Int "n" []))
  And
  (SBin (SymVar SYT.Int "j" []) Gt (SymInt 0))

-- (i <= n - 1) || (j <= 0)
example32_correct = Right
  $ SBin (SBin (SymVar SYT.Int "i" []) Le (SBin (SymVar SYT.Int "n" []) Sub (SymInt 1)))
         Or
         (SBin (SymVar SYT.Int "j" []) Le (SymInt 0))

--------------------

-- 2*i+j > i+1
example33 = SBin
  (SBin (SBin (SymInt 2) Mul (SymVar SYT.Int "i" [])) Add (SymVar SYT.Int "j" []))
  Gt
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))

-- i > 1-j
example33_correct = Right
  $ SBin (SymVar SYT.Int "i" [])
         Gt
         (SBin (SymInt 1) Sub (SymVar SYT.Int "j" []))

--------------------

-- i+j > i+1
example34 = SBin
  (SBin (SymVar SYT.Int "i" []) Add (SymVar SYT.Int "j" []))
  Gt
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))

-- 0 > 1-j
example34_correct = Right
  $ SBin (SymInt 0)
         Gt
         (SBin (SymInt 1) Sub (SymVar SYT.Int "j" []))
--------------------

-- i-j > i+1
example35 = SBin
  (SBin (SymVar SYT.Int "i" []) Sub (SymVar SYT.Int "j" []))
  Gt
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))

-- 0 > 1+j
example35_correct = Right
  $ SBin (SymInt 0) Gt (SBin (SymInt 1) Add (SymVar SYT.Int "j" []))

--------------------

-- j-i > i+1
example36 = SBin
  (SBin (SymVar SYT.Int "j" []) Sub (SymVar SYT.Int "i" []))
  Gt
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))

-- -2i > 1-j
example36_correct = Right
  $ SBin (SBin (SymInt (-2)) Mul (SymVar SYT.Int "i" []))
         Gt
         (SBin (SymInt 1) Sub (SymVar SYT.Int "j" []))

--------------------

-- i+1 > i+j
example37 = SBin
  (SBin (SymVar SYT.Int "i" []) Add (SymInt 1))
  Gt
  (SBin (SymVar SYT.Int "i" []) Add (SymVar SYT.Int "j" []))

-- 0 > j-1
example37_correct = Right
  $ SBin (SymInt 0) Gt (SBin (SymVar SYT.Int "j" []) Sub (SymInt 1))

--------------------

-- 2*i+j <= i+n
example38 = SBin
  (SBin (SBin (SymInt 2) Mul (SymVar SYT.Int "i" [])) Add (SymVar SYT.Int "j" []))
  Le
  (SBin (SymVar SYT.Int "i" []) Add (SymVar SYT.Int "n" []))

-- i <= n-j
example38_correct = Right
  $ SBin (SymVar SYT.Int "i" []) Le (SBin (SymVar SYT.Int "n" []) Sub (SymVar SYT.Int "j" []))

--------------------

-- 2*i-j <= i+n
example39 = SBin
  (SBin (SBin (SymInt 2) Mul (SymVar SYT.Int "i" [])) Sub (SymVar SYT.Int "j" []))
  Le
  (SBin (SymVar SYT.Int "i" []) Add (SymVar SYT.Int "n" []))

-- i <= n+j
example39_correct = Right
  $ SBin (SymVar SYT.Int "i" []) Le (SBin (SymVar SYT.Int "n" []) Add (SymVar SYT.Int "j" []))

--------------------

-- i-3 >= i+n
example40 = SBin
  (SBin (SymVar SYT.Int "i" []) Sub (SymInt 3))
  Ge
  (SBin (SymVar SYT.Int "i" []) Add (SymVar SYT.Int "n" []))

-- 0 >= n+3
example40_correct = Right
  $ SBin (SymInt 0)
         Ge
         (SBin (SymVar SYT.Int "n" []) Add (SymInt 3))

--------------------

-- (i+j)-(i+1) > n
example41 = SBin
  (SBin (SBin (SymVar SYT.Int "i" []) Add (SymVar SYT.Int "j" []))
        Sub
        (SBin (SymVar SYT.Int "i" []) Add (SymInt 1)))
  Gt
  (SymVar SYT.Int "n" [])

-- j-1 > n
example41_correct = Left $ Eliminated
  $ SBin (SBin (SymVar SYT.Int "j" []) Sub (SymInt 1))
         Gt
         (SymVar SYT.Int "n" [])
