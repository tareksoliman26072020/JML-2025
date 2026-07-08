# Loop-invariant pass for `to-be-tested.java`

## Reading assumptions

This is a JML-oriented design pass, not a mechanically checked OpenJML proof run. I treated the uploaded `to-be-tested.java` as the source of truth and used the existing project style from `test1.java`: symbolic expressions are used to generate `requires`, `assignable`, and `ensures`, and loop information should become `maintaining` clauses.

General assumptions used below:

1. `println`, `print`, and `toString` are treated as predefined functions whose console output is not modeled as heap mutation, matching the style already used in the project examples.
2. Local variables and freshly allocated arrays are not listed in method-level `assignable` clauses. For loops I still list them in `loop_assigns` because OpenJML needs a loop frame.
3. Arithmetic postconditions using `+`, `*`, `\sum`, or closed forms are exact only under the stated no-overflow preconditions. Where no such precondition is listed, the spec is a logical/inference target rather than a strict OpenJML arithmetic proof obligation.
4. String equality is written in the same symbolic style as your generated JML. For strict OpenJML verification, replace string-value `==` facts by a pure model equality or by suitably specified `String.equals` usage.
5. Several methods in `to-be-tested.java` are toy-language Java rather than directly compilable Java, for example `input.length` on `String`, checked `Exception` throws without declarations in some callers, and `void` methods returning arrays. I still specify them according to the intended symbolic-execution semantics.

---

## 1. Method-by-method JML and loop annotations

### `manyArrs7`

```java
/*@ normal_behavior
  @   requires arr != null;
  @   assignable arr[*];
  @   ensures arr.length == \old(arr.length);
  @   ensures (\forall int k; 0 <= k && k < arr.length; arr[k] != null);
  @*/
public void manyArrs7(String[] arr) {
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
```

The strong symbolic-content invariant would be `arr[k] == toString(k+1) + ". " + \old(arr[k])` for processed `k`, but I did not make that the default because Java/JML string value equality needs a pure string model.

---

### `wrongSum1`

```java
/*@ normal_behavior
  @   requires true;
  @   assignable t;
  @   ensures \result == 0;
  @   ensures n > 0 ==> t == 1;
  @   ensures n <= 0 ==> t == \old(t);
  @*/
public int wrongSum1(int n) {
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
```

The invariant captures the important fact that `res` is reset to `0` in every executed iteration, so the final result is always `0`.

---

### `wrongSum2`

```java
/*@ normal_behavior
  @   requires true;
  @   assignable v, t;
  @   ensures \result == 0;
  @   ensures n > 0 ==> t == 1;
  @   ensures n > 0 ==> v == "zuzu";
  @   ensures n <= 0 ==> t == \old(t);
  @   ensures n <= 0 ==> v == \old(v);
  @*/
public int wrongSum2(int n) {
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
```

---

### `wrongSum3`

```java
/*@ normal_behavior
  @   requires true;
  @   assignable t;
  @   ensures \result == 0;
  @   ensures v == \old(v);
  @   ensures n > 0 ==> t == 1;
  @   ensures n <= 0 ==> t == \old(t);
  @*/
public int wrongSum3(int n) {
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
```

---

### `wrongSum4`

```java
/*@ normal_behavior
  @   requires true;
  @   assignable v, t;
  @   ensures \result == 0;
  @   ensures n > 0 ==> t == 1;
  @   ensures n <= 0 ==> t == \old(t);
  @   ensures n <= 0 ==> v == \old(v);
  @   ensures n > 0 && \old(v) == "bye" ==> v == "zuzu";
  @   ensures n > 0 && \old(v) != "bye" ==> v == \old(v);
  @*/
public int wrongSum4(int n) {
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
```

---

### `wrongSum5`

```java
/*@ normal_behavior
  @   requires 0 <= n && n <= 65535;
  @   assignable v, t;
  @   ensures \result == (\sum int k; 1 <= k && k <= n; k)
  @                    + ((n > 0 && \old(v) == "bye") ? 1 : 0);
  @   ensures n > 0 ==> t == 1;
  @   ensures n == 0 ==> t == \old(t);
  @   ensures n > 0 && \old(v) == "bye" ==> v == "zuzu";
  @   ensures n > 0 && \old(v) != "bye" ==> v == \old(v);
  @*/
public int wrongSum5(int n) {
  int res = 0;
  /*@ maintaining 0 <= i && i <= n;
    @ maintaining res == (\sum int k; i < k && k <= n; k)
    @                    + ((n > 0 && i < n && \old(v) == "bye") ? 1 : 0);
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
```

---

### `for1`

```java
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int for1(int n) {
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
```

---

### `for2`

```java
/*@ normal_behavior
  @   requires 0 <= n && n <= Integer.MAX_VALUE;
  @   assignable \nothing;
  @   ensures \result == (((n / 2) % 3 == 0) ? (n / 2) * 3 : (n / 2));
  @*/
public int for2(int n) {
  int res = 0;
  /*@ maintaining 0 <= i && i <= n;
    @ maintaining res == (\num_of int k; i < k && k <= n; k % 2 == 0);
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
```

---

### `for3`

```java
/*@ normal_behavior
  @   requires 0 <= n;
  @   assignable \nothing;
  @   ensures \result == ((((n % 2 == 0) ? 10 : 20) + 5 * (n / 2)) % 3 == 0
  @                       ? (((n % 2 == 0) ? 10 : 20) + 5 * (n / 2)) * 3
  @                       : (((n % 2 == 0) ? 10 : 20) + 5 * (n / 2)));
  @*/
public int for3(int n) {
  int a;
  if(n % 2 == 0) {
    a = 10;
  }
  else {
    a = 20;
  }

  /*@ maintaining 0 <= i && i <= n;
    @ maintaining a == ((n % 2 == 0) ? 10 : 20)
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
```

---

### `sum1`

```java
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
```

Call specs:

```java
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == "231";
  @*/
public String sum1Call1() { return toString(sum1(21)); }

/*@ normal_behavior
  @   requires x <= 0;
  @   assignable \nothing;
  @   ensures \result == "0";
  @ also
  @ normal_behavior
  @   requires 0 < x && x <= 65535;
  @   assignable \nothing;
  @   ensures \result == toString(x * (x + 1) / 2);
  @*/
public String sum1Call2() { return toString(sum1(x)); }

/*@ normal_behavior
  @   requires true;
  @   assignable x;
  @   ensures x == 3;
  @   ensures \result == "6";
  @*/
public String sum1Call3() { x = 3; return toString(sum1(x)); }
```

---

### `sum2`

```java
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 231;
  @*/
public int sum2() {
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
```

---

### `sum4` and `sum4Call`

`sum4` is semantically the same as `sum1`, but the decrement is inside the body.

```java
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
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 6;
  @*/
public int sum4Call() { return sum4(3); }
```

---

### `sum1_While` and `sum1_WhileCall`

```java
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
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 6;
  @*/
public int sum1_WhileCall() { return sum1_While(3); }
```

---

### `sum1_While2`

```java
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
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int sum1_While2Call1() { return sum1_While2(0); }

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 6;
  @*/
public int sum1_While2Call2() { return sum1_While2(3); }
```

---

### `sumOddNums`

```java
/*@ normal_behavior
  @   requires nums != null;
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < nums.length && nums[k] % 2 != 0; nums[k]);
  @*/
public int sumOddNums(int[] nums) {
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
```

Call specs:

```java
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
public int sumOddNumsCall1() { int x = sumOddNums(new int[]{1,2,3,4}); return x; }

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
public int sumOddNumsCall2() { int x = sumOddNums(new int[]{1,3}); return x; }
```

---

### `sumUntilNegative`

```java
/*@ normal_behavior
  @   requires nums != null;
  @   assignable \nothing;
  @   ensures (\exists int m; 0 <= m && m <= nums.length
  @             && (\forall int k; 0 <= k && k < m; nums[k] >= 0)
  @             && (m == nums.length || nums[m] < 0)
  @             && \result == (\sum int k; 0 <= k && k < m; nums[k]));
  @*/
public int sumUntilNegative(int[] nums) {
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
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int sumUntilNegativeCall1() { return sumUntilNegative(new int[]{}); }

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int sumUntilNegativeCall2() { return sumUntilNegative(new int[]{4,1,-2,1}); }
```

---

### `processArray1`

```java
/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \result == (\sum int k; 0 <= k && k < arr.length;
  @                            arr[k] % 2 == 0 ? arr[k] : -arr[k]);
  @*/
public int processArray1(int[] arr) {
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
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public int processArray1Call() { int x = processArray1(new int[]{1,2,3,4}); return x; }
```

---

### `fillArray`

```java
/*@ normal_behavior
  @   requires 0 <= size;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures \result.length == size;
  @   ensures (\forall int k; 0 <= k && k < size; \result[k] == elem);
  @*/
public int[] fillArray(int size, int elem) {
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
  @   requires true;
  @   assignable \nothing;
  @*/
public void fillArrayCall() { println(fillArray(5,10)); }
```

---

### `sqrt`

```java
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
  @   signals Exception;
  @*/
public static int sqrt(int y) throws Exception{
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
```

Call specs:

```java
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 3;
  @*/
public static int sqrtCall1() { int x = sqrt(9); return x; }

/*@ exceptional_behavior
  @   requires true;
  @   assignable \nothing;
  @   signals Exception;
  @*/
public static int sqrtCall2() { int x = sqrt(8); return x; }
```

---

### `boo34` and `boo34Call`

```java
/*@ normal_behavior
  @   requires input != null;
  @   assignable status;
  @   ensures input.length > 0 ==> status == "non-empty";
  @   ensures input.length <= 0 ==> status == "empty";
  @*/
public void boo34(String input){
  if (input.length > 0) {
    String msg = "non-empty";
    status = msg;
  } else {
    String msg = "empty";
    status = msg;
  }
}

/*@ normal_behavior
  @   requires true;
  @   assignable status;
  @   ensures status == "empty";
  @*/
public void boo34Call() {
  boo34("Hello");
  println(status);
  boo34("");
  println(status);
}
```

---

### `getMax`

```java
/*@ exceptional_behavior
  @   requires arr != null && arr.length == 0;
  @   assignable \nothing;
  @   signals Exception;
  @ also
  @ normal_behavior
  @   requires arr != null && arr.length > 0;
  @   assignable \nothing;
  @   ensures (\exists int k; 0 <= k && k < arr.length; \result == arr[k]);
  @   ensures (\forall int k; 0 <= k && k < arr.length; arr[k] <= \result);
  @*/
public static int getMax(int[] arr) throws Exception {
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
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 9;
  @*/
public static int getMaxCall() { return getMax(new int[] {5,4,6,4,7,8,9,0,1}); }
```

---

### `swap` and calls

```java
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
  int temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
private static void swapCall() {
  int[] arr = new int[] {5,4,6,4,7,8,9,0,1};
  swap(arr,0,1);
}
```

---

### `partition`

```java
/*@ normal_behavior
  @   requires arr != null;
  @   requires 0 <= low && low <= high && high < arr.length;
  @   assignable arr[low..high];
  @   ensures low <= \result && \result <= high;
  @   ensures arr[\result] == \old(arr[high]);
  @   ensures (\forall int k; low <= k && k < \result; arr[k] < arr[\result]);
  @   ensures (\forall int k; \result < k && k <= high; arr[k] >= arr[\result]);
  @*/
private static int partition(int[] arr, int low, int high) {
  int pivot = arr[high];
  int i = low - 1;
  /*@ maintaining low - 1 <= i && i < j && low <= j && j <= high;
    @ maintaining pivot == \old(arr[high]);
    @ maintaining arr[high] == pivot;
    @ maintaining (\forall int k; low <= k && k <= i; arr[k] < pivot);
    @ maintaining (\forall int k; i < k && k < j; arr[k] >= pivot);
    @ loop_assigns i, j, arr[low..high-1];
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
```

The partition spec omits the permutation/multiset postcondition. It is true, but it requires a model function such as `sameMultiset(\old(arr), arr, low, high)` or counting quantifiers over values.

Call specs:

```java
/*@ normal_behavior @ requires true; assignable \nothing; @*/
private static void partitionCall1() { /* arr becomes [7], result 0 */ }
/*@ normal_behavior @ requires true; assignable \nothing; @*/
private static void partitionCall2() { /* arr becomes [7,9], result 0 */ }
/*@ normal_behavior @ requires true; assignable \nothing; @*/
private static void partitionCall3() { /* arr becomes [3,7], result 1 */ }
/*@ normal_behavior @ requires true; assignable \nothing; @*/
private static void partitionCall4() { /* arr becomes [3,7,9], result 1 */ }
/*@ normal_behavior @ requires true; assignable \nothing; @*/
private static void partitionCall5() { /* arr becomes [1,2,7], result 2 */ }
/*@ normal_behavior @ requires true; assignable \nothing; @*/
private static void partitionCall6() { /* arr becomes [7,8,9], result 0 */ }
```

---

### `isAscending1`

```java
/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \result <==> (\forall int k; 0 <= k && k + 1 < arr.length; arr[k] <= arr[k+1]);
  @*/
public boolean isAscending1(int[] arr) {
  boolean res = true;
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining res <==> (\forall int k; 0 <= k && k < i; arr[k] <= arr[k+1]);
    @ loop_assigns i, res;
    @ decreases arr.length - 1 - i;
    @*/
  for(int i = 0; i<arr.length-1; i++) {
    if(arr[i] > arr[i+1]) {
      res = false;
    }
  }
  return res;
}
```

`isAscending1Call` has no heap side effect if console output is ignored:

```java
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void isAscending1Call() { ... }
```

---

### `isAscending2`

```java
/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \result <==> (\forall int k; 0 <= k && k + 1 < arr.length; arr[k] <= arr[k+1]);
  @*/
public boolean isAscending2(int[] arr) {
  /*@ maintaining 0 <= i && i <= arr.length;
    @ maintaining (\forall int k; 0 <= k && k < i; arr[k] <= arr[k+1]);
    @ loop_assigns i;
    @ decreases arr.length - 1 - i;
    @*/
  for(int i = 0; i<arr.length-1; i++) {
    if(arr[i] > arr[i+1]) {
      return false;
    }
  }
  return true;
}
```

`isAscending2Call` is analogous to `isAscending1Call`.

---

### `copyArray`

```java
/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures \result.length == arr.length;
  @   ensures (\forall int k; 0 <= k && k < arr.length; \result[k] == arr[k]);
  @*/
public int[] copyArray(int[] arr) {
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

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void copyArrayCall() { ... }
```

---

### `addElemRight`

```java
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
```

---

### `removeAtPos`

```java
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
```

Call specs:

```java
/*@ normal_behavior @ requires true; assignable \nothing; @*/
public void removeAtPosCall1() { /* result [1,3] */ }
/*@ normal_behavior @ requires true; assignable \nothing; @*/
public void removeAtPosCall2() { /* result [9] */ }
```

---

### `takeWhileAsLongAsEven`

```java
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
```

Call specs:

```java
/*@ normal_behavior @ requires true; assignable \nothing; @*/
public void takeWhileAsLongAsEvenCall1() { /* result [2,4,6,8] */ }
/*@ normal_behavior @ requires true; assignable \nothing; @*/
public void takeWhileAsLongAsEvenCall2() { /* result [2,4] */ }
```

---

### `bubbleSort`

```java
/*@ normal_behavior
  @   requires arr != null;
  @   assignable arr[*];
  @   ensures (\forall int k; 0 <= k && k + 1 < arr.length; arr[k] <= arr[k+1]);
  @*/
public static void bubbleSort(int[] arr) {
  int n = arr.length;
  /*@ maintaining 0 <= i && i <= n;
    @ maintaining n == arr.length;
    @ maintaining (\forall int p; n - i <= p && p + 1 < n; arr[p] <= arr[p+1]);
    @ maintaining (\forall int p, q; 0 <= p && p < n - i && n - i <= q && q < n; arr[p] <= arr[q]);
    @ loop_assigns i, arr[*];
    @ decreases n - 1 - i;
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
```

This proves the sorting direction if the verifier can use the inner-loop “maximum bubbles right” invariant. To fully specify sorting as a permutation, add a multiset preservation predicate; the code indeed preserves multiplicity, but that is not shown by the above postcondition.

---

### `replicate`

```java
/*@ normal_behavior
  @   requires v != null;
  @   assignable \nothing;
  @   ensures \result != null;
  @   ensures n <= 0 ==> \result == "";
  @*/
public String replicate(int n,String v) {
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
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == "qwqwqwqwqw";
  @*/
public String replicateCall() { String str = replicate(5,"qw"); return str; }
```

For an exact general spec, add a model function `repeat(String s, int n)` and use the invariant `res == repeat(v, n - i)`.

---

### `sum3`

```java
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

/*@ normal_behavior @ requires true; assignable \nothing; ensures \result == 0; @*/
public int sum3Call1() { int x = sum3(0); return x; }
/*@ normal_behavior @ requires true; assignable \nothing; ensures \result == 6; @*/
public int sum3Call2() { int x = sum3(3); return x; }
```

---

### `tail`

```java
/*@ exceptional_behavior
  @   requires arr == null || arr.length <= 1;
  @   assignable \nothing;
  @   signals Exception;
  @ also
  @ normal_behavior
  @   requires arr != null && arr.length > 1;
  @   assignable \nothing;
  @   ensures \fresh(\result);
  @   ensures \result.length == arr.length - 1;
  @   ensures (\forall int k; 0 <= k && k < \result.length; \result[k] == arr[k+1]);
  @*/
public static int[] tail(int[] arr) {
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
```

Call specs:

```java
/*@ exceptional_behavior @ requires true; assignable \nothing; signals Exception; @*/
public static void tailCall1() { println(tail(null)); }
/*@ exceptional_behavior @ requires true; assignable \nothing; signals Exception; @*/
public static void tailCall2() { println(tail(new int[]{})); }
/*@ normal_behavior @ requires true; assignable \nothing; @*/
public static void tailCall3() { /* result [9] */ }
/*@ normal_behavior @ requires true; assignable \nothing; @*/
public static void tailCall4() { /* result [9,2] */ }
```

---

### `doubleArrayElems`

```java
/*@ normal_behavior
  @   requires arr != null;
  @   requires (\forall int k; 0 <= k && k < arr.length;
  @              Integer.MIN_VALUE / 2 <= arr[k] && arr[k] <= Integer.MAX_VALUE / 2);
  @   assignable arr[*];
  @   ensures (\forall int k; 0 <= k && k < arr.length; arr[k] == 2 * \old(arr[k]));
  @*/
public static void doubleArrayElems(int[] arr) {
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

/*@ normal_behavior @ requires true; assignable \nothing; @*/
public static void doubleArrayElemsCall() { doubleArrayElems(new int[]{1,2,3}); }
```

---

### `doubleArrayElems2`

```java
/*@ normal_behavior
  @   requires arr != null;
  @   requires (\forall int k; 0 <= k && k < arr.length;
  @              Integer.MIN_VALUE / 2 <= arr[k] && arr[k] <= Integer.MAX_VALUE / 2);
  @   assignable arr[*];
  @   ensures (\forall int k; 0 <= k && k < arr.length; arr[k] == 2 * \old(arr[k]));
  @*/
public static void doubleArrayElems2(int[] arr) {
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

/*@ normal_behavior @ requires true; assignable \nothing; @*/
public static void doubleArrayElems2Call() { doubleArrayElems2(new int[]{1,2,3}); }
```

---

### `quickSort`

A fully useful quicksort spec needs two parts: sortedness and permutation. The following is a sound sortedness target plus stack-shape invariants. It is not enough by itself to prove sorting automatically unless `partition` is specified strongly and the verifier has additional lemmas about partitioned intervals.

```java
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
```

Call specs:

```java
/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == null;
  @*/
public static int[] quickSortCall1() { int[] arr = null; quickSort(arr); return arr; }

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result.length == 1;
  @   ensures \result[0] == 7;
  @*/
public static int[] quickSortCall2() { int[] arr = new int[] {7}; quickSort(arr); return arr; }

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result.length == 5;
  @   ensures \result[0] == 1 && \result[1] == 2 && \result[2] == 3 && \result[3] == 4 && \result[4] == 5;
  @*/
public static int[] quickSortCall3() { int[] arr = new int[] {1,5,2,4,3}; quickSort(arr); return arr; }
```

---

## 2. How I derived the invariants

The pattern used repeatedly is:

1. Identify the loop counter and the processed prefix/range.
2. Write the bounds invariant first, e.g. `0 <= i && i <= arr.length` or `0 <= i && i <= n`.
3. Write the accumulator invariant as “current accumulator equals the specification applied to already processed elements”.
4. Write unchanged-frame invariants for arrays: processed cells have the new relation; unprocessed cells equal `\old(...)`.
5. Write `loop_assigns` with the loop counter, local accumulators, and mutated array slice.
6. Write a termination measure that decreases with each iteration, usually `arr.length - i`, `i`, or `n - i`.

For example, `sumOddNums` has target postcondition

```java
\result == (\sum int k; 0 <= k && k < nums.length && nums[k] % 2 != 0; nums[k])
```

so the loop invariant is the same formula restricted to the processed prefix:

```java
sum == (\sum int k; 0 <= k && k < i && nums[k] % 2 != 0; nums[k])
```

For array construction such as `copyArray`, the postcondition says every result cell equals the corresponding input cell. At loop head only the prefix has been copied, so the invariant is:

```java
(\forall int k; 0 <= k && k < i; copy[k] == arr[k])
```

For `getMax`, the result-level property is “the result is an element of the whole array and every element is no larger than it”. At loop head only `arr[0..i)` has been scanned:

```java
(\exists int k; 0 <= k && k < i; max == arr[k])
(\forall int k; 0 <= k && k < i; arr[k] <= max)
```

---

## 3. How `lecture-11.pdf` should guide the Haskell implementation

The lecture is directly useful, but not as a complete invariant-synthesis algorithm. The important implementation idea is this:

- Use Floyd-Hoare logic to define what a valid invariant must satisfy.
- Use weakest-precondition/backward reasoning to derive candidate invariant shapes.
- Use symbolic execution output to instantiate those shapes with concrete variables, guards, ranges, assignments, and expressions.
- Use verification-condition checks, even lightweight syntactic ones, to reject candidates that are not inductive.

The key Hoare while rule is essentially:

```text
{I && guard} body {I}
----------------------
{I} while (guard) body {I && !guard}
```

So the generator should not merely print loop facts. It should produce candidates `I`, then test at least these three VCs:

1. **Initialization VC**: pre-state before the loop implies `I`.
2. **Preservation VC**: `I && guard` before the body implies `I` after executing body and step.
3. **Exit VC**: `I && !guard` implies the postcondition needed after the loop.

For annotated programs, the lecture’s approximate weakest precondition idea is the right architecture: when the program contains a loop annotation, the approximate WP of the loop is simply the invariant, and the remaining work is moved to VCs. This maps well to a JML generator: generate `maintaining`, then ask OpenJML or an internal simplifier to discharge the VCs.

### Suggested Haskell module shape

```haskell
data LoopKind
  = CountingUp      -- for (i = lo; i < hi; i++)
  | CountingDown    -- for (i = hi; i > lo; i--)
  | WhileGuarded
  | WhileTrueBreak
  | NestedLoop
  | UnknownLoop

-- What the loop changes.
data LoopSummary = LoopSummary
  { loopIndex      :: Maybe String
  , loopInit       :: Maybe SymExpr
  , loopGuard      :: Maybe SymExpr
  , loopStep       :: Maybe SymExpr
  , loopWrites     :: [LValue]
  , loopReads      :: [LValue]
  , loopBody       :: [CFG.Node]
  , loopBreaks     :: [SymExpr]
  , loopContinues  :: [SymExpr]
  }

data InvariantCandidate = InvariantCandidate
  { invKind    :: InvariantKind
  , invExpr    :: JML.Expr
  , invReason  :: String
  }

data InvariantBundle = InvariantBundle
  { maintaining :: [JML.Expr]
  , loopAssigns :: [LValue]
  , decreases   :: Maybe JML.Expr
  , confidence  :: Confidence
  }
```

A practical pipeline:

```text
SymbolicExecution output
   -> extract SLoop / LoopConditions / LoopFailure
   -> classify loop kind
   -> detect loop frame from VarAssignments and array writes
   -> synthesize bound invariants
   -> synthesize accumulator invariants
   -> synthesize array prefix/suffix invariants
   -> synthesize break/continue path invariants
   -> synthesize decreases term
   -> validate candidates by symbolic one-step preservation
   -> pretty-print JML LoopInvariant / maintaining clauses
```

### Candidate-generation rules

#### Rule A: counter bounds

For `for (int i = 0; i < arr.length; i++)`:

```java
maintaining 0 <= i && i <= arr.length;
decreases arr.length - i;
```

For `for (int i = n; i > 0; i--)`:

```java
maintaining 0 <= i && i <= n;
decreases i;
```

If `n` may be negative and the method does not require `n >= 0`, generate guarded invariants:

```java
maintaining n <= 0 ==> i == n;
maintaining n > 0 ==> 0 <= i && i <= n;
```

#### Rule B: additive accumulator over numeric ranges

If the loop body contains `res += i` and the loop counts down from `n` to `1`, generate:

```java
maintaining res == (\sum int k; i < k && k <= n; k);
```

If the loop mutates `n` itself, use `\old(n)`:

```java
maintaining res == (\old(n) * (\old(n) + 1) - n * (n + 1)) / 2;
```

#### Rule C: array prefix accumulation

For `sum += arr[i]`, generate:

```java
maintaining sum == (\sum int k; 0 <= k && k < i; arr[k]);
```

For guarded accumulation:

```java
if (arr[i] % 2 != 0) sum += arr[i];
```

generate:

```java
maintaining sum == (\sum int k; 0 <= k && k < i && arr[k] % 2 != 0; arr[k]);
```

#### Rule D: array construction/copy

For `res[i] = arr[i]` in an increasing loop:

```java
maintaining (\forall int k; 0 <= k && k < i; res[k] == arr[k]);
```

For `tail` where `arr2[j] = arr[i]` and `j == i - 1`:

```java
maintaining j == i - 1;
maintaining (\forall int k; 0 <= k && k < j; arr2[k] == arr[k+1]);
```

#### Rule E: in-place array update

For `arr[i] += arr[i]` or equivalent:

```java
maintaining (\forall int k; 0 <= k && k < i; arr[k] == 2 * \old(arr[k]));
maintaining (\forall int k; i <= k && k < arr.length; arr[k] == \old(arr[k]));
```

#### Rule F: maximum/minimum scan

For `max = arr[0]; for i=1..`:

```java
maintaining (\exists int k; 0 <= k && k < i; max == arr[k]);
maintaining (\forall int k; 0 <= k && k < i; arr[k] <= max);
```

#### Rule G: break loops

For a loop that breaks at the first negative:

```java
maintaining (\forall int k; 0 <= k && k < i; nums[k] >= 0);
maintaining sum == (\sum int k; 0 <= k && k < i; nums[k]);
```

The postcondition uses an existential break index `m`.

#### Rule H: continue loops

A `continue` means the update/step is still executed but the rest of the body is skipped. The invariant must describe all processed iterations, including skipped ones. `sumOddNums` is the canonical test.

---

## 4. Is the lecture the best course of action?

The lecture is the right foundation for *validating* invariants, because Floyd-Hoare and VCG tell you exactly what obligations an invariant must satisfy. But it is not enough by itself for *discovering* invariants for real Java programs.

Better practical strategy:

1. **Template-based invariant synthesis** for common loops.
2. **Symbolic execution** to fill template parameters.
3. **Abstract interpretation/lightweight dataflow** to infer bounds, frames, and monotonic counters.
4. **VC checking** to keep only candidates that are inductive.
5. **Fallback to weak invariants** when exact semantic invariants are too hard.

Examples:

- For `sum1`, backward induction tells you the postcondition is `res == oldN*(oldN+1)/2` at exit. The template recognizes that after processing from `oldN` down to `n+1`, the invariant is `res == oldSum - remainingSum`.
- For `copyArray`, backward reasoning from `forall k < arr.length: result[k] == arr[k]` naturally weakens the bound to `k < i` at loop head.
- For `getMax`, the postcondition over the whole array weakens to the scanned prefix `k < i`.
- For `quickSort`, pure backward induction is not enough; you need domain lemmas about partitioning, stack intervals, and permutation preservation.

So: use the lecture’s VCG model as the correctness checker, but use template synthesis and dataflow as the invariant generator.

---

## 5. Suggested additional loop-invariant tests

Your current `to-be-tested.java` is strong for:

- counting loops,
- descending loops,
- while loops,
- `break`,
- `continue`,
- array copying,
- array mutation,
- nested loops,
- max scan,
- sorting-style algorithms.

Useful missing tests:

### A. Multiplicative accumulator

```java
public int factorial(int n) {
  int p = 1;
  for (int c = 1; c <= n; c++) {
    p *= c;
  }
  return p;
}
```

Expected invariant:

```java
maintaining 1 <= c && c <= n + 1;
maintaining p == fact(c - 1);
```

This mirrors the lecture’s factorial example and is ideal for testing backward invariant inference.

### B. Two-index copy/reverse

```java
public int[] reverseCopy(int[] arr) {
  int[] res = new int[arr.length];
  for (int i = 0; i < arr.length; i++) {
    res[i] = arr[arr.length - 1 - i];
  }
  return res;
}
```

Expected invariant:

```java
maintaining (\forall int k; 0 <= k && k < i; res[k] == arr[arr.length - 1 - k]);
```

### C. Search with sentinel result

```java
public int indexOf(int[] arr, int x) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == x) return i;
  }
  return -1;
}
```

Expected invariant:

```java
maintaining (\forall int k; 0 <= k && k < i; arr[k] != x);
```

### D. Loop with non-unit step

```java
public int countEverySecond(int[] arr) {
  int c = 0;
  for (int i = 0; i < arr.length; i += 2) {
    c++;
  }
  return c;
}
```

Expected invariant:

```java
maintaining 0 <= i && i <= arr.length + 1;
maintaining i % 2 == 0;
maintaining c == i / 2;
```

### E. Loop with two arrays

```java
public int dotProduct(int[] a, int[] b) {
  int res = 0;
  for (int i = 0; i < a.length; i++) {
    res += a[i] * b[i];
  }
  return res;
}
```

Expected invariant:

```java
maintaining 0 <= i && i <= a.length;
maintaining res == (\sum int k; 0 <= k && k < i; a[k] * b[k]);
```

This tests equal-length preconditions and compound array expressions.
