class Wheel {
  LinearSurface surface;
  float radius, diameter;
  int dotSize;
  float angularDisplacement, angularSpeed, angularAcceleration, angleOpposite;
  float xC, yC;
  Vector velocity;
  float xDot, yDot, xDotOpposite, yDotOpposite;
  ArrayList<Float> dotHistoryX, dotHistoryY, dotHistoryX2, dotHistoryY2, dotHistoryXC, dotHistoryYC;
  color wheelColour, dotColour, dotColourOpposite;
  int pieceNum; //STARTS AT 0 WHEN ON THE 1ST SURFACE PIECE
  boolean inAir;
 
  Wheel(LinearSurface s, float r, float xStart, color wc, color c1, color c2) {
    //PARAMETERS
    this.surface = s;
    this.radius = r;
    this.angularSpeed = 0;
    this.xC = xStart;
    this.dotColour = c1;
    this.dotColourOpposite = c2;
    
    //CALCULATED AND PRE-SET VALUES    
    this.pieceNum = getpieceNum( xStart );
    this.yC = this.surface.getY( this.pieceNum, xStart ) - this.radius;
    this.angularDisplacement = 3*PI/2;
    this.angleOpposite = this.angularDisplacement + PI;
    this.angularAcceleration = getAngularAcceleration();
    this.dotSize = int(0.10*this.radius);
    this.diameter = 2*this.radius;
    this.velocity = new Vector(0, 0);
    this.inAir = false;
    
    this.dotHistoryX = new ArrayList<Float>();   this.dotHistoryY = new ArrayList<Float>();
    this.dotHistoryX2 = new ArrayList<Float>();  this.dotHistoryY2 = new ArrayList<Float>();
    this.dotHistoryXC = new ArrayList<Float>();  this.dotHistoryYC = new ArrayList<Float>();
    
    this.calculateDotPositions();
    this.wheelColour = wc;
  }
  
  
  void drawMe() {
    //DIAGNOSTICS
    String msg0 = "angSpeed=" + this.angularSpeed;
    String msg1 = "angAcc=" + this.angularAcceleration;
    String msg2 = "xSpeed=" + this.velocity.xComponent;
    String msg3 = "ySpeed=" + this.velocity.yComponent;
    String msg4 = "Dist to cliff=" + (-this.xC-this.radius + this.surface.xBreakPoints[this.pieceNum+1]); 
    //text(msg0, 200,600);
    //text(msg4, 200,650);
    //text(msg2, 200,700);
    //text(msg3, 200,750);
    
    //SPOKE TRAIL
    if( showSpokePath ) {
      stroke(0);
      strokeWeight(1);
      for( int i=0; i < dotHistoryX.size(); i++ ) {               
        line(dotHistoryX.get(i), dotHistoryY.get(i), dotHistoryX2.get(i), dotHistoryY2.get(i));        
      }
      noStroke();
    }
    
    //DOT TRAIL
    if( showCycloidPath1 ) {
      fill( dotColour );
      for( int i=0; i < dotHistoryX.size(); i++ ) {
        ellipse( dotHistoryX.get(i), dotHistoryY.get(i), dotSize, dotSize );
      }
    }
        
    if( showCycloidPath2 ) {
      fill(dotColourOpposite);
      for( int i=0; i < dotHistoryX.size(); i++ ) {
        ellipse( dotHistoryX2.get(i), dotHistoryY2.get(i), dotSize, dotSize );
      }
    }
    
    //WHEEL
    fill( this.wheelColour ); 
    ellipse(this.xC, this.yC, this.diameter, this.diameter);
    
    //SPOKE IN CURRENT FRAME
    stroke(0);
    strokeWeight(1);
    line(xDot, yDot, xDotOpposite, yDotOpposite); 
    noStroke();
        
    //AXLE
    fill(0,255,0);
    ellipse(this.xC, this.yC, 10,10);
    
    //DOTS IN CURRENT FRAME
    fill( dotColour );
    ellipse( xDot, yDot, dotSize, dotSize );
    ellipse( xDotOpposite, yDotOpposite, dotSize, dotSize );
  }
  
  
  void updateValues() {
      if ( this.hasJustGoneOverCliff() ) { 
        this.pieceNum++;
                
        if ( this.pieceNum >= this.surface.numPieces  ) { //IF THE WHEEL HAS PASSED THE END OF THE LAST SURFACE PIECE...
          this.inAir = true;
          this.pieceNum--;
        }
          
        else { //IF THERE'S AT LEAST ONE MORE SURFACE PIECE AHEAD OF THE WHEEL...
          if ( this.yC + this.radius < this.surface.yBreakPoints[ this.pieceNum ] ) {  //IF THE NEXT SURFACE IS A DROP-OFF AND NOT JUST A SLOPE CHANGE...
            this.inAir = true;
          }
          
          else {
            this.inAir = false;
          }
        }
      }
      
      else { //IF xC IS BETWEEN BREAK POINTS...
        float ySurface = this.surface.getY(this.pieceNum, this.xC);
        float cos = this.surface.cosAngles[this.pieceNum];
        
        if ( this.yC + this.radius/cos >= ySurface ) {  //IF THE WHEEL IS IN CONTACT WITH THE SURFACE  
            
            if( this.inAir ) { //IF WE JUST LANDED...
              this.adjustAfterLanding( ySurface ); //...THEN WE ONLY RETAIN THE VELOCITY PROJECTED ONTO THE SURFACE VECTOR; THE REST IS LOST TO IMPACT FRICTION
              this.inAir = false;
            }
            
            this.inAir = false;
        }
          
        else {
            this.inAir = true;
        }
      }
      
      this.angularDisplacement -= this.angularSpeed;  //THE ANGLE OF THE WHEEL DECREASES AS IT ROLLS TO THE RIGHT
      this.angleOpposite = this.angularDisplacement + PI;     
      this.updateCenterPosWithVelocity();
      this.calculateDotPositions();
          
      this.angularSpeed += this.angularAcceleration;
      
      this.velocity.setComponents( getSpeedX(), getSpeedY() );
      this.angularAcceleration = getAngularAcceleration();      
  }
  
  
  boolean hasJustGoneOverCliff() {
    LinearSurface s = this.surface;
    int n = this.pieceNum;
    float xC = this.xC, yC = this.yC;
    float xEdge = s.xBreakPoints[n + 1];
    float yEdge = s.yEndPoints[n];
    
    if (xC - this.radius * s.sinAngles[n] > xEdge) {
      if (dist(xC, yC, xEdge, yEdge) > this.radius)
        return true;
    }
    
    return false;
  }
  
  
  void updateCenterPosWithVelocity() {
    float xCnext = this.xC + this.velocity.xComponent;
    float yCnext = this.yC + this.velocity.yComponent;
    int n = this.pieceNum;
    LinearSurface s = this.surface;
    
    if ( this.velocity.xComponent < 0 && xCnext - this.radius  < this.surface.xBreakPoints[n] ) { //IF WE'RE ROLLING INTO A CLIFF TO THE LEFT...
        println("AHHHHHH!"); //USED FOR DEBUGGING
        this.xC = this.surface.xBreakPoints[n] + this.radius;
        this.yC = this.surface.getY(n, this.xC) - this.radius*tan(this.surface.angles[n]);
        stopAnimation();
    }
    
    else if ( xCnext + this.radius  > this.surface.xBreakPoints[n+1] ) { //IF WE'RE PASSING A CLIFF POINT...
        if (n < s.numPieces - 1) { //IF THERE ARE PIECES AHEAD OF US...
        
          if (  s.yBreakPoints[n+1] + this.radius/5 < s.yEndPoints[n]) { //AND IF WE'RE ROLLING INTO A VERTICAL WALL TO THE RIGHT...
            
             
            if( s.slopes[n] >= 0) {  //IF WE'RE ROLLING DOWN INTO THE CORNER...
              print("Ug");
              this.xC = this.surface.xBreakPoints[n+1] - this.radius;
              this.yC = this.surface.getY(n, this.xC) + this.radius*tan(this.surface.angles[n]);
              stopAnimation();
            }
            
            else {  //IF WE'RE ROLLING UP TOWARDS THE WALL, THEN STOP ROLLING AT THE WALL AND LET GRAVITY PULL US BACK DOWN THE HILL
              this.angularSpeed = 0;
              this.velocity = new Vector(0,0);
            }
          }
          
          else { //BUT IF WE'RE NOT ROLLING INTO A WALL, THEN DO THE NORMAL INCREMENTS.
            this.xC = xCnext;
            this.yC = yCnext;
          }
        
        }
        
        else { //BUT IF THIS IS THE LAST PIECE, THEN DO THE NORMAL INCREMENTS
          this.xC = xCnext;
          this.yC = yCnext;
        }
    }
    
    else { //IF THERE ARE NO CLIFFS TO WORRY ABOUT...
     this.xC = xCnext;
     this.yC = yCnext;
    }
  }
  
  

  float getSpeedX() { //THE X-SPEED OF THE CENTER OF THE WHEEL
    if( this.inAir )
      return this.velocity.xComponent;  //BY SIMPLE INERTIA
    
    else {
      float sine = this.surface.sinAngles[ this.pieceNum ];
      float cosine = this.surface.cosAngles[ this.pieceNum ];
      return this.velocity.xComponent + 2*g*sine*cosine; //A FORMULA DERIVED FROM THE MECHANICS OF ROLLING ON A SURFACE
    }
  }
  
  
  float getSpeedY() { //THE Y-SPEED OF THE CENTER OF THE WHEEL
    if( this.inAir ) 
      return this.velocity.yComponent + g;  //ACCELERATING BY g IN EACH FRAME
        
    else { 
      float sine = this.surface.sinAngles[ this.pieceNum ];
      return this.velocity.yComponent + 2*g*sine*sine;  //A FORMULA FROM SIMPLE PHYSICS
    }
  }
  
  
  void adjustAfterLanding( float ySurface ) {
    //ADJUST CENTER TO BE FLUSH WITH SURFACE
    float cosine = this.surface.cosAngles[ this.pieceNum ]; 
    this.yC = ySurface - this.radius/cosine;
    
    //ADJUST SPEED AFTER IMPACT WITH THE SURFACE SO THAT THE COMPONENT OF THE VELOCITY NORMAL TO THE SURFACE IS LOST (DUE TO INELASTICITY)
    Vector s = this.surface.surfaceVectors[this.pieceNum];
    Vector v = this.velocity;
    float newSpeed = s.dotProduct( v ) / s.squaredMagnitude;
    this.velocity = s.scalarMultiply( newSpeed );
    
    //ADJUST ANGULAR SPEED TO BE CONSISTENT WITH THE SPEED CHANGE
    this.angularSpeed = newSpeed/this.radius;
  }
  
  
  float getAngularAcceleration() {
    if( this.inAir )
      return 0;
      
    else {
      float sine = this.surface.sinAngles[ this.pieceNum ];
      return 2 * g * sine/this.radius; //A FORMULA FROM SIMPLE PHYSICS
    }
  }
  
  
  int getpieceNum(float x) {
    int pieceNum = 0;
    
    while (x > this.surface.xBreakPoints[pieceNum+1]) {
      pieceNum++;
    }
    
    return pieceNum;    
  }
  
   
  void calculateDotPositions() {
      this.xDot = this.xC + this.radius * cos( this.angularDisplacement );
      this.yDot = this.yC - this.radius * sin( this.angularDisplacement );
      
      this.xDotOpposite = this.xC + this.radius * cos( this.angleOpposite );
      this.yDotOpposite = this.yC - this.radius * sin( this.angleOpposite );   
      
      this.dotHistoryX.add(xDot);
      this.dotHistoryY.add(yDot);
      this.dotHistoryX2.add(xDotOpposite);
      this.dotHistoryY2.add(yDotOpposite);
      this.dotHistoryXC.add(xC);
      this.dotHistoryYC.add(yC);
  }
}
