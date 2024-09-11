class Dog {
  //FIELDS
  String name;
  int weight;
  String gender;
  String breed;
  String emoState;
  
  //CONSTRUCTOR. THIS IS WHAT GETS CALLED BY THE LINE OF CODE Dog haley = new Dog("Haley", 50, "female", "husky");
  Dog(String n, int w, String g, String b) {
    this.name = n;
    this.weight = w;
    this.gender = g;
    this.breed = b;
    this.emoState = "normal";
  }
  
  //METHODS OF THE DOG CLASS. ALSO CALLED BEHAVIOURS
  void describe() {
    println( "Hi, my name's", this.name + 
            "! I am a", this.gender, this.breed, 
            "and I'm feeling", this.emoState + " now.", 
            "I weigh", this.weight, "pounds." );
  }  
  
  
  void getTreat() {
    println( this.name, "just got a treat!" );
    this.emoState = "happy";
  }
  
  
  void takeToVet() {
    println( this.name, "is at the vet!" );
    this.emoState = "nervous";
  }
  
  
  void bark(){
    println( "WOOF! says", this.name );
  }
}
