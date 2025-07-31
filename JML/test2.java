public int[] elemAt(int[] arr, int pos){
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}
