int n = 10;             //Number of dots
float diameter = 20;
PVector[] dots = new PVector[n];
float r = diameter/2;
boolean someDotHasBeenClicked = false;
PVector selectedDot;
float gap;
float t;
float dt = 0.03;
int j;
String mode = "drag"; //"animate", "drag"

void setup() {
  size(1000, 500);
  rectMode(CENTER);
  frameRate(60);
  noLoop();         //No animation 
  strokeWeight(5);  //Makes lines thicker
  gap = width / n;  //Computes the spacing of the balls
  resetTrack();     //Defined below
  resetCar();       //Defined below
}


void draw() {
  background(0);

  //PRINTS THE INSTRUCTIONS
  fill( 255, 255, 0 );
  textSize(16);
  text( "Drag any dot", 50, 50 );
  text( "Push s to animate the car", 50, 80 );
  text( "Push r to reset", 50, 110 );

  //DRAWS THE GREEN CURVES
  stroke(0, 255, 0);
  noFill();
  PVector d1, d2, d3, d4;

  for (int i = 0; i < dots.length; i++) {  //NOTICE WE DON'T STOP AT length-3 NOW.
    d1 = dots[i];
    d2 = dots[(i+1) % n]; //REMEMEBER WHAT % DOES?
    d3 = dots[(i+2) % n];
    d4 = dots[(i+3) % n];
    curve( d1.x, d1.y, d2.x, d2.y, d3.x, d3.y, d4.x, d4.y );
  }

  //DRAWS THE BLUE DOTS
  fill(0, 200, 255);
  noStroke();

  for ( PVector d : dots )  
    circle( d.x, d.y, diameter );

  float x, y;

  //ANIMATES THE CAR
  if ( mode.equals( "animate" ) ) {
    d1 = dots[j];  //J REPRESENTS WHICH GREEN CURVE THE BOX IS TRAVELING ON
    d2 = dots[(j+1) % n];
    d3 = dots[(j+2) % n];
    d4 = dots[(j+3) % n];
    
    x = curvePoint( d1.x, d2.x, d3.x, d4.x, t );  
    y = curvePoint( d1.y, d2.y, d3.y, d4.y, t );
    
    fill(255,0,0);
    square(x, y, 30); //DRAWS THE "CAR"
    
    t += dt;
    
    if ( t >= 1.0 ) {  //WHAT DOES THIS DO?
      j++;
      t = 0.0;
    }

    if ( j >= n  )
      resetCar();
  }
}


void resetTrack() {
  for ( int i = 0; i < dots.length; i++ ) {
    float xDot = random(30, 70) + i*gap;
    float yDot = height/2 + random(-160, 160);
    dots[i] = new PVector( xDot, yDot );
  }
}


void resetCar() {
  j = 0;
  t = 0.0;
}


void mousePressed() {
  for ( PVector d : dots) {
    if ( dist(d.x, d.y, mouseX, mouseY) < r) {
      someDotHasBeenClicked = true;
      selectedDot = d;
    }
  }
}


void mouseReleased() {
  someDotHasBeenClicked = false;
  selectedDot = null; //no value
}


void mouseDragged() {
  if ( someDotHasBeenClicked == true ) {
    selectedDot.x = mouseX;
    selectedDot.y = mouseY;
    redraw();
  }
}


void keyPressed() {
  if ( key == 'r' || key == 'R') {
    mode = "drag";
    resetTrack();
    resetCar();
    noLoop();
    redraw(); 
  }
  
  else if ( key == 's' || key == 'S' ) {
    mode = "animate";
    resetCar();
    loop();
  }
}
