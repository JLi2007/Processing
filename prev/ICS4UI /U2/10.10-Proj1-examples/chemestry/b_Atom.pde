class Atom {
  // Fields 
  float size;
  String name;
  String formula;
  color atomColor;
  PVector position;
  PVector velocity;
  PVector acceleration;
  int charge;
  float mass;
  Text atomText;
  
  
  // Constructor
  Atom (String n, String f, float s, color ac, int c, float m) {
    this.name = n;
    this.formula = f;
    this.atomColor = ac;
    this.size = s/atomScaleDown;
    this.charge = c;
    this.mass = m;
    
    this.position = new PVector(random(this.size, width-this.size), random(this.size, height-this.size));
    this.velocity = new PVector(random(-5, 5), random(-5, 5));
    this.acceleration = new PVector(0,0);
    this.atomText = new Text(this.formula, this.position, this.charge);
  }
  
  
  // Methods
  // Draws the atom, updates it position, and checks for collisions
  void drawAtom() {
    
    fill(this.atomColor);
    noStroke();
    circle(this.position.x, this.position.y, this.size);
    
    this.atomText.drawText();
    updatePosition();
    checkForCollision();
  }
  
  
  // Updates the position of the ball
   void updatePosition() {
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
    this.acceleration = new PVector (0,0); 
    
    // If the atom is moving too fast, slow it down (this can happen when two atoms approach each other really quick
    if(this.velocity.x > 10) {
      this.velocity.x = 9;
    }
    
    else if(this.velocity.x < -10) {
      this.velocity.x = -9;
    }
    
    if(this.velocity.y > 10) {
      this.velocity.y = 9;
    }
    
    else if(this.velocity.y < -10) {
      this.velocity.y = -9;
    }
  }
  
  
  // Checks for collision with walls and makes sure it bounces off walls 
  void checkForCollision() {
    
    // Ensures the atom bounces off the vertical walls
    if(dist(this.position.x, this.position.y, 0, this.position.y) - this.size/2 <= 0 || dist(this.position.x, this.position.y, 0, this.position.y) + this.size/2 >= width) { 
      this.velocity.x *= -1;
      
      // Prevents the atoms from being stuck in the walls 
      if(this.position.x - this.size/2 < 0) {
        this.position.x = this.size/2 + 1;
      }
      
      else {
        this.position.x = width - this.size/2 - 1;
      }
    }
    
    // Ensures the atom bounces off the horizontal walls 
    if (dist(this.position.x, this.position.y, this.position.x, 0) - this.size/2 <= 0 ||dist(this.position.x, this.position.y, this.position.x, 0) + this.size/2 >= height) {
      this.velocity.y *= -1;
      
      // Prevents the atoms from being stuck in the walls 
      if(this.position.y - this.size/2 < 0) {
        this.position.y = this.size/2 + 1;
      }
      
      else {
        this.position.y = height - this.size/2 - 1;
      }
    }
  }
}
