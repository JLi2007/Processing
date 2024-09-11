int getLastDigit(x) {
  ////x = 6519   --- > 9
  //return x % 10; 
  
  ////or 
  
  String s = str(x);
  int L = s.length();
  return int( s.substring( L-1, L) );
  
}
