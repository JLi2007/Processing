int[] x = new int[50];
int[] y = new int[50];
int[] diameters = new int[50];
int n = 0;
int R;

void setup() {
  size(500,500);
  fill(255);
}

void draw() {
  background(0); 
  stroke(255);
  textSize(14);
  text("Click and hold anywhere", 100, 100);
  
  if (mousePressed) {
    diameters[n]++;
  }
  
  fill(6*n, 10*n, 20*n);
  for(int i = 0; i <= n; i++) {
    circle(x[i], y[i], diameters[i]);
  }
}


void mousePressed() {
  n++;
  x[n] = mouseX;
  y[n] = mouseY;
}
  
