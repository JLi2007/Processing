class Circle {
  //FIELDS
  float xCenter, yCenter, radius, diameter;
  color col;
  
  //CONSTRUCTOR 1 - TAKES 3 POINTS THAT THE CIRCLE SHOULD GO THROUGH
  Circle( PVector A, PVector B, PVector C, color col ) {
    this.col = col;
    
    float[] circleData = findCircleThruThreePoints(A, B, C);
    
    this.xCenter = circleData[0];
    this.yCenter = circleData[1];
    this.radius = circleData[2];
    this.diameter = 2 * circleData[2];
  }
  
  //CONSTRUCTOR 2 - TAKES A FIXED CENTER & RADIUS
  Circle( float xC, float yC, float r, color col){
    this.xCenter = xC;
    this.yCenter = yC;
    this.radius = r;
    this.diameter = 2*r;
    this.col = col;
  }
  
  
  //METHODS
  void drawMe(int strokeThickness ) {
    noFill();
    strokeWeight( strokeThickness ); 
    stroke(this.col);
    circle(this.xCenter, this.yCenter, this.diameter);
  }  
}
