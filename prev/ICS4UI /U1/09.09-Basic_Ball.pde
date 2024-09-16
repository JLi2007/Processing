//GLOBAL VARIABLES
float xBall = 100, yBall;
float xSpeed, ySpeed;

//SETUP() GETS CALLED ONCE AS SOON AS THE PROGRAM STARTS
void setup(){
  size(800,600);

  yBall = height/4;   //Here, height is automatically set to 600/4
}


//DRAW() GETS CALLED 30 TIMES PER SECOND AFTER SETUP() FINISHES 
void draw(){
  background(0,0,0);
  
  fill(0,0,255);
  stroke(255,255,0);
  
  xSpeed = 0.005*(xBall);
  //ySpeed = 0.1*(mouseY-yBall);
  
  circle(xBall, yBall, 80);
  
  xBall = xBall + xSpeed;
  yBall = yBall + ySpeed;
}
