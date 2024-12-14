Maze maze;
Robot robot;
int robotSpeed = 2;
int stepNumber = 0;


void setup() {
  size(600, 600);
  background(0);
  frameRate( robotSpeed );
  
  maze = new Maze( 7, 9 ); //Create an empty 7x6 maze

  maze.digColumn(1);       //Dig all of column 1
  maze.digRow(2, 0, 1);    //Dig row 2 from columns 0-1
  maze.digColumn(5, 0, 2); //Dig column 5 from rows 0-2
  maze.digRow(3, 1, 5);    //Dig row 3 from columns 1-5
  maze.digRow(5, 1, 7);    //Dig row 5 from columns 1-7
  maze.digColumn(3, 1, 5);
  maze.digColumn(7, 3, 5);

  maze.setExit(0, 5);      //The exit is is row 0, column 4

  robot = new Robot( maze );
  robot.setPosition(0, 1, "down" );  //Robot starts in row 0, column 1, heading down
  
  maze.drawMe();

  solveMaze();  //Solves the maze and stores the robot's path before draw() starts running the animation
}    


void solveMaze() {
  //BASE CASE: WE'RE AT THE EXIT
  if ( robot.atExit() )  
    println("FOUND THE EXIT!");

  //RECURSIVE CASE: USE THE RIGHT-HAND RULE TO SET YOUR DIRECTION, THEN GO 1 STEP
  else {              
    if ( robot.canTurnRight() ) {
      robot.turnRight();
    } 
    
    else if (robot.canGoStraight()) {
      //keep current direction
    }

    else if (robot.canTurnLeft()) {
      robot.turnLeft();
    } 
    
    else {
      robot.turnAround();
    }
    
    robot.forwardOneStep();
    solveMaze(); //Recursive call. By now, the robot has changed its location and/or direction
  }
} 


void draw() {
  if( stepNumber < robot.path.size() ) {
    background(0);
    maze.drawMe();
    robot.drawMe( stepNumber ); 
    stepNumber++;
  }
}
