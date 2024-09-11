ArrayList<Vertex> vList;
ArrayList<Polygon> pList;
boolean start = true;
Vertex v1;
String mode = "drawing"; //"moving" or "drawing"

void setup() {
  size(600, 500);
  background(255);
  vList = new ArrayList<Vertex>();
  pList = new ArrayList<Polygon>();
}


void draw() {
  for (Polygon p: pList ) {
    p.drawMe();
  }
}


void mouseClicked() {
  for( Polygon p : pList ){
    if (p.contains( mouseX, mouseY )) {
      println("Inside a polygon!");
      mode = "moving";
      p.selected = true;
      p.drawMe();
    }
    else
      println("Not inside");
  }
  
  
  if( mode.equals( "drawing") ) {
    if( start ) {
      start = false;
      v1 = new Vertex(mouseX, mouseY);
    }
    
    if( vList.size() >= 3 ) {
      if (dist(mouseX, mouseY, v1.x, v1.y) < 15) {
        Polygon p = new Polygon(vList, color(0,0,255));
        pList.add( p );
        redraw();
        start = true;
        vList = new ArrayList<Vertex>();
      }
      
      else {
        fill(255,0,0);
        vList.add( new Vertex(mouseX, mouseY));
        circle(mouseX, mouseY, 5);
      }
    }
    
    else {
      vList.add( new Vertex(mouseX, mouseY));
      fill(255,0,0);
      circle(mouseX, mouseY, 5);
    }
  }
}
