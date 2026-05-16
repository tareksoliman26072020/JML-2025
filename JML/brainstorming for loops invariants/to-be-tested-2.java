public void manyArrs7(String[] arr) {
  for(int i=0; i<arr.length; i++) {
    arr[i] = toString(i+1) + ". " + arr[i];
  }
  println(arr);
}

////////////////////

public int wrongSum1(int n) {
  int res = 0;
  int j = w;
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

////////////////////

public int wrongSum2(int n) {
  int res = 0;
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

////////////////////

public int wrongSum3(int n) {
  int res = 0;
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

////////////////////

public int wrongSum4(int n) {
  int res = 0;
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

////////////////////

public int wrongSum5(int n) {
  int res = 0;
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

////////////////////

public int for1(int n) {
  int res = 0;
  for(int i=n; i>0; i--) {
  }
  return res;
}

////////////////////

public int for2(int n) {
  int res = 0;
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

////////////////////

public int for3(int n) {
  int a;
  if(n % 2 == 0) {
    a = 10;
  }
  else {
    a = 20;
  }
  
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

////////////////////

public int sum1(int n) {
  int res = 0;
  for(; n>0; n--) {
    res += n;
  }
  return res;
}

////////////////////

public String sum1Call1() {
  return toString(sum1(21));
}

////////////////////

public String sum1Call2() {
  return toString(sum1(x));
}

////////////////////

public String sum1Call3() {
  x = 3;
  return toString(sum1(x));
}

////////////////////

public int sum2() {
  int res = 0;
  int n = 21;
  for(int i=0; n>0; n--) {
    res += n;
  }
  return res;
}

////////////////////

public int sum4(int n) {
  int res = 0;
  for(;n>0;) {
    res += n;
     n--;
  }
  return res;
}

////////////////////

public int sum4Call() {
  return sum4(3);
}

////////////////////

public int sum1_While(int n) {
  int res = 0;
  while(n>0) {
    res += n;
    n--;
  }
  return res;
}

////////////////////

public int sum1_WhileCall() {
  return sum1_While(3);
}

////////////////////

public int sum1_While2(int n) {
  int res = 0;
  while(true) {
    res += n;
    n--;
    if(n<=0) {
      break;
    }
  }
  return res;
}

////////////////////

public int sum1_While2Call1() {
  return sum1_While2(0);
}

////////////////////

public int sum1_While2Call2() {
  return sum1_While2(3);
}

////////////////////

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

////////////////////

public int sumOddNumsCall1() {
  int x = sumOddNums(new int[]{1,2,3,4});
  return x;
}

////////////////////

public int sumOddNumsCall2() {
  int x = sumOddNums(new int[]{1,3});
  return x;
}

////////////////////

public int sumUntilNegative(int[] nums) {
    int sum = 0;
    for (int i=0; i<nums.length; i++) {
        if (nums[i] < 0) {
            break;
        }
        sum += nums[i];
    }
    return sum;
}

////////////////////

public int sumUntilNegativeCall1() {
  return sumUntilNegative(new int[]{});
}

////////////////////

public int sumUntilNegativeCall2() {
  return sumUntilNegative(new int[]{4,1,-2,1});
}

////////////////////

public int processArray1(int[] arr) {
  int sum = 0;
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] % 2 == 0) {
      sum += arr[i];
    } else {
      sum -= arr[i];
    }
  }
  return sum;
}

////////////////////

public int processArray1Call() {
  int x = processArray1(new int[]{1,2,3,4});
  return x;
}

////////////////////

public int[] fillArray(int size, int elem) {
  int[] arr = new int[size];
  for(int i=0; i<size; i++) {
    arr[i] = elem;
  }
  return arr;
}

////////////////////

public void fillArrayCall() {
  println(fillArray(5,10));
}

////////////////////

public static int sqrt(int y) throws Exception{
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

////////////////////

public static int sqrtCall1() {
  int x = sqrt(9);
  return x;
}

////////////////////

public static int sqrtCall2() {
  int x = sqrt(8);
  return x;
}

////////////////////

public void boo34(String input){
  if (input.length > 0) {
    String msg = "non-empty";
    status = msg;
  } else {
    String msg = "empty";
    status = msg;
  }
}

////////////////////

public void boo34Call() {
  boo34("Hello");
  println(status);
  boo34("");
  println(status);
}

////////////////////

public static int getMax(int[] arr) throws Exception {
  if(arr.length == 0) {
    throw new Exception("empty array");
  }
  else {
    int max = arr[0];
    for(int i=1; i<arr.length; i++) {
      if(arr[i] > max) {
        max = arr[i];
      }
    }
    return max;
  }
}

////////////////////

public static int getMaxCall() {
  return getMax(new int[] {5,4,6,4,7,8,9,0,1});
}

////////////////////

private static void swap(int[] arr, int i, int j) {
  int temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
}

////////////////////

private static void swapCall() {
  int[] arr = new int[] {5,4,6,4,7,8,9,0,1};
  swap(arr,0,1);
}

////////////////////

private static int partition(int[] arr, int low, int high) {
  int pivot = arr[high];
  int i = low - 1;
  for (int j = low; j < high; j++) {
    if (arr[j] < pivot) {
      i++;
      swap(arr, i, j);
    }
  }
  swap(arr, i + 1, high);
  return i + 1;
}

////////////////////

private static void partitionCall1() {
  int[] arr = {7};
  int x = partition(arr,0,0);
  println(arr);
  println(toString(x));
}

////////////////////

private static void partitionCall2() {
  int[] arr = {9,7};
  int x = partition(arr,0,1);
  println(arr);
  println(toString(x));
}

////////////////////

private static void partitionCall3() {
  int[] arr = {3,7};
  int x = partition(arr,0,1);
  println(arr);
  println(toString(x));
}

////////////////////

private static void partitionCall4() {
  int[] arr = {9,3,7};
  int x = partition(arr,0,2);
  println(arr);
  println(toString(x));
}

////////////////////

private static void partitionCall5() {
  int[] arr = {1,2,7};
  int x = partition(arr,0,2);
  println(arr);
  println(toString(x));
}

////////////////////

private static void partitionCall6() {
  int[] arr = {9,8,7};
  int x = partition(arr,0,2);
  println(arr);
  println(toString(x));
}

////////////////////

public boolean isAscending1(int[] arr) {
  boolean res = true;
  for(int i = 0; i<arr.length-1; i++) {
    if(arr[i] > arr[i+1]) {
      res = false;
    }
  }
  return res;
}

////////////////////

public void isAscending1Call() {
  int[] arr1 = new int[]{1,2,4,6,7,99};
  int[] arr2 = new int[]{1,2,4,7,6,99};
  println(toString(isAscending1(arr1)));
  println(toString(isAscending1(arr2)));
}

////////////////////

public boolean isAscending2(int[] arr) {
  for(int i = 0; i<arr.length-1; i++) {
    if(arr[i] > arr[i+1]) {
      return false;
    }
  }
  return true;
}

////////////////////

public void isAscending2Call() {
  int[] arr1 = new int[]{1,2,4,6,7,99};
  int[] arr2 = new int[]{1,2,4,7,6,99};
  println(toString(isAscending2(arr1)));
  println(toString(isAscending2(arr2)));
}

////////////////////

public int[] copyArray(int[] arr) {
  int[] copy = new int[arr.length];
  for(int i=0; i<arr.length; i++) {
    copy[i] = arr[i];
  }
  return copy;
}

////////////////////

public void copyArrayCall() {
  int[] arr = new int[]{1,4,6,8};
  int[] c = copyArray(arr);
  println(arr);
  println(c);
}

////////////////////

public int[] addElemRight(int[] arr, int elem) {
  int[] res = new int[arr.length + 1];
  for(int i=0; i<arr.length; i++) {
    res[i] = arr[i];
  }
  res[arr.length] = elem;
  return res;
}

////////////////////

public void addElemRightCall() {
  int[] arr = addElemRight(new int[]{1,2,3},4);
  println(arr);
}

////////////////////

public int[] removeAtPos(int[] arr, int pos) {
  int[] res = new int[arr.length-1];
  int j = 0;
  for(int i=0; i<arr.length; i++) {
    if(i == pos) {
      continue;
    }
    res[j] = arr[i];
    j++;
  }
  return res;
}

////////////////////

public void removeAtPosCall1() {
  int[] arr = removeAtPos(new int[]{1,2,3},1);
  println(arr);
}

////////////////////

public void removeAtPosCall2() {
  int[] arr = removeAtPos(new int[]{4,9},0);
  println(arr);
}

////////////////////

public int[] takeWhileAsLongAsEven(int[] arr) {
  int[] res = new int[0];
  for(int i=0; i<arr.length; i++) {
    if(arr[i] % 2 == 0) {
      int[] temp = new int[res.length+1];
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

////////////////////

public void takeWhileAsLongAsEvenCall1() {
  int[] arr = takeWhileAsLongAsEven(new int[]{2,4,6,8});
  println(arr);
}

////////////////////

public void takeWhileAsLongAsEvenCall2() {
  int[] arr = takeWhileAsLongAsEven(new int[]{2,4,7,6,8});
  println(arr);
}

////////////////////

public static void bubbleSort(int[] arr) {
  int n = arr.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
}

////////////////////

public static void bubbleSortCall() {
  int[] arr = new int[] {5,4,6,4,7,8,9,0,1};
  bubbleSort(arr);
  return arr;
}

////////////////////

public String replicate(int n,String v) {
  String core = v;
  String res = "";
  for(int i=n; i>0; i--) {
    res += core;
  }
  return res;
}

////////////////////

public String replicateCall() {
  String str = replicate(5,"qw");
  return str;
}

////////////////////

public int sum3(int n) {
  int res = 0;
  for(;; n--) {
    if (n<=0) {
      break;
    }
    res += n;
  }
  return res;
}

////////////////////

public int sum3Call1() {
  int x = sum3(0);
  return x;
}

////////////////////

public int sum3Call2() {
  int x = sum3(3);
  return x;
}

////////////////////

public static int[] tail(int[] arr) {
  if (arr == null || arr.length <= 1) {
    throw new Exception("array is too small");
  }
  else {
    int[] arr2 = new int[arr.length-1];
    int j = 0;
    for (int i = 1; i<arr.length; i++) {
      arr2[j] = arr[i];
      j++;
    }
    return arr2;
  }
}

////////////////////

public static void tailCall1() {
    println(tail(null));
}

////////////////////

public static void tailCall2() {
    println(tail(new int[]{}));
}

////////////////////

public static void tailCall3() {
    println(tail(new int[]{4, 9}));
}

////////////////////

public static void tailCall4() {
    println(tail(new int[]{4, 9, 2}));
}

////////////////////

public static void doubleArrayElems(int[] arr) {
  for(int i=0; i<arr.length; i++) {
    int x = arr[i];
    arr[i] += x;
  }
  println(arr);
}

////////////////////

public static void doubleArrayElemsCall() {
  doubleArrayElems(new int[]{1,2,3});
}

////////////////////

public static void doubleArrayElems2(int[] arr) {
  int i = 0;
  while(i<arr.length) {
    int x = arr[i];
    arr[i] += x;
    i++;
  }
  println(arr);
}

////////////////////

public static void doubleArrayElems2Call() {
  doubleArrayElems2(new int[]{1,2,3});
}

////////////////////

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

////////////////////

public static int[] quickSortCall1() {
  int[] arr = null;
  quickSort(arr);
  return arr;
}

////////////////////

public static int[] quickSortCall2() {
  int[] arr = new int[] {7};
  quickSort(arr);
  return arr;
}

////////////////////

public static int[] quickSortCall3() {
  int[] arr = new int[] {1,5,2,4,3};
  quickSort(arr);
  return arr;
}

////////////////////

public int factorial(int n) {
  int p = 1;
  for (int c = 1; c <= n; c++) {
    p *= c;
  }
  return p;
}

////////////////////

public int[] reverseCopy(int[] arr) {
  int[] res = new int[arr.length];
  for (int i = 0; i < arr.length; i++) {
    res[i] = arr[arr.length - 1 - i];
  }
  return res;
}

////////////////////

public int indexOf(int[] arr, int x) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] == x) return i;
  }
  return -1;
}

////////////////////

public int countEverySecond(int[] arr) {
  int c = 0;
  for (int i = 0; i < arr.length; i += 2) {
    c++;
  }
  return c;
}

////////////////////

public int dotProduct(int[] a, int[] b) {
  int res = 0;
  for (int i = 0; i < a.length; i++) {
    res += a[i] * b[i];
  }
  return res;
}

////////////////////

public static int sum(int[] a) {
  int i = 0;
  int s = 0;
  while (i < a.length) {
    s = s + a[i];
    i = i + 1;
  }
  return s;
}
