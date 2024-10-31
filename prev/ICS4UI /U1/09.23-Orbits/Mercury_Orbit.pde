float earthFreq = 0.025;
float freqRatio =  365.25/87.98;
int framesBetweenLines = 2;

float t = 0.0;
Planet sun, mercury, earth;
float xC, yC;


void setup() {
  background(0);
  size(700, 700);
  noFill();
  
  xC = width/2; yC = height/2;
  
  mercury = new Planet( 150, earthFreq * freqRatio, 35, color(180, 180, 0));
  earth = new Planet( 300, earthFreq, 35, color(0, 255, 120));
  sun = new Planet( 0, 0, 75, color(255, 255, 0));
}


void draw() {
  background(0);
  
  stroke(255, 255, 255, 150);  
  strokeWeight(1);
  noFill();
  
  for( int i = 0; i < mercury.trail.size(); i++ ) {
    PVector p1 = mercury.trail.get(i);
    PVector p2 = earth.trail.get(i);
    if( i == mercury.trail.size() - 1 ) {
      stroke(255, 0, 0);
      strokeWeight(2);
    }
    line( p1.x, p1.y, p2.x, p2.y );
  } 
  
  noStroke();
  
  mercury.drawMe();
  earth.drawMe();
  sun.drawMe();
  
  mercury.updatePos();
  earth.updatePos();
 
  t += 1;
}

class Planet {
  float R;
  float freq;
  float diam;
  PVector pos;
  ArrayList<PVector> trail = new ArrayList();
  color col;
  
  Planet(float r, float f, float d, color c) {
    this.R = r;
    this.freq = f;
    this.diam = d;
    this.pos = new PVector(xC + R, yC);
    this.col = c;
    
  }
  
  void updatePos() {
    this.pos.x = xC + R*cos(freq*t); 
    this.pos.y = yC - R*sin(freq*t);
    
    if( frameCount % framesBetweenLines == 0)
      trail.add( new PVector(this.pos.x, this.pos.y) );
  }
  
  
  void drawMe() {
    fill( this.col );
    circle( this.pos.x, this.pos.y, this.diam );
  }
}