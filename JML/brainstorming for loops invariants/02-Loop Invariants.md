# Loop Invariants

You do **not** infer loop invariants by trying random formulas. You infer them from four proof needs:

1. **Safety:** every array access, dereference, division, etc. is legal.
2. **Postcondition:** when the loop exits, the invariant plus `!guard` must imply the method’s `ensures`.
3. **Frame:** the verifier must know what the loop may modify.
4. **Termination:** the `decreases` term must be non-negative before each iteration and strictly decrease.

loop annotations should contain `maintaining`, `loop_assigns`, and `decreases`, and the invariants should help prove safety, progress, or the final postcondition, not be decorative.

One important limitation: **there is no complete algorithm that infers the exact invariant for every possible Java loop.** For real tools, you infer invariant candidates from templates, symbolic execution, abstract interpretation, and then keep only candidates that are inductive.

---

# 1. General inference recipe

For a loop:

```java
while (G) {
    B
}
```

you want an invariant `I` such that:

```text
1. Initialization:
   pre-state before loop ==> I

2. Preservation:
   I && G && body execution ==> I'

3. Exit usefulness:
   I && !G ==> desired postcondition

4. Termination:
   decreases expression >= 0 before each iteration
   and strictly decreases after the body

5. Frame:
   loop_assigns includes every local/field/array cell modified by the loop
```

For an automatic tool, the usual inference pipeline is:

```text
Input:
  CFG + symbolic states + desired method contract/postcondition

Step 1: Identify loop variables
  Variables assigned in the loop:
    i, j, sum, found, a[*], this.x, ...

Step 2: Infer safety invariants
  From array accesses:
    a[i]  ==>  a != null && 0 <= i && i < a.length when accessed
  Around the loop:
    0 <= i && i <= a.length

Step 3: Infer progress invariants
  From updates:
    i++      ==> i moves upward
    i--      ==> i moves downward
    lo++, hi-- ==> lo increases, hi decreases
  Candidate decreases:
    a.length - i
    hi - lo + 1
    n - i

Step 4: Infer semantic invariants
  From accumulator updates:
    sum += a[i] ==> sum equals sum of processed prefix
  From search loops:
    no match found yet in processed prefix
  From fill/copy loops:
    processed prefix already has target value
    unprocessed suffix still equals old value

Step 5: Infer frame invariants
  From assignments:
    a[i] = v ==> processed segment may change
    unprocessed segment often remains unchanged

Step 6: Validate candidates
  Keep candidate invariant only if:
    it holds initially,
    it is preserved by one iteration,
    it helps prove the postcondition or safety.
```

---

# 2. Minimal counter loop

## Java method

```java
public static int idByLoop(int n) {
    int i = 0;
    while (i < n) {
        i++;
    }
    return i;
}
```

## JML

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

## Inference

From:

```java
int i = 0;
while (i < n) i++;
```

infer:

```java
0 <= i
i <= n
```

Because:

```text
initially: i == 0, and requires 0 <= n
preservation: if i < n, then after i++, i <= n
exit: i >= n and i <= n, therefore i == n
```

This is the simplest loop-invariant pattern:

```text
index bounds + variant
```

---

# 3. Array traversal without mutation

## Java method

```java
public static boolean contains(int[] a, int x) {
    int i = 0;
    while (i < a.length) {
        if (a[i] == x) {
            return true;
        }
        i++;
    }
    return false;
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   assignable \nothing;
  @   ensures \result <==>
  @           (\exists int k; 0 <= k && k < a.length; a[k] == x);
  @*/
public static boolean contains(int[] a, int x) {
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
```

## Inference

The loop scans a prefix of the array.

At the start of each iteration, every already-checked element is known not to equal `x`:

```java
(\forall int k; 0 <= k && k < i; a[k] != x)
```

This is the standard **search invariant**:

```text
processed prefix does not contain target
```

When the loop exits:

```text
i == a.length
```

so the invariant becomes:

```text
for all k in [0, a.length), a[k] != x
```

which proves `return false`.

---

# 4. First-index search

## Java method

```java
public static int indexOf(int[] a, int x) {
    int i = 0;
    while (i < a.length) {
        if (a[i] == x) {
            return i;
        }
        i++;
    }
    return -1;
}
```

## JML

```java
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
```

## Inference

Same as `contains`, but stronger.

The invariant says:

```text
nothing before i matches x
```

So if the method returns inside the loop at index `i`, then:

```text
a[i] == x
and no earlier index matched
```

Therefore the returned index is the **first** match.

---

# 5. Universal property: all elements satisfy condition

## Java method

```java
public static boolean allNonNegative(int[] a) {
    int i = 0;
    while (i < a.length) {
        if (a[i] < 0) {
            return false;
        }
        i++;
    }
    return true;
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   assignable \nothing;
  @   ensures \result <==>
  @           (\forall int k; 0 <= k && k < a.length; a[k] >= 0);
  @*/
public static boolean allNonNegative(int[] a) {
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
```

## Inference

This is the dual of search.

For search:

```text
processed prefix has no match
```

For universal checking:

```text
processed prefix satisfies predicate
```

Generic schema:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; P(a[k]));
```

---

# 6. Summation loop

## Java method

```java
public static int sum(int[] a) {
    int i = 0;
    int s = 0;
    while (i < a.length) {
        s += a[i];
        i++;
    }
    return s;
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int k; 0 <= k && k < a.length; 0 <= a[k]);
  @   requires (\sum int k; 0 <= k && k < a.length; a[k]) <= Integer.MAX_VALUE;
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < a.length; a[k]);
  @*/
public static int sum(int[] a) {
    int i = 0;
    int s = 0;

    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining s == (\sum int k; 0 <= k && k < i; a[k]);
    //@ maintaining 0 <= s && s <= Integer.MAX_VALUE;
    //@ loop_assigns i, s;
    //@ decreases a.length - i;
    while (i < a.length) {
        s += a[i];
        i++;
    }

    return s;
}
```

## Inference

From:

```java
s += a[i];
i++;
```

infer:

```text
s is the sum of the processed prefix [0, i)
```

Invariant:

```java
s == (\sum int k; 0 <= k && k < i; a[k])
```

The preconditions are important. Without overflow assumptions, the mathematical postcondition may be false for Java `int`.

This example shows the **accumulator invariant** schema:

```text
accumulator == fold over processed segment
```

Examples:

```text
sum     == sum of prefix
product == product of prefix
count   == number of prefix elements satisfying P
max     == maximum of prefix
```

---

# 7. Arithmetic formula loop

## Java method

```java
public static int triangular(int n) {
    int i = 0;
    int s = 0;
    while (i < n) {
        s += i;
        i++;
    }
    return s;
}
```

## JML

```java
/*@ normal_behavior
  @   requires 0 <= n && n <= 65536;
  @   assignable \nothing;
  @   ensures \result == n * (n - 1) / 2;
  @*/
public static int triangular(int n) {
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
```

## Inference

From the update:

```java
s += i;
i++;
```

the symbolic execution gives:

```text
after one iteration:
  s' = s + i
  i' = i + 1
```

Candidate relation:

```text
s = 0 + 1 + ... + (i - 1)
```

Closed form:

```text
s = i * (i - 1) / 2
```

When the loop exits:

```text
i == n
```

so:

```text
s == n * (n - 1) / 2
```

This is an **algebraic accumulator invariant**.

---

# 8. Array fill loop

## Java method

```java
public static void fill(int[] a, int v) {
    int i = 0;
    while (i < a.length) {
        a[i] = v;
        i++;
    }
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length; a[k] == v);
  @*/
public static void fill(int[] a, int v) {
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
```

## Inference

The loop mutates the prefix.

Processed segment:

```java
(\forall int k; 0 <= k && k < i; a[k] == v)
```

Unprocessed segment:

```java
(\forall int k; i <= k && k < a.length; a[k] == \old(a[k]))
```

This is the standard **prefix mutation invariant**:

```text
processed prefix has target property
unprocessed suffix is unchanged
```

---

# 9. Array copy loop

## Java method

```java
public static void copy(int[] src, int[] dst) {
    int i = 0;
    while (i < src.length) {
        dst[i] = src[i];
        i++;
    }
}
```

## Verifier-friendly JML

```java
/*@ normal_behavior
  @   requires src != null && dst != null;
  @   requires src.length <= dst.length;
  @   requires src != dst;
  @   assignable dst[0 .. src.length - 1];
  @   ensures (\forall int k; 0 <= k && k < src.length;
  @              dst[k] == \old(src[k]));
  @   ensures (\forall int k; 0 <= k && k < src.length;
  @              src[k] == \old(src[k]));
  @*/
public static void copy(int[] src, int[] dst) {
    int i = 0;

    //@ maintaining 0 <= i && i <= src.length;
    //@ maintaining (\forall int k; 0 <= k && k < i;
    //@                dst[k] == \old(src[k]));
    //@ maintaining (\forall int k; i <= k && k < src.length;
    //@                dst[k] == \old(dst[k]));
    //@ maintaining (\forall int k; 0 <= k && k < src.length;
    //@                src[k] == \old(src[k]));
    //@ loop_assigns i, dst[0 .. src.length - 1];
    //@ decreases src.length - i;
    while (i < src.length) {
        dst[i] = src[i];
        i++;
    }
}
```

## Inference

The generated invariant is:

```text
dst[0 .. i-1] has already been copied from old src
dst[i .. src.length-1] is not copied yet
src is unchanged
```

The `src != dst` precondition is not logically required for the Java code to execute, but it is a useful verifier-friendly aliasing restriction. Without it, the invariant must reason about the case where `src` and `dst` are the same array.

This example shows that invariant inference is affected by **aliasing**.

---

# 10. In-place increment loop

## Java method

```java
public static void incrementAll(int[] a) {
    int i = 0;
    while (i < a.length) {
        a[i] = a[i] + 1;
        i++;
    }
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int k; 0 <= k && k < a.length;
  @              a[k] < Integer.MAX_VALUE);
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length;
  @              a[k] == \old(a[k]) + 1);
  @*/
public static void incrementAll(int[] a) {
    int i = 0;

    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i;
    //@                a[k] == \old(a[k]) + 1);
    //@ maintaining (\forall int k; i <= k && k < a.length;
    //@                a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    while (i < a.length) {
        a[i] = a[i] + 1;
        i++;
    }
}
```

## Inference

This is a mutation variant of the prefix/suffix invariant:

```text
processed prefix: changed according to rule
unprocessed suffix: unchanged
```

Generic schema:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == f(\old(a[k])));
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
```

---

# 11. Conditional mutation with `continue`

## Java method

```java
public static void clampNegativeToZero(int[] a) {
    int i = 0;
    while (i < a.length) {
        if (a[i] >= 0) {
            i++;
            continue;
        }
        a[i] = 0;
        i++;
    }
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length;
  @              a[k] >= 0);
  @   ensures (\forall int k; 0 <= k && k < a.length;
  @              \old(a[k]) >= 0 ==> a[k] == \old(a[k]));
  @   ensures (\forall int k; 0 <= k && k < a.length;
  @              \old(a[k]) < 0 ==> a[k] == 0);
  @*/
public static void clampNegativeToZero(int[] a) {
    int i = 0;

    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i;
    //@                a[k] >= 0);
    //@ maintaining (\forall int k; 0 <= k && k < i;
    //@                \old(a[k]) >= 0 ==> a[k] == \old(a[k]));
    //@ maintaining (\forall int k; 0 <= k && k < i;
    //@                \old(a[k]) < 0 ==> a[k] == 0);
    //@ maintaining (\forall int k; i <= k && k < a.length;
    //@                a[k] == \old(a[k]));
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
```

## Inference

Here the body has two paths:

```text
Path 1: a[i] >= 0
  element remains old value

Path 2: a[i] < 0
  element becomes 0
```

So the invariant must summarize both paths:

```text
if old value was nonnegative, current value equals old value
if old value was negative, current value equals 0
```

This is the **path-sensitive mutation invariant** pattern.

---

# 12. Loop with `break`

## Java method

```java
public static int firstEvenOrLength(int[] a) {
    int i = 0;
    while (i < a.length) {
        if (a[i] % 2 == 0) {
            break;
        }
        i++;
    }
    return i;
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   assignable \nothing;
  @   ensures 0 <= \result && \result <= a.length;
  @   ensures (\forall int k; 0 <= k && k < \result; a[k] % 2 != 0);
  @   ensures \result < a.length ==> a[\result] % 2 == 0;
  @*/
public static int firstEvenOrLength(int[] a) {
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
```

## Inference

With `break`, the loop can exit in two ways:

```text
1. guard is false:
   i == a.length

2. break is taken:
   i < a.length && a[i] % 2 == 0
```

The invariant still describes the processed prefix:

```text
all elements before i are odd
```

The postcondition must allow both exit reasons.

---

# 13. Reverse array with two moving indices

## Java method

```java
public static void reverse(int[] a) {
    int lo = 0;
    int hi = a.length - 1;

    while (lo < hi) {
        int tmp = a[lo];
        a[lo] = a[hi];
        a[hi] = tmp;
        lo++;
        hi--;
    }
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length;
  @              a[k] == \old(a[a.length - 1 - k]));
  @*/
public static void reverse(int[] a) {
    int lo = 0;
    int hi = a.length - 1;

    //@ maintaining 0 <= lo && lo <= a.length;
    //@ maintaining -1 <= hi && hi < a.length;
    //@ maintaining lo <= hi + 1;
    //@ maintaining lo + hi == a.length - 1;
    //@ maintaining (\forall int k; 0 <= k && k < lo;
    //@                a[k] == \old(a[a.length - 1 - k]));
    //@ maintaining (\forall int k; hi < k && k < a.length;
    //@                a[k] == \old(a[a.length - 1 - k]));
    //@ maintaining (\forall int k; lo <= k && k <= hi;
    //@                a[k] == \old(a[k]));
    //@ loop_assigns lo, hi, a[*];
    //@ decreases hi - lo + 1;
    while (lo < hi) {
        int tmp = a[lo];
        a[lo] = a[hi];
        a[hi] = tmp;
        lo++;
        hi--;
    }
}
```

## Inference

This is a **two-frontier invariant**.

The array is split into three regions:

```text
[0, lo)             already reversed
[lo, hi]            not processed yet
(hi, a.length)      already reversed
```

The relation:

```java
lo + hi == a.length - 1
```

connects the two indices.

This kind of invariant is necessary for loops that consume data from both ends.

---

# 14. Binary search

## Java method

```java
public static int binarySearch(int[] a, int x) {
    int lo = 0;
    int hi = a.length - 1;

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
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int i, j;
  @              0 <= i && i <= j && j < a.length ==> a[i] <= a[j]);
  @   assignable \nothing;
  @   ensures \result == -1 ==>
  @           !(\exists int k; 0 <= k && k < a.length; a[k] == x);
  @   ensures \result != -1 ==>
  @           0 <= \result && \result < a.length && a[\result] == x;
  @*/
public static int binarySearch(int[] a, int x) {
    int lo = 0;
    int hi = a.length - 1;

    //@ maintaining 0 <= lo && lo <= a.length;
    //@ maintaining -1 <= hi && hi < a.length;
    //@ maintaining lo <= hi + 1;
    //@ maintaining (\forall int k; 0 <= k && k < lo; a[k] < x);
    //@ maintaining (\forall int k; hi < k && k < a.length; a[k] > x);
    //@ loop_assigns lo, hi;
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
```

## Inference

The key invariant is not simply bounds. It is an **exclusion-zone invariant**:

```text
all indices before lo contain values less than x
all indices after hi contain values greater than x
```

This requires the sortedness precondition.

Without sortedness, this invariant is not justified.

---

# 15. Nested loops: matrix fill

## Java method

```java
public static void zeroMatrix(int[][] m) {
    int i = 0;
    while (i < m.length) {
        int j = 0;
        while (j < m[i].length) {
            m[i][j] = 0;
            j++;
        }
        i++;
    }
}
```

## JML

```java
/*@ normal_behavior
  @   requires m != null;
  @   requires (\forall int r; 0 <= r && r < m.length; m[r] != null);
  @   assignable m[*][*];
  @   ensures (\forall int r, c;
  @              0 <= r && r < m.length &&
  @              0 <= c && c < m[r].length
  @              ==> m[r][c] == 0);
  @*/
public static void zeroMatrix(int[][] m) {
    int i = 0;

    //@ maintaining 0 <= i && i <= m.length;
    //@ maintaining (\forall int r, c;
    //@                0 <= r && r < i &&
    //@                0 <= c && c < m[r].length
    //@                ==> m[r][c] == 0);
    //@ loop_assigns i, m[*][*];
    //@ decreases m.length - i;
    while (i < m.length) {
        int j = 0;

        //@ maintaining 0 <= j && j <= m[i].length;
        //@ maintaining 0 <= i && i < m.length;
        //@ maintaining (\forall int r, c;
        //@                0 <= r && r < i &&
        //@                0 <= c && c < m[r].length
        //@                ==> m[r][c] == 0);
        //@ maintaining (\forall int c; 0 <= c && c < j; m[i][c] == 0);
        //@ loop_assigns j, m[i][*];
        //@ decreases m[i].length - j;
        while (j < m[i].length) {
            m[i][j] = 0;
            j++;
        }

        i++;
    }
}
```

## Inference

Nested loops need nested summaries.

Outer invariant:

```text
all rows before i are fully zeroed
```

Inner invariant:

```text
rows before i are fully zeroed
current row prefix [0, j) is zeroed
```

For nested loops, infer invariants hierarchically:

```text
inner loop proves one row
outer loop uses that to prove all rows
```

---

# 16. Object-field mutation loop

## Java method

```java
public class Counter {
    public int x;

    public void addN(int n) {
        int i = 0;
        while (i < n) {
            x++;
            i++;
        }
    }
}
```

## JML

```java
public class Counter {
    public int x;

    /*@ normal_behavior
      @   requires 0 <= n;
      @   requires x + n <= Integer.MAX_VALUE;
      @   assignable x;
      @   ensures x == \old(x) + n;
      @*/
    public void addN(int n) {
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
}
```

## Inference

This is an accumulator invariant over a field:

```java
x == \old(x) + i
```

Same pattern as local `sum`, except the frame condition must mention the field:

```java
assignable x;
loop_assigns i, x;
```

---

# 17. Loop with helper method call

## Java method

```java
public static void incAt(int[] a, int i) {
    a[i] = a[i] + 1;
}

public static void incrementAllViaHelper(int[] a) {
    int i = 0;
    while (i < a.length) {
        incAt(a, i);
        i++;
    }
}
```

## Needed helper specification

```java
/*@ normal_behavior
  @   requires a != null;
  @   requires 0 <= i && i < a.length;
  @   requires a[i] < Integer.MAX_VALUE;
  @   assignable a[i];
  @   ensures a[i] == \old(a[i]) + 1;
  @   ensures (\forall int k; 0 <= k && k < a.length && k != i;
  @              a[k] == \old(a[k]));
  @*/
public static void incAt(int[] a, int i) {
    a[i] = a[i] + 1;
}
```

## Caller with loop invariant

```java
/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int k; 0 <= k && k < a.length;
  @              a[k] < Integer.MAX_VALUE);
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length;
  @              a[k] == \old(a[k]) + 1);
  @*/
public static void incrementAllViaHelper(int[] a) {
    int i = 0;

    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i;
    //@                a[k] == \old(a[k]) + 1);
    //@ maintaining (\forall int k; i <= k && k < a.length;
    //@                a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    while (i < a.length) {
        incAt(a, i);
        i++;
    }
}
```

## Inference

If the loop body calls another method, invariant inference depends on the callee’s specification.

You cannot infer the caller’s invariant soundly if the callee has no useful contract.

So your tool should treat method calls like this:

```text
if callee spec exists:
    use its assignable/ensures to update symbolic state
else:
    havoc everything in callee's assignable frame
    infer only weak invariants
```

---

# 18. Loop with exceptions

## Java method

```java
public static int sumNonNegative(int[] a) {
    int i = 0;
    int s = 0;

    while (i < a.length) {
        if (a[i] < 0) {
            throw new IllegalArgumentException();
        }
        s += a[i];
        i++;
    }

    return s;
}
```

## JML normal case only

```java
/*@ normal_behavior
  @   requires a != null;
  @   requires (\forall int k; 0 <= k && k < a.length; a[k] >= 0);
  @   requires (\sum int k; 0 <= k && k < a.length; a[k]) <= Integer.MAX_VALUE;
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < a.length; a[k]);
  @*/
public static int sumNonNegative(int[] a) {
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
```

## Inference

For the normal-behavior spec, the precondition rules out the exceptional branch:

```java
requires (\forall int k; 0 <= k && k < a.length; a[k] >= 0);
```

Then the invariant is the usual sum-prefix invariant.

If you wanted a full exceptional spec, you would need additional clauses describing when an exception is thrown. But for many verification tasks, the normal case is simpler and stronger.

---

# 19. Non-unit index update

## Java method

```java
public static void zeroEvenIndices(int[] a) {
    int i = 0;
    while (i < a.length) {
        a[i] = 0;
        i += 2;
    }
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length && k % 2 == 0;
  @              a[k] == 0);
  @   ensures (\forall int k; 0 <= k && k < a.length && k % 2 != 0;
  @              a[k] == \old(a[k]));
  @*/
public static void zeroEvenIndices(int[] a) {
    int i = 0;

    //@ maintaining 0 <= i && i <= a.length + 1;
    //@ maintaining i % 2 == 0;
    //@ maintaining (\forall int k; 0 <= k && k < i && k < a.length && k % 2 == 0;
    //@                a[k] == 0);
    //@ maintaining (\forall int k; 0 <= k && k < a.length && k % 2 != 0;
    //@                a[k] == \old(a[k]));
    //@ maintaining (\forall int k; i <= k && k < a.length;
    //@                a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    while (i < a.length) {
        a[i] = 0;
        i += 2;
    }
}
```

## Inference

The index does not increase by `1`; it increases by `2`.

So the invariant must include:

```java
i % 2 == 0
```

and the processed range must talk only about even indices.

This is the **strided-loop invariant** pattern.

---

# 20. `for` loop

A `for` loop is usually normalized into a `while` loop.

## Java method

```java
public static void clear(int[] a) {
    for (int i = 0; i < a.length; i++) {
        a[i] = 0;
    }
}
```

Equivalent normalized form:

```java
int i = 0;
while (i < a.length) {
    a[i] = 0;
    i++;
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   assignable a[*];
  @   ensures (\forall int k; 0 <= k && k < a.length; a[k] == 0);
  @*/
public static void clear(int[] a) {
    //@ maintaining 0 <= i && i <= a.length;
    //@ maintaining (\forall int k; 0 <= k && k < i; a[k] == 0);
    //@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
    //@ loop_assigns i, a[*];
    //@ decreases a.length - i;
    for (int i = 0; i < a.length; i++) {
        a[i] = 0;
    }
}
```

## Inference

For `for(init; guard; update) body`, infer invariants as if the loop were:

```java
init;
while (guard) {
    body;
    update;
}
```

The update statement participates in preservation.

---

# 21. `do-while` loop

## Java method

```java
public static int countToPositiveN(int n) {
    int i = 0;
    do {
        i++;
    } while (i < n);
    return i;
}
```

## JML

```java
/*@ normal_behavior
  @   requires 0 < n;
  @   assignable \nothing;
  @   ensures \result == n;
  @*/
public static int countToPositiveN(int n) {
    int i = 0;

    //@ maintaining 0 <= i && i <= n;
    //@ loop_assigns i;
    //@ decreases n - i;
    do {
        i++;
    } while (i < n);

    return i;
}
```

## Inference

A `do-while` loop executes at least once.

To keep the invariant simple, this spec requires:

```java
requires 0 < n;
```

Without that precondition, the method returns `1` for `n <= 0`, so the postcondition would need case-splitting:

```text
if n <= 0, result == 1
if n > 0, result == n
```

This shows an important rule:

```text
sometimes the clean invariant depends on choosing the right method precondition/spec cases
```

---

# 22. Max over array

## Java method

```java
public static int max(int[] a) {
    int i = 1;
    int m = a[0];

    while (i < a.length) {
        if (a[i] > m) {
            m = a[i];
        }
        i++;
    }

    return m;
}
```

## JML

```java
/*@ normal_behavior
  @   requires a != null;
  @   requires a.length > 0;
  @   assignable \nothing;
  @   ensures (\exists int k; 0 <= k && k < a.length; \result == a[k]);
  @   ensures (\forall int k; 0 <= k && k < a.length; a[k] <= \result);
  @*/
public static int max(int[] a) {
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
```

## Inference

The accumulator `m` is not a sum. It is a selected element from the processed prefix.

So the invariant is:

```text
m is one of the processed elements
and every processed element is <= m
```

This is the **extremum invariant** pattern.

---

# 23. Classification of common invariant schemas

For your Haskell tool, you can think in terms of invariant families.

| Loop pattern         | Invariant schema                                             |
| -------------------- | ------------------------------------------------------------ |
| Simple counter       | `lower <= i && i <= upper`                                   |
| Array traversal      | `0 <= i && i <= a.length`                                    |
| Search               | no matching element in processed prefix                      |
| Universal check      | all processed elements satisfy predicate                     |
| Sum/product/count    | accumulator equals fold over processed prefix                |
| Max/min              | accumulator is extremum of processed prefix                  |
| Fill                 | processed prefix has target value                            |
| Copy                 | destination prefix equals old source prefix                  |
| Conditional mutation | processed prefix satisfies path-sensitive relation           |
| Reverse/swap         | processed left and right segments satisfy old-state relation |
| Binary search        | excluded zones cannot contain target                         |
| Nested loops         | outer processed region + inner current-region prefix         |
| Field update         | field equals old field plus loop progress                    |
| Helper call          | invariant depends on callee contract                         |
| Break                | invariant plus break condition proves postcondition          |
| Continue             | invariant must be preserved by every control-flow path       |
| Do-while             | invariant must handle at-least-once execution                |
| Strided loop         | index congruence, e.g. `i % 2 == 0`                          |

---

# 24. How this maps to symbolic execution

For your symbolic execution module, a loop invariant can be inferred as a **fixed-point summary** at the loop header.

Conceptually:

```text
header_state_0 = symbolic state before loop

body_state =
  symbolicExecute(body, assume(header_invariant && guard))

header_state_1 =
  join(header_state_0, body_state after back-edge)

invariant =
  generalize(header_state_0, header_state_1, ...)
```

But raw symbolic execution alone usually gives you an infinite sequence:

```text
i = 0
i = 1
i = 2
i = 3
...
```

So you need generalization.

Examples:

```text
Observed:
  i = 0, 1, 2, 3, ...
Generalize:
  0 <= i <= n

Observed:
  s = 0
  s = a[0]
  s = a[0] + a[1]
  s = a[0] + a[1] + a[2]
Generalize:
  s == (\sum int k; 0 <= k && k < i; a[k])

Observed:
  a[0] = 0
  a[0] = 0 && a[1] = 0
  a[0] = 0 && a[1] = 0 && a[2] = 0
Generalize:
  (\forall int k; 0 <= k && k < i; a[k] == 0)
```

So your inference engine needs pattern lifting:

```text
concrete repeated facts
  ==> quantified prefix/suffix facts
```

---

# 25. Practical inference rules for your tool

A good automatic invariant generator should first infer these conservative clauses:

```java
//@ maintaining 0 <= i && i <= bound;
```

for every monotonic index.

Then infer frame/segment clauses:

```java
//@ maintaining (\forall int k; 0 <= k && k < i; processedProperty(k));
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
```

Then infer accumulator clauses:

```java
//@ maintaining acc == expressionOverProcessedPrefix;
```

Then infer termination:

```java
//@ decreases bound - i;
```

Then infer loop frame:

```java
//@ loop_assigns i, acc;
```

or, for array mutation:

```java
//@ loop_assigns i, a[*];
```

The most important automatically-generated invariant is almost always the index bound:

```java
0 <= i && i <= a.length
```

because it proves:

```text
array access safety
termination metric non-negativity
exit condition usefulness
quantifier range well-definedness
```

---

# 26. What cannot be inferred reliably

Your tool should be honest about these cases:

```text
1. Arbitrary nonlinear arithmetic
2. Complex heap aliasing
3. Loops depending on undocumented helper methods
4. Loops with I/O, randomness, time, reflection, concurrency
5. Data-structure invariants not visible in the code
6. Sortedness unless given by a precondition
7. Permutation/multiset preservation unless using stronger logic/modeling
8. Arithmetic correctness under Java overflow unless bounded
9. Object ownership and representation invariants unless declared
10. Exact invariants for arbitrary nested mutation without templates
```

So the realistic goal is:

```text
infer useful, sound, common invariants
not infer the strongest invariant for every Java loop
```

---

# 27. Minimal invariant template library

For your Haskell implementation, I would start with these templates.

## A. Index bounds

```java
//@ maintaining 0 <= i && i <= n;
```

Use when:

```java
i = 0;
while (i < n) {
    ...
    i++;
}
```

## B. Reverse index bounds

```java
//@ maintaining -1 <= i && i < n;
```

Use when:

```java
i = n - 1;
while (i >= 0) {
    ...
    i--;
}
```

## C. Prefix property

```java
//@ maintaining (\forall int k; 0 <= k && k < i; P(k));
```

Use for:

```java
for (int i = 0; i < a.length; i++)
```

## D. Suffix property

```java
//@ maintaining (\forall int k; i <= k && k < a.length; P(k));
```

Use for reverse loops or unprocessed suffixes.

## E. Prefix unchanged

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] == \old(a[k]));
```

Use when proving no mutation occurred in processed region.

## F. Suffix unchanged

```java
//@ maintaining (\forall int k; i <= k && k < a.length; a[k] == \old(a[k]));
```

Use in mutation loops.

## G. Sum accumulator

```java
//@ maintaining s == (\sum int k; 0 <= k && k < i; a[k]);
```

## H. Count accumulator

```java
//@ maintaining c == (\num_of int k; 0 <= k && k < i; P(k));
```

## I. Search exclusion

```java
//@ maintaining (\forall int k; 0 <= k && k < i; a[k] != x);
```

## J. Two-index relation

```java
//@ maintaining lo + hi == a.length - 1;
```

## K. Binary-search exclusion

```java
//@ maintaining (\forall int k; 0 <= k && k < lo; a[k] < x);
//@ maintaining (\forall int k; hi < k && k < a.length; a[k] > x);
```

## L. Decreases

```java
//@ decreases n - i;
```

or:

```java
//@ decreases hi - lo + 1;
```

---

# 28. The core mental model

For most Java loops over arrays, the invariant is a sentence of this form:

```text
At the start of each iteration,
the part before the index has already been processed correctly,
the part from the index onward is not processed yet,
and the index is within bounds.
```

For example:

```java
//@ maintaining 0 <= i && i <= a.length;
//@ maintaining (\forall int k; 0 <= k && k < i; processedCorrectly(k));
//@ maintaining (\forall int k; i <= k && k < a.length; unprocessedProperty(k));
//@ loop_assigns i, modifiedState;
//@ decreases a.length - i;
```

That template alone covers a large part of verifier-friendly JML loop annotations.
