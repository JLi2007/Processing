/********************************
** PARAMETERS. TRY CHANGING THESE
*********************************/
int n = 120;                    //Number of electrons (Under 2000 recommended)
float electronCharge = 9;     //How strongly the electrons repel (The q1 in Couloumb's Law, F = -k q1 q2/r^2)
//When n is big, make the charge smaller. When n is small, make the charge bigger

float wallCharge = 200;         //How strongly walls repel the electrons
boolean slowMo = false;         //Try changing this to true
boolean showForces = false;     //Try changing this to true
boolean showGridLines = false;  //Recommended only when n < 150 or so

float k = 2;                    //The k in Couloumb's Law
float frictionDecay = 0.98;     //1.0 = no friction. Make this smaller when n is big (over 500) to prevent an initial explosion
float electronDiameter = 15;
float electronMass = 1;          //Inertia of electrons
float L = 300;
String boundaryShape = "ring";  //"square" or "ring"
String initialSetup = "grid";    //"random" or "grid"

/************************
** OTHER GLOBAL VARIABLES
*************************/

PVector[] positions = new PVector[n];
PVector[] velocities = new PVector[n];
PVector[] accelerations = new PVector[n];
float dt = 1.0;  //Delta t, or the amount of time between frames. Used in the formulas v = a*dt and a = v*dt
float pad = 50;

color[] colors = new color[n];

float xWallLeft, xWallRight, yWallTop, yWallBottom;
float boundaryWidth, boundaryRadius;
boolean isSomethingSelected = false;
int electronSelected;
float xC, yC;   //Center of the screen
PVector center;
PFont font;

/************************
** MAIN PROGRAM
*************************/
void setup() {
  size(800, 800);

  if ( slowMo )
    frameRate(10);

  else
    frameRate(60);

  xC = width/2; 
  yC = height/2;
  center = new PVector(xC, yC);
  boundaryWidth = width - 2*pad;
  boundaryRadius = boundaryWidth/2;
  font = createFont("Arial", 20);
  textFont( font );

  xWallLeft = pad;
  xWallRight = width - pad;
  yWallTop = pad;
  yWallBottom = height - pad;

  if ( initialSetup.equals("random") )
    makeRandomPoints();

  else
    makeGridPoints();
}


/*********
** DRAW()
*********/
void draw() {
  background(0);
  noFill();

  drawBoundary();

  //Draws the electrons (and grid lines if desired) in their current positions
  if (showGridLines) drawGridLines();

  for ( int i = 0; i < n; i++ ) {
    fill( colors[i] );
    circle( positions[i].x, positions[i].y, electronDiameter );
  }

  //Resets all accelerations for the current frame
  for ( int i = 0; i < n; i++ )
    accelerations[i].set(0, 0);

  //Calculates forces using Couloub's law
  calculateForcesBetweenElectrons();
  calculateWallForcesOnElectrons();

  //Updates the positions & velocities of the electrons using the forces we just calculated
  for ( int i = 0; i < n; i++ ) {
    velocities[i].add( accelerations[i].mult(dt) ).mult( frictionDecay );
    positions[i].add( velocities[i].mult(dt) );
  }
  
  if (showForces )
    drawForceLines();
  
  fill(255, 0, 0);
  text("Drag any electron", 20, 40);
}
