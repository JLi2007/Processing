float ringSpeed = 4.0;
float numFramesBetweenRingReleases = 3;
String ringShape = "circle"; //"square", "circle"
String sourceMotionMode = "linear"; //"linear", "circular", "wave", "backandforth", "mouse"

//Linear mode parameters
float xStartFraction = 0.1;
float xSpeed = 0.0;
float ySpeed = 0;
float xAcceleration = 0.00;

//Circular, wave or backandforth parameters
float frequency = 0.15;
float amplitude = 60;
float horizontalWaveSpeed = 0.5*ringSpeed;
float xCentre, yCentre;

//Don't change these
Ring[] rings;
int n = 500;
float maxRingSize, xPos, yPos;
int currIndex = 0;
float realTime = 0.0;
float timeSinceLastRingRelease = 0.0;
float xSpeedOrig = xSpeed, ySpeedOrig = ySpeed;


void setup() {
  size(1000, 700);
  rings = new Ring[n];
  xPos = width * xStartFraction;
  yPos = height/2;
  xCentre = width/2;
  yCentre = height/2;
  frameRate(30);
  maxRingSize = width; //sqrt(2)/2
}


void draw() {
  background(255);

  drawSource();
  drawRings();

  if ( timeSinceLastRingRelease > numFramesBetweenRingReleases ) 
    releaseNewRing();

  realTime++;
  timeSinceLastRingRelease++;

  updateSourcePosition();
}
