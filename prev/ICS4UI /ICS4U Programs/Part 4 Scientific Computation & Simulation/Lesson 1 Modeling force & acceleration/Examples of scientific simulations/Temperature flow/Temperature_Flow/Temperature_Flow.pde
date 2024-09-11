//USER CONTROLS
int n = 50;
float conductivity = 0.35;
float blinksPerSecond = 8;
String method = "ring"; //"random" or "ring"
int ringThickness = round(0.2*n);
float minTemp = -100;
float maxTemp = 100;


//GLOBAL VARIABLES
float padding = 50;
float cellSize;

color cold = color(0,0,255);
color neutral = color(255);
color hot = color(255,0,0);

float avgTemp  = (minTemp + maxTemp)/2;

float[][] temps = new float[n][n];

void setup(){
  size(800,800); 
  frameRate( blinksPerSecond );
  cellSize = (width-2*padding)/n;
    
  plantFirstGen();
}


void draw() {
  background(255);
 // println( getTotalEnergy() );
  float y = padding;
  
  for(int i=0; i<n; i++) {
    for(int j=0; j<n; j++) {
      float x = padding + j*cellSize;
      color c = getColor(temps[i][j]);
      fill(c); stroke(c);
      square(x, y, cellSize);
    }
    
    y += cellSize;
  }
      
  setNextGeneration();
}



void setNextGeneration() {
      
  for(int i=0; i<n; i++) {  
    for(int j=0; j<n; j++) {
      try{
        float avgTemp = (temps[i][j+1]+temps[i][j])/2;
        float gainFromRight = (avgTemp-temps[i][j])*conductivity;
        
        temps[i][j] += gainFromRight;
        temps[i][j+1] -= gainFromRight;
       
      }
      catch(Exception e){}
      
      try{
        float avgTemp = (temps[i+1][j]+temps[i][j])/2;
        float gainFromBelow = (avgTemp-temps[i][j])*conductivity;
        
        temps[i][j] += gainFromBelow;
        temps[i+1][j] -= gainFromBelow;
      }
      catch(Exception e){}
    }
  }
}
