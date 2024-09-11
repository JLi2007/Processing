void drawAngle() {
  
  //DRAWS PINK ARC AT THE ORIGIN
  fill( angleCol );
  noStroke();
  arc(xC, yC, arcDiameter, arcDiameter, TWO_PI-(theta-.02), TWO_PI, PIE);
  
  
  //DRAWS THE THETA SYMBOL AT THE ORIGIN
  if( showThetaSymbol && theta > 0.395 ) {
    fill(0,0,255);
    textSize( 20 );
    textAlign(CENTER, CENTER);
    text( thetaSymbol, xThetaSymbol, yThetaSymbol );
  }
  
}
