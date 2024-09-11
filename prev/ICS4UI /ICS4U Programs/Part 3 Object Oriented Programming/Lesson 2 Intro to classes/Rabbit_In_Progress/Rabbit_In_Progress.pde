Rabbit carl = new Rabbit("Carl", 400, 315, "male", 2, 75, color(160, 100, 100 ), 20);  //update this
Rabbit soo = new Rabbit("Soo", 100, 420, "female", 3.5, 35, color(255, 255, 0), 2);

void setup() {
  size(600, 600);
  rectMode(CENTER);
  textAlign(CENTER);
}

void draw() {
  background(0, 255, 50);
  
  carl.drawMe();
  soo.drawMe();
  
  carl.move();
  soo.move();
}
