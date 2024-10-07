import g4p_controls.*;

float xMin, xMax, yMin, yMax;
float mx, my, bx, by;
float a, b;
int numRays = 600;
int maxNumRays = 1000;
float raySpeed;
float xBulb = 0, yBulb = 0;
String drawingMode = "particles"; //"particles"

Bulb bulb;
QuadraticCurve e;


void setup(){
  size(600,600);
  createGUI();
  
  xMin = -width/2;  xMax = width/2;
  yMin = -height/2; yMax = height/2;
  
  mx = width/(xMax-xMin);
  bx = -mx*xMin;
  my = -height/(yMax-yMin);
  by = -my*yMax;
  
  a = width/2;  //default values
  b = a;
  
  numRays = 1000;
  raySpeed = 2.0;

  stroke(255);

  e = new QuadraticCurve(a, b);  
  bulb = new Bulb(a/2, 0, raySpeed, numRays);
}


void draw() {
  background(0);
  stroke(255);
  noFill();
  e.drawMe();
  
  bulb.drawObjects();
  bulb.updateObjects();
}
