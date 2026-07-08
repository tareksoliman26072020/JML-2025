Below is a **standalone addendum report** for only the two new methods:

```java
idByLoop2
halving
```

---

# Addendum report for `idByLoop2` and `halving`

## Scope

Source file fragment:

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

public static int halving(int n) {
  int i = 0;
  while (i < n) {
    n--;
    i++;
  }
  return i;
}
```

This report uses the improved structured classification:

```haskell
loopSyntax   :: LoopSyntax
loopPatterns :: [LoopPattern]
```

instead of the old single-field style:

```haskell
loopKind :: LoopKind
```

The reason is that a loop can simultaneously be a `while` loop, a counting loop, a break-terminated loop, a moving-bound loop, and so on. The old report already notes that the summary is meant to collect facts used by the template matcher before emitting invariant schemas, and that templates must still be validated afterward.

---

# Mission 1 — revised dataflow questions and structured `LoopSummary`

## New questions needed for these two methods

The old report already covered normal counting loops, array loops, accumulators, early exits, helper calls, and exceptions. These two methods require additional questions:

1. **Is the loop guard syntactically meaningful?**
   
   - `idByLoop2` has `while (true)`, so normal guard-exit reasoning does not apply.

2. **Does termination happen through an internal `break`?**
   
   - `idByLoop2` terminates only through `if (i >= n) break;`.

3. **Is the loop bound stable or moving?**
   
   - `halving` uses guard `i < n`, but `n` is decremented inside the loop.

4. **Is a formal parameter assigned inside the loop?**
   
   - `halving` mutates parameter `n`, so postconditions about the original input need `\old(n)`.

5. **Does the termination measure depend on two variables moving in opposite directions?**
   
   - In `halving`, `i` increases and `n` decreases, so `n - i` decreases by `2`.

6. **Does the loop need an effective logical bound different from the syntactic guard?**
   
   - `idByLoop2` behaves as if its effective target is `max(1, n)`.

7. **Does a break path need a special exit fact?**
   
   - `idByLoop2` needs the break path to establish `i == (n <= 1 ? 1 : n)`.

---

## Better structured classification types

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
  | ConditionalEffectiveBound
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

## Revised `LoopSummary`

I would replace `loopKind` with `loopSyntax` and `loopPatterns`.

```haskell
data LoopSummary expr = LoopSummary
  { loopId                  :: String
  , loopSyntax              :: LoopSyntax
  , loopPatterns            :: [LoopPattern]

  , loopInitFacts           :: [expr]
  , loopGuard               :: expr

  , loopCounters            :: [(String, expr)]
  , loopCounterBounds       :: [(String, expr, expr)]
  , loopCounterDirection    :: [(String, CounterDirection)]
  , loopCounterStride       :: [(String, expr)]

  , loopBoundStabilityFacts :: [expr]
  , loopBoundChangeFacts    :: [expr]

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

The new field is:

```haskell
loopBoundChangeFacts :: [expr]
```

This is needed because `halving` has a moving bound. For ordinary loops, this is empty. For `halving`, it records facts like:

```haskell
"n decreases by 1 whenever i increases by 1"
"n == old(n) - i"
"n is not a stable upper bound"
```

---

# Mission 2 — method-by-method `LoopSummary`

## 1. `idByLoop2`

### Code behavior

`idByLoop2` increments `i` at least once, then breaks when `i >= n`.

Therefore:

```text
if n <= 1, result == 1
if n > 1,  result == n
```

So the exact code-justified result is:

```text
result == max(1, n)
```

or in JML expression form:

```java
\result == (n <= 1 ? 1 : n)
```

### `LoopSummary`

```haskell
LoopSummary
  { loopId       = "idByLoop2#while0"

  , loopSyntax   = WhileSyntax

  , loopPatterns =
      [ CounterPattern CountingUp
      , BoundPattern GuardlessWithInternalExit
      , BoundPattern ConditionalEffectiveBound
      , ControlFlowPattern BreakExit
      ]

  , loopInitFacts =
      [ "i == 0" ]

  , loopGuard =
      "true"

  , loopCounters =
      [ ("i", "i") ]

  , loopCounterBounds =
      [ ("i", "0", "(n <= 1 ? 1 : n)") ]

  , loopCounterDirection =
      [ ("i", Increasing) ]

  , loopCounterStride =
      [ ("i", "1") ]

  , loopBoundStabilityFacts =
      [ "n is read-only during the loop"
      , "effective bound is (n <= 1 ? 1 : n)"
      ]

  , loopBoundChangeFacts =
      []

  , loopAssignments =
      [ "i" ]

  , loopFieldAssignments =
      []

  , loopArrayAccesses =
      []

  , loopReadOnlyVars =
      [ "n" ]

  , loopAccumulators =
      []

  , loopSegments =
      []

  , loopEarlyExits =
      [ EarlyExitSummary
          { exitKind      = BreakExit
          , exitCondition = "i >= n after i++"
          , exitEffect    = Just "loop exits with i == (n <= 1 ? 1 : n)"
          }
      ]

  , loopHelperCalls =
      []

  , loopNeedsOldState      = False
  , loopNeedsSortedness    = False
  , loopNeedsNonEmptyArray = False
  , loopNeedsNoOverflow    = False

  , loopFrameTargets =
      [ "i" ]

  , loopDecreasesCandidate =
      Just "(n <= 1 ? 1 : n) - i"

  , loopTemplateHints =
      [ ConditionalEffectiveBoundTemplate
          { counter        = "i"
          , effectiveBound = "(n <= 1 ? 1 : n)"
          }

      , GuardlessBreakTerminationTemplate
          { counter        = "i"
          , breakCondition = "i >= n"
          , exitFact       = "i == (n <= 1 ? 1 : n)"
          }

      , LoopFrameTemplate
          { frameTargets = [ "i" ] }

      , DecreasesTemplate
          { variant = "(n <= 1 ? 1 : n) - i" }
      ]

  , loopValidationNotes =
      [ "The loop guard is true, so exit-usefulness does not come from invariant && !guard."
      , "Termination is established by the internal break condition i >= n."
      , "The effective logical bound is max(1, n), encoded as (n <= 1 ? 1 : n)."
      , "At loop head: if n <= 1 then i == 0; if n > 1 then i < n."
      , "On a non-break path, i has just been incremented and i < n still holds."
      , "On the break path, prove i == (n <= 1 ? 1 : n)."
      ]
  }
```

---

## 2. `halving`

### Code behavior

`halving` starts with:

```java
int i = 0;
```

Then each loop iteration does:

```java
n--;
i++;
```

So after `t` iterations:

```text
i == t
n == old(n) - t
```

The loop continues while:

```text
i < n
```

That is:

```text
t < old(n) - t
```

or:

```text
2t < old(n)
```

The loop stops at the smallest `t` such that:

```text
2t >= old(n)
```

Therefore:

```text
if old(n) <= 0, result == 0
if old(n) > 0,  result == ceil(old(n) / 2)
```

For positive Java integers, `ceil(n / 2)` can be written without overflow as:

```java
n / 2 + n % 2
```

Because for positive `n`, `n % 2` is either `0` or `1`.

### `LoopSummary`

```haskell
LoopSummary
  { loopId       = "halving#while0"

  , loopSyntax   = WhileSyntax

  , loopPatterns =
      [ CounterPattern CountingUp
      , CounterPattern CountingDown
      , BoundPattern MovingBound
      ]

  , loopInitFacts =
      [ "i == 0"
      , "n == old(n)"
      ]

  , loopGuard =
      "i < n"

  , loopCounters =
      [ ("i", "primary increasing counter")
      , ("n", "moving decreasing bound")
      ]

  , loopCounterBounds =
      [ ("i", "0", "ceil(old(n) / 2)")
      ]

  , loopCounterDirection =
      [ ("i", Increasing)
      , ("n", Decreasing)
      ]

  , loopCounterStride =
      [ ("i", "1")
      , ("n", "1")
      ]

  , loopBoundStabilityFacts =
      []

  , loopBoundChangeFacts =
      [ "n is assigned inside the loop"
      , "n decreases by 1 on every iteration"
      , "i increases by 1 on every iteration"
      , "n == old(n) - i"
      , "n - i decreases by 2 on every iteration"
      ]

  , loopAssignments =
      [ "i", "n" ]

  , loopFieldAssignments =
      []

  , loopArrayAccesses =
      []

  , loopReadOnlyVars =
      []

  , loopAccumulators =
      []

  , loopSegments =
      []

  , loopEarlyExits =
      []

  , loopHelperCalls =
      []

  , loopNeedsOldState      = True
  , loopNeedsSortedness    = False
  , loopNeedsNonEmptyArray = False
  , loopNeedsNoOverflow    = False

  , loopFrameTargets =
      [ "i", "n" ]

  , loopDecreasesCandidate =
      Just "n - i"

  , loopTemplateHints =
      [ MovingBoundRelationTemplate
          { increasingVar = "i"
          , decreasingVar = "n"
          , relation      = "n == old(n) - i"
          }

      , MovingBoundExitTemplate
          { increasingVar = "i"
          , decreasingVar = "n"
          , exitFact      = "i >= n"
          }

      , LoopFrameTemplate
          { frameTargets = [ "i", "n" ] }

      , DecreasesTemplate
          { variant = "n - i" }
      ]

  , loopValidationNotes =
      [ "This is not a stable-bound counting loop because n is assigned in the body."
      , "The usual invariant 0 <= i && i <= n is not inductive."
      , "The key relation is n == old(n) - i."
      , "The variant n - i decreases by 2, not by 1."
      , "At exit, i >= n and n == old(n) - i imply 2*i >= old(n)."
      , "For exact ceil behavior, also need the upper-side invariant i <= n + 1 when old(n) > 0."
      , "Because the formal parameter n is mutated, postconditions about the input must use old(n)."
      ]
  }
```

---

# Mission 3 — new `InvariantTemplate` constructors needed

The old template set already has useful generic templates such as:

```haskell
LoopFrameTemplate
DecreasesTemplate
BreakExitTemplate
```

But these two new methods require more precise templates.

## Additional template constructors

```haskell
data InvariantTemplate
  -- existing constructors stay unchanged

  | ConditionalEffectiveBoundTemplate
      { counter        :: String
      , effectiveBound :: Expr
      }

  | GuardlessBreakTerminationTemplate
      { counter        :: String
      , breakCondition :: Expr
      , exitFact       :: Expr
      }

  | MovingBoundRelationTemplate
      { increasingVar :: String
      , decreasingVar :: String
      , relation      :: Expr
      }

  | MovingBoundExitTemplate
      { increasingVar :: String
      , decreasingVar :: String
      , exitFact      :: Expr
      }

  | MovingBoundUpperSandwichTemplate
      { increasingVar :: String
      , decreasingVar :: String
      , originalBound :: Expr
      }

  deriving (Eq, Show)
```

## Template rules

Add these decision rules to the old algorithm.

### Rule A — guardless break loop

If:

```text
loop guard is true
one counter increases
there is a break condition involving the counter
```

then emit:

```haskell
GuardlessBreakTerminationTemplate
ConditionalEffectiveBoundTemplate
BreakExitTemplate
LoopFrameTemplate
DecreasesTemplate
```

For `idByLoop2`, this yields:

```text
effective bound: (n <= 1 ? 1 : n)
break condition: i >= n
variant: (n <= 1 ? 1 : n) - i
```

### Rule B — moving bound loop

If:

```text
guard is i < n
i increases by 1
n decreases by 1
n is assigned in the loop
```

then do **not** emit the ordinary stable-bound template:

```haskell
CounterBoundsTemplate(i, 0, n)
```

Instead emit:

```haskell
MovingBoundRelationTemplate(i, n, n == old(n) - i)
MovingBoundExitTemplate(i, n, i >= n)
MovingBoundUpperSandwichTemplate(i, n, old(n))
LoopFrameTemplate([i, n])
DecreasesTemplate(n - i)
```

---

# Mission 4 — inferred JML invariants and proof needs

## 1. `idByLoop2`

### Code-justified method contract

```java
/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == (n <= 1 ? 1 : n);
  @*/
public static int idByLoop2(int n) {
    int i = 0;

    //@ maintaining 0 <= i;
    //@ maintaining n <= 1 ==> i == 0;
    //@ maintaining n > 1 ==> i < n;
    //@ loop_assigns i;
    //@ decreases (n <= 1 ? 1 : n) - i;
    while (true) {
        i++;

        if (i >= n) {
            //@ assert i == (n <= 1 ? 1 : n);
            break;
        }
    }

    return i;
}
```

### Simpler partial variant

If you only want the same intended behavior as `idByLoop`, namely `result == n`, then use:

```java
/*@ normal_behavior
  @   requires 1 <= n;
  @   assignable \nothing;
  @   ensures \result == n;
  @*/
public static int idByLoop2(int n) {
    int i = 0;

    //@ maintaining 0 <= i && i < n;
    //@ loop_assigns i;
    //@ decreases n - i;
    while (true) {
        i++;

        if (i >= n) {
            //@ assert i == n;
            break;
        }
    }

    return i;
}
```

### Four proof needs

#### Safety

No array access, no dereference, no division. Integer overflow is not a practical issue for the code path because:

- if `n <= 1`, the loop executes once;

- if `n > 1`, `i` increases only until `n`.

#### Postcondition

For the total contract:

```java
ensures \result == (n <= 1 ? 1 : n);
```

the break path must establish:

```text
if n <= 1, i == 1
if n > 1,  i == n
```

The inserted assertion before `break` expresses exactly the exit fact that the template should generate.

#### Frame

Only local variable `i` changes:

```java
//@ loop_assigns i;
```

Method-level frame is:

```java
assignable \nothing;
```

because no heap state is modified.

#### Termination

The loop guard is `true`, so termination must be proven from the internal break. The effective variant is:

```java
(n <= 1 ? 1 : n) - i
```

At every loop head it is non-negative and decreases on every continuing path.

---

## 2. `halving`

### Code-justified method contract

```java
/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \old(n) <= 0 ==> \result == 0;
  @   ensures \old(n) > 0 ==> \result == \old(n) / 2 + \old(n) % 2;
  @*/
public static int halving(int n) {
    int i = 0;

    //@ maintaining 0 <= i;
    //@ maintaining n == \old(n) - i;
    //@ maintaining \old(n) <= 0 ==> i == 0;
    //@ maintaining \old(n) > 0 ==> i <= n + 1;
    //@ loop_assigns i, n;
    //@ decreases n - i;
    while (i < n) {
        n--;
        i++;
    }

    return i;
}
```

### Alternative arithmetic postcondition

The following postcondition avoids division/modulo but uses mathematical multiplication, so in an OpenJML setting you may want casts or arithmetic-mode control:

```java
//@ ensures \old(n) <= 0 ==> \result == 0;
//@ ensures \old(n) > 0 ==> 2 * \result >= \old(n);
//@ ensures \old(n) > 0 ==> 2 * \result <= \old(n) + 1;
```

The division/modulo version is usually clearer:

```java
//@ ensures \old(n) > 0 ==> \result == \old(n) / 2 + \old(n) % 2;
```

### Four proof needs

#### Safety

No array access, no dereference, no division inside the implementation.

The implementation terminates for all `int n`:

- if initial `n <= 0`, the loop does not execute;

- if initial `n > 0`, each iteration decreases `n - i` by `2`.

#### Postcondition

The key invariant is:

```java
//@ maintaining n == \old(n) - i;
```

At loop exit:

```text
!(i < n)
```

so:

```text
i >= n
```

Together with:

```text
n == old(n) - i
```

we get:

```text
i >= old(n) - i
2*i >= old(n)
```

The upper-side invariant:

```java
//@ maintaining \old(n) > 0 ==> i <= n + 1;
```

gives:

```text
i <= old(n) - i + 1
2*i <= old(n) + 1
```

Together these characterize:

```text
i == ceil(old(n) / 2)
```

for positive `old(n)`.

#### Frame

The loop modifies both:

```java
i
n
```

So the loop frame is:

```java
//@ loop_assigns i, n;
```

The method-level frame remains:

```java
assignable \nothing;
```

because assigning a formal parameter does not mutate heap state.

#### Termination

The variant is:

```java
//@ decreases n - i;
```

On every iteration:

```text
old variant = n - i
new variant = (n - 1) - (i + 1)
            = n - i - 2
```

So it strictly decreases.

This is exactly the kind of case where `loopBoundStabilityFacts` must be empty and `loopBoundChangeFacts` must record that `n` is a moving bound.

---

# Mission 5 — inference pipeline and remaining work

## `idByLoop2` pipeline

### Input

```java
int i = 0;
while (true) {
    i++;
    if (i >= n) break;
}
return i;
```

### Step 1 — detect syntax

```haskell
loopSyntax = WhileSyntax
loopGuard  = true
```

### Step 2 — detect counter

```haskell
i initialized to 0
i updated by i++
i is used in break condition i >= n
```

So:

```haskell
CounterPattern CountingUp
```

### Step 3 — detect guardless termination

Because the guard is `true` and there is a `break`, classify:

```haskell
BoundPattern GuardlessWithInternalExit
ControlFlowPattern BreakExit
```

### Step 4 — infer effective bound

The loop always increments before checking the break.

Therefore the effective bound is:

```java
(n <= 1 ? 1 : n)
```

### Step 5 — generate templates

```haskell
ConditionalEffectiveBoundTemplate(i, (n <= 1 ? 1 : n))
GuardlessBreakTerminationTemplate(i, i >= n, i == (n <= 1 ? 1 : n))
LoopFrameTemplate([i])
DecreasesTemplate((n <= 1 ? 1 : n) - i)
```

### Step 6 — validate

Required validation checks:

```text
initialization:
  i == 0 establishes all invariants

preservation:
  on non-break path, i has incremented but still i < n

break exit:
  prove i == (n <= 1 ? 1 : n)

termination:
  effectiveBound - i decreases on continuing paths

frame:
  only i is modified
```

### Remaining work

The old algorithm must be extended because `invariant && !guard` is useless for `while(true)`. Exit-usefulness must use the recorded `BreakExit` path condition instead.

---

## `halving` pipeline

### Input

```java
int i = 0;
while (i < n) {
    n--;
    i++;
}
return i;
```

### Step 1 — detect syntax

```haskell
loopSyntax = WhileSyntax
loopGuard  = i < n
```

### Step 2 — detect moving variables

```haskell
i increases by 1
n decreases by 1
```

So:

```haskell
CounterPattern CountingUp
CounterPattern CountingDown
BoundPattern MovingBound
```

### Step 3 — reject stable-bound template

Do **not** emit:

```java
//@ maintaining 0 <= i && i <= n;
```

because it is not the right semantic invariant for this method.

The bound `n` changes.

### Step 4 — infer relational invariant

From symbolic execution:

```text
initially: i == 0, n == old(n)
after 1 iteration: i == 1, n == old(n) - 1
after 2 iterations: i == 2, n == old(n) - 2
```

Generalization:

```java
//@ maintaining n == \old(n) - i;
```

### Step 5 — infer termination

Variant:

```java
//@ decreases n - i;
```

On every iteration it decreases by `2`.

### Step 6 — validate exit usefulness

At exit:

```text
i >= n
n == old(n) - i
```

Therefore:

```text
2*i >= old(n)
```

With the upper-side invariant:

```text
i <= n + 1
```

we get:

```text
2*i <= old(n) + 1
```

So `i` is the ceiling half of the original input.

### Remaining work

The validator must support:

```text
1. formal parameters assigned inside loops;
2. \old(n) in loop invariants;
3. moving-bound variants;
4. arithmetic reasoning for ceil-half behavior;
5. no accidental use of stable-bound templates.
```

---

# Summary table

| Method      | Syntax        | Patterns                                                                            | Main invariant idea                                                            | Variant                |
| ----------- | ------------- | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ | ---------------------- |
| `idByLoop2` | `WhileSyntax` | `CountingUp`, `GuardlessWithInternalExit`, `ConditionalEffectiveBound`, `BreakExit` | At loop head: `n <= 1 ==> i == 0`, `n > 1 ==> i < n`                           | `(n <= 1 ? 1 : n) - i` |
| `halving`   | `WhileSyntax` | `CountingUp`, `CountingDown`, `MovingBound`                                         | `n == \old(n) - i`; plus upper sandwich `i <= n + 1` for positive original `n` | `n - i`                |

The architectural conclusion is that these two methods justify the structured design. A single `loopKind` value is too rigid: `idByLoop2` is both a counting loop and a break-terminated loop, while `halving` is both a counting-up loop and a moving-bound loop.
