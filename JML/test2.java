/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures 0 < n ==> \result == n;
  @   ensures 0 >= n ==> \result == 0;
  @*/
int idByLoop (int n) {
  int i = 0;
  //@ maintaining 0 <= i && i <= n;
  //@ loop_assigns i;
  //@ decreases n - i;
  while(i<n) {
    i++;
  }
  return i;
}
