/*
 * Annotated version of to-be-tested-2.java.
 *
 * Assumptions:
 * - Console output from println/print is not modeled as heap mutation.
 * - toString and string concatenation are treated symbolically; strict OpenJML
 *   verification would need pure model functions for string values.
 * - Mathematical postconditions using +, *, \sum, \product, and closed forms
 *   require the stated no-overflow bounds.
 * - Some original methods are toy-Java rather than directly compilable Java
 *   (e.g. checked exceptions without throws declarations, void methods returning
 *   arrays). The specifications follow the intended symbolic-execution meaning.
 */

/*@ normal_behavior
  @   requires arr != null;
  @   assignable arr[*];
  @   ensures arr.length == \old(arr.length);
  @   ensures (\forall int k; 0 <= k && k < arr.length; arr[k] != null);
  @*/
public void manyArrs7(String[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up.
   * counter/init/guard/step: i / 0 / i < arr.length / i++.
   * assigned: i, arr[*].
   * array reads: arr[i]. array writes: arr[i].
   * only-read state: arr.length.
   * break/continue/return/throw: none.
   * semantic template: in-place prefix transform; processed arr[k] is non-null
   * after string concatenation; exact string equality needs a pure String model.
   * frame/decreases: loop_assigns i, arr[*]; decreases arr.length - i.
   */
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining arr.length == \old(arr.length);
    @ maintaining (\forall int k; 0 <= k && k < i; arr[k] != null);
    @ maintaining (\forall int k; i <= k && k < arr.length; arr[k] == \old(arr[k]));
    @ loop_assigns i, arr[*];
    @ decreases arr.length - i;
    @*/
  for(int i=0; i<arr.length; i++) {
    arr[i] = toString(i+1) + ". " + arr[i];
  }
  println(arr);
}

/*@ normal_behavior
  @   assignable t;
  @   ensures \result == 0;
  @   ensures n > 0 ==> t == 1;
  @   ensures n <= 0 ==> t == \old(t);
  @*/
public int wrongSum1(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-down, guarded for negative n.
   * counter/init/guard/step: i / n / i > 0 / i--.
   * assigned: i, res, local j, local z, field t.
   * reads: n, w, c. array reads/writes: none.
   * accumulator: res is killed/reset to 0 every iteration, so it is not a true sum.
   * break/continue/return/throw: none.
   * semantic template: guarded descending counter + reset accumulator + last field assignment.
   * frame/decreases: loop_assigns i, res, j, t; decreases i.
   */
  int res = 0;
  int j = w;
  /*@ maintaining n <= 0 ==> i == n && res == 0;
    @ maintaining n > 0 ==> 0 <= i && i <= n && res == 0;
    @ maintaining n > 0 && i < n ==> t == i + 1;
    @ loop_assigns i, res, j, t;
    @ decreases i;
    @*/
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    res = 0;
    t = i;
    j = c;
  }
  return res;
}

/*@ normal_behavior
  @   assignable v, t;
  @   ensures \result == 0;
  @   ensures n > 0 ==> t == 1;
  @   ensures n > 0 ==> v == "zuzu";
  @   ensures n <= 0 ==> t == \old(t);
  @   ensures n <= 0 ==> v == \old(v);
  @*/
public int wrongSum2(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-down.
   * counter/init/guard/step: i / n / i > 0 / i--.
   * assigned: i, res, local z, fields v and t.
   * branch facts: if(true) is unconditional; v is overwritten to "hi", then "zuzu".
   * accumulator: res is reset to 0; not a true sum.
   * break/continue/return/throw: none.
   * semantic template: constant-true branch + reset accumulator + final field overwrite.
   */
  int res = 0;
  /*@ maintaining n <= 0 ==> i == n && res == 0;
    @ maintaining n > 0 ==> 0 <= i && i <= n && res == 0;
    @ maintaining n > 0 && i < n ==> t == i + 1;
    @ maintaining n > 0 && i < n ==> v == "zuzu";
    @ loop_assigns i, res, v, t;
    @ decreases i;
    @*/
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(true) {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    res = 0;
    t = i;
  }
  return res;
}

/*@ normal_behavior
  @   assignable t;
  @   ensures \result == 0;
  @   ensures v == \old(v);
  @   ensures n > 0 ==> t == 1;
  @   ensures n <= 0 ==> t == \old(t);
  @*/
public int wrongSum3(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-down.
   * counter/init/guard/step: i / n / i > 0 / i--.
   * assigned: i, res, local z, field t.
   * branch facts: if(false) is unreachable; v is not assigned on feasible paths.
   * accumulator: res is reset to 0.
   * template: constant-false branch + reset accumulator + last field assignment.
   */
  int res = 0;
  /*@ maintaining n <= 0 ==> i == n && res == 0;
    @ maintaining n > 0 ==> 0 <= i && i <= n && res == 0;
    @ maintaining v == \old(v);
    @ maintaining n > 0 && i < n ==> t == i + 1;
    @ loop_assigns i, res, t;
    @ decreases i;
    @*/
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(false) {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    res = 0;
    t = i;
  }
  return res;
}

/*@ normal_behavior
  @   assignable v, t;
  @   ensures \result == 0;
  @   ensures n > 0 ==> t == 1;
  @   ensures n <= 0 ==> t == \old(t);
  @   ensures n <= 0 ==> v == \old(v);
  @   ensures n > 0 && \old(v) == "bye" ==> v == "zuzu";
  @   ensures n > 0 && \old(v) != "bye" ==> v == \old(v);
  @*/
public int wrongSum4(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-down.
   * counter/init/guard/step: i / n / i > 0 / i--.
   * assigned: i, res, local z, fields v and t.
   * branch guard: v == "bye"; after taken once, v becomes "zuzu".
   * accumulator: res is reset to 0.
   * template: path-sensitive field mutation + reset accumulator.
   */
  int res = 0;
  /*@ maintaining n <= 0 ==> i == n && res == 0;
    @ maintaining n > 0 ==> 0 <= i && i <= n && res == 0;
    @ maintaining n > 0 && i < n ==> t == i + 1;
    @ maintaining n > 0 && i < n && \old(v) == "bye" ==> v == "zuzu";
    @ maintaining \old(v) != "bye" ==> v == \old(v);
    @ loop_assigns i, res, v, t;
    @ decreases i;
    @*/
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(v == "bye") {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    res = 0;
    t = i;
  }
  return res;
}

/*@ normal_behavior
  @   requires n <= 0 || (0 < n && n <= 65535);
  @   assignable v, t;
  @   ensures n <= 0 ==> \result == 0;
  @   ensures n > 0 ==> \result == n * (n + 1) / 2
  @                       + ((\old(v) == "bye") ? 1 : 0);
  @   ensures n > 0 ==> t == 1;
  @   ensures n <= 0 ==> t == \old(t);
  @   ensures n <= 0 ==> v == \old(v);
  @   ensures n > 0 && \old(v) == "bye" ==> v == "zuzu";
  @   ensures n > 0 && \old(v) != "bye" ==> v == \old(v);
  @*/
public int wrongSum5(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-down.
   * counter/init/guard/step: i / n / i > 0 / i--.
   * assigned: i, res, local z, fields v and t.
   * accumulator: res accumulates descending range, plus one if the old v=="bye".
   * branch guard: v == "bye"; after first taken path v is "zuzu".
   * template: descending range sum + one-shot guarded field mutation.
   */
  int res = 0;
  /*@ maintaining n <= 0 ==> i == n && res == 0;
    @ maintaining n > 0 ==> 0 <= i && i <= n;
    @ maintaining n > 0 ==> res == (\sum int k; i < k && k <= n; k)
    @                    + ((i < n && \old(v) == "bye") ? 1 : 0);
    @ maintaining i < n && \old(v) == "bye" ==> v == "zuzu";
    @ maintaining \old(v) != "bye" ==> v == \old(v);
    @ maintaining i < n ==> t == i + 1;
    @ loop_assigns i, res, v, t;
    @ decreases i;
    @*/
  for(int i=n; i>0; i--) {
    res += i;
    int z = 9;
    z = i;
    if(v == "bye") {
      v = "hi";
      res += 1;
      v = "zuzu";
    }
    t = i;
  }
  return res;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int for1(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-down.
   * counter/init/guard/step: i / n / i > 0 / i--.
   * assigned: i only. reads: n. no arrays.
   * semantic template: counter-only loop; no semantic accumulator.
   */
  int res = 0;
  /*@ maintaining res == 0;
    @ maintaining n <= 0 ==> i == n;
    @ maintaining n > 0 ==> 0 <= i && i <= n;
    @ loop_assigns i;
    @ decreases i;
    @*/
  for(int i=n; i>0; i--) {
  }
  return res;
}

/*@ normal_behavior
  @   requires n <= 0 || (0 < n && n <= Integer.MAX_VALUE);
  @   assignable \nothing;
  @   ensures n <= 0 ==> \result == 0;
  @   ensures n > 0 ==> \result == (((n / 2) % 3 == 0) ? (n / 2) * 3 : (n / 2));
  @*/
public int for2(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-down.
   * counter/init/guard/step: i / n / i > 0 / i--.
   * assigned: i, res.
   * branch guard: i % 2 == 0.
   * accumulator: res counts even integers in processed descending suffix.
   * post-loop transform: if res % 3 == 0 then res *= 3.
   * template: guarded count accumulator + post-loop transformer.
   */
  int res = 0;
  /*@ maintaining n <= 0 ==> i == n && res == 0;
    @ maintaining n > 0 ==> 0 <= i && i <= n;
    @ maintaining n > 0 ==> res == (\num_of int k; i < k && k <= n; k % 2 == 0);
    @ loop_assigns i, res;
    @ decreases i;
    @*/
  for(int i=n; i>0; i--) {
    if(i % 2 == 0) {
      res += 1;
    }
  }
  if(res % 3 == 0) {
    res *= 3;
  }
  return res;
}

/*@ normal_behavior
  @   requires n <= 0 || (0 < n && n <= 85899345);
  @   assignable \nothing;
  @   ensures n <= 0 ==> \result == ((n % 2 == 0) ? 10 : 20);
  @   ensures n > 0 ==> \result ==
  @       (((((n % 2 == 0) ? 10 : 20) + 5 * (n / 2)) % 3 == 0)
  @          ? (((n % 2 == 0) ? 10 : 20) + 5 * (n / 2)) * 3
  @          : (((n % 2 == 0) ? 10 : 20) + 5 * (n / 2)));
  @*/
public int for3(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-down after an initial parity branch.
   * counter/init/guard/step: i / n / i > 0 / i--.
   * assigned: i, a.
   * branch guard in loop: i % 2 == 0.
   * accumulator: a starts from parity-selected constant and adds 5 per even i.
   * post-loop transform: if a % 3 == 0 then a *= 3.
   * template: initial branch constant + guarded scaled count accumulator.
   */
  int a;
  if(n % 2 == 0) {
    a = 10;
  }
  else {
    a = 20;
  }

  /*@ maintaining n <= 0 ==> i == n && a == ((n % 2 == 0) ? 10 : 20);
    @ maintaining n > 0 ==> 0 <= i && i <= n;
    @ maintaining n > 0 ==> a == ((n % 2 == 0) ? 10 : 20)
    @               + 5 * (\num_of int k; i < k && k <= n; k % 2 == 0);
    @ loop_assigns i, a;
    @ decreases i;
    @*/
  for(int i=n; i>0; i--) {
    if(i % 2 == 0) {
      a += 5;
    }
  }

  if(a % 3 == 0) {
    a *= 3;
  }

  return a;
}

/*@ normal_behavior
  @   requires n <= 0;
  @   assignable \nothing;
  @   ensures \result == 0;
  @ also
  @ normal_behavior
  @   requires 0 < n && n <= 65535;
  @   assignable \nothing;
  @   ensures \result == n * (n + 1) / 2;
  @*/
public int sum1(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for with mutated parameter as counter.
   * counter/init/guard/step: n / method input / n > 0 / n--.
   * assigned: n, res.
   * accumulator: res accumulates old n down to current n+1.
   * template: mutated-parameter descending triangular-sum; needs \old(n) or a ghost n0.
   */
  int res = 0;
  /*@ maintaining \old(n) <= 0 ==> n == \old(n) && res == 0;
    @ maintaining \old(n) > 0 ==> 0 <= n && n <= \old(n);
    @ maintaining \old(n) > 0 ==> res == (\old(n) * (\old(n) + 1) - n * (n + 1)) / 2;
    @ loop_assigns n, res;
    @ decreases n;
    @*/
  for(; n>0; n--) {
    res += n;
  }
  return res;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == "231";
  @*/
public String sum1Call1() {
  /* LOOP DATAFLOW ANSWERS: no loop; straight-line call to sum1(21). */
  return toString(sum1(21));
}

/*@ normal_behavior
  @   requires x <= 0 || (0 < x && x <= 65535);
  @   assignable \nothing;
  @   ensures x <= 0 ==> \result == "0";
  @   ensures x > 0 ==> \result == toString(x * (x + 1) / 2);
  @*/
public String sum1Call2() {
  /* LOOP DATAFLOW ANSWERS: no loop; delegates to sum1(x). */
  return toString(sum1(x));
}

/*@ normal_behavior
  @   assignable x;
  @   ensures x == 3;
  @   ensures \result == "6";
  @*/
public String sum1Call3() {
  /* LOOP DATAFLOW ANSWERS: no loop; assigns x then delegates to sum1(3). */
  x = 3;
  return toString(sum1(x));
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 231;
  @*/
public int sum2() {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for with unused local initializer and mutated local n.
   * counter/init/guard/step: n / 21 / n > 0 / n--.
   * assigned: n, res.
   * accumulator: descending triangular sum from 21.
   * template: local descending triangular-sum.
   */
  int res = 0;
  int n = 21;
  /*@ maintaining 0 <= n && n <= 21;
    @ maintaining res == (21 * 22 - n * (n + 1)) / 2;
    @ loop_assigns n, res;
    @ decreases n;
    @*/
  for(int i=0; n>0; n--) {
    res += n;
  }
  return res;
}

/*@ normal_behavior
  @   requires n <= 0;
  @   assignable \nothing;
  @   ensures \result == 0;
  @ also
  @ normal_behavior
  @   requires 0 < n && n <= 65535;
  @   assignable \nothing;
  @   ensures \result == n * (n + 1) / 2;
  @*/
public int sum4(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for with body decrement.
   * counter/init/guard/step: n / method input / n > 0 / body n--.
   * assigned: n, res.
   * accumulator: descending triangular sum.
   * template: while-style mutated-parameter triangular sum.
   */
  int res = 0;
  /*@ maintaining \old(n) <= 0 ==> n == \old(n) && res == 0;
    @ maintaining \old(n) > 0 ==> 0 <= n && n <= \old(n);
    @ maintaining \old(n) > 0 ==> res == (\old(n) * (\old(n) + 1) - n * (n + 1)) / 2;
    @ loop_assigns n, res;
    @ decreases n;
    @*/
  for(;n>0;) {
    res += n;
     n--;
  }
  return res;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 6;
  @*/
public int sum4Call() {
  /* LOOP DATAFLOW ANSWERS: no loop; delegates to sum4(3). */
  return sum4(3);
}

/*@ normal_behavior
  @   requires n <= 0;
  @   assignable \nothing;
  @   ensures \result == 0;
  @ also
  @ normal_behavior
  @   requires 0 < n && n <= 65535;
  @   assignable \nothing;
  @   ensures \result == n * (n + 1) / 2;
  @*/
public int sum1_While(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: while with mutated parameter.
   * counter/init/guard/step: n / method input / n > 0 / body n--.
   * assigned: n, res.
   * accumulator: descending triangular sum.
   */
  int res = 0;
  /*@ maintaining \old(n) <= 0 ==> n == \old(n) && res == 0;
    @ maintaining \old(n) > 0 ==> 0 <= n && n <= \old(n);
    @ maintaining \old(n) > 0 ==> res == (\old(n) * (\old(n) + 1) - n * (n + 1)) / 2;
    @ loop_assigns n, res;
    @ decreases n;
    @*/
  while(n>0) {
    res += n;
    n--;
  }
  return res;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 6;
  @*/
public int sum1_WhileCall() {
  /* LOOP DATAFLOW ANSWERS: no loop; delegates to sum1_While(3). */
  return sum1_While(3);
}

/*@ normal_behavior
  @   requires n <= 0;
  @   assignable \nothing;
  @   ensures \result == n;
  @ also
  @ normal_behavior
  @   requires 0 < n && n <= 65535;
  @   assignable \nothing;
  @   ensures \result == n * (n + 1) / 2;
  @*/
public int sum1_While2(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: while(true) with internal break; executes at least once.
   * counter/init/guard/step: n / method input / true / body n--.
   * assigned: n, res.
   * break condition: after decrement, n <= 0.
   * accumulator: for old n > 0, descending triangular sum.
   * special case: for old n <= 0, one iteration returns old n.
   * template: while-true-break + conditional triangular sum.
   */
  int res = 0;
  /*@ maintaining \old(n) <= 0 ==> n == \old(n) && res == 0;
    @ maintaining \old(n) > 0 ==> 0 < n && n <= \old(n);
    @ maintaining \old(n) > 0 ==> res == (\old(n) * (\old(n) + 1) - n * (n + 1)) / 2;
    @ loop_assigns n, res;
    @ decreases n > 0 ? n : 0;
    @*/
  while(true) {
    res += n;
    n--;
    if(n<=0) {
      break;
    }
  }
  return res;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int sum1_While2Call1() {
  /* LOOP DATAFLOW ANSWERS: no loop; delegates to sum1_While2(0). */
  return sum1_While2(0);
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 6;
  @*/
public int sum1_While2Call2() {
  /* LOOP DATAFLOW ANSWERS: no loop; delegates to sum1_While2(3). */
  return sum1_While2(3);
}

/*@ normal_behavior
  @   requires nums != null;
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < nums.length && nums[k] % 2 != 0; nums[k]);
  @*/
public int sumOddNums(int[] nums) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up over array.
   * counter/init/guard/step: i / 0 / i < nums.length / i++.
   * assigned: i, sum.
   * array reads: nums[i]. array writes: none.
   * continue condition: nums[i] % 2 == 0.
   * accumulator: sum += nums[i] guarded by nums[i] % 2 != 0.
   * template: guarded numeric array accumulator with continue.
   */
  int sum = 0;
  /*@ maintaining 0 <= i && i <= nums.length;
    @ maintaining sum == (\sum int k; 0 <= k && k < i && nums[k] % 2 != 0; nums[k]);
    @ loop_assigns i, sum;
    @ decreases nums.length - i;
    @*/
  for (int i=0; i<nums.length; i++) {
      if (nums[i] % 2 == 0) {
          continue;
      }
      sum += nums[i];
  }
  return sum;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
public int sumOddNumsCall1() {
  /* LOOP DATAFLOW ANSWERS: no loop; delegates to sumOddNums on literal array. */
  int x = sumOddNums(new int[]{1,2,3,4});
  return x;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
public int sumOddNumsCall2() {
  /* LOOP DATAFLOW ANSWERS: no loop; delegates to sumOddNums on literal array. */
  int x = sumOddNums(new int[]{1,3});
  return x;
}

/*@ normal_behavior
  @   requires nums != null;
  @   assignable \nothing;
  @   ensures (\exists int m; 0 <= m && m <= nums.length
  @             && (\forall int k; 0 <= k && k < m; nums[k] >= 0)
  @             && (m == nums.length || nums[m] < 0)
  @             && \result == (\sum int k; 0 <= k && k < m; nums[k]));
  @*/
public int sumUntilNegative(int[] nums) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up over array.
   * counter/init/guard/step: i / 0 / i < nums.length / i++.
   * assigned: i, sum.
   * array reads: nums[i]. writes: none.
   * break condition: nums[i] < 0.
   * accumulator: sum over nonnegative prefix before first negative.
   * template: prefix sum until break.
   */
    int sum = 0;
    /*@ maintaining 0 <= i && i <= nums.length;
      @ maintaining (\forall int k; 0 <= k && k < i; nums[k] >= 0);
      @ maintaining sum == (\sum int k; 0 <= k && k < i; nums[k]);
      @ loop_assigns i, sum;
      @ decreases nums.length - i;
      @*/
    for (int i=0; i<nums.length; i++) {
        if (nums[i] < 0) {
            break;
        }
        sum += nums[i];
    }
    return sum;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int sumUntilNegativeCall1() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  return sumUntilNegative(new int[]{});
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int sumUntilNegativeCall2() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  return sumUntilNegative(new int[]{4,1,-2,1});
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < arr.length;
  @                            arr[k] % 2 == 0 ? arr[k] : -arr[k]);
  @*/
public int processArray1(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up.
   * counter/init/guard/step: i / 0 / i < arr.length / i++.
   * assigned: i, sum.
   * array reads: arr[i]. writes: none.
   * branch: even adds arr[i], odd subtracts arr[i].
   * template: path-sensitive signed array fold.
   */
  int sum = 0;
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining sum == (\sum int k; 0 <= k && k < i;
    @                            arr[k] % 2 == 0 ? arr[k] : -arr[k]);
    @ loop_assigns i, sum;
    @ decreases arr.length - i;
    @*/
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] % 2 == 0) {
      sum += arr[i];
    } else {
      sum -= arr[i];
    }
  }
  return sum;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public int processArray1Call() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int x = processArray1(new int[]{1,2,3,4});
  return x;
}

/*@ normal_behavior
  @   requires 0 <= size;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures \result.length == size;
  @   ensures (\forall int k; 0 <= k && k < size; \result[k] == elem);
  @*/
public int[] fillArray(int size, int elem) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up over freshly allocated array.
   * counter/init/guard/step: i / 0 / i < size / i++.
   * assigned: i, arr[*].
   * array writes: arr[i] = elem. array reads: none.
   * allocation: arr is fresh and arr.length == size.
   * template: array fill.
   */
  int[] arr = new int[size];
  /*@ maintaining 0 <= i && i <= size;
    @ maintaining arr.length == size;
    @ maintaining (\forall int k; 0 <= k && k < i; arr[k] == elem);
    @ loop_assigns i, arr[*];
    @ decreases size - i;
    @*/
  for(int i=0; i<size; i++) {
    arr[i] = elem;
  }
  return arr;
}

/*@ normal_behavior
  @   assignable \nothing;
  @*/
public void fillArrayCall() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  println(fillArray(5,10));
}

/*@ normal_behavior
  @   requires 0 <= y && y <= 46340;
  @   requires (\exists int r; 0 <= r && r <= y && r * r == y);
  @   assignable \nothing;
  @   ensures 0 <= \result && \result <= y;
  @   ensures \result * \result == y;
  @ also
  @ exceptional_behavior
  @   requires 0 <= y && y <= 46340;
  @   requires !(\exists int r; 0 <= r && r <= y && r * r == y);
  @   assignable \nothing;
  @   signals_only Exception;
  @   signals (Exception e) true;
  @*/
public static int sqrt(int y) throws Exception{
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: bounded for-search.
   * counter/init/guard/step: i / 0 / i <= y / i = i + 1.
   * assigned: i, local j.
   * arithmetic: j = i*i; requires y <= 46340 to avoid square overflow.
   * exits: return when i*i == y; throw on final i==y with no match.
   * template: bounded search with return-or-throw.
   */
  /*@ maintaining 0 <= i && i <= y + 1;
    @ maintaining (\forall int k; 0 <= k && k < i; k * k != y);
    @ loop_assigns i;
    @ decreases y - i + 1;
    @*/
  for(int i=0; i<=y; i=i+1){
    int j = i*i;
    if(j==y){
      return i;
    }
    else{
      if(i==y){
        throw new Exception("not found");
      }
    }
  }
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 3;
  @*/
public static int sqrtCall1() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int x = sqrt(9);
  return x;
}

/*@ exceptional_behavior
  @   assignable \nothing;
  @   signals_only Exception;
  @   signals (Exception e) true;
  @*/
public static int sqrtCall2() {
  /* LOOP DATAFLOW ANSWERS: no loop; delegates to exceptional sqrt(8). */
  int x = sqrt(8);
  return x;
}

/*@ normal_behavior
  @   requires input != null;
  @   assignable status;
  @   ensures input.length > 0 ==> status == "non-empty";
  @   ensures input.length <= 0 ==> status == "empty";
  @*/
public void boo34(String input){
  /* LOOP DATAFLOW ANSWERS: no loop; conditional field assignment. */
  if (input.length > 0) {
    String msg = "non-empty";
    status = msg;
  } else {
    String msg = "empty";
    status = msg;
  }
}

/*@ normal_behavior
  @   assignable status;
  @   ensures status == "empty";
  @*/
public void boo34Call() {
  /* LOOP DATAFLOW ANSWERS: no loop; two calls to boo34. */
  boo34("Hello");
  println(status);
  boo34("");
  println(status);
}

/*@ exceptional_behavior
  @   requires arr == null || arr.length == 0;
  @   assignable \nothing;
  @   signals_only Exception;
  @   signals (Exception e) true;
  @ also
  @ normal_behavior
  @   requires arr != null && arr.length > 0;
  @   assignable \nothing;
  @   ensures (\exists int k; 0 <= k && k < arr.length; \result == arr[k]);
  @   ensures (\forall int k; 0 <= k && k < arr.length; arr[k] <= \result);
  @*/
public static int getMax(int[] arr) throws Exception {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up starting at 1.
   * counter/init/guard/step: i / 1 / i < arr.length / i++.
   * assigned: i, max.
   * array reads: arr[0], arr[i]. writes: none.
   * branch: if arr[i] > max then max = arr[i].
   * template: max scan over processed prefix.
   */
  if(arr.length == 0) {
    throw new Exception("empty array");
  }
  else {
    int max = arr[0];
    /*@ maintaining 1 <= i && i <= arr.length;
      @ maintaining (\exists int k; 0 <= k && k < i; max == arr[k]);
      @ maintaining (\forall int k; 0 <= k && k < i; arr[k] <= max);
      @ loop_assigns i, max;
      @ decreases arr.length - i;
      @*/
    for(int i=1; i<arr.length; i++) {
      if(arr[i] > max) {
        max = arr[i];
      }
    }
    return max;
  }
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 9;
  @*/
public static int getMaxCall() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  return getMax(new int[] {5,4,6,4,7,8,9,0,1});
}

/*@ normal_behavior
  @   requires arr != null;
  @   requires 0 <= i && i < arr.length;
  @   requires 0 <= j && j < arr.length;
  @   assignable arr[i], arr[j];
  @   ensures arr[i] == \old(arr[j]);
  @   ensures arr[j] == \old(arr[i]);
  @   ensures (\forall int k; 0 <= k && k < arr.length && k != i && k != j; arr[k] == \old(arr[k]));
  @*/
private static void swap(int[] arr, int i, int j) {
  /* LOOP DATAFLOW ANSWERS: no loop; helper frame is essential for partition/bubble reasoning. */
  int temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

/*@ normal_behavior
  @   assignable \nothing;
  @*/
private static void swapCall() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = new int[] {5,4,6,4,7,8,9,0,1};
  swap(arr,0,1);
}

/*@ normal_behavior
  @   requires arr != null;
  @   requires 0 <= low && low <= high && high < arr.length;
  @   assignable arr[low .. high];
  @   ensures low <= \result && \result <= high;
  @   ensures arr[\result] == \old(arr[high]);
  @   ensures (\forall int k; low <= k && k < \result; arr[k] < arr[\result]);
  @   ensures (\forall int k; \result < k && k <= high; arr[k] >= arr[\result]);
  @*/
private static int partition(int[] arr, int low, int high) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: Lomuto partition for-loop.
   * counter/init/guard/step: j / low / j < high / j++.
   * secondary index: i starts at low-1 and increments only when arr[j] < pivot.
   * assigned: j, i, arr[low..high] through swap.
   * array reads/writes: arr[j], arr[high], swap(arr,i,j).
   * helper dependency: needs precise swap contract.
   * template: partition two-region invariant with fixed pivot.
   * missing hard fact: permutation/multiset preservation needs a model predicate.
   */
  int pivot = arr[high];
  int i = low - 1;
  /*@ maintaining low - 1 <= i && i < j && low <= j && j <= high;
    @ maintaining pivot == \old(arr[high]);
    @ maintaining arr[high] == pivot;
    @ maintaining (\forall int k; low <= k && k <= i; arr[k] < pivot);
    @ maintaining (\forall int k; i < k && k < j; arr[k] >= pivot);
    @ loop_assigns i, j, arr[low .. high - 1];
    @ decreases high - j;
    @*/
  for (int j = low; j < high; j++) {
    if (arr[j] < pivot) {
      i++;
      swap(arr, i, j);
    }
  }
  swap(arr, i + 1, high);
  return i + 1;
}

/*@ normal_behavior @ assignable \nothing; @*/
private static void partitionCall1() {
  /* LOOP DATAFLOW ANSWERS: no loop; literal test for partition. */
  int[] arr = {7};
  int x = partition(arr,0,0);
  println(arr);
  println(toString(x));
}

/*@ normal_behavior @ assignable \nothing; @*/
private static void partitionCall2() {
  /* LOOP DATAFLOW ANSWERS: no loop; literal test for partition. */
  int[] arr = {9,7};
  int x = partition(arr,0,1);
  println(arr);
  println(toString(x));
}

/*@ normal_behavior @ assignable \nothing; @*/
private static void partitionCall3() {
  /* LOOP DATAFLOW ANSWERS: no loop; literal test for partition. */
  int[] arr = {3,7};
  int x = partition(arr,0,1);
  println(arr);
  println(toString(x));
}

/*@ normal_behavior @ assignable \nothing; @*/
private static void partitionCall4() {
  /* LOOP DATAFLOW ANSWERS: no loop; literal test for partition. */
  int[] arr = {9,3,7};
  int x = partition(arr,0,2);
  println(arr);
  println(toString(x));
}

/*@ normal_behavior @ assignable \nothing; @*/
private static void partitionCall5() {
  /* LOOP DATAFLOW ANSWERS: no loop; literal test for partition. */
  int[] arr = {1,2,7};
  int x = partition(arr,0,2);
  println(arr);
  println(toString(x));
}

/*@ normal_behavior @ assignable \nothing; @*/
private static void partitionCall6() {
  /* LOOP DATAFLOW ANSWERS: no loop; literal test for partition. */
  int[] arr = {9,8,7};
  int x = partition(arr,0,2);
  println(arr);
  println(toString(x));
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \result <==> (\forall int k; 0 <= k && k + 1 < arr.length; arr[k] <= arr[k+1]);
  @*/
public boolean isAscending1(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up over adjacent pairs.
   * counter/init/guard/step: i / 0 / i < arr.length - 1 / i++.
   * assigned: i, res.
   * array reads: arr[i], arr[i+1]. writes: none.
   * branch: violation sets res=false and never restores it.
   * template: boolean accumulator for universal prefix property.
   */
  boolean res = true;
  /*@ maintaining 0 <= i && i <= (arr.length <= 1 ? 0 : arr.length - 1);
    @ maintaining res <==> (\forall int k; 0 <= k && k < i; arr[k] <= arr[k+1]);
    @ loop_assigns i, res;
    @ decreases (i < arr.length - 1 ? arr.length - 1 - i : 0);
    @*/
  for(int i = 0; i<arr.length-1; i++) {
    if(arr[i] > arr[i+1]) {
      res = false;
    }
  }
  return res;
}

/*@ normal_behavior @ assignable \nothing; @*/
public void isAscending1Call() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr1 = new int[]{1,2,4,6,7,99};
  int[] arr2 = new int[]{1,2,4,7,6,99};
  println(toString(isAscending1(arr1)));
  println(toString(isAscending1(arr2)));
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \result <==> (\forall int k; 0 <= k && k + 1 < arr.length; arr[k] <= arr[k+1]);
  @*/
public boolean isAscending2(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up over adjacent pairs.
   * counter/init/guard/step: i / 0 / i < arr.length - 1 / i++.
   * assigned: i only.
   * array reads: arr[i], arr[i+1].
   * early return: returns false on first violation.
   * template: universal prefix property with early return.
   */
  /*@ maintaining 0 <= i && i <= (arr.length <= 1 ? 0 : arr.length - 1);
    @ maintaining (\forall int k; 0 <= k && k < i; arr[k] <= arr[k+1]);
    @ loop_assigns i;
    @ decreases (i < arr.length - 1 ? arr.length - 1 - i : 0);
    @*/
  for(int i = 0; i<arr.length-1; i++) {
    if(arr[i] > arr[i+1]) {
      return false;
    }
  }
  return true;
}

/*@ normal_behavior @ assignable \nothing; @*/
public void isAscending2Call() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr1 = new int[]{1,2,4,6,7,99};
  int[] arr2 = new int[]{1,2,4,7,6,99};
  println(toString(isAscending2(arr1)));
  println(toString(isAscending2(arr2)));
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures \result.length == arr.length;
  @   ensures (\forall int k; 0 <= k && k < arr.length; \result[k] == arr[k]);
  @*/
public int[] copyArray(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up over source array.
   * counter/init/guard/step: i / 0 / i < arr.length / i++.
   * assigned: i, copy[*].
   * array reads: arr[i]. writes: copy[i].
   * allocation: copy is fresh; copy.length == arr.length.
   * template: fresh array copy prefix.
   */
  int[] copy = new int[arr.length];
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining copy.length == arr.length;
    @ maintaining (\forall int k; 0 <= k && k < i; copy[k] == arr[k]);
    @ loop_assigns i, copy[*];
    @ decreases arr.length - i;
    @*/
  for(int i=0; i<arr.length; i++) {
    copy[i] = arr[i];
  }
  return copy;
}

/*@ normal_behavior @ assignable \nothing; @*/
public void copyArrayCall() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = new int[]{1,4,6,8};
  int[] c = copyArray(arr);
  println(arr);
  println(c);
}

/*@ normal_behavior
  @   requires arr != null;
  @   requires arr.length < Integer.MAX_VALUE;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures \result.length == arr.length + 1;
  @   ensures (\forall int k; 0 <= k && k < arr.length; \result[k] == arr[k]);
  @   ensures \result[arr.length] == elem;
  @*/
public int[] addElemRight(int[] arr, int elem) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up copy, followed by append.
   * counter/init/guard/step: i / 0 / i < arr.length / i++.
   * assigned: i, res[*].
   * array reads: arr[i]. writes: res[i].
   * allocation: res.length == arr.length + 1.
   * template: fresh array copy prefix + append postcondition.
   */
  int[] res = new int[arr.length + 1];
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining res.length == arr.length + 1;
    @ maintaining (\forall int k; 0 <= k && k < i; res[k] == arr[k]);
    @ loop_assigns i, res[*];
    @ decreases arr.length - i;
    @*/
  for(int i=0; i<arr.length; i++) {
    res[i] = arr[i];
  }
  res[arr.length] = elem;
  return res;
}

/*@ normal_behavior @ assignable \nothing; @*/
public void addElemRightCall() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = addElemRight(new int[]{1,2,3},4);
  println(arr);
}

/*@ normal_behavior
  @   requires arr != null;
  @   requires 0 <= pos && pos < arr.length;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures \result.length == arr.length - 1;
  @   ensures (\forall int k; 0 <= k && k < pos; \result[k] == arr[k]);
  @   ensures (\forall int k; pos <= k && k < \result.length; \result[k] == arr[k+1]);
  @*/
public int[] removeAtPos(int[] arr, int pos) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up with continue.
   * counter/init/guard/step: i / 0 / i < arr.length / i++.
   * secondary counter: j counts copied elements.
   * assigned: i, j, res[*].
   * skip condition: i == pos.
   * array reads: arr[i]. writes: res[j].
   * template: two-counter copy-skip.
   */
  int[] res = new int[arr.length-1];
  int j = 0;
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining 0 <= j && j <= res.length;
    @ maintaining j == i - (i > pos ? 1 : 0);
    @ maintaining (\forall int k; 0 <= k && k < j && k < pos; res[k] == arr[k]);
    @ maintaining (\forall int k; pos <= k && k < j; res[k] == arr[k+1]);
    @ loop_assigns i, j, res[*];
    @ decreases arr.length - i;
    @*/
  for(int i=0; i<arr.length; i++) {
    if(i == pos) {
      continue;
    }
    res[j] = arr[i];
    j++;
  }
  return res;
}

/*@ normal_behavior @ assignable \nothing; @*/
public void removeAtPosCall1() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = removeAtPos(new int[]{1,2,3},1);
  println(arr);
}

/*@ normal_behavior @ assignable \nothing; @*/
public void removeAtPosCall2() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = removeAtPos(new int[]{4,9},0);
  println(arr);
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures (\exists int m; 0 <= m && m <= arr.length
  @             && (\forall int k; 0 <= k && k < m; arr[k] % 2 == 0)
  @             && (m == arr.length || arr[m] % 2 != 0)
  @             && \result.length == m
  @             && (\forall int k; 0 <= k && k < m; \result[k] == arr[k]));
  @*/
public int[] takeWhileAsLongAsEven(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * outer loopKind: for-counting-up with early return.
   * outer counter/init/guard/step: i / 0 / i < arr.length / i++.
   * assigned: i, res.
   * branch: even -> allocate temp and append; odd -> return res.
   * nested loop: j copies old res prefix and writes temp[i] = arr[i].
   * template: take-while prefix + nested append-copy.
   */
  int[] res = new int[0];
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining res.length == i;
    @ maintaining (\forall int k; 0 <= k && k < i; arr[k] % 2 == 0);
    @ maintaining (\forall int k; 0 <= k && k < i; res[k] == arr[k]);
    @ loop_assigns i, res;
    @ decreases arr.length - i;
    @*/
  for(int i=0; i<arr.length; i++) {
    if(arr[i] % 2 == 0) {
      int[] temp = new int[res.length+1];
      /* NESTED LOOP DATAFLOW: j / 0 / j <= i / j++; writes temp[j]; copies res prefix and appends arr[i]. */
      /*@ maintaining 0 <= j && j <= i + 1;
        @ maintaining temp.length == i + 1;
        @ maintaining (\forall int k; 0 <= k && k < j && k < i; temp[k] == res[k]);
        @ maintaining j == i + 1 ==> temp[i] == arr[i];
        @ loop_assigns j, temp[*];
        @ decreases i + 1 - j;
        @*/
      for(int j=0; j<=i; j++) {
        if(j<i) {
         temp[j] = res[j];
        }
        else {
          temp[j] = arr[i];
        }
      }
      res = temp;
    }
    else {
      return res;
    }
  }
  return res;
}

/*@ normal_behavior @ assignable \nothing; @*/
public void takeWhileAsLongAsEvenCall1() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = takeWhileAsLongAsEven(new int[]{2,4,6,8});
  println(arr);
}

/*@ normal_behavior @ assignable \nothing; @*/
public void takeWhileAsLongAsEvenCall2() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = takeWhileAsLongAsEven(new int[]{2,4,7,6,8});
  println(arr);
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable arr[*];
  @   ensures (\forall int k; 0 <= k && k + 1 < arr.length; arr[k] <= arr[k+1]);
  @*/
public static void bubbleSort(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * outer loopKind: for-counting-up over passes.
   * outer counter/init/guard/step: i / 0 / i < n - 1 / i++.
   * inner counter/init/guard/step: j / 0 / j < n - i - 1 / j++.
   * assigned: i, j, arr[*], temp.
   * array reads/writes: adjacent arr[j], arr[j+1], swapped if out of order.
   * template: nested bubble-sort; inner bubbles max of unsorted prefix rightward;
   * outer grows sorted suffix.
   * missing hard fact: permutation preservation needs multiset model predicate.
   */
  int n = arr.length;
  /*@ maintaining 0 <= i && i <= (n <= 1 ? 0 : n - 1);
    @ maintaining n == arr.length;
    @ maintaining (\forall int p; n - i <= p && p + 1 < n; arr[p] <= arr[p+1]);
    @ maintaining (\forall int p, q; 0 <= p && p < n - i && n - i <= q && q < n; arr[p] <= arr[q]);
    @ loop_assigns i, arr[*];
    @ decreases (i < n - 1 ? n - 1 - i : 0);
    @*/
  for (int i = 0; i < n - 1; i++) {
    /*@ maintaining 0 <= j && j <= n - i - 1;
      @ maintaining n == arr.length;
      @ maintaining (\forall int k; 0 <= k && k <= j; arr[k] <= arr[j]);
      @ maintaining (\forall int p; n - i <= p && p + 1 < n; arr[p] <= arr[p+1]);
      @ loop_assigns j, arr[*];
      @ decreases n - i - 1 - j;
      @*/
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public static void bubbleSortCall() {
  /* LOOP DATAFLOW ANSWERS: no loop; note original source returns arr from a void method. */
  int[] arr = new int[] {5,4,6,4,7,8,9,0,1};
  bubbleSort(arr);
  return arr;
}

/*@ normal_behavior
  @   requires v != null;
  @   assignable \nothing;
  @   ensures \result != null;
  @   ensures n <= 0 ==> \result == "";
  @*/
public String replicate(int n,String v) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-down.
   * counter/init/guard/step: i / n / i > 0 / i--.
   * assigned: i, res.
   * string accumulator: res += core.
   * template: string repeat accumulator; exact spec needs pure repeat(v,count).
   */
  String core = v;
  String res = "";
  /*@ maintaining core == v;
    @ maintaining res != null;
    @ maintaining n <= 0 ==> i == n && res == "";
    @ maintaining n > 0 ==> 0 <= i && i <= n;
    @ loop_assigns i, res;
    @ decreases i;
    @*/
  for(int i=n; i>0; i--) {
    res += core;
  }
  return res;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == "qwqwqwqwqw";
  @*/
public String replicateCall() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  String str = replicate(5,"qw");
  return str;
}

/*@ normal_behavior
  @   requires n <= 0;
  @   assignable \nothing;
  @   ensures \result == 0;
  @ also
  @ normal_behavior
  @   requires 0 < n && n <= 65535;
  @   assignable \nothing;
  @   ensures \result == n * (n + 1) / 2;
  @*/
public int sum3(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: infinite for(;;) with leading break.
   * counter/init/guard/step: n / method input / true / for-update n--.
   * assigned: n, res.
   * break condition: n <= 0 before accumulation.
   * accumulator: for old n > 0, descending triangular sum.
   * template: infinite-loop-with-break + descending sum.
   */
  int res = 0;
  /*@ maintaining \old(n) <= 0 ==> n == \old(n) && res == 0;
    @ maintaining \old(n) > 0 ==> 0 <= n && n <= \old(n);
    @ maintaining \old(n) > 0 ==> res == (\old(n) * (\old(n) + 1) - n * (n + 1)) / 2;
    @ loop_assigns n, res;
    @ decreases n > 0 ? n : 0;
    @*/
  for(;; n--) {
    if (n<=0) {
      break;
    }
    res += n;
  }
  return res;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int sum3Call1() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int x = sum3(0);
  return x;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == 6;
  @*/
public int sum3Call2() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int x = sum3(3);
  return x;
}

/*@ exceptional_behavior
  @   requires arr == null || arr.length <= 1;
  @   assignable \nothing;
  @   signals_only Exception;
  @   signals (Exception e) true;
  @ also
  @ normal_behavior
  @   requires arr != null && arr.length > 1;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures \result.length == arr.length - 1;
  @   ensures (\forall int k; 0 <= k && k < \result.length; \result[k] == arr[k+1]);
  @*/
public static int[] tail(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up starting at 1.
   * counter/init/guard/step: i / 1 / i < arr.length / i++.
   * secondary counter: j starts 0 and increments with i.
   * assigned: i, j, arr2[*].
   * array reads: arr[i]. writes: arr2[j].
   * template: shifted copy prefix with j == i - 1.
   */
  if (arr == null || arr.length <= 1) {
    throw new Exception("array is too small");
  }
  else {
    int[] arr2 = new int[arr.length-1];
    int j = 0;
    /*@ maintaining 1 <= i && i <= arr.length;
      @ maintaining j == i - 1;
      @ maintaining (\forall int k; 0 <= k && k < j; arr2[k] == arr[k+1]);
      @ loop_assigns i, j, arr2[*];
      @ decreases arr.length - i;
      @*/
    for (int i = 1; i<arr.length; i++) {
      arr2[j] = arr[i];
      j++;
    }
    return arr2;
  }
}

/*@ exceptional_behavior @ assignable \nothing; signals_only Exception; signals (Exception e) true; @*/
public static void tailCall1() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
    println(tail(null));
}

/*@ exceptional_behavior @ assignable \nothing; signals_only Exception; signals (Exception e) true; @*/
public static void tailCall2() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
    println(tail(new int[]{}));
}

/*@ normal_behavior @ assignable \nothing; @*/
public static void tailCall3() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
    println(tail(new int[]{4, 9}));
}

/*@ normal_behavior @ assignable \nothing; @*/
public static void tailCall4() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
    println(tail(new int[]{4, 9, 2}));
}

/*@ normal_behavior
  @   requires arr != null;
  @   requires (\forall int k; 0 <= k && k < arr.length;
  @              Integer.MIN_VALUE / 2 <= arr[k] && arr[k] <= Integer.MAX_VALUE / 2);
  @   assignable arr[*];
  @   ensures (\forall int k; 0 <= k && k < arr.length; arr[k] == 2 * \old(arr[k]));
  @*/
public static void doubleArrayElems(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up in-place array update.
   * counter/init/guard/step: i / 0 / i < arr.length / i++.
   * assigned: i, local x, arr[*].
   * array reads: arr[i]. writes: arr[i].
   * template: in-place prefix map with unchanged suffix.
   */
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining (\forall int k; 0 <= k && k < i; arr[k] == 2 * \old(arr[k]));
    @ maintaining (\forall int k; i <= k && k < arr.length; arr[k] == \old(arr[k]));
    @ loop_assigns i, arr[*];
    @ decreases arr.length - i;
    @*/
  for(int i=0; i<arr.length; i++) {
    int x = arr[i];
    arr[i] += x;
  }
  println(arr);
}

/*@ normal_behavior @ assignable \nothing; @*/
public static void doubleArrayElemsCall() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  doubleArrayElems(new int[]{1,2,3});
}

/*@ normal_behavior
  @   requires arr != null;
  @   requires (\forall int k; 0 <= k && k < arr.length;
  @              Integer.MIN_VALUE / 2 <= arr[k] && arr[k] <= Integer.MAX_VALUE / 2);
  @   assignable arr[*];
  @   ensures (\forall int k; 0 <= k && k < arr.length; arr[k] == 2 * \old(arr[k]));
  @*/
public static void doubleArrayElems2(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: while-counting-up in-place array update.
   * counter/init/guard/step: i / 0 / i < arr.length / body i++.
   * assigned: i, local x, arr[*].
   * array reads/writes: arr[i].
   * template: in-place prefix map with unchanged suffix.
   */
  int i = 0;
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining (\forall int k; 0 <= k && k < i; arr[k] == 2 * \old(arr[k]));
    @ maintaining (\forall int k; i <= k && k < arr.length; arr[k] == \old(arr[k]));
    @ loop_assigns i, arr[*];
    @ decreases arr.length - i;
    @*/
  while(i<arr.length) {
    int x = arr[i];
    arr[i] += x;
    i++;
  }
  println(arr);
}

/*@ normal_behavior @ assignable \nothing; @*/
public static void doubleArrayElems2Call() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  doubleArrayElems2(new int[]{1,2,3});
}

/*@ normal_behavior
  @   requires arr == null || arr.length <= 1;
  @   assignable \nothing;
  @ also
  @ normal_behavior
  @   requires arr != null && arr.length > 1;
  @   requires arr.length <= Integer.MAX_VALUE / 2;
  @   assignable arr[*];
  @   ensures (\forall int k; 0 <= k && k + 1 < arr.length; arr[k] <= arr[k+1]);
  @*/
public static void quickSort(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: while worklist/stack over intervals.
   * guard: top >= 1; stack stores low/high pairs at even/odd positions.
   * assigned: top, stack[*], arr[*] through partition.
   * helper dependency: partition contract is essential.
   * arithmetic: arr.length * 2 allocation needs overflow precondition.
   * template: stack interval validity + partitioned subproblem processing.
   * remaining hard proof: sortedness and permutation need stronger partition/postcondition lemmas.
   */
  if (arr == null || arr.length <= 1) {
    return;
  }

  int[] stack = new int[arr.length * 2];
  int top = -1;

  top++;
  stack[top] = 0;
  top++;
  stack[top] = arr.length - 1;

  /*@ maintaining -1 <= top && top < stack.length;
    @ maintaining top == -1 || top % 2 == 1;
    @ maintaining (\forall int k; 0 <= k && k <= top && k % 2 == 0;
    @                0 <= stack[k] && stack[k] <= stack[k+1] && stack[k+1] < arr.length);
    @ loop_assigns top, stack[*], arr[*];
    @ decreases top + 1;
    @*/
  while (top >= 1) {
    int high = stack[top];
    top--;
    int low = stack[top];
    top--;

    int pivotIndex = partition(arr, low, high);

    if (pivotIndex - 1 > low) {
      top++;
      stack[top] = low;
      top++;
      stack[top] = pivotIndex - 1;
    }

    if (pivotIndex + 1 < high) {
      top++;
      stack[top] = pivotIndex + 1;
      top++;
      stack[top] = high;
    }
  }
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result == null;
  @*/
public static int[] quickSortCall1() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = null;
  quickSort(arr);
  return arr;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result.length == 1 && \result[0] == 7;
  @*/
public static int[] quickSortCall2() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = new int[] {7};
  quickSort(arr);
  return arr;
}

/*@ normal_behavior
  @   assignable \nothing;
  @   ensures \result.length == 5;
  @   ensures \result[0] == 1 && \result[1] == 2 && \result[2] == 3 && \result[3] == 4 && \result[4] == 5;
  @*/
public static int[] quickSortCall3() {
  /* LOOP DATAFLOW ANSWERS: no loop. */
  int[] arr = new int[] {1,5,2,4,3};
  quickSort(arr);
  return arr;
}

/*@ normal_behavior
  @   requires 0 <= n && n <= 12;
  @   assignable \nothing;
  @   ensures \result == (\product int k; 1 <= k && k <= n; k);
  @*/
public int factorial(int n) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up from 1 to n.
   * counter/init/guard/step: c / 1 / c <= n / c++.
   * assigned: c, p.
   * accumulator: p *= c.
   * arithmetic: product overflow bounded by n <= 12 for int.
   * template: multiplicative accumulator.
   */
  int p = 1;
  /*@ maintaining 1 <= c && c <= n + 1;
    @ maintaining p == (\product int k; 1 <= k && k < c; k);
    @ loop_assigns c, p;
    @ decreases n - c + 1;
    @*/
  for (int c = 1; c <= n; c++) {
    p *= c;
  }
  return p;
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures \result.length == arr.length;
  @   ensures (\forall int k; 0 <= k && k < arr.length; \result[k] == arr[arr.length - 1 - k]);
  @*/
public int[] reverseCopy(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up over result.
   * counter/init/guard/step: i / 0 / i < arr.length / i++.
   * assigned: i, res[*].
   * array reads: arr[arr.length - 1 - i]. writes: res[i].
   * template: reverse-copy prefix.
   */
  int[] res = new int[arr.length];
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining res.length == arr.length;
    @ maintaining (\forall int k; 0 <= k && k < i; res[k] == arr[arr.length - 1 - k]);
    @ loop_assigns i, res[*];
    @ decreases arr.length - i;
    @*/
  for (int i = 0; i < arr.length; i++) {
    res[i] = arr[arr.length - 1 - i];
  }
  return res;
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures -1 <= \result && \result < arr.length;
  @   ensures \result == -1 <==> !(\exists int k; 0 <= k && k < arr.length; arr[k] == x);
  @   ensures \result != -1 ==> arr[\result] == x;
  @   ensures \result != -1 ==> (\forall int k; 0 <= k && k < \result; arr[k] != x);
  @*/
public int indexOf(int[] arr, int x) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up search.
   * counter/init/guard/step: i / 0 / i < arr.length / i++.
   * assigned: i.
   * array reads: arr[i].
   * early return: if arr[i] == x return i.
   * template: search exclusion over processed prefix.
   */
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining (\forall int k; 0 <= k && k < i; arr[k] != x);
    @ loop_assigns i;
    @ decreases arr.length - i;
    @*/
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == x) return i;
  }
  return -1;
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \result == (arr.length + 1) / 2;
  @*/
public int countEverySecond(int[] arr) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: strided for-counting-up.
   * counter/init/guard/step: i / 0 / i < arr.length / i += 2.
   * assigned: i, c.
   * stride fact: i % 2 == 0.
   * accumulator: c == i / 2 at loop head.
   * template: strided counter + count accumulator.
   */
  int c = 0;
  /*@ maintaining 0 <= i && i <= arr.length + 1;
    @ maintaining i % 2 == 0;
    @ maintaining c == i / 2;
    @ loop_assigns i, c;
    @ decreases (i < arr.length ? arr.length - i : 0);
    @*/
  for (int i = 0; i < arr.length; i += 2) {
    c++;
  }
  return c;
}

/*@ normal_behavior
  @   requires a != null && b != null;
  @   requires a.length <= b.length;
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < a.length; a[k] * b[k]);
  @*/
public int dotProduct(int[] a, int[] b) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: for-counting-up over two arrays.
   * counter/init/guard/step: i / 0 / i < a.length / i++.
   * assigned: i, res.
   * array reads: a[i], b[i].
   * accumulator: res += a[i] * b[i].
   * safety: b.length >= a.length; multiplication/addition overflow must be constrained for strict proof.
   * template: two-array dot-product accumulator.
   */
  int res = 0;
  /*@ maintaining 0 <= i && i <= a.length;
    @ maintaining res == (\sum int k; 0 <= k && k < i; a[k] * b[k]);
    @ loop_assigns i, res;
    @ decreases a.length - i;
    @*/
  for (int i = 0; i < a.length; i++) {
    res += a[i] * b[i];
  }
  return res;
}

/*@ normal_behavior
  @   requires a != null;
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < a.length; a[k]);
  @*/
public static int sum(int[] a) {
  /*
   * LOOP DATAFLOW ANSWERS:
   * loopKind: while-counting-up.
   * counter/init/guard/step: i / 0 / i < a.length / body i = i + 1.
   * assigned: i, s.
   * array reads: a[i].
   * accumulator: s = s + a[i].
   * template: array sum accumulator.
   */
  int i = 0;
  int s = 0;
  /*@ maintaining 0 <= i && i <= a.length;
    @ maintaining s == (\sum int k; 0 <= k && k < i; a[k]);
    @ loop_assigns i, s;
    @ decreases a.length - i;
    @*/
  while (i < a.length) {
    s = s + a[i];
    i = i + 1;
  }
  return s;
}
