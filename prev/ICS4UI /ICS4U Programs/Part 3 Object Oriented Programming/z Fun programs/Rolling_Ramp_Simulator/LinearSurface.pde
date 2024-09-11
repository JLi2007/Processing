class LinearSurface {
  int numPieces; 
  float[] xBreakPoints, yBreakPoints, slopes, yEndPoints;
  float[] angles, sinAngles, cosAngles;   //STORES THE ANGLES OF THE LINES, AS WELL AS THE SINES AND COSINES OF THOSE ANGLES. WE STORE THE LATTER TWO SO THAT WE DON'T HAVE TO KEEP RECOMPUTING THEM IN EVERY FRAME
  Vector[] surfaceVectors;
  color fillColour;
    
  LinearSurface(float[] xBP, float[] yBP, float[] slopes, color c) {
    this.numPieces = yBP.length;
    this.xBreakPoints = xBP;
    this.yBreakPoints = yBP;
    this.slopes = slopes;
    
    this.yEndPoints = new float[this.numPieces];
    this.angles = new float[this.numPieces];
    this.sinAngles = new float[this.numPieces];
    this.cosAngles = new float[this.numPieces];  
    this.surfaceVectors = new Vector[this.numPieces];
    
    
    for(int i=0; i < this.numPieces; i++){
      this.yEndPoints[i] = this.getYEnd( this.yBreakPoints[i], this.slopes[i], this.xBreakPoints[i], this.xBreakPoints[i+1]); 
      this.angles[i] = atan(this.slopes[i]);
      this.sinAngles[i] = sin(this.angles[i]);
      this.cosAngles[i] = cos(this.angles[i]);
      this.surfaceVectors[i] = new Vector(1, this.slopes[i]);
      println(i, degrees(angles[i]), cosAngles[i]);
    }
    
    this.fillColour = c;
  }
  
  
  float getY(int pieceNumber, float x) {
    float x1 = this.xBreakPoints[pieceNumber];
    float y1 = this.yBreakPoints[pieceNumber];
    float m = this.slopes[pieceNumber];
    
    return y1 + m*(x - x1);  //GOOD OLD GRADE 9 MATH
  }
  
  
  float getYEnd(float ys, float m, float x1, float x2) {
    return ys + m*(x2 - x1); //GOTTA KNOW YOUR GRADE 9 MATH
  }


  void drawMe() { //DRAWS THE RAMPS OF THE SURFACE
    stroke(this.fillColour);
    strokeWeight(2);
    float x1=0, y1=0, x2=0, y2=0;
    
    for(int i=0; i < this.numPieces; i++) {
      x1 = this.xBreakPoints[i];
      y1 = this.yBreakPoints[i];
      
      if( i > 0 ){
        line(x2, y2, x1, y1);
      }
      x2 = this.xBreakPoints[i+1];
      y2 = this.yEndPoints[i];
      line(x1, y1, x2, y2);
    }
    noStroke();
  }
}  
  
