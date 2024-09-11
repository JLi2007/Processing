//new version
String getLocation( String p ) {
  //Pick apart the string p to extract the x and y values
  //Example: p = "(23.1, -6778.42)"
  float x,y;
  
// use substrings to pick apart the String p to extract x and y vallues

x = float p.substring(1)
  
  if ( x==0 && y==0 )   
    return "at the origin";
   
  else if ( x==0 ) 
    return "on the y-axis";
   
  else if ( y==0 ) 
    return "on the x-axis";
   
  else if ( x>0 && y>0 ) 
    return "in Quadrant 1";
   
  else if ( x<0 && y>0 )
    return "in Quadrant 2";
   
  else if ( x<0 && y<0 ) 
    return "in Quadrant 3";
   
  else 
    return "in Quadrant 4";
}
