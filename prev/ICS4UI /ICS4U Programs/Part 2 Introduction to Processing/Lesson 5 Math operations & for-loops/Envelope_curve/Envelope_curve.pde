float n=1;
float dx;
float frameSpeed = 2;

void setup() {
  size(800,800);
  background(0);
  stroke(255);
  frameRate(frameSpeed);
  //noLoop();
}

void draw() {
  background(0);
  
  float x1 = width/2;
  float dx = x1/n;
  float x2 = x1 + dx;
  float y1 = 0;
  float y2 = height/2;
  
  for(int i=0; i<=n; i++){
    stroke(255,0,0);
    line(x1,y1,x2,y2);
    y1 += dx;
    x2 += dx;
  }
  
  x2 = x1 - dx;
  y1 = 0;
  
  for(int i=0; i<n; i++){
    stroke(0,255, 0);
    line(x1,y1,x2,y2);
    y1 += dx;
    x2 -= dx;
  }
      
  x2 = x1 + dx;
  y1 = height;

  for(int i=0; i<n; i++){
    stroke(0,255, 0);
    line(x1,y1,x2,y2);
    y1 -= dx;
    x2 += dx;
  }
   
  x2 = x1 - dx;
  y1 = height;
  
  for(int i=0; i<=n; i++){
    stroke(255,0, 0);
    line(x1,y1,x2,y2);
    y1 -= dx;
    x2 -= dx;
  }
  
  if( n < 100 ) {
    n++; 
    frameSpeed += 0.2;
    frameRate(frameSpeed);
  }
  
  else
    noLoop();  
}
