float backgroundColorDiff(Blob b) {
 // Finds the difference in background color to the color of the single blob itself
 float R = b.colorR - backgroundR; 
 float G = b.colorG - backgroundG; 
 float B = b.colorB - backgroundB; 
 
 float diff = sqrt(R*R + G*G + B*B);
 return diff;
}

int boundary1(int value, int minimum, int maximum) {
 // A general boundary function for maybe colors (0, 255) 
 if (value >= maximum) {
  value = maximum; 
 }
 if (value <= minimum) {
   value = minimum;
 }
 return value;
}

void statsBox() {
 fill(0);
 strokeWeight(9);
 line(fieldX, 0, fieldX, height);
 
 fill(255);
 strokeWeight(0);
 rect(0, 0, fieldX, height);
 
 fill(0);
 textSize(25);
 text("Blob Statistics", 19, 30); 
 
 textSize(15);
 text("Blob Alive: " + str(blobsAlive), 20, 50);
 
 textSize(15);
 text("Blob Died: " + str(blobsDied), 20, 70);
 
 textSize(25);
 text("Predator Statistics", 19, 120);
 
 textSize(15);
 text("Predator Alive: " + str(predatorsAlive), 20, 140);
 
 textSize(15);
 text("Predator Died: " + str(predatorsDied), 20, 160);
 
 textSize(15);
 text("Background Color" , 20, 210);
 
 textSize(15);
 fill(255, 0, 0);
 text("R = " + backgroundR, 20, 230);
 fill(0, 255, 0);
 text("G = " + backgroundG, 20, 250);
 fill(0, 0, 255);
 text("B = " + backgroundB, 20, 270);
 
 fill(backgroundR, backgroundG, backgroundB);
 rect(20, 290, 100, 50);
 
 fill(0);
 textSize(15);
 text("Avg Blob Color", 220, 210);
 fill(255, 0, 0);
 text("R = " + blobAverageR, 220, 230);
 fill(0, 255, 0);
 text("G = " + blobAverageG, 220, 250);
 fill(0, 0, 255);
 text("B = " + blobAverageB, 220, 270);
 
 fill(blobAverageR, blobAverageG, blobAverageB);
 rect(220, 290, 100, 50);
 
 fill(0,0,0);
 text("Camo diff = " + camoDiff, 150, 370);
}
