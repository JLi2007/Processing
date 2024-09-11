import g4p_controls.*;

//DECLARING THE OBJECTS
Shape generatorShape; 
Marker myMarker = new Marker( color(120, 0, 255) ) ;  //Purple marker
ArrayList<Dot> dots;
Dot[] edgedots;
float tolerance = 10;

//OTHER GLOBAL VARIABLES
float wheelRotationalFreq;
int numEdgedots = 8;
PVector center;
boolean paused = false;
boolean mouseDown = false;
boolean showShape = true;
float t = 0;
float wheelRadius;
int wheelDirection = 1;
float diameter;
float xC, yC;


//MAIN PROCEDURE
void setup() {
  size(500, 500);
  background(0);
  noStroke();

  createGUI();
  getControllerValues();  //Reads all values from the slider bars

  xC = width/2;
  yC = height/2;

  center = new PVector(xC, yC);
  wheelRadius = width/2.05;
  diameter = 2 * wheelRadius;

  dots = new ArrayList<Dot>();
  edgedots = new Dot[10];
  createEdgedots();
}


//DRAWING PROCEDURE
void draw() {
  if (paused == false) {

    //Draws the main wheel
    background(0);
    fill(255);
    noStroke();
    circle( xC, yC, diameter );
    
    //Draws the generator shape (pretzel, figure 8, square, etc.)
    if ( showShape )
      generatorShape.drawMe();


    //Draws the curve created so far, then rotates every dot on that curve in prep for the next frame 
    fill( myMarker.colour );
    stroke( myMarker.colour );
    strokeWeight( myMarker.strokeSize );

    int n = dots.size();

    if (generatorShape.type.equals("mouse")) {
      for ( Dot d : dots ) 
        d.drawMe();
    } 
    
    else {

      if (n >= 4) {   
        for (int i = 0; i < dots.size()-3; i++ ) {
          Dot dA = dots.get(i);
          Dot dB = dots.get(i+1);
          Dot dC = dots.get(i+2);
          Dot dD = dots.get(i+3);

          if ( dB.onScreen &&  dC.onScreen )  
            curve( dA.location.x, dA.location.y, dB.location.x, dB.location.y, dC.location.x, dC.location.y, dD.location.x, dD.location.y );
          }
        }
      }
    

    for ( Dot d : dots ) 
      d.rotate( wheelRotationalFreq * wheelDirection );  


    //Draws and rotates the edge dots along the edge of the wheel
    for ( int i = 0; i < numEdgedots; i++ ) {
      edgedots[i].drawMe();
      edgedots[i].rotate( wheelRotationalFreq * wheelDirection );
    }

    //Moves the marker
    myMarker.updatePosition(); 

    //Creates a new dot where the marker currently is and adds it to the list of dots to be drawn next frame
    Dot newDot;

    if ( !generatorShape.type.equals("mouse")  ) {  
      newDot = new Dot( myMarker.pos, center, myMarker.colour, 5); 
      dots.add( newDot );
    }

    //Draws the marker
    myMarker.drawMe();

    t += 1; //INCREMENTS THE GLOBAL TIMER
  }
}
