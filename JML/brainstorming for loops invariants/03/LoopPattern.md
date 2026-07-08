## Goal of this document

Overriding `data LoopKind` mentioned in the file `loop_invariant_missions_report_to_be_tested_3.md`, so that `LoopPattern` which is mentioned in `Better structured version` is now adopted.

---

# Why the original type was incomplete

## 1. Missing `GuardlessLoopPattern`

For:

```java
public static int idByLoop2(int n) {
    int i = 0;
    while (true) {
        i++;
        if(i >= n) {
          break;
        }
    }
    return i;
}
```

This is not a normal guarded counting loop.

It is not:

```haskell
CountingUpPattern
```

alone, because the loop guard is `true`. Termination is internal:

```java
if (i >= n) {
    break;
}
```

So the pattern should include:

```haskell
[ CountingUpPattern
, GuardlessLoopPattern
, BreakPattern
]
```

or more specifically:

```haskell
[ CountingUpPattern
, GuardlessLoopPattern
, InternalBreakTerminationPattern
]
```

If you keep only `BreakPattern`, that is probably enough for now.

---

## 2. Missing `MovingBoundPattern`

For:

```java
public static int halving(int n) {
  int i = 0;
  while (i < n) {
    n--;
    i++;
  }
  return i;
}
```

This is not ordinary `CountingUpPattern`.

The counter `i` increases, but the bound `n` decreases. The report explicitly says bound stability matters because stable bounds justify decreases expressions and prefix ranges. In `halving`, `n` is **not stable**.

So this loop should be classified as:

```haskell
[ CountingUpPattern
, MovingBoundPattern
]
```

The natural termination measure is not the usual simple stable-bound variant:

```haskell
n - i
```

because both sides change. But it can still decrease:

```text
before body: n - i
after n-- and i++: (n - 1) - (i + 1) = n - i - 2
```

So `MovingBoundPattern` is useful for loops where the guard bound itself is assigned inside the loop.

---

## 3. Missing `BreakPattern`

You need this for at least:

```java
firstEvenOrLength
```

and also for:

```java
idByLoop2
```

The report already treats break as an early-exit kind and gives `firstEvenOrLength` as a loop with break.

So `BreakPattern` should be explicit.

---

## 4. Missing `ContinuePattern`

You need this for:

```java
clampNegativeToZero
```

The report emphasizes that `clampNegativeToZero` needs path-sensitive validation because `i++` occurs before `continue`.

So the method is not only:

```haskell
[ CountingUpPattern
, ArrayMutationPattern
]
```

but more precisely:

```haskell
[ CountingUpPattern
, ArrayScanPattern
, ConditionalArrayMutationPattern
, ContinuePattern
]
```

---

## 5. Missing `EarlyReturnPattern`

You currently have `SearchPattern`, but not all early returns are exactly the same semantic pattern.

Examples:

```java
contains       // return true when found
indexOf        // return i when found
allNonNegative // return false when counterexample found
binarySearch   // return mid when found
```

The report lists returns inside loops as early exits and separates their path conditions.

So I would include:

```haskell
EarlyReturnPattern
```

Then:

```haskell
contains =
  [ CountingUpPattern
  , ArrayScanPattern
  , SearchPattern
  , EarlyReturnPattern
  ]
```

and:

```haskell
allNonNegative =
  [ CountingUpPattern
  , ArrayScanPattern
  , PrefixPropertyPattern
  , EarlyReturnPattern
  ]
```

---

## 6. `ArrayMutationPattern` is too coarse

This single constructor technically covers:

```java
fill
copy
incrementAll
clampNegativeToZero
zeroEvenIndices
clear
reverse
```

But these need different invariant templates:

```haskell
fill          -> ArrayFillPattern
copy          -> ArrayCopyPattern
incrementAll  -> InPlaceTransformPattern
clamp...      -> ConditionalArrayMutationPattern
zeroEven...   -> ArrayFillPattern + StridedCountingPattern
reverse       -> TwoFrontierPattern
```

The report also distinguishes array fill, copy, in-place transform, conditional rewrite, and reverse templates.

So I would keep `ArrayMutationPattern` as a broad tag, but add the more specific tags too.

---

## 7. `AccumulatorPattern` is too coarse

This covers:

```java
sum
triangular
max
addN
sumNonNegative
```

But they need different invariant templates:

```haskell
sum             -> AccumulatorPattern
triangular      -> ArithmeticSeriesAccumulatorPattern
max             -> MaxAccumulatorPattern
addN            -> FieldAccumulatorPattern
sumNonNegative  -> AccumulatorPattern + ExceptionPattern
```

The report distinguishes additive array accumulator, arithmetic-series accumulator, max accumulator, and field-linear accumulator.

So again: keep the broad `AccumulatorPattern`, but add sub-patterns.

---

# Better structured version

The flat enum works, but it will keep growing. I would prefer a more structured version:

```haskell
data LoopSyntax
  = WhileSyntax
  | ForSyntax
  | DoWhileSyntax
  | UnknownSyntax
  deriving (Eq, Show)

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
  deriving (Eq, Show)

data CounterPattern
  = CountingUp
  | CountingDown
  | StridedCounting
  | ConditionalCounterMovement
  deriving (Eq, Show)

data BoundPattern
  = StableBound
  | MovingBound
  | GuardlessWithInternalExit
  deriving (Eq, Show)

data TraversalPattern
  = ArrayScan
  | PrefixProperty
  | SourceUnchanged
  deriving (Eq, Show)

data MutationPattern
  = ArrayFill
  | ArrayCopy
  | InPlaceTransform
  | ConditionalArrayRewrite
  | SymmetricSwap
  deriving (Eq, Show)

data AccumulatorPattern
  = AdditiveAccumulator
  | ArithmeticSeriesAccumulator
  | MaxAccumulator
  | FieldLinearAccumulator
  deriving (Eq, Show)

data SearchPattern
  = LinearSearch
  | FirstIndexSearch
  | BooleanPredicateScan
  | BinarySearch
  deriving (Eq, Show)

data ControlFlowPattern
  = EarlyReturn
  | BreakExit
  | ContinuePath
  | ThrowExit
  deriving (Eq, Show)
```

Then `idByLoop` is:

```haskell
loopSyntax =
  WhileSyntax

loopPatterns =
  [ CounterPattern CountingUp
  , BoundPattern StableBound
  ]
```

`idByLoop2` is:

```haskell
loopSyntax =
  WhileSyntax

loopPatterns =
  [ CounterPattern CountingUp
  , BoundPattern GuardlessWithInternalExit
  , ControlFlowPattern BreakExit
  ]
```

`halving` is:

```haskell
loopSyntax =
  WhileSyntax

loopPatterns =
  [ CounterPattern CountingUp
  , CounterPattern CountingDown
  , BoundPattern MovingBound
  ]
```

`sum` is:

```haskell
loopSyntax =
  WhileSyntax

loopPatterns =
  [ CounterPattern CountingUp
  , BoundPattern StableBound
  , TraversalPattern ArrayScan
  , AccumulatorPattern AdditiveAccumulator
  ]
```

`clear` is:

```haskell
loopSyntax =
  ForSyntax

loopPatterns =
  [ CounterPattern CountingUp
  , BoundPattern StableBound
  , MutationPattern ArrayFill
  ]
```

This is the cleaner design because `for`/`while` is syntax, while “counting,” “array fill,” “search,” and “accumulator” are semantic patterns.

---

# Explanation of every constructor

Yes. The most important thing to understand first is this:

```haskell
LoopPattern
```

is now a **multi-label classification**. A loop does **not** need exactly one pattern. A loop can be:

```haskell
[ CounterPattern CountingUp
, TraversalPattern ArrayScan
, AccumulatorPattern AdditiveAccumulator
]
```

as in `sum`.

So the constructors are not mutually exclusive. They describe different dimensions of the loop.

---

# 1. `LoopPattern`

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
  deriving (Eq, Show)
```

## `CounterPattern CounterPattern`

Use this when the loop has one or more **loop-carried progress variables**.

A counter pattern says:

> Some variable changes across iterations in a way that describes progress.

Examples:

```java
int i = 0;
while (i < n) {
    i++;
}
```

This gives:

```haskell
CounterPattern CountingUp
```

For:

```java
int hi = a.length - 1;
while (...) {
    hi--;
}
```

this gives:

```haskell
CounterPattern CountingDown
```

For:

```java
i += 2;
```

this gives:

```haskell
CounterPattern StridedCounting
```

For binary search:

```java
if (a[mid] < x) {
    lo = mid + 1;
} else {
    hi = mid - 1;
}
```

this gives:

```haskell
CounterPattern ConditionalCounterMovement
```

This pattern usually triggers counter bounds and termination templates.

---

## `BoundPattern BoundPattern`

Use this when the loop has an important **bound behavior**.

A bound pattern describes whether the loop limit is stable, moving, implicit, or internally defined.

Example:

```java
while (i < n) {
    i++;
}
```

If `n` is not modified:

```haskell
BoundPattern StableBound
```

Example:

```java
while (i < n) {
    n--;
    i++;
}
```

Here `n` is the guard bound, but it changes:

```haskell
BoundPattern MovingBound
```

Example:

```java
while (true) {
    i++;
    if (i >= n) break;
}
```

There is no useful syntactic guard, so:

```haskell
BoundPattern GuardlessWithInternalExit
```

And because the effective bound is not exactly `n` for all inputs but rather:

```java
(n <= 1 ? 1 : n)
```

you also use:

```haskell
BoundPattern ConditionalEffectiveBound
```

This pattern helps decide whether ordinary invariants like:

```java
//@ maintaining 0 <= i && i <= n;
```

are valid or whether you need a more special invariant.

---

## `TraversalPattern TraversalPattern`

Use this when the loop **reads through a structure or logical range**.

Most commonly this means array traversal.

Example:

```java
while (i < a.length) {
    if (a[i] == x) return true;
    i++;
}
```

This gives:

```haskell
TraversalPattern ArrayScan
```

If the loop establishes a property over a processed prefix:

```java
while (i < a.length) {
    if (a[i] < 0) return false;
    i++;
}
```

then use:

```haskell
TraversalPattern PrefixProperty
```

because the invariant is:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] >= 0);
```

If an array is only read and should remain unchanged, as in `copy` for `src`, then:

```haskell
TraversalPattern SourceUnchanged
```

can be useful.

---

## `Mutationtern MutationPattern`

Use this when the loop **writes to heap data**, especially arrays.

Example:

```java
a[i] = 0;
```

gives:

```haskell
MutationPattern ArrayFill
```

Example:

```java
dst[i] = src[i];
```

gives:

```haskell
MutationPattern ArrayCopy
```

Example:

```java
a[i] = a[i] + 1;
```

gives:

```haskell
MutationPattern InPlaceTransform
```

Example:

```java
if (a[i] < 0) {
    a[i] = 0;
}
```

gives:

```haskell
MutationPattern ConditionalArrayRewrite
```

Example:

```java
int tmp = a[lo];
a[lo] = a[hi];
a[hi] = tmp;
```

gives:

```haskell
MutationPattern SymmetricSwap
```

These patterns usually trigger quantified old-state invariants, such as:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == \old(a[k]) + 1);
```

or:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == 0);
```

---

## `Accumulatortern AccumulatorPattern`

Use this when a variable accumulates a semantic value over processed iterations.

Example:

```java
s += a[i];
```

gives:

```haskell
AccumulatorPattern AdditiveAccumulator
```

Example:

```java
s += i;
```

in `triangular` gives:

```haskell
AccumulatorPattern ArithmeticSeriesAccumulator
```

Example:

```java
if (a[i] > m) {
    m = a[i];
}
```

in `max` gives:

```haskell
AccumulatorPattern MaxAccumulator
```

Example:

```java
x++;
```

where `x` is an object field, as in `addN`, gives:

```haskell
AccumulatorPattern FieldLinearAccumulator
```

Important distinction:

```java
i++;
```

in `idByLoop` is **not** an accumulator. It is a counter update.

But:

```java
s += i;
```

is an accumulator update because `s` stores a computed semantic value.

---

## `SearchPattern SearchPattern`

Use this when the loop searches for a witness, counterexample, or target.

Example:

```java
while (i < a.length) {
    if (a[i] == x) return true;
    i++;
}
```

gives:

```haskell
SearchPattern LinearSearch
```

Example:

```java
while (i < a.length) {
    if (a[i] == x) return i;
    i++;
}
```

gives:

```haskell
SearchPattern FirstIndexSearch
```

Example:

```java
while (i < a.length) {
    if (a[i] < 0) return false;
    i++;
}
```

can be treated as:

```haskell
SearchPattern BooleanPredicateScan
```

because the loop searches for a counterexample to a universal property.

Example:

```java
while (lo <= hi) {
    int mid = lo + (hi - lo) / 2;
    ...
}
```

gives:

```haskell
SearchPattern BinarySearch
```

Search patterns usually trigger exclusion or prefix-property invariants.

For `contains`:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] != x);
```

For `allNonNegative`:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] >= 0);
```

For `binarySearch`:

```java
//@ maintaining (\forall int k; 0 <= k && k < lo; a[k] < x);
//@ maintaining (\forall int k; hi < k && k < a.length; a[k] > x);
```

---

## `ControlFlowPattern ControlFlowPattern`

Use this when the loop contains important internal control flow.

Example:

```java
if (a[i] == x) return true;
```

gives:

```haskell
ControlFlowPattern EarlyReturn
```

Example:

```java
if (a[i] % 2 == 0) break;
```

gives:

```haskell
ControlFlowPattern BreakExit
```

Example:

```java
if (a[i] >= 0) {
    i++;
    continue;
}
```

gives:

```haskell
ControlFlowPattern ContinuePath
```

Example:

```java
if (a[i] < 0) {
    throw new IllegalArgumentException();
}
```

gives:

```haskell
ControlFlowPattern ThrowExit
```

Control-flow patterns are important because ordinary loop-exit reasoning:

```text
invariant && !guard
```

is not enough for `return`, `break`, `continue`, or `throw`.

---

## `HelperCallPattern`

Use this when the loop body calls another method.

Example:

```java
while (i < a.length) {
    incAt(a, i);
    i++;
}
```

gives:

```haskell
HelperCallPattern
```

This means the loop invariant may depend on the callee specification.

For `incrementAllViaHelper`, you cannot soundly infer:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == \old(a[k]) + 1);
```

unless you know that `incAt(a, i)` increments exactly `a[i]` and leaves other cells unchanged.

So `HelperCallPattern` tells your pipeline:

> Before generating strong semantic invariants, look up or infer the helper method’s contract.

---

## `TwoFrontierPattern`

Use this when the loop has two moving boundaries, usually from both ends of a range.

Example:

```java
int lo = 0;
int hi = a.length - 1;

while (lo < hi) {
    int tmp = a[lo];
    a[lo] = a[hi];
    a[hi] = tmp;
    lo++;
    hi--;
}
```

This gives:

```haskell
TwoFrontierPattern
```

Usually combined with:

```haskell
CounterPattern CountingUp
CounterPattern CountingDown
MutationPattern SymmetricSwap
```

This pattern triggers invariants like:

```java
//@ maintaining lo + hi == a.length - 1;
//@ maintaining (\forall int k; 0 <= k && k < lo;
//@     a[k] == \old(a[a.length - 1 - k]));
//@ maintaining (\forall int k; hi < k && k < a.length;
//@     a[k] == \old(a[a.length - 1 - k]));
```

---

## `UnknownPattern`

Use this when your classifier cannot confidently recognize the loop.

Example:

```java
while (complexCondition(x, y)) {
    strangeUpdate();
}
```

or any loop where your analysis cannot determine:

```text
counter
bound
frame
termination
semantic effect
```

`UnknownPattern` should not mean “give up completely.”

It should mean:

```text
Do not emit strong semantic templates.
Emit only safe low-level facts if available.
Maybe require manual annotation.
```

For example, you might still emit:

```java
//@ loop_assigns ...;
```

but not an unsafe invariant.

---

# 2. `CounterPattern`

```haskell
data CounterPattern
  = CountingUp
  | CountingDown
  | StridedCounting
  | ConditionalCounterMovement
  deriving (Eq, Show)
```

## `CountingUp`

Use this when a counter increases monotonically, usually by `1`.

Canonical form:

```java
i++;
```

or:

```java
i = i + 1;
```

or:

```java
++i;
```

Example:

```java
int i = 0;
while (i < n) {
    i++;
}
```

Pattern:

```haskell
CounterPattern CountingUp
```

Typical invariant:

```java
//@ maintaining 0 <= i && i <= n;
```

Typical decreases:

```java
//@ decreases n - i;
```

Used in:

```text
idByLoop
idByLoop2
contains
indexOf
allNonNegative
sum
triangular
fill
copy
incrementAll
clear
max
```

and many others.

---

## `CountingDown`

Use this when a counter decreases monotonically, usually by `1`.

Canonical form:

```java
i--;
```

or:

```java
i = i - 1;
```

or:

```java
--i;
```

Example:

```java
int hi = a.length - 1;
while (hi >= 0) {
    hi--;
}
```

Pattern:

```haskell
CounterPattern CountingDown
```

Typical invariant:

```java
//@ maintaining -1 <= hi && hi < a.length;
```

Typical decreases:

```java
//@ decreases hi + 1;
```

In `reverse`, `hi` is a counting-down counter:

```java
hi--;
```

So `reverse` has both:

```haskell
CounterPattern CountingUp
CounterPattern CountingDown
```

In `halving`, `n` is also decreasing:

```java
n--;
```

but since `n` is the moving guard bound, you also add:

```haskell
BoundPattern MovingBound
```

---

## `StridedCounting`

Use this when the counter changes by a fixed step other than `1`.

Canonical examples:

```java
i += 2;
i = i + 2;
i -= 3;
i = i - 3;
```

Example:

```java
int i = 0;
while (i < a.length) {
    a[i] = 0;
    i += 2;
}
```

Pattern:

```haskell
CounterPattern StridedCounting
```

This is different from ordinary `CountingUp` because the invariant may need a congruence fact:

```java
//@ maintaining i % 2 == 0;
```

and a widened upper bound:

```java
//@ maintaining 0 <= i && i <= a.length + 1;
```

A naive invariant like:

```java
//@ maintaining 0 <= i && i <= a.length;
```

can fail after the final iteration when `a.length` is odd.

Used in:

```text
zeroEvenIndices
```

---

## `ConditionalCounterMovement`

Use this when the loop progress variable changes conditionally, depending on branches.

Canonical example:

```java
while (lo <= hi) {
    int mid = lo + (hi - lo) / 2;

    if (a[mid] < x) {
        lo = mid + 1;
    } else {
        hi = mid - 1;
    }
}
```

Pattern:

```haskell
CounterPattern ConditionalCounterMovement
```

Here neither `lo` nor `hi` is updated on every branch individually.

But the pair:

```text
(lo, hi)
```

moves in a way that shrinks the interval.

Typical decreases:

```java
//@ decreases hi - lo + 1;
```

Used in:

```text
binarySearch
```

Potentially also useful for loops like:

```java
while (...) {
    if (...) i++;
    else j--;
}
```

where progress is made by a tuple rather than by one counter on every path.

---

# 3. How to use these patterns together

A loop can have several patterns at once.

## `idByLoop`

```java
int i = 0;
while (i < n) {
    i++;
}
return i;
```

Patterns:

```haskell
[ CounterPattern CountingUp
, BoundPattern StableBound
]
```

No accumulator, no traversal, no mutation.

---

## `sum`

```java
int i = 0;
int s = 0;
while (i < a.length) {
    s += a[i];
    i++;
}
return s;
```

Patterns:

```haskell
[ CounterPattern CountingUp
, BoundPattern StableBound
, TraversalPattern ArrayScan
, AccumulatorPattern AdditiveAccumulator
]
```

Here:

```text
i = counter
s = accumulator
a = scanned source
```

---

## `fill`

```java
int i = 0;
while (i < a.length) {
    a[i] = v;
    i++;
}
```

Patterns:

```haskell
[ CounterPattern CountingUp
, BoundPattern StableBound
, MutationPattern ArrayFill
]
```

---

## `clampNegativeToZero`

```java
while (i < a.length) {
    if (a[i] >= 0) {
        i++;
        continue;
    }
    a[i] = 0;
    i++;
}
```

Patterns:

```haskell
[ CounterPattern CountingUp
, BoundPattern StableBound
, TraversalPattern ArrayScan
, MutationPattern ConditionalArrayRewrite
, ControlFlowPattern ContinuePath
]
```

---

## `idByLoop2`

```java
while (true) {
    i++;
    if (i >= n) {
        break;
    }
}
```

Patterns:

```haskell
[ CounterPattern CountingUp
, BoundPattern GuardlessWithInternalExit
, BoundPattern ConditionalEffectiveBound
, ControlFlowPattern BreakExit
]
```

---

## `halving`

```java
while (i < n) {
    n--;
    i++;
}
```

Patterns:

```haskell
[ CounterPattern CountingUp
, CounterPattern CountingDown
, BoundPattern MovingBound
]
```

---

# 4. Mental model

Use this checklist:

```text
CounterPattern:
  How does progress happen?

BoundPattern:
  What limits the loop, and is that limit stable?

TraversalPattern:
  Is the loop reading through a structure or range?

MutationPattern:
  Is the loop writing to an array or heap location?

AccumulatorPattern:
  Is the loop building a semantic value?

SearchPattern:
  Is the loop looking for a witness or counterexample?

ControlFlowPattern:
  Does return/break/continue/throw affect reasoning?

HelperCallPattern:
  Does correctness depend on a callee contract?

TwoFrontierPattern:
  Are two boundaries moving inward or maintaining an interval?

UnknownPattern:
  Did classification fail or remain too uncertain?
```

This structure is much better than a single `loopKind`, because real loops often combine several roles.
