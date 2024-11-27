class Shape {
  PVector center;
  float amplitude, diameter;
  float squareSpeed;
  String type; 

  Shape( String type, float xC, float yC, float amp ) {
    this.type = type;
    this.center = new PVector( xC, yC ); 
    this.amplitude = amp; 
    this.diameter = 2*amp;
    this.squareSpeed = 2*amp/HALF_PI;
  }

  void drawMe() {
    noFill();
    stroke(128);
    strokeWeight(2);

    //CIRCLE
    if ( this.type.equals("circular") ) { 
      circle( this.center.x, this.center.y, this.diameter );
    } 
    
    //SQUARE
    else if ( this.type.equals("square") ) {
      square( this.center.x - this.amplitude, this.center.y - this.amplitude, this.diameter);
    } 
    
    //SINUSOIDAL 
    else if ( this.type.equals("sinusoidal") ) {
      float xLeft = this.center.x - this.amplitude;
      float xRight = this.center.x + this.amplitude;
      line(xLeft, this.center.y, xRight, this.center.y);
    } 
    
    //FIGURE 8, PRETZEL or PARABOLA
    else {
      PVector currPoint;
      float xPrev = 0, yPrev = 0;
      float x, y;

      for (float theta = 0; theta <= 2*PI+0.05; theta += 0.05 ) {
        currPoint = this.getPoint( theta );
        x = currPoint.x; y = currPoint.y;

        if (theta > 0) 
          line( x, y, xPrev, yPrev);

        xPrev = x;
        yPrev = y;
      }
    }
  }

  //RETURNS A POINT ALONG THE SHAPE AT A GIVEN ANGLE THETA.
  //USED FOR DRAWING THE PRETZEL-LIKE SHAPES, AND ALSO FOR PLACING THE MARKER AT THE RIGHT PLACE ALONG THE SHAPE
  PVector getPoint( float theta ) { 
    float x=0, y=0;
    float A = this.amplitude;

    // cos theta and sin theta are all in the range -1 to 1
    if ( this.type.equals("sinusoidal") ) {
      x = this.center.x + A * cos(theta);
      y = this.center.y;
    } 
    
    // i was lowk tweaking cus i forgot unit circle theory [x^2 + y^2 = 1 on center (0,0) circle]
    else if ( this.type.equals("circular") ) { 
      x = this.center.x + A * cos( theta);
      y = this.center.y + A * sin( theta);
    } 
    
    else if ( this.type.equals("figure8") ) { 
      x = this.center.x + A * sin( 2 * theta);
      y = this.center.y + A * sin( theta);
    } 
    
    else if ( this.type.equals("pretzel") ) { 
      x = this.center.x + A * sin( 4 * theta); 
      y = this.center.y + A * sin( 3 * theta);
    } 
    
    else if ( this.type.equals("parabola") ) { 
      x = this.center.x + A * cos( theta );
      y = this.center.y + A * cos( 2*theta );
    } 
    
    else if ( this.type.equals("square") ) { 
      float t2 = theta % TWO_PI;
      float t3 = theta % HALF_PI;  //MEASURES PROGRESS ALONG THE CURRENT LINE THAT THE MARKER IS TRAVERSING
      float progressAlongEdge = this.squareSpeed * t3;

      // x= and y= brings the next pos calculation into a CORNER of the square, then progressAlongEdge adds/subs 
      if ( t2 <= HALF_PI ) {   //1ST EDGE OF THE SQUARE
        x = this.center.x + A;
        y = this.center.y + A - progressAlongEdge;
      }
      
      else if ( t2 <= PI ){   //2ND EDGE  
        x = this.center.x + A - progressAlongEdge;
        y = this.center.y - A;
      } 
      
      else if ( t2 <= 3*HALF_PI ) {  //3RD EDGE OF THE SQUARE
        x = this.center.x - A ;
        y = this.center.y - A + progressAlongEdge;
      } 
      
      else if ( t2 <= TWO_PI ) {  //4TH EDGE OF THE SQUARE
        x = this.center.x - A + progressAlongEdge;
        y = this.center.y + A;
      }
    } 
    
    return new PVector(x, y);
  }
}
