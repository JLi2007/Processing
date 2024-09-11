class Dog {
  //FIELDS
  String name;
  int weight;
  String gender;
  String breed;
  String emoState;
  Human owner;
  
  //CONSTRUCTOR METHOD. THIS IS WHAT GETS CALLED BY THE LINE OF CODE Dog haley = new Dog("Haley", 50, "female", "husky");
  Dog(String n, int w, String g, String b) {
    this.name = n;
    this.weight = w;
    this.gender = g;
    this.breed = b;
    this.emoState = "normal";
    this.owner = null;
  }
  
  //METHODS OF THE DOG CLASS.  ALSO CALLED BEHAVIOURS
  void bark(){
    println(this.name + " says woof!");
  }
  
  void getTreat() {
    this.emoState = "happy";
  }
  
  void describe() {
    println(this.name + " is a " + this.gender + " " + this.breed + " and is feeling " + this.emoState + " now");

    if( this.owner != null )
      println("My owner is", owner.name);
      
    else
      println("I am feral and proudly independent.");
      
    println();
  }  
  
  void takeToVet() {
    this.emoState = "nervous";
  }
}
