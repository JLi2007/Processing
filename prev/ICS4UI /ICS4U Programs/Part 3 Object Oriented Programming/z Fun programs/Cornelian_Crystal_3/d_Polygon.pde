class Polygon {
  ArrayList<Corner> vertices;
  ArrayList<Edge> edges;
  color col;
  
  Polygon(color col) {
    this.vertices = new ArrayList<Corner>();
    this.edges = new ArrayList<Edge>();
    this.col = col;
  }
  
  void addVertex(Corner c, Edge from, color col) {
    this.vertices.add(c);
    this.edges.add(from);
    
  }
  
  
  void addFirstVertex(Corner c, color col) {
     this.vertices.add(c);
  }
  
  
  int findCycle() {
    int iLast = this.vertices.size()-1;
    Corner lastCorner = this.vertices.get(iLast);
    int i = iLast - 1;
    
    while( i >= 0  ) {
      Corner curr = this.vertices.get(i);
      if ( curr.equals(lastCorner) ) {
        return i;
      }
      else {
        i--; 
      }
    }
    
    return -1;
  }
  
  
  void paint(int iStart) {
    fill(this.col);
    
    beginShape();
    
    for( int i = iStart; i < this.vertices.size(); i++ ) {
      Corner c = this.vertices.get(i);
      vertex( c.x, c.y);
    }
    
    endShape(CLOSE);
  }
   
   
  void removeEdges() {
    for( int i=0; i < this.edges.size(); i++) {
      Edge e = this.edges.get(i);
      Corner c = this.vertices.get(i);
      c.edgesOut.remove(e);
    }
  }
  
  
  void trace() {
    color col = color(random(0,255),random(0,255),random(0,255)); 
    strokeWeight(5);
    Edge first = this.edges.get(0);
    fill(255);
    circle( first.start.x, first.start.y, 15);
    //for( int i=0; i < this.edges.size(); i++) {
    //  Edge e = this.edges.get(i);
    //  stroke(col);
    //  line(e.start.x, e.start.y, e.end.x, e.end.y);
    //}
    
    strokeWeight(1);
  }
  
  
}
