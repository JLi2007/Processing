/*  
     Last Computer Science project :( 
                Option A
         Bridge Finding Simulator
            Written by Hossein 
*/ 

// import the g4p library
import g4p_controls.*;

// initiallize the global variables
boolean pauseAnimation = false;
int bridgeInt = 0; // the bridge is located at the left of the screen i.e. 0 pixels
PImage DALeft, DARight, CGLeft, CGRight, Background, Arrow, InitialArrow;
Robot DA, CG;

void setup(){
  
  size(1000,800);
  frameRate(60);

  // load the images and save them in their variables
  DALeft = loadImage("orangeCarLeft.png");
  DARight = loadImage("orangeCarRight.png");
  CGLeft = loadImage("blueCarLeft.png");
  CGRight = loadImage("blueCarRight.png");
  Background = loadImage("background.png");
  Arrow = loadImage("Arrow.png");
  InitialArrow = loadImage("ArrowYellow.png");

  // create our robots, declare the algorithm, image height and image width
  DA = new Robot("DA", 86, 154);
  CG = new Robot("CG", 86, 154);
  
  createGUI();
}

void draw(){
  if (!pauseAnimation){
    
    // draw the background for a fresh start
    image(Background,0,0);
    
    // draw the cars and point them towards their direction
    if (CG.movingRight)
      image(CGRight, CG.location - CG.carWidth/2, 110, CG.carWidth, CG.carHeight);
        // subtract half car width ^ so the car image is centered
    else
      image(CGLeft,  CG.location - CG.carWidth/2, 110, CG.carWidth, CG.carHeight);
    
    if (DA.movingRight)
      image(DARight, DA.location - DA.carWidth/2, 510, DA.carWidth, DA.carHeight);
    else 
      image(DALeft,  DA.location - DA.carWidth/2, 510, DA.carWidth, DA.carHeight);    
    
    // create a yellow arrow at the cars initial position
    image(InitialArrow, CG.startLocation-5 , 170, 5, 20);
    image(InitialArrow, DA.startLocation-5, 580, 5, 20);
    
    // draw the red arrows everytime the robot turns
    for (int i=0; i<CG.turningPoints.size();i++)
      image(Arrow, CG.turningPoints.get(i) - 5, 170, 5, 20);
        
    for (int i=0; i<DA.turningPoints.size();i++)
      image(Arrow, DA.turningPoints.get(i) - 5, 580, 5, 20);
    
    // write the total distance travelled on the screen
    fill(255);
    text("Distance Travelled",10,630);
    text(DA.totalDistanceTravelled, 40, 642);
    text("Distance Travelled",10,205);
    text(CG.totalDistanceTravelled, 40, 217);
    
    // the icing on the cake :)
    fill(0);
    text(CG.speed, 23,50);
    text(DA.speed, 957,645);
    
    // check if the robot has reached the bridge
    CG.checkBridge();
    DA.checkBridge();
    
    // if robot has not reached bridge, move it
    if (! CG.reachedBridge)
      CG.makeMove();
    if (! DA.reachedBridge)
      DA.makeMove();
    
    // if both robots have reached the bridge stop the animation
    if (DA.reachedBridge &&  CG.reachedBridge ){
      println("CG  #Moves", CG.totalMovesMade,"\t sVal", CG.sVal);
      println("DA  #Moves", DA.totalMovesMade,"\t sVal", DA.sVal);  
      println("done");
      println();
      pauseAnimation = true;
    }
  }
}

// factory resets the robot variables
void resetValues(){
  DA.reachedBridge = false;
  CG.reachedBridge = false;
  
  DA.movingRight = true;
  CG.movingRight = true;
  
  DA.location = DA.startLocation;
  CG.location = CG.startLocation;
  
  DA.Goal = DA.strideLength + DA.location;
  CG.Goal = CG.strideLength + CG.location;
  
  DA.prevLocation = DA.location;
  CG.prevLocation = CG.location;
  
  DA.sVal = 1;
  CG.sVal = 1;
  
  DA.totalMovesMade = 0;
  CG.totalMovesMade = 0;
  
  DA.totalDistanceTravelled = 0;
  CG.totalDistanceTravelled = 0;

  DA.turningPoints.clear();
  CG.turningPoints.clear();
  
  pauseAnimation = false;
  println();
}
