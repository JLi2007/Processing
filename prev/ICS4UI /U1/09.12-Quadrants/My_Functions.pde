// String getLocation( float x, float y ) {
  
//   if ( x==0 && y==0 )   
//     return "at the origin";
   
//   else if ( x==0 ) 
//     return "on the y-axis";
   
//   else if ( y==0 ) 
//     return "on the x-axis";
   
//   else if ( x>0 && y>0 ) 
//     return "in Quadrant 1";
   
//   else if ( x<0 && y>0 )
//     return "in Quadrant 2";
   
//   else if ( x<0 && y<0 ) 
//     return "in Quadrant 3";
   
//   else 
//     return "in Quadrant 4";
// }

String getLocationFromOrderedPair( String pair )
{
  float xVal, yVal;
  
  //Add code that extracts the x and y values from the String parameter named "pair" and assigns those values to 
  //the variables xVal and yVal
  
  return getLocation( xVal, yVal ); 
}



String getLocation(float x, float y) {
  if ( x==0 && y==0 ) 
    return "at the origin";
   
  else if ( x==0 ) 
    return "on the y-axis";
   
  else if ( y==0 ) 
    return "on the x-axis";
   
  else if ( x>0 && y>0 ) 
    return "in quadrant 1";
   
  else if ( x<0 && y>0 ) 
    return "in quadrant 2";
   
  else if ( x<0 && y<0 ) 
    return "in quadrant 3";
   
  else 
    return "in quadrant 4";
}
