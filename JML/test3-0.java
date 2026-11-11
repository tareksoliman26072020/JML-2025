/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo21(){
  return 5;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo21_2(){
  int i;
  return 5;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo22(){
  return boo21();
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo22_2(){
  int x = boo21();
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo23_3(){
  int x = 3 + boo21();
  return 5;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8;
  @*/
public int boo23_3_1() {
  return 3 + 5;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8;
  @*/
public int boo23_4(){
  return 3 + boo21();
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8;
  @*/
public int boo23_9(){
  int x;
  x = 3 + boo21();
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 1.1;
  @*/
public double boo33_3(){
  double x = 1;
  x+=0.1;
  return x;
}

public double boo33_4(){
  double x = 1;
  x = x + 0.1;
  return x;
}

public double boo33_5(String str){
  double x = 1;
  int y;
  z = t;
  x = x + 0.1;
  return x;
}

public double boo33_6(String str){
  double x = 1;
  int y;
  z = t;
  x = x + 0.1;
  z = 1;
  return x;
}

public double boo33_7(){
  double x;
  x = c;
  return x;
}

public int boo21_i(int i){
  return i;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo21_2_i(int i){
  i = 5;
  return i;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 1.1;
  @   ensures z == str;
  @*/
public double boo33_5_2(String str){
  double x = 1;
  int y;
  z = str;
  x = x + 0.1;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 1.1;
  @   ensures z == \old(str) + 1;
  @*/
public double boo33_5_3(String str){
  double x = 1;
  int y;
  str = str + "1";
  z = str;
  x = x + 0.1;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 1.1;
  @   ensures z == \old(str);
  @*/
public double boo33_5_4(String str){
  double x = 1;
  int y;
  z = str;
  str = str + "1";
  x = x + 0.1;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == \old(i) + 2;
  @*/
public int boo21_3_i(int i){
  i += 2;
  return i;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2 * \old(i) + 4;
  @*/
public int boo21_3_i_1(int i){
  i += 2;
  return i+i;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2 * \old(i) + 9;
  @*/
public int boo21_3_i_2(int i){
  i += 2;
  int x = i + 5 + i;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5 * \old(i) + 20;
  @*/
public int boo21_3_i_3(int i){
  i += 2;
  int x = i + 5 + i;
  return x + i + x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2 * i + 2;
  @   ensures x == \old(x) + 2 * i + 2;
  @*/
public int boo21_3_i_4(int i){
  x += i + 2 + i;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2 - i;
  @   ensures x == \old(x) + 2 - i;
  @*/
public int boo21_3_i_5(int i){
  x += i + 2 - 2*i;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2 + i;
  @   ensures x == \old(x) + 2 + i;
  @*/
public int boo21_3_i_6(int i){
  x += 2 + 3*i - 2*i;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2;
  @   ensures x == \old(x) + 2;
  @*/
public int boo21_3_i_7(int i){
  x += 2 + 3*i - 2*i - i;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable x;
  @   ensures \result == \old(x) + 2 + 4 * i;
  @   ensures x == \old(x) + 2 + 4 * i;
  @*/
public int boo21_3_i_8(int i){
  x += i + 2 + 3*i;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2 * \old(i);
  @*/
public int boo21_3_i_9(int i){
  i += i;
  return i;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i;
  @*/
public int boo22_i(int i){
  return boo21_i(i);
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i + 5;
  @*/
public int boo22_i_2(int i){
  return boo21_i(i+4) + 1;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i + 2;
  @*/
public int boo22_i_3(int i){
  return boo21_3_i(i);
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i + 6 * 5;
  @*/
/*@ public normal_behavior
  @   requires -429496735 <= i && i <= 429496723;
  @   assignable \nothing;
  @   ensures \result == 5 * (\old(i) + 6);
  @*/
public int boo22_i_4(int i){
  return boo21_3_i(i+4) * 5;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == j + 2;
  @*/
public int boo22_i_5(int i){
  return boo21_3_i(j);
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i * 2;
  @*/
public int boo22_2_i(int i){
  int x = boo21_i(i*2);
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 33;
  @*/
public int boo22_2_i_2(){
  int j = 6;
  int i = 3 + j;
  int x = boo21_i(i*2);
  return x + i + j;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo23_3_i(int i){
  int x = 3 + boo21_i(i+i);
  return 5;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 16;
  @*/
public int boo23_3_i_2(){
  int i = 4;
  int x = 3 + boo21_i(i+i);
  return x+5;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 3;
  @*/
public int boo23_4_i(int i){
  return 3 + boo21_i(0);
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 10;
  @*/
public int boo23_4_i_2(){
  return 5 * boo21_i(0*4+2);
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 10;
  @*/
public int boo23_4_i_3(int i){
  return 5 * boo21_i(0*i+2);
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 15 * ((3 * i) + 2);
  @*/
public int boo23_4_i_4(int i){
  return 15 * boo21_i(3*i+2);
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 255;
  @*/
public int boo23_4_i_4_1(){
  return boo23_4_i_4(5);
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 15 * (i + 2);
  @*/
public int boo23_4_i_5(int i){
  return 15 * boo21_i(1*i+2);
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8;
  @*/
public int boo23_5_i(int i){
  return 8;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8.0;
  @*/
public double boo23_6_i(int i){
  return 8;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8.0 + i;
  @*/
public double boo23_7_i(double i){
  return 3+5+i;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 3 + (5 * i);
  @*/
public int boo23_8_i(int i){
  return 3+5*i;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo23_9_i(int i){
  int x;
  x = 3 + boo21_i(i+2) - i;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5 - i;
  @*/
public int boo23_9_i_2(int i){
  int x;
  x = 3 + boo21_i(i+2) - 2*i;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8 + i;
  @*/
public int boo23_10_i(int i){
  int x = 3+5+i;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8 + i;
  @*/
public int boo23_10_i_2(int i){
  int x = 3+i+5;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 9 * i;
  @*/
public int boo23_11_i(int i){
  int x = 3+5;
  x = 10-1;
  return x*i;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 3 + i;
  @*/
public int boo23_12_i(int i){
  int x = 3 + boo21_i(i);
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 1.1 + i;
  @*/
public double boo33_3_i(double i){
  double x = 1 + i;
  x+=0.1;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == (1.1 + i) + j;
  @*/
public double boo33_4_i(double i, double j){
  double x = 1 + i;
  x = x + 0.1 + j;
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 18.5;
  @*/
public double boo33_4_i_call(){
  double x = 1 + boo33_4_i(8.8,7.6);
  return x;
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 9;
  @*/
public int boo24(){
  int x = 3 + boo25(5);
  return x;
}

/*@ Exceptional Behavior
  @   requires true;
  @   signals Exception;
  @   assignable \nothing;
  @*/
public int boo24_2(){
  int x = 3 + boo25(11);
  return x;
}

/*@ exceptional_behavior
  @   requires true;
  @   assignable \nothing;
  @   signals Exception;
  @*/
public int exceptionFun() throws Exception {
  throw new Exception("thee");
}

/*@ Exceptional Behavior
  @   requires i > 10;
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ Normal Behavior
  @   requires i <= 10;
  @   assignable \nothing;
  @   ensures \result == 6;
  @*/
public int boo25(int i){
  if(i>10){
    println("Oopsie");
    throw new Exception("meow");
  }
  else{
    return 6;
  }
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo26_2(){
  return boo27(-5);
}

/*@ Normal Behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i;
  @ also
  @ Normal Behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == -1 * i;
  @*/
public int boo27(int i){
  if(i >= 0){
    return i;
  }
  else{
    int res = -1 * i;
    return res;
  }
}

/*@ Normal Behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo27_2() {
  return boo27(5);
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28(int i){
  int x = 1;
  if(i >= 0){
    x++;
    return i;
  }
  return 5;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public int boo282(){
  int x = 1;
  if(x >= 0){
    x++;
    return x;
  }
  return 5;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo283(){
  int x = 1;
  if(x < 0){
    x++;
    return x;
  }
  return 5;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 10;
  @*/
public int boo28_p() {
  return boo28(10);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28_m() {
  return boo28(-10);
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28_2(int i){
  int x = 1;
  if(i >= 0){
    x++;
    int y = 0;
    return i;
  }
  return 5;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
public int boo28_2_1(){
  int x = 1;
  if(x >= 0){
    x++;
    int y = 0;
    return 1+x+1;
  }
  return 5;
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28_4(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    return i;
  }
  else {
   x++;
  }
  return 5;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i;
  @*/
public int boo28_4_1(int i){
  int x = 1;
  if(true){
    int y = 0;
    return i;
  }
  else {
   x++;
  }
  return 5;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28_4_2(int i){
  int x = 1;
  if(false){
    int y = 0;
    return i;
  }
  else {
   x++;
  }
  return 5;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 10;
  @*/
public int boo28_4_p() {
  return boo28_4(10);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28_4_m() {
  return boo28_4(-10);
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int boo28_5(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
   x++;
  }
  return 5;
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 7;
  @*/
public static int boo28_6(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  int y = 2;
  return 5+y;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @*/
public static int boo28_6_2(int i){
  int x = 1;
  if(x >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  int y = 2;
  return 5+y;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 7;
  @*/
public static int boo28_6_3(int i){
  int x = 1;
  if(x >= 0){
    int y = 0;
    y++;
  }
  else {
    x++;
  }
  int y = 2;
  return 5+y;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 7;
  @*/
public static int boo28_6_4(int i){
  int x = 1;
  if(x < 0){
    int y = 0;
    y++;
  }
  else {
    x++;
  }
  int y = 2;
  return 5+y;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public static int boo28_6_5(int i){
  int x = 1;
  if(x < 0){
    int y = 0;
    y++;
  }
  else {
    x++;
  }
  return x;
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public static int boo28_6_6(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  return x;
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 0;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == i + 2;
  @*/
public static int boo28_6_6_2(int i){
  int x = 1;
  if(i >= 0){
    x = 0;
  }
  else {
    x++;
  }
  return i+x;
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable y;
  @   ensures \result == i + 0;
  @   ensures y == true;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable y;
  @   ensures \result == i + 2;
  @   ensures y == false;
  @*/
public static int boo28_6_6_3(int i){
  int x = 1;
  if(i >= 0){
    x = 0;
    y = true;
  }
  else {
    x++;
    y = false;
  }
  return i+x;
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 2;
  @*/
public static int boo28_6_6_4(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    int z = 9;
    x++;
  }
  return x;
}

/*@ normal_behavior
  @   requires i >= 0;
  @   assignable \nothing;
  @   ensures \result == i + 1;
  @ also
  @ normal_behavior
  @   requires i < 0;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public static int boo28_6_7(int i){
  int x = 1;
  if(i >= 0){
    int y = 0;
    y++;
    return i+y;
  }
  else {
    x++;
  }
  x = 5;
  return x;
}

/*@ normal_behavior
  @   requires ((i % 2) == 0) && ((i % 3) == 0);
  @   assignable \nothing;
  @   ensures \result == 1 * 3;
  @ also
  @ normal_behavior
  @   requires ((i % 2) != 0) && ((i % 3) == 0);
  @   assignable \nothing;
  @   ensures \result == 0 * 3;
  @ also
  @ normal_behavior
  @   requires ((i % 2) == 0) && ((i % 3) != 0);
  @   assignable \nothing;
  @   ensures \result == 1;
  @ also
  @ normal_behavior
  @   requires ((i % 2) != 0) && ((i % 3) != 0);
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int boo28_6_8(int i) {
  int res = 0;
  if(i % 2 == 0) {
    res += 1;
  }

  if(i % 3 == 0) {
    res *= 3;
  }
  return res;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void boo28_6_8_call() {
  println(toString(boo28_6_8(5)));
  println(toString(boo28_6_8(8)));
  println(toString(boo28_6_8(12)));
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 11;
  @*/
public int boo28_6_p() {
  return boo28_6(10);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == false;
  @*/
public boolean boo29(){
  if(true){
    return false;
  }
  else{
    return true;
  }
}

/*@ normal_behavior
  @   requires z >= 0;
  @   assignable t1, y, y1, y2;
  @   ensures \result == 7;
  @   ensures t1 == 7;
  @   ensures y == 0.0;
  @   ensures y1 == 0.0;
  @   ensures y2 == 0.0;
  @ also
  @ normal_behavior
  @   requires z < 0;
  @   assignable t2, y, y1, y2;
  @   ensures \result == 17;
  @   ensures t2 == 17;
  @   ensures y == 0.0;
  @   ensures y1 == 0.0;
  @   ensures y2 == 0.0;
  @*/
public int boo30(int z){
  int x1 = 0;
  int x2 = 0;
  y = 0;
  y1 = 0;
  y2 = 0;
  if(z>=0){
    t1 = 7;
    return t1;
  }
  else{
    t2 = 17;
    return t2;
  }
}

/*@ normal_behavior
  @   requires true;
  @   assignable z;
  @   ensures \result == 0;
  @   ensures z == 0;
  @*/
public int boo31(){
  z = 0;
  int x = z;
  return x;
}

/*@ normal_behavior
  @   requires true;
  @   assignable t1, y, y1, y2, z;
  @   ensures \result == 7;
  @   ensures t1 == 7;
  @   ensures y == 0.0;
  @   ensures y1 == 0.0;
  @   ensures y2 == 0.0;
  @   ensures z == 0;
  @*/
public int boo31_2(){
  z = 0;
  int x = z;
  return boo30(1);
}

/*@ normal_behavior
  @   requires true;
  @   assignable t2, y, y1, y2, z;
  @   ensures \result == 0;
  @   ensures t2 == 17;
  @   ensures y == 0.0;
  @   ensures y1 == 0.0;
  @   ensures y2 == 0.0;
  @   ensures z == 0;
  @*/
public int boo31_3(){
  z = 0;
  int x = z;
  boo30(-1);
  return z;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == (y1 + y2) + y3;
  @*/
public int boo32(){
  int x = y1 + y2 + y3;
  return x;
}

/*@ normal_behavior
  @   requires true;
  @   assignable y1, y2, y3;
  @   ensures \result == 6;
  @   ensures y1 == 1.0;
  @   ensures y2 == 2.0;
  @   ensures y3 == 3.0;
  @*/
public int boo32Call(){
  y1 = 1;
  y2 = 2;
  y3 = 3;
  return boo32();
}

/*@ exceptional_behavior
  @   requires (arr != null) && (arr.length <= pos);
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ normal_behavior
  @   requires (arr != null) && (arr.length > pos);
  @   assignable \nothing;
  @   ensures \result == arr[pos];
  @*/
public int elemAt(int[] arr, int pos) throws Exception {
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
public int elemAtCall() throws Exception {
  return elemAt(new int[]{6,5,4,7,8},2);
}

/*@ exceptional_behavior
  @   requires 5 <= pos;
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ normal_behavior
  @   requires 5 > pos;
  @   assignable \nothing;
  @   ensures \result == arr[pos];
  @*/
public int elemAt2(int pos) throws Exception {
  int[] arr = new int[]{6,5,4,7,8};
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 4;
  @*/
public int elemAt2Call() {
  return elemAt2(2);
}

/*@ exceptional_behavior
  @   requires true;
  @   signals Exception;
  @   assignable \nothing;
  @*/
public int elemAt2Call2() {
  return elemAt2(5);
}

/*@ exceptional_behavior
  @   requires pos < 0;
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ exceptional_behavior
  @   requires (5 <= pos) && (pos >= 0);
  @   signals Exception;
  @   assignable \nothing;
  @ also
  @ normal_behavior
  @   requires (5 > pos) && (pos >= 0);
  @   assignable \nothing;
  @   ensures \result == arr[pos];
  @*/
public int elemAt3(int pos) throws Exception {
  if(pos<0) {
    throw new Exception("too small");
  }
  else {
    int[] arr = new int[]{6,5,4,7,8};
    if(arr.length<=pos) {
      throw new Exception("not found");
    }
    return arr[pos];
  }
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 7;
  @*/
public int elemAt4() {
  int[] arr = {6,5,4,7,8};
  return arr[3];
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == Tarek Soliman;
  @*/
public String strFun() {
  String firstName = "Tarek";
  String lastName = "Soliman";
  return firstName + " " + lastName;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun1() {
  return;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun2() {
}

/*@ normal_behavior
  @   requires (1 + n) == 1;
  @   assignable y2, z;
  @   ensures y2 == "is not one";
  @   ensures z == (toString(1 + n) + " ") + "is one";
  @ also
  @ normal_behavior
  @   requires (1 + n) != 1;
  @   assignable y2, z;
  @   ensures y2 == "is not one";
  @   ensures z == (toString(1 + n) + " ") + "is not one";
  @*/
public void voidFun3(int n) {
  int x;
  String y;
  x = 1 + n;
  y = "is one";
  y2 = "is not one";
  if(x == 1) {
    z = toString(x) + " " + y;
  }
  else {
    z = toString(x) + " " + y2;
  }
}

public void manyArrs() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  println(numbers);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void manyArrs2() {
  int[] numbers1 = new int[7];
  int[] numbers2 = {40, 55, 63, 17, 22};
  int[] numbers3;
  numbers3 = new int[5];
  String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
  String[] strs = new String[3];
  strs[1] = "meow";
  numbers1[0] = 86;
  numbers1[2] = 80;
  numbers1[1] = 57;
  numbers1[3] = 34;
  numbers1[4] = 50;
  numbers1[5] = 48;
  numbers1[6] = 94;
  numbers2[0] = 51;
  numbers2[1] = 84;
  numbers2[2] = 92;
  numbers2[3] = 87;
  numbers2[4] = 81;
  numbers3[4] = 43;
  numbers3[3] = 10;
  numbers3[2] = 34;
  numbers3[1] = 75;
  numbers3[4] = 6;
  numbers3[0] = 5;
  println(numbers1);
  println(numbers2);
  println(numbers3);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == [99, 5];
  @*/
public int[] manyArrs3() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  return numbers;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void manyArrs4() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  println(numbers);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void manyArrs5() {
  String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
  for(int i=0; i<brand.length; i++) {
    brand[i] = toString(i+1) + ". " + brand[i];
  }
  println(brand);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void manyArrs6() {
  String[] brand = new String[] {"Toyota","Mercedes","BMW","Volkswagen","Skoda"};
  for(int i=0; i<brand.length; i++) {
    println(toString(i+1) + ". " + brand[i]);
  }
  println(brand);
}

/*@ normal_behavior
  @   requires n >= 0;
  @   assignable \nothing;
  @   ensures \result == n + 1;
  @ also
  @ normal_behavior
  @   requires n < 0;
  @   assignable \nothing;
  @   ensures \result == 0 + 1;
  @*/
public int ifFun(int n) {
  int res = 0;
  int m = 0;
  int x = 1;
  if(n>=0) {
    res += n;
    m += 2*n;
  }
  return res+1;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 8;
  @*/
public int ifFunCall() {
  return 4+ifFun(3);
}

/*@ normal_behavior
  @   requires n >= 0;
  @   assignable \nothing;
  @   ensures \result == (y + n) + 1;
  @ also
  @ normal_behavior
  @   requires n < 0;
  @   assignable \nothing;
  @   ensures \result == y + 1;
  @*/
public int ifFun2(int n) {
  int res = y;
  int m = 0;
  int x = 1;
  if(n>=0) {
    res += n;
    m += 2*n;
  }
  return res+1;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == y + 11;
  @*/
public int ifFun2Call() {
  return ifFun2(10);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == y + 1;
  @*/
public int ifFun2Call2() {
  return ifFun2(-10);
}

/*@ normal_behavior
  @   requires y >= 0.0;
  @   assignable \nothing;
  @   ensures \result == n + 1;
  @ also
  @ normal_behavior
  @   requires y < 0.0;
  @   assignable \nothing;
  @   ensures \result == 0 + 1;
  @*/
public int ifFun3(int n) {
  int res = 0;
  int m = 0;
  int x = 1;
  if(y>=0) {
    res += n;
    m += 2*n;
  }
  return res+1;
}

/*@ normal_behavior
  @   requires true;
  @   assignable y2, z;
  @   ensures y2 == "is not one";
  @   ensures z == "11 is not one";
  @*/
public void voidFun3Call() {
  voidFun3(10);
  println(z);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun4() {
  int x;
  String y;
  x = 1;
  y = "is one";
  String z = toString(x) + " " + y;
  println(z);
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun5() {
  println("Before");
  voidFun4();
  println("After");
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void voidFun6(int n) {
  println(toString(n));
  println(toString(n+1));
  int x = n+1;
  println(toString(x));
}

/*@ normal_behavior
  @   requires \old(y) >= 0;
  @   assignable y;
  @   ensures \result == \old(y) + n;
  @   ensures y == \old(y) + n;
  @ also
  @ normal_behavior
  @   requires \old(y) < 0;
  @   assignable \nothing;
  @   ensures \result == \old(y);
  @*/
public int ifFun4(int n) {
  if(y>=0) {
    y += n;
  }
  return y;
}

/*@ normal_behavior
  @   requires true;
  @   assignable y, z;
  @   ensures y == 12;
  @   ensures z == 12;
  @*/
public void ifFun4Call() {
  y = 2;
  z = ifFun4(1);
  println(toString(y));
  println(toString(z));
  y = -1;
  z = ifFun4(10);
  println(toString(y));
  println(toString(z));
  y = 3;
  z = ifFun4(9);
  println(toString(y));
  println(toString(z));
}

/*@ normal_behavior
  @   requires n >= 0;
  @   assignable y;
  @   ensures \result == 2 * n;
  @   ensures y == 2 * n;
  @ also
  @ normal_behavior
  @   requires n < 0;
  @   assignable y;
  @   ensures \result == n;
  @   ensures y == n;
  @*/
public int ifFun5(int n) {
  y = n;
  if(y>=0) {
    y += n;
  }
  return y;
}

/*@ normal_behavior
  @   requires true;
  @   assignable y;
  @   ensures \result == 20;
  @   ensures y == 20;
  @*/
public int ifFun5Call1() {
  return ifFun5(10);
}

/*@ normal_behavior
  @   requires true;
  @   assignable y;
  @   ensures \result == -10;
  @   ensures y == -10;
  @*/
public int ifFun5Call2() {
  return ifFun5(-10);
}

/*@ normal_behavior
  @   requires \old(y) >= 0.0;
  @   assignable s, m, y;
  @   ensures \result == c;
  @   ensures s == "something";
  @   ensures m == \old(m) + n;
  @   ensures y == -1.0 * \old(y);
  @ also
  @ normal_behavior
  @   requires \old(y) < 0.0;
  @   assignable s;
  @   ensures \result == c;
  @   ensures s == "something";
  @*/
public String ifFun6(int n) {
  if(y>=0) {
    m += n;
    y = (-1) * y;
  }
  s = "something";
  return c;
}

/*@ normal_behavior
  @   requires true;
  @   assignable c, m, s, y;
  @   ensures \result == "6.0 dangerous something6";
  @   ensures c == "dangerous";
  @   ensures m == 11;
  @   ensures s == "something";
  @   ensures y == -5;
  @*/
public String ifFun6Call() {
  y = 5;
  m = 1;
  c = "dangerous";
  return toString(m+y) + " " + ifFun6(10) + " " + s + toString(m+y);
}

/*@ normal_behavior
  @   requires true;
  @   assignable c, m, s, y;
  @   ensures \result == "dangerous 11";
  @   ensures c == "dangerous";
  @   ensures m == 11;
  @   ensures s == "something";
  @   ensures y == -5.0;
  @*/
public String ifFun6Call2() {
  y = 5;
  m = 1;
  c = "dangerous";
  return ifFun6(10) + " " + toString(m);
}

/*@ normal_behavior
  @   requires (n % 2) == 0;
  @   assignable s, v;
  @   ensures s == "something";
  @   ensures v == "hi";
  @ also
  @ normal_behavior
  @   requires (n % 2) != 0;
  @   assignable s, w;
  @   ensures s == "something";
  @   ensures w == "bye";
  @*/
public void ifFun7(int n) {
  if(n % 2 == 0) {
    v = "hi";
  }
  else {
    w = "bye";
  }
  s = "something";
}

/*@ normal_behavior
  @   requires true;
  @   assignable s, v;
  @   ensures s == "something";
  @   ensures v == "hi";
  @*/
public void ifFun7Call() {
  ifFun7(4);
}

/*@ normal_behavior
  @   requires true;
  @   assignable s, v, w;
  @   ensures s == "something";
  @   ensures v == "hi";
  @   ensures w == "bye";
  @*/
public void ifFun7Call2() {
  ifFun7(4);
  ifFun7(5);
}

/*@ normal_behavior
  @   requires (t % 2) == 0;
  @   assignable s, v;
  @   ensures s == "something";
  @   ensures v == "hi";
  @ also
  @ normal_behavior
  @   requires (t % 2) != 0;
  @   assignable s, w;
  @   ensures s == "something";
  @   ensures w == "bye";
  @*/
public void ifFun7Call3() {
  ifFun7(t);
}

/*@ normal_behavior
  @   requires (n % 2) == 0;
  @   assignable v;
  @   ensures v == "hi";
  @ also
  @ normal_behavior
  @   requires (n % 2) != 0;
  @   assignable w;
  @   ensures w == "bye";
  @*/
public void ifFun8(int n) {
  if(n % 2 == 0) {
    v = "hi";
    println(v);
  }
  else {
    w = "bye";
    println(w);
  }
}

/*@ normal_behavior
  @   requires true;
  @   assignable v, w;
  @   ensures v == "hi";
  @   ensures w == "bye";
  @*/
public void ifFun8Call() {
  ifFun8(4);
  ifFun8(5);
  ifFun8(6);
}

/*@ normal_behavior
  @   requires (n % 2) == 0;
  @   assignable v;
  @   ensures v == "hi zu";
  @ also
  @ normal_behavior
  @   requires (n % 2) != 0;
  @   assignable w;
  @   ensures w == "bye";
  @*/
public void ifFun9(int n) {
  if(n % 2 == 0) {
    v = "hi";
    int z = 3;
    v += " zu";
  }
  else {
    w = "bye";
  }
}

/*@ normal_behavior
  @   requires \old(v) == "bye";
  @   assignable t, v;
  @   ensures \result == 0;
  @   ensures t == i;
  @   ensures v == "zuzu";
  @ also
  @ normal_behavior
  @   requires \old(v) != "bye";
  @   assignable t;
  @   ensures \result == 0;
  @   ensures t == i;
  @*/
public int ifFun10() {
  int res = 0;
  if(v == "bye") {
    v = "hi";
    res += 1;
    v = "zuzu";
  }
  res = 0;
  t = i;
  return res;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int ifFun11() {
  int res = 0;
  if(false) {
    res += 1;
  }
  return res;
}

/*@ normal_behavior
  @   requires n >= 0;
  @   assignable \nothing;
  @   ensures \result == 1;
  @ also
  @ normal_behavior
  @   requires n < 0;
  @   assignable \nothing;
  @   ensures \result == 0;
  @*/
public int ifFun12(int n) {
  int res = 0;
  if(n >= 0) {
    res += 1;
  }
  return res;
}

/*@ normal_behavior
  @   requires (t % 2.0) == 0.0;
  @   assignable s, v;
  @   ensures s == "something" + toString(n);
  @   ensures v == "hi";
  @ also
  @ normal_behavior
  @   requires (t % 2.0) != 0.0;
  @   assignable s, w;
  @   ensures s == "something" + toString(n);
  @   ensures w == "bye";
  @*/
public void ifFun13() {
  if(t % 2 == 0) {
    v = "hi";
  }
  else {
    w = "bye";
  }
  s = "something" + toString(n);
}

/*@ normal_behavior
  @   requires (t % 2.0) == 0.0;
  @   assignable s, v;
  @   ensures s == "something" + toString(n);
  @   ensures v == "hi";
  @ also
  @ normal_behavior
  @   requires (t % 2.0) != 0.0;
  @   assignable s, w;
  @   ensures s == "something" + toString(n);
  @   ensures w == "bye";
  @*/
public void ifFun13Call() {
  ifFun13();
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void succFun(int i) {
  i += 1;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public void succFunCall() {
  int n = 2;
  succFun(n);
  println(toString(n));
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == n;
  @*/
public int callSuccFun(int n) {
  succFun(n);
  return n;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == 5;
  @*/
public int callCallSuccFun() {
  return callSuccFun(5);
}

/*@ normal_behavior
  @   requires arr != null;
  @   assignable \nothing;
  @   ensures \result == arr.length == 0;
  @*/
public boolean isEmpty(int[] arr) {
  return arr.length == 0;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == true;
  @*/
public boolean callIsEmpty() {
  return isEmpty(new int[]{});
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == false;
  @*/
public boolean callIsNotEmpty() {
  return isEmpty(new int[]{1,2,3});
}

/*@ normal_behavior
  @   requires input.length > 0;
  @   assignable status;
  @   ensures status == "non-empty";
  @ also
  @ normal_behavior
  @   requires input.length <= 0;
  @   assignable status;
  @   ensures status == "empty";
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

/*@
  @ public normal_behavior
  @   assignable status;
  @   ensures status.equals("empty");
  @*/
public void boo34Call() {
  boo34("Hello");
  println(status);
  boo34("");
  println(status);
}

/*@
  @ public normal_behavior
  @   requires arr != null;
  @   requires 0 <= i && i < arr.length;
  @   requires 0 <= j && j < arr.length;
  @   assignable arr[i], arr[j];
  @   ensures arr[i] == \old(arr[j]);
  @   ensures arr[j] == \old(arr[i]);
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

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @   ensures \result == (arr == null) || (arr.length <= 1);
  @*/
public static boolean arrayBoolean(int[] arr) {
  return arr == null || arr.length <= 1;
}

/*@ normal_behavior
  @   requires true;
  @   assignable \nothing;
  @*/
public static void arrayBooleanCall() {
  println(toString(arrayBoolean(new int[] {5})));
  println(toString(arrayBoolean(new int[] {5,6})));
  println(toString(arrayBoolean(null)));
}
