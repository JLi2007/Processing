class Chihuahua extends Dog {
  
  int numSweaters;
  
  Chihuahua(String n, String g, int ns) {
    super(n, g, "chihuahua", 3.0, false);
    this.numSweaters = ns;
    this.emoState = "nervous";
  }
  
  void describe() {
    super.describe();
    println(this.name + " owns " + this.numSweaters + " sweaters.");
  }
  
  
  void bark() {
    println("Yipe! said " + this.name);
  }
  
  
  void chewSweater() {
    println(this.name + " is chewing now.");
    this.numSweaters = max(0, this.numSweaters - 1);
  }
}
