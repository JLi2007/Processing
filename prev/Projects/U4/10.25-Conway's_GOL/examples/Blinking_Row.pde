boolean[] cells;

int n = 20;
float cellSize;
float padding = 50;
int blinksPerSecond = 2; //used in the call to frameRate() inside setup()

void setup(){
  size(800,800);
  cellSize = (width-2*padding)/n;
  cells = new boolean[n];
  setCellValuesRandomly();
  frameRate( blinksPerSecond );
}


void draw() {  
  background(255,255,0);
  float y = padding;
  
  for(int i=0; i<n; i++) {
    float x = padding + i*cellSize;
    
    if (cells[i])
      fill(255);
      
    else
      fill(0);
      
    square(x, y, cellSize);
  }
  
  setCellValuesRandomly(); //RESETS THE CELL VALUES AFTER EACH FRAME, CREATING A BLINKING EFFECT.
}


void setCellValuesRandomly() {
  for(int i = 0; i < n; i++) {
    int x = round(random(0,1));
    
    if (x == 0)
      cells[i] = false;
      
    else
      cells[i] = true;
  }
}

 
