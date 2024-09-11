class Ray {
  float baseX, baseY, tipX, tipY, speedX, speedY;
  float reverseSpeedX, reverseSpeedY;
  boolean outsideCurve;
  float insideness; //negative=inside the ellipse, positive=outside
  
  Ray(float bx, float by, float sx, float sy){
    this.baseX=bx;
    this.baseY=by;
    this.tipX=bx;
    this.tipY=by;
    this.speedX=sx;
    this.speedY=sy;
    resetReverseSpeed();
  }
  
  
  void resetReverseSpeed() {
    this.reverseSpeedX = -this.speedX/10;
    this.reverseSpeedY = -this.speedY/10;
  }
    
  
  void update() {
    float prevInsideness = e.eval(this.tipX, this.tipY); //Determines whether the ray's tip was inside or outside the ellipse in the previous frame
    
    this.tipX += this.speedX;  //Where the ray would be in this frame
    this.tipY += this.speedY;
    
    float currInsideness = e.eval(this.tipX, this.tipY); //Determines whether the ray's tip will be inside or outside the ellipse in the current frame
    
    if( prevInsideness < 0 && currInsideness >= 0) {    //If the ray was inside the ellipse last frame but would go outside in this frame, then we've detected a bounce
        correctToBoundary();                       //Resets the ray to be exactly on the ellipse's surface
        float rotationAngle = getRotationAngle();  //Determines the angle by which the ray will bounce according to the reflection law
        this.rotateBy( rotationAngle );            //Rotates the ray by that angle
    }
  }
  
  
  void correctToBoundary() {
    while( e.eval(this.tipX, this.tipY) >= 0 ) {  //While the tip is still outside the ellipse...
      this.tipX += this.reverseSpeedX;  //...back the ray up along the direction it came from
      this.tipY += this.reverseSpeedY;
    }
  }
  
  
  //Determines the bouncing angle of a ray that has just hit the ellipse's wall
  float getRotationAngle() {
    PVector grad = e.gradient(this.tipX, this.tipY);  //The gradient vector of the ellipse at the collision point
    float alpha = getAngle(this.speedX, this.speedY, grad.x, grad.y);  //The angle between the ray's incoming velocity vector and the normal vector to the ellipse 
                                                                       //at the point of contact
    
    if( -this.speedX*grad.y + this.speedY*grad.x >= 0 )
      return PI-2*alpha; //rotate the ray by PI - 2*alpha radians counter-clockwise
      
    else
      return 2*alpha-PI;  //rotate clockwise
  }
  
  
  void rotateBy(float angle) {
    float s = sin(angle);
    float c = cos(angle);
    float speedXold = this.speedX;
    
    this.speedX = speedX*c - speedY*s;
    this.speedY = speedXold*s + speedY*c;
    resetReverseSpeed();
    
    this.baseX = this.tipX;  //The point of contact is now the new base of the ray. 
    this.baseY = this.tipY;
  }
  
  
  void drawRay(){
    float xScreenBase = getScreenX(this.baseX);
    float yScreenBase = getScreenY(this.baseY);
    
    float xScreenTip = getScreenX(this.tipX);
    float yScreenTip = getScreenY(this.tipY);
    
    line(xScreenBase, yScreenBase, xScreenTip, yScreenTip);
  }
  
  
  void drawParticle(){
    float xScreenTip = getScreenX(this.tipX);
    float yScreenTip = getScreenY(this.tipY);
    
    circle(xScreenTip, yScreenTip, 4);
  }
}
