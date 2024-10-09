int numRabbits = 4;
int numPlants = 12;

Rabbit[] rabbits = new Rabbit[ numRabbits ];
Plant[] plants = new Plant[ numPlants ];

color normalFur = color(198, 140, 70);  //brown
color happyFur = color(0, 255, 255);  //cyan


void setup() {
  size(1000,800);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(18);
  
  makeRabbits();
  makePlants();
}


void makeRabbits() {
  for(int i = 0; i < rabbits.length; i++) {
    String rName = "Rabbit #" + i;
    rabbits[i] = new Rabbit( rName, 3.0, random( 30, 150), 3 );
  }
}


void makePlants() {
  for(int i = 0; i < plants.length; i++) 
    plants[i] = new Plant(random(0.9*width), random(0.9*height));  
}


void draw() {
  background(100,255,0);
  
  for( Plant p : plants ) {  //Another way to write a for-loop that goes through an array of class objects
    p.drawMe();
  }
  
  for( Rabbit r : rabbits ) {
    r.drawMe();
    r.move();
  }
}
