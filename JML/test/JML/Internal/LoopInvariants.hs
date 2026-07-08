module Internal.LoopInvariants where

import CFG.Types (ScopeRange(..))
import JML.Types (
  Expr(..), Op(..), JMLType(..), DefinedFun(..),
  LoopInvariantTemplate(..))

allTargets :: [(String,[[LoopInvariantTemplate]])]
allTargets = [
  ("idByLoop", idByLoop)
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
