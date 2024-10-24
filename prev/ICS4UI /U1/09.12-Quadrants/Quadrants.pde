void setup() {
  float x, y;
  
  //I WISH I COULD JUST TYPE THIS:
  //String op1 = "(23.3, -424)";
  //println("The point (" + x + ", " + y + ") is",   getLocation( op1 ));
 
  x = 3; y = -4; 
  println("The point (" + x + ", " + y + ") is", getLocation(x, y));

  x = 0; y = -4; 
  println("The point (" + x + ", " + y + ") is", getLocation(x, y));
  
  x = 2.5; y = 0; 
  println("The point (" + x + ", " + y + ") is", getLocation(x, y));

  x = -2.5; y = 5; 
  println("The point (" + x + ", " + y + ") is", getLocation(x, y));
  
  x = random(-100, 100); y = random(-100, 100);
  println("The point (" + nf(x, 1, 2) + ", " + nf(y, 1, 2) + ") is", getLocation(x, y));
}
