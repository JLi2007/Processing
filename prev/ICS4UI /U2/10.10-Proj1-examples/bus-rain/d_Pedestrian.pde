class Pedestrian {
  float h;
  float w;
  color colour;
  boolean onBus;
  boolean hasDecided;
  int busState; // 0 is nothing, 1 is going on/leaving bus
  int timeOnBus;
  PVector pos;
  float speed;
  PVector vel;
  PVector dir;
  
  Pedestrian(float h, float w, color c, boolean onBus, float x, float y, float s) {
    this.h = h * 100;
    this.w = w * 100;
    this.colour = c;
    this.hasDecided = false;
    this.onBus = onBus;
    this.timeOnBus = 0;
    this.vel = new PVector(random(-2, 2), random(-2, 2));
    this.pos = new PVector(x, y);
    this.speed = s;
  }
  
  void drawPedestrian() {
    noStroke();
    fill(255);
    rect(this.pos.x-this.w/4, this.pos.y+5, this.h/8, this.h/4); // Body
    
    fill(100);
    rect(this.pos.x-this.w/4, this.pos.y+this.h/4, this.h/8, this.h/4); // Legs
    
    fill(150);
    rect(this.pos.x+this.w/4, this.pos.y+5, this.w/4, this.h/4); // Arm 1
    rect(this.pos.x-this.w/2.75, this.pos.y+7, this.w/8, this.h/4); // Arm 2
    
    fill(this.colour);
    circle(this.pos.x, this.pos.y, this.h/8); // Head
    
    if (weather.weatherType == 1) { 
      fill(100);
      arc(this.pos.x, this.pos.y, this.h/8, this.h/8, PI, TWO_PI, OPEN); // Hats
      fill(200);
      circle(this.pos.x, this.pos.y-this.h/16, this.h/24);
    }
    else if (weather.weatherType == 0) { 
      fill(100); 
      arc(this.pos.x+10, this.pos.y-18, this.h/3, this.h/8, PI, TWO_PI, OPEN); // Umbrellas
      fill(50);
      rect(this.pos.x+10, this.pos.y-18, 3, h/3);
    }
  }
  
  void getOffBus() {
    if (!this.hasDecided && b.alreadyStopped) {
      willLeaveBus();

      if (this.busState == 1 && this.timeOnBus > 0) {
        this.onBus = false;
        this.busState = 0;
        this.pos = new PVector(b.pos.x+475, b.pos.y+100);
        this.timeOnBus = 0;
        b.pedestrians.remove(this);
      }
    }
    if (!b.alreadyStopped) {
      this.timeOnBus += 1;
      this.hasDecided = false;
    }
  }
  
  void animatePedestrian() {
    if (b.idleTime == 0) {
      this.hasDecided = false;
    }
    if (!this.hasDecided) {
      willGetOnBus();
    }

    if (this.pos.y < 550) {
      this.vel = PVector.mult(new PVector(0, -1), this.speed);
    } 
    else {
      if (random(0, 100) < 1) {
        pickNewDirection();
      }
    }
    
    if (this.pos.x<=0 || this.pos.x >= 800) 
      this.vel.x *= -1;
    if (this.pos.y <= 550 || this.pos.y >= 750)
      this.vel.y *= -1;
    
    if (b.idleTime > 10 && this.busState == 1) {
      PVector busDoorPos = new PVector(b.pos.x+475, b.pos.y+100);
      float d = this.pos.dist(busDoorPos);
      if (d < 2.5) {
        this.onBus = true;
        this.busState = 0;
        b.pedestrians.add(this); // Adding pedestrian to bus class
      }
      headTowards(b); 
    }

    this.pos.add(this.vel);
  }
  
  void pickNewDirection() {
    float randAngle = random(0, TWO_PI);
    this.dir = new PVector(cos(randAngle), sin(randAngle)); // Unit vector to direction
    this.vel = PVector.mult(this.dir, this.speed);
  }
  
  void headTowards(Bus b) {
    PVector targetPos = new PVector(b.pos.x+475, b.pos.y+100);
    
    PVector v = PVector.sub(targetPos, this.pos); 
    float angle = v.heading(); // Get angle
    this.dir = new PVector(cos(angle), sin(angle)); 
    this.vel = PVector.mult(this.dir, this.speed);
  }
  
  void willGetOnBus() {
    if (b.idleTime < 10) {
      this.busState = int(random(0, 2));
    }
  }
  
  void willLeaveBus() {
    if (b.idleTime < 10) {
      this.busState = int(random(0, 2));
      this.hasDecided = true;
    }
  }
  
}
