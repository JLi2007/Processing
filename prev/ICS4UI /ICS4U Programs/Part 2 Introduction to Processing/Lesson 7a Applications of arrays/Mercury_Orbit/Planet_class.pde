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
