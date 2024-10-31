int n = 100;
boolean[][] cells = new boolean[n][n];
boolean[][] newCells = new boolean[n][n];

float padding = 10;
float cellSize;

void setup(){
  size(800,800);
  cellSize = (width - 2*padding)/n;

  // the speed at which the frames change
  frameRate( 2 );  

  setCellValuesRandomly();
}

void draw() {
  background(140);
  stroke(140);
  float y = padding; //the top of the grid
  
  for(int i = 0; i < n; i++) {
    float x = padding;
    
    for(int j = 0; j < n; j++) {
      if ( cells[i][j] == true ) 
        fill(0);     
      else
        fill(255);
        
      square(x, y, cellSize);    
      x += cellSize;
    }   
    y += cellSize;
  }  
 setCellsUsingGOLrules();
 for(int row = 0; row < n; row++){
  for(int col = 0; col < n; col++){
    cells[row][col] = newCells[row][col];
  }
 }
}

void setCellsUsingGOLrules() {
   for(int row = 0; row < n; row++) {
    for(int col = 0; col < n; col++) {  
      int aliveNeighbors = countAliveNeighbors(row,col);

      if(cells[row][col] == true){
          if (aliveNeighbors == 2 || aliveNeighbors==3){
            newCells[row][col]=true;
          }
          else{
            newCells[row][col] = false;
          }      
        }

        else{
          if(aliveNeighbors==3){
            newCells[row][col] = true;
          }
        }
      }
    }
}

int countAliveNeighbors(int row, int col){
    int count = 0;
    for(int a=-1; a<2; a++){
      for(int b=-1; b<2; b++){
        // try catch block to avoid exception errors
        try{
          if(cells[row+a][col+b]==true && (b!=0 || a!=0)){ //final condition is to not count itself
            count+=1;
          }
        } 
        
        catch( Exception e ){
          count+=0;
        }
      }
    }
    return count;
}

// randomly at the start
void setCellValuesRandomly() {
  for(int i = 0; i < n; i++) {
    
    for(int j = 0; j < n; j++) {      
      int x = round(random(0, 1));
      
      if (x == 0)
        cells[i][j] = false;
        
      else
        cells[i][j] = true;
    }
  }
}