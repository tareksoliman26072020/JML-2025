module Internal.LoopInvariants where

import CFG.Types (ScopeRange(..), Node_Coor(..))
import JML.Types (
  Expr(..), Op(..), JMLType(..), DefinedFun(..), Quantifier(..),
  LoopInvariantTemplate(..),
  Maintaining_LoopInvariantTemplate(..),
  LoopAssigns_LoopInvariantTemplate(..))

allTargets :: [(String,[[LoopInvariantTemplate]])]
allTargets = [
  ("idByLoop", idByLoop),
  ("idByLoopStride3", idByLoopStride3),
  ("idByLoop2",idByLoop2),
  ("halving", halving),
  ("contains", contains)
  ]

-----------------------------
-----------------------------
-----------------------------

idByLoop :: [[LoopInvariantTemplate]]
idByLoop = [
    [Maintaining $ CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n"),
     LoopAssigns $ LoopFrameTemplate ["i"],
     DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))]
  ]

-----------------------------
-----------------------------
-----------------------------

idByLoopStride3 :: [[LoopInvariantTemplate]]
idByLoopStride3 = [
    [Maintaining $ CounterBoundsTemplate (JMLInt 0) "i" (JMLBin (JMLVar Int_Type "n") Add (JMLInt 2)),
     Maintaining $ StridedCounterTemplate "i" (JMLInt 3) (JMLInt 0),
     LoopAssigns $ LoopFrameTemplate ["i"],
     DecreasesTemplate $ JMLBin (JMLBin (JMLVar Int_Type "n") Add (JMLInt 2)) Sub (JMLVar Int_Type "i")]
  ]

-----------------------------
-----------------------------
-----------------------------

idByLoop2 :: [[LoopInvariantTemplate]]
idByLoop2 = [
    [Maintaining $ CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n"),
     LoopAssigns $ LoopFrameTemplate ["i"],
     DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))]
  ]

-----------------------------
-----------------------------
-----------------------------

halving :: [[LoopInvariantTemplate]]
halving = [
    [Maintaining (CounterBoundsTemplate (JMLInt 0) "i" (JMLVar Int_Type "n")),
     Maintaining (CounterBoundsTemplate (JMLVar Int_Type "i") "n" (JMLOld (JMLVar Int_Type "n"))),
     LoopAssigns (LoopFrameTemplate ["n","i"]),
     DecreasesTemplate (JMLBin (JMLVar Int_Type "n") Sub (JMLVar Int_Type "i"))]
  ]

-----------------------------
-----------------------------
-----------------------------

contains :: [[LoopInvariantTemplate]]
contains = [
     [Maintaining $ CounterBoundsTemplate (JMLInt 0) "i" (JMLObjAcc ["a","length"]),
      Maintaining $ SearchExclusionTemplate
          (Universal,
           [("k1",(JMLInt 0,(Int_Type,"i",JMLInt 0,(JMLInt 1,True)),JMLObjAcc ["a","length"]))],
           (Node_Coor {varDeclAt = 3, varFrame = SR {branchStart = 3, branchEnd = 5}},
            JMLBin (JMLArrayIndexAccess (Array_Type Int_Type) "a" (JMLVar Int_Type "k1"))
                   Neq
                   (JMLVar Int_Type "x")))
          (Node_Coor {varDeclAt = 4, varFrame = SR {branchStart = 3, branchEnd = 5}},
           Just (JMLBool True)),
      LoopAssigns $ LoopFrameTemplate ["i"],
      DecreasesTemplate $ JMLBin (JMLObjAcc ["a","length"]) Sub (JMLVar Int_Type "i")]
  ]
