/*
 * Annotated version of to-be-tested-3.java.
 *
 * This is a JML-oriented synthesis pass, not an OpenJML proof run.
 * Assumptions:
 * - Array parameters are required non-null when the implementation dereferences them.
 * - Mathematical postconditions using +, *, \sum, or closed forms require the stated
 *   no-overflow preconditions, because Java int arithmetic can overflow.
 * - Local variables and freshly allocated objects are not listed in method-level
 *   assignable clauses, but loop-local variables are listed in loop_assigns.
 * - The method addN assumes an enclosing class field named x.
 */

/*@ normal_behavior
  @   requires 0 <= n;
  @   assignable \nothing;
  @   ensures \result == n;
  @*/
public static int idByLoop(int n) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-counting-up.
     * initialized before loop: i = 0; n is input-only.
     * counter/init/guard/step: i / 0 / i < n / i++.
     * counter direction/stride: increasing by 1.
     * assigned variables: i.
     * array reads/writes: none.
     * accumulators: none.
     * only-read variables: n.
     * early exits: none.
     * safety obligations: none beyond integer-progress reasoning.
     * termination measure: n - i.
     * selected templates: CounterBounds, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= n;
    //@ loop_assigns i;
    //@ decreases n - i;
    while (i < n) {
        i++;
    }
    return i;
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   assignable \nothing;
  @   ensures \result <==>
  @           (\exists int k; 0 <= k && k < a.length; a[k] == x);
  @*/
public static boolean contains(int[] a, int x) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-scan.
     * initialized before loop: i = 0; a and x are input-only.
     * counter/init/guard/step: i / 0 / i < a.length / i++ on the non-return path.
     * assigned variables: i.
     * array reads: a[i]. array writes: none.
     * accumulators: none.
     * branch/early exits: return true when a[i] == x.
     * semantic fact: processed prefix contains no x.
     * safety obligations: a != null; 0 <= i && i < a.length when reading a[i].
     * termination measure: a.length - i.
     * selected templates: CounterBounds, SearchExclusion, EarlyReturn, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] != x);
    //@ loop_assigns i;
    //@ decreases a.length - i;
    while (i < a.length) {
        if (a[i] == x) {
            return true;
        }
        i++;
    }
    return false;
}
////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   assignable \nothing;
  @   ensures -1 <= \result && \result < a.length;
  @   ensures \result == -1 <==>
  @           !(\exists int k; 0 <= k && k < a.length; a[k] == x);
  @   ensures \result != -1 ==>
  @           a[\result] == x &&
  @           (\forall int k; 0 <= k && k < \result; a[k] != x);
  @*/
public static int indexOf(int[] a, int x) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-scan.
     * initialized before loop: i = 0; a and x are input-only.
     * counter/init/guard/step: i / 0 / i < a.length / i++ on the non-return path.
     * assigned variables: i.
     * array reads: a[i]. array writes: none.
     * accumulators: none.
     * branch/early exits: return i when a[i] == x.
     * semantic fact: processed prefix contains no x, so returned i is the first match.
     * safety obligations: a != null; 0 <= i && i < a.length when reading a[i].
     * termination measure: a.length - i.
     * selected templates: CounterBounds, SearchExclusion, FirstIndexReturn, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] != x);
    //@ loop_assigns i;
    //@ decreases a.length - i;
    while (i < a.length) {
        if (a[i] == x) {
            return i;
        }
        i++;
    }
    return -1;
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   assignable \nothing;
  @   ensures \result <==>
  @           (\forall int k; 0 <= k && k < a.length; a[k] >= 0);
  @*/
public static boolean allNonNegative(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-scan.
     * initialized before loop: i = 0; a is input-only.
     * counter/init/guard/step: i / 0 / i < a.length / i++ on the non-return path.
     * assigned variables: i.
     * array reads: a[i]. array writes: none.
     * branch/early exits: return false when a[i] < 0.
     * semantic fact: processed prefix is nonnegative.
     * safety obligations: a != null; 0 <= i && i < a.length when reading a[i].
     * termination measure: a.length - i.
     * selected templates: CounterBounds, BooleanPrefixProperty, EarlyReturn, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] >= 0);
    //@ loop_assigns i;
    //@ decreases a.length - i;
    while (i < a.length) {
        if (a[i] < 0) {
            return false;
        }
        i++;
    }
    return true;
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int j; 0 <= j && j <= a.length;
  @              Integer.MIN_VALUE <= (\sum int k; 0 <= k && k < j; a[k]) &&
  @              (\sum int k; 0 <= k && k < j; a[k]) <= Integer.MAX_VALUE);
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < a.length; a[k]);
  @*/
public static int sum(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-scan-with-accumulator.
     * initialized before loop: i = 0; s = 0; a is input-only.
     * counter/init/guard/step: i / 0 / i < a.length / i++.
     * assigned variables: i, s.
     * array reads: a[i]. array writes: none.
     * accumulator: s, additive, update s += a[i], unguarded.
     * safety obligations: a != null; 0 <= i && i < a.length when reading a[i]; no int overflow.
     * termination measure: a.length - i.
     * selected templates: CounterBounds, ArraySumAccumulator, LoopFrame, Decreases.
     */
    int i = 0;
    int s = 0;
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining s == (\sum int k; 0 <= k && k < i; a[k]);
    //@ maintaining Integer.MIN_VALUE <= s && s <= Integer.MAX_VALUE;
    //@ loop_assigns i, s;
    //@ decreases a.length - i;
    while (i < a.length) {
        s += a[i];
        i++;
    }
    return s;
}

////////////////////

/*@ normal_behavior
  @   requires 0 <= n && n <= 65536;
  @   assignable \nothing;
  @   ensures \result == n * (n - 1) / 2;
  @*/
public static int triangular(int n) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-counting-up-with-numeric-accumulator.
     * initialized before loop: i = 0; s = 0; n is input-only.
     * counter/init/guard/step: i / 0 / i < n / i++.
     * assigned variables: i, s.
     * array reads/writes: none.
     * accumulator: s, additive, update s += i, unguarded.
     * semantic fact: s is the triangular sum over processed range [0, i).
     * safety obligations: no int overflow; guaranteed by n <= 65536.
     * termination measure: n - i.
     * selected templates: CounterBounds, ArithmeticSeriesAccumulator, LoopFrame, Decreases.
     */
    int i = 0;
    int s = 0;
    //@ maintaining 0 <= i && i <= n;
    //@ maintaining s == i * (i - 1) / 2;
    //@ loop_assigns i, s;
    //@ decreases n - i;
    while (i < n) {
        s += i;
        i++;
    }
    return s;
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length; a[k] == v);
  @*/
public static void fill(int[] a, int v) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-fill.
     * initialized before loop: i = 0; a and v are inputs.
     * counter/init/guard/step: i / 0 / i < a.length / i++.
     * assigned variables: i.
     * array reads: none. array writes: a[i] = v.
     * semantic fact: processed prefix is filled with v; unprocessed suffix is unchanged.
     * safety obligations: a != null; 0 <= i && i < a.length when writing a[i].
     * termination measure: a.length - i.
     * selected templates: CounterBounds, ArrayFill, UnprocessedSuffixUnchanged, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] == v);
    //@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    while (i < a.length) {
        a[i] = v;
        i++;
    }
}

////////////////////

/*@ normal_behavior
  @   requires src != null && dst != null;
  @   requires src.length <= dst.length;
  @   assignable dst[0 .. src.length - 1];
  @   ensures (\forall int k; 0 <= k && k < src.length; dst[k] == \old(src[k]));
  @   ensures (\forall int k; 0 <= k && k < src.length; src[k] == \old(src[k]));
  @*/
public static void copy(int[] src, int[] dst) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-copy.
     * initialized before loop: i = 0; src and dst are inputs.
     * counter/init/guard/step: i / 0 / i < src.length / i++.
     * assigned variables: i.
     * array reads: src[i]. array writes: dst[i].
     * semantic fact: dst prefix equals old src prefix; dst suffix not yet copied; src unchanged.
     * safety obligations: src != null, dst != null, src.length <= dst.length.
     * aliasing: src == dst is harmless for this exact self-copy pattern.
     * termination measure: src.length - i.
     * selected templates: CounterBounds, ArrayCopyPrefix, SourceUnchanged, UnprocessedDestinationUnchanged, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= src.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; dst[k] == \old(src[k]));
    //@ maintaining (\forall int k; i <= k && k < src.length; dst[k] == \old(dst[k]));
    //@ maintaining (\forall int k; 0 <= k && k < src.length; src[k] == \old(src[k]));
    //@ loop_assigns i, dst[0 .. src.length - 1];
    //@ decreases src.length - i;
    while (i < src.length) {
        dst[i] = src[i];
        i++;
    }
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int k; 0 <= k && k < a.length; a[k] < Integer.MAX_VALUE);
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length; a[k] == \old(a[k]) + 1);
  @*/
public static void incrementAll(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-in-place-array-transform.
     * initialized before loop: i = 0; a is input.
     * counter/init/guard/step: i / 0 / i < a.length / i++.
     * assigned variables: i.
     * array reads: a[i]. array writes: a[i] = a[i] + 1.
     * semantic fact: processed prefix equals old value plus 1; unprocessed suffix unchanged.
     * safety obligations: a != null; 0 <= i && i < a.length; a[i] < Integer.MAX_VALUE.
     * termination measure: a.length - i.
     * selected templates: CounterBounds, InPlaceTransformPrefixSuffix, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] == \old(a[k]) + 1);
    //@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    while (i < a.length) {
        a[i] = a[i] + 1;
        i++;
    }
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length; a[k] >= 0);
  @   ensures (\forall int k; 0 <= k && k < a.length; \old(a[k]) >= 0 ==> a[k] == \old(a[k]));
  @   ensures (\forall int k; 0 <= k && k < a.length; \old(a[k]) < 0 ==> a[k] == 0);
  @*/
public static void clampNegativeToZero(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-conditional-array-mutation-with-continue.
     * initialized before loop: i = 0; a is input.
     * counter/init/guard/step: i / 0 / i < a.length / i++ on both paths.
     * assigned variables: i.
     * array reads: a[i]. array writes: a[i] only when old/current a[i] < 0.
     * continue paths: if a[i] >= 0, increment i and continue.
     * semantic fact: processed prefix is path-sensitive clamp(old value, 0).
     * safety obligations: a != null; 0 <= i && i < a.length.
     * termination measure: a.length - i.
     * selected templates: CounterBounds, ConditionalArrayRewrite, ContinueAwarePathSummary, UnprocessedSuffixUnchanged, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] >= 0);
    //@ maintaining (\forall int k; 0 <= k && k < i; \old(a[k]) >= 0 ==> a[k] == \old(a[k]));
    //@ maintaining (\forall int k; 0 <= k && k < i; \old(a[k]) < 0 ==> a[k] == 0);
    //@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    while (i < a.length) {
        if (a[i] >= 0) {
            i++;
            continue;
        }
        a[i] = 0;
        i++;
    }
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   assignable \nothing;
  @   ensures 0 <= \result && \result <= a.length;
  @   ensures (\forall int k; 0 <= k && k < \result; a[k] % 2 != 0);
  @   ensures \result < a.length ==> a[\result] % 2 == 0;
  @*/
public static int firstEvenOrLength(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-scan-with-break.
     * initialized before loop: i = 0; a is input-only.
     * counter/init/guard/step: i / 0 / i < a.length / i++ on non-break path.
     * assigned variables: i.
     * array reads: a[i]. array writes: none.
     * break paths: break when a[i] % 2 == 0.
     * semantic fact: processed prefix is odd; break index, if any, is even.
     * safety obligations: a != null; 0 <= i && i < a.length when reading a[i].
     * termination measure: a.length - i.
     * selected templates: CounterBounds, PrefixProperty, BreakExitCondition, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] % 2 != 0);
    //@ loop_assigns i;
    //@ decreases a.length - i;
    while (i < a.length) {
        if (a[i] % 2 == 0) {
            break;
        }
        i++;
    }
    return i;
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length;
  @              a[k] == \old(a[a.length - 1 - k]));
  @*/
public static void reverse(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-two-frontier-swap.
     * initialized before loop: lo = 0; hi = a.length - 1.
     * counters/init/guard/step: lo / 0 / lo < hi / lo++; hi / a.length - 1 / lo < hi / hi--.
     * counter directions/stride: lo increases by 1; hi decreases by 1.
     * assigned variables: lo, hi, tmp.
     * array reads: a[lo], a[hi]. array writes: a[lo], a[hi].
     * semantic fact: processed left and right segments are reversed relative to old array; middle unchanged.
     * safety obligations: a != null; lo and hi in bounds when lo < hi.
     * termination measure: hi - lo + 1.
     * selected templates: TwoFrontierBounds, TwoFrontierReverseSegments, MiddleUnchanged, LoopFrame, Decreases.
     */
    int lo = 0;
    int hi = a.length - 1;

    //@ maintaining 0 <= lo && lo <= a.length;
    //@ maintaining -1 <= hi && hi < a.length;
    //@ maintaining lo <= hi + 1;
    //@ maintaining lo + hi == a.length - 1;
    //@ maintaining (\forall int k; 0 <= k && k < lo; a[k] == \old(a[a.length - 1 - k]));
    //@ maintaining (\forall int k; hi < k && k < a.length; a[k] == \old(a[a.length - 1 - k]));
    //@ maintaining (\forall int k; lo <= k && k <= hi; a[k] == \old(a[k]));
    //@ loop_assigns lo, hi, tmp, a[*];
    //@ decreases hi - lo + 1;
    while (lo < hi) {
        int tmp = a[lo];
        a[lo] = a[hi];
        a[hi] = tmp;
        lo++;
        hi--;
    }
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int p, q; 0 <= p && p <= q && q < a.length ==> a[p] <= a[q]);
  @   assignable \nothing;
  @   ensures \result == -1 ==>
  @           !(\exists int k; 0 <= k && k < a.length; a[k] == x);
  @   ensures \result != -1 ==>
  @           0 <= \result && \result < a.length && a[\result] == x;
  @*/
public static int binarySearch(int[] a, int x) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-two-bound-search.
     * initialized before loop: lo = 0; hi = a.length - 1.
     * counters/init/guard/step: lo / 0 / lo <= hi / lo = mid + 1 on low branch;
     *                           hi / a.length - 1 / lo <= hi / hi = mid - 1 on high branch.
     * assigned variables: lo, hi, mid.
     * array reads: a[mid]. array writes: none.
     * branch/early exits: return mid when a[mid] == x.
     * semantic fact: excluded left zone is < x; excluded right zone is > x.
     * required semantic precondition: array sorted nondecreasing.
     * safety obligations: a != null; mid in bounds whenever lo <= hi.
     * termination measure: hi - lo + 1.
     * selected templates: BinarySearchBounds, BinarySearchExclusionZones, EarlyReturn, LoopFrame, Decreases.
     */
    int lo = 0;
    int hi = a.length - 1;

    //@ maintaining 0 <= lo && lo <= a.length;
    //@ maintaining -1 <= hi && hi < a.length;
    //@ maintaining lo <= hi + 1;
    //@ maintaining (\forall int k; 0 <= k && k < lo; a[k] < x);
    //@ maintaining (\forall int k; hi < k && k < a.length; a[k] > x);
    //@ loop_assigns lo, hi, mid;
    //@ decreases hi - lo + 1;
    while (lo <= hi) {
        int mid = lo + (hi - lo) / 2;

        if (a[mid] == x) {
            return mid;
        } else if (a[mid] < x) {
            lo = mid + 1;
        } else {
            hi = mid - 1;
        }
    }

    return -1;
}

////////////////////

/*@ normal_behavior
  @   requires 0 <= n;
  @   requires x + n <= Integer.MAX_VALUE;
  @   assignable x;
  @   ensures x == \old(x) + n;
  @*/
public void addN(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: while-field-accumulator.
   * initialized before loop: i = 0; x is object field; n is input-only.
   * counter/init/guard/step: i / 0 / i < n / i++.
   * assigned variables/fields: i, this.x.
   * array reads/writes: none.
   * accumulator: field x, additive, update x++.
   * safety obligations: no int overflow for x + n.
   * termination measure: n - i.
   * selected templates: CounterBounds, FieldLinearAccumulator, LoopFrame, Decreases.
   */
  int i = 0;
  //@ maintaining 0 <= i && i <= n;
  //@ maintaining x == \old(x) + i;
  //@ loop_assigns i, x;
  //@ decreases n - i;
  while (i < n) {
    x++;
    i++;
  }
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   requires 0 <= i && i < a.length;
  @   requires a[i] < Integer.MAX_VALUE;
  @   assignable a[i];
  @   ensures a[i] == \old(a[i]) + 1;
  @   ensures (\forall int k; 0 <= k && k < a.length && k != i; a[k] == \old(a[k]));
  @*/
public static void incAt(int[] a, int i) {
    a[i] = a[i] + 1;
}

/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int k; 0 <= k && k < a.length; a[k] < Integer.MAX_VALUE);
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length; a[k] == \old(a[k]) + 1);
  @*/
public static void incrementAllViaHelper(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-transform-via-helper.
     * initialized before loop: i = 0; a is input.
     * counter/init/guard/step: i / 0 / i < a.length / i++.
     * assigned variables: i; array locations modified through incAt(a, i).
     * helper call: incAt(a, i).
     * required callee spec: incAt increments exactly a[i] and leaves all other cells unchanged.
     * semantic fact: processed prefix equals old value plus 1; unprocessed suffix unchanged.
     * safety obligations: a != null; 0 <= i && i < a.length; a[i] < Integer.MAX_VALUE.
     * termination measure: a.length - i.
     * selected templates: CounterBounds, HelperCallLift, InPlaceTransformPrefixSuffix, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] == \old(a[k]) + 1);
    //@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    while (i < a.length) {
        incAt(a, i);
        i++;
    }
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int k; 0 <= k && k < a.length; a[k] >= 0);
  @   requires (\forall int j; 0 <= j && j <= a.length;
  @              (\sum int k; 0 <= k && k < j; a[k]) <= Integer.MAX_VALUE);
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < a.length; a[k]);
  @ also
  @ exceptional_behavior
  @   requires a != null;
  @   requires (\exists int m; 0 <= m && m < a.length && a[m] < 0);
  @   assignable \nothing;
  @   signals_only IllegalArgumentException;
  @   signals (IllegalArgumentException e)
  @       (\exists int m; 0 <= m && m < a.length && a[m] < 0 &&
  @          (\forall int k; 0 <= k && k < m; a[k] >= 0));
  @*/
public static int sumNonNegative(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-scan-with-exception.
     * initialized before loop: i = 0; s = 0; a is input-only.
     * counter/init/guard/step: i / 0 / i < a.length / i++ on non-throw path.
     * assigned variables: i, s.
     * array reads: a[i]. array writes: none.
     * exceptional exits: throw IllegalArgumentException when a[i] < 0.
     * accumulator: s, additive, update s += a[i] on nonnegative path.
     * semantic fact: processed prefix is nonnegative and summed.
     * safety obligations: a != null; 0 <= i && i < a.length; no int overflow on normal path.
     * termination measure: a.length - i.
     * selected templates: CounterBounds, ExceptionPrefixGuard, ArraySumAccumulator, LoopFrame, Decreases.
     */
    int i = 0;
    int s = 0;

    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] >= 0);
    //@ maintaining s == (\sum int k; 0 <= k && k < i; a[k]);
    //@ loop_assigns i, s;
    //@ decreases a.length - i;
    while (i < a.length) {
        if (a[i] < 0) {
            throw new IllegalArgumentException();
        }
        s += a[i];
        i++;
    }

    return s;
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length && k % 2 == 0; a[k] == 0);
  @   ensures (\forall int k; 0 <= k && k < a.length && k % 2 != 0; a[k] == \old(a[k]));
  @*/
public static void zeroEvenIndices(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-strided-array-fill.
     * initialized before loop: i = 0; a is input.
     * counter/init/guard/step: i / 0 / i < a.length / i += 2.
     * counter direction/stride: increasing by 2; congruence i % 2 == 0.
     * assigned variables: i.
     * array reads: none. array writes: a[i].
     * semantic fact: processed even indices are zero; odd indices unchanged; unprocessed suffix unchanged.
     * safety obligations: a != null; 0 <= i && i < a.length when writing a[i].
     * termination measure: a.length - i.
     * selected templates: StridedCounterBounds, StridedArrayFill, OddIndexUnchanged, UnprocessedSuffixUnchanged, LoopFrame, Decreases.
     */
    int i = 0;
    //@ maintaining 0 <= i && i <= a.length + 1;
    //@ maintaining i % 2 == 0;
    //@ maintaining (\forall int k; 0 <= k && k < i && k < a.length && k % 2 == 0; a[k] == 0);
    //@ maintaining (\forall int k; 0 <= k && k < a.length && k % 2 != 0; a[k] == \old(a[k]));
    //@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    while (i < a.length) {
        a[i] = 0;
        i += 2;
    }
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length; a[k] == 0);
  @*/
public static void clear(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: for-array-fill, normalized to while.
     * initialized in loop header: i = 0; a is input.
     * counter/init/guard/step: i / 0 / i < a.length / i++.
     * assigned variables: i.
     * array reads: none. array writes: a[i] = 0.
     * semantic fact: processed prefix is zero; unprocessed suffix unchanged.
     * safety obligations: a != null; 0 <= i && i < a.length when writing a[i].
     * termination measure: a.length - i.
     * selected templates: CounterBounds, ArrayFill, UnprocessedSuffixUnchanged, LoopFrame, Decreases.
     */
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] == 0);
    //@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    for (int i = 0; i < a.length; i++) {
        a[i] = 0;
    }
}

////////////////////

/*@ normal_behavior
  @   requires a != null;
  @   requires a.length > 0;
  @   assignable \nothing;
  @   ensures (\exists int k; 0 <= k && k < a.length; \result == a[k]);
  @   ensures (\forall int k; 0 <= k && k < a.length; a[k] <= \result);
  @*/
public static int max(int[] a) {
    /*
     * LOOP DATAFLOW ANSWERS:
     * loopKind: while-array-extremum-scan.
     * initialized before loop: i = 1; m = a[0]; a is input-only.
     * counter/init/guard/step: i / 1 / i < a.length / i++.
     * assigned variables: i, m.
     * array reads: a[0], a[i]. array writes: none.
     * accumulator: m is a max accumulator selected from processed prefix.
     * semantic fact: m is some processed element and every processed element is <= m.
     * safety obligations: a != null; a.length > 0; 0 <= i && i < a.length when reading a[i].
     * termination measure: a.length - i.
     * selected templates: CounterBoundsFromOne, MaxScan, LoopFrame, Decreases.
     */
    int i = 1;
    int m = a[0];

    //@ maintaining 1 <= i && i <= a.length;
    //@ maintaining (\exists int k; 0 <= k && k < i; m == a[k]);
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] <= m);
    //@ loop_assigns i, m;
    //@ decreases a.length - i;
    while (i < a.length) {
        if (a[i] > m) {
            m = a[i];
        }
        i++;
    }

    return m;
}

////////////////////
