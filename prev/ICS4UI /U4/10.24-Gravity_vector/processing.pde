//INITIAL VALUES. TRY CHANGING THESE
float G = 0.8;       // Gravitational Constant
float M = 10000.0;   // Mass of the Sun
float m = 1.0;       // Mass of the Mars
float deltaT = 0.1;  // Time increment per frame - Used to set the speed of animation (think of this as translating frames to seconds)

PVector posSun = new PVector( 600, 275);   //Position of the sun
PVector posMars = new PVector( 600, 65);  //Position of the Mars (initially directly above the sun)
PVector velMars = new PVector( 5, 3 );    //Initial velocity of the Mars...try changing this


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
  PVector rad = PVector.sub( posMars, posSun );       //finding distance between mars and sun (vector substraction)
  PVector ForceDir = rad.normalize( null );           //normalize the vector into a unit vector (THE DIRECTION BETWEEN THEM). NULL = create new PVector
  
  float rSquared = rad.magSq();                       //the length of rad squared
  float ForceMag = -G * M * m / rSquared;             //force of gravity equation
  PVector F = PVector.mult( ForceDir, ForceMag );     //multiply force DIRECTION and force MAGNITUDE to obtain F
  PVector accMars = PVector.div( F, m );              //divide F and m to get mars acceleration. (F=ma)
  
  PVector deltaV = PVector.mult( accMars, deltaT );   //multiply the mars acceleration and time increment (0.1 sec per frame)
  velMars.add( deltaV );                              //add acceleration to velocity
  
  PVector deltaPos = PVector.mult( velMars, deltaT ); //multiply the mars velovity and time increment (0.1 sec per frame)
  posMars.add( deltaPos );                            //add velocity to position
}