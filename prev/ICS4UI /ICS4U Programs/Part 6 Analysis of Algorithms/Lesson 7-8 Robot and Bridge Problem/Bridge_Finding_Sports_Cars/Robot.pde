public class Robot{
  // create the varialbes
  boolean reachedBridge;
  boolean movingRight = true; // the robot always moves right first as did in the teacher examples
  int totalMovesMade;
  int totalDistanceTravelled;  
  int strideLength = 25;  // although these can be changed using the sliders they have 
  int speed = 5;          // to be given an initial value
  int sVal = 1;                 // the s value will always have to start at 1
  int startLocation = 500;           // where the car spawns 
  int prevLocation = startLocation;               // I broke up the robots movements 
  int location = startLocation;                   // into 3 steps: pastCheckmark, 
  int Goal = sVal * strideLength + startLocation; // present and futureCheckmark.
  String robotType;
  int carWidth;    
  int carHeight;   
  IntList turningPoints = new IntList(); // create an array list for the turning points
  
  Robot( String type, int y, int x){
    robotType = type;
    carWidth = x;
    carHeight = y;
  }
  
  void makeMove(){
    
    if (movingRight){
      if (location >= Goal){ //if we are moving right and we surpass our goal, we: 
        turningPoints.append(location  );   // register turning point
        movingRight = !movingRight;                  // change directions
        prevLocation = Goal;                         // our pastCheckmark becomes our goal
        increaseSVal();                              // increase the s value and set a new goal
        Goal = -sVal * strideLength + prevLocation;          
        makeMove();                                  // move in the other direction
      }
      else{
        location += speed; // else we move to the right one step
        totalMovesMade ++; // since we moved, we add one to the total moves made by the robot
      }
    }
    else if (! movingRight){ // same thing but in opposite direction
      if (location <= Goal){         
        turningPoints.append(location );
        movingRight = !movingRight;
        prevLocation = Goal;
        increaseSVal();
        Goal = sVal * strideLength + prevLocation;          
        makeMove();
      }
      else{
        location -= speed;
        totalMovesMade ++;
      }
    }
    totalDistanceTravelled = totalMovesMade * speed; // multiply the total moves made by the speed to get the total distance travelled
  }
  
  void checkBridge(){
    if (location  <= bridgeInt)
      reachedBridge = true;   
  }
  
  void increaseSVal(){
    // if the robots algorithm is doubling we double the sval
    // if robot algorithm is constant growth we add one
    if (robotType == "DA")
      sVal = 2 * sVal;
    else if (robotType == "CG")
      sVal ++; 
  }

}
