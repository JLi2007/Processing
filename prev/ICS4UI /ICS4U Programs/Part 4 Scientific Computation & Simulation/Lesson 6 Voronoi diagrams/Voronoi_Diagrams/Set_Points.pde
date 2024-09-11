void setPointsLine(float x1, float y1, float x2, float y2) {
  float x=x1, y=y1;
  float dx = (x2-x1)/maxNumPoints, dy = (y2-y1)/maxNumPoints;
  n = 0;
  //p[0] = new PVector(width/2, height/2);
  for (int i=0; i<maxNumPoints; i++) {
    p[i] = new PVector(x, y);
    x += dx;
    y += dy;
    n++;
  }
}


void setPointsCircle( float rx, float ry, float numWraps) {
  numPoints = maxNumPoints;
  float dTheta = 2*PI/numPoints*numWraps;
  float a = pow(0.1, 1.0/numPoints);
  float dRadiusX = rx/numPoints;
  float dRadiusY = ry/numPoints;
  
  float xC = width/2;
  float yC = height/2;
  float x, y;
  float theta = 0;

  for (int k = 0; k < numPoints; k++) {
    x = xC + rx*cos(theta);
    y = yC - ry*sin(theta);
    p[k] = new PVector(x, y);
    //r = r*a;
    if ( numWraps > 1) {
      rx -= dRadiusX;
      ry -= dRadiusY;
    }
    theta += dTheta;
  }
}


void setPointsWave(float A, float numPeaks, float decayFactor) {
  numPoints = maxNumPoints;
  float waveLength = width/numPeaks;
  float freq = TWO_PI/waveLength;
  float dx = width/float(numPoints);
  
  float yC = height/2;
  float x, y;
  x = 2;

  for (int k = 0; k < numPoints; k++) {
    y = yC - A*sin(freq*x);
    p[k] = new PVector(x, y); 
    x += dx;
    A *= decayFactor;
  }
}


void setPointsGrid(int rows, int cols, int pad) {
  numPoints = rows*cols;
  println(numPoints);
  int k = 0;
  float dx = width/cols;
  float dy = height/rows;
  
  for(int i = 0; i < rows; i++) {
    float y = i * dy + random(-10,10);
    for(int j = 0; j < cols; j++) {
      float x = j * dx + random(-10,10);
      p[k] = new PVector(x, y);
      k++;
    }
  }
}
