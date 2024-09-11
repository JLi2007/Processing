String request = "Draw a blue circle at center (0, 225) with diameter 190";
//user is limited to the colors "red", "blue", "green", or "black"

float xC, yC, d;
String col;

void setup() {
  size(600, 600);
  
  extractStuff();
  
  println(col + "-" + xC + "-" + yC + "-" + d);
  
}


void draw() {
  if( col.equals("red") )
    fill(255, 0, 9);
    
  else if( col.equals("green") )
    fill(0, 255, 0);
    
  else if( col.equals("blue") )
    fill(0, 0, 255);

  else
    fill(0);
    
  circle(xC, yC, d);
}
