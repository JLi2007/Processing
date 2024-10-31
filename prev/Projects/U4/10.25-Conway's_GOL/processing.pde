// used controlP5 library: http://www.sojamo.de/libraries/controlP5
import controlP5.*;
ControlP5 cp5;

// ADJUSTABLE VALUES:

// starting frame speed
int frame_speed = 5;

// number of cells
int n = 100;

// ADJUSTABLE VALUES END

boolean[][] cells = new boolean[n][n];
boolean[][] newCells = new boolean[n][n];

float padding = 10;
float cellSize;

void setup(){
  size(800,800);
  cellSize = (width - 2*padding)/n;

  // initiate slider
  cp5 = new ControlP5(this);

  cp5.addSlider("frame_speed")
     .setPosition(padding,0)
     .setWidth(width/3)
     .setRange(1,15)
     .setValue(frame_speed)
     .setSliderMode(Slider.FLEXIBLE)
  ;

  // start at either random or checkerboard
  setCellValuesCheckerboard();
  // setCellValuesRandomly();
}

void draw() {
  background(140);
  stroke(140);

  frameRate( frame_speed );  // the speed at which the frames change

  float y = padding; //the top of the grid
  
  // draw black square for alive, unfilled white square for dead
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

    // rewrite cells with new cells
  for(int row = 0; row < n; row++){
    for(int col = 0; col < n; col++){
      cells[row][col] = newCells[row][col];
    }
  }
}

// use game of life rules to set next generation of cells
void setCellsUsingGOLrules() {
   for(int row = 0; row < n; row++) {
    for(int col = 0; col < n; col++) {  
      int aliveNeighbors = countAliveNeighbors(row,col);

      if(cells[row][col] == true){
        if (aliveNeighbors == 2 || aliveNeighbors==3){
            newCells[row][col] = true;
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

// count the alive neighbors if a certain square
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
          count+=0; //do nothing
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

// checkerboard pattern
void setCellValuesCheckerboard() {
  for(int i = 2; i < (n+2); i++) { 
    for(int j = 2; j < (n+2); j++) {
      if(i%2==0){
        if(j%2==0){
          cells[i-2][j-2] = true;
        }
        else{
          cells[i-2][j-2] = false;
        }
      }

      else{
        if(j%2 == 0){
          cells[i-2][j-2] = false;
        }
        else{
          cells[i-2][j-2] = true;
        }
      }
    }
  }
}