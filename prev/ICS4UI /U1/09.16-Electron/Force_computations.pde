//COMPUTES THE NET FORCE ON EACH ELECTRON BY ADDING UP THE INDIVIDUAL FORCES BETWEEN EACH PAIR
void calculateForcesBetweenElectrons() {
  for( int i = 0; i < n; i++ ) {
    PVector p = positions[i];  //position of electron 1
    
    for( int j = i+1; j < n; j++ ) {  //What values does j take on?
      PVector q = positions[j];  //position of electron 2
      
      PVector ForceOnPfromQ = computeForceOnPfromQ( p, q );           // Force on p from q
      PVector accelerationFromQ = PVector.div(ForceOnPfromQ, electronMass );  // a = F/m  (Newton's 2nd law)
      accelerations[i].add( accelerationFromQ );
      
      PVector ForceOnQfromP = ForceOnPfromQ.mult( -1 );               // Force on q from p via Newton's 3rd law
      PVector accelerationFromP = PVector.div(ForceOnQfromP, electronMass );  // a = F/m  
      accelerations[j].add( accelerationFromP ); 
    }
  }
}

//COMPUTES THE FORCE ON ELECTRON p FROM ELECTRON q USING COULOUMB'S LAW: F = k q1 q2 / d^2
PVector computeForceOnPfromQ( PVector p, PVector q ) {
  PVector pMinusQ = PVector.sub(p, q); //The vector p-q.  It points from electron p to electron q
  float distPtoQ = pMinusQ.mag();      //Distance between electrons p and q, which is just the magnitude of vector p-q
  pMinusQ.normalize();                 //Making a unit vector so we can scale it by the magnitude of the electrical force, computed below
  
  float magnitude = k * electronCharge * electronCharge / (pow(distPtoQ, 2)+5); //Couloumb's law F = k q1 q2 / d^2. The +5 is to prevent division by 0 in case the electrons end up "on top of each other"
  PVector forceOnPfromQ = pMinusQ.mult( magnitude );     //Scaling the unit vector by the magnitude of the force

  return forceOnPfromQ; 
}


//ADDS UP THE REPELLING FORCES OF ALL 4 WALLS ON EACH ELECTRON
void calculateWallForcesOnElectrons() {
  float distFromWall, forceMagnitude;
  PVector forceFromWall, accelerationFromWall;
  
  if( boundaryShape.equals("ring") ) {
    
    for( int i = 0; i < n; i++ ) {
      PVector inwardRadialVector = PVector.sub(center, positions[i]);         //Points from electron i to the center of the circle
      distFromWall = boundaryRadius - inwardRadialVector.mag();
      forceMagnitude = k * wallCharge * electronCharge /pow(distFromWall, 2); //

      inwardRadialVector.normalize();
      forceFromWall = PVector.mult( inwardRadialVector, forceMagnitude );
      accelerationFromWall = forceFromWall.div( electronMass );
      
      accelerations[i].add( accelerationFromWall );
    }
  }
  
  if( boundaryShape.equals("square") ) {
    
    for( int i = 0; i < n; i++ ) {
      
      //LEFT WALL
      distFromWall = positions[i].x - xWallLeft;
      forceMagnitude = k * wallCharge * electronCharge / pow(distFromWall, 2);
      forceFromWall = new PVector( forceMagnitude, 0 );
      accelerationFromWall = forceFromWall.div( electronMass );
      
      accelerations[i].add( accelerationFromWall );
      
      //RIGHT WALL
      distFromWall = xWallRight - positions[i].x;
      forceMagnitude = k * wallCharge * electronCharge / pow(distFromWall, 2);
      forceFromWall = new PVector( -forceMagnitude, 0 );                       //
      accelerationFromWall = forceFromWall.div( electronMass );
      
      accelerations[i].add( accelerationFromWall );
      
      //TOP WALL
      distFromWall = positions[i].y - yWallTop;
      forceMagnitude = k * wallCharge * electronCharge / pow(distFromWall, 2);
      forceFromWall = new PVector(0, forceMagnitude );                              //downward force
      accelerationFromWall = forceFromWall.div( electronMass );
      
      accelerations[i].add( accelerationFromWall );
      
      //BOTTOM WALL
      distFromWall = yWallBottom - positions[i].y;
      forceMagnitude = k * wallCharge * electronCharge / pow(distFromWall, 2);
      forceFromWall = new PVector( 0, -forceMagnitude );
      accelerationFromWall = forceFromWall.div( electronMass );
      
      accelerations[i].add( accelerationFromWall );
    }
  }
}
  
