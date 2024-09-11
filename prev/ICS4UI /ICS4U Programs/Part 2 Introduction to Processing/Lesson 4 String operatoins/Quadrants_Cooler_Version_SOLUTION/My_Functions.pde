String getLocationFromOrderedPair( String pair )  //  "(34.5, -6.0)"
{
  float xVal, yVal;
  
  int commaIndex = pair.indexOf(",");
  int bracketIndex = pair.indexOf(")");
  
  xVal = float( pair.substring( 1, commaIndex ) );
  yVal = float( pair.substring( commaIndex+1, bracketIndex ) );
  
  return getLocation(xVal, yVal);
}


String getLocation(float x, float y) {
  
  if ( x == 0 && y == 0 ) 
    return "at the origin";
   
  else if ( x == 0 ) 
    return "on the y-axis";
   
  else if ( y == 0 ) 
    return "on the x-axis";
   
  else if ( x > 0 && y > 0 ) 
    return "in quadrant 1";
   
  else if ( x < 0 && y > 0 ) 
    return "in quadrant 2";
   
  else if ( x < 0 && y < 0 ) 
    return "in quadrant 3";
   
  else 
    return "in quadrant 4";
}
