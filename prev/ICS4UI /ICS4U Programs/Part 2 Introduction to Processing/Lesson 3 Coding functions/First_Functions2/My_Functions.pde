//Code the function f(x) = square root of x+5

float f(float x) {
  return sqrt(x+5);
}

float KE( float m, float v ) {
  return 0.5*m*pow(v, 2);  
}


String getLongerWord( String t, String s ) {
  if( t.length() > s.length() ) {
    return t;
  }
  
  else if( t.length() < s.length() ) {
    return s;
  }
  
  else {
    return "tie";
  }
  
}
