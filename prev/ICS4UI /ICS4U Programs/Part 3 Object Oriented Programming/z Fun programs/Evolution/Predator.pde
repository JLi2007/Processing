class Predator {
  Blob prey;
  
  PVector pos;
  PVector vel;
  PVector acc;
  PVector dir;
  
  float speed = 2.9;
  
  float stomach;
  float stomachCap;
  
  float lifeForce;
  
  float canBirth;
  
  Predator(PVector pos) {
    this.pos = pos;
    vel = PVector.random2D().setMag(speed);
    acc = new PVector(0, 0);
    dir = new PVector(0, 0);
    
    stomach = 20;
    stomachCap = 30;
    
    lifeForce = (365 * 7.6) * random(0.9, 1.5);
    
    canBirth = (365 * 2) * random(0.9, 1.5);
  }
  
  Predator() {
    pos =  new PVector(random(fieldX, width), random(0, height));
    vel = PVector.random2D().setMag(speed);
    acc = new PVector(0, 0);
    dir = new PVector(0, 0);
    
    stomach = 20;
    stomachCap = 30;
    
    lifeForce = (365 * 6) * random(0.9, 1.5);
    
    canBirth = (365 * 2) * random(0.9, 1.5);
  }
  
  void update(ArrayList<Blob> b) {
    stomach -= 0.02;
    canBirth--;
    lifeForce--;
    
    giveBirth();
    boundary();
    findPrey(b);
    death();
  }
  
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
  
  void death() {
   if (lifeForce <= 0) {
    kill();
   }
  }
  
  void kill() {
   predators.remove(this);
   predatorsDied++;
  }
  
  void giveBirth() {
   // Only births if the predator has eaten some food and isn't on birth cooldown
   if (canBirth < 0 && stomach > 0) {
    Predator childPredator = new Predator(pos.copy());
    predators.add(childPredator);
    stomach = 0;
    canBirth = (365 * 1.35) * random(0.9, 1.5);
   }
  }
  
  // Finds the blog with the biggest difference in color compared to the background color
  Blob leastFitness(ArrayList<Blob> b) {
    Blob worstBlob = null;
    float lowestGene = 0;
    
    for (int i = 0; i < b.size(); i++) {
      // Ensures that other predators can't get to the predator if someone else has already locked onto it
      if (b.get(i).target == false) {
       float distance = pos.dist(b.get(i).pos);
       
       if (distance < 150) { // This is how far away they can look, when looking for prey
        float gene = backgroundColorDiff(b.get(i));
        
        // Will eventually find the worst gene in a radius of 150 units
        if (gene > lowestGene) {
         lowestGene = gene;
         worstBlob = b.get(i);
         float camo = (abs(b.get(i).colorR - backgroundR) + abs(b.get(i).colorG - backgroundG) + abs(b.get(i).colorB - backgroundB)); // adds up the differences in color then divides them
         camo /= 765;
         
         if (camo < 0.12 ) { // How close the prey should be to the background to be ignored by the predators
          worstBlob = null; 
         }
         
        }
       }
      }
    }
    
    return worstBlob;
  }
  
  void moveTo(Blob b) {
   PVector displacement = PVector.sub(b.pos, pos);
   float angle = displacement.heading();
   dir.set(new PVector(cos(angle), sin(angle)));
   vel.set(dir.mult(2));
   pos.add(vel);
   
   float distance = this.pos.dist(b.pos);
   if (distance < 12) {
     kill(b);
   }
  }
  
  void kill(Blob target) {
   if(stomach < stomachCap) {
     target.kill(); 
     stomach++;
   }
   
   prey = null;
  }
  
  void findPrey(ArrayList<Blob> b) {
   // Will only look for prey if they haven't yet locked onto one
   if (prey == null) {
     prey = leastFitness(b);
   }
   
   if (prey != null) {
     prey.target = true;
     moveTo(prey);
   } else {
    move(); 
   }
  }
  
  void move() {
   vel.add(acc);
   pos.add(vel);
   acc.set(PVector.random2D());
   acc.mult(0.15);
  }
}
