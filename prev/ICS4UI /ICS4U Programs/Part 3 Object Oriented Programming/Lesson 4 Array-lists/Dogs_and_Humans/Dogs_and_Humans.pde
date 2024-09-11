void setup() {
  Dog haley = new Dog("Haley", 50, "female", "husky");
  Dog sully = new Dog("Sully", 90, "male", "golden retriever");
  Dog sohil = new Dog("Sohil", 120, "male", "chihuahua");
  
  Human sean = new Human("Sean");
  
  sean.adopt(sully);
  sean.adopt(haley);
 
  haley.describe();
  sully.describe();
  sohil.describe();
  
  sean.listAllDogs();
  
}
