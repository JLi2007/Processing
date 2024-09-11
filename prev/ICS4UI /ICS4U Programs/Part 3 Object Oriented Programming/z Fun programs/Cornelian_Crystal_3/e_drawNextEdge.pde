void drawNextGenerationOfEdges() {
  while ( !toExpand.isEmpty() ) {
    Ray nextRay = toExpand.get(0);

    //Find the next ray in the list whose corner has visit-count less than 2
    while ( !toExpand.isEmpty() && corners[nextRay.i][nextRay.j].visitCount >= 2  ) {
      toExpand.remove( toExpand.get(0) );
      
      if( !toExpand.isEmpty()) 
        nextRay = toExpand.get(0);
    }

    if ( !toExpand.isEmpty() )
      growRay( nextRay );
  }
    
  if ( toExpandNextGen.isEmpty() ) {
    phase = "filling";
    toFill.add( corners[iMid][jMid] );
    frameRate(fpsPolygons);
  }
  
  else {
     toExpand = toExpandNextGen;
     toExpandNextGen = new ArrayList<Ray>();
  }
}
