class Plant {
  PVector pos;
  float diameter, radius;
  
  Plant(float x, float y) {
    this.pos = new PVector(x, y);
    this.diameter = 50;
    this.radius = this.diameter/2;
  }
  
  void drawMe() {
    if( this.diameter > 0 ) {
      fill(0, 100, 50); noStroke();
      circle(this.pos.x, this.pos.y, this.diameter);
    }
  }
}
