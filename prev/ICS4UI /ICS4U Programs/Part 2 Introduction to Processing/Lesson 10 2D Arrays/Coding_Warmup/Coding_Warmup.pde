int numRows, numCols;
int xStart, yStart;

void setup() {
 size(500, 500);
 String[] allLines = loadStrings("Grid.txt");
 
 String dimLine = allLines[0];  //1ST LINE OF THE DATA FILE
 String xyLine = allLines[1];   //2ND LINE OF THE DATA FILE
 
 String[] dimensions = dimLine.split("\t"); //1ST LINE TURNED INTO AN ARRAY 
 String[] xyStart = xyLine.split("\t");     //2ND LINE TURNED INTO AN ARRAY 
 
 numRows = int( dimensions[0] );  //GRABBING THE TWO VALUES FROM THE 1ST LINE
 numCols = int( dimensions[1] );
 
 xStart = int( xyStart[0] );      //GRABBING THE TWO VALUES FROM THE 2ND LINE
 yStart = int( xyStart[1] );
 
 println(numRows, numCols);       //PRINTING ALL 4 VALUES TO MAKE SURE THE FILE READING WORKED 
 println(xStart, yStart);
}


void draw() {
  background(0);
  fill(255,255,0);
  
  int yBall = yStart;

  for(int row = 0; row < numRows; row++) {
    int xBall = xStart;
    
    for(int col = 0; col < numCols; col++) {
      circle(xBall, yBall, 20);
      xBall += 50;
    }
    
    yBall += 50;
  }
}
