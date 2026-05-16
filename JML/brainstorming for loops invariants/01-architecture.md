# The Lecture

1) The lecture is excellent for defining the correctness obligations: initialization, preservation, and exit.

2) The lecture gives me the needed theorem prover. But it doesn't generate the needed invariants. This means the lecture is not the starting point.

3) The while rule says that a loop invariant must be preserved by one loop iteration and combined with the negated guard after the loop.

4) A **VCG**, or verification-condition generator, usually does not discover the invariant. It assumes the invariant is already there, then generates logical obligations.

5) <u>**annotated invariants or synthesized approximations are needed**</u>, because loops cannot generally be handled by naive recursive WP computation.

6) The lecture’s theory can be used to know **what must be proven**, then use program-pattern recognition to generate likely invariants.

7) The lecture gives the proof model: for a loop, we need an invariant `ϕ` such that executing the loop body from `ϕ && condition` re-establishes `ϕ`; after the loop, `ϕ && !condition` must imply the desired postcondition. That is exactly the Hoare while rule shown in the lecture.

8) The invariant is the approximate weakest precondition of the loop.
   
   1) after the loop invariant is supplied, the VCG produces obligations for entering the loop, executing the loop, and skipping/exiting the loop.
   
   2) see the factorial example on page 17 in the lecture 11.

9) iteration relies on loop invariants. These invariants get synthesized by my haskell-software. Iteration then gets annotated, then VCG reduces correctness to validity of verification conditions. Example:
   
   ```java
   public int sum4(int n) {
     int res = 0;
     for(; n > 0;) {
       res += n;
       n--;
     }
     return res;
   }
   ```

   A useful annotated version would introduce a ghost copy of the initial `n`:

```java
/*@ normal_behavior
  @   requires n >= 0;
  @   assignable \nothing;
  @   ensures \result == \old(n) * (\old(n) + 1) / 2;
  @*/
public int sum4(int n) {
  //@ ghost int n0 = n;
  int res = 0;

  /*@ maintaining 0 <= n && n <= n0;
    @ maintaining res + n * (n + 1) / 2 == n0 * (n0 + 1) / 2;
    @ loop_assigns n, res;
    @ decreases n;
    @*/
  for(; n > 0;) {
    res += n;
    n--;
  }

  return res;
}
```

Now the VCG generates roughly these obligations.

### VC 1: initialization

Before the loop:

```java
n0 == n
res == 0
n >= 0
```

### Need to prove:

```java
0 <= n && n <= n0
res + n * (n + 1) / 2 == n0 * (n0 + 1) / 2
```

### VC 2: preservation

Assume at loop head:

```java
0 <= n && n <= n0
res + n * (n + 1) / 2 == n0 * (n0 + 1) / 2
n > 0
```

Execute:

```java
res = res + n;
n = n - 1;
```

Need to prove the invariant again:

```java
res + n * (n + 1) / 2 == n0 * (n0 + 1) / 2
```

but using the new values of `res` and `n`.

The arithmetic is:

```
newRes + newN * (newN + 1) / 2
= (oldRes + oldN) + (oldN - 1) * oldN / 2
= oldRes + oldN * (oldN + 1) / 2
= n0 * (n0 + 1) / 2
```

So preservation holds.

### VC 3: exit implies postcondition

After the loop:

```java
invariant && !(n > 0)
```

So:

```java
0 <= n && n <= n0
res + n * (n + 1) / 2 == n0 * (n0 + 1) / 2
n <= 0
```

From `0 <= n` and `n <= 0`, we get:

```java
n == 0
```

Therefore:

```java
res == n0 * (n0 + 1) / 2
```

which proves the method postcondition.

That is what I mean by “VCG works once the right annotations are present”: the hard creative step is the invariant. Once the invariant is there, the rest is mostly systematic proof-obligation generation.

---

# To-Build

1. An invariant-synthesis layer

2. A validation layer layer

These layers takes Symbolic Expression as input

3. Generate invariant templates, such as:

```java
// counter bounds
maintaining 0 <= i && i <= arr.length;

// processed-prefix array copy
maintaining (\forall int k; 0 <= k && k < i; copy[k] == arr[k]);

// numeric accumulator
maintaining sum == (\sum int k; 0 <= k && k < i; nums[k]);

// guarded accumulator
maintaining sum == (\sum int k; 0 <= k && k < i && nums[k] % 2 != 0; nums[k]);

// max scan
maintaining (\exists int k; 0 <= k && k < i; max == arr[k]);
maintaining (\forall int k; 0 <= k && k < i; arr[k] <= max);
```

---

# Planning

1. The lecture’s theory can be used to know **what must be proven**, then use program-pattern recognition to generate likely invariants.

2. Then use program-pattern recognition to generate likely invariants.

---

# Template-based synthesis

A **template** is a reusable invariant shape with holes.

Example:

```java
public int[] fillArray(int size, int elem) {
  int[] arr = new int[size];
  for(int i=0; i<size; i++) {
    arr[i] = elem;
  }
  return arr;
}
```

The generator should recognize:

```java
for (int i = 0; i < bound; i++) {
    arr[i] = value;
}
```

then instantiate the **array-fill template**:

```java
//@ maintaining 0 <= i && i <= size;
//@ maintaining arr.length == size;
//@ maintaining (\forall int k; 0 <= k && k < i; arr[k] == elem);
//@ loop_assigns i, arr[*];
//@ decreases size - i;
```

The template is not derived from theorem proving (the lecture). It is a rule (a synthesis) you encode:

```haskell
ArrayFillTemplate:
  if loop counter i starts at 0
  and guard is i < bound
  and step is i++
  and body contains arr[i] = value
  then generate:
    0 <= i <= bound
    forall k in [0, i): arr[k] == value
    loop_assigns i, arr[*]
    decreases bound - i
```

This is “synthesis” because your tool **creates** the invariant automatically. It is “template-based” because it creates it from known invariant schemas, not from unconstrained logical search. TODO: what is meant with (invariant schemas) vs (unconstrained logical search)?



Symbolic execution gives you expressions like:

```
i starts at 0
condition: i < size
body effect: arr[i] becomes elem
step: i becomes i + 1
```

**<u>symbolic execution</u>** helps you validate the candidate invariant:

1. Before one iteration:

```java
0 <= i && i < size
(\forall int k; 0 <= k && k < i; arr[k] == elem)
```

2. Body:
   
   ```java
   arr[i] = elem;
   i++;
   ```

3. After the step, new `i` is old `i + 1`.

So the invariant becomes:

```java
(\forall int k; 0 <= k && k < old_i + 1; arr[k] == elem)
```

That is symbolic execution doing the “one-step preservation” check.

---

# Dataflow

The template depends on dataflow facts. Without dataflow, you would not know that accumulators, the counters, and the conditions which re-assign the accumulators.

Example:

```java
public int sumOddNums(int[] nums) {
  int sum = 0;
  for (int i=0; i<nums.length; i++) {
      if (nums[i] % 2 == 0) {
          continue;
      }
      sum += nums[i];
  }
  return sum;
}
```

Without dataflow, you would not know that `sum` is the accumulator, `i` is the counter, and `nums[i] % 2 != 0` is the condition under which the addition happens.

lightweight dataflow of `sumOddNums` finds:

```
counter: i
initial: i = 0
guard: i < nums.length
step: i++
assigned variables: i, sum
array reads: nums[i]
continue exists
accumulator: sum
accumulator update guarded by nums[i] % 2 != 0
```

Lightweight dataflow is simple static analysis over the loop. It answers questions like:

```
Which variables are initialized before the loop?
Which variables are assigned inside the loop?
Which variable is the loop counter?
Is the counter increasing or decreasing?
Which array cells are written?
Which variables are accumulators?
Which variables are only read?
Does the loop have break or continue?
```

TODO: gather all possible questions for all possible methods

Then your template generator can choose a **guarded-sum template**:

```
//@ maintaining nums != null;
//@ maintaining 0 <= i && i <= nums.length;
//@ maintaining sum == (\sum int k; 0 <= k && k < i && nums[k] % 2 != 0; nums[k]);
//@ loop_assigns i, sum;
//@ decreases nums.length - i;
```

```haskell
data LoopSummary = LoopSummary
  { loopCounter      :: Maybe String
  , loopInit         :: Maybe SYT.SymbolicExecutionValue
  , loopGuard        :: Maybe SYT.SymbolicExecutionValue
  , loopStep         :: Maybe SYT.SymbolicExecutionValue
  , loopAssignments  :: [(String, SYT.SymbolicExecutionValue)]
  , loopArrayWrites  :: [(String, SYT.SymbolicExecutionValue, SYT.SymbolicExecutionValue)]
  , loopArrayReads   :: [(String, SYT.SymbolicExecutionValue)]
  , loopHasBreak     :: Bool
  , loopHasContinue  :: Bool
  }

data InvariantTemplate
  = CounterBounds
  | NumericAccumulator
  | GuardedNumericAccumulator
  | ArrayFill
  | ArrayCopyPrefix
  | MaxScan
  | BooleanPrefixProperty
  | TwoCounterCopySkip
```

Then:

```haskell
inferLoopInvariants :: LoopSummary -> [JML.Expr]
inferLoopInvariants loop =
  concat
    [ tryCounterBounds loop
    , tryAccumulator loop
    , tryArrayFill loop
    , tryArrayCopy loop
    , tryMaxScan loop
    , tryBreakContinueFacts loop
    ]
```

But crucially, do not directly trust every generated invariant. Add a validation phase:

```haskell
validateInvariant :: LoopSummary -> JML.Expr -> Bool
validateInvariant loop inv =
  initializationLikelyHolds loop inv
  && preservationLikelyHolds loop inv
  && wellDefinedInLoop loop inv
```

For the first implementation, `validateInvariant` can be syntactic and conservative. Later, you can send the generated VCs to an SMT solver or OpenJML.

---

# Why this is better than pure backward induction

1. Backward induction works beautifully for straight-line code, and the lecture’s swap example demonstrates that weakest preconditions can be computed automatically over assignments, sequencing, and conditionals. But loops are different because the weakest precondition equation for `while` refers to itself recursively, which the lecture explicitly marks as the automation problem.

2. So for loops, the right practical approach is:
   
   1. `Use backward reasoning to know what must be proven.`
   
   2. Use templates/dataflow/symbolic execution to guess an invariant.
   
   3. `Use VCG/OpenJML/SMT to check whether the guessed invariant is actually valid.`
   
   That gives you a realistic pipeline:
   
   ```
   Java method
     -> CFG
     -> symbolic execution summary
     -> loop dataflow summary
     -> invariant template matching
     -> candidate JML invariants
     -> VCG/OpenJML verification
     -> keep valid invariants, weaken or discard invalid ones
   ```
   
   For simple methods like `fillArray`, `copyArray`, `sumOddNums`, `getMax`, and `isAscending`, this can work very well. For `partition`, `bubbleSort`, and iterative `quickSort`, you will need more domain-specific templates, because those algorithms require semantic facts like permutation preservation, sorted suffixes, pivot partitioning, and stack segment validity.












































