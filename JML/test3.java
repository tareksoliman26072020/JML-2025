public int boo21(){
  return 5;
}

////////////////////////////////////////

public int boo22(){
  return boo21();
}

////////////////////////////////////////

public int boo23_2(){
  return 3 + boo21();
}

////////////////////////////////////////

public int boo23(){
  int x = 3 + boo21();
  return x;
}
