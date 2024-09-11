int n = 12;   //Number of control points
float diameter = 15;

PVector[] dots = new PVector[n];
PImage carImg;
float r = diameter/2;
boolean someDotHasBeenClicked = false;
PVector selectedDot;
float gap;
float t;
float dt;
int dotNum;
String mode = "drag"; //"animate", "drag"
float[] curveLengths;

void setup() {
  size(1000, 600);
  rectMode(CENTER);
  imageMode(CENTER);
  frameRate(30);
  carImg = loadImage("car.png");
  carImg.resize(50, 0);

  noLoop();         //No animation 
  strokeWeight(30);  //Makes lines thicker
  gap = width / n;  //Computes the spacing of the balls
  curveLengths = new float[n];
  resetTrack();     //Defined below
  resetCar();       //Defined below
}


void draw() {
  background(0);

  //PRINTS THE INSTRUCTIONS
  fill( 255, 255, 0 );
  textSize(16);
  text( "Drag any dot", 25, 50 );
  text( "Push s to animate the car", 25, 80 );
  text( "Push r to reset", 25, 110 );

  //DRAWS THE ROAD
  stroke(255);
  noFill();
  PVector d1, d2, d3, d4;

  for (int i = 0; i < dots.length; i++) {
    d1 = dots[i];
    d2 = dots[(i+1) % n];
    d3 = dots[(i+2) % n];
    d4 = dots[(i+3) % n];
    curve( d1.x, d1.y, d2.x, d2.y, d3.x, d3.y, d4.x, d4.y );
  }

  //DRAWS THE CONTROL POINTS
  fill(0, 200, 255);
  noStroke();

  for ( PVector d : dots )  
    circle( d.x, d.y, diameter );

  float x, y, dxdt, dydt, angle;

  //ANIMATES THE CAR
  if ( mode.equals( "animate" ) ) {
    d1 = dots[ dotNum ];
    d2 = dots[( dotNum + 1 ) % n];
    d3 = dots[( dotNum + 2 ) % n];
    d4 = dots[( dotNum + 3 ) % n];

    x = curvePoint( d1.x, d2.x, d3.x, d4.x, t );  
    y = curvePoint( d1.y, d2.y, d3.y, d4.y, t );

    dxdt = getDerivative( d1.x, d2.x, d3.x, d4.x, t );
    dydt = getDerivative( d1.y, d2.y, d3.y, d4.y, t );

    angle = atan2(dydt, dxdt);

    drawCar(x, y, angle);

    dt = 10/curveLengths[dotNum];
    t += dt;  // t = t + dt

    if ( t >= 1.0 ) {
      dotNum++;
      t = 0.0;
    }

    if ( dotNum >= n  )
      resetCar();
  }
}
