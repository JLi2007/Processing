float x, v, a;

void setup() {
  size(1000, 500);
  x = 100;
  v = 5;
}

void draw() {
  //background(255, 255, 0);
  fill(100, 200, 88);
  circle(x, height/2, 50);
  x = x + v;
  v = v + 0.4;
  
}
