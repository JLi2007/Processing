int n = 4;             //Number of dots
float diameter = 30;
PVector[] dots = new PVector[n];
float r = diameter/2;
boolean someDotHasBeenClicked = false;
PVector selectedDot;
float gap;


void setup(){
  size(1000,500);
  noLoop();         //No animation 
  strokeWeight(5);  //Makes lines thicker
  gap = width / n;  //Computes the spacing of the balls
  reset();          //Defined below
}


void draw() {
  background(0);
  
  //PRINTS THE RED INSTRUCTIONS
  fill( 255, 0, 0 );
  textSize(16);
  text( "Drag any dot", 50, 50 );
  text( "Push r to reset", 50, 80 );
  
  //DRAWS THE GREEN CURVES
  noFill();
  stroke(0, 255, 0);
  PVector d1, d2, d3, d4;
  
  d1 = dots[0];
  d2 = dots[1];
  d3 = dots[2];
  d4 = dots[3];
  curve( d1.x, d1.y, d2.x, d2.y, d3.x, d3.y, d4.x, d4.y );  
      
  //DRAWS THE BLUE DOTS
  fill(0,200,255);
  noStroke();
  
  for( PVector d: dots )  //
    circle( d.x, d.y, diameter );
}


void reset() {
  for( int i = 0; i < dots.length; i++ ) {
    float xDot = 50 + i*gap;
    dots[i] = new PVector( xDot, height/2 );
  } 
}


void mousePressed() {
  for( PVector d: dots) {
    if( dist(d.x, d.y, mouseX, mouseY) < r) {
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
  if( someDotHasBeenClicked == true ) {
    selectedDot.x = mouseX;
    selectedDot.y = mouseY;
    redraw();  //Calls draw() once more
  }
}


void keyPressed() {
  if( key == 'r' || key == 'R') {
    reset();
    redraw();  //Calls draw() again manually
  }
}
