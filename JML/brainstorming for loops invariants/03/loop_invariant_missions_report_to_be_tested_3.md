# Loop-invariant missions report for `to-be-tested-3.java`

This report repeats Missions 1–5 for `to-be-tested-3.java`.

Scope:

- Source file: `to-be-tested-3.java`
- Output companion file: `to-be-tested-3.annotated.java`
- Main goal: infer verifier-oriented JML method contracts, loop invariants, loop frames, termination measures, loop-summary facts, and template-generation consequences.

Important status:

- This is a synthesis/design pass, not a completed OpenJML proof run.
- The generated annotations are intended to be close to copy-ready, but the next required phase is validation by generated VCs, OpenJML, SMT, or a conservative internal checker.
- Arithmetic postconditions are mathematical. Java `int` overflow is controlled by explicit preconditions where needed.
- `addN` assumes an enclosing object field named `x`.
- `incrementAllViaHelper` depends on the helper specification of `incAt`.

---

# Mission 1 — revised lightweight-dataflow questions and `LoopSummary`

The original questions from `01-architecture.md` are necessary but not sufficient for `to-be-tested-3.java`. They covered initialization, assignments, loop counter, counter direction, array writes, accumulators, read-only variables, and break/continue. For this file, the list must also cover:

1. **What is the loop kind?**
   - `while`, `for`, normalized `for`, two-frontier loop, search loop, helper-call loop, exception loop, strided loop.

2. **What is the normalized loop shape?**
   - init, guard, body, step.
   - For `for`, the step is syntactically outside the body but semantically part of one iteration.
   - For `while`, the step is usually inside the body.

3. **Which variables are loop counters / induction variables?**
   - Single counter: `i`.
   - Two counters: `lo`, `hi` in `reverse`, `binarySearch`.
   - Field accumulator: `x` in `addN` is not a counter but evolves with `i`.

4. **What are the counter bounds, direction, and stride?**
   - Upward unit stride: `i++`.
   - Downward unit stride: `hi--`.
   - Non-unit stride: `i += 2`.
   - Conditional counter updates: `lo = mid + 1`, `hi = mid - 1`.

5. **Is the loop bound stable?**
   - `a.length`, `src.length`, `n` are read-only during these loops.
   - Stability must be recorded because it justifies decreases expressions and prefix ranges.

6. **What variables are initialized immediately before the loop?**
   - Needed for initialization VC.
   - Examples: `i = 0`, `s = 0`, `lo = 0`, `hi = a.length - 1`, `m = a[0]`.

7. **Are ghost/old values needed?**
   - Needed for in-place mutation: `incrementAll`, `clampNegativeToZero`, `zeroEvenIndices`, `clear`, `reverse`.
   - Needed for field update: `addN` uses `\old(x)`.

8. **Which local variables, fields, and array cells are assigned?**
   - Locals: `i`, `s`, `lo`, `hi`, `mid`, `tmp`, `m`.
   - Field: `x`.
   - Array cells: `a[i]`, `dst[i]`, `a[lo]`, `a[hi]`.

9. **Which array cells are read?**
   - `a[i]`, `src[i]`, `a[lo]`, `a[hi]`, `a[mid]`, `a[0]`.

10. **Which variables/heap locations are read-only?**
    - Used to produce frame and unchanged facts.
    - Example: source array `src` is read-only in `copy`.

11. **Is there an accumulator? What kind?**
    - Additive array accumulator: `sum`.
    - Arithmetic-series accumulator: `triangular`.
    - Max accumulator: `max`.
    - Field linear accumulator: `x` in `addN`.

12. **Is the accumulator guarded?**
    - `sumNonNegative`: addition occurs only after checking nonnegative.
    - `binarySearch`: no arithmetic accumulator; branches modify bounds.

13. **Are there boolean/search prefix facts?**
    - `contains`, `indexOf`, `allNonNegative`, `firstEvenOrLength`, `binarySearch`.

14. **Are there early exits?**
    - `return` inside loop: `contains`, `indexOf`, `allNonNegative`, `binarySearch`.
    - `break`: `firstEvenOrLength`.
    - `throw`: `sumNonNegative`.
    - `continue`: `clampNegativeToZero`.

15. **What are the path conditions of early exits?**
    - `a[i] == x`, `a[i] < 0`, `a[i] % 2 == 0`, `a[mid] == x`.

16. **Is the loop mutating an existing array or constructing a fresh logical segment?**
    - Existing mutation: `fill`, `incrementAll`, `clampNegativeToZero`, `reverse`, `zeroEvenIndices`, `clear`.
    - Destination mutation: `copy`.

17. **Which segment is processed, and which segment is unprocessed?**
    - Prefix `[0, i)`.
    - Suffix `[i, length)`.
    - Two-frontier regions `[0, lo)`, `[lo, hi]`, `(hi, length)`.
    - Binary search excluded zones `[0, lo)`, `(hi, length)`.

18. **What old-state relation applies to mutated segments?**
    - `a[k] == \old(a[k]) + 1`.
    - `a[k] == 0` for filled/clamped cells.
    - `a[k] == \old(a[a.length - 1 - k])` for reverse.

19. **Are there helper calls?**
    - `incrementAllViaHelper` calls `incAt`.
    - The caller invariant depends on the callee’s `assignable` and `ensures` clauses.

20. **Are there semantic preconditions not inferable from the loop body alone?**
    - Sortedness for `binarySearch`.
    - Nonempty array for `max`.
    - No-overflow bounds for `sum`, `triangular`, `incrementAll`, `addN`, `sumNonNegative`, and helper-based increment.

21. **What is the candidate `decreases` expression?**
    - `n - i`, `a.length - i`, `src.length - i`, `hi - lo + 1`, `a.length - i` for stride-2 loops.

22. **What template candidates are triggered, and with what confidence?**
    - This is needed because a loop can trigger multiple templates: bounds + semantic prefix + frame + decreases.

23. **What validation obligations remain?**
    - Initialization, preservation, exit usefulness, frame soundness, termination, overflow/well-definedness.

## Revised `LoopSummary`

```haskell
data LoopKind
  = WhileCountingUp
  | WhileArrayScan
  | WhileAccumulator
  | WhileArrayMutation
  | WhileTwoFrontier
  | WhileBinarySearch
  | WhileHelperCall
  | WhileException
  | WhileStrided
  | ForCountingUp
  | UnknownLoop
  deriving (Eq, Show)

data CounterDirection
  = Increasing
  | Decreasing
  | ConditionalMovement
  | NotACounter
  deriving (Eq, Show)

data EarlyExitKind
  = ReturnExit
  | BreakExit
  | ContinueExit
  | ThrowExit
  deriving (Eq, Show)

data EarlyExitSummary expr = EarlyExitSummary
  { exitKind      :: EarlyExitKind
  , exitCondition :: expr
  , exitEffect    :: Maybe expr
  }

data ArrayAccessSummary expr = ArrayAccessSummary
  { arrayName     :: String
  , arrayIndex    :: expr
  , accessKind    :: AccessKind
  , writtenValue  :: Maybe expr
  }

data AccessKind = ArrayRead | ArrayWrite | ArrayReadWrite
  deriving (Eq, Show)

data AccumulatorKind
  = NoAccumulator
  | AdditiveAccumulator
  | ArithmeticSeriesAccumulator
  | MaxAccumulator
  | FieldLinearAccumulator
  | PredicatePrefixAccumulator
  deriving (Eq, Show)

data AccumulatorSummary expr = AccumulatorSummary
  { accName       :: String
  , accKind       :: AccumulatorKind
  , accInit       :: expr
  , accUpdate     :: expr
  , accGuard      :: Maybe expr
  , accDomain     :: Maybe expr
  }

data SegmentSummary expr
  = PrefixSegment { segArray :: String, segIndex :: String, segPredicate :: expr }
  | SuffixSegment { segArray :: String, segIndex :: String, segPredicate :: expr }
  | TwoFrontierSegments { leftIndex :: String, rightIndex :: String, segmentFact :: expr }
  | ExclusionZones { lowIndex :: String, highIndex :: String, leftFact :: expr, rightFact :: expr }

data HelperCallSummary expr = HelperCallSummary
  { calleeName        :: String
  , calleeArguments   :: [expr]
  , requiredFrame     :: [String]
  , requiredPostFacts :: [expr]
  }

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

This shape is deliberately richer than a bare symbolic state. It records the facts your template matcher needs before it emits invariant schemas.

---

# Mission 3 — revised `InvariantTemplate`

`to-be-tested-3.java` requires these template families:

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

## Mechanical algorithm: `LoopSummary -> [InvariantTemplate]`

```haskell
inferTemplates :: LoopSummary Expr -> [InvariantTemplate]
inferTemplates s = concat
  [ inferCounterTemplates s
  , inferStridedTemplates s
  , inferTwoFrontierTemplates s
  , inferPrefixOrSearchTemplates s
  , inferAccumulatorTemplates s
  , inferArrayMutationTemplates s
  , inferBinarySearchTemplates s
  , inferHelperCallTemplates s
  , inferEarlyExitTemplates s
  , inferFrameAndTerminationTemplates s
  ]
```

Concrete decision rules:

1. If there is a monotonic counter and a stable upper bound, emit `CounterBoundsTemplate` and `DecreasesTemplate`.
2. If the stride is not `1`, also emit `StridedCounterTemplate` with congruence facts such as `i % 2 == 0`.
3. If there is a read-only array scan and early return, emit either `SearchExclusionTemplate` or `BooleanPrefixPropertyTemplate` depending on the branch condition.
4. If a variable is updated as `acc += expr`, emit `ArraySumAccumulatorTemplate` or `ArithmeticSeriesAccumulatorTemplate` depending on whether `expr` is array-indexed or counter-indexed.
5. If an array cell is overwritten as `a[i] = value`, emit `ArrayFillTemplate` or `ConditionalArrayRewriteTemplate`.
6. If an array cell is transformed from its old value, emit `InPlaceTransformPrefixSuffixTemplate` and `UnprocessedSuffixUnchangedTemplate`.
7. If two indices move inward and swap symmetric cells, emit `TwoFrontierReverseTemplate`.
8. If two bounds `lo` and `hi` are narrowed based on sorted array comparisons, emit `BinarySearchExclusionTemplate`, but require an external sortedness precondition.
9. If a method call occurs in the loop body, emit `HelperCallLiftTemplate` only if the callee has a precise frame and postcondition.
10. Always emit `LoopFrameTemplate` from assigned locals/fields/array cells.
11. Always emit `DecreasesTemplate` when a well-founded variant is found.
12. Send every emitted template through validation: initialization, preservation, exit usefulness, frame, termination, and well-definedness.

---

# Mission 2/3/4/5 — method-by-method results

Each method entry gives:

- LoopSummary facts.
- InvariantTemplate candidates.
- Loop invariants/JML shape.
- Four proof needs: Safety, Postcondition, Frame, Termination.
- Inference pipeline: Input, Steps 1–6.
- Remaining work after template generation.

---

## 1. `idByLoop`

### LoopSummary

```text
loopKind: WhileCountingUp
initFacts: i = 0
counter: i
bounds: 0 <= i <= n
guard: i < n
step: i++
assignments: i
arrayAccesses: none
accumulators: none
earlyExits: none
needsPreconditions: 0 <= n for result == n
frameTargets: i
decreases: n - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, n)
LoopFrameTemplate([i])
DecreasesTemplate(n - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= n;
//@ loop_assigns i;
//@ decreases n - i;
```

### Four proof needs

- Safety: no array or dereference; only arithmetic progress.
- Postcondition: invariant plus `!(i < n)` gives `i == n`.
- Frame: only `i` changes inside the loop.
- Termination: `n - i` decreases by 1.

### Inference pipeline

- Input: CFG + symbolic state `i = 0`, guard `i < n`, postcondition `result == n`.
- Step 1: detect assigned variable `i`.
- Step 2: infer safety/bounds `0 <= i && i <= n`.
- Step 3: infer progress `i++`, decreases `n - i`.
- Step 4: no semantic accumulator needed.
- Step 5: frame is `i`.
- Step 6: validate initialization, preservation, and exit.

### Remaining work

The template is sufficient under `requires 0 <= n`. Without that precondition, the method needs a split spec: for `n < 0`, result is `0`, not `n`.

---

## 2. `contains`

### LoopSummary

```text
loopKind: WhileArrayScan
initFacts: i = 0
counter: i
guard: i < a.length
step: i++ on non-return path
assignments: i
arrayReads: a[i]
arrayWrites: none
earlyExits: return true when a[i] == x
semanticPrefixFact: forall k < i: a[k] != x
needsPreconditions: a != null
frameTargets: i
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
SearchExclusionTemplate(i, a[k] != x)
EarlyReturnTemplate(a[i] == x, true)
LoopFrameTemplate([i])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] != x);
//@ loop_assigns i;
//@ decreases a.length - i;
```

### Four proof needs

- Safety: `a != null` and `0 <= i < a.length` before `a[i]`.
- Postcondition: early return proves existence; normal exit proves no element equals `x`.
- Frame: only `i` changes.
- Termination: `a.length - i` decreases on non-return path.

### Inference pipeline

- Input: loop over `a`, target existential membership postcondition.
- Step 1: detect `i` as loop counter.
- Step 2: infer bounds from `a[i]` and guard.
- Step 3: infer `a.length - i`.
- Step 4: infer search exclusion over processed prefix.
- Step 5: frame is `i`.
- Step 6: validate early-return and false-exit cases.

### Remaining work

Template generation is sufficient. The validation layer must check the return path separately from the loop-exit path.

---

## 3. `indexOf`

### LoopSummary

```text
loopKind: WhileArrayScan
initFacts: i = 0
counter: i
guard: i < a.length
step: i++ on non-return path
assignments: i
arrayReads: a[i]
earlyExits: return i when a[i] == x
semanticPrefixFact: forall k < i: a[k] != x
needsPreconditions: a != null
frameTargets: i
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
SearchExclusionTemplate(i, a[k] != x)
EarlyReturnTemplate(a[i] == x, i)
LoopFrameTemplate([i])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] != x);
//@ loop_assigns i;
//@ decreases a.length - i;
```

### Four proof needs

- Safety: `a != null`, safe `a[i]` read.
- Postcondition: return path gives first match; exit gives `-1` and no match.
- Frame: only `i` changes.
- Termination: `a.length - i` decreases.

### Inference pipeline

- Input: loop and sentinel return `-1`.
- Step 1: detect `i`.
- Step 2: infer array bounds.
- Step 3: infer progress.
- Step 4: infer no-match prefix.
- Step 5: frame `i`.
- Step 6: validate first-index property from prefix exclusion.

### Remaining work

Template generation is enough. The validation phase must connect the early return value `i` to the prefix exclusion invariant.

---

## 4. `allNonNegative`

### LoopSummary

```text
loopKind: WhileArrayScan
initFacts: i = 0
counter: i
guard: i < a.length
step: i++ on non-return path
assignments: i
arrayReads: a[i]
earlyExits: return false when a[i] < 0
semanticPrefixFact: forall k < i: a[k] >= 0
needsPreconditions: a != null
frameTargets: i
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
BooleanPrefixPropertyTemplate(i, a[k] >= 0)
EarlyReturnTemplate(a[i] < 0, false)
LoopFrameTemplate([i])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] >= 0);
//@ loop_assigns i;
//@ decreases a.length - i;
```

### Four proof needs

- Safety: safe array dereference.
- Postcondition: early return disproves universal property; exit proves all elements nonnegative.
- Frame: only `i` changes.
- Termination: variant decreases.

### Inference pipeline

- Input: universal postcondition.
- Step 1: identify scan counter.
- Step 2: infer bounds.
- Step 3: infer `a.length - i`.
- Step 4: infer processed-prefix property.
- Step 5: loop frame `i`.
- Step 6: validate early false and final true cases.

### Remaining work

Template generation is sufficient.

---

## 5. `sum`

### LoopSummary

```text
loopKind: WhileAccumulator
initFacts: i = 0, s = 0
counter: i
guard: i < a.length
step: i++
assignments: i, s
arrayReads: a[i]
accumulator: s += a[i]
needsPreconditions: a != null, prefix sums within int range
frameTargets: i, s
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
ArraySumAccumulatorTemplate(s, a, i, a[k], None)
LoopFrameTemplate([i, s])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining s == (\sum int k; 0 <= k && k < i; a[k]);
//@ loop_assigns i, s;
//@ decreases a.length - i;
```

### Four proof needs

- Safety: `a != null`; safe `a[i]`; no overflow in `s += a[i]`.
- Postcondition: exit gives `i == a.length`, so prefix sum is whole-array sum.
- Frame: only `i` and `s` change.
- Termination: `a.length - i` decreases.

### Inference pipeline

- Input: postcondition sum over all elements.
- Step 1: detect `i`, `s`.
- Step 2: infer array bounds.
- Step 3: infer progress and variant.
- Step 4: generalize symbolic sequence `0`, `a[0]`, `a[0]+a[1]`, ... into `\sum`.
- Step 5: frame `i, s`.
- Step 6: validate accumulator preservation and overflow preconditions.

### Remaining work

The template is semantically sufficient, but the validator must generate or require no-overflow assumptions for every prefix sum.

---

## 6. `triangular`

### LoopSummary

```text
loopKind: WhileAccumulator
initFacts: i = 0, s = 0
counter: i
guard: i < n
step: i++
assignments: i, s
accumulator: s += i
needsPreconditions: 0 <= n, no overflow; chosen bound n <= 65536
frameTargets: i, s
decreases: n - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, n)
ArithmeticSeriesAccumulatorTemplate(s, i, i * (i - 1) / 2)
LoopFrameTemplate([i, s])
DecreasesTemplate(n - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= n;
//@ maintaining s == i * (i - 1) / 2;
//@ loop_assigns i, s;
//@ decreases n - i;
```

### Four proof needs

- Safety: no heap access; no overflow.
- Postcondition: exit yields `i == n`, hence `s == n*(n-1)/2`.
- Frame: only `i` and `s`.
- Termination: `n - i` decreases.

### Inference pipeline

- Input: arithmetic loop with `s += i`.
- Step 1: detect `i`, `s`.
- Step 2: infer `0 <= i <= n`.
- Step 3: infer progress and variant.
- Step 4: recognize arithmetic series closed form.
- Step 5: frame `i, s`.
- Step 6: validate algebraic preservation.

### Remaining work

The hard part is recognizing or supplying the closed form. Without an arithmetic-series template, your tool can emit a `\sum` invariant instead: `s == (\sum int k; 0 <= k && k < i; k)`.

---

## 7. `fill`

### LoopSummary

```text
loopKind: WhileArrayMutation
initFacts: i = 0
counter: i
guard: i < a.length
step: i++
assignments: i, a[i]
arrayWrites: a[i] = v
semanticSegment: prefix filled with v, suffix unchanged
needsPreconditions: a != null
frameTargets: i, a[*]
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
ArrayFillTemplate(a, i, v)
UnprocessedSuffixUnchangedTemplate(a, i)
LoopFrameTemplate([i, a[*]])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == v);
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
//@ loop_assigns i, a[*];
//@ decreases a.length - i;
```

### Four proof needs

- Safety: `a != null`, valid write index.
- Postcondition: after exit, filled prefix is whole array.
- Frame: `a[*]` and `i`.
- Termination: variant decreases.

### Inference pipeline

- Input: assignment `a[i] = v` in monotone scan.
- Step 1: detect `i`.
- Step 2: infer bounds.
- Step 3: infer variant.
- Step 4: infer prefix fill and suffix unchanged.
- Step 5: loop frame includes `a[*]`.
- Step 6: validate preservation after writing `a[i]` and incrementing `i`.

### Remaining work

Template generation is sufficient.

---

## 8. `copy`

### LoopSummary

```text
loopKind: WhileArrayMutation
initFacts: i = 0
counter: i
guard: i < src.length
step: i++
assignments: i, dst[i]
arrayReads: src[i]
arrayWrites: dst[i] = src[i]
semanticSegment: dst prefix equals old src prefix; source unchanged
needsPreconditions: src != null, dst != null, src.length <= dst.length
frameTargets: i, dst[0..src.length-1]
decreases: src.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, src.length)
ArrayCopyPrefixTemplate(src, dst, i, k, k)
SourceUnchangedTemplate(src)
UnprocessedSuffixUnchangedTemplate(dst, i)
LoopFrameTemplate([i, dst[0..src.length-1]])
DecreasesTemplate(src.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= src.length;
//@ maintaining (\forall int k; 0 <= k && k < i; dst[k] == \old(src[k]));
//@ maintaining (\forall int k; i <= k && k < src.length; dst[k] == \old(dst[k]));
//@ maintaining (\forall int k; 0 <= k && k < src.length; src[k] == \old(src[k]));
//@ loop_assigns i, dst[0 .. src.length - 1];
//@ decreases src.length - i;
```

### Four proof needs

- Safety: non-null arrays and `src.length <= dst.length`.
- Postcondition: copied prefix becomes whole `src` range.
- Frame: destination segment changes; source remains unchanged.
- Termination: `src.length - i`.

### Inference pipeline

- Input: `dst[i] = src[i]`.
- Step 1: detect `i`.
- Step 2: infer source and destination bounds.
- Step 3: infer variant.
- Step 4: infer copy prefix and source unchanged.
- Step 5: frame destination range.
- Step 6: validate with aliasing. Same-array alias is harmless for this exact pattern, but more general aliasing needs care.

### Remaining work

Your validator should either prove same-array aliasing is harmless here or conservatively require `src != dst` for simpler verification.

---

## 9. `incrementAll`

### LoopSummary

```text
loopKind: WhileArrayMutation
initFacts: i = 0
counter: i
guard: i < a.length
step: i++
assignments: i, a[i]
arrayReadWrite: a[i] = a[i] + 1
semanticSegment: prefix old+1, suffix unchanged
needsPreconditions: a != null, all a[k] < Integer.MAX_VALUE
frameTargets: i, a[*]
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
InPlaceTransformPrefixSuffixTemplate(a, i, old(a[k]) + 1)
UnprocessedSuffixUnchangedTemplate(a, i)
LoopFrameTemplate([i, a[*]])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == \old(a[k]) + 1);
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
//@ loop_assigns i, a[*];
//@ decreases a.length - i;
```

### Four proof needs

- Safety: valid array access and no overflow.
- Postcondition: processed prefix covers whole array at exit.
- Frame: `a[*]` and `i`.
- Termination: `a.length - i`.

### Inference pipeline

- Input: read/write same cell `a[i]`.
- Step 1: detect counter.
- Step 2: infer bounds.
- Step 3: infer variant.
- Step 4: infer old-state transform.
- Step 5: frame array.
- Step 6: validate transform preservation.

### Remaining work

Overflow preconditions must be generated for every cell.

---

## 10. `clampNegativeToZero`

### LoopSummary

```text
loopKind: WhileArrayMutation with continue
initFacts: i = 0
counter: i
guard: i < a.length
step: i++ on both paths
assignments: i, optionally a[i]
arrayReadWrite: read a[i], write a[i] = 0 when a[i] < 0
continue: condition a[i] >= 0
semanticSegment: prefix is max(old(a[k]), 0), suffix unchanged
needsPreconditions: a != null
frameTargets: i, a[*]
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
ConditionalArrayRewriteTemplate(a, i, [(old(a[k]) >= 0, old(a[k])), (old(a[k]) < 0, 0)])
ContinuePathTemplate(a[i] >= 0, [...])
UnprocessedSuffixUnchangedTemplate(a, i)
LoopFrameTemplate([i, a[*]])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] >= 0);
//@ maintaining (\forall int k; 0 <= k && k < i; \old(a[k]) >= 0 ==> a[k] == \old(a[k]));
//@ maintaining (\forall int k; 0 <= k && k < i; \old(a[k]) < 0 ==> a[k] == 0);
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
//@ loop_assigns i, a[*];
//@ decreases a.length - i;
```

### Four proof needs

- Safety: valid read and conditional write.
- Postcondition: prefix characterization becomes whole-array characterization at exit.
- Frame: `a[*]` and `i`.
- Termination: both continue and non-continue paths increment `i`.

### Inference pipeline

- Input: conditional mutation with `continue`.
- Step 1: detect counter and both update paths.
- Step 2: infer bounds.
- Step 3: infer progress for both paths.
- Step 4: infer path-sensitive mutation summary.
- Step 5: frame array.
- Step 6: validate both paths preserve the same invariant.

### Remaining work

The template is sufficient, but the validator must be path-sensitive; a path-insensitive checker could miss that `i++` happens before `continue`.

---

## 11. `firstEvenOrLength`

### LoopSummary

```text
loopKind: WhileArrayScan with break
initFacts: i = 0
counter: i
guard: i < a.length
step: i++ on non-break path
assignments: i
arrayReads: a[i]
break: a[i] % 2 == 0
semanticPrefixFact: forall k < i: a[k] is odd
needsPreconditions: a != null
frameTargets: i
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
PrefixPropertyTemplate(i, a[k] % 2 != 0)
BreakExitTemplate(a[i] % 2 == 0)
LoopFrameTemplate([i])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] % 2 != 0);
//@ loop_assigns i;
//@ decreases a.length - i;
```

### Four proof needs

- Safety: safe array read.
- Postcondition: either exit by guard with result length, or break with even element at result.
- Frame: only `i`.
- Termination: `a.length - i` on non-break path.

### Inference pipeline

- Input: scan with break.
- Step 1: detect `i`.
- Step 2: infer bounds.
- Step 3: infer variant.
- Step 4: infer odd prefix and break condition.
- Step 5: frame `i`.
- Step 6: validate both exit modes.

### Remaining work

The postcondition must explicitly model both loop-exit reasons. The template alone gives the invariant but not the disjunctive postcondition unless the break condition is recorded.

---

## 12. `reverse`

### LoopSummary

```text
loopKind: WhileTwoFrontier
initFacts: lo = 0, hi = a.length - 1
counters: lo increasing, hi decreasing
guard: lo < hi
step: lo++, hi--
assignments: lo, hi, tmp, a[lo], a[hi]
arrayReads: a[lo], a[hi]
arrayWrites: a[lo], a[hi]
semanticSegments: left and right processed zones reversed; middle unchanged
needsPreconditions: a != null
frameTargets: lo, hi, tmp, a[*]
decreases: hi - lo + 1
```

### Templates

```text
TwoFrontierBoundsTemplate(lo, hi, lo + hi == a.length - 1)
TwoFrontierReverseTemplate(a, lo, hi)
UnprocessedMiddleUnchangedTemplate(a, lo, hi)
LoopFrameTemplate([lo, hi, tmp, a[*]])
DecreasesTemplate(hi - lo + 1)
```

### Invariants

```java
//@ maintaining 0 <= lo && lo <= a.length;
//@ maintaining -1 <= hi && hi < a.length;
//@ maintaining lo <= hi + 1;
//@ maintaining lo + hi == a.length - 1;
//@ maintaining (\forall int k; 0 <= k && k < lo; a[k] == \old(a[a.length - 1 - k]));
//@ maintaining (\forall int k; hi < k && k < a.length; a[k] == \old(a[a.length - 1 - k]));
//@ maintaining (\forall int k; lo <= k && k <= hi; a[k] == \old(a[k]));
//@ loop_assigns lo, hi, tmp, a[*];
//@ decreases hi - lo + 1;
```

### Four proof needs

- Safety: `lo` and `hi` in bounds when guard holds.
- Postcondition: when `lo >= hi`, left/right processed zones cover all relevant indices.
- Frame: array cells and loop locals.
- Termination: distance `hi - lo + 1` decreases by 2.

### Inference pipeline

- Input: symmetric swap loop.
- Step 1: detect two moving counters.
- Step 2: infer two-frontier bounds.
- Step 3: infer relation `lo + hi == a.length - 1` and variant.
- Step 4: infer processed segment reversal relation.
- Step 5: frame array and locals.
- Step 6: validate after swap and counter movement.

### Remaining work

The template is domain-specific. A generic prefix template will not infer this. Your tool needs a dedicated symmetric-swap recognizer.

---

## 13. `binarySearch`

### LoopSummary

```text
loopKind: WhileBinarySearch
initFacts: lo = 0, hi = a.length - 1
counters: lo and hi are conditional bounds
guard: lo <= hi
updates: lo = mid + 1 or hi = mid - 1
arrayReads: a[mid]
earlyReturn: return mid if a[mid] == x
semanticZones: all k < lo have a[k] < x; all k > hi have a[k] > x
needsPreconditions: a != null, array sorted nondecreasing
frameTargets: lo, hi, mid
decreases: hi - lo + 1
```

### Templates

```text
BinarySearchExclusionTemplate(a, lo, hi, x)
CounterBoundsTemplate(lo, 0, a.length)
CounterBoundsTemplate(hi, -1, a.length - 1)
EarlyReturnTemplate(a[mid] == x, mid)
LoopFrameTemplate([lo, hi, mid])
DecreasesTemplate(hi - lo + 1)
```

### Invariants

```java
//@ maintaining 0 <= lo && lo <= a.length;
//@ maintaining -1 <= hi && hi < a.length;
//@ maintaining lo <= hi + 1;
//@ maintaining (\forall int k; 0 <= k && k < lo; a[k] < x);
//@ maintaining (\forall int k; hi < k && k < a.length; a[k] > x);
//@ loop_assigns lo, hi, mid;
//@ decreases hi - lo + 1;
```

### Four proof needs

- Safety: `mid` in range when `lo <= hi`.
- Postcondition: return path gives a match; exit with exclusion zones gives no match.
- Frame: `lo`, `hi`, `mid`.
- Termination: each branch strictly shrinks the interval.

### Inference pipeline

- Input: sorted-array search loop.
- Step 1: detect interval bounds `lo`, `hi`.
- Step 2: infer bounds and `mid` safety.
- Step 3: infer interval shrinkage.
- Step 4: infer exclusion zones from sortedness and branch comparisons.
- Step 5: frame locals.
- Step 6: validate return and no-match exit.

### Remaining work

This cannot be inferred soundly without a sortedness precondition. The template generator must mark `needsSortedness = True` and either require a sortedness precondition or weaken the postcondition.

---

## 14. `addN`

### LoopSummary

```text
loopKind: WhileFieldAccumulator
initFacts: i = 0
counter: i
guard: i < n
step: i++
assignments: i, field x
accumulator: x++
semanticFact: x == old(x) + i
needsPreconditions: 0 <= n, x + n <= Integer.MAX_VALUE
frameTargets: i, x
decreases: n - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, n)
FieldLinearAccumulatorTemplate(x, i, old(x))
LoopFrameTemplate([i, x])
DecreasesTemplate(n - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= n;
//@ maintaining x == \old(x) + i;
//@ loop_assigns i, x;
//@ decreases n - i;
```

### Four proof needs

- Safety: no heap-array safety; arithmetic overflow must be ruled out.
- Postcondition: exit gives `i == n`, so `x == old(x)+n`.
- Frame: only field `x` and local `i`.
- Termination: `n - i`.

### Inference pipeline

- Input: field update loop.
- Step 1: detect `i` and field assignment `x++`.
- Step 2: infer counter bounds.
- Step 3: infer progress.
- Step 4: infer field-linear accumulator.
- Step 5: frame includes field `x`.
- Step 6: validate preservation and overflow bound.

### Remaining work

Your tool must distinguish object fields from locals and generate method-level `assignable x;` plus loop-level `loop_assigns i, x;`.

---

## 15. `incAt`

### LoopSummary

```text
no loop
helperEffect: a[i] becomes old(a[i]) + 1; all other cells unchanged
needsPreconditions: a != null, 0 <= i < a.length, a[i] < Integer.MAX_VALUE
frameTargets: a[i]
```

### Templates

```text
No loop templates.
This method supplies a HelperCallLiftTemplate dependency for incrementAllViaHelper.
```

### Invariants

No loop invariant is needed.

### Four proof needs

- Safety: valid index and non-null array.
- Postcondition: one cell increments.
- Frame: exactly `a[i]`.
- Termination: no loop.

### Inference pipeline

- Input: straight-line assignment.
- Step 1: no loop variables.
- Step 2: infer array safety preconditions.
- Step 3: no progress invariant.
- Step 4: infer cell transform.
- Step 5: frame `a[i]`.
- Step 6: validate by assignment rule.

### Remaining work

This helper must be available in the callee-spec environment before processing `incrementAllViaHelper`.

---

## 16. `incrementAllViaHelper`

### LoopSummary

```text
loopKind: WhileHelperCall
initFacts: i = 0
counter: i
guard: i < a.length
step: i++
assignments: i; a[i] through incAt(a, i)
helperCalls: incAt(a, i)
semanticFact: prefix old+1, suffix unchanged
needsPreconditions: a != null, all cells < Integer.MAX_VALUE
frameTargets: i, a[*]
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
HelperCallLiftTemplate(incAt, [a[i] == old(a[i]) + 1, others unchanged])
InPlaceTransformPrefixSuffixTemplate(a, i, old(a[k]) + 1)
UnprocessedSuffixUnchangedTemplate(a, i)
LoopFrameTemplate([i, a[*]])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == \old(a[k]) + 1);
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
//@ loop_assigns i, a[*];
//@ decreases a.length - i;
```

### Four proof needs

- Safety: `incAt` preconditions must hold at every iteration.
- Postcondition: prefix transform covers whole array.
- Frame: helper may only modify `a[i]`; loop frame is `a[*]`.
- Termination: `a.length - i`.

### Inference pipeline

- Input: loop with helper call.
- Step 1: detect counter and call.
- Step 2: use callee requires for safety.
- Step 3: infer progress.
- Step 4: lift callee postcondition to prefix invariant.
- Step 5: combine callee frame into loop frame.
- Step 6: validate preservation using callee spec, not body inlining.

### Remaining work

Without the `incAt` specification, your tool should not infer the strong prefix transform. It should either inline the helper body or fall back to a weak frame-only invariant.

---

## 17. `sumNonNegative`

### LoopSummary

```text
loopKind: WhileException
initFacts: i = 0, s = 0
counter: i
guard: i < a.length
step: i++ on non-throw path
assignments: i, s
arrayReads: a[i]
throwExit: a[i] < 0 -> IllegalArgumentException
accumulator: s += a[i] after nonnegative check
semanticFact: processed prefix nonnegative and summed
needsPreconditions: a != null, no overflow for normal behavior
frameTargets: i, s
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
ExceptionExitTemplate(IllegalArgumentException, a[i] < 0)
PrefixPropertyTemplate(i, a[k] >= 0)
ArraySumAccumulatorTemplate(s, a, i, a[k], a[k] >= 0)
LoopFrameTemplate([i, s])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] >= 0);
//@ maintaining s == (\sum int k; 0 <= k && k < i; a[k]);
//@ loop_assigns i, s;
//@ decreases a.length - i;
```

### Four proof needs

- Safety: safe array access; normal path no overflow.
- Postcondition: normal exit sums all elements; exceptional exit has a first negative witness.
- Frame: only locals change.
- Termination: non-throw path increments `i`.

### Inference pipeline

- Input: loop with throw and sum.
- Step 1: detect `i`, `s`, throw condition.
- Step 2: infer safety bounds.
- Step 3: infer variant on non-throw path.
- Step 4: infer nonnegative prefix and sum prefix.
- Step 5: frame locals.
- Step 6: validate normal and exceptional spec cases.

### Remaining work

The validator must distinguish normal and exceptional behavior. The normal postcondition needs overflow preconditions; the exceptional spec does not need a result postcondition.

---

## 18. `zeroEvenIndices`

### LoopSummary

```text
loopKind: WhileStrided
initFacts: i = 0
counter: i
guard: i < a.length
step: i += 2
stride: 2
congruence: i % 2 == 0
assignments: i, a[i]
arrayWrites: a[i] = 0
semanticFact: processed even cells are zero; odd cells unchanged; suffix unchanged
needsPreconditions: a != null
frameTargets: i, a[*]
decreases: a.length - i
```

### Templates

```text
StridedCounterTemplate(i, 0, a.length + 1, 2, i % 2 == 0)
StridedArrayFillTemplate(a, i, 0, even indices)
OddIndexUnchangedTemplate(a)
UnprocessedSuffixUnchangedTemplate(a, i)
LoopFrameTemplate([i, a[*]])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length + 1;
//@ maintaining i % 2 == 0;
//@ maintaining (\forall int k; 0 <= k && k < i && k < a.length && k % 2 == 0; a[k] == 0);
//@ maintaining (\forall int k; 0 <= k && k < a.length && k % 2 != 0; a[k] == \old(a[k]));
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
//@ loop_assigns i, a[*];
//@ decreases a.length - i;
```

### Four proof needs

- Safety: write index valid when guard holds.
- Postcondition: all even indices are processed at exit; odds unchanged.
- Frame: array and `i`.
- Termination: `a.length - i` decreases by 2 while guard holds.

### Inference pipeline

- Input: `i += 2` and `a[i] = 0`.
- Step 1: detect strided counter.
- Step 2: infer widened upper bound `a.length + 1` and congruence.
- Step 3: infer variant.
- Step 4: infer even-index prefix fill and odd unchanged.
- Step 5: frame array.
- Step 6: validate last iteration for odd/even length arrays.

### Remaining work

Strided loops need special bounds. A naive `i <= a.length` invariant is not inductive for odd-length arrays after the final `i += 2`.

---

## 19. `clear`

### LoopSummary

```text
loopKind: ForCountingUp normalized to while
initFacts: i = 0 in for header
counter: i
guard: i < a.length
step: i++
assignments: i, a[i]
arrayWrites: a[i] = 0
semanticFact: prefix zero, suffix unchanged
needsPreconditions: a != null
frameTargets: i, a[*]
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 0, a.length)
ArrayFillTemplate(a, i, 0)
UnprocessedSuffixUnchangedTemplate(a, i)
LoopFrameTemplate([i, a[*]])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == 0);
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
//@ loop_assigns i, a[*];
//@ decreases a.length - i;
```

### Four proof needs

- Safety: valid write index.
- Postcondition: processed prefix covers all array cells after exit.
- Frame: array cells and `i`.
- Termination: `a.length - i`.

### Inference pipeline

- Input: `for` loop.
- Step 1: normalize to `i = 0; while (i < a.length) { body; i++; }`.
- Step 2: infer bounds.
- Step 3: infer progress.
- Step 4: infer fill-zero prefix.
- Step 5: frame array.
- Step 6: validate preservation.

### Remaining work

No special remaining work beyond standard validation.

---

## 20. `max`

### LoopSummary

```text
loopKind: WhileArrayScan with extremum accumulator
initFacts: i = 1, m = a[0]
counter: i
guard: i < a.length
step: i++
assignments: i, m conditionally
arrayReads: a[0], a[i]
accumulator: m = max of processed prefix
semanticFact: exists k < i: m == a[k]; forall k < i: a[k] <= m
needsPreconditions: a != null, a.length > 0
frameTargets: i, m
decreases: a.length - i
```

### Templates

```text
CounterBoundsTemplate(i, 1, a.length)
MaxScanTemplate(m, a, i)
LoopFrameTemplate([i, m])
DecreasesTemplate(a.length - i)
```

### Invariants

```java
//@ maintaining 1 <= i && i <= a.length;
//@ maintaining (\exists int k; 0 <= k && k < i; m == a[k]);
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] <= m);
//@ loop_assigns i, m;
//@ decreases a.length - i;
```

### Four proof needs

- Safety: `a[0]` requires nonempty array; `a[i]` safe under guard.
- Postcondition: exit makes processed prefix the whole array.
- Frame: only locals `i`, `m`.
- Termination: `a.length - i`.

### Inference pipeline

- Input: initialization from `a[0]`, conditional max update.
- Step 1: detect counter and max accumulator.
- Step 2: infer safety and nonempty precondition.
- Step 3: infer progress.
- Step 4: infer extremum invariant: membership + upper-bound property.
- Step 5: frame locals.
- Step 6: validate both branch paths.

### Remaining work

The max template is sufficient. The important requirement is detecting initialization at `i = 1, m = a[0]`; the invariant does not start at `i = 0`.

---

# Mission 5 — what remains after templates are generated?

The generated templates are not the end of the pipeline. They are candidate annotations. After `LoopSummary -> InvariantTemplate`, your tool still needs these phases:

1. **Instantiate JML expressions** from templates.
   - Convert each template into concrete `maintaining`, `loop_assigns`, and `decreases` clauses.

2. **Well-definedness check.**
   - Ensure every generated expression is legal: non-null arrays, bounded quantifiers, safe indexes, no division-by-zero, no ill-defined `a[0]` when empty.

3. **Initialization VC.**
   - Prove the invariant holds before the first iteration.

4. **Preservation VC.**
   - Symbolically execute one loop body from `invariant && guard` and prove the invariant holds again.

5. **Exit-usefulness VC.**
   - Prove `invariant && !guard` implies the needed postcondition.
   - For early exits, prove each return/break/throw path separately.

6. **Frame validation.**
   - Check that `loop_assigns` covers every modified local/field/array cell.
   - Check method-level `assignable` covers loop writes that escape.

7. **Arithmetic/overflow validation.**
   - Generate preconditions or weaken mathematical specs when Java overflow is possible.

8. **Callee-spec lookup.**
   - For `incrementAllViaHelper`, load the `incAt` spec before synthesizing the caller invariant.

9. **Domain-precondition synthesis.**
   - `binarySearch` needs sortedness.
   - `max` needs nonempty array.
   - array loops need non-null arrays.

10. **Fallback/weakening strategy.**
    - If a semantic template fails validation, keep bounds/frame/decreases and drop the stronger semantic invariant.

Per-method classification:

| Method | Are templates enough to print plausible invariants? | Additional work before trusting them |
|---|---:|---|
| `idByLoop` | Yes | Require `0 <= n` or split negative case. |
| `contains` | Yes | Validate early return and false-exit postcondition. |
| `indexOf` | Yes | Validate first-index property. |
| `allNonNegative` | Yes | Validate false-return path. |
| `sum` | Mostly | Generate no-overflow prefix-sum preconditions. |
| `triangular` | Mostly | Recognize closed form or emit `\sum`; require no-overflow bound. |
| `fill` | Yes | Standard prefix/suffix validation. |
| `copy` | Mostly | Handle aliasing or require alias separation if verifier struggles. |
| `incrementAll` | Mostly | Generate no-overflow preconditions. |
| `clampNegativeToZero` | Yes | Need path-sensitive validation for `continue`. |
| `firstEvenOrLength` | Yes | Need explicit break-exit postcondition. |
| `reverse` | Mostly | Needs dedicated two-frontier/symmetric-swap template. |
| `binarySearch` | Mostly | Needs sortedness precondition and interval-exclusion reasoning. |
| `addN` | Mostly | Need field-frame handling and overflow precondition. |
| `incAt` | No loop | Needed as callee contract. |
| `incrementAllViaHelper` | Only if callee spec is known | Use `incAt` frame/postcondition or inline helper. |
| `sumNonNegative` | Mostly | Split normal/exceptional behavior; overflow only for normal case. |
| `zeroEvenIndices` | Mostly | Need strided-loop bounds and congruence. |
| `clear` | Yes | Standard for-loop normalization. |
| `max` | Yes | Require nonempty array and start bound at `i = 1`. |

The important architectural conclusion is: **templates produce candidate loop annotations; they do not by themselves prove correctness.** The next layer is the validation layer: generate VCs using the Hoare/VCG obligations and keep only candidates that are initialized, preserved, useful on exit, frame-sound, terminating, and well-defined.
