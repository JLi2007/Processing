class Electrons{
  float velocity;
  float distance;
  float deltaD;
  float declaration;
  PVector position;
  BaseTen mass;
  BaseTen stoppingVolt;
  BaseTen energy;
  
  //constructor
  Electrons(BaseTen e, Battery b, PVector pos){
    this.energy = e;
    this.position = pos;
    this.velocity = -5;
    this.mass = new BaseTen("9.109 * 10^-31");
    this.stoppingVolt = this.energy.divide(new BaseTen("1.6 * 10^-19"));
    this.distance = distanceFactor(b.voltage) * (1075 - 240);
    this.deltaD = 0;
    this.declaration = (-1 * pow(abs(this.velocity), 2)) / (2 * (this.distance));
  }
  
  //gets the distance the electron travels before being repeled by field
  float distanceFactor(float v){
    float factor = this.stoppingVolt.divide(new BaseTen(v + " * 10^0")).convFloat();
    return factor;
  }
  
  //creates electron on screen
  void create(){
    stroke(255);
    strokeWeight(1);
    fill(205);
    ellipseMode(RADIUS);
    ellipse(this.position.x, this.position.y, 5, 5);
  }
  
  //updates electron position
  void update(){
    this.position.x += this.velocity;
    this.deltaD += abs(this.velocity);
    this.velocity -= this.declaration;
  }
  
}