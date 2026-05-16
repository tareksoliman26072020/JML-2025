`LoopSummary` is the **normalized dataflow summary of one loop**. It is not itself a JML invariant. Its purpose is to collect enough facts so your next phase can choose `InvariantTemplate`s and then validate the generated JML clauses. The report explicitly says this structure is “richer than a bare symbolic state” because it records the facts the template matcher needs before emitting invariant schemas. 

## Big picture

For each loop, `LoopSummary` answers questions like:

1. What kind of loop is this?
2. What variables move?
3. What heap locations are read or written?
4. What semantic pattern exists: scan, fill, copy, sum, max, search, reverse, etc.?
5. What templates should be tried?
6. What validation obligations remain?

This matters because template inference is mechanical: if the summary says “monotonic counter + stable upper bound,” you can emit `CounterBoundsTemplate` and `DecreasesTemplate`; if it says “array write `a[i] = value`,” you can emit an array-fill template; if it says “helper call,” you need callee specs first. 

---

# Top-level `LoopSummary` fields

```haskell
data LoopSummary expr = LoopSummary
  { loopId                  :: String
  , loopKind                :: LoopKind
  , loopInitFacts           :: [expr]
  , loopGuard               :: expr
  , loopCounters            :: [(String, expr)]
  , loopCounterBounds       :: [(String, expr, expr)]
  , loopCounterDirection    :: [(String, CounterDirection)]
  , loopCounterStride       :: [(String, expr)]
  , loopBoundStabilityFacts :: [expr]
  , loopAssignments         :: [String]
  , loopFieldAssignments    :: [String]
  , loopArrayAccesses       :: [ArrayAccessSummary expr]
  , loopReadOnlyVars        :: [String]
  , loopAccumulators        :: [AccumulatorSummary expr]
  , loopSegments            :: [SegmentSummary expr]
  , loopEarlyExits          :: [EarlyExitSummary expr]
  , loopHelperCalls         :: [HelperCallSummary expr]
  , loopNeedsOldState       :: Bool
  , loopNeedsSortedness     :: Bool
  , loopNeedsNonEmptyArray  :: Bool
  , loopNeedsNoOverflow     :: Bool
  , loopFrameTargets        :: [String]
  , loopDecreasesCandidate  :: Maybe expr
  , loopTemplateHints       :: [InvariantTemplate]
  , loopValidationNotes     :: [String]
  }
```

## `loopId :: String`

A unique identifier for this loop.

Purpose: lets you distinguish multiple loops inside the same method.

Example:

```haskell
loopId = "idByLoop#while0"
```

This becomes important for methods with two or more loops, because each loop needs its own summary, templates, invariants, frame, and termination measure.

---

## `loopKind :: LoopKind`

Classifies the loop shape at a high level.

Examples:

```haskell
WhileCountingUp
WhileArrayScan
WhileAccumulator
WhileArrayMutation
WhileTwoFrontier
WhileBinarySearch
WhileHelperCall
WhileException
WhileStrided
ForCountingUp
UnknownLoop
```

Purpose: this is the first dispatch key for templates.

For `idByLoop`, the loop is:

```haskell
loopKind = WhileCountingUp
```

So the tool should primarily try counter-bound and termination templates, not array, search, or accumulator templates. The report classifies `idByLoop` exactly this way. 

---

## `loopInitFacts :: [expr]`

Facts known immediately before the loop starts.

Purpose: needed for the **initialization VC**: proving that the candidate invariant holds before the first iteration.

For `idByLoop`:

```haskell
loopInitFacts = [ "i == 0" ]
```

This supports:

```java
//@ maintaining 0 <= i && i <= n;
```

because if `i == 0` and the method precondition says `0 <= n`, then initially `0 <= i && i <= n`.

The report explicitly says initialization facts are needed for the initialization VC. 

---

## `loopGuard :: expr`

The loop condition.

For `idByLoop`:

```haskell
loopGuard = "i < n"
```

Purpose: used for three things:

1. **Safety inside the body**: under the guard, array indexes are often valid.
2. **Preservation**: symbolic execution assumes `invariant && guard`.
3. **Exit reasoning**: after the loop, you know `invariant && !guard`.

For `idByLoop`, exit reasoning is:

```text
0 <= i && i <= n
!(i < n)
```

Therefore:

```text
i == n
```

That proves `return i` gives `n`.

---

## `loopCounters :: [(String, expr)]`

The variables that function as loop counters or induction variables.

For `idByLoop`:

```haskell
loopCounters = [ ("i", "i") ]
```

Purpose: identifies which variable the template should put into the invariant.

For example, if the counter is `i`, then the counter-bound template emits:

```java
//@ maintaining 0 <= i && i <= n;
```

Not:

```java
//@ maintaining 0 <= s && s <= n;
```

For two-frontier loops like `reverse`, this would contain both `lo` and `hi`.

---

## `loopCounterBounds :: [(String, expr, expr)]`

Lower and upper bounds for each counter.

For `idByLoop`:

```haskell
loopCounterBounds = [ ("i", "0", "n") ]
```

Purpose: feeds the counter-bounds invariant.

It says the candidate invariant should be:

```java
//@ maintaining 0 <= i && i <= n;
```

For an array traversal, it might be:

```haskell
("i", "0", "a.length")
```

which becomes:

```java
//@ maintaining 0 <= i && i <= a.length;
```

This field is not only documentation. It directly provides the holes for:

```haskell
CounterBoundsTemplate
  { counter = "i"
  , lower   = "0"
  , upper   = "n"
  }
```

---

## `loopCounterDirection :: [(String, CounterDirection)]`

Records whether a counter increases, decreases, moves conditionally, or is not really a counter.

Examples:

```haskell
[("i", Increasing)]
[("hi", Decreasing)]
[("lo", ConditionalMovement), ("hi", ConditionalMovement)]
```

Purpose: used to decide whether a simple termination measure exists.

For `idByLoop`:

```haskell
loopCounterDirection = [ ("i", Increasing) ]
```

Because `i` increases toward upper bound `n`, the natural variant is:

```java
//@ decreases n - i;
```

For `reverse`, `lo` increases and `hi` decreases. For `binarySearch`, `lo` and `hi` move conditionally.

---

## `loopCounterStride :: [(String, expr)]`

Records how much the counter changes per iteration.

For `idByLoop`:

```haskell
loopCounterStride = [ ("i", "1") ]
```

Purpose: needed for preservation and for detecting special strided loops.

For ordinary `i++`, stride is `1`.

For:

```java
i += 2;
```

stride is `2`, and a normal invariant like:

```java
//@ maintaining 0 <= i && i <= a.length;
```

may fail after the last iteration. That is why strided loops may need widened bounds like:

```java
//@ maintaining 0 <= i && i <= a.length + 1;
//@ maintaining i % 2 == 0;
```

The report explicitly identifies non-unit stride such as `i += 2` as a separate dataflow fact. 

---

## `loopBoundStabilityFacts :: [expr]`

This field records that the loop bound does **not change during the loop**.

For `idByLoop`:

```haskell
loopBoundStabilityFacts =
  [ "n is read-only during the loop" ]
```

Purpose: it justifies that expressions like `n - i` or `a.length - i` are valid termination measures and that prefix ranges such as `[0, i)` are meaningful against a fixed bound.

The report says this explicitly: loop-bound stability records facts like `a.length`, `src.length`, and `n` being read-only, and this stability justifies decreases expressions and prefix ranges. 

Why this is separate from `loopReadOnlyVars`:

```haskell
loopReadOnlyVars = [ "n" ]
```

says "`n` is not assigned."

But:

```haskell
loopBoundStabilityFacts = [ "n is stable as the upper bound of i" ]
```

says "`n` is specifically the bound used in `i < n`, `i <= n`, and `n - i`."

So `loopBoundStabilityFacts` is more semantic.

Example where it matters:

```java
while (i < n) {
    n--;
    i++;
}
```

Here `n` is not stable. You should **not** blindly emit:

```java
//@ maintaining 0 <= i && i <= n;
//@ decreases n - i;
```

because `n - i` changes from both sides and may not behave like the simple counting-up pattern.

For arrays, Java array length itself is immutable, but the array reference can be reassigned:

```java
while (i < a.length) {
    a = new int[0];
    i++;
}
```

Then `a.length` is not stable as the loop bound because `a` changes.

---

## `loopAssignments :: [String]`

Local variables assigned inside the loop.

For `idByLoop`:

```haskell
loopAssignments = [ "i" ]
```

Purpose: used to generate `loop_assigns` and to know what must be havoced/updated during preservation checking.

For `idByLoop`, this gives:

```java
//@ loop_assigns i;
```

For `sum`, it would be:

```haskell
loopAssignments = [ "i", "s" ]
```

and the loop frame becomes:

```java
//@ loop_assigns i, s;
```

---

## `loopFieldAssignments :: [String]`

Object fields assigned inside the loop.

For `idByLoop`:

```haskell
loopFieldAssignments = []
```

Purpose: distinguishes local updates from heap/object-field updates.

Example from `addN`:

```java
x++;
```

There, the loop modifies field `x`, so:

```haskell
loopFieldAssignments = [ "x" ]
```

and the loop frame needs:

```java
//@ loop_assigns i, x;
```

This field matters because field assignments also affect the **method-level** frame:

```java
//@ assignable x;
```

Local variable assignments do not appear in method-level `assignable`, but field and array mutations do.

---

## `loopArrayAccesses :: [ArrayAccessSummary expr]`

Records array reads, writes, and read-writes.

For `idByLoop`:

```haskell
loopArrayAccesses = []
```

Purpose: used for safety, frame, and semantic templates.

Examples:

```java
a[i]
```

as a read gives an array access summary like:

```haskell
ArrayAccessSummary
  { arrayName = "a"
  , arrayIndex = "i"
  , accessKind = ArrayRead
  , writtenValue = Nothing
  }
```

For:

```java
a[i] = 0;
```

you get:

```haskell
ArrayAccessSummary
  { arrayName = "a"
  , arrayIndex = "i"
  , accessKind = ArrayWrite
  , writtenValue = Just "0"
  }
```

For:

```java
a[i] = a[i] + 1;
```

you get:

```haskell
accessKind = ArrayReadWrite
```

This field tells the tool whether to emit templates like `ArrayFillTemplate`, `ArrayCopyPrefixTemplate`, or `InPlaceTransformPrefixSuffixTemplate`.

The report’s lightweight-dataflow questions explicitly separate array reads and writes because they drive safety and mutation reasoning. 

---

## `loopReadOnlyVars :: [String]`

Variables or heap locations read but not assigned in the loop.

For `idByLoop`:

```haskell
loopReadOnlyVars = [ "n" ]
```

Purpose: helps infer frame and unchanged facts.

Example:

```java
dst[i] = src[i];
```

In `copy`, `src` is read-only and `dst` is written. That supports an invariant/postcondition like:

```java
//@ maintaining (\forall int k; 0 <= k && k < src.length; src[k] == \old(src[k]));
```

The report says read-only variables/heap locations are used to produce frame and unchanged facts. 

---

## `loopAccumulators :: [AccumulatorSummary expr]`

Records variables that accumulate a value over iterations.

For `idByLoop`:

```haskell
loopAccumulators = []
```

Purpose: triggers accumulator templates.

Examples:

```java
s += a[i];
```

would produce an additive array accumulator:

```haskell
AccumulatorSummary
  { accName   = "s"
  , accKind   = AdditiveAccumulator
  , accInit   = "0"
  , accUpdate = "s + a[i]"
  , accGuard  = Nothing
  , accDomain = Just "0 <= k && k < i"
  }
```

That can emit:

```java
//@ maintaining s == (\sum int k; 0 <= k && k < i; a[k]);
```

For:

```java
if (a[i] >= 0) s += a[i];
```

the accumulator has a guard.

The report lists additive, arithmetic-series, max, and field-linear accumulators as separate accumulator kinds. 

---

## `loopSegments :: [SegmentSummary expr]`

Records processed and unprocessed regions.

For `idByLoop`:

```haskell
loopSegments = []
```

There is no array or search segment.

Purpose: necessary for quantified prefix/suffix invariants.

Examples:

For a fill loop:

```java
while (i < a.length) {
    a[i] = v;
    i++;
}
```

you get a processed prefix:

```text
[0, i) is filled with v
```

and an unprocessed suffix:

```text
[i, a.length) is unchanged
```

That turns into:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == v);
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
```

The report names the common segment shapes: prefix `[0, i)`, suffix `[i, length)`, two-frontier regions, and binary-search exclusion zones. 

---

## `loopEarlyExits :: [EarlyExitSummary expr]`

Records `return`, `break`, `continue`, and `throw` paths inside the loop.

For `idByLoop`:

```haskell
loopEarlyExits = []
```

Purpose: early exits require path-sensitive reasoning.

Examples:

```java
if (a[i] == x) return true;
```

summary:

```haskell
EarlyExitSummary
  { exitKind = ReturnExit
  , exitCondition = "a[i] == x"
  , exitEffect = Just "return true"
  }
```

For:

```java
if (a[i] % 2 == 0) break;
```

summary:

```haskell
EarlyExitSummary
  { exitKind = BreakExit
  , exitCondition = "a[i] % 2 == 0"
  , exitEffect = Nothing
  }
```

The report explicitly lists return, break, throw, and continue as early-exit forms and records their path conditions. 

---

## `loopHelperCalls :: [HelperCallSummary expr]`

Records method calls inside the loop body.

For `idByLoop`:

```haskell
loopHelperCalls = []
```

Purpose: if the loop body calls another method, the loop invariant may depend on that callee’s contract.

Example:

```java
while (i < a.length) {
    incAt(a, i);
    i++;
}
```

The caller can only infer:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == \old(a[k]) + 1);
```

if `incAt` has a precise contract saying it increments exactly `a[i]` and leaves other cells unchanged.

The report notes that `incrementAllViaHelper` depends on the helper specification of `incAt`, and the dataflow questions explicitly include helper calls because caller invariants depend on callee `assignable` and `ensures` clauses.  

---

## `loopNeedsOldState :: Bool`

Whether generated invariants need pre-state values via `\old(...)` or ghost snapshots.

For `idByLoop`:

```haskell
loopNeedsOldState = False
```

Purpose: tells the generator whether it must use old-state expressions.

Example where it is `True`:

```java
a[i] = a[i] + 1;
```

You need:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == \old(a[k]) + 1);
```

For array mutation, reverse, and field updates, old-state relations are often essential. The report explicitly says old values are needed for in-place mutation and field update examples. 

---

## `loopNeedsSortedness :: Bool`

Whether the inferred semantic invariant depends on sortedness.

For `idByLoop`:

```haskell
loopNeedsSortedness = False
```

Purpose: prevents your tool from silently inventing sortedness assumptions.

Example where it is `True`:

```java
binarySearch(int[] a, int x)
```

Binary search exclusion facts such as:

```java
//@ maintaining (\forall int k; 0 <= k && k < lo; a[k] < x);
//@ maintaining (\forall int k; hi < k && k < a.length; a[k] > x);
```

are only sound if the array is sorted.

The report explicitly lists sortedness for `binarySearch` as a semantic precondition not inferable from the loop body alone. 

---

## `loopNeedsNonEmptyArray :: Bool`

Whether the loop or its setup requires a nonempty array.

For `idByLoop`:

```haskell
loopNeedsNonEmptyArray = False
```

Purpose: generates or records preconditions like:

```java
//@ requires a.length > 0;
```

Example:

```java
int i = 1;
int m = a[0];
while (i < a.length) { ... }
```

For `max`, `a[0]` is accessed before the loop. So the method needs:

```java
//@ requires a != null;
//@ requires a.length > 0;
```

The report identifies nonempty array for `max` as a semantic precondition. 

---

## `loopNeedsNoOverflow :: Bool`

Whether mathematical specs/invariants require ruling out Java `int` overflow.

For `idByLoop`:

```haskell
loopNeedsNoOverflow = False
```

At least for the intended simple reasoning, no sum/product/update of data values occurs.

Purpose: records that generated JML uses mathematical expressions that may not match Java overflow behavior unless preconditions are added.

Examples:

```java
s += a[i];
x++;
a[i] = a[i] + 1;
n * (n - 1) / 2
```

These may need preconditions like:

```java
//@ requires (\forall int k; 0 <= k && k < a.length; a[k] < Integer.MAX_VALUE);
```

or prefix-sum bounds.

The report says arithmetic postconditions are mathematical and Java `int` overflow is controlled by explicit preconditions.  It also lists no-overflow bounds as semantic preconditions for several methods. 

---

## `loopFrameTargets :: [String]`

The locations that the loop is allowed to modify.

For `idByLoop`:

```haskell
loopFrameTargets = [ "i" ]
```

Purpose: directly generates `loop_assigns`.

For `idByLoop`:

```java
//@ loop_assigns i;
```

For an array mutation:

```haskell
loopFrameTargets = [ "i", "a[*]" ]
```

which becomes:

```java
//@ loop_assigns i, a[*];
```

The report’s template rules say to always emit `LoopFrameTemplate` from assigned locals, fields, and array cells. 

---

## `loopDecreasesCandidate :: Maybe expr`

Candidate termination variant.

For `idByLoop`:

```haskell
loopDecreasesCandidate = Just "n - i"
```

Purpose: generates:

```java
//@ decreases n - i;
```

and lets the validator check:

1. non-negativity at loop head,
2. strict decrease after one iteration.

The report lists common variants such as `n - i`, `a.length - i`, `src.length - i`, and `hi - lo + 1`. 

Why `Maybe expr`?

Because some loops may not have an obvious variant:

```haskell
loopDecreasesCandidate = Nothing
```

Then your tool should either avoid emitting `decreases`, emit a weaker partial-correctness-only annotation, or require manual help.

---

## `loopTemplateHints :: [InvariantTemplate]`

The templates that the summary suggests should be instantiated.

For `idByLoop`:

```haskell
loopTemplateHints =
  [ CounterBoundsTemplate { counter = "i", lower = "0", upper = "n" }
  , LoopFrameTemplate { frameTargets = [ "i" ] }
  , DecreasesTemplate { variant = "n - i" }
  ]
```

Purpose: separates **recognition** from **emission**.

The summary says:

```text
This loop looks like a counter-bounds loop.
```

Then the template phase turns that into:

```java
//@ maintaining 0 <= i && i <= n;
//@ loop_assigns i;
//@ decreases n - i;
```

The report explicitly asks what template candidates are triggered because a loop can trigger several templates: bounds, semantic prefix, frame, and decreases. 

---

## `loopValidationNotes :: [String]`

Human-readable or machine-readable notes about what still must be proven or supplied.

For `idByLoop`:

```haskell
loopValidationNotes =
  [ "Requires 0 <= n to prove result == n"
  , "Initialization: i == 0 establishes 0 <= i && i <= n"
  , "Preservation: i++ preserves 0 <= i && i <= n under i < n"
  , "Exit: invariant && !(i < n) gives i == n"
  , "Termination: n - i decreases by 1"
  ]
```

Purpose: records the remaining proof obligations after template generation.

This field is important because generated templates are only candidates. The report emphasizes that generated annotations still need validation by VCs, OpenJML, SMT, or an internal checker.  It also lists validation obligations: initialization, preservation, exit usefulness, frame soundness, termination, overflow, and well-definedness. 

---

# Nested summary fields

These are not top-level fields of `LoopSummary`, but they appear inside top-level fields.

## `EarlyExitSummary`

```haskell
data EarlyExitSummary expr = EarlyExitSummary
  { exitKind      :: EarlyExitKind
  , exitCondition :: expr
  , exitEffect    :: Maybe expr
  }
```

Purpose:

* `exitKind`: tells whether the exit is `return`, `break`, `continue`, or `throw`.
* `exitCondition`: records the path condition under which the exit occurs.
* `exitEffect`: records what the exit does, such as `return true`, `return i`, or `throw IllegalArgumentException`.

Example:

```java
if (a[i] == x) return true;
```

summary:

```haskell
EarlyExitSummary
  { exitKind = ReturnExit
  , exitCondition = "a[i] == x"
  , exitEffect = Just "true"
  }
```

---

## `ArrayAccessSummary`

```haskell
data ArrayAccessSummary expr = ArrayAccessSummary
  { arrayName     :: String
  , arrayIndex    :: expr
  , accessKind    :: AccessKind
  , writtenValue  :: Maybe expr
  }
```

Purpose:

* `arrayName`: which array is accessed.
* `arrayIndex`: which index expression is used.
* `accessKind`: read, write, or read-write.
* `writtenValue`: value assigned, if this is a write.

Example:

```java
a[i] = 0;
```

summary:

```haskell
ArrayAccessSummary
  { arrayName = "a"
  , arrayIndex = "i"
  , accessKind = ArrayWrite
  , writtenValue = Just "0"
  }
```

This can trigger:

```haskell
ArrayFillTemplate(a, i, 0)
```

---

## `AccumulatorSummary`

```haskell
data AccumulatorSummary expr = AccumulatorSummary
  { accName       :: String
  , accKind       :: AccumulatorKind
  , accInit       :: expr
  , accUpdate     :: expr
  , accGuard      :: Maybe expr
  , accDomain     :: Maybe expr
  }
```

Purpose:

* `accName`: accumulator variable, e.g. `s` or `m`.
* `accKind`: sum, arithmetic series, max, field-linear, etc.
* `accInit`: initial value before loop.
* `accUpdate`: update expression in the loop.
* `accGuard`: condition under which update happens, if any.
* `accDomain`: quantified domain, usually `0 <= k && k < i`.

Example:

```java
if (a[i] >= 0) {
    s += a[i];
}
```

summary:

```haskell
AccumulatorSummary
  { accName = "s"
  , accKind = AdditiveAccumulator
  , accInit = "0"
  , accUpdate = "s + a[i]"
  , accGuard = Just "a[i] >= 0"
  , accDomain = Just "0 <= k && k < i"
  }
```

---

## `SegmentSummary`

```haskell
data SegmentSummary expr
  = PrefixSegment { segArray :: String, segIndex :: String, segPredicate :: expr }
  | SuffixSegment { segArray :: String, segIndex :: String, segPredicate :: expr }
  | TwoFrontierSegments { leftIndex :: String, rightIndex :: String, segmentFact :: expr }
  | ExclusionZones { lowIndex :: String, highIndex :: String, leftFact :: expr, rightFact :: expr }
```

Purpose: records semantic regions of an array or search interval.

Examples:

For a prefix fill:

```haskell
PrefixSegment
  { segArray = "a"
  , segIndex = "i"
  , segPredicate = "a[k] == v"
  }
```

For binary search:

```haskell
ExclusionZones
  { lowIndex = "lo"
  , highIndex = "hi"
  , leftFact = "a[k] < x for k < lo"
  , rightFact = "a[k] > x for k > hi"
  }
```

This field is what lets your tool generate quantified invariants over processed parts of the input.

---

## `HelperCallSummary`

```haskell
data HelperCallSummary expr = HelperCallSummary
  { calleeName        :: String
  , calleeArguments   :: [expr]
  , requiredFrame     :: [String]
  , requiredPostFacts :: [expr]
  }
```

Purpose:

* `calleeName`: name of called method.
* `calleeArguments`: actual arguments at the call site.
* `requiredFrame`: what the callee must be allowed to modify.
* `requiredPostFacts`: what the caller needs from the callee to preserve the loop invariant.

Example:

```java
incAt(a, i);
```

summary:

```haskell
HelperCallSummary
  { calleeName = "incAt"
  , calleeArguments = [ "a", "i" ]
  , requiredFrame = [ "a[i]" ]
  , requiredPostFacts =
      [ "a[i] == \\old(a[i]) + 1"
      , "all other a[k] unchanged"
      ]
  }
```

Without this, `incrementAllViaHelper` cannot soundly infer the same invariant as the direct `incrementAll` loop.

---

# For `idByLoop`, most fields are intentionally empty

That is a good sign. `idByLoop` is the simplest possible counter loop:

```java
int i = 0;
while (i < n) {
    i++;
}
return i;
```

So the only meaningful summary facts are:

```haskell
loopKind                  = WhileCountingUp
loopInitFacts             = [ "i == 0" ]
loopGuard                 = "i < n"
loopCounters              = [ ("i", "i") ]
loopCounterBounds         = [ ("i", "0", "n") ]
loopCounterDirection      = [ ("i", Increasing) ]
loopCounterStride         = [ ("i", "1") ]
loopBoundStabilityFacts   = [ "n is read-only during the loop" ]
loopAssignments           = [ "i" ]
loopReadOnlyVars          = [ "n" ]
loopFrameTargets          = [ "i" ]
loopDecreasesCandidate    = Just "n - i"
loopTemplateHints         =
  [ CounterBoundsTemplate ...
  , LoopFrameTemplate ...
  , DecreasesTemplate ...
  ]
```

Everything array-related, accumulator-related, helper-call-related, old-state-related, sortedness-related, and early-exit-related is empty or `False`.

That is exactly why the generated loop annotation is only:

```java
//@ maintaining 0 <= i && i <= n;
//@ loop_assigns i;
//@ decreases n - i;
```

The report gives this same invariant shape for `idByLoop`. 

