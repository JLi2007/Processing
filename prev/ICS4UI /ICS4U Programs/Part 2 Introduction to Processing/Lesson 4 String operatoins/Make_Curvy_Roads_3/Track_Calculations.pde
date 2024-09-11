void resetTrack() {
  float dTheta = TWO_PI/n;
  float theta = 0;
  float rx = width/2.5;
  float ry = height/2.5;
  float xC = width/2 + 25;
  float yC = height/2;
  
  for ( int i = 0; i < dots.length; i++ ) {
    float xDot = xC + rx*cos(theta) + random(-30, 30);
    float yDot = yC - ry*sin(theta) + random(-50, 50);
    dots[i] = new PVector( xDot, yDot );
    theta += dTheta;
  }
  
  setCurveLengths();
}

void setCurveLengths() {
  PVector d1, d2, d3, d4;
  float dxdt, dydt, deltaT;
  
  deltaT = 0.01;
  
  for(int i = 0; i < dots.length; i++ ) {
    float L = 0;
    for( float t = 0; t <= 1; t += .01 ) {
      d1 = dots[i];
      d2 = dots[(i+1) % n];
      d3 = dots[(i+2) % n];
      d4 = dots[(i+3) % n];
      dxdt = getDerivative( d1.x, d2.x, d3.x, d4.x, t );
      dydt = getDerivative( d1.y, d2.y, d3.y, d4.y, t ); 
      //print(i, dxdt, dydt, sqrt( pow(dxdt,2) + pow(dydt,2)), "\t");
      L += sqrt( pow(dxdt,2) + pow(dydt,2)) * deltaT;
    }
    curveLengths[i] = L;
   
  }
}
