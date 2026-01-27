public int boo21(){
  return 5;
}

////////////////////////////////////////

public int boo21_2(){
  int i;
  return 5;
}

////////////////////////////////////////

public int boo22(){
  return boo21();
}

////////////////////////////////////////

public int boo22_2(){
  int x = boo21();
  return x;
}

////////////////////////////////////////

public int boo23_3(){
  int x = 3 + boo21();
  return 5;
}

////////////////////////////////////////

public int boo23_4(){
  return 3 + boo21();
}

////////////////////////////////////////

public int boo23_5(){
  return 8;
}

////////////////////////////////////////

public double boo23_6(){
  return 8;
}

////////////////////////////////////////

public double boo23_7(){
  return 3+5;
}

////////////////////////////////////////

public int boo23_8(){
  return 3+5;
}

////////////////////////////////////////

public int boo23_9(){
  int x;
  x = 3 + boo21();
  return x;
}

////////////////////////////////////////

public int boo23_10(){
  int x = 3+5;
  return x;
}

////////////////////////////////////////

public int boo23_11(){
  int x = 3+5;
  x = 10-1;
  return x;
}

////////////////////////////////////////

public int boo23_12(){
  int x = 3 + boo21();
  return x;
}

////////////////////////////////////////

public double boo33_3(){
  double x = 1;
  x+=0.1;
  return x;
}

////////////////////////////////////////

public double boo33_4(){
  double x = 1;
  x = x + 0.1;
  return x;
}

////////////////////////////////////////

public double boo33_5(String str){
  double x = 1;
  int y;
  z = t;
  x = x + 0.1;
  return x;
}

////////////////////////////////////////


public double boo33_6(String str){
  double x = 1;
  int y;
  z = t;
  x = x + 0.1;
  z = 1;
  return x;
}

////////////////////////////////////////

public double boo33_7(){
  double x;
  x = c;
  return x;
}

////////////////////////////////////////

public int boo21_i(int i){
  return i;
}

////////////////////////////////////////

public int boo21_2_i(int i){
  i = 5;
  return i;
}

////////////////////////////////////////

public int boo21_3_i(int i){
  i += 2;
  return i;
}

////////////////////////////////////////

public int boo21_3_i_1(int i){
  i += 2;
  return i+i;
}

////////////////////////////////////////

public int boo21_3_i_2(int i){
  i += 2;
  int x = i + 5 + i;
  return x;
}

////////////////////////////////////////

public int boo21_3_i_3(int i){
  i += 2;
  int x = i + 5 + i;
  return x + i + x;
}

////////////////////////////////////////

public int boo21_3_i_4(int i){
  x += i + 2 + i;
  return x;
}

////////////////////////////////////////

public int boo21_3_i_5(int i){
  x += i + 2 - 2*i;
  return x;
}

////////////////////////////////////////

public int boo21_3_i_6(int i){
  x += 2 + 3*i - 2*i;
  return x;
}

////////////////////////////////////////

public int boo21_3_i_7(int i){
  x += 2 + 3*i - 2*i - i;
  return x;
}

////////////////////////////////////////

public int boo21_3_i_8(int i){
  x += i + 2 + 3*i;
  return x;
}

////////////////////////////////////////

public int boo21_3_i_9(int i){
  i += i;
  return i;
}

////////////////////////////////////////

public int boo22_i(int i){
  return boo21_i(i);
}

////////////////////////////////////////

public int boo22_i_2(int i){
  return boo21_i(i+4) + 1;
}

////////////////////////////////////////

public int boo22_i_3(int i){
  return boo21_3_i(i);
}

////////////////////////////////////////

public int boo22_i_4(int i){
  return boo21_3_i(i+4) * 5;
}

////////////////////////////////////////

public int boo22_i_5(int i){
  return boo21_3_i(j);
}

////////////////////////////////////////

public int boo22_2_i(int i){
  int x = boo21_i(i*2);
  return x;
}

////////////////////////////////////////

public int boo22_2_i_2(){
  int j = 6;
  int i = 3 + j;
  int x = boo21_i(i*2);
  return x + i + j;
}

////////////////////////////////////////

public int boo23_3_i(int i){
  int x = 3 + boo21_i(i+i);
  return 5;
}

////////////////////////////////////////

public int boo23_3_i_2(){
  int i = 4;
  int x = 3 + boo21_i(i+i);
  return x+5;
}

////////////////////////////////////////

public int boo23_4_i(int i){
  return 3 + boo21_i(0);
}

////////////////////////////////////////

public int boo23_4_i_2(){
  return 5 * boo21_i(0*4+2);
}

////////////////////////////////////////

public int boo23_4_i_3(int i){
  return 5 * boo21_i(0*i+2);
}

////////////////////////////////////////

public int boo23_4_i_4(int i){
  return 15 * boo21_i(3*i+2);
}

////////////////////////////////////////

public int boo23_4_i_4_1(){
  return boo23_4_i_4(5);
}

////////////////////////////////////////

public int boo23_4_i_5(int i){
  return 15 * boo21_i(1*i+2);
}

////////////////////////////////////////

public int boo23_5_i(int i){
  return 8;
}

////////////////////////////////////////

public double boo23_6_i(int i){
  return 8;
}

////////////////////////////////////////

public double boo23_7_i(int i){
  return 3+5+i;
}

////////////////////////////////////////

public int boo23_8_i(int i){
  return 3+5*i;
}

////////////////////////////////////////

public int boo23_9_i(int i){
  int x;
  x = 3 + boo21_i(i+2) - i;
  return x;
}

////////////////////////////////////////

public int boo23_9_i_2(int i){
  int x;
  x = 3 + boo21_i(i+2) - 2*i;
  return x;
}

////////////////////////////////////////

public int boo23_10_i(int i){
  int x = 3+5+i;
  return x;
}

////////////////////////////////////////

public int boo23_10_i_2(int i){
  int x = 3+i+5;
  return x;
}

////////////////////////////////////////

public int boo23_11_i(int i){
  int x = 3+5;
  x = 10-1;
  return x*i;
}

////////////////////////////////////////

public int boo23_12_i(int i){
  int x = 3 + boo21_i(i);
  return x;
}

////////////////////////////////////////

public double boo33_3_i(double i){
  double x = 1 + i;
  x+=0.1;
  return x;
}

////////////////////////////////////////

public double boo33_4_i(double i, double j){
  double x = 1 + i;
  x = x + 0.1 + j;
  return x;
}

////////////////////////////////////////

public int boo24(){
  int x = 3 + boo25(5);
  return x;
}

////////////////////////////////////////

public int boo24_2(){
  int x = 3 + boo25(11);
  return x;
}

////////////////////////////////////////

public int boo25(int i){
  if(i>10){
    println("Oopsie");
    throw new Exception("meow");
  }
  else{
    return 6;
  }
}

////////////////////////////////////////

public int boo26_2(){
  return boo27(-5);
}

////////////////////////////////////////

public int boo27(int i){
  if(i >= 0){
    return i;
  }
  else{
    int res = -1 * i;
    return res;
  }
}

////////////////////////////////////////

public int boo27_2() {
  return boo27(5);
}

////////////////////////////////////////

public int boo28(int i){
  int x = 1;
  if(i >= 0){
    x++;
    return i;
  }
  return 5;
}

////////////////////////////////////////

public int boo282(){
  int x = 1;
  if(x >= 0){
    x++;
    return x;
  }
  return 5;
}

////////////////////////////////////////

public int boo283(){
  int x = 1;
  if(x < 0){
    x++;
    return x;
  }
  return 5;
}

////////////////////////////////////////

public int boo28_p() {
  return boo28(10);
}

////////////////////////////////////////

public int boo28_m() {
  return boo28(-10);
}

////////////////////////////////////////

public int boo28_2(int i){
  int x = 1;
  if(i >= 0){
    x++;
    int y = 0;
    return i;
  }
  return 5;
}

////////////////////////////////////////

public int boo28_2_1(){
  int x = 1;
  if(x >= 0){
    x++;
    int y = 0;
    return 1+x+1;
  }
  return 5;
}

////////////////////////////////////////

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

////////////////////////////////////////

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

////////////////////////////////////////

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

////////////////////////////////////////

public int boo28_4_p() {
  return boo28_4(10);
}

////////////////////////////////////////

public int boo28_4_m() {
  return boo28_4(-10);
}

////////////////////////////////////////

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

////////////////////////////////////////

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

////////////////////////////////////////

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

////////////////////////////////////////

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

////////////////////////////////////////

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

////////////////////////////////////////

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

////////////////////////////////////////

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

////////////////////////////////////////

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

////////////////////////////////////////

public int boo28_6_p() {
  return boo28_6(10);
}

////////////////////////////////////////

public boolean boo29(){
  if(true){
    return false;
  }
  else{
    return true;
  }
}

////////////////////////////////////////

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

////////////////////////////////////////

public int boo31(){
  z = 0;
  int x = z;
  return x;
}

///////////////////////////////////////////////////

public int boo31_2(){
  z = 0;
  int x = z;
  return boo30(1);
}

///////////////////////////////////////////////////

public int boo32(){
  int x = y1 + y2 + y3;
  return x;
}

///////////////////////////////////////////////////

public int elemAt(int[] arr, int pos) throws Exception {
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

////////////////////////////////////////

public int elemAtCall() throws Exception {
  return elemAt(new int[]{6,5,4,7,8},2);
}

////////////////////////////////////////

public int elemAt2(int pos) throws Exception {
  int[] arr = new int[]{6,5,4,7,8};
  if(arr.length<=pos) {
    throw new Exception("not found");
  }
  return arr[pos];
}

////////////////////////////////////////

public int elemAt2call() {
  return elemAt2(2);
}

////////////////////////////////////////

public int elemAt2call2() {
  return elemAt2(5);
}

////////////////////////////////////////

public int elemAt4() {
  int[] arr = {6,5,4,7,8};
  return arr[3];
}

////////////////////////////////////////

public String strFun() {
  String firstName = "Tarek";
  String lastName = "Soliman";
  return firstName + " " + lastName;
}

////////////////////////////////////////

public void voidFun1() {
  return;
}

////////////////////////////////////////

public void voidFun2() {
}

////////////////////////////////////////

public void voidFun3() {
  int x;
  String y;
  x = 1;
  y = "is one";
  String z = toString(x) + " " + y;
}

////////////////////////////////////////

public void voidFun4() {
  int x;
  String y;
  x = 1;
  y = "is one";
  String z = toString(x) + " " + y;
  println(z);
}

////////////////////////////////////////

public void voidFun5() {
  println("Before");
  voidFun4();
  println("After");
}

////////////////////////////////////////

public void manyArrs() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  println(numbers);
}

////////////////////////////////////////

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

///////////////////

public int[] manyArrs3() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  numbers[1] = 5;
  return numbers;
}

///////////////////

public void manyArrs4() {
  int[] numbers = new int[2];
  numbers[0] = 99;
  println(numbers);
}

///////////////////

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

/////////////////////

public int ifFunCall() {
  return 4+ifFun(3);
}


/////////////////////

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

/////////////////////

public int ifFun2Call() {
  return ifFun2(10);
}

/////////////////////

public int ifFun2Call2() {
  return ifFun2(-10);
}

/////////////////////

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

/////////////////////

public int ifFun4(int n) {
  if(y>=0) {
    y += n;
  }
  return y;
}

/////////////////////

public int ifFun5(int n) {
  y = n;
  if(y>=0) {
    y += n;
  }
  return y;
}

/////////////////////

public int ifFun5Call1() {
  return ifFun5(10);
}

/////////////////////

public int ifFun5Call2() {
  return ifFun5(-10);
}

/////////////////////

public String ifFun6(int n) {
  if(y>=0) {
    m += n;
  }
  s = "something";
  return c;
}

/////////////////////

public void ifFun7(int n) {
  if(n % 2 == 0) {
    v = "hi";
  }
  else {
    w = "bye";
  }
}

/////////////////////

public void ifFun7Call() {
  ifFun7(4);
}

/////////////////////

public void ifFun7Call2() {
  ifFun7(4);
  ifFun7(5);
}

/////////////////////

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

/////////////////////
