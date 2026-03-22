public static int[] tail(int[] arr) {
  if (arr == null || arr.length <= 1) {
    throw new Exception("array is too small");
  }
  else {
    int[] arr2 = new int[arr.length-1];
    for (int i = 1, int j = 0; i<arr.length; i++, j++) {
      arr2[j] = arr[i];
    }
    return arr2;
  }
}
