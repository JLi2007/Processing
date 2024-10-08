static class Fraction {
 
  //FIELDS
  int numerator;
  int denominator; 
  String label;
  String emoState;
       
  //CONSTRUCTOR 1
  Fraction( int n, int d ) {
    this.numerator = n;
    this.denominator = d;
    this.label = "";
  }
  
  //CONSTRUCTOR 2
  Fraction( int n, int d, String l ) {
    this.numerator = n;
    this.denominator = d;
    this.label = l;
  }

 //CONSTRUCTOR 3
 Fraction( float x, String l){
   //Logic to convert float to decimal
   String decimals = split(nf(x), ".")[1];
   float multiply = pow(10, decimals.length());
   float newX = x*multiply;
   //Strategy to count down instead of counting up so can immediately stop checking after finding a factor
   for(int reduce=int(multiply); reduce>0; reduce--){
     if(newX%reduce ==0 && multiply%reduce==0){
       newX /= reduce;
       multiply /= reduce;
       this.numerator=int(newX);
       this.denominator=int(multiply);
       this.label=l;
       return;
     }
   }
   
   this.numerator=int(newX);
   this.denominator=int(multiply);
   this.label=l;
 }


  //METHODS
  void display() {         
    String printedFrac = this.numerator + "/" + this.denominator; 
    
    if ( this.label.equals( "" ) )
      println( printedFrac );
    
    else
      println( this.label + " = " + printedFrac );   
  }
  
  void reduce() {
    int gcd = getGCD( this.numerator, this.denominator );
    
    this.numerator /= gcd;
    this.denominator /= gcd;       
  }
 
  float toDecimal() {
    return float(this.numerator) / this.denominator; 
  }
 
  //METHODS THAT RETURN A NEW FRACTION OBJECT
  Fraction reciprocal() {
    return new Fraction( this.denominator, this.numerator, "1 / " + this.label);
  }
  
  
  Fraction multiply( Fraction other ) {
    int num2 = this.numerator * other.numerator;
    int den2 = this.denominator * other.denominator;
    
    Fraction p = new Fraction( num2, den2, this.label + "x" + other.label   );
    return p;
  }

  Fraction power(int exponent){
     int num3 = int(pow(this.numerator,exponent));
     int den3 = int(pow(this.denominator,exponent));

     Fraction p = new Fraction(num3, den3, this.label + "^" + exponent);
     return p;
  }
  
  
  //The following 4 methods are "static". 
  //Static methods are just "helper methods" that don't require information about any particular Fraction object.
  //To call a static method inside setup, you use <CLASS NAME>.<METHOD NAME> instead of <OBJECT VARIABLE NAME>.<METHOD NAME>  
  //For example, Fraction.getGCD(6, 8);
  static int getGCD(int a, int b) { //Euclid's algorithm
    int max, min, rem;
    
    max = max(a, b);
    min = min(a, b);
    
    rem = max % min;
    
    while (rem > 0) {
      max = min;
      min = rem;
      rem = max % min;
    }
    
    return min;
  }
  
  
  static int getLCM(int a, int b) {
    //CODE THIS ON YOUR OWN
    return -1;
  }
  
  
  //This method is "private" because it's only needed by other methods in the class, and not by setup().
  //The user has no access to it from setup().
  private static boolean isWholeNumber( float d ) {
    return d == round(d);
  }
  
} //END OF FRACTION CLASS
