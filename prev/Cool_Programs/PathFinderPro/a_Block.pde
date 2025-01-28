class Block{
  float x, y;
  Edge edge;
  
  Block(Edge e){
    this.edge =  e;
  }
  
  void showBlock(){
    imageMode(CENTER);
    x = (edge.n1.x + edge.n2.x)/2;
    y = (edge.n1.y + edge.n2.y)/2;
    image(cone,x,y);
  }
}
