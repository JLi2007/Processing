class Marker {
  PVector pos;
  float xSpeed, ySpeed;
  float distFromCenter;
  float frequency;
  color colour;
  int strokeSize;
  
 
  Marker( color col ) {
    this.colour = col;
  }
  
  
  void updatePosition() { 
    float theta = this.frequency * t;
    this.pos = generatorShape.getPoint( theta );
   
    this.distFromCenter = this.pos.dist( center );
  }  
  
  
  void drawMe() {
    fill( this.colour );
    stroke(0);
    circle( this.pos.x, this.pos.y, 12 );
  }
}
