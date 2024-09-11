void addNeighboursToQueue( Corner c ) {
  for( Corner neighbour : c.connectedCorners ) {
    if( neighbour.edgesOut.size() > 0 ) {
      toFill.add( neighbour );
      //println("Adding neighbour", neighbour.i, neighbour.j);
    }
  }
}


void removeFromQueue() {
  if( !toFill.isEmpty() ) {
    Corner curr = toFill.get(0);
    toFill.remove( curr );
    curr.disconnect();    
  }
}


color getPolyColour( Corner c ) {
  if( colourMode.equals( "distance" ) ) {
    int distance = round( dist(c.i, c.j, iMid, jMid) );//(abs(c.i - iMid) + abs(c.j - jMid))/2;
    return colours[ distance % numColours ];
  }
  
  else if( colourMode.equals( "random" ) ) {
    return color(random(50,255), random(50,255), random(50,255));
  }
  
  else
    return color(0);
}


void initializeGrid() {
  int y = pad;
  
  for(int i=0; i<n; i++) {
    int x = pad;
    
    for(int j=0; j<n; j++) {
      corners[i][j] = new Corner(x, y, i, j);
      x += cellSize;
    }
    y += cellSize;
  }
}


int setDistance( Ray r ) {  //Returns either 1 or 2
  int dist = 2;
  
  if( r.theta == 45 ) {
    try {
      if( corners[r.i-2][r.j].isConnectedTo( corners[r.i][r.j+2]) ) 
        dist = 1;
    }
    catch( Exception e ) {}
  }
  
  else if( r.theta == 135 ) {
    try {
      if( corners[r.i-2][r.j].isConnectedTo( corners[r.i][r.j-2]) )
        dist = 1;
    }
    catch( Exception e ) {}
  }
  
  else if( r.theta == 225 ) {
    try {
      if( corners[r.i+2][r.j].isConnectedTo( corners[r.i][r.j-2]) )
        dist = 1;
    }
    catch( Exception e ) {}
  }
  
  else if( r.theta == 315 )  {
    try {
      if( corners[r.i+2][r.j].isConnectedTo( corners[r.i][r.j+2]) )
        dist = 1;
    }
    catch( Exception e ) {}
  }

  else
    dist = 2;
    
  r.distance = dist;
    
  return dist;
}


void connect( Corner c1, Corner c2 ) { 
  line( c1.x, c1.y, c2.x, c2.y );
   
  c1.connectedCorners.add( c2 );
  c2.connectedCorners.add( c1 ); 
  
  Edge e12 = new Edge(c1, c2);
  Edge e21 = new Edge(c2, c1);
  
  c1.edgesOut.add( e12 );
  c1.edgesIn.add( e21 );
  c2.edgesOut.add( e21 );
  c2.edgesIn.add( e12 );
}


void mouseClicked() {
  if( running )
    noLoop();
    
  else
    loop();
    
  running = !running;
}
