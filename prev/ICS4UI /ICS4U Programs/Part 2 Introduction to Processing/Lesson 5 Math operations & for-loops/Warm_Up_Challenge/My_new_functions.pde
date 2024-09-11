void extractStuff() {
  //GETTING THE COLOR
  int colorStartIndex = request.indexOf( " a " ) + 3;
  int circleIndex = request.indexOf( " circle" );
  col = request.substring( colorStartIndex, circleIndex);
  
  //GETTING xC
  int xStartIndex = request.indexOf( "(" ) + 1;
  int commaIndex = request.indexOf(",");
  xC = float( request.substring( xStartIndex, commaIndex ));
  
  //GETTING yC
  int yStartIndex = commaIndex + 2;
  int bracketIndex = request.indexOf(")");
  yC = float( request.substring( yStartIndex, bracketIndex ));
  
  //GETTING d
  int dStartIndex = request.indexOf( "diameter" ) + 9;
  d = float( request.substring( dStartIndex )); 
}
