class BusStop {
  PVector pos;
  
  BusStop(int x, int y) {
    this.pos = new PVector(x, y);
  }
  
  void displayBusStop() {
    // Columns
    fill(150);
    rect(this.pos.x+440, this.pos.y+65, 20, 100);
    rect(this.pos.x+490, this.pos.y, 10, 200);
    rect(this.pos.x+150, this.pos.y+65, 20, 100);
    rect(this.pos.x+200, this.pos.y+65, 10, 200);
    
    // Ceiling 
    fill(228, 155, 15);
    quad(this.pos.x, this.pos.y, this.pos.x, this.pos.y+75, this.pos.x+450, this.pos.y+75, this.pos.x+500, this.pos.y);
    fill(228, 125, 75);
    rect(this.pos.x, this.pos.y+75, 450, 10);
    quad(this.pos.x+450, this.pos.y+75, this.pos.x+450, this.pos.y+85, this.pos.x+500, this.pos.y+10, this.pos.x+500, this.pos.y);
  }
}
