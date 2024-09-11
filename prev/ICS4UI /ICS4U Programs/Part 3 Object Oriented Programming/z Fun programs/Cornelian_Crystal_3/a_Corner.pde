class Corner {
  int x, y;
  int i, j;
  int visitCount;
  boolean closed;
  ArrayList<Corner> connectedCorners;
  ArrayList<Edge> edgesOut, edgesIn;
  
  Corner(int x, int y, int i, int j) {
    this.x = x;
    this.y = y;
    this.i = i;
    this.j = j;
    this.visitCount = 0;
    this.closed = false;
    this.connectedCorners = new ArrayList<Corner>();
    this.edgesOut = new ArrayList<Edge>();
    this.edgesIn = new ArrayList<Edge>();
  }
  
  
  boolean isConnectedTo( Corner other ) {
    return this.connectedCorners.contains( other );
  }
  
  
  void disconnect() {
    this.edgesOut = new ArrayList<Edge>();
  }
  
  
  boolean isOnBorder() {
    return this.i==0 || this.i == n-1 || this.j==0 || this.j == n-1;
  }
  
  
  String info() {
    return this.i + "," + this.j + " out degree=" + this.edgesOut.size();
  }
  
  
  void printMe() {
    println(this.i + ",", this.j + "    ");
  }
  
  
  void paintMe(color col) {
    fill(col);
    circle(this.x, this.y, 10);
  }
}
