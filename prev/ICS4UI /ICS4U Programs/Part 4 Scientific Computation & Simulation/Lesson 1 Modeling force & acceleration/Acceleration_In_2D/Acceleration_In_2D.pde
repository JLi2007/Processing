PVector pos, vel, acc, accGrav;
float yGround, radius, diam;

void setup() {
  size(1000, 700);
  yGround = 7*height/8;
  radius = 15;
  diam = 2*radius;
  
  pos = new PVector(100, yGround-radius);
  vel = new PVector(12, -10);
  acc = new PVector(-0.15, 0.30); //wind accel = -0.15, gravity accel = 0.30
}

void draw() {
  //background(0);
  stroke(255,0,0); strokeWeight(5);
  line(0, yGround, width, yGround);
  fill(255,255,0); stroke(0); strokeWeight(1);
  circle(pos.x, pos.y, diam);
  
  if(pos.y <= yGround-radius) {
    pos.add(vel);
    vel.add(acc);
  }
}
