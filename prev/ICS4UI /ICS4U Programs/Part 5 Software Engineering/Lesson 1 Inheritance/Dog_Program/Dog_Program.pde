void setup() {
  Dog snoopy = new Dog("Snoopy", "male", "beagle", 20, false);
  Dog ginger = new Dog("Ginger", "female", "rottweiler", 63, true);
  
  snoopy.describe();
  ginger.describe();
  
  snoopy.bark();
  ginger.bark();
  
  ginger.takeToVet();
  ginger.describe();
  
  ginger.giveTreat(0.15);
  ginger.describe();
  
  exit();
}
