class Frisbee {

  //FIELDS
  float r, xCenter, yCenter, x1, y1, x2, y2, theta, alpha, w;
  float phaseShift; 
  int k;
  Demo myDemo;  //which demo this Frisbee object is a part of
  
  
  //CONSTRUCTOR
  Frisbee( float alphaGiven, float wGiven, float phaseShiftGiven, int k, Demo d ) {
    this.alpha = alphaGiven;
    this.theta = alphaGiven + HALF_PI;
    this.w = wGiven;
    this.myDemo = d;
    
    if ( myDemo.flyingSpeed != 0 )
      this.phaseShift = phaseShiftGiven / myDemo.flyingSpeed;
      
    else
      this.phaseShift = 0;
      
    this.k = k;
    
    this.setPoints();
  }
  
  
  //METHODS
  void setPoints() {
    this.r =  myDemo.Rmin * cos(myDemo.flyingSpeed*(t-this.phaseShift));
    
    this.xCenter = xC + this.r*cos( this.alpha );
    this.yCenter = yC - this.r*sin( this.alpha );
    
    this.x1 = this.xCenter + myDemo.frisbeeLength * cos(this.theta);
    this.y1 = this.yCenter - myDemo.frisbeeLength * sin(this.theta);
    
    this.x2 = this.xCenter + myDemo.frisbeeLength * cos(this.theta + PI);
    this.y2 = this.yCenter - myDemo.frisbeeLength * sin(this.theta + PI);
  }
  
  
  void updatePosition() {
    this.theta -= this.w;
    this.setPoints();
  }
  
  
  void drawMe() {   
    stroke(frisbeeCol);
    strokeWeight(3);
    line( this.x1, this.y1, this.x2, this.y2 );
    strokeWeight(1);
  }
  
  
  void drawCentre() {   
    fill(255,0,0);
    noStroke();
    circle( this.xCenter, this.yCenter, myDemo.dotSize );
  }

  
  void drawBoundingCircle() {
    stroke(100,255,255);
    circle( this.xCenter, this.yCenter, 2 * myDemo.frisbeeLength );
  }
  
  
  void drawMeWithGreen1() {   
    strokeWeight(2);
    stroke(lineCol2);
    line(this.x1, this.y1, xC, yC);    stroke(frisbeeCol);
    strokeWeight(3);
    line(this.x1, this.y1, this.x2, this.y2);
   
    strokeWeight(1);
  }


  void drawMeWithGreen2() {   
    stroke(frisbeeCol);
    strokeWeight(3);
    line(this.x1, this.y1, this.x2, this.y2);
    strokeWeight(2);
    stroke(lineCol2);
    line(this.x2, this.y2, xC, yC);
    strokeWeight(1);
  }
  
  
  void drawMeWithDoubleGreen() {   
    stroke(frisbeeCol);
    strokeWeight(3);
    line(this.x1, this.y1, this.x2, this.y2);
    strokeWeight(1);
    stroke(lineCol2);
    line(this.x1, this.y1, xC, yC);
    line(this.x2, this.y2, xC, yC);
  }
}
