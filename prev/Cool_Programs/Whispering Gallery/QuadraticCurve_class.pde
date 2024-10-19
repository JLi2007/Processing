class QuadraticCurve {
  float a, b;                      //The equation of an ellipse is x^2/a^2 + y^2/b^2 = 1.  If a == b, then the ellipse is just a circle with radius b
  float c;                         //Focal length of the ellipse
  float aSq, bSq, invaSq, invbSq;  //Precomputed constants that come in handy in the formulas below
  float f1x, f1y, f2x, f2y;        //Coordinates of the foci
  
  
  QuadraticCurve(float a, float b){
    this.a = a;
    this.b = b;
    this.aSq = a*a;
    this.bSq = b*b;
    this.invaSq = 2/aSq;
    this.invbSq = 2/bSq;
    setFoci();
  }
  
  
  void setFoci() {
    if(a >= b) {
        this.c = sqrt(aSq - bSq);
        this.f1x = -this.c;
        this.f1y = 0;
        this.f2x = this.c;
        this.f2y = 0;
    }
      
    else {
        this.c = sqrt(bSq - aSq);
        this.f1x = 0;
        this.f1y = -this.c;
        this.f2x = 0;
        this.f2y = this.c;
    }
  }
  
  
  //Used for determining if the location of a red ball at (x,y) is inside or outside the ellipse.
  //Returns negative --> (x,y) is inside the ellipse   
  //Returns positive --> (x, y) is outside the ellipse    
  //Returns zero -->     (x, y) is on the ellipse
  float eval(float x, float y) {
    return x*x/aSq + y*y/bSq - 1; 
  }

  
  //Returns the slope of the normal vector to the ellipse at point (x, y)
  PVector gradient(float x, float y) {
    float fx = x * invaSq;  //fx = x/a^2
    float fy = y * invbSq;  //fy = y/b^2
    return new PVector(fx, fy);
  }
  
  
  void drawMe(){
    ellipse(getScreenX(0),getScreenY(0), 2*a, 2*b); //Drawing the main ellipse
    fill(255,0,0);
    ellipse(getScreenX(f1x), getScreenY(f1y), 10, 10);  //Drawing the two foci as red dots
    ellipse(getScreenX(f2x), getScreenY(f2y), 10, 10);
  }
}
