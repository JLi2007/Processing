Plant[] plants = new Plant[20];
Rabbit charlie = new Rabbit("Charlie", 400, 315, "male", 2, 75, color(160, 100, 100 ), 20);
Rabbit vidul = new Rabbit("Vidul", 100, 420, "female", 3.5, 35, color(255, 255, 0), 2);

void setup() {
  size(600, 600);
  rectMode(CENTER);
  textAlign(CENTER);

  for (int i = 0; i < plants.length; i++) {
    plants[i] = new Plant(random(600),random(600));
  }
}

void draw() {
  background(0, 255, 50);

  // iterate through plants and draw each plant
  for (Plant plant : plants) {
    plant.drawMe();
  }

  charlie.drawMe();
  vidul.drawMe();

  charlie.move();
  vidul.move();
}
