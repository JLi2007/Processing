
void resetParameters() {
  a = float(aSlider.getValueI())/100.0 * xMax; 
  b = float(bSlider.getValueI())/100.0 * yMax; 
  raySpeed = float(speedSlider.getValueI())/2.0;
  numRays = min( int(numRaysTextfield.getText()), maxNumRays );
  String bulbPlacement = bulbPlacementList.getSelectedText();
  
  e = new QuadraticCurve(a, b); 

  if (bulbPlacement.equals("Center")) {
    xBulb = 0; 
    yBulb = 0;
  }
  
  else if (bulbPlacement.equals("Focus")) {
    xBulb = e.f1x; 
    yBulb = e.f1y;
  }
  
  else if (bulbPlacement.equals("Left edge")) {
    xBulb = -a*0.99; 
    yBulb = 0;
  }
  
  else if (bulbPlacement.equals("Top edge")) {
    xBulb = 0; 
    yBulb = b*0.99;
  }
  
  else if (bulbPlacement.equals("1/4 between foci")) {
    if (a >= b) {
      xBulb = e.f1x * 0.25 + e.f2x * 0.75;
      yBulb = 0;
    }
    
    else {
      xBulb = 0; 
      yBulb = e.f1y * 0.25 + e.f2y * 0.75;
    }
  }

  bulb = new Bulb( xBulb, yBulb, raySpeed, numRays );
}


float getAngle(float vx, float vy, float wx, float wy){
  float dotProd = vx*wx + vy*wy;
  float vMag = sqrt(vx*vx + vy*vy);
  float wMag = sqrt(wx*wx + wy*wy);
  return acos(dotProd/(vMag*wMag));
}


float getScreenX(float xMath) {
  return xMath + bx;
}


float getScreenY(float yMath) {
  return by - yMath;
}
