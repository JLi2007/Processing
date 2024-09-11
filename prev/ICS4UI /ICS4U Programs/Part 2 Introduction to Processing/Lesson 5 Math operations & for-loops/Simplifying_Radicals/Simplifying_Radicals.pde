void setup() {
  int N = 237600; //12*12*3*5*11*5*2 = 60 sqrt(66)

  int n = N;
  int outsideRadical = 1;
  int insideRadical = n;
  String primeFactorization = n + " = ";  //Example: "2 x 2 x 2 x 3 x 7"
  
  int f = 2;
  
  while(n > 1) { 
    int repeatCount = 0;  //For keeping track of repeated factors. repeatCount will always be 0, 1 or 2
    
    while( n % f == 0 ) {  //Keep dividing n by f for as long as n is still divisible by f...
      repeatCount++;  
      
      if ( repeatCount == 2 ) {  //We've found a pair of identical factors, so we pull one out of the radical
        outsideRadical *= f;         //Pulling that factor outside the radical
        insideRadical /= pow(f, 2);  //Dividing what's left under the radical by f*f
        repeatCount = 0;             //Setting repeatCount back to 0 before searching for the next repeated factor
      }
      
      n /= f;
      primeFactorization +=  f + " x ";
    }
    f++;
  }
  
  println( chopOffLastX( primeFactorization ) );
  println( "sqrt(" + N + ") = " + outsideRadical + "*sqrt(" + insideRadical + ")");
}
