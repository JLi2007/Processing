class Rabbit {
  //FIELDS (attributes that every rabbit has)
  String name, gender;
  PVector pos, vel;
  float speed, sightRadius, nervousness;
  color furColour;
  
  
  //CONSTRUCTOR (code to build a new Rabbit)
  // new Rabbit("Carl", 100, 315, "male", 6, color(140, 20, 15 ));
  Rabbit(String n, float x, float y, String g, float sp, float sr, color fc, float nv) {
    this.name = n;
    this.pos = new PVector(x, y);
    this.vel = new PVector( random(-2, 2), random(-2, 2) );
    this.speed = sp;
    this.sightRadius = sr;
    this.furColour = fc;
    this.nervousness = nv;
  }
  
  
  //METHODS (things a Rabbit can do)
  void drawMe() {
    fill( this.furColour );
    square(this.pos.x, this.pos.y, 40);
    
    noFill();
    circle(this.pos.x, this.pos.y, 2*this.sightRadius);
    
    fill(0);
    text(this.name, this.pos.x, this.pos.y);
  }
  
  
  void move() {
    if( random(0,100) < this.nervousness ) {  //change the 8 to something more general
      this.pickNewDirection();
    }
    
    this.pos.add( this.vel );
  }
  
  
  void pickNewDirection() {
    float randAngle = random(0, TWO_PI);
    PVector randDir = new PVector( cos(randAngle), sin(randAngle)); //unit vector in the direction we want to go
    this.vel = PVector.mult(randDir, this.speed );
  }
 
}
