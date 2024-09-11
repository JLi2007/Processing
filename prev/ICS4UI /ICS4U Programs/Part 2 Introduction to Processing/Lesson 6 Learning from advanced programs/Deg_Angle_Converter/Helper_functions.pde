
int getNumerator(int piIndex) {
  int numerator;
  
  if (piIndex == 0) {
    numerator = 1;
  }
  
  else {
    numerator = int( a.substring(0, piIndex) );
  }
  
  return numerator;
}


int getDenominator(int piIndex, int slashIndex) {
  
  if (slashIndex == -1) {
    return 1;
  }
  
  else {
    return int(a.substring(piIndex+3));
  }  
}
