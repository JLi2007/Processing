String typing = "";
PFont f;

void setup() {
  size(900,200);
  noLoop();
  f = createFont("Arial", 24);
  textFont(f);
}

void draw(){
  background(255);
  fill(255,0,0);
  
  text(typing, 100, 100);
}

void keyPressed() {
  if( key == BACKSPACE ) {
    int L = typing.length();
    if ( L > 0 )
      typing = typing.substring(0, L-1);
  }
  
  else if( key == CODED ) {  //e.g. if they press SHIFT, TAB, ALT or some other special character
    //PRINT NOTHING
  }
  
  else
    typing = typing + key;
    
  redraw();
}
