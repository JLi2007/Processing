PVector posCue, posRed; //Positions of the cue ball and red ball
PVector v, w;           //Velocities of the cue ball and red ball
float radius, diam;

void setup() {
  size(700, 700);
  background(0,155,0);
  
  posCue = new PVector(50, 360);  //Starting positions of the balls
  posRed = new PVector(400, 330);
  radius = 30;
  diam = 2*radius;
  
  v = new PVector(7, 0);          //Starting velocities of the balls
  w = new PVector(0, 0);
}

void draw() {
  background(0,155,0);
  
  //DRAW THE BALLS IN THEIR CURRENT POSITIONS
  fill(255);
  circle(posCue.x, posCue.y, diam);
  fill(255,0,0);
  circle(posRed.x, posRed.y, diam);
  
  //UPDATE THEIR POSITIONS USING THEIR CURRENT VELOCITIES
  posCue.add(v);
  posRed.add(w);
  
  //DETERMINE IF THEY'VE COLLIDED, AND IF THEY HAVE, UPDATE THEIR VELOCITIES USING THE LAWS OF PHYSICS
  PVector S = new PVector(posRed.x-posCue.x, posRed.y-posCue.y); //Vector spanning between posCue and posRed
  
  if( S.mag() <= diam ) { //If the dist between the balls < sum of their radii:
    PVector sHat = S.normalize(null);
    
    float k = v.dot(sHat) - w.dot(sHat);
    
    //Step 3: Compute the vectors deltaV and deltaW 
    PVector deltaV = PVector.mult(sHat,k);
      
    //Step 4: Add deltaV to v, and deltaW to w
    v.sub(deltaV);
    w.add(deltaW);
  }
}
