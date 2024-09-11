String a = "43567pi/6564";

void setup() {
  int numerator, denominator;
  
  int piIndex = a.indexOf( "pi" );
  
  numerator = getNumerator( piIndex );
  
  int slashIndex = a.indexOf( "/" );
  
  denominator = getDenominator( piIndex, slashIndex );
  
  float degAngle = numerator * 180.0 / denominator;
  println(a, "rad =", degAngle, "degrees");
}
