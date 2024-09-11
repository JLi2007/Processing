void setup() {
  String p;
  
  p = "(1367.2, -54.999)"; 
  println("The point", p, "is", getLocationFromOrderedPair(p));

  p = "(0, -4)"; 
  println("The point", p, "is", getLocationFromOrderedPair(p));
  
  p = "(-62.5, -0.03)"; 
  println("The point " + p + " is " + getLocationFromOrderedPair(p));

  p = "(-28.541, 150.7)"; 
  println("The point " + p + " is " + getLocationFromOrderedPair(p));
}
