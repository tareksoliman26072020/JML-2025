21.June.2026 (working on InvariantTemplate for idByLoop after finishing LoopSummary, LoopPattern, LoopSummaryTag, inferLoopPatterns, createLoopSummary)

---

I'm writing this prompt many days after the last one in this chat, therefore I seem to somehow have „forgotten“ what we worked on together. I scrolled up and tried to see what we spoke about, and also I saw what I ended up implementing. So before I come to ask my questions, I'll write first the premise the current state, and what was achieved. Then I'll ask the question(s). In The end I'll offer more starter informations in (Premises).

---

# current goal

inferring loop invariants and all JML annotations in the method `idByLoop`

```java
public static int idByLoop(int n) {

int i = 0;

while (i < n) {

i++;

}

return i;

}
```

---

# current state

## LoopSummary, LoopPattern, LoopSummaryTag

I have 3 data types (LoopSummary, LoopPattern, LoopSummaryTag) with which my modul of thought is being represented as the following:

```haskell
data LoopSummary = LoopSummary {
   loopSyntax :: LoopSyntax
  , loopInitFacts :: [(String,SymExpr)]
  , loopGuards :: [SymExpr]
  , loopCounters :: [String]
  , loopCountersBounds :: [(SymExpr,String,SymExpr)]
  , loopCountersDevelopmentTrajectory :: [(String,SymExprDevelopmentTrajectory)]
  , loopBoundStabilityFacts :: [(SymExpr,SymExprDevelopmentTrajectory)]
  , loopAssignments :: [String]
  , loopReadOnlyVars :: [String]
  , loopFrameTargets :: [String]
  , loopDecreasesCandidate :: [SymExpr]
}
```

```haskell
data SymExprDevelopmentTrajectory =
    Increasing SymExpr
  | Decreasing SymExpr
  | Mixed SymExpr
  | ReadOnly
```

```haskell
data BoundPosition = LeftBound | RightBound
```

```haskell
data LoopSyntax
  = WhileSyntax
  | ForSyntax
```

```haskell
data LoopPattern
  = CounterPattern CounterPattern
  | BoundPattern BoundPattern
  | TraversalPattern TraversalPattern
  | MutationPattern MutationPattern
  | AccumulatorPattern AccumulatorPattern
  | SearchPattern SearchPattern
  | ControlFlowPattern ControlFlowPattern
  | HelperCallPattern
  | TwoFrontierPattern
  | UnknownPattern
```

```haskell
data CounterPattern
  = CountingUp
  | CountingDown
  | StridedCounting
  | ConditionalCounterMovement

data BoundPattern
  = StableBound
  | MovingBound
  | GuardlessWithInternalExit

data TraversalPattern
  = ArrayScan
  | PrefixProperty
  | SourceUnchanged

data MutationPattern
  = ArrayFill
  | ArrayCopy
  | InPlaceTransform
  | ConditionalArrayRewrite
  | SymmetricSwap

data AccumulatorPattern
  = AdditiveAccumulator
  | ArithmeticSeriesAccumulator
  | MaxAccumulator
  | FieldLinearAccumulator

data SearchPattern
  = LinearSearch
  | FirstIndexSearch
  | BooleanPredicateScan
  | BinarySearch

data ControlFlowPattern
  = EarlyReturn
  | BreakExit
  | ContinuePath
  | ThrowExit
```

```haskell
data LoopSummaryTag =
   LoopInitFacts
 | LoopGuards
 | LoopCounters
 | LoopCountersBounds
 | LoopCountersDevelopmentTrajectory
 | LoopBoundStabilityFacts
 | LoopAssignments
 | LoopReadOnlyVars
 | LoopFrameTargets
 | LoopDecreasesCandidate
```

`LoopSummary` is the summary of relevant informations mentioned in the loop.

`LoopPattern` is an evaluation of `LoopSummary`, in which patterns are detected. So in other words, `LoopPattern` is an „intermediate representation“ between `LoopSummary` and the to-be-inferred invariants templates.

`LoopSummaryTag` are values which count as explanation to why the values LoopPatterns are the way they are, in other words they refer to functions in `LoopSummary` in order for the function(s) which will infer the invariants templates to lookup the relevant functions in `LoopSummary`.

---

# output (what was achieved so far)

`LoopSummary` for `idByLoop` gives:

```haskell
  loopInitFacts                     = [("i",SymInt 0)]
  loopGuards                        = [SBin (SymVar Int "i") Lt (SymVar Int "n")]
  loopCounters                      = ["i"]
  loopCountersDevelopmentTrajectory = [("i",Increasing (SymInt 1))]
  loopCounterStride: DONE via loopCountersDevelopmentTrajectory
  loopCountersBounds                = [(SymInt 0,"i",SymVar Int "n")]
  loopBoundStabilityFacts           = [(SymVar Int "n",ReadOnly)]
  theLoopAssignments                = ["i"]
  theLoopReadOnlyVars               = ["n"]
  theLoopFrameTargets               = ["i"]
  theLoopDecreasesCandidate         = [SBin (SymVar Int "n") Sub (SymVar Int "i")]
```

I have implemented the following function:

```haskell
inferLoopPatterns :: LoopSummary -> [(LoopPattern,[LoopSummaryTag])]
```

`inferLoopPatterns` returns for `idByLoop` the following:

```haskell
[
 (CounterPattern CountingUp,
 [LoopCounters
 ,LoopCountersDevelopmentTrajectory
 ,LoopInitFacts
 ,LoopGuards
 ,LoopCountersBounds
 ,LoopAssignments
 ,LoopDecreasesCandidate
 ]),
 (BoundPattern StableBound,
 [LoopCounters
 ,LoopCountersBounds
 ,LoopGuards
 ,LoopBoundStabilityFacts
 ,LoopReadOnlyVars
 ])]
```

and this output is supposed to help me infer the invariant Templates which will, according to an earlier reply from you, returns:

```java
//@ maintaining 0 <= i && i <= n;
//@ loop_assigns i;
//@ decreases n - i;
```

---

# My question (your task to do)

1) give me an initial implementation which will give me the templates for this method `idByLoop`. The name of the main function should be `inferInvariantTemplates`. It takes as input `LoopSummary` and `[(LoopPattern,[LoopSummaryTag])]`, and it will return `[InvariantTemplate]`

2) The output should be the haskell representation of:
   
   ```java
   //@ maintaining 0 <= i && i <= n;
   //@ loop_assigns i;
   //@ decreases n - i;
   ```

---

# Premises:

if you look in the file `idByLoop.md`, by its end you'll see:

- ```haskell
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

and this output can be seen in the JML annotations which you gave me earlier as well:

```java
/*@ normal_behavior
  @   requires 0 <= n;
  @   assignable \nothing;
  @   ensures \result == n;
  @*/
public static int idByLoop(int n) {
    int i = 0;
    //@ maintaining 0 <= i && i <= n;
    //@ loop_assigns i;
    //@ decreases n - i;
    while (i < n) {
        i++;
    }
    return i;
}
```

In the file `loop_invariant_missions_report_to_be_tested_3.md` which was your output from the past, you gave me the following data type:

```haskell
data InvariantTemplate
  = CounterBoundsTemplate
      { counter :: String, lower :: Expr, upper :: Expr }
  | StridedCounterTemplate
      { counter :: String, lower :: Expr, upper :: Expr, stride :: Expr, congruence :: Expr }
  | TwoFrontierBoundsTemplate
      { lo :: String, hi :: String, relation :: Expr }
  | PrefixPropertyTemplate
      { counter :: String, predicate :: Expr }
  | SearchExclusionTemplate
      { counter :: String, predicate :: Expr }
  | BooleanPrefixPropertyTemplate
      { counter :: String, predicate :: Expr }
  | ArraySumAccumulatorTemplate
      { acc :: String, array :: String, counter :: String, summand :: Expr, guard :: Maybe Expr }
  | ArithmeticSeriesAccumulatorTemplate
      { acc :: String, counter :: String, closedForm :: Expr }
  | MaxScanTemplate
      { acc :: String, array :: String, counter :: String }
  | FieldLinearAccumulatorTemplate
      { field :: String, counter :: String, oldBase :: Expr }
  | ArrayFillTemplate
      { array :: String, counter :: String, value :: Expr }
  | ArrayCopyPrefixTemplate
      { src :: String, dst :: String, counter :: String, srcIndex :: Expr, dstIndex :: Expr }
  | InPlaceTransformPrefixSuffixTemplate
      { array :: String, counter :: String, transform :: Expr }
  | ConditionalArrayRewriteTemplate
      { array :: String, counter :: String, cases :: [(Expr, Expr)] }
  | UnprocessedSuffixUnchangedTemplate
      { array :: String, counter :: String }
  | SourceUnchangedTemplate
      { array :: String }
  | TwoFrontierReverseTemplate
      { array :: String, lo :: String, hi :: String }
  | BinarySearchExclusionTemplate
      { array :: String, lo :: String, hi :: String, target :: Expr }
  | EarlyReturnTemplate
      { condition :: Expr, result :: Expr }
  | BreakExitTemplate
      { condition :: Expr }
  | ContinuePathTemplate
      { condition :: Expr, preservedFacts :: [Expr] }
  | ExceptionExitTemplate
      { exceptionType :: String, condition :: Expr }
  | HelperCallLiftTemplate
      { callee :: String, liftedFacts :: [Expr] }
  | LoopFrameTemplate
      { frameTargets :: [String] }
  | DecreasesTemplate
      { variant :: Expr }
  deriving (Eq, Show)
```

but for the sake of `idByLoop`, I think it's enough to concentrate on the three values: CounterBoundsTemplate, LoopFrameTemplate, DecreasesTemplate:

```haskell
data InvariantTemplate =
   CounterBoundsTemplate ???
 | LoopFrameTemplate ???
 | DecreasesTemplate ???
```

You see the question marks to denote the fact that the detailed data type `InvariantTemple` can be edited by need and demand.

Your output will of course not be pretty-printed. It will be `[InvariantTemplate]`.

---

# Decisive tags and patterns:

There are three kinds of tags:

1) Tags to **generate** that invariant expression

2) Tags to **justify recognizing the pattern**

3) Tags to **validate** the invariant.

Here is the exact mapping for `idByLoop`.

```haskell
[
 (CounterPattern CountingUp,
 [LoopCounters
 ,LoopCountersDevelopmentTrajectory
 ,LoopInitFacts
 ,LoopGuards
 ,LoopCountersBounds
 ,LoopAssignments
 ,LoopFrameTargets
 ,LoopDecreasesCandidate
 ]),
 (BoundPattern StableBound,
 [LoopCounters
 ,LoopCountersBounds
 ,LoopGuards
 ,LoopBoundStabilityFacts
 ,LoopReadOnlyVars
 ])]
```

produces:

```haskell
[ CounterBoundsTemplate
    { counter = "i"
    , lower   = SymInt 0
    , upper   = SymVar Int "n"
    }

, LoopFrameTemplate
    { frameTargets = ["i"]
    }

, DecreasesTemplate
    { variant = SBin (SymVar Int "n") Sub (SymVar Int "i")
    }
]
```

which corresponds to:

```java
//@ maintaining 0 <= i && i <= n;
//@ loop_assigns i;
//@ decreases n - i;
```

---

# 1. `CounterBoundsTemplate`

Template:

```haskell
CounterBoundsTemplate
  { counter :: String
  , lower   :: SYT.SymbolicExecutionValue
  , upper   :: SYT.SymbolicExecutionValue
  }
```

For `idByLoop`:

```haskell
CounterBoundsTemplate
  { counter = "i"
  , lower   = SymInt 0
  , upper   = SymVar Int "n"
  }
```

This template is justified by the combination of:

```haskell
CounterPattern CountingUp
BoundPattern StableBound
```

The decisive tags are:

```haskell
CounterPattern CountingUp:
  LoopCounters
  LoopCountersDevelopmentTrajectory
  LoopCountersBounds

BoundPattern StableBound:
  LoopCountersBounds
  LoopGuards
  LoopBoundStabilityFacts
  LoopReadOnlyVars
```

The concrete values come from `LoopSummary`:

```haskell
loopCounters =
  ["i"]

loopCountersDevelopmentTrajectory =
  [("i", Increasing (SymInt 1))]

loopCountersBounds =
  [(SymInt 0, "i", SymVar Int "n")]

loopGuards =
  [SBin (SymVar Int "i") Lt (SymVar Int "n")]

loopBoundStabilityFacts =
  [(SymVar Int "n", ReadOnly)]

loopReadOnlyVars =
  ["n"]
```

Meaning:

```text
i is a counter.
i increases by 1.
i has lower bound 0.
i has upper bound n.
The guard is i < n.
n is read-only/stable.
```

So the generated invariant is:

```java
//@ maintaining 0 <= i && i <= n;
```

The supporting, but not direct constructor-value, tags are:

```haskell
LoopInitFacts
LoopGuards
```

`LoopInitFacts` helps validate that the invariant holds before the loop:

```haskell
loopInitFacts = [("i", SymInt 0)]
```

`LoopGuards` helps validate preservation and exit reasoning:

```haskell
loopGuards = [SBin (SymVar Int "i") Lt (SymVar Int "n")]
```

---

# 2. `LoopFrameTemplate`

Template:

```haskell
LoopFrameTemplate
  { frameTargets :: [String]
  }
```

For `idByLoop`:

```haskell
LoopFrameTemplate
  { frameTargets = ["i"]
  }
```

This template is justified mainly by:

```haskell
CounterPattern CountingUp
```

with the tag:

```haskell
LoopFrameTargets
```

The concrete value comes from:

```haskell
loopFrameTargets =
  ["i"]
```

The related supporting tags are:

```haskell
LoopAssignments
LoopCounters
```

because:

```haskell
loopAssignments =
  ["i"]

loopCounters =
  ["i"]
```

Meaning:

```text
The only loop-carried modified variable is i.
Therefore the loop frame is i.
```

So the generated clause is:

```java
//@ loop_assigns i;
```

In your design, attaching `LoopFrameTargets` to `CounterPattern CountingUp` is reasonable because the modified frame target is the counter itself.

---

# 3. `DecreasesTemplate`

Template:

```haskell
DecreasesTemplate
  { variant :: SYT.SymbolicExecutionValue
  }
```

For `idByLoop`:

```haskell
DecreasesTemplate
  { variant = SBin (SymVar Int "n") Sub (SymVar Int "i")
  }
```

This template is justified by:

```haskell
CounterPattern CountingUp
BoundPattern StableBound
```

The decisive tags are:

```haskell
CounterPattern CountingUp:
  LoopCounters
  LoopCountersDevelopmentTrajectory
  LoopDecreasesCandidate

BoundPattern StableBound:
  LoopCountersBounds
  LoopBoundStabilityFacts
  LoopReadOnlyVars
```

The concrete value comes from:

```haskell
loopDecreasesCandidate =
  [SBin (SymVar Int "n") Sub (SymVar Int "i")]
```

The supporting facts are:

```haskell
loopCounters =
  ["i"]

loopCountersDevelopmentTrajectory =
  [("i", Increasing (SymInt 1))]

loopCountersBounds =
  [(SymInt 0, "i", SymVar Int "n")]

loopBoundStabilityFacts =
  [(SymVar Int "n", ReadOnly)]
```

Meaning:

```text
i increases by 1.
n is the stable upper bound.
Therefore n - i decreases by 1 each iteration.
```

So the generated clause is:

```java
//@ decreases n - i;
```

---

# Compact mapping

```haskell
CounterBoundsTemplate
  <- CounterPattern CountingUp
       [ LoopCounters
       , LoopCountersDevelopmentTrajectory
       , LoopCountersBounds
       ]
  <- BoundPattern StableBound
       [ LoopCountersBounds
       , LoopGuards
       , LoopBoundStabilityFacts
       , LoopReadOnlyVars
       ]

LoopFrameTemplate
  <- CounterPattern CountingUp
       [ LoopAssignments
       , LoopFrameTargets
       ]

DecreasesTemplate
  <- CounterPattern CountingUp
       [ LoopCounters
       , LoopCountersDevelopmentTrajectory
       , LoopDecreasesCandidate
       ]
  <- BoundPattern StableBound
       [ LoopCountersBounds
       , LoopBoundStabilityFacts
       , LoopReadOnlyVars
       ]
```

---

# Final template result for `idByLoop`

```haskell
[ CounterBoundsTemplate
    { counter = "i"
    , lower   = SymInt 0
    , upper   = SymVar Int "n"
    }

, LoopFrameTemplate
    { frameTargets = ["i"]
    }

, DecreasesTemplate
    { variant = SBin (SymVar Int "n") Sub (SymVar Int "i")
    }
]
```

Important boundary: these are **loop templates only**. The method-level precondition:

```java
//@ requires 0 <= n;
```

is needed to prove the intended method postcondition:

```java
//@ ensures \result == n;
```

but it is not itself one of these loop invariant templates.

---
