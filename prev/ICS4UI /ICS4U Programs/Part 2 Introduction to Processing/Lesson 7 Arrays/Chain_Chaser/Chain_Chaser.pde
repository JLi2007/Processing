//PARAMETERS. TRY CHANGING THESE
int n = 100;
float ballSize = 20;
float k = 0.35; //the "stickiness" of the chain
String leaderFollows = "mouse"; //"mouse", "spiral", "end", "wave", "line"

//DON'T CHANGE THESE
PVector[] balls;
float xC, yC;
float time = 0.0;
int t = 0;
float r = 275;
float xLineSpeed = 25;
float yLineSpeed = 10;
float xCurrSpeed = xLineSpeed;
float yCurrSpeed = -yLineSpeed;


void setup(){
  size(1200,600);
  background(0);
  xC = width/2;
  yC = height/2;
  balls = new PVector[n];
  
  //starts all balls at the left-middle of the screen
  for(int i = 0; i < n; i++){
    balls[i] = new PVector(300, 450);
  }
}

void draw() {
  background(0);
  fill(255);
  
  //draws the balls in their current positions
  for(int i = 0; i < n; i++){
    circle(balls[i].x, balls[i].y, ballSize);
    fill(255,0,0);
  }
  
  //the leader chases the last ball in the line
  if( leaderFollows.equals("end") ) {
    balls[0].x += (balls[n-1].x-balls[0].x)*k;
    balls[0].y += (balls[n-1].y-balls[0].y)*k;
  }
  
  //the leader traces a sine wave. For best results, set n to over 100 and shrink the ball size
  else if( leaderFollows.equals("wave") ) {
    balls[0].x = 1.2*t;
    balls[0].y = yC - r*sin(.04*t);
    t++;
  }
  
  //the leader traces a spiral. For best results, set n to over 100 and shrink the ball size
  else if(leaderFollows.equals("spiral")) {
    balls[0].x = xC + r*cos(time);
    balls[0].y = yC - r*sin(time);
    time += .05;
    r += .1;
  }
  
  //the leader bounces around the room
  else if(leaderFollows.equals("line")) {
    balls[0].x += xCurrSpeed;
    balls[0].y += yCurrSpeed;
    
    if (balls[0].x >= width){
      xCurrSpeed = -xLineSpeed;
    }
    if (balls[0].x <= 0){
      xCurrSpeed = xLineSpeed;
    }
    if (balls[0].y >= height){
      yCurrSpeed = -yLineSpeed;
    }
    if (balls[0].y <= 0){
      yCurrSpeed = yLineSpeed;
    }
  }

  //makes the leader chase the mouse
  else{
    balls[0].x += (mouseX - balls[0].x) * k;
    balls[0].y += (mouseY - balls[0].y) * k;
  }
  
  //makes each non-leader ball chase the ball ahead of it
  for(int i = 1; i < n; i++){
    balls[i].x += (balls[i-1].x-balls[i].x) * k;
    balls[i].y += (balls[i-1].y-balls[i].y) * k;
  }
}


//IF THE USER CLICKS THE MOUSE, THE LEADER WILL START TO CHASE THE END BALL
void mouseClicked(){
  leaderFollows = "end";
}
