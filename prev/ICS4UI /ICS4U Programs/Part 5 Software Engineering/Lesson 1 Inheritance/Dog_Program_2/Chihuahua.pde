class Chihuahua extends Dog {
  int numSweaters;
  
  Chihuahua(String n, String g, int w, int ns) {
    super(n, g, "chihuahua", w, true);  //calls the Dog constructor with 5 arguments;
    this.numSweaters = ns;
    this.emoState = "nervous";
  }
  
  void bark() { //overrides the bark method in Dog
    println("Squeak! said " + this.name);
  }
  
  void describe() {
    super.describe(); //This calls the .describe() method from the Dog class
    println("I own " + this.numSweaters + " sweaters.");
  }
  
  
  
}
