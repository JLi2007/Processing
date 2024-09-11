int numRows = 5;  //CHANGE ME. 5 = STANDARD BILLIARDS RACK

String mode = "placing"; 
Ball[] balls;
color[] billiardColours;
float maxSpeed = 5;
float r;
int numBalls = 1 + numRows*(numRows+1)/2;
float friction = 0.995;
boolean cueballClicked = false;
int gap = 150;

void setup(){
  size(450,600);
  r = width/30;
  setColours();
  arrangeBalls(numRows);
}

void draw(){
  background(0, 200, 0);
  
  fill(0);
  textSize(16);
  
  if( mode.equals("placing") )
    text("Drag the cue ball where you want it, then release", 10, 30);
    
  else if ( mode.equals("aiming") ) {
    text("Click and drag an aiming line", 10, 30);
    text("Then release the mouse to shoot", 10, 50);
    text("Longer line = faster speed", 10, 70);  
  }
  
  for( int i = 0; i < numBalls; i++ ) {
    balls[i].drawMe();
    
    if ( mode.equals("aiming") ) {
      line(balls[0].pos.x, balls[0].pos.y, mouseX, mouseY);
    }
 
    else if( mode.equals("animating") ){
      for( int j = i+1; j < numBalls; j++ ) {
        balls[i].checkCollision( balls[j] );
      }
    
      balls[i].updatePos();
    }
  }
}
