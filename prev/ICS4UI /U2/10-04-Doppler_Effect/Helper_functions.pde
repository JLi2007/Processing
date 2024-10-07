void releaseNewRing() {
  if (currIndex < n) {
    rings[currIndex] = new Ring(xPos, yPos, 0, ringSpeed);
    timeSinceLastRingRelease = 0.0;
    currIndex = (currIndex + 1) % n;
  }
}


void drawSource() {
  fill(255, 0, 0);
  noStroke();
  circle(xPos, yPos, 10);
}


void drawRings() {
  noFill();
  stroke(255, 0, 0);
  
  if( ringShape.equals("circle") ) {
    for (int i=0; i < currIndex; i++)
      if (rings[i].radius < maxRingSize) {
        rings[i].drawCircular();
        rings[i].grow();
      }
  }
  
  else if( ringShape.equals("square") ) {
    for (int i=0; i < currIndex; i++)
      if (rings[i].radius < maxRingSize) {
        rings[i].drawSquare();
        rings[i].grow();
      }
  }
}


void updateSourcePosition() {
  if ( sourceMotionMode.equals("linear") ) {
    xPos += xSpeed;
    yPos += ySpeed;
    xSpeed += xAcceleration;
  } 
  
  else if( ! sourceMotionMode.equals( "mouse" )) {
    float theta = realTime * frequency;

    if ( sourceMotionMode.equals("circular") ) {
      xPos = xCentre + amplitude*cos(theta);
      yPos = yCentre - amplitude*sin(theta);
    } 
    
    else if ( sourceMotionMode.equals("backandforth") ) {
      xPos = xCentre + amplitude*cos(theta);
    } 
    
    else if ( sourceMotionMode.equals("wave") ) {
      xSpeed = horizontalWaveSpeed;
      xPos += xSpeed;
      yPos = yCentre - amplitude*sin(theta);
    }
  }
  
  else {
    //mouse mode updates with mouse motion, not with the frame count
  }
}


void clearRings() {
  currIndex = 0;
  rings = new Ring[n];
}
