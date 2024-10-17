class Molecule {
  // Fields 
  Atom a, b;
  Atom biggestAtom;
  Molecule c;
  float size;
  String name;
  PVector position;
  PVector velocity;
  PVector acceleration;
  int charge;
  float mass;
  ArrayList<Atom> atomsAttachedToMolecule = new ArrayList<Atom>();
 
  
  // Constructor #1 
  Molecule (Atom a, Atom b) {
    this.a = a;
    this.b = b;
    
    this.size = a.size + b.size;
    this.charge = a.charge + b.charge;
    this.mass = a.mass + b.mass;
    
    this.position = this.b.position;
    this.velocity = new PVector(random(-5, 5), random(-5, 5));
    this.acceleration = new PVector(0,0);

    this.atomsAttachedToMolecule.add(a);
    this.atomsAttachedToMolecule.add(b);
  }
  
  
  // Constructor #2
  Molecule (Molecule c, Atom b) {
    this.c = c;
    this.b = b;
    
    this.atomsAttachedToMolecule = c.atomsAttachedToMolecule;
    this.atomsAttachedToMolecule.add(b);
    
    this.charge = c.charge + b.charge;
    this.mass = c.mass + b.mass;
    
    this.position = c.position;
    this.velocity = new PVector(random(-5, 5), random(-5, 5));
    this.acceleration = new PVector(0,0);
  }
  
  
  // Methods
  // Draws the molecule, and updates the position of all molecules while checking for collisions
  void drawMolecule() {
    
    // Find the biggest atom to use as the center atom
    noStroke();
    this.biggestAtom = this.b;
    
    // Finds the biggest atom for all the atoms attached to the molecule 
    for(Atom atom : this.atomsAttachedToMolecule) {
      if(this.biggestAtom.size < atom.size) {
        this.biggestAtom = atom;
      }
    }
    
    // Draw the biggest atom
    fill(this.biggestAtom.atomColor);
    circle(this.position.x, this.position.y, this.biggestAtom.size);
    Text centralAtomText = new Text(this.biggestAtom.formula, this.position, this.biggestAtom.charge);
    centralAtomText.drawText();
    
    // Updates the position of the central atom 
    this.biggestAtom.position = new PVector(this.position.x, this.position.y);
    this.size = this.biggestAtom.size;
    
    
    // Draws the atoms around the bigger central atom 
    for(int i = 0; i < this.atomsAttachedToMolecule.size(); i++) {
      // If the atom isn't the center atom
      if(this.atomsAttachedToMolecule.get(i) != this.biggestAtom) {
 
        // Distributes the other atoms evenly across the big atom using the a unit circle of bigger radius 
        float posX = this.biggestAtom.size/1.5*cos(i*TWO_PI/(this.atomsAttachedToMolecule.size()-1)) + this.position.x;
        float posY = this.biggestAtom.size/1.5*sin(i*TWO_PI/(this.atomsAttachedToMolecule.size()-1)) + this.position.y;
        
        // Updates the position of the individual atoms as well (this is important for collision detection)
        this.atomsAttachedToMolecule.get(i).position = new PVector(posX, posY);
        
        // Draws in the atoms around the center atom 
        fill(this.atomsAttachedToMolecule.get(i).atomColor);
        circle(posX, posY, this.atomsAttachedToMolecule.get(i).size);
        Text atomText = new Text(this.atomsAttachedToMolecule.get(i).formula, new PVector(posX, posY), this.atomsAttachedToMolecule.get(i).charge);
        atomText.drawText();
        
        this.size = this.biggestAtom.size + this.atomsAttachedToMolecule.get(i).size;
      }
    }
    
    // Updating the position of all molecules and checking for collision
    updatePosition();
    checkForCollision();
  }
  
  
   // Updates the position of the molecules
   void updatePosition() {
    
    this.position.add(this.velocity);    
    this.velocity.add(this.acceleration);    
    this.acceleration = new PVector (0,0);
    
    
    // If the molecule is moving too fast (this can happen when two molecules approach each other really quick)
    if(this.velocity.x > 10) {
      this.velocity.x -= 1;
    }
    
    else if(this.velocity.x < -10) {
      this.velocity.x += 1;
    }
    
    if(this.velocity.y > 10) {
      this.velocity.y -= 1;
    }
    
    else if(this.velocity.y < -10) {
      this.velocity.y += 1;
    }
  }
  
  
  // Collision detection
  private void checkForCollision() {
    
    // Goes through all the atoms on the molecule
    for(Atom atom : this.atomsAttachedToMolecule) {
      boolean collidedWithWall = false;
      
      // Checks for collision with the vertical walls 
      if(dist(atom.position.x, atom.position.y, 0, atom.position.y) - atom.size/2 <= 0 || dist(atom.position.x, atom.position.y, 0, atom.position.y) + atom.size/2 >= width) {
        this.velocity.x *= -1;
        collidedWithWall = true;
        
        // Prevents the molecules from getting stuck in the walls
        if(this.position.x - this.size/2 - this.b.size/2 < 0) {
          
          if(this.atomsAttachedToMolecule.size() > 2) {
            this.position.x = this.size/2 + this.b.size/2 + 1;
          }
          
          else {
            this.position.x = this.biggestAtom.size/2 + 1;
          }
        }
        
        else if (this.position.x + this.size/2 + this.b.size/2 + 4 > width) {
          this.position.x = width - this.size/2 - this.b.size/2 - 1;
        }
      }
      
      // Checks for collision with the horizontal walls 
      if (dist(atom.position.x, atom.position.y, atom.position.x, 0) - atom.size/2 <= 0 || dist(atom.position.x, atom.position.y, atom.position.x, 0) + atom.size/2 >= height) {
        this.velocity.y *= -1;
        collidedWithWall = true;
        
        // Prevents the molecules from getting stuck in the walls
        if(this.position.y - this.size/2 - this.b.size/2 < 0) {
          
          if(this.atomsAttachedToMolecule.size() > 3) {
            this.position.y = this.size/2 + this.b.size/2;
          }
          
          else{
            this.position.y = this.size/2+1;
          }
        }
        
        else if(this.position.y + this.size/2 + this.b.size/2 > height) {
          
          if(this.atomsAttachedToMolecule.size() > 3) {
            this.position.y = height - this.size/2 - this.b.size/2 - 1;
          }
          
          else{
            this.position.y = height - this.size/2 - 1;
          }
          
        }
      }
      
      if(collidedWithWall) {
        break;
      }
    }
  }
}
