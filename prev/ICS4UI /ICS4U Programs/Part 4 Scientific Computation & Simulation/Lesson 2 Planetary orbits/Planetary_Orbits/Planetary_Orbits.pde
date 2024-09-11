//INITIAL VALUES. TRY CHANGING THESE
float G = 0.8;       // Gravitational constant
float M = 10000.0;   // Mass of the sun
float m = 1.0;       // Mass of the Mars
float deltaT = 0.1;  // Time increment per frame (must be small for the approximation of the orbit to be accurate)

PVector posSun = new PVector( 600, 275);   //Position of the sun
PVector posMars = new PVector( 600, 65);  //Position of the Mars (initially directly above the sun)
PVector velMars = new PVector( 4, 3 );    //Initial velocity of the Mars...try changing this


void setup() {
  background(0);
  size(1000,500);
  frameRate(240);
}


void draw() {
  //DRAWS THE SYSTEM IN ITS CURRENT POSITION
  fill( 255, 255, 0);
  circle( posSun.x, posSun.y, 50 );
  fill( 255, 40, 40);
  circle( posMars.x, posMars.y, 20 );
  
  //UPDATES THE VELCOCITY AND POSITION FOR THE NEXT FRAME
  PVector r = PVector.sub( posMars, posSun );   // Radius vector r = posMars - posSun
  PVector Fdir = r.normalize( null );           // Unit vector in the direction of the force. (The "null" means create a new vector without changing the original value of r)
  
  float rSquared = r.magSq();              // Squared distance between the sun and Mars rSquared = r^2
  float Fmag = -G * M * m / rSquared;      // Magnitude of the force via Newton's law of gravitation (negative because the force is attracting, not repelling)
  PVector F = PVector.mult( Fdir, Fmag );  // Force vector with direction Fdir and magnitude Fmag
  PVector accMars = PVector.div( F, m );   // a = F / m
  
  PVector deltaV = PVector.mult( accMars, deltaT );  // Change in velocity during the current time interval dV = a * dt
  velMars.add( deltaV );                             // Incrementing v by that change:  v = v + dv
  
  PVector deltaPos = PVector.mult( velMars, deltaT );  // Change in position during the current time interval dPos = v * dt
  posMars.add( deltaPos );                             // Incrementing pos by that change:  pos = pos + dPos
}
