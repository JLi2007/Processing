void setup() {
  Dog haley = new Dog("Haley", 50, "female", "husky");
  Dog sully = new Dog("Sully", 90, "male", "golden retriever");
   
  haley.describe();
  haley.getTreat();
  haley.describe();
  
  println();
  
  sully.describe();
  sully.takeToVet();
  sully.describe();
    
  println();
   
  haley.bark();
  sully.bark();
  
  exit();
}
