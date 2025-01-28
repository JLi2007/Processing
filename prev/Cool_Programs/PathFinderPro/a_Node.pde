class Node{
  float x, y;
  float s = 20; //size of node
  color col = og;
  String label = "";
  float SD = 100000.0;
  Node prev;
  boolean vis = false;
  
  Node(float x, float y, String str){
    this.x = x;
    this.y = y;
    this.label = str;
  }
  
  
  boolean isClicked(){
    if(x-s <= mouseX && mouseX <= x+s){
      if(y-s <= mouseY && mouseY <= y+s){
        col = clicked;
        return true;
      }
    }
    return false;
  }
  
  void showNode(){
    fill(col);
    circle(x,y,2*s);
    fill(0);
    textFont(f);
    textAlign(CENTER);
    text(label,x,y);
    
  }
 
  
}
