// the purple marker
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
    // because this.frequency is divided by 100 and t is being increased by 1 every draw, this.frequency*t keeps is kept a constant speed when moving
    // 0=360=720... theta is just an angle. Useful for sin and cos
    float theta = this.frequency * t;
    // bring called to update from draw, calls getPoint and theta to move within the bounds of shape
    this.pos = generatorShape.getPoint( theta );
    this.distFromCenter = this.pos.dist( center );
  }  
  
  void drawMe() {
    fill( this.colour );
    stroke(0);
    circle( this.pos.x, this.pos.y, 12 );
  }
}
