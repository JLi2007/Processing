String angleIncrement = "pi/3";

void setup () {
  int numerator = getNumerator( angleIncrement );
  int denominator = getDenominator( angleIncrement );
          
  printTable( numerator, denominator );
  exit();
}


int getNumerator( String frac ) {
  int piIndex = frac.indexOf( "p" );
  
  if (piIndex == 0)
    return 1; 
    
  else 
    return int( frac.substring(0, piIndex) );
}


int getDenominator( String frac ) {
  int piIndex = frac.indexOf("p");
  
  if ( piIndex + 2 == frac.length() )
    return 1;
    
  else
    return int( frac.substring( piIndex+3 ));
}


void printTable( int numerator, int denominator ) {
  //PRINTS THE 3 COLUMN HEADINGS AND THE HORIZONTAL BAR
  println( "x", "\t\t", "sin x", "\t", "cos x");
  println("_____________________________");
  
  //INITIAL VALUES FOR GENERATING THE ROW VALUES
  String currFrac = "0";  //TABLE WILL ALWAYS START AT 0 RADIANS
  int currNumerator = 0;
  float currAngle = 0; 
  float angleIncrement = numerator*PI / denominator;  //DECIMAL EQUIVALENT OF THE STRING angleEquivalent

  //PRINTS THE ROWS
  while( currAngle <= 2*PI + .001 ) 
  {
      //CALCULATES THE CURRENT ROW'S TRIG VALUES
      float sinValue = roundAny( sin(currAngle), 4 );
      float cosValue = roundAny( cos(currAngle), 4 );
      
      //PRINTS THE CURRENT ROW
      println( currFrac + "\t\t" + sinValue + "\t\t" + cosValue );
      
      //UPDATES VALUES FOR THE NEXT ROW
      currNumerator += numerator;
      currAngle += angleIncrement;
      
      currFrac = currNumerator + "pi" + "/" + denominator; 
  }
}


float roundAny(float x, int d) {  
  float y = x * pow(10,d);  
  float z = round(y);  
  return z/pow(10,d);  
}
