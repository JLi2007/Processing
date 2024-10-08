// James Li September 26 U2 Project
/********************************
** PARAMETERS & VARIABLES
*********************************/
int ballRadius=40;
int rowPos_y=0;
int numBalls,rowPos_x, ballColor, rowSelected, colSelected, movedBallX,movedBallX2, movedBallY;
boolean isRowSelected = false;
// stores numbers from txt file
int[][] rowData;
// 2d array coordinates of all the balls
String[][] coords;
// original ball coords for connecting lines (uses coords 2d array)
String[] ballCoords;
// ball coords of balls to draw line to (uses) coords 2d array)
String[] newBallCoords;
// ball coords after mouse move
String[] movedCoords;

void setup(){
  size(650, 650);
  background(0);
  // load the gridData.txt file and store in a String array
  String[] ballData = loadStrings("gridData.txt");
  // call functions
  initializeBalls(ballData);
  make2DArray();
  drawItems();
}

// Empty draw function for mouse functions to work
void draw(){}

// Populate the rowData 2D array from the loaded String
void initializeBalls(String[] ballData){
  // number of balls per row
  numBalls = int(ballData[0]);
  // the length of coords 2d array depends on the specifics of txt file!
  coords = new String[ballData.length-1][numBalls];
  // set rowData array to the ballData length minus the line that indicates the "number of balls per row"
  rowData = new int[ballData.length-1][ballData.length-1];
  for(int row = 1; row<ballData.length; row++){
    // create a rowBallData string array for each row and split by a tab
    String[] rowBallData = ballData[row].split("\t");
    // populate rowData 2D array
    for(int col = 0; col<rowBallData.length;col++){
      // row-1 to remove the line that indicates the "number of balls per row"
      rowData[row-1][col]=int(rowBallData[col]);
    }
  }
}

// Create the coords 2D array
void make2DArray(){
  // loop through all balls
  for(int row = 0; row<rowData.length; row++){
    // reset x position every row
    rowPos_x=0;
    // y position is extracted from the txt file
    rowPos_y+=int(rowData[row][3]);
    for(int col=0; col<numBalls; col++){
      // x position is increased by some amount (does not matter)
      rowPos_x+=(ballRadius*2);
      // create a string combination for the ball to split later in the code with correct x and y position
      coords[row][col] = (rowPos_x+","+rowPos_y);
    }
  }
}

// Draw the circles
void drawCircles(){
  // loop through all balls 
  for(int row = 0; row<rowData.length; row++){
    for(int col=0; col<numBalls; col++){
      // split the x and y position for the current ball
      ballCoords = coords[row][col].split(",");
      // use the color specified in txt file via rowData 2d array
      ballColor = color(rowData[row][0], rowData[row][1], rowData[row][2]);
      fill(ballColor);
      stroke(0);
      // draw the circle
      circle(float(ballCoords[0]), float(ballCoords[1]),float(ballRadius));
    }
  }
}

// Draws the connecting lines
void drawConnectingLines(String[][] coords){
  // loop through all the rows minuus bottom row
  for(int ballRow=0; ballRow<rowData.length-1; ballRow++){
    for(int ballColumn=0; ballColumn<numBalls; ballColumn++){
      // split the x and y position for the current ball
      ballCoords = coords[ballRow][ballColumn].split(",");
      for(int otherBallColumn=0; otherBallColumn<numBalls; otherBallColumn++){
        // split the x and y position for EACH ball in the next row
        newBallCoords = coords[ballRow+1][otherBallColumn].split(",");
        stroke(255);
        // draw the line
        line(float(ballCoords[0]), float(ballCoords[1]), float(newBallCoords[0]), float(newBallCoords[1]));
      }
    }
  }
}

// Draw the circles and connecting lines
void drawItems(){
  drawCircles();
  drawConnectingLines(coords);
  // draw circles again just to cover the lines drawn over the circle
  drawCircles();
}
/********************************
** Mouse Fns
*********************************/
void mousePressed() {
    // loop through all the balls and find the ball the mouse is on (if there is any ball at all)
    for (int movedRow = 0; movedRow < rowData.length; movedRow++) {
        for (int movedColumn = 0; movedColumn < numBalls; movedColumn++) {
            movedCoords = coords[movedRow][movedColumn].split(",");
            // distance formula with mouse coordinates of mouse and coordinates of a ball
            if (dist(mouseX, mouseY, int(movedCoords[0]), int(movedCoords[1])) < ballRadius) {
                // if the mouse is on the ball:
                // set the row moved
                rowSelected = movedRow;
                // set the column moved
                colSelected = movedColumn;
                // indicate that something is selected
                isRowSelected = true;
            }
        }  
    }
}

// Indicate that something isn't selected anymore on mouse release
void mouseReleased() {
    isRowSelected = false;
}

void mouseDragged() {
    // if something is selected
    if(isRowSelected) {
        // create variables on the position of mouse
        movedBallX = mouseX;
        movedBallX2 = mouseX;
        movedBallY = mouseY;
        
        // loop through all the balls in a column
        // no need to loop through rows because there is only one row selected
        for (int ball = 0; ball < numBalls; ball++) {
            // logic to move the balls correctly using the ball in the column moved
            if (ball < colSelected) {
                movedBallX -= (ballRadius * 2);  
                coords[rowSelected][ball] = (movedBallX + "," + movedBallY);
            } else{
                coords[rowSelected][ball] = (movedBallX2 + "," + movedBallY);
                movedBallX2 += (ballRadius * 2);
            }
        }
        // redraw
        background(0);
        drawItems();
    }
}