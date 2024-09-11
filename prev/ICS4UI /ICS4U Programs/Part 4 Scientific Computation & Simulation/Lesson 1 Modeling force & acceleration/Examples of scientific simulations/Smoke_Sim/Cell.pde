/*
  Data structure for the indivdual cells. Makes accessing one cells data more convient
*/
class Cell {
  int x, y;
  float temp;
  float smokeCon;
  PVector windVec;
  
  Cell(int x, int y, float temp, float smokeCon) {
    this.x = x;
    this.y = y;
    this.temp = temp;
    this.smokeCon = smokeCon;
    windVec = PVector.random2D().normalize();  
  }
  
  PVector getMidpoint() {
    return new PVector(x+.5, y+.5);
  }
}
