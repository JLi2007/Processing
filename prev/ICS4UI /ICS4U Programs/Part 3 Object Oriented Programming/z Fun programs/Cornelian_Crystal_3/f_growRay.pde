void growRay( Ray r ) {
  int iNext=0, jNext=0, theta2, theta3, dist;
  
  dist = setDistance( r );

  if ( r.theta == 0 ) {
    iNext = r.i;
    jNext = r.j + dist;
    
  } else if ( r.theta == 45 ) {
    iNext = r.i - dist;
    jNext = r.j + dist;
    
  } else if ( r.theta == 90 ) {
    iNext = r.i - dist;
    jNext = r.j;
   
  } else if ( r.theta == 135 ) {
    iNext = r.i - dist;
    jNext = r.j - dist;
    
  } else if ( r.theta == 180 ) {
    iNext = r.i;
    jNext = r.j - dist;
    
  } else if ( r.theta == 225 ) {
    iNext = r.i + dist;
    jNext = r.j - dist;
   
  } else if ( r.theta == 270 ) {
    iNext = r.i + dist;
    jNext = r.j;
    
  } else if ( r.theta == 315 ) {
    iNext = r.i + dist;
    jNext = r.j + dist;
   
  }
  stroke(0);

  try {
    Corner cStart = corners[r.i][r.j];
    Corner cEnd = corners[iNext][jNext];
    
    connect( cStart, cEnd );
    toFill.add( cStart );
    
    cEnd.visitCount++;

    theta2 = (r.theta - 45) % 360;
    theta3 = (r.theta + 45) % 360;
    if ( theta2 == -45 ) theta2 = 315;

    if( r.distance == 2 ) {
      toExpandNextGen.add( new Ray( iNext, jNext, theta2 ) );
      toExpandNextGen.add( new Ray( iNext, jNext, theta3 ) );
    }
 
  }
  catch(Exception e) {
  }

  toExpand.remove( toExpand.get(0) );
}
