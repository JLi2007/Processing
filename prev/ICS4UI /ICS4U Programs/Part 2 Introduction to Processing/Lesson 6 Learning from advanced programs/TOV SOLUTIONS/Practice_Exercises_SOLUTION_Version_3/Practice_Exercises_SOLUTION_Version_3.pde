String angleIncrementString = "pi/6";

void setup () {
  int numerator = getNumerator( angleIncrementString );      //1
  int denominator = getDenominator( angleIncrementString );  //6

  printTable( numerator, denominator );
  exit();
}


int getNumerator( String frac ) {
  int piIndex = frac.indexOf( "pi" );

  if (piIndex == 0)
    return 1; 

  else 
  return int( frac.substring(0, piIndex) );
}


int getDenominator( String frac ) {
  int piIndex = frac.indexOf("pi");

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
  String currFrac = "0";  //FIRST ROW WILL ALWAYS START AT "0"
  int currNumerator = 0;
  float currDecimalAngle = 0;    //THE DECIMAL EQUIVALENT OF THE ANGLE FOR THE CURRENT ROW
  float angleIncrement = numerator*PI / denominator;  //DECIMAL EQUIVALENT OF THE STRING angleIncrementString

  //PRINTS THE ROWS
  while ( currDecimalAngle <= 2*PI + .001 ) 
  {
    //CALCULATES THE CURRENT ROW'S TRIG VALUES
    float sinValue = roundAny( sin(currDecimalAngle), 4 );   //currAngle might be, say, 1.23243
    float cosValue = roundAny( cos(currDecimalAngle), 4 );

    //PRINTS THE CURRENT ROW
    println( currFrac + "\t\t" + sinValue + "\t\t" + cosValue );

    //UPDATES VALUES FOR THE NEXT ROW
    currNumerator += 1;
    currDecimalAngle += angleIncrement;

    currFrac = currNumerator + "pi" + "/" + denominator; //"1pi/6", "2pi/6", "3pi/6", "4pi/6", "5pi/6", etc.
    currFrac = getReducedFraction( currFrac );  //Reduces "4pi/6"  --> "2pi/3"
  }
}



//REDUCES FRACTIONS OF THE FORM Api/B BY FINDING THE GCD OF A AND B
String getReducedFraction( String frac ) { //"4pi/6"
  int numerator = getNumerator( frac );     //4
  int denominator = getDenominator( frac ); //6

  //REDUCES THE NUMERATOR & DENOMINATOR TO LOWEST TERMS
  int gcd = getGCD( numerator, denominator);  //2
  numerator /= gcd;    //2
  denominator /= gcd;  //3

  //BUILDS THE NEW FRACTION STRING
  if (denominator == 1 && numerator == 1)   //EX. "1pi/1" --> "pi" 
    return "pi";

  else if (denominator == 1)                //EX. "3pi/1" --> "3pi" 
    return numerator + "pi";

  else if (numerator == 1)                  //EX. "1pi/5" --> "pi/5"     
    return "pi/" + denominator;

  else
    return numerator + "pi/" + denominator; //EX. "2pi/3"
}


//EUCLID'S GCD ALGORITHM
int getGCD(int a, int b) {
  int Max = max(a, b);
  int Min = min(a, b);
  int R = Max % Min;

  while (R>0) {
    Max = Min;
    Min = R;
    R = Max % Min;
  }
  
  return Min;
}


float roundAny(float x, int d) {  
  float y = x * pow(10, d);  
  float z = round(y);  
  return z/pow(10, d);
}
