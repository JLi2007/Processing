/*
  Holds info on a source of emission, makes it easier to use
*/

class EmissionEpicenter {
  Cell cell;
  int timeAlive;
  float smoke = 800;
  float temp = 1600;
  PVector direction;
  int lifeTime;
  boolean dead;


  EmissionEpicenter(Cell cell, float emissionSmoke, float emissionTemp, PVector emissionDirection, int emissionLength) {
    this.cell = cell;
    this.smoke = emissionSmoke;
    this.temp = emissionTemp;
    this.direction = emissionDirection;
    this.lifeTime = emissionLength;

    this.timeAlive = 0;
    dead = false;
  }

  void emit() {
    if (!dead) {
      cell.smokeCon = smoke;
      cell.temp = temp;
      cell.windVec = new PVector(direction.x, direction.y);

      timeAlive++;

      if (timeAlive >= lifeTime) {
        dead = true;
      }
    }
  }
}
