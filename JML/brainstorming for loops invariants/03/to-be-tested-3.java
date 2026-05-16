//Minimal counter loop
public static int idByLoop(int n) {
    int i = 0;
    while (i < n) {
        i++;
    }
    return i;
}

////////////////////

// Array traversal without mutation
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
////////////////////

// First-index search
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

////////////////////

// Universal property: all elements satisfy condition
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

////////////////////

// Summation loop
public static int sum(int[] a) {
    int i = 0;
    int s = 0;
    while (i < a.length) {
        s += a[i];
        i++;
    }
    return s;
}

////////////////////

// Arithmetic formula loop
public static int triangular(int n) {
    int i = 0;
    int s = 0;
    while (i < n) {
        s += i;
        i++;
    }
    return s;
}

////////////////////

// Array fill loop
public static void fill(int[] a, int v) {
    int i = 0;
    while (i < a.length) {
        a[i] = v;
        i++;
    }
}

////////////////////

// Array copy loop
public static void copy(int[] src, int[] dst) {
    int i = 0;
    while (i < src.length) {
        dst[i] = src[i];
        i++;
    }
}

////////////////////

// In-place increment loop
public static void incrementAll(int[] a) {
    int i = 0;
    while (i < a.length) {
        a[i] = a[i] + 1;
        i++;
    }
}

////////////////////

// Conditional mutation with `continue`
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

////////////////////

// Loop with `break`
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

////////////////////

// Reverse array with two moving indices
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

////////////////////

// Binary search
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

////////////////////

// Object-field mutation loop (x is the object field)
public void addN(int n) {
  int i = 0;
  while (i < n) {
    x++;
    i++;
  }
}

////////////////////

// Loop with helper method call
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

////////////////////

// Loop with exceptions
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

////////////////////

// Non-unit index update
public static void zeroEvenIndices(int[] a) {
    int i = 0;
    while (i < a.length) {
        a[i] = 0;
        i += 2;
    }
}

////////////////////

// `for` loop
public static void clear(int[] a) {
    for (int i = 0; i < a.length; i++) {
        a[i] = 0;
    }
}

////////////////////

// Max over array
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

////////////////////
