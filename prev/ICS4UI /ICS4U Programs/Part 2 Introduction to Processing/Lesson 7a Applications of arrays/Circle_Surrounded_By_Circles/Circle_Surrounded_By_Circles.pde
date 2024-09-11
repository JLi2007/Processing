int n = 9;
float R = 100;
float rotationSpeed = 0.005; 

float startAngle = 0;
float rMax, r, s, deltaTheta;
color[] myCol;


void setup() {
  background(0);
  noStroke();
  size(700, 700);
  reset();
}


void reset() {
  myCol = new color[n];

  deltaTheta = TWO_PI/n;
  s = sin(PI/n);
  //R = 0.5*width*(1-s)/(1+s);
  rMax = R*s/(1-s);
  print(R, rMax);

  for (int i=0; i < n; i++) {
    myCol[i] = color( random(80, 255), random(80, 255), random(80, 255) );
  }

  r = 2;
}


void draw() {
  background(0);
  fill(240, 120, 0);
  circle(width/2, height/2, 2*R);
  float x, y, currAngle;
  
  currAngle = startAngle;

  for (int i=0; i < myCol.length; i++) {
    fill( myCol[i] );
    currAngle += deltaTheta;
    x = width/2 + (R+r)*cos(currAngle);
    y = height/2 - (R+r)*sin(currAngle);

    circle(x, y, 2*r);
  }

  startAngle += rotationSpeed;

  if ( r < rMax ) {
    r += 2.5/n;
  }
}
