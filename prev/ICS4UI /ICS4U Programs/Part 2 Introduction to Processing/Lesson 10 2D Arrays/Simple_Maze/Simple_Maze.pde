int n = 4;
int[][] maze = new int[n][n];
int boxSize;
color mazeColor = color(255,0,0);
int ballX = 320, ballY = 320;
int ballRow, ballColumn;


void setup(){
  size(600,600);
  boxSize = width/n;
  
  String[] mazeLines = loadStrings("Maze data.txt");
  
  for(int i = 0; i < n; i++){
    String nextLine = mazeLines[i];
    String[] nextLineData = nextLine.split(" ");
    
    for(int j = 0; j < n; j++){
      maze[i][j] = int( nextLineData[j] );
      print(nextLineData[j] + " ");
    }
    println();
  }
}


void draw() {
  background(128);
  
  drawMaze();
  drawCharacter();
}
