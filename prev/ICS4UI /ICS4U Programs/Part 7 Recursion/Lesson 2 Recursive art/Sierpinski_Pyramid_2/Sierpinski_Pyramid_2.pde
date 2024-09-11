/***************************************************************************************************************
THIS PROGRAM DRAWS A 3-D SIERPINSKI PYRAMID FRACTAL TO ANY DESIRED LEVEL OF RECURSION, AND THEN TAKES THE VIEWER
ON A 3D "RIDE" THROUGH THE PYRAMID. WHEEEEE!

IN 3D SCREEN COORDINATES, x POINTS RIGHT, y POINTS DOWN, z POINTS INTO THE VIEWER'S FACE (ow!) 

PROGRAMMED BY JASON SCHATTMAN 2021

/**********************************
USER CONTROLS - TRY CHANGING THESE!
***********************************/
int level = 7;                     //HOW MANY LEVELS OF RECURSION THE SIERPINSKI PYRAMID GETS DRAWN TO.  TRY 1-6 TO SEE WHAT THEY DO

float distanceFactor = 1;        //HOW FAR AWAY THE CAMERA STARTS FROM THE CENTER OF THE PYRAMID (as a multiple of the length of the pyramid's base)
float boxSizeFactor = 1.4;         //HOW BIG THE BOXES ARE

float theta = radians( 89.9 );       //INITIAL EAST-WEST VIEWING ANGLE
float phi = radians( 112 );         //INITIAL NORTH-SOUTH VIEWING ANGLE. //0 DEG = LOOKING DOWN FROM ABOVE. 90 DEG = LOOKING THROUGH IT LEVEL WITH THE BASE

float rotationSpeedWest = 0;       //HOW FAST OUR VIEWING ANGLE (theta) CHANGES EAST-TO-WEST AS WE FLY.  0-100 RECOMMENDED.
float rotationSpeedSouth = 0;      //HOW FAST OUR VIEWING ANGLE (phi) CHANGES NORTH-TO-SOUTH AS WE FLY.  0-50 RECOMMENDED.
float flyingSpeed = 1.5;           //HOW FAST WE FLY TOWARDS (AND THROUGH) THE PYRAMID. SET TO 0 TO JUST SEE THE PYRAMID SPIN IN FRONT OF US (but set the rotation speeds way higher)

int waitTimeBeforeZoom = 120;       //HOW MANY FRAMES WE WAIT BEFORE WE START TO MOVE. 90 FRAMES = 2 SECONDS

color boxCol = color(150);
boolean save = false;             //CHANGE TO "true" TO MAKE A MOVIE OF THE ANIMATION
boolean animate = true;

int weight = 1;                   //THICKNESS OF THE LINES.  1 OR 2 RECOMMENDED



/******************************************
OTHER GLOBAL VARIABLES - DON'T CHANGE THESE
*******************************************/
float sideLength;
float altitude;
float pyramidHeight;
float yBase;                 //y-VALUE OF THE BASE OF THE PYRAMID (y is "up")        
float zBack, zFront;                 //z-VALUE OF THE BACK WALL OF THE PYRAMID (the wall farthest away from the viewer at the start)

float xC, yC, zC;            //THE CENTER OF THE PYRAMID.  THE CAMERA WILL ALWAYS LOOK TOWARDS THIS POINT AS IT MOVES.
float xEye, yEye, zEye;      //THE LOCATION OF THE CAMERA. CHANGING THESE 3 VALUES OVER TIME IS WHAT CREATES THE FLY-THROUGH EFFECT

float cameraRadius;          //DISTANCE BETWEEN THE CAMERA AND THE CENTER OF THE PYRAMID
float boxSize;
float deltaTheta = rotationSpeedWest / 10000;
float deltaPhi = rotationSpeedSouth / 10000;
float pad = 150;


/***********
MAIN PROGRAM
************/
void setup() {
  size( 1600, 1000, P3D );  //USE P3D TO DRAW IN 3D
  strokeWeight(weight);
  
  if (!animate) 
    noLoop();
  
  sideLength = width;
  altitude = sideLength * sqrt(3) / 2;
  pyramidHeight = sideLength * sqrt(2.0/3);                   //CAN YOU WORK OUT ON PAPER WHERE THIS FORMULA COMES FROM?
  yBase = pyramidHeight + pad;
  zBack = -700;
  zFront = zBack + altitude;
  boxSize = boxSizeFactor * sideLength / pow(2, level+3);  //BOXES SHOULD SHRINK AS THE RECURSION LEVEL INCREASES, TO REDUCE CLUTTER
  
  //THE CENTER OF THE PYRAMID'S BASE (this is the point that the camera always point at while we fly)
  xC = width/2;
  yC = yBase - pyramidHeight/2 + 50;
  zC = zBack + sideLength / sqrt(3);
  
  cameraRadius = altitude * distanceFactor;
}


void draw() {
  if( frameCount < 3000 ) {
    background(0);
    float zSpeed, thetaSpeed, phiSpeed;
    
    if( frameCount < waitTimeBeforeZoom ) {
      zSpeed = 0;
      thetaSpeed = 0;
      phiSpeed = 0; 
    }
    
    else {
      zSpeed = flyingSpeed;
      thetaSpeed = deltaTheta;
      phiSpeed = deltaPhi;
    }
    
    /*
    CALCULATES THE POSITION OF THE CAMERA USING THE 2 VIEWING ANGLES (theta and phi), THE CAMERA'S RADIUS, AND THE CENTER OF THE PYRAMID.
    THESE ARE THE CLASSIC FORMULAS FOR "SPHERICAL COORDINATES", WHICH YOU'LL LEARN ABOUT IF YOU STUDY MULTIVARIABLE CALCULUS.
    THEY'RE USED FOR CALCULATING THE (x, y, z) COORDINATES OF A POINT WHOSE TWO ANGLES AND RADIUS FROM A CENTRAL POINT (xC, yC, zC) ARE KNOWN. */
    xEye = xC + cameraRadius * cos(theta) * sin(phi);
    yEye = yC - cameraRadius * cos(phi);
    zEye = zC + cameraRadius * sin(theta) * sin(phi) - zSpeed * (frameCount - waitTimeBeforeZoom);
    
    directionalLight( 128, 128, 128, 1, 0, -1 );      //LIGHT WITH GREY-SCALE INTENSITY 128 WILL SHINE FROM *THE RIGHT* (the 1) AND FROM *THE BACK* (the -1)
    ambientLight( 140, 140, 140 );                    //IN ADDITION TO THE DIRECTIONAL LIGHT, WE'LL ALSO GET GENERAL "AMBIENT LIGHT" WITH INTENSITY 140
  
    camera( xEye, yEye, zEye, xC, yC, zC, 0, 1, 0 );  //PLACING THE CAMERA AT (xEye, yEye, zEye) AND POINTING TOWARDS (xC, yC, zC), WITH THE Y-AXIS POINTING UP
    
    //THE 5 VERTICES THAT WILL BE USED TO FORM THE MAIN PYRAMID  
    Point3D a = new Point3D( 0, yBase, zFront );
    Point3D b = new Point3D( width/2, yBase, zBack);
    Point3D c = new Point3D( width, yBase, zFront );
    Point3D d = new Point3D( width/2, yBase - pyramidHeight, zBack + sideLength/sqrt(3) );    
    
    //DRAWS THE SIERPINSKI PYRAMID RECURSIVELY TO THE GIVEN LEVEL USING THE 5 POINTS ABOVE AS THE STARTING PYRAMID
    drawSierpinskiPyramid( level, a, b, c, d, color(255) );  
    
    //UPDATES THE TWO VIEWING ANGLES
    theta += thetaSpeed;  //east-west angle
    phi += phiSpeed;      //north-south angle
    
    //deltaTheta *= 0.997;
    //deltaPhi *= 0.998;
    
    if(save)
      saveFrame("frames/#####.jpg");
  }
  
  else
    exit();
}


void drawSierpinskiPyramid( int level, Point3D a, Point3D b, Point3D c, Point3D d, color col ) {
 
  if (level == 1)  //BASE CASE
    pyramid( a, b, c, d, col );   //DRAWS A SINGLE SQUARE-BASED PYRAMID WITH VERTICES a, b, c, d, e AND COLOUR col
 
  else {           //RECURSIVE CASE
    /* 
    CALCULATES 9 MIDPOINTS ON THE CURRENT PYRAMID: 
    4 FOR THE SIDES OF THE SQUARE BASE + 4 FOR THE LINES CONNECTING THE PEAK TO THE BASE + 1 FOR THE CENTER OF THE BASE  */
    
    Point3D mab = midpoint( a, b );
    Point3D mbc = midpoint( b, c );
    Point3D mac = midpoint( c, a );
    Point3D mad = midpoint( d, a );
    Point3D mbd = midpoint( d, b );
    Point3D mcd = midpoint( d, c );

    /* 
    USING THE 9 MIDPOINTS ABOVE, DRAWS 5 NEW SIERPINSKI PYRAMIDS RECURSIVELY INSIDE THE CURRENT ONE. 
    NOTE THAT THE LEVEL GOES DOWN BY 1 IN EACH RECURSIVE CALL, SO THAT WE ALWAYS GET CLOSER TO THE BASE CASE. */
    
    drawSierpinskiPyramid( level-1, a, mab, mac, mad, color(255,   0, 255) );   //Filling the lower north-west corner with a new pyramid
    drawSierpinskiPyramid( level-1, mab, b, mbc, mbd, color(255,   255,   255) );   //Filling the lower north-east corner with a new pyramid
    drawSierpinskiPyramid( level-1, mac, mbc, c, mcd, color(0,   255, 255)  ); //Filling the lower south-east corner with a new pyramid
    drawSierpinskiPyramid( level-1, mad, mbd, mcd, d, color(255, 255,   0) );       //Filling the upper half with a new pyramid
  }
}


//DRAWS A SINGLE 5-POINT PYRAMID WHOSE SQUARE BASE IS THE POINTS (a, b, c, d) AND WHOSE PEAK IS POINT e
void pyramid( Point3D a, Point3D b, Point3D c, Point3D d, color col ) {
  stroke(col);
  
  //DRAWS THE  BASE
  line3D( a, b );
  line3D( b, c );
  line3D( c, a );
  
  //DRAWS THE 3 LINES CONNECTING THE BASE TO THE PEAK d
  line3D( a, d );
  line3D( b, d );
  line3D( c, d );
  
  //DRAWS A SMALL BOX AROUND EACH OF THE FIVE POINTS
  fill( boxCol );
  noStroke();
  a.drawBox();
  b.drawBox();
  c.drawBox();
  d.drawBox();
}


//CALCULATES THE MIDPOINT BETWEEN POINTS p AND q
Point3D midpoint( Point3D p, Point3D q ) {
  return new Point3D( (p.x + q.x) / 2, (p.y + q.y) / 2, (p.z + q.z) / 2);
}


//DRAWS A LINE BETWEEN POINTS p AND q
void line3D( Point3D p, Point3D q ) {
  line( p.x, p.y, p.z, q.x, q.y, q.z );
}
