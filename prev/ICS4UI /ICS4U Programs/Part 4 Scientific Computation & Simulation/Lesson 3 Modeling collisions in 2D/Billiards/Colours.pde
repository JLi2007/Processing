void setColours() {
  color white = color(240);
  color maroon = color(153,0,0);
  color yellow = color(255,255,0);
  color peach =  color(240,180,122);
  color black = color(0);
  color blue1 = color(50, 150, 250);
  
  color green = color(0, 150, 0);
  color pink = color(255, 150, 255);
  color hotpink = color(255, 220, 230);
  color grey = color(170);
  color teal = color(0, 102, 102);
  
  color cyan = color(102,255,255);
  color blue2 = color(0,0,255);
  color orange = color (255, 120, 50);
  color green2 = color(0,255,0);
  color purple = color(175, 50, 255);
  color brown = color(210,105,30);
  
  color[] allColours = {white, maroon, yellow, brown, purple, peach, blue1, black, green, pink, grey, hotpink, teal, cyan, blue2, orange, green2};
  int numColours = allColours.length;
  
  billiardColours = new color[numBalls];
  println(numBalls);
  
  for( int i = 0; i < numBalls; i++ ) {
    billiardColours[i] = allColours[i % numColours];
  }
}
