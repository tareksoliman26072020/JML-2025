public int boo35(int a, int b) {
  int x=a+b;
  int y=a*b;
  while (y>a+b) {
    a=a+1;
    x=a+b;
  }
  return x;
}
