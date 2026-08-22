module Internal.LoopInvariants where

import CFG.Types (ScopeRange(..))
import JML.Types (
  Expr(..), Op(..), JMLType(..), DefinedFun(..),
  LoopInvariantTemplate(..))

allTargets :: [(String,[[LoopInvariantTemplate]])]
allTargets = [
  ("idByLoop", idByLoop),
  ("idByLoopStride3", idByLoopStride3),
  ("idByLoop2",idByLoop2)
  ]

-----------------------------
-----------------------------
-----------------------------

idByLoop :: [[LoopInvariantTemplate]]
idByLoop = [
    [CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n"),
     LoopFrameTemplate ["i"],
     DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))
    ]
  ]

-----------------------------
-----------------------------
-----------------------------

idByLoopStride3 :: [[LoopInvariantTemplate]]
idByLoopStride3 = [
    [CounterBoundsTemplate (JMLInt 0) "i" (JMLBin (JMLVar Int_Type "n") Add (JMLInt 2)),
     StridedCounterTemplate "i" (JMLInt 3) (JMLInt 0),
     LoopFrameTemplate ["i"],
     DecreasesTemplate $ JMLBin (JMLBin (JMLVar Int_Type "n") Add (JMLInt 2)) Sub (JMLVar Int_Type "i")
    ]
  ]

-----------------------------
-----------------------------
-----------------------------

idByLoop2 :: [[LoopInvariantTemplate]]
idByLoop2 = [
    [CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n"),
     LoopFrameTemplate ["i"],
     DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))
    ]
  ]
