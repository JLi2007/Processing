import g4p_controls.*;

int MUTATION_SIZE = 5; // GUI

int fieldX;
int fieldY;

int backgroundR = 0; // GUI
int backgroundG = 0; // GUI
int backgroundB = 0; // GUI

int blobAverageR = 0;
int blobAverageG = 0;
int blobAverageB = 0;

int numberOfBlobs = 125;
int numberOfPredators = 3;

int blobsAlive;
int blobsDied;

int predatorsAlive;
int predatorsDied;

float camoDiff;

String[] maps;

PImage tree;

ArrayList<Blob> blobs;
ArrayList<Predator> predators;

// GUI Variables
String option = "Custom";

void setup() {
  size(1100, 800);
  createGUI();
  noStroke();
  
  // Creates distance from the informations box
  fieldX = width - 750;
  
  maps = loadStrings("Maps.txt");
  
  blobs = new ArrayList();
  predators = new ArrayList();
  
  setInitialMobs();
}

void setInitialMobs() {
  // Creates all the blobs and predators initally
  for (int i = 0; i < numberOfBlobs; i++) {
   Blob blob = new Blob();
   blobs.add(blob);
  }
  
  for (int i = 0; i < numberOfPredators; i++) {
   Predator predator = new Predator();
   predators.add(predator);
  }
}

void blobsVisual() {
  int blobTotalR = 0;
  int blobTotalG = 0;
  int blobTotalB = 0;
  
  blobsAlive = 0;
  
  for (int i = 0; i < blobs.size(); i++) {
   blobsAlive++;
   
   Blob blob = blobs.get(i);
   fill(blob.colorR, blob.colorG, blob.colorB);
   circle(blob.pos.x, blob.pos.y, 7);
   
   // Adds up the color for every blob 
   blobTotalR = blobTotalR + blob.colorR;
   blobTotalG = blobTotalG + blob.colorG;
   blobTotalB = blobTotalB + blob.colorB;
   
   blob.update();
  }
  
  // Divides the color for every blob by the number of blobs
  if (blobs.size() > 0) {
    blobAverageR = blobTotalR / blobs.size();
    blobAverageG = blobTotalG / blobs.size();
    blobAverageB = blobTotalB / blobs.size();
  }

  
  // Substracts the average color by the background color and divides that by 765 which is 255*3
  camoDiff = abs(blobAverageR - backgroundR) + abs(blobAverageG - backgroundG) + abs(blobAverageB - backgroundB);
  camoDiff = camoDiff/765;
}

void predatorsVisual() {
  predatorsAlive = 0;
  
  for (int i = 0; i < predators.size(); i++) {
   predatorsAlive++;
   
   Predator predator = predators.get(i);
   fill(255,255,255);
   strokeWeight(3);
   circle(predator.pos.x, predator.pos.y, 13);
   line(predator.pos.x - 2, predator.pos.y - 2, predator.pos.x + 4, predator.pos.y + 4);
   
   predator.update(blobs);
  }
}

void border() {
  fill(backgroundR, backgroundG, backgroundB);
  strokeWeight(6);
  rect(fieldX + 4, 3, 743, 794);
}

void mapMaking() {
  for (int i = 0; i < maps.length; i++) {
    // Looks for keywords in the text file
    if (maps[i].equals(option)) {
     backgroundR = int(maps[i + 1]); 
     backgroundG = int(maps[i + 2]); 
     backgroundB = int(maps[i + 3]); 
    }
  }
}

void draw() {
  background(backgroundR, backgroundG, backgroundB);
  border();
  strokeWeight(2);
  blobsVisual();
  statsBox();
  predatorsVisual();
  mapMaking();
}
