//Step 1: Tools menu, get the two packages
import g4p_controls.*;  //Step 2

float xPos = 0;
float speed = 5;
float yPos;
float r = 50;

void setup() {
  size(900, 600);
  createGUI();  //Step 3
  yPos = height/2;
}

//Step 4 Open GUI Builder from Tools menu
//Step 5 Make a new window, give it a name
//Step 6 Make the slider

void draw() {
  background(0);
  fill(34, 100, 200);
  circle(xPos, yPos, r);
  xPos += speed;
  if (xPos > width + r ) {
    xPos = -r;
  }
}
