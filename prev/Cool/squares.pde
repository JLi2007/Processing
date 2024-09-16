// http://forum.processing.org/topic/processing-question
// http://forum.processing.org/topic/generate-a-square-grid
// http://studio.processingtogether.com/sp/pad/export/ro.9PDcp7xMBknWz/latest

final static byte SQUARES = 4;
final static color[] colors = new color[SQUARES];

// Choose JAVA2D, P2D, P3D or OPENGL:
final static String ENGINE = P2D;

void setup() {
  size(512, 512, ENGINE);
  frameRate(50);
  noLoop();
  noStroke();
  noCursor();
  rectMode(CORNERS);  // CORNER works too!

  mousePressed();
}

void draw() {
  fill(colors[0]);
  rect(0, 0, mouseX, mouseY);

  fill(colors[1]);
  rect(mouseX, 0, width, mouseY);

  fill(colors[2]);
  rect(0, mouseY, mouseX, height);

  fill(colors[3]);
  rect(mouseX, mouseY, width, height);
}

void mousePressed() {
  redraw();

  for ( byte c = SQUARES; c-- != 0; 
  colors[c] = (color) random(#000000) );             // Java
  //colors[c] = (int) random(0x1000000) | #000000);  // JS

  print(hex(colors[0]) + "\t");    // Java
  //println( hex(colors[0]) );     // JS
}

void mouseMoved() {
  redraw();
}

void mouseDragged() {
  redraw();
}