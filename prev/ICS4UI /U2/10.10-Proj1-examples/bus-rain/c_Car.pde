class Car {
  color colour;
  PVector pos;
  float speed;
  PVector vel;
  PVector dir;
  
  Car(color c, float x, float y, float s, int dirX) {
    this.colour = c;
    this.pos = new PVector(x, y);
    this.speed = s;
    this.dir = new PVector(dirX, 1);
  }
  
  void drawCar() {
    noStroke();
    fill(this.colour);
    quad(this.pos.x-60, this.pos.y-50, this.pos.x-45, this.pos.y, this.pos.x+195, this.pos.y, this.pos.x+210, this.pos.y-50); // Body
    rect(this.pos.x, this.pos.y-90, 150, 40);
    
    fill(0);
    stroke(50);
    circle(this.pos.x, this.pos.y, 35); // Tires
    circle(this.pos.x+150, this.pos.y, 35);
    
    noStroke();
    fill(50, 100, 150);
    rect(this.pos.x+10, this.pos.y-80, 60, 25); // Windows
    rect(this.pos.x+80, this.pos.y-80, 60, 25);
  }
  
  void animateCar() {
    if (this.dir.x == 1) {
      if (this.pos.x >= 900) {
        this.pos.x = -200;
        this.colour = color(random(0, 255), random(0, 255), random(0, 255));
      }
    }
    else {
      if (this.pos.x<= -200) {
        this.pos.x = 900;
        this.colour = color(random(0, 255), random(0, 255), random(0, 255));
      }
    }
    
    if (!isCollision()) {
      this.pos.x += this.speed*this.dir.x;
    }  
  }
  
  boolean isCollision() {
    if (this.pos.x+280 > b.pos.x && this.pos.x < b.pos.x + 550 && this.dir.x == b.dir) {
      return true;
    }
    
    return false; 
  }
}
