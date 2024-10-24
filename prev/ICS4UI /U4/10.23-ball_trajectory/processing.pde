PVector posWithAR, posWithoutAR; //positions of the ball with and without air resistance
PVector velWithAR, velWithoutAR; //velocities of the ball with and without air resistance
PVector velInit = new PVector(10, -15);
PVector acc, accGrav;
float yGround, radius, diam;
float rho = 0.003;

void setup() {
  size(1000, 700);

  yGround = 7*height/8;
  radius = 15;
  diam = 2*radius;

  posWithoutAR = new PVector(50, yGround-radius); //initial position is on the ground
  posWithAR = new PVector(50, yGround-radius); 
  
  velWithoutAR = new PVector(velInit.x, velInit.y); //initial launch velocity
  velWithAR = new PVector(velInit.x, velInit.y);    //initial launch velocity
  
  accGrav = new PVector(0, 0.3); //gravity has 0 horizontal component, but a positive downward component
}

void draw() {
  //DRAWS THE GROUND
  stroke(255, 0, 0); 
  strokeWeight(5);
  line(0, yGround, width, yGround);

  //DRAWS THE BALLS IN THEIR CURRENT POSITIONS
  stroke(0); strokeWeight(1);
  fill(255, 255, 0); 
  circle(posWithoutAR.x, posWithoutAR.y, diam);
  fill(0, 255, 255); 
  circle(posWithAR.x, posWithAR.y, diam);

  //UPDATES THE POSITION, VELOCITY & ACCELERATION OF THE BALL WITHOUT AIR RESISTANCE
  if (posWithoutAR.y <= yGround-radius) {
    posWithoutAR.add( velWithoutAR );
    velWithoutAR.add( accGrav );
  }  

  //UPDATES THE POSITION, VELOCITY & ACCELERATION OF THE BALL WITH AIR RESISTANCE
  if (posWithAR.y <= yGround-radius) {
    posWithAR.add( velWithAR );

    //COMPUTES ACCELERATION USING THE AIR RESISTANCE FORMULA a = rho * speed^2
    PVector ballDirection = velWithAR.normalize(null);  //Unit vector in the direction of the velocity
    PVector airResDir = ballDirection.mult(-1);         //The direction of air resistance is opposite the velocity
    float airResMag = rho * pow(velWithAR.mag(), 2);    //The magnitude of the air resistance computed from the formula
    PVector airResAcc = PVector.mult( airResDir, airResMag );  //Air resistance acceleration vector
    acc = PVector.add(accGrav, airResAcc);        //Total accerlation on the ball = gravity + air resistance

    velWithAR.add(acc);
  }
  println(velWithoutAR, velWithAR);
}
