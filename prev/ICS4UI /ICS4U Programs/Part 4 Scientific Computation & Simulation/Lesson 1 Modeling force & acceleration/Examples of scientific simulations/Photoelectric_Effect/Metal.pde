class Metal{
  String name;
  float workFunction_eV;
  BaseTen workFunction_J;
  
  //constructor
  Metal(String n, float wF){
    this.name = n;
    this.workFunction_eV = wF;
    this.workFunction_J = electronVoltsToJoules(this.workFunction_eV);
  }
  
  //converts workfunction from electrons volts to joules
  BaseTen electronVoltsToJoules(float eV){
    BaseTen e = new BaseTen(eV, 0);
    BaseTen j = new BaseTen("1.6 * 10^-19");
    BaseTen wF = e.multiply(j);
    return wF;
  }
  
  //creates metal on screen
  void create(){
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(1050, 200, 50, 400);
  }
  
  //prints metal information
  void display(){
    println("Metal:", this.name);
    println("Work Function", this.workFunction_J.number + " J");
  }
  
}