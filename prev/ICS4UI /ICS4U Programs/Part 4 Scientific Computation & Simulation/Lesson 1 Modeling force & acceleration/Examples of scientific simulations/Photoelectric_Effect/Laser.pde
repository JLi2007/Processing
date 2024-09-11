class Laser{
  float wavelength_nm;
  float timeIntervals;
  color colour; 
  int intensity;
  BaseTen frequency;
  BaseTen wavelength_m;
  
  //constructor
  Laser(float w, int i){
    this.wavelength_nm = w;
    this.intensity = i;
    this.wavelength_m = nanoMeterToMeter(this.wavelength_nm);
    this.frequency = wavelengthToFrequency(this.wavelength_m);
    this.timeIntervals = (1 / (this.intensity / 60.0)) * 1000;   
    this.colour = wavelengthToRGB(w);
  }
  
  //calculates frequency from wavelength
  BaseTen wavelengthToFrequency(BaseTen w){
    BaseTen f = c.divide(w);
    return f;
  }
  
  //converts nanometers to meters
  BaseTen nanoMeterToMeter(float n){
    String w = n + " * 10^-9";
    return new BaseTen(w);
  }
  
  //shoots a photon
  Photons eject(){
    float x = random(410, 490);
    float y = -2 * x + 1050;
    PVector position = new PVector(x, y);
    return new Photons(this.frequency, this.wavelength_m, position, this.colour);
  }
  
  //creates laser/light on screen
  void create(){
    //light visuals 
    stroke(0);
    strokeWeight(2);
    fill(this.colour);
    quad(500, 50, 400, 250, 1050, 600, 1050, 200);
  }
  
  //prints information about laser
  void display(){
    println("wavelength:", this.wavelength_nm + " nm");
    println("frequency:", this.frequency.number + " Hz");
    println("intensity:", this.intensity + " photons/min");
  }
  
}