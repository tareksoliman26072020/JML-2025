boolean contains (int[] a, int x) {
  int i = 0;
  //@ maintaining 0 <= i && i <= a.length;
  //@ maintaining (\\forall int k1;
  //    0 <= k1 && k1 < i && k1 < a.length;
  //      a[k1] != x);
  //@ loop_assigns i;
  //@ decreases a.length - i;
  while(i<a.length) {
    if(a[i]==x) {
      return true;
    }
    i++;
  }
  return false;
}
