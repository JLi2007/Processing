void mouseClicked() {
  int col = int((mouseX - padding)/cellSize);
  int row = int((mouseY - padding)/cellSize);
  
  try {
    temps[row][col] = maxTemp;
  }
  
  catch(Exception e){}
}


void mouseDragged() {
  int col = int((mouseX - padding)/cellSize);
  int row = int((mouseY - padding)/cellSize);
  
  try {
    temps[row][col] = maxTemp;
  }
  
  catch(Exception e){}
}
