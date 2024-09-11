//TRY CHANGING THESE
float ballSize = 20;
float stickiness = 0.3;

//OTHER GLOBAL VARIABLES
PVector[] balls; //not committing to the size yet
color[] colors;
PrintWriter pw; //used for writing the (x, y) values you draw to a file
boolean mouseDown = false, mouseReleased = false;
int numPoints = 0;
String mode = "dragging";  //"dragging", "animating"


//MAIN PROGRAM
void setup() {
  size(900,700);
  background(0);
  noStroke();
  noLoop();
}


void draw() {
  if( mouseReleased && mode.equals("animating") ) { //So that we only do these steps after the user finishes drawing with the mouse
    background(0);
    
    //Draws the balls in their current positions
    for( int i = 0; i < numPoints; i++ ) {
      fill( colors[i] ); 
      circle( balls[i].x, balls[i].y, ballSize );
    }
    
    //Moves the leader ball in the direction of the mouse with a certain "stickiness"
    balls[0].x += (mouseX - balls[0].x) * stickiness;   //(mouseX - balls[0].x) is the x-speed at which the leader ball chases the mouse
    balls[0].y += (mouseY - balls[0].y) * stickiness;   //(mouseY - balls[0].y) is the y-speed
      
    //Moves each non-leader ball (numbered as i) in the direction of the ball ahead of it (i-1)
    for(int i = 1; i < numPoints; i++) { //Why does i start at 1 and not 0?
      balls[i].x += (balls[i-1].x - balls[i].x) * stickiness;
      balls[i].y += (balls[i-1].y - balls[i].y) * stickiness;
    }
  }
 
  //Switching to chase mode
  if( mouseReleased ) {
    int n = max(0, 10000-frameCount);
   // saveFrame( "movie frames/" + n + ".png");
  }
}


void mousePressed() { //The user is just now starting to draw a shape
  background(0);  //Clears the screen for a fresh start
  mouseReleased = false;
  mode = "dragging";  //So that the draw() procedure won't start animating yet
  pw = createWriter("Your points.txt");  //Starts a new file to record the (x,y) points about to be drawn
}


void mouseDragged(){  //The user is drawing white balls across the screen
  if ( !mouseReleased ) {
     fill(255);
     circle(mouseX, mouseY, ballSize);   //Draws a white ball wherever the mouse is
     pw.println(mouseX + "," + mouseY);  //Writes the current mouse position into the file
     loop();
  }
}


void mouseReleased() { //The user is finished drawing and is ready to watch the animation
  if ( !mouseReleased ) {  //If we didn't just release the mouse already
    pw.close(); //Closes the file of (x,y) points...that is, stop recording points
    
    String[] lines = loadStrings( "Your points.txt" );  //Reads the file of points that was just recorded into this array
    numPoints = lines.length;
    
    balls = new PVector[ numPoints ];  //Allocates space for the PVectors array based on the number of (x,y) points in the file
    colors = new color[ numPoints ];
    
    //Makes random colours for the leading and trailing balls
    float red = random(0,255);  
    float green = random(0,255);
    float blue = random(0,255);
    
    color startColor = color(red, green, blue);
    color endColor = color(255-red, 255-green, 255-blue);
    
    //Fills the "balls" array using data from the file, and fills the "colours" array using the leading and trailing colours
    for (int i=0; i < numPoints; i++ ) {
      int j = numPoints - 1 - i; //So that we read in the (x,y) points in reverse order, making the last ball drawn the first in the chain
      String[] xyVals = lines[j].split(",");
      
      int xBall = int( xyVals[0] );
      int yBall = int( xyVals[1] );
      
      balls[i] = new PVector(xBall, yBall);
      colors[i] = lerpColor(startColor, endColor, float(i)/numPoints);  //Look up what lerpColor does :-)
    }
  
    mouseReleased = true;
    if( numPoints > 0 ) mode = "animating";  //The balls are ready to move now, so we switch to animating mode
  }
}
