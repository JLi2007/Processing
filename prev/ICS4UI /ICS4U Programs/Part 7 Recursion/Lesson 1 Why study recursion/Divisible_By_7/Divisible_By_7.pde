void setup() {
  int x = 71;
  print( isDivBy7(x));
  
 
}


boolean isDivBy7(int x) {
  if ( x < 20 ) {
    if (x == -14 || x == -7 || x ==0 || x ==7 || x == 14 )
      return true;
    else
      return false;
  }
  
  else {
    int lastDigit = getLastDigit(x);//doesn't exist yet, will code later
    int otherDigits = getOtherDigits(x); 
    
    int revisedX = otherDigits - 2*lastDigit;
    return isDivBy7( revisedX );
    
  }
      
      
  
}  
