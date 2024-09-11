void setup() {
  float y = f(11);
  println("y is", y);
  
  y = f(-3);
  println("y is", y);
  
  y = f(-20);
  println("y is", y);
}


float f( float x ) {
  return sqrt(x+5);
}
