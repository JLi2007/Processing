String angleIncrement = "pi/6";

void setup () {
  size(900, 900);
  background(0);

  angleIncrement = getReducedFraction( angleIncrement ); //REDUCES THE ORIGINAL FRACTION IF NECESSARY
  
  int numerator = getNumerator( angleIncrement );
  int denominator = getDenominator( angleIncrement );
          
  printTable( numerator, denominator );
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
  //SETTING UP THE FONT 
  PFont f = createFont("Times New Roman", 22);
  textFont(f);
  
  //SETTINGS FOR THE SIZE AND SCALE OF THE TABLE
  int xAngleColumn = 100, xSinColumn = 200, xCosColumn = 300;
  int yHeader = 100;
  int rowHeight = 30;
  int currY = yHeader + rowHeight;
  
  //PRINTS THE 3 COLUMN HEADINGS AND THE HORIZONTAL BAR
  String thetaSymbol = "\u03B8";
  fill(255);      //THETA COLUMN IS WHITE
  text( thetaSymbol, xAngleColumn, yHeader);
  fill(0,255,0);  //SINE COLUMN IS GREEN
  text( "sin " + thetaSymbol, xSinColumn, yHeader);
  fill(255,0,0);  //COSINE COLUMN IS RED
  text( "cos " + thetaSymbol, xCosColumn, yHeader);
  stroke(255);   //HORIZONTAL LINE IS WHITE
  line(xAngleColumn, yHeader+5, xCosColumn+50,  yHeader+5);
  
  //INITIAL VALUES FOR GENERATING THE ROW VALUES
  String currFrac = "0";  //TABLE WILL ALWAYS START AT 0 RADIANS
  String printableFrac = "0";
  int currNumerator = 0;
  float currAngle = 0; 
  float angleIncrement = numerator*PI / denominator;  //DECIMAL EQUIVALENT OF THE STRING angleEquivalent

  //PRINTS THE ROWS
  while( currAngle <= 2*PI + .001 ) {
    
      //CALCULATES THE CURRENT ROW'S SINE AND COSINE VALUES, ROUNDED TO 4 DECIMAL PLACES
      float sinValue = roundAny( sin(currAngle), 4 );
      float cosValue = roundAny( cos(currAngle), 4 );
      
      //PRINTS THE CURRENT ROW
      fill(255);
      text( printableFrac, xAngleColumn, currY );   //PRINTS THE ANGLE
      fill(0,255,0);
      text( sinValue, xSinColumn, currY);           //PRINTS THE SIN VALUE
      fill(255,0,0);
      text( cosValue, xCosColumn, currY );          //PRINTS THE COS VALUE
      
      //UPDATES VALUES FOR THE NEXT ROW
      currNumerator += numerator;
      currAngle += angleIncrement;
      
      currFrac = currNumerator + "pi" + "/" + denominator; 
      currFrac = getReducedFraction( currFrac );
      
      printableFrac = getPrintableFraction( currFrac );  //REPLACES "pi" WITH THE UNICODE PI SYMBOL
      currY += rowHeight;                                //UPDATES THE Y-VALUE AT WHICH THE ROW WILL BE DRAWN
  }
}


//REPLACES "pi" WITH THE UNICODE PI SYMBOL
String getPrintableFraction( String frac ) {
  String piSymbol = "\u03c0";
  return frac.replaceAll("pi", piSymbol);
}


//EUCLID'S GCD ALGORITHM
int getGCD(int a, int b) {
  int Max = max(a,b);
  int Min = min(a,b);
  int R = Max % Min;
  
  while(R>0) {
    Max = Min;
    Min = R;
    R = Max % Min;
  }
  return Min;
}


//REDUCES FRACTIONS OF THE FORM Api/B BY FINDING THE GCD OF A AND B
String getReducedFraction( String frac ) {
  int numerator = getNumerator( frac );
  int denominator = getDenominator( frac );

  //REDUCES THE NUMERATOR & DENOMINATOR TO LOWEST TERMS
  int gcd = getGCD( numerator, denominator);
  numerator /= gcd;
  denominator /= gcd;
    
  //BUILDS THE NEW FRACTION STRING
  if (denominator == 1 && numerator == 1)  //EX. "1pi/1" --> "pi" 
    return "pi";
      
  else if (denominator == 1)               //EX. "3pi/1" --> "3pi" 
    return numerator + "pi";
      
  else if (numerator == 1)                 //EX. "1pi/5" --> "pi/5"     
    return "pi/" + denominator;
      
  else
    return numerator + "pi/" + denominator; //EX. "6pi/7" 
}


float roundAny(float x, int d) {  
  float y = x * pow(10,d);  
  float z = round(y);  
  return z/pow(10,d);  
}
