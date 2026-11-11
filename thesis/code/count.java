/*@ normal_behavior
  @   requires n >= 0;
  @   assignable \nothing;
  @   ensures \result == n;
  @*/
public static int count(int n) {
    int i = 0;
    //@ maintaining 0 <= i && i <= n;
    //@ loop_assigns i;
    //@ decreases n - i;
    while (i < n) {
        i++;
    }
    return i;
}
