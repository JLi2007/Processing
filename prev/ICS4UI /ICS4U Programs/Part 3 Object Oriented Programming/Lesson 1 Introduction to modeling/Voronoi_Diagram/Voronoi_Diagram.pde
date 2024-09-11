PVector[] p;
int numPoints;
int maxNumPoints = 150;
int numShades = 150;
boolean drawSeeds = true;
int n = 0;
color[] colorSet;
color[][] pixelColors;

String mode = "clicking"; //Or "sine wave" or "line"


void setup(){
  size(500,500);
  background(255);
  noLoop();
  
  pixelColors = new color[width][height];

  p = new PVector[maxNumPoints];
  colorSet = new color[maxNumPoints];
  setColorPalette( numShades );    
  
  if( mode.equals( "line" )) {
    drawPointsLine(0, 400, width, 400); 
    calculateNeighborhoods();
  }
    
  else if( mode.equals( "sine wave" )) {
    drawPointsSineWave( numShades, width/2, 1);
    calculateNeighborhoods();
  }
  
  else {
    //JUST WAIT FOR USER TO CLICK AROUND
    textSize(18);
    fill(255,0,0);
    text("Click anywhere. Wait a sec between clicks...", 20, 20);
  }
}


void mouseClicked() {
  if( mode.equals( "clicking" )) {
    p[n] = new PVector(mouseX, mouseY);
    n++;
    calculateNeighborhoods();
    redraw();
  }
}


//FOR EACH PIXEL ON SCREEN, DETERMINE WHICH BLACK DOT IS CLOSEST TO IT, AND SHADE THE PIXEL ACCORDINGLY
void calculateNeighborhoods() {
  for(int i = 0; i < width; i++){
    for(int j = 0; j < height; j++){
      
      float minDist = 2*width;
      int kClosest = n;
      
      for(int k = 0; k < n; k++){
        float d = dist(i, j, p[k].x, p[k].y);
        
        if (d < minDist){
          kClosest = k;
          minDist = d;
        }
      }
      
      pixelColors[i][j] = colorSet[ kClosest ];
    }
  }
}


void draw() {    
    if( n > 0 ) {
   
      for(int i=0; i < width; i++) {
        for(int j=0; j< height; j++) {
          stroke( pixelColors[i][j] );        
          point(i,j);
        }
      }
      
    }
    
    fill(0);
    noStroke();
    
    if( drawSeeds ) {
      for(int k = 0; k < n; k++){
        circle(p[k].x, p[k].y, 10);
      }
    }
}


void setColorPalette(int numShades){
  for(int i=0; i < numShades; i++){
    int red = int(random(1,254));
    int green = int(random(1,254));
    int blue = int(random(1,254));
    colorSet[i] = color(red,green,blue);
  }
}


void drawPointsLine(float x1, float y1, float x2, float y2) {
  float x=x1, y=y1;
  float dx = (x2-x1)/maxNumPoints, dy = (y2-y1)/maxNumPoints;
  n=1;
  p[0] = new PVector(width/2, height/2);
  
  for(int i=1; i < maxNumPoints; i++){
    p[i] = new PVector(x, y);
    x += dx;
    y += dy;
    n++;
  }
}


void drawPointsSineWave(int numPoints, float r, float numWraps){
  float dTheta = 2*PI/numPoints*numWraps;
  float xC = width/2;
  float yC = height/2;
 
  for(int k = 0; k < numPoints; k++){
    n++;
    float x = -70+k*width/(numPoints-70); x = xC + r*cos(k*dTheta); x = k*width/numPoints;//
    float y = yC - r/3*sin(3*k*dTheta);
    p[k] = new PVector(x,y);
  }
}
