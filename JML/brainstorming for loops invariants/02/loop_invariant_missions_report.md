# Loop-summary, invariant-template, and JML pass for `to-be-tested-2.java`

## Reading assumptions

This report is a design-and-specification pass, not a completed OpenJML proof run. The file `to-be-tested-2.java` is treated as toy Java in the same style as the previous project examples. Console output is not modeled as heap mutation. Local variables and freshly allocated arrays are included in `loop_assigns` where needed, but not in method-level `assignable` clauses. Exact arithmetic specifications require no-overflow assumptions; exact string-content specifications require pure string model functions.

The complete copy-ready annotated source is in:

- `to-be-tested-2.annotated.java`

That file contains method-level JML, loop-level `maintaining` / `loop_assigns` / `decreases`, and a `LOOP DATAFLOW ANSWERS` comment for each method or loop.

---

# Mission 1 — revised dataflow questions and `LoopSummary`

The original question list was a good start, but `to-be-tested-2.java` contains more than simple counters, assignments, array reads/writes, `break`, and `continue`. The inclusive question set should be this:

## A. Loop shape and normalization

1. What syntactic loop form is this: `for`, `while`, `while(true)`, `for(;;)`, nested loop, or unknown?
2. What is the normalized loop form: pre-loop initialization, guard, body, update/back-edge?
3. Is this loop nested inside another loop?
4. Does the loop have a normal guard exit?
5. Does it have `break`, `continue`, `return`, or `throw` exits?
6. For each exit, under which path condition does it happen?
7. For `continue`, does the loop update still execute afterwards, as in a Java `for` loop?

## B. Counters, progress, and ranges

1. Which variables are loop counters?
2. What are their initial values?
3. What guard bounds them?
4. What is their step expression?
5. Are they increasing, decreasing, strided, or non-monotone?
6. What is the stride, e.g. `1`, `-1`, `2`?
7. Is the counter a method parameter mutated by the loop, as in `sum1`?
8. Do we need a ghost/old value to remember the initial counter?
9. What processed range does the counter represent: `[0,i)`, `(i,n]`, `[low,j)`, etc.?
10. Are there secondary counters, e.g. `j` in `removeAtPos` and `tail`?
11. Is there a relation between counters, e.g. `j == i - 1` or `j == i - (i > pos ? 1 : 0)`?

## C. Assignments, frame, and heap effects

1. Which locals are assigned in the loop?
2. Which fields are assigned in the loop?
3. Which array cells are written?
4. Which array cells are read?
5. Which variables/fields/arrays are read-only?
6. Which assignments are temporary/local-only and irrelevant to the method postcondition?
7. Which assignments reset or kill an accumulator, e.g. `res = 0`?
8. Which array regions are modified: whole array, prefix, suffix, slice `[low..high]`, fresh array?
9. Which array regions remain unchanged?
10. Does a helper call mutate state, and what is its callee frame?

## D. Accumulators and semantic effects

1. Which variables are accumulators?
2. What is their identity/init value?
3. What operation updates them: sum, subtraction, product, count, max, min, string append?
4. What is the update term?
5. Is the update guarded?
6. Is the guard direct or inverted because of `continue`, e.g. `nums[i] % 2 != 0`?
7. Is the accumulator path-sensitive, e.g. add on even and subtract on odd?
8. Is the accumulator not real because it is reset each iteration?
9. Is there a post-loop transformation, e.g. `if(res % 3 == 0) res *= 3`?

## E. Arrays, allocation, and aliasing

1. Are arrays required non-null?
2. Are array lengths preserved or newly allocated?
3. Is the destination fresh?
4. Are source and destination possibly aliased?
5. Is the write a fill, copy, shifted copy, reverse copy, in-place map, swap, partition, or sort?
6. Is the index expression affine, e.g. `i`, `i+1`, `arr.length-1-i`?
7. Are there nested-array accesses?
8. Is a permutation/multiset fact needed?

## F. Branches and path sensitivity

1. What are the branch conditions?
2. Are any branches constant true or false?
3. Does a branch make itself false for future iterations, e.g. `v == "bye"` then `v = "zuzu"`?
4. Does every path preserve the candidate invariant?
5. Which path reaches the back-edge?
6. Which path exits by `break`, `return`, or `throw`?

## G. Well-definedness and preconditions

1. Which null dereferences need `requires`?
2. Which array accesses need bounds invariants?
3. Which array allocations need non-negative size constraints?
4. Which arithmetic expressions can overflow?
5. Are there multiplication-specific bounds, e.g. `i*i` in `sqrt`, `arr.length*2` in `quickSort`?
6. Are there divisions/modulo operations and do they need nonzero divisors?
7. Are string/model functions required for exact specifications?

## H. Template and validation metadata

1. Which semantic pattern does the loop resemble?
2. Which invariant templates are plausible?
3. Which templates are low-confidence and require solver validation?
4. Which candidates are needed for safety only?
5. Which candidates are needed for postcondition proof?
6. Which candidates are needed for frame/unchanged facts?
7. Which `decreases` term is valid?
8. Which candidates should be discarded if initialization or preservation fails?

## Revised `LoopSummary`


```haskell
-- Use your existing symbolic-expression type where I write SymExpr/JmlExpr/LValue.
-- The important change is that LoopSummary must distinguish:
--   (1) syntactic loop shape,
--   (2) dataflow facts,
--   (3) path-sensitive exits,
--   (4) semantic pattern hints,
--   (5) validation obligations.

data LoopKind
  = ForLoop
  | WhileLoop
  | WhileTrueLoop
  | InfiniteForLoop
  | NestedLoop
  | UnknownLoop
  deriving (Eq, Show)

data Direction = Increasing | Decreasing | NonMonotone | UnknownDirection
  deriving (Eq, Show)

data ExitKind
  = GuardExit
  | BreakExit
  | ReturnExit
  | ThrowExit
  | ContinueEdge
  deriving (Eq, Show)

data CounterSummary = CounterSummary
  { counterName      :: String
  , counterInit      :: Maybe SymExpr
  , counterGuard     :: Maybe SymExpr
  , counterStep      :: Maybe SymExpr
  , counterDirection :: Direction
  , counterStride    :: Maybe SymExpr
  , counterLower     :: Maybe SymExpr
  , counterUpper     :: Maybe SymExpr
  , counterIsParam   :: Bool
  , counterNeedsOld  :: Bool
  }

data AssignmentSummary = AssignmentSummary
  { assignedLhs       :: LValue
  , assignedRhs       :: SymExpr
  , assignmentGuard   :: Maybe SymExpr
  , isResetAssignment :: Bool
  , isUpdateAssignment :: Bool
  }

data ArrayAccessSummary = ArrayAccessSummary
  { accessArray :: String
  , accessIndex :: SymExpr
  , accessKind  :: AccessKind      -- ReadAccess | WriteAccess
  , accessGuard :: Maybe SymExpr
  }

data AccumulatorSummary = AccumulatorSummary
  { accName       :: String
  , accInit       :: Maybe SymExpr
  , accOp         :: AccOp          -- Add | Sub | Mul | Count | Max | Min | StringAppend | UnknownAccOp
  , accTerm       :: SymExpr
  , accGuard      :: Maybe SymExpr
  , accRange      :: Maybe RangeSummary
  , accIsKilled   :: Bool           -- important for wrongSum1..4
  }

data RangeSummary = RangeSummary
  { rangeIndex     :: String
  , rangeLowerExpr :: SymExpr
  , rangeUpperExpr :: SymExpr
  , rangeInclusiveLower :: Bool
  , rangeInclusiveUpper :: Bool
  , rangePredicate :: Maybe SymExpr
  }

data BranchSummary = BranchSummary
  { branchCondition :: SymExpr
  , branchFeasible  :: Feasibility   -- AlwaysTrue | AlwaysFalse | Feasible | UnknownFeasible
  , thenEffects     :: [AssignmentSummary]
  , elseEffects     :: [AssignmentSummary]
  }

data ExitSummary = ExitSummary
  { exitKind      :: ExitKind
  , exitCondition :: Maybe SymExpr
  , exitState     :: Maybe SymState
  }

data HelperCallSummary = HelperCallSummary
  { calleeName      :: String
  , callArguments   :: [SymExpr]
  , calleeFrame     :: Maybe [LValue]
  , calleeEnsures   :: Maybe [JmlExpr]
  , callGuard       :: Maybe SymExpr
  , mustHavoc       :: Bool
  }

data AllocationSummary = AllocationSummary
  { allocatedName   :: String
  , allocatedLength :: Maybe SymExpr
  , allocatedFresh  :: Bool
  }

data WellDefinednessObligation
  = NonNull String
  | IndexInBounds String SymExpr
  | NoOverflow SymExpr
  | NoUnderflow SymExpr
  | NoNegativeArraySize SymExpr
  | DivisorNonZero SymExpr
  | CalleePrecondition String [JmlExpr]
  deriving (Eq, Show)

data SemanticHint
  = LooksLikeArrayFill
  | LooksLikeArrayCopy
  | LooksLikeShiftedCopy
  | LooksLikeReverseCopy
  | LooksLikeInPlaceMap
  | LooksLikeNumericSum
  | LooksLikeGuardedSum
  | LooksLikeCount
  | LooksLikeProduct
  | LooksLikeMaxScan
  | LooksLikeSearch
  | LooksLikeUniversalCheck
  | LooksLikePartition
  | LooksLikeBubbleSort
  | LooksLikeWorklistStack
  | LooksLikeStringRepeat
  | LooksLikeResetKilledAccumulator
  deriving (Eq, Show)

data LoopSummary = LoopSummary
  { loopId              :: LoopId
  , loopKind            :: LoopKind
  , parentLoop          :: Maybe LoopId
  , normalizedInit      :: [AssignmentSummary]
  , normalizedGuard     :: Maybe SymExpr
  , normalizedStep      :: [AssignmentSummary]
  , counters            :: [CounterSummary]
  , assignments         :: [AssignmentSummary]
  , arrayAccesses       :: [ArrayAccessSummary]
  , fieldReads          :: [LValue]
  , fieldWrites         :: [LValue]
  , localsReadOnly      :: [String]
  , accumulators        :: [AccumulatorSummary]
  , branches            :: [BranchSummary]
  , exits               :: [ExitSummary]
  , hasBreak            :: Bool
  , hasContinue         :: Bool
  , hasReturn           :: Bool
  , hasThrow            :: Bool
  , helperCalls         :: [HelperCallSummary]
  , allocations         :: [AllocationSummary]
  , possibleFrame       :: [LValue]
  , preservedFacts      :: [JmlExpr]
  , requiredPreFacts    :: [JmlExpr]
  , wellDefinedness     :: [WellDefinednessObligation]
  , semanticHints       :: [SemanticHint]
  }
```


---

# Mission 2 — JML and loop invariants

The method-level JML and loop invariants are in the attached generated file `to-be-tested-2.annotated.java`.

Important corrections/improvements relative to the older report:

1. The new methods at the end of `to-be-tested-2.java` are included: `factorial`, `reverseCopy`, `indexOf`, `countEverySecond`, `dotProduct`, and `sum`.
2. `isAscending1` and `isAscending2` use a length-safe bound for empty and singleton arrays.
3. `for2` and `for3` distinguish `n <= 0` from `n > 0`, because the loop itself handles negative `n` by doing zero iterations.
4. Exceptional specs use `signals_only Exception;` and `signals (Exception e) true;`.
5. `quickSort` is explicitly marked as requiring additional reasoning; the stack-shape invariant is not, by itself, a complete sorting proof.

---

# Mission 3 — revised `InvariantTemplate`

The original `InvariantTemplate` list was too small. It covers the core examples, but not reset accumulators, path-sensitive branches, return/throw exits, shifted copies, strided loops, nested loops, partition, bubble sort, quicksort stack intervals, string repeat, factorial/product, or model predicates.


```haskell
data InvariantTemplate
  -- Structural / proof skeleton templates
  = CounterBoundsTemplate CounterSummary
  | GuardedCounterBoundsTemplate CounterSummary
  | StridedCounterTemplate CounterSummary
  | TwoCounterRelationTemplate String String JmlExpr
  | LoopFrameTemplate [LValue]
  | DecreasesTemplate JmlExpr

  -- Prefix/suffix/range templates
  | PrefixPropertyTemplate RangeSummary JmlExpr
  | SuffixPropertyTemplate RangeSummary JmlExpr
  | PrefixUnchangedTemplate String RangeSummary
  | SuffixUnchangedTemplate String RangeSummary
  | FreshArrayLengthTemplate String JmlExpr

  -- Array construction/mutation templates
  | ArrayFillTemplate
      { targetArray :: String, indexName :: String, bound :: JmlExpr, fillValue :: JmlExpr }
  | ArrayCopyPrefixTemplate
      { srcArray :: String, dstArray :: String, indexName :: String, bound :: JmlExpr }
  | ShiftedCopyTemplate
      { srcArray :: String, dstArray :: String, srcIndex :: JmlExpr, dstIndex :: JmlExpr }
  | ReverseCopyTemplate
      { srcArray :: String, dstArray :: String, indexName :: String, lengthExpr :: JmlExpr }
  | InPlaceMapTemplate
      { arrayName :: String, indexName :: String, newValueOfOld :: JmlExpr }
  | ConditionalArrayMapTemplate
      { arrayName :: String, indexName :: String, cases :: [(JmlExpr, JmlExpr)] }

  -- Accumulator templates
  | NumericRangeSumTemplate
      { acc :: String, indexName :: String, range :: RangeSummary, summand :: JmlExpr }
  | GuardedNumericAccumulatorTemplate
      { acc :: String, indexName :: String, range :: RangeSummary, guard :: JmlExpr, summand :: JmlExpr }
  | CountAccumulatorTemplate
      { acc :: String, indexName :: String, range :: RangeSummary, countedPred :: JmlExpr }
  | ProductAccumulatorTemplate
      { acc :: String, indexName :: String, range :: RangeSummary, factor :: JmlExpr }
  | StringRepeatTemplate
      { acc :: String, repeated :: JmlExpr, countExpr :: JmlExpr }
  | ResetKilledAccumulatorTemplate
      { acc :: String, resetValue :: JmlExpr }
  | LastAssignmentTemplate
      { lhs :: LValue, valueAtLastIteration :: JmlExpr }

  -- Search / universal / extremum
  | SearchExclusionTemplate
      { arrayName :: String, indexName :: String, targetPredicate :: JmlExpr }
  | UniversalPrefixTemplate
      { indexName :: String, predOverIndex :: JmlExpr }
  | BooleanPrefixPropertyTemplate
      { boolVar :: String, indexName :: String, predOverIndex :: JmlExpr }
  | MaxScanTemplate
      { maxVar :: String, arrayName :: String, indexName :: String }

  -- Control-flow-sensitive templates
  | BreakPrefixTemplate
      { breakCond :: JmlExpr, prefixFact :: JmlExpr }
  | ContinueGuardedTemplate
      { continueCond :: JmlExpr, skippedEffect :: JmlExpr, takenEffect :: JmlExpr }
  | ReturnInsideLoopTemplate
      { returnCond :: JmlExpr, returnPost :: JmlExpr }
  | ThrowInsideLoopTemplate
      { throwCond :: JmlExpr, exceptionalPost :: JmlExpr }
  | WhileTrueBreakTemplate
      { breakCond :: JmlExpr, backedgeCond :: JmlExpr }

  -- Algorithm-specific templates
  | PartitionTemplate
      { arrayName :: String, low :: JmlExpr, high :: JmlExpr, pivot :: JmlExpr, iName :: String, jName :: String }
  | BubbleSortInnerTemplate
      { arrayName :: String, jName :: String, unsortedEnd :: JmlExpr }
  | BubbleSortOuterTemplate
      { arrayName :: String, iName :: String, nExpr :: JmlExpr }
  | WorklistStackTemplate
      { stackName :: String, topName :: String, intervalPredicate :: JmlExpr }

  -- Model-predicate templates; generated only when the target logic has support
  | PermutationTemplate
      { arrayName :: String, lo :: JmlExpr, hi :: JmlExpr }
  | SortedSegmentTemplate
      { arrayName :: String, lo :: JmlExpr, hi :: JmlExpr }

  -- Explicit fallback for loops where only weak facts are safe
  | WeakInvariantTemplate [JmlExpr]
```


## Mechanical algorithm from `LoopSummary` to `InvariantTemplate`

Use this ordered generation strategy:

```haskell
inferTemplates :: LoopSummary -> [InvariantTemplate]
inferTemplates s =
  concat
    [ counterTemplates s
    , frameAndVariantTemplates s
    , allocationTemplates s
    , prefixSuffixTemplates s
    , accumulatorTemplates s
    , searchAndUniversalTemplates s
    , controlFlowTemplates s
    , helperCallTemplates s
    , algorithmSpecificTemplates s
    , modelPredicateTemplates s
    , fallbackWeakTemplates s
    ]
```

Mechanically:

1. **Normalize the loop.** Convert `for(init; guard; step)` to `init; while(guard) { body; step; }` for analysis. For `while(true)` and `for(;;)`, compute the back-edge path condition from paths that do not break/return/throw.
2. **Generate counter templates first.** Every monotone counter gets bounds and a candidate `decreases`.
3. **Generate safety templates.** Array accesses become bounds requirements; allocations become non-negative size requirements; multiplication or addition becomes overflow obligations.
4. **Generate semantic templates from assignments.**
   - `sum += a[i]` gives a prefix sum.
   - `sum += a[i]` under an inverted continue guard gives a guarded prefix sum.
   - `p *= c` gives a product accumulator.
   - `a[i] = v` gives an array-fill prefix.
   - `dst[i] = src[i]` gives a copy-prefix invariant.
   - `arr[i] += arr[i]` gives an in-place map prefix plus unchanged suffix.
5. **Generate branch-sensitive templates.** Constant branches are folded; feasible branches create conditional summands or path-sensitive heap facts.
6. **Generate exit templates.** `break`, `return`, and `throw` are not normal guard exits; they must produce separate exit summaries.
7. **Generate helper-call templates.** If a callee contract exists, use its frame/postcondition. Otherwise, havoc its possible frame and keep only weak invariants.
8. **Validate.** For every candidate, check initialization, one-step preservation, exit usefulness, frame soundness, termination, and well-definedness. Invalid candidates must be weakened or discarded.

---

# Mission 3 + 4 + 5 — method-by-method summaries

Each method below gives the `LoopSummary` answer, generated template family, four proof needs, inference pipeline, and what remains after template generation.

### `manyArrs7`

- **LoopSummary answer:** for i=0; i<arr.length; i++; writes arr[i]; reads arr[i]; no exits; string-concat transform.
- **InvariantTemplate(s):** `CounterBounds + InPlacePrefixStringTransform + SuffixUnchanged`
- **Four proof needs:** Safety: arr!=null and i bounds. Post: processed prefix non-null/exact string relation if modeled. Frame: i, arr[*]. Termination: arr.length-i.
- **Inference pipeline:** identify i and arr[*] write -> infer 0<=i<=arr.length -> infer prefix transform + suffix unchanged -> emit loop frame/decreases -> validate.
- **Still left after templates:** Needs pure String/value-concat model for exact content; non-null prefix is automatic.

### `wrongSum1`

- **LoopSummary answer:** descending for i=n..1; res reset to 0; t=i each iteration; j local assigned.
- **InvariantTemplate(s):** `GuardedDescendingCounter + ResetAccumulator + LastFieldAssignment`
- **Four proof needs:** Safety: arithmetic only. Post: result 0; if n>0 final t=1. Frame: i,res,j,t. Termination: i.
- **Inference pipeline:** classify guarded descending loop -> detect killed accumulator res -> detect last assignment t=i -> guarded negative-n invariants -> validate.
- **Still left after templates:** Mostly syntactic; field t frame must be integrated into method assignable.

### `wrongSum2`

- **LoopSummary answer:** descending loop; if(true) writes v then reset res; t=i.
- **InvariantTemplate(s):** `GuardedDescendingCounter + ConstantTrueBranch + ResetAccumulator + FieldOverwrite`
- **Four proof needs:** Safety: arithmetic only. Post: result 0; v=zuzu and t=1 if executed. Frame: i,res,v,t. Termination: i.
- **Inference pipeline:** constant-fold branch -> killed accumulator -> last field assignment -> counter bounds -> validate.
- **Still left after templates:** String equality/model if strict OpenJML; otherwise easy.

### `wrongSum3`

- **LoopSummary answer:** descending loop; if(false) unreachable; res reset; t=i.
- **InvariantTemplate(s):** `GuardedDescendingCounter + ConstantFalseBranch + ResetAccumulator`
- **Four proof needs:** Safety: arithmetic only. Post: result 0; v unchanged; t=1 if executed. Frame: i,res,t. Termination: i.
- **Inference pipeline:** constant-fold branch false -> ignore unreachable writes -> killed accumulator -> validate.
- **Still left after templates:** Need path feasibility filtering so unreachable assignments do not pollute frame.

### `wrongSum4`

- **LoopSummary answer:** descending loop; branch on v==bye can fire once then v=zuzu; res reset; t=i.
- **InvariantTemplate(s):** `GuardedDescendingCounter + PathSensitiveFieldMutation + ResetAccumulator`
- **Four proof needs:** Safety: arithmetic only. Post: path-sensitive v and t; result 0. Frame: i,res,v,t. Termination: i.
- **Inference pipeline:** detect one-shot guard because branch assignment falsifies future guard -> old(v)-based invariant -> validate.
- **Still left after templates:** String equality model; path-sensitive field summary.

### `wrongSum5`

- **LoopSummary answer:** descending loop; res accumulates i; branch on v==bye adds one once; t=i.
- **InvariantTemplate(s):** `DescendingRangeSum + OneShotGuardedFieldMutation`
- **Four proof needs:** Safety: no overflow for triangular sum. Post: sum 1..n plus optional 1. Frame: i,res,v,t. Termination: i.
- **Inference pipeline:** descending range-sum template + one-shot guarded effect -> old(v)-based invariant -> validate.
- **Still left after templates:** Arithmetic bound and string equality model.

### `for1`

- **LoopSummary answer:** empty descending loop over i=n..1.
- **InvariantTemplate(s):** `GuardedDescendingCounter`
- **Four proof needs:** Safety: none. Post: result 0. Frame: i. Termination: i.
- **Inference pipeline:** counter-only template -> no semantic invariant except res unchanged.
- **Still left after templates:** Easy.

### `for2`

- **LoopSummary answer:** descending loop counts positive even i; post-loop triples count if divisible by 3.
- **InvariantTemplate(s):** `GuardedDescendingCounter + EvenCountAccumulator + PostLoopTransform`
- **Four proof needs:** Safety: modulo defined. Post: count-even then post-transform. Frame: i,res. Termination: i.
- **Inference pipeline:** guarded count template -> post-loop symbolic execution -> validate.
- **Still left after templates:** Need post-loop transformer in method-summary stage, not loop template.

### `for3`

- **LoopSummary answer:** initial parity branch sets a; descending loop adds 5 on even i; post-loop optional triple.
- **InvariantTemplate(s):** `InitialBranchConstant + EvenCountScaledAccumulator + PostLoopTransform`
- **Four proof needs:** Safety: arithmetic overflow bound. Post: initial constant + 5*even count, then transform. Frame: i,a. Termination: i.
- **Inference pipeline:** symbolically summarize initial if -> guarded scaled count -> post-loop transform.
- **Still left after templates:** Overflow bounds and branch simplification.

### `sum1`

- **LoopSummary answer:** parameter n is loop counter; res accumulates n+(n-1)+...+1.
- **InvariantTemplate(s):** `MutatedParameterDescendingTriangularSum`
- **Four proof needs:** Safety: no overflow. Post: triangular sum or 0. Frame: n,res. Termination: n.
- **Inference pipeline:** mutated-parameter descending-sum; introduce old/ghost n0 -> closed-form invariant.
- **Still left after templates:** Need ghost/old support and overflow precondition synthesis.

### `sum2`

- **LoopSummary answer:** local n=21 counts down; res accumulates fixed triangular sum.
- **InvariantTemplate(s):** `LocalDescendingTriangularSum`
- **Four proof needs:** Safety: bounded constants. Post: 231. Frame: n,res. Termination: n.
- **Inference pipeline:** constant initialize -> descending-sum -> constant-fold postcondition.
- **Still left after templates:** Easy; ignore unused i in for initializer.

### `sum4`

- **LoopSummary answer:** same as sum1 but decrement in body.
- **InvariantTemplate(s):** `MutatedParameterWhileStyleTriangularSum`
- **Four proof needs:** Safety: no overflow. Post: triangular sum. Frame: n,res. Termination: n.
- **Inference pipeline:** normalize for(;guard;) body-with-step to while -> descending-sum.
- **Still left after templates:** Normalize body step before template matching.

### `sum1_While`

- **LoopSummary answer:** while version of sum1.
- **InvariantTemplate(s):** `MutatedParameterWhileTriangularSum`
- **Four proof needs:** Safety: no overflow. Post: triangular sum. Frame: n,res. Termination: n.
- **Inference pipeline:** while-counting-down -> descending-sum with old n.
- **Still left after templates:** Same as sum1.

### `sum1_While2`

- **LoopSummary answer:** while(true) executes at least once; breaks after decrement when n<=0.
- **InvariantTemplate(s):** `WhileTrueBreak + AtLeastOnceDescendingSum`
- **Four proof needs:** Safety: no overflow. Post: old n if <=0, triangular if >0. Frame: n,res. Termination: conditional n.
- **Inference pipeline:** detect while-true-break -> split old n<=0 vs >0 -> preserve only non-break backedge.
- **Still left after templates:** Needs path-sensitive backedge extraction; not simple guard negation.

### `sumOddNums`

- **LoopSummary answer:** array traversal; continue on even; sum odd elements.
- **InvariantTemplate(s):** `ForwardCounter + GuardedArraySum + ContinuePath`
- **Four proof needs:** Safety: nums!=null and i bounds. Post: guarded sum over all odd indices. Frame: i,sum. Termination: nums.length-i.
- **Inference pipeline:** detect continue guard -> invert guard for accumulator update -> guarded array-sum template.
- **Still left after templates:** Overflow bounds if exact int math is required.

### `sumUntilNegative`

- **LoopSummary answer:** array traversal; break at first negative; sum prefix before break.
- **InvariantTemplate(s):** `ForwardCounter + PrefixSumUntilBreak + BreakCondition`
- **Four proof needs:** Safety: nums!=null and i bounds. Post: existential break index m. Frame: i,sum. Termination: nums.length-i.
- **Inference pipeline:** break condition -> prefix nonnegative invariant + prefix sum -> existential postcondition.
- **Still left after templates:** Need break-exit summary in method postcondition.

### `processArray1`

- **LoopSummary answer:** array traversal; add even values and subtract odd values.
- **InvariantTemplate(s):** `ForwardCounter + PathSensitiveSignedArrayFold`
- **Four proof needs:** Safety: arr!=null and i bounds. Post: signed conditional sum. Frame: i,sum. Termination: arr.length-i.
- **Inference pipeline:** path-sensitive fold over if/else -> conditional summand template.
- **Still left after templates:** Overflow constraints for exact arithmetic.

### `fillArray`

- **LoopSummary answer:** fresh array arr of length size; fill arr[i]=elem.
- **InvariantTemplate(s):** `ArrayFillFresh`
- **Four proof needs:** Safety: size>=0 and i bounds. Post: fresh filled array. Frame: i,arr[*]. Termination: size-i.
- **Inference pipeline:** allocation fact arr.length=size -> array-fill template -> validate.
- **Still left after templates:** Easy.

### `sqrt`

- **LoopSummary answer:** search i from 0 to y; return square root if found; throw at final miss.
- **InvariantTemplate(s):** `BoundedSearch + ReturnOrThrow + SquareSafety`
- **Four proof needs:** Safety: y>=0; i*i no overflow. Post: result square or exception. Frame: i. Termination: y-i+1.
- **Inference pipeline:** bounded search -> exclusion prefix k*k != y -> return/throw exits.
- **Still left after templates:** Exception spec and square overflow bounds.

### `getMax`

- **LoopSummary answer:** if nonempty, max starts arr[0], scan arr[1..].
- **InvariantTemplate(s):** `MaxScan`
- **Four proof needs:** Safety: arr!=null && arr.length>0. Post: max element and upper bound. Frame: i,max. Termination: arr.length-i.
- **Inference pipeline:** max-scan template with exists+forall over processed prefix.
- **Still left after templates:** Easy once empty exceptional case is handled.

### `partition`

- **LoopSummary answer:** Lomuto partition over arr[low..high]; helper swap; pivot arr[high].
- **InvariantTemplate(s):** `LomutoPartition + HelperSwapFrame + PivotPreservation`
- **Four proof needs:** Safety: low/high bounds and swap preconditions. Post: pivot position and left/right partition. Frame: i,j,arr[low..high]. Termination: high-j.
- **Inference pipeline:** detect pivot fixed -> two-region invariant -> use swap frame -> final pivot swap.
- **Still left after templates:** Permutation/multiset model and helper-call summarization.

### `isAscending1`

- **LoopSummary answer:** adjacent-pair scan; boolean res becomes false on violation.
- **InvariantTemplate(s):** `BooleanUniversalPrefixProperty`
- **Four proof needs:** Safety: arr!=null and k+1 bounds. Post: res iff all adjacent pairs ordered. Frame: i,res. Termination: ternary length-1-i.
- **Inference pipeline:** adjacent universal prefix + boolean accumulator.
- **Still left after templates:** Needs special bound for arr.length<=1.

### `isAscending2`

- **LoopSummary answer:** adjacent-pair scan; early return false on violation.
- **InvariantTemplate(s):** `UniversalPrefixProperty + EarlyReturn`
- **Four proof needs:** Safety: arr!=null and k+1 bounds. Post: true iff all pairs ordered. Frame: i. Termination: ternary length-1-i.
- **Inference pipeline:** universal prefix + early return summary.
- **Still left after templates:** Needs return-path postcondition generation.

### `copyArray`

- **LoopSummary answer:** fresh copy same length; copy[i]=arr[i].
- **InvariantTemplate(s):** `FreshArrayCopyPrefix`
- **Four proof needs:** Safety: arr!=null. Post: fresh same-length copy. Frame: i,copy[*]. Termination: arr.length-i.
- **Inference pipeline:** allocation length fact -> copy-prefix template.
- **Still left after templates:** Easy.

### `addElemRight`

- **LoopSummary answer:** fresh res length arr.length+1; copy prefix then append elem.
- **InvariantTemplate(s):** `FreshArrayCopyPrefix + Append`
- **Four proof needs:** Safety: arr!=null; arr.length+1 no overflow. Post: copied prefix and last elem. Frame: i,res[*]. Termination: arr.length-i.
- **Inference pipeline:** copy-prefix template + straight-line append.
- **Still left after templates:** Allocation overflow bound.

### `removeAtPos`

- **LoopSummary answer:** fresh res length arr.length-1; skip pos while copying; j counts output.
- **InvariantTemplate(s):** `TwoCounterCopySkip + ContinuePath`
- **Four proof needs:** Safety: arr!=null and valid pos. Post: prefix before pos and shifted suffix. Frame: i,j,res[*]. Termination: arr.length-i.
- **Inference pipeline:** continue guard i==pos -> two-counter relation j=i-(i>pos?1:0) -> shifted-copy invariants.
- **Still left after templates:** Path-sensitive continue and bounds for j.

### `takeWhileAsLongAsEven`

- **LoopSummary answer:** outer loop extends res while arr[i] even; returns on first odd; inner loop copies old res into temp and appends.
- **InvariantTemplate(s):** `PrefixTakeUntilReturn + NestedAppendCopy`
- **Four proof needs:** Safety: arr!=null; temp/res bounds. Post: existential even prefix. Frame: outer i,res; inner j,temp[*]. Termination: arr.length-i and i+1-j.
- **Inference pipeline:** outer take-while template + inner append-copy template.
- **Still left after templates:** Nested-loop summaries and fresh-array alias tracking.

### `bubbleSort`

- **LoopSummary answer:** nested adjacent swaps; outer passes grow sorted suffix.
- **InvariantTemplate(s):** `NestedLoop + BubbleMaxPrefix + SortedSuffix + AdjacentSwap`
- **Four proof needs:** Safety: arr!=null and j+1 bounds. Post: sorted. Frame: i,j,arr[*]. Termination: outer n-1-i; inner n-i-1-j.
- **Inference pipeline:** nested-loop classification -> inner max-bubble invariant -> outer sorted-suffix invariant.
- **Still left after templates:** Permutation model and stronger inner lemmas; pure template alone may be insufficient for OpenJML.

### `replicate`

- **LoopSummary answer:** descending loop appends core string to res n times.
- **InvariantTemplate(s):** `StringRepeatAccumulator`
- **Four proof needs:** Safety: v!=null if modeling strings. Post: repeat(v,n). Frame: i,res. Termination: i.
- **Inference pipeline:** string accumulator template.
- **Still left after templates:** Need pure model function repeat(String,int).

### `sum3`

- **LoopSummary answer:** for(;; n--) with leading break when n<=0; else add n.
- **InvariantTemplate(s):** `InfiniteForBreak + DescendingTriangularSum`
- **Four proof needs:** Safety: no overflow. Post: 0 if old n<=0, triangular if >0. Frame: n,res. Termination: conditional n.
- **Inference pipeline:** infinite-loop-break normalization -> descending-sum on non-break paths.
- **Still left after templates:** Backedge-only preservation and old n split.

### `tail`

- **LoopSummary answer:** if arr length>1, copy arr[1..] into fresh arr2 using i,j.
- **InvariantTemplate(s):** `ShiftedCopyPrefix`
- **Four proof needs:** Safety: arr!=null && length>1. Post: shifted copy. Frame: i,j,arr2[*]. Termination: arr.length-i.
- **Inference pipeline:** two-counter shifted-copy template with j=i-1.
- **Still left after templates:** Exception spec for small/null arrays.

### `doubleArrayElems`

- **LoopSummary answer:** for each arr[i], local x=arr[i], then arr[i]+=x.
- **InvariantTemplate(s):** `InPlaceArrayMapPrefix + SuffixUnchanged`
- **Four proof needs:** Safety: arr!=null and no doubling overflow. Post: each old element doubled. Frame: i,arr[*]. Termination: arr.length-i.
- **Inference pipeline:** in-place array map prefix + unchanged suffix.
- **Still left after templates:** Overflow precondition.

### `doubleArrayElems2`

- **LoopSummary answer:** while version of doubleArrayElems.
- **InvariantTemplate(s):** `InPlaceArrayMapPrefix + SuffixUnchanged`
- **Four proof needs:** Safety: arr!=null and no doubling overflow. Post: doubled array. Frame: i,arr[*]. Termination: arr.length-i.
- **Inference pipeline:** while-counting-up -> in-place map template.
- **Still left after templates:** Same as doubleArrayElems.

### `quickSort`

- **LoopSummary answer:** iterative quicksort using stack of low/high intervals and partition.
- **InvariantTemplate(s):** `StackIntervalWorklist + PartitionContract + SortednessAfterAllSegments`
- **Four proof needs:** Safety: arr null/length split; stack bounds; partition preconditions. Post: sorted array. Frame: top,stack[*],arr[*]. Termination: top+1 is insufficient alone without push-size argument. 
- **Inference pipeline:** worklist stack template -> interval validity -> helper partition summaries -> sortedness after all intervals processed.
- **Still left after templates:** Hard: partition lemmas, permutation model, processed/unprocessed segment invariant, and a sound variant for arbitrary pushes.

### `factorial`

- **LoopSummary answer:** c from 1 to n; p *= c.
- **InvariantTemplate(s):** `MultiplicativeAccumulator`
- **Four proof needs:** Safety: n>=0 and product no overflow. Post: product 1..n. Frame: c,p. Termination: n-c+1.
- **Inference pipeline:** multiplicative accumulator template.
- **Still left after templates:** Need \product support or pure fact model; overflow bound.

### `reverseCopy`

- **LoopSummary answer:** res[i]=arr[arr.length-1-i].
- **InvariantTemplate(s):** `ReverseCopyPrefix`
- **Four proof needs:** Safety: arr!=null; reverse index bounds. Post: fresh reversed copy. Frame: i,res[*]. Termination: arr.length-i.
- **Inference pipeline:** copy-prefix with source index affine reverse expression.
- **Still left after templates:** Easy after affine-index recognition.

### `indexOf`

- **LoopSummary answer:** linear search; return i on first arr[i]==x, else -1.
- **InvariantTemplate(s):** `SearchExclusion + EarlyReturnSentinel`
- **Four proof needs:** Safety: arr!=null. Post: sentinel and first occurrence. Frame: i. Termination: arr.length-i.
- **Inference pipeline:** search exclusion prefix + early return path.
- **Still left after templates:** Easy.

### `countEverySecond`

- **LoopSummary answer:** strided i+=2 and counter c++.
- **InvariantTemplate(s):** `StridedCounter + CountAccumulator`
- **Four proof needs:** Safety: arr!=null. Post: ceil(length/2). Frame: i,c. Termination: ternary arr.length-i.
- **Inference pipeline:** stride detection -> congruence i%2==0 -> c=i/2.
- **Still left after templates:** Need strided-loop bounds allowing i==length+1.

### `dotProduct`

- **LoopSummary answer:** res += a[i]*b[i] over i<a.length.
- **InvariantTemplate(s):** `TwoArrayDotProductAccumulator`
- **Four proof needs:** Safety: a,b!=null and b.length>=a.length; no multiply/add overflow. Post: dot-product sum. Frame: i,res. Termination: a.length-i.
- **Inference pipeline:** two-array accumulator template with compound summand.
- **Still left after templates:** Overflow bounds and equal-length/length-order precondition synthesis.

### `sum`

- **LoopSummary answer:** while i<a.length; s=s+a[i]; i++.
- **InvariantTemplate(s):** `WhileArraySumAccumulator`
- **Four proof needs:** Safety: a!=null and i bounds; no sum overflow. Post: array sum. Frame: i,s. Termination: a.length-i.
- **Inference pipeline:** while array-sum accumulator template.
- **Still left after templates:** Overflow bounds.


## No-loop methods

These methods have no loop invariant to synthesize. Their proof pipeline is straight-line symbolic execution plus callee-contract application:

`sum1Call1`, `sum1Call2`, `sum1Call3`, `sum4Call`, `sum1_WhileCall`, `sum1_While2Call1`, `sum1_While2Call2`, `sumOddNumsCall1`, `sumOddNumsCall2`, `sumUntilNegativeCall1`, `sumUntilNegativeCall2`, `processArray1Call`, `fillArrayCall`, `sqrtCall1`, `sqrtCall2`, `boo34`, `boo34Call`, `getMaxCall`, `swap`, `swapCall`, `partitionCall1`, `partitionCall2`, `partitionCall3`, `partitionCall4`, `partitionCall5`, `partitionCall6`, `isAscending1Call`, `isAscending2Call`, `copyArrayCall`, `addElemRightCall`, `removeAtPosCall1`, `removeAtPosCall2`, `takeWhileAsLongAsEvenCall1`, `takeWhileAsLongAsEvenCall2`, `bubbleSortCall`, `replicateCall`, `sum3Call1`, `sum3Call2`, `tailCall1`, `tailCall2`, `tailCall3`, `tailCall4`, `doubleArrayElemsCall`, `doubleArrayElems2Call`, `quickSortCall1`, `quickSortCall2`, `quickSortCall3`

For these, the four proof needs collapse as follows:

- **Safety:** prove each callee precondition, nullness, and array literal/index safety.
- **Postcondition:** use direct assignment reasoning and callee `ensures`.
- **Frame:** method-level `assignable` only; no `loop_assigns`.
- **Termination:** trivial unless the callee is not known to terminate.

---

# Mission 5 — what remains after `LoopSummary` and `InvariantTemplate`?

The templates are not the final answer. They are candidate generators. After generating templates, your tool still needs the following stages.

## 1. Candidate instantiation

Turn each `InvariantTemplate` into concrete `JML.Expr` values. Example:

```haskell
ArrayFillTemplate "arr" "i" "size" "elem"
```

becomes:

```java
//@ maintaining 0 <= i && i <= size;
//@ maintaining arr.length == size;
//@ maintaining (orall int k; 0 <= k && k < i; arr[k] == elem);
//@ loop_assigns i, arr[*];
//@ decreases size - i;
```

## 2. Well-definedness filtering

Before asking whether an invariant is true, check whether it is well-defined:

- array references have non-null arrays and in-bounds indices,
- arithmetic does not overflow if exact math is claimed,
- quantifier bodies do not dereference invalid indices,
- model functions used in specs are declared pure.

## 3. VC-style validation

For each candidate invariant `I`, generate at least:

1. initialization VC,
2. preservation VC over every feasible back-edge,
3. exit VC for normal guard exit,
4. break/return/throw exit obligations,
5. frame VC,
6. termination VC.

This is exactly why templates are not enough: a template can be plausible but not inductive.

## 4. Method-contract synthesis

Loop invariants usually depend on method-level facts. Your tool must synthesize or request:

- nullness preconditions,
- array-length/index preconditions,
- overflow bounds,
- exceptional spec cases,
- helper method contracts,
- model predicates for strings, factorial/product, sortedness, and permutation.

## 5. Solver/OpenJML feedback loop

The realistic architecture is:

```text
Java AST/CFG
  -> symbolic execution
  -> LoopSummary
  -> InvariantTemplate candidates
  -> JML candidate expressions
  -> lightweight syntactic validation
  -> VCs / OpenJML / SMT
  -> keep valid, weaken invalid, request assumptions for unsupported facts
```

## Method-specific remaining work categories

- **Mostly automatic after templates:** `for1`, `sum2`, `fillArray`, `copyArray`, `indexOf`, `reverseCopy`, `countEverySecond`, `sum`, `getMax`.
- **Needs overflow-precondition synthesis:** `sum1`, `sum4`, `sum1_While`, `sum1_While2`, `sum3`, `wrongSum5`, `for3`, `processArray1`, `factorial`, `dotProduct`, `doubleArrayElems`, `doubleArrayElems2`, `sqrt`.
- **Needs string/model-function support:** `manyArrs7`, `wrongSum2`, `wrongSum4`, `wrongSum5`, `replicate`, `boo34`.
- **Needs path-sensitive exit handling:** `sumUntilNegative`, `sqrt`, `isAscending2`, `indexOf`, `takeWhileAsLongAsEven`, `sum3`, `sum1_While2`.
- **Needs nested-loop summaries:** `takeWhileAsLongAsEven`, `bubbleSort`.
- **Needs helper-call and permutation reasoning:** `partition`, `bubbleSort`, `quickSort`.
- **Needs worklist/algorithm-specific reasoning beyond simple templates:** `quickSort`.

The practical conclusion: `LoopSummary` plus `InvariantTemplate` is the synthesis layer, not the validation layer. For many methods in this file it is enough to produce good candidate JML, but for sorting/partitioning/quicksort and exact string/arithmetic semantics, you still need model predicates, helper specs, and VC/OpenJML validation.
