class Demo {
  //FIELDS
  String label;
  int n ;
  float ringSize = 1;             //As a percentage of the screen size taken up by the big circle
  float frisbeeSize;          //As a percentage of the size of the main ring
  float numRotations;           //How many times a frisbee rotates during one round trip across the circle
  float delayBetweenLaunches;   //0-10 recommended
  float flyingSpeed;
  boolean showCircles;
  boolean showRing;
  boolean showDots;  
  boolean switchToDotsHalfway;
  boolean showInnerRing;
  int greenAmount;
  int alternateSpinDirections;
  float numFrames;
  Frisbee[] frisbees;
  
  float Rmax, Rmin, Dmax, Dmin, r, W, w, t, D, frisbeeLength, dotSize;  
  
  //CONSTRUCTOR
  Demo(String l, int n, boolean showD, boolean showC, float nRot, float fSize, float ps, boolean showR, float numFr, float spd, boolean swToD, 
       int asd, boolean sir, int green) {
    
    //SETTING GIVEN FIELDS
    this.label = l;
    this.n = n;
    this.frisbees = new Frisbee[n];
    this.frisbeeSize = fSize;          //As a percentage of the size of the main ring
    this.numRotations = nRot;           //How many times a frisbee rotates during one round trip across the circle
    this.delayBetweenLaunches = ps;   //0-10 recommended
    this.flyingSpeed = spd;
    this.showCircles = showC;
    this.showRing = showR;
    this.showDots = showD;
    this.numFrames = numFr;
    this.switchToDotsHalfway = swToD;
    this.alternateSpinDirections = asd;
    this.showInnerRing = sir;
    this.greenAmount = green;
    
    //COMPUTED FIELDS
    this.Rmax = xC * ringSize;
    this.frisbeeLength = Rmax * this.frisbeeSize;
    this.Rmin = this.Rmax - this.frisbeeLength;
    this.Dmax = 2 * Rmax;
    this.Dmin = 2 * Rmin;
    this.dotSize = 0.01 * Dmax;
    this.w = deltaT * this.numRotations;
    
    //LOCAL VARIABLES
    float alpha = 0;
    float phaseShiftCurr = 0;
    float deltaAlpha = TWO_PI/n;
    float deltaPhaseShift = deltaAlpha * delayBetweenLaunches;
    
    //FILLING THE ARRAY OF FRISBEE OBJECTS USED IN THIS DEMO
    for( int i= 0; i < n; i++ ) {
      float wCurr = this.w * pow(this.alternateSpinDirections, i); 
      frisbees[i] = new Frisbee( alpha, wCurr, phaseShiftCurr, i, this );
      alpha += deltaAlpha;
      phaseShiftCurr += deltaPhaseShift;
    }
  }
  
  
  void drawScene() {
    stroke( frisbeeCol );
    
    if( this.greenAmount == 1 ) {
      Frisbee f0 = this.frisbees[0];
      
      if ( dist(xC, yC, f0.x1, f0.y1) < dist(xC, yC, f0.x2, f0.y2) )
        for( Frisbee f : frisbees ) 
          f.drawMeWithGreen2();
        
      else
        for( Frisbee f : frisbees ) 
          f.drawMeWithGreen2();
    }
      
    else if( this.greenAmount == 2 )
      for( Frisbee f : frisbees )
        f.drawMeWithDoubleGreen();
        
    else 
      for( Frisbee f : frisbees )
        f.drawMe();
    
    
    if ( this.showRing || (demoFrameCount >= 2*this.numFrames/3 && this.switchToDotsHalfway)) {
      stroke(255);
      circle(xC, yC, Dmax);
    }
    
    
    if ( this.showCircles || (demoFrameCount >= this.numFrames/3 && this.switchToDotsHalfway) )
      for( Frisbee f : frisbees ) 
        f.drawBoundingCircle();
      
      
    if ( this.showDots  ) 
      for( Frisbee f : frisbees ) 
        f.drawCentre(); 
    
    
   if( this.showInnerRing ) {
      Frisbee f = this.frisbees[0];
      
      float d1 = 2 * dist( xC, yC, f.x1, f.y1 );
      float d2 = 2 * dist( xC, yC, f.x2, f.y2 );
      float dMin = min(d1, d2);
      
      fill(90);
      stroke(255,255,0);
      strokeWeight(2);
      circle(xC, yC, dMin);  
      noFill();
      strokeWeight(1);
    }
  }
  
  
  void updatePositions() {
    for( Frisbee f : frisbees ) 
      f.updatePosition();
  }
}
