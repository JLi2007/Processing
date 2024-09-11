class Robot {
  int i, j;         //CURRENT POSITION IN THE MAZE
  String direction; //"up", "down", "left", "right"
  Maze maze;
  ArrayList<Integer[]> path = new ArrayList<Integer[]>();

  Robot(Maze m) {
    this.maze = m;
  }

  void setPosition(int startI, int startJ, String dir) {
    this.i = startI;
    this.j = startJ;
    this.direction = dir;
    this.maze.cells[this.i][this.j] = true;  //ensures robot starts in an open cell
    addPositionToPath();
  }
  
  
  void addPositionToPath() {
    Integer[] currentLocation = {this.i, this.j};
    path.add( currentLocation );
  }


  void turnAround() {
    if (direction.equals("down"))
      direction = "up";
    else if (direction.equals("up"))
      direction = "down";
    else if (direction.equals("left"))
      direction = "right";
    else
      direction = "left";
      
    println("TURN AROUND");
  }


  void turnRight() {
    if (direction.equals("down"))
      direction = "left";
    else if (direction.equals("up"))
      direction = "right";
    else if (direction.equals("left"))
      direction = "up";
    else
      direction = "down";
      
    println("RIGHT");
  }


  void turnLeft() {
    if (direction.equals("down"))
      direction = "right";
    else if (direction.equals("up"))
      direction = "left";
    else if (direction.equals("left"))
      direction = "down";
    else
      direction = "up";
      
    println("LEFT");
  }


  boolean atExit() {
    return this.i == maze.exitI && this.j == maze.exitJ;
  }


  boolean atIntersection() {
    int numPossibleDirections=0;

    if (canTurnRight())
      numPossibleDirections++;

    if (canTurnLeft())
      numPossibleDirections++;

    if (canGoStraight())
      numPossibleDirections++;

    return numPossibleDirections > 1;
  }


  boolean canTurnRight() {
    if (direction.equals("down")) 

      if (j==0) //at left edge
        return false;

      else 
      return maze.cells[i][j-1];

    else if (direction.equals("up")) 
      if (j==maze.mazeWidth-1) //at right edge
        return false;

      else 
        return maze.cells[i][j+1];

    else if (direction.equals("right")) 
      if (i==maze.mazeHeight-1) //at bottom edge
        return false;

      else 
        return maze.cells[i+1][j];

    else //going left
      if (i==0) //at bottom edge
        return false;
  
      else 
        return maze.cells[i-1][j];
  }


  boolean canTurnLeft() {
    if (direction.equals("up")) 
      if (j==0) //at left edge
        return false;

      else 
        return maze.cells[i][j-1];


    else if (direction.equals("down")) 
      if (j==maze.mazeWidth-1) //at right edge
        return false;

      else 
        return maze.cells[i][j+1];

    else if (direction.equals("left")) 
      if (i==maze.mazeHeight-1) //at bottom edge
        return false;

      else 
        return maze.cells[i+1][j];

    else //going right
      if (i==0) //at bottom edge
        return false;
  
      else 
        return maze.cells[i-1][j];
  }


  boolean canGoStraight() {
    if (direction.equals("left")) 

      if (j==0) //at left edge
        return false;

      else 
        return maze.cells[i][j-1];


    else if (direction.equals("right")) 
      if (j==maze.mazeWidth-1) //at right edge
        return false;

      else 
        return maze.cells[i][j+1];

    else if (direction.equals("down")) 
      if (i==maze.mazeHeight-1) //at bottom edge
        return false;

      else 
        return maze.cells[i+1][j];

    else //going up
      if (i==0) //at top edge
        return false;
  
      else 
        return maze.cells[i-1][j];
  }


  void forwardOneStep() {
    if (direction.equals("down")) 
      if (this.i < maze.mazeHeight-1)
        this.i++;
      else 
        println("ERROR! CAN'T GO DOWN FROM " + i + " " + j);

    else if (direction.equals("up")) 
      if (this.i > 0)
        this.i--;
      else 
        println("ERROR! CAN'T GO UP FROM " + i + " " + j);

    else if (direction.equals("right")) 
      if (this.j < maze.mazeWidth - 1)
        this.j++;
      else 
        println("ERROR! CAN'T GO RIGHT FROM " + i + " " + j);

    else 
      if (this.j > 0)
        this.j--;
      else 
        println("ERROR! CAN'T GO LEFT FROM " + i + " " + j);
    
    println("STRAIGHT");
    
    addPositionToPath();
  } 


  void drawMe(int n) {
    Integer currColumn = path.get(n)[1];
    Integer currRow = path.get(n)[0];
    
    int s = maze.cellSize;
    int xPos = maze.pad + currColumn*s;
    int yPos = maze.pad + currRow*s;

    fill(0,0,255);
    circle(xPos+s/2, yPos+s/2, s);
  }
}
