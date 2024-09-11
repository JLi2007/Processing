void setup() {
  Dog snoopy = new Dog("Snoopy", "male", "beagle", 20, false);
  Dog ginger = new Dog("Ginger", "female", "rottweiler", 50, true);
  Chihuahua beverly = new Chihuahua("Beverly", "female", 11, 6);
  
  snoopy.describe();
  ginger.describe();
  beverly.describe();
  beverly.bark();
  
  //snoopy.bark();
  //ginger.bark();
  
  //ginger.takeToVet();
  //ginger.describe();
  
  //ginger.giveTreat(2);
  //ginger.describe();
  
  //exit();
  
  //Dog[] myLitter = snoopy.breedWith ( ginger );
  //for(int i = 0; i<myLitter.length; i++) {
  //  myLitter[i].describe();
  //  myLitter[i].bark();
  //}
}
