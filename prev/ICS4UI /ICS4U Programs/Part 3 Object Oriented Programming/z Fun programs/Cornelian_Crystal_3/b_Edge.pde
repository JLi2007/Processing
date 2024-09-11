class Edge {
  Corner start, end;
  String info;
  
  Edge(Corner s, Corner e) {
    this.start = s;
    this.end = e;
    this.info = "(" + s.i + "," + s.j + ")->(" + e.i + "," + e.j + ")";
  }
  
    
  boolean isOnBoundary() {
    int i1 = this.start.i;
    int j1 = this.start.j;
    int i2 = this.end.i;
    int j2 = this.end.j;    
    
    if( i1 <=1 && i2 <= 1 || j1 <=1  && j2 <=1 || i1 >= n-2 && i2 >= n-2 || j1 >= n-2 && j2 >= n-2 )
      return true;
      
    else
      return false;
  }
}
