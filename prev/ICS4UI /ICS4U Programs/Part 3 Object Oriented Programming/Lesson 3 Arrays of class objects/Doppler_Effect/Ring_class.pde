class Ring {
  //FIELDS - attributes that all Rings will have
  float x, y;
  float radius, diameter;
  float speed;
  
  //CONSTRUCTOR - sets the field values with the parameters passed in from the main program
  Ring(float xPos, float yPos, float r, float s) {
    this.x = xPos;
    this.y = yPos;
    this.radius = r;
    this.speed = s;
    this.diameter = 2*r;
  }
  
  //METHODS - functions that all ring objects can do
  void grow() {
    this.radius += speed;
    this.diameter = 2*radius;
  }
  
  void drawCircular() {
    circle(x, y, 2*radius);
  }
  
  void drawSquare() {
    square(x-radius, y-radius, diameter);
  }
}
