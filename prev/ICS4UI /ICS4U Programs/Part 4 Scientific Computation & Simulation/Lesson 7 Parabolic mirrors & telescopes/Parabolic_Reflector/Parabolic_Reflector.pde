import g4p_controls.*;

float a = 0.05;
float a2 = 2*a, a4 = 4*a;

float xMin = -10.0, xMax = 10.0;
float yMin = 0, yMax = 10.0;

float mirrorCoverage = 0.40;
float xMirrorLeft = xMin*mirrorCoverage;
float xMirrorRight = xMax*mirrorCoverage;

float xBulb = 0;
float yBulb = 5;

float xScreenBulb = getScreenX( xBulb );
float yScreenBulb = getScreenY( yBulb );

float dx = 0.05;
float numBeams = 153;
float dTheta = 2*PI/numBeams;
float mx, my, bx, by;


void setup(){
  createGUI();
  size(1000, 680);
  mx = width/(xMax-xMin);
  bx = -mx*xMin;
  
  my = -height/(yMax-yMin);
  by = -my*yMax;
  noLoop();
}

void resetValues() {
  a = aSlider.getValueI()/10000.0;   //0.0-0.1
  a2 = 2*a;
  a4 = 4*a;
  yBulb = focusSlider.getValueI() / 100.0;
  redraw();
}


void draw(){
  background(0);

  drawBulb();
  drawBeams();
  drawMirror();
}


void drawMirror() {
  stroke(150);
  strokeWeight(6);
  
  float xScreenPrev = getScreenX( xMirrorLeft );
  float yScreenPrev = getScreenY( f(xMirrorLeft) );
  
  for(float xMath = xMirrorLeft+dx; xMath<=xMirrorRight; xMath+=dx) {
    float yMath = f(xMath);
    float xScreen = getScreenX( xMath );
    float yScreen = getScreenY( yMath );
    line(xScreenPrev, yScreenPrev, xScreen, yScreen);
    xScreenPrev = xScreen;
    yScreenPrev = yScreen;
  }
}


void drawBulb() {
  fill(255);
  noStroke();
  
  float xScreen = getScreenX( xBulb );
  float yScreen = getScreenY( yBulb );
  
  circle(xScreen, yScreen, 10);
}


void drawBeams() {
  stroke(200,200,0);
  strokeWeight(2);

  float tanTheta, tanSquared, x0, y0, xScreen0, yScreen0; 
  
  xScreenBulb = getScreenX( xBulb );
  yScreenBulb = getScreenY( yBulb );
  
  for(float theta=0; theta<2*PI; theta+=dTheta) {
    tanTheta = tan(theta);
    tanSquared = pow( tanTheta, 2 );
    
    if (theta < PI) 
      x0 = (tanTheta + sqrt(tanSquared + a4*yBulb))/a2;
       
    else 
      x0 = (tanTheta - sqrt(tanSquared + a4*yBulb))/a2;
        
    if ( xMirrorLeft <= x0 && x0 <= xMirrorRight ) {
      y0 = f(x0);
      xScreen0 = getScreenX( x0 );
      yScreen0 = getScreenY( y0 );
      line( xScreenBulb, yScreenBulb, xScreen0, yScreen0 );
      drawReflectedBeam( tanTheta, x0, y0 );
    }
  }
}


void drawReflectedBeam(float tanTheta, float x0, float y0) {
  float dydx = 2*a*x0;
  float tanAlpha = dydx;
  float tan2Alpha = 2*tanAlpha/(1 - tanAlpha*tanAlpha);
  float tanBeta = (tan2Alpha - tanTheta)/(1 + tan2Alpha*tanTheta);
  float dx = 0.1;

  if( tanBeta < 0) 
    dx = -0.1; 
    
  float x = x0, y = y0;
  float xPrev = x, yPrev = y;
  
  while( x >= xMin && x <= xMax && y >= yMin && y <= yMax ){
    x += dx;
    y = tanBeta*(x-x0)+y0;
    line(getScreenX(xPrev), getScreenY(yPrev), getScreenX(x), getScreenY(y));
    xPrev = x;
    yPrev = y;
  }
}


float getScreenX( float xMath ) {
  return mx*xMath + bx;
}


float getScreenY( float yMath ) {
  return my*yMath + by;
}
  
  
float f(float x) {  //f(x) = ax^2
  return a*x*x;
}
