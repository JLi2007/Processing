//INITIAL VALUES. TRY CHANGING THESE
float G = 0.8;       // Gravitational Constant
float M = 10000.0;   // Mass of the Sun
float m = 1.0;       // Mass of the Mars
float deltaT = 0.1;  // Time increment per frame - Used to set the speed of animation (think of this as translating frames to seconds)

PVector posSun = new PVector( 600, 275);   //Position of the sun
PVector posMars = new PVector( 600, 65);  //Position of the Mars (initially directly above the sun)
PVector velMars = new PVector( 4, 3 );    //Initial velocity of the Mars...try changing this


void setup() {
  background(0);
  size(1000,500);
}


void draw() {
  //DRAWS THE SYSTEM IN ITS CURRENT POSITION
  fill( 255, 255, 0);
  circle( posSun.x, posSun.y, 50 );
  fill( 255, 40, 40);
  circle( posMars.x, posMars.y, 20 );
  
  //UPDATES THE VELCOCITY AND POSITION FOR THE NEXT FRAME
  PVector rad = PVector.sub( posMars, posSun );   //Comment each
  PVector ForceDir = rad.normalize( null );       //of these lines
  
  float rSquared = rad.magSq();              
  float ForceMag = -G * M * m / rSquared;      
  PVector F = PVector.mult( ForceDir, ForceMag );  
  PVector accMars = PVector.div( F, m);
  
  PVector deltaV = PVector.mult( accMars, deltaT );  
  velMars.add( deltaV );
  
  PVector deltaPos = PVector.mult( velMars, deltaT ); 
  posMars.add( deltaPos );
