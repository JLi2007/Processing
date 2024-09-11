void drawMaze() {
  fill(mazeColor);
  
  for(int i = 0; i < n; i++){
    int y = i * boxSize;
    
    for(int j = 0; j < n; j++){
      int x = j * boxSize;
      
      if( maze[i][j] == 1 ) 
        square(x, y, boxSize);
    }
  }
}


void drawCharacter() {
  fill(0,255,0);
  circle(ballX, ballY, 50);
}


void mouseMoved() {
  ballRow = mouseY / boxSize;
  ballColumn = mouseX / boxSize;
 
  if( maze[ballRow][ballColumn] == 0 ){
    ballX = mouseX;
    ballY = mouseY;
  }
  
}
