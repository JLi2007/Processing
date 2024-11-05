class Chihuahua extends Dog {              //Making Chihuahua a subclass of Dog.
					      //This means Chihuahua has the same fields and 
     //methods of Dog, plus any others we add below.

	int numSweaters;     //A field unique to Chihuahuas. Other Dog objects don’t have this.
			         //Thus, every Chihuahua object has 5 fields:  numSweaters plus the 4 
		                       //fields it inherits from Dog, its superclass.

	Chihuahua( String n, String g, int ns )  {
	      super( n, g, "chihuahua" );     //super() calls the Dog constructor with 3 arguments,
					     //which sets name to n, gender to g, breed to
				 	     //"chihuahua" 
	      this.emoState = "nervous";    //Overriding the default value of the field emoState
	      this.numSweaters = ns;          //Setting the 5th field value
	}

	//More methods to come. For now, we’ll just have a constructor.

    void bark(){
        println("YIpIYPYIPYIPYIPYIP");
    }

    void describe(){
        super.describe();
        println(this.name + " has eaten " + this.numSweaters + " sweaters.");
    }

    void chewSweater(){
        println("ate sweater");
        this.numSweaters += 1;
    }
}
