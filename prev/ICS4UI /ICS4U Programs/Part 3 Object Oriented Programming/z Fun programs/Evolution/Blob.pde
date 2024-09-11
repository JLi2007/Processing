class Blob {
  int colorR;
  int colorG;
  int colorB;
  
  PVector pos;
  PVector vel;
  
  boolean target;
  
  float canBirth;
  float lifeForce;
  
  Blob() {
   colorR = int(random(0, 256)); 
   colorG = int(random(0, 256)); 
   colorB = int(random(0, 256)); 
   
   pos = new PVector(random(fieldX, width), random(0, height));
   vel = PVector.random2D();
   
   lifeForce = (365 * 2.3) * random(0.8, 1.2);
   canBirth = (365) * random(0.8, 1.8);
   
   target = false;
  }
  
  // Constructor for the children
  Blob(PVector pos, int colorR, int colorG, int colorB) {
   this.colorR = colorR;
   this.colorG = colorG;
   this.colorB = colorB;
   
   this.pos = pos;
   vel = PVector.random2D();
   
   lifeForce = (365 * 2.3) * random(0.8, 1.2);
   canBirth = (365) * random(0.8, 1.8);
   
   target = false;
  }
  
  void update() {
   canBirth--;
   lifeForce--;
   
   boundary();
   move();
   giveBirth();
   death();
  }
  
  // So the blobs cannot leave the designated rectangle
  void boundary() {
    if (pos.x <= fieldX + 8) {
     vel.set(-vel.x, vel.y); 
     pos.set(fieldX + 8, pos.y);
    }
    if (pos.y <= 0) {
     vel.set(vel.x, -vel.y);
     pos.set(pos.x, 1);
    }
    if (pos.x >= width) {
     vel.set(-vel.x, vel.y);
     pos.set(width, pos.y);
    }
    if (pos.y >= height) {
     vel.set(vel.x, -vel.y);
     pos.set(pos.x, height);
    }
  }
  
  // Takes in a value and substracts it or adds to by a random number multiplied by the mutation size
  int inheritance(int value1, int minimum, int maximum) {
    int childValue = value1 + (int(random(3))-1) * MUTATION_SIZE;
    childValue = boundary1(childValue, minimum, maximum);

    return childValue; 
  }
  
  void giveBirth() {
   if (canBirth < 0 ) {
     int childR = inheritance(this.colorR, 0, 255);
     int childG = inheritance(this.colorG, 0, 255);
     int childB = inheritance(this.colorB, 0, 255);
     
     Blob childBlob = new Blob(pos.copy(), childR, childG, childB);
     blobs.add(childBlob);
     canBirth = (365) * random(0.8, 1.2);
   }
  }
  
  void death() {
   if (lifeForce < 0) {
    kill(); 
   }
  }
  
  void kill() {
   blobs.remove(this);
   blobsDied++;
  }
  
  void move() {
   pos.add(vel);
  }
}
