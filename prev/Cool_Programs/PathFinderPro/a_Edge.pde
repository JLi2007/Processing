class Edge{
  Node n1, n2; //two nodes that make up this edge
  float dist;
  float w = 15; //width of  node
  float deltaX, deltaY; // slope of node (split up to avoid division by zero)
  float [][] corners = new float[5][2]; //coordinates of each corner of the edge
  boolean exists = true; // whether it has been blocked or not
  color col = og; //colour
  boolean inPath = false; //part of the shortest path or not
  
  Edge(Node node1, Node node2){
    this.n1 = node1;
    this.n2 = node2;
    this.dist = dist(n1.x, n1.y, n2.x, n2.y);
  }
  
  void updateDist(){
    this.dist = dist(n1.x, n1.y, n2.x, n2.y);
  }
  
  void drawEdge(){
    deltaX = (n2.x-n1.x)/dist;
    deltaY = (n2.y-n1.y)/dist;
    corners[0] = new float[] { n1.x + (-deltaY * w/2), n1.y + (deltaX * w/2) };
    corners[1] = new float[] { n1.x + (-deltaY * -w/2), n1.y + (deltaX * -w/2) };
    corners[2] = new float[] { n2.x + (-deltaY * -w/2), n2.y + (deltaX * -w/2) };
    corners[3] = new float[] { n2.x + (-deltaY * w/2), n2.y + (deltaX * w/2) };
    
    beginShape();
    fill(col);
    for(int i = 0; i < 4; i++){
      vertex(corners[i][0], corners[i][1]);
    }
    endShape();
    
    if(showDistance) displayDist();

  }
  
  boolean isClicked(){ //Checks to see if edge is clicked
    int i, j; boolean c = false;
    for (i = 0, j = 3; i < 4; j = i++) {
      //Draw a horizontal (finite) ray from (mouseX, mouseY)
      //Count how many edges it crosses
      //If the number of crossings is odd, point is inside the shape
 
      if ( ((corners[i][1]>mouseY) != (corners[j][1]>mouseY)) && (mouseX < (corners[j][0]-corners[i][0]) * (mouseY-corners[i][1]) / (corners[j][1]-corners[i][1]) + corners[i][0]) )
        c = !c;
    }
    return c;
  }
  
  void displayDist(){
    fill(0);
    textAlign(CENTER);
    if(exists) text(str(int(dist)), (n1.x + n2.x) / 2, (n1.y + n2.y) / 2);
  }
  
}
