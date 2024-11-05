// Need G4P library
import g4p_controls.*;

int numPlants = 20;
Plant[] plants = new Plant[numPlants];
ArrayList<Rabbit> rabbits = new ArrayList<Rabbit>();
boolean paused = false;

public void setup(){
  size(600,600, JAVA2D);
  createGUI();

  rectMode(CENTER);
  textAlign(CENTER);
  createPlants();

  rabbits.add(new Rabbit("Charlie", 400, 315, "male", 2, 75, color(160, 100, 100 ), 20));
  rabbits.add(new Rabbit("Vidul", 100, 420, "female", 3.5, 35, color(255, 255, 0), 2));
}

public void createPlants(){
  plants = new Plant[numPlants];
  for (int i = 0; i < plants.length; i++) {
    plants[i] = new Plant(random(600),random(600));
  }
}

public void draw(){
  background(230);

  background(0, 255, 50);

  // iterate through plants and draw each plant
  for (Plant plant : plants) {
    plant.drawMe();
  }

  for (Rabbit rabbit : rabbits){
    rabbit.drawMe();

    if(!paused){
        rabbit.move();
    }
  }
  
}