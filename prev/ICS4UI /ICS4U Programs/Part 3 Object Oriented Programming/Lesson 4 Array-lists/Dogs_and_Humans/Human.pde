class Human {
  String name;
  ArrayList<Dog> dogsIown;
  
  //Constructor
  Human(String n) {
    this.name = n;
    this.dogsIown = new ArrayList<Dog>();//This creates space in RAM for an empty list of Dog objects
  }
  
  void adopt( Dog d ) {  
    d.owner = this;  
    dogsIown.add( d );
  }
  
  void listAllDogs() {
    for( Dog d : this.dogsIown ) {
      println( this.name, "owns", d.name );
    }
      
  }

}
