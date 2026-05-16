For `idByLoop`, the source loop is:

```java
int i = 0;
while (i < n) {
    i++;
}
return i;
```

This is the minimal monotone counter loop: one local counter `i`, stable upper bound `n`, no heap access, no accumulator, no early exit. The previous report classifies it as `WhileCountingUp` with `CounterBoundsTemplate`, `LoopFrameTemplate`, and `DecreasesTemplate`.  

## `LoopSummary`

```haskell
LoopSummary
  { loopId                  = "idByLoop#while0"

  , loopKind                = WhileCountingUp

  , loopInitFacts           =
      [ "i == 0" ]

  , loopGuard               =
      "i < n"

  , loopCounters            =
      [ ("i", "i") ]

  , loopCounterBounds       =
      [ ("i", "0", "n") ]

  , loopCounterDirection    =
      [ ("i", Increasing) ]

  , loopCounterStride       =
      [ ("i", "1") ]

  , loopBoundStabilityFacts =
      [ "n is read-only during the loop" ]

  , loopAssignments         =
      [ "i" ]

  , loopFieldAssignments    =
      []

  , loopArrayAccesses       =
      []

  , loopReadOnlyVars        =
      [ "n" ]

  , loopAccumulators        =
      []

  , loopSegments            =
      []

  , loopEarlyExits          =
      []

  , loopHelperCalls         =
      []

  , loopNeedsOldState       = False

  , loopNeedsSortedness     = False

  , loopNeedsNonEmptyArray  = False

  , loopNeedsNoOverflow     = False

  , loopFrameTargets        =
      [ "i" ]

  , loopDecreasesCandidate  =
      Just "n - i"

  , loopTemplateHints       =
      [ CounterBoundsTemplate
          { counter = "i"
          , lower   = "0"
          , upper   = "n"
          }

      , LoopFrameTemplate
          { frameTargets = [ "i" ]
          }

      , DecreasesTemplate
          { variant = "n - i" }
      ]

  , loopValidationNotes     =
      [ "To prove result == n, require 0 <= n."
      , "Initialization: i == 0, so 0 <= i && i <= n follows from 0 <= n."
      , "Preservation: assuming 0 <= i && i <= n and i < n, after i++ we still have 0 <= i && i <= n."
      , "Exit: 0 <= i && i <= n and !(i < n) imply i == n."
      , "Frame: only local variable i is modified."
      , "Termination: n - i is non-negative at loop head and decreases by 1 each iteration."
      , "Without requires 0 <= n, the method returns 0 for n < 0, not n."
      ]
  }
```

## `InvariantTemplate`

```haskell
[ CounterBoundsTemplate
    { counter = "i"
    , lower   = "0"
    , upper   = "n"
    }

, LoopFrameTemplate
    { frameTargets = [ "i" ]
    }

, DecreasesTemplate
    { variant = "n - i" }
]
```

Instantiated JML clauses:

```java
//@ maintaining 0 <= i && i <= n;
//@ loop_assigns i;
//@ decreases n - i;
```

Method-level precondition needed for the intended postcondition `\result == n`:

```java
//@ requires 0 <= n;
```

