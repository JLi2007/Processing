void fillNextPolygon() {
  if ( !toFill.isEmpty() ) {
    Corner cOrigin = toFill.get(0);

    color col = getPolyColour(cOrigin);

    while ( cOrigin.edgesOut.size() > 0  ) {  
      Polygon p = new Polygon(col);
      Corner c1, c2;

      c1 = cOrigin;
      c2 = null;

      Edge prevEdge = null;
      int pathCount = 0;

      p.addFirstVertex(c1, color(150, 0, 0)); 

      int cycleStart = -1;
      println();
      
      while ( pathCount == 0 || cycleStart == -1  ) {
        print(pathCount + " ");
        Edge e = getNextCounterclockwiseEdge( c1, prevEdge );

        if ( e != null ) {
          c2 = e.end;
          p.addVertex(c2, e, color(255)); 
          c1 = c2;
          prevEdge = e;
          pathCount++;
          
          if( pathCount > maxPerimeter )
            break;

          if ( pathCount >= 3 ) {
            cycleStart = p.findCycle();
          }
        } 
        
        else {
         // removeFromQueue();
          break;
        }
      }

      if ( cycleStart != -1 ) {
        println(cycleStart);
        
        if ( cycleStart > 0 ) { 
          println("CYCLE START", cycleStart);
          p.col = color(0);
          p.vertices.get(0).paintMe(color(255, 0, 0));
          p.vertices.get(cycleStart).paintMe(color(255, 255, 0));
        }
        p.paint( cycleStart );
        p.removeEdges();
      } 
      
      else {
        println("Bad poly");
        //phase = "tracing";
        //tracedPoly = p;
        //frameRate(2);
        removeFromQueue();
      }
    }
    removeFromQueue();
  } 
  
  else {
    println("Finished painting");
    noLoop();
  }
}


Edge getNextCounterclockwiseEdge(Corner c, Edge prevEdge) {

  if ( c.edgesOut.size() == 0 )
    return null;

  else if ( prevEdge == null || c.edgesOut.size() == 1 ) {
    return c.edgesOut.get(0);
  } else {
    int indexOfNextEdge;
    int indexOfPrevEdge = c.edgesIn.indexOf( prevEdge );

    if (indexOfPrevEdge > 0) 
      indexOfNextEdge = indexOfPrevEdge - 1;  

    else 
    indexOfNextEdge = c.edgesOut.size()-1;

    return c.edgesOut.get(indexOfNextEdge);
  }
}
