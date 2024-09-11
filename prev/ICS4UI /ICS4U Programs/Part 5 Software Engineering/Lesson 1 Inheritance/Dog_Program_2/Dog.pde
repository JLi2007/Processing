class Dog {
  String name, breed, gender, emoState;
  int weight;
  boolean isDangerous;

  Dog( String n, String g, String b, int w, boolean id) {
    this.name = n;
    this.gender = g;
    this.breed = b;
    this.weight = w;
    this.isDangerous = id;
    this.emoState = "normal";
  }


  void bark() {
    println("Woof!" + " said " + this.name);
  }


  void describe() {
    String description = this.name + " is a " + this.gender + " " + this.breed  +
                        " and is feeling " + this.emoState + " now." + " Current weight: " + this.weight + " pounds.";

    if ( this.isDangerous )
      description += " Caution! May bite!";
   
    println( description );

  }
  
  
  void takeToVet() {
    this.emoState = "nervous";
  }
  
  
  void giveTreat( float weightOfTreat ) {
    this.emoState = "happy";
    this.weight += weightOfTreat;
  }
  
  Dog[] breedWith( Dog mate ) {
    Dog[] theLitter;
    if( this.gender.equals("male") && mate.gender.equals("female") || 
    this.gender.equals("female") && mate.gender.equals("male")) {
      int size = int(random(1,8));
      theLitter = new Dog[size];
      String theGender;
      
      for(int i = 0; i < size; i++ ) {
        float x = random(0,1);
        
        if ( x <= 0.5 )
          theGender = "male";
          
        else
          theGender = "female";
          
        String theName= "puppy #" + (i+1);
        
        theLitter[i] = new Dog(theName, theGender, this.breed, 10, false);
        
      }
      
      return theLitter;
      
    }
    
    else 
      return null;
  }
}
