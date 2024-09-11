class Polygon {
  Vertex[] vertices;
  PVector[] sides;
  PVector displacement;
  boolean selected;
  int xMin, xMax, yMin, yMax;
  int n;
  color colour;
  
  Polygon(ArrayList<Vertex> vertexList, color c) {
    this.n = vertexList.size();
    this.vertices = vertexList.toArray( new Vertex[n] );
    this.colour = c;
    
    this.selected = false;
    this.displacement = new PVector(0,0);
    this.sides = new PVector[n];
    
    for(int i=0; i < n; i++) {  
      int nextI = (i+1) % n;
      Vertex v = this.vertices[i];
      Vertex vNext = this.vertices[nextI];
      int dx = vNext.x - v.x;
      int dy = vNext.y - v.y;
      this.sides[i] = new PVector(dx, dy);
    }
  }
  
  
  boolean contains(int a, int b) {
    for( int i=0; i < n; i++) {
      PVector u = new PVector( a - this.vertices[i].x, b - this.vertices[i].y );
      PVector uNorm = new PVector(u.y, -u.x);
      //println("Mouse", a, b);
      //println("v1x, v1y", this.vertices[i].x, this.vertices[i].y);
      //println("v2x, v2y", this.vertices[i+1].x, this.vertices[i+1].y);
      //println("s = ", sides[i].x, sides[i].y);
      //println("u = ", u.x, u.y);
      //println("uNorm = ", uNorm.x, uNorm.y);
      //println("u * uNorm = ", sides[i].dot( uNorm ));
      
      if( sides[i].dot( uNorm ) <= 0 ) {
        println("Not inside", i);
        return false; 
      }
    }
    return true;
  }
  
  void move(PVector d) {
    for(Vertex v: vertices) {
      v.x += d.x;
      v.y += d.y;
    }
  }
  
  
  void drawMe() {
    if( this.selected ) {
      strokeWeight(5);
      fill( color(120,120,0) );
    }
      
    else {
      strokeWeight(2);
      fill( this.colour );
    }
    
    beginShape();
    for (Vertex v: vertices) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
}
