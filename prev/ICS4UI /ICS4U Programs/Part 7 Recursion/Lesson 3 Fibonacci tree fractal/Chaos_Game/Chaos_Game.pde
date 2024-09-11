float dotSize = 15;
int numPoints = 6000;
float speed = 1;
boolean showLines = true;
boolean fixedVertex = false;
boolean showSierpinskiOutline = false;
int sierpinskiLevel = 6;

PVector[] V = new PVector[3];
float s;
float h;
float pad = 50;
PVector randPoint; 
boolean paused = false;


void setup() {
  size(700, 700);
  background(255);
  frameRate(speed);
  noStroke();
  rectMode(CENTER);
  
  //CORNERS 
  s = width - 100;
  h = s * sqrt(3)/2;
  V[0] = new PVector(width/2, pad);
  V[1] = new PVector(pad, pad + h);
  V[2] = new PVector(width-pad, pad + h);
  
  if(showSierpinskiOutline) drawSierpinskiTriangle(sierpinskiLevel, V[0], V[1], V[2]);
  
  //PICKING A FIRST RANDOM POINT
  float p1 = random(0, 1);
  float p2 = random(0, 1);
  float a = min(p1, p2);
  float b = abs(p2-p1);
  float c = 1 - a - b;
 
  randPoint = new PVector( a*V[0].x + b*V[1].x + c*V[2].x, 
                           a*V[0].y + b*V[1].y + c*V[2].y );
  
  randPoint = getBoundaryPoint(0.2);
}


void draw() { 
  
  if (frameCount > numPoints)
    noLoop();
    
  //DRAW THE CORNERS
  fill(0, 0, 0); 
  for( PVector p : V ) {
    square(p.x, p.y, 25);
  }

  //DRAW THE RANDOM POINT
  fill(255, 0, 0); 
  circle(randPoint.x, randPoint.y, dotSize);
  
  //CHOOSE A RANDOM CORNER
  int rand = int( random(0, 3) );
  if(fixedVertex) rand = 1;
  PVector randCorner = V[rand];
  
  //DRAW THE RANDOM CORNER AND LINE
  fill(255, 0 , 255);
  square( randCorner.x, randCorner.y, 25);
  stroke(120, 120, 120, 50);
  if(showLines) line(randPoint.x, randPoint.y, randCorner.x, randCorner.y);
  noStroke();
  
  //FIND MIDPOINT BETWEEN THE RANDOM POINT AND THE RANDOM CORNER
  PVector mid = midpoint(randPoint, randCorner);
  fill(0,255,0);
  circle(mid.x, mid.y, dotSize);
  
  //SET THAT MIDPOINT AS THE NEXT "RANDOM" POINT
  randPoint = mid;
}
