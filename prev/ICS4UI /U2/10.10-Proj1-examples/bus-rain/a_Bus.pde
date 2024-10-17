class Bus {
  int numP;
  PVector pos;
  color colour;
  float speed;
  int dir;
  int idleTime;
  boolean alreadyStopped;
  ArrayList<Pedestrian> pedestrians = new ArrayList<Pedestrian>();

  Bus(int p, color c, int x, int y, float s) {
    this.numP = p;
    this.colour = c;
    this.pos = new PVector(x, y);
    this.speed = s;
    this.dir = 1;
    this.idleTime = 0;
    this.alreadyStopped = false;
  }
  
  void drawBus() {
    noStroke();
    fill(this.colour);
    rect(this.pos.x, this.pos.y, 550, 200, 15); // Body
    rect(this.pos.x+100, this.pos.y-5, 400, 5, 25);
    fill(75);
    rect(this.pos.x, this.pos.y+180, 450, 20); // Bottom
    
    fill(0);
    stroke(50);
    circle(this.pos.x+150, this.pos.y+200, 50); // Tires
    circle(this.pos.x+425, this.pos.y+200, 50);
    
    fill(75);
    for (int i=0; i<5; i++) {
      rect(this.pos.x+50+75*i, this.pos.y+50, 75, 75); // Windows
    }
    
    strokeWeight(2);
    rect(this.pos.x+450, this.pos.y+45, 75, 125); // Door
    fill(0);
    rect(this.pos.x+485, this.pos.y+45, 5, 125); // Door split
    
    noStroke();
    fill(100);
    rect(this.pos.x+535, this.pos.y+25, 15, 125); // Driver Window
    
    fill(255, 191, 0);
    rect(this.pos.x+535, this.pos.y+160, 15, 10); // Headlight
    
    showPassengers();
  }
 
  void animateBus() {
    if (this.pos.x >= 900) {
      this.alreadyStopped = false;
      this.pos.x = -500;
    }
      
    if (this.idleTime <= 0) {
      if (!isStopping())
        this.pos.x += this.speed;
    }
    else {
      this.idleTime -= 1;
    }
  }
  
  boolean isStopping() {
    if (this.pos.x > 0 && this.pos.x+550 < 800) {
      if (random(0, 50) < 1 && !this.alreadyStopped) {
        this.idleTime = 450;
        this.alreadyStopped = true;
        return true;
      }
    }
    return false;
  }
  
  void showPassengers() {
    int l;
    // Display only max 10 people
    if (this.pedestrians.size() > 10) { 
      l = 10;
    }
    else {
      l = this.pedestrians.size();
    }
    
    float windowSpace = 0;
    for (int i=0; i<l; i++) {
      if (i % 2 == 0 && i != 0) {
        windowSpace += 1;
      }
      fill(this.pedestrians.get(i).colour);
      circle(this.pos.x+75+30*i+windowSpace*15, this.pos.y+100, this.pedestrians.get(i).h/8); 
    }
  }
  
}
