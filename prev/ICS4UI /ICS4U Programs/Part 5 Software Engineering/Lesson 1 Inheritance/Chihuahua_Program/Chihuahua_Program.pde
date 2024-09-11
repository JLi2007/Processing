void setup() {
  Dog snoopy = new Dog("Snoopy", "male", "beagle", 20, false);
  Dog ginger = new Dog("Ginger", "female", "rottweiler", 50, true);
  Chihuahua ralph = new Chihuahua("Ralph", "male", 4, 3);
  
  snoopy.describe();
  ginger.describe();
  ralph.describe();
  
  snoopy.bark();
  ginger.bark();
  ralph.bark();
  
  ralph.chewSweater();
  ralph.describe();
  
  exit();
}
