void arrangeBalls(int numRows) {
  
  float sq3 = r*sqrt(3);
  
  float xStart = width/2;
  float y = height - gap - numRows*sq3;
  
  balls = new Ball[numBalls];
  balls[0] = new Ball( xStart, height/6, 0, 0, r, color(255));

  int i = 1;
  float diam = 2*r;

  for (int row = 1; row <= numRows; row++) {
    float x = xStart;
    
    for (int col = 1; col <= row; col++) {
      balls[i] = new Ball( x, y, 0, 0, r, billiardColours[i]);
      i++;
      x += diam;
    }
    
    xStart -= r;
    y += sq3;
  }
  
}
