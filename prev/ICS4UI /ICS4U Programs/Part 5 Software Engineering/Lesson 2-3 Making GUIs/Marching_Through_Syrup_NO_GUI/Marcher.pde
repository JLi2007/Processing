class Marcher {
  float xPos, yPos, xSpeed, ySpeed;
  boolean inMapleSyrup;
  float size;
  
  Marcher( float x, float y, float xs, float ys ) {
    this.xPos = x;
    this.yPos = y;
    this.xSpeed = xs;
    this.ySpeed = ys;
    this.inMapleSyrup = false;
    this.size = 10;
  }
  
  void updatePosition() {      
     this.xPos += this.xSpeed;
     this.yPos += this.ySpeed;
  }
  
  void slowDown( ) {
    this.xSpeed /= stickiness;
    this.ySpeed /= stickiness;
  }
  
  void drawMe() {
    circle(this.xPos, this.yPos, size);
  }

}
