class Photons{
  BaseTen energy;
  BaseTen wavelength;
  BaseTen frequency;
  color colour;
  PVector position;
  PVector velocity;
  PVector destination;
  
  //constructor
  Photons(BaseTen f, BaseTen wnm, PVector pos, color c){
    this.frequency = f;
    this.wavelength = wnm;
    this.position = pos;
    this.energy = getEnergy(this.wavelength);
    this.destination = new PVector(1075, random(210, 590));
    this.velocity = getVelocity();
    this.colour = color(red(c), green(c), blue(c));
  }
  
  //gets the velocity vector of the photon
  PVector getVelocity(){
    float xComp = this.destination.x - this.position.x;
    float yComp = this.destination.y - this.position.y;
    return new PVector(xComp, yComp).normalize().mult(2.5);
  }
  
  //gets the amount of energy in photon
  BaseTen getEnergy(BaseTen w){
    BaseTen e = h.multiply(c).divide(w);
    return e;
  }
  
  //updates photon position
  void update(){
    this.position.add(this.velocity);
  }
  
  //creates photon on screen
  void create(){
    //noStroke();
    stroke(255);
    strokeWeight(1);
    fill(this.colour);
    ellipseMode(RADIUS);
    ellipse(this.position.x, this.position.y, 5, 5);
    this.update();
  }
  
  //prints photon information 
  void display(){
    println("wavelength:", this.wavelength.number + " m");
    println("frequency:", this.frequency.number + " Hz");
    println("energy:", this.energy.number + " J");
  }
  
}