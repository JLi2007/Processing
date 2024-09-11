int n = 8;    //Number of dots - Try changing this
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
  
  //PRINTS THE YELLOW INSTRUCTIONS
  fill( 255, 255, 0 );
  textSize(18);
  text( "Drag any dot", 50, 50 );
  text( "Push r to reset", 50, 80 );
  
  //DRAWS THE 2 ORANGE LINES
  noFill();
  stroke( 255, 150, 0 );
  line( dots[0].x, dots[0].y, dots[1].x, dots[1].y ); 
  line( dots[n-2].x, dots[n-2].y, dots[n-1].x, dots[n-1].y ); 

  //DRAWS THE GREEN CURVES
  stroke(0, 255, 0);
  PVector d1, d2, d3, d4;
  
  for(int i = 0; i < dots.length-3; i++) {
    d1 = dots[i];
    d2 = dots[i+1];
    d3 = dots[i+2];
    d4 = dots[i+3];
    curve( d1.x, d1.y, d2.x, d2.y, d3.x, d3.y, d4.x, d4.y );  //Look up on processing.org/reference what the curve() command does
  }
      
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
