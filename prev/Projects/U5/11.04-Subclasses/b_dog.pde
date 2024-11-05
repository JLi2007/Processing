class Dog extends Pet {
	String breed, emoState;

	Dog( String n, String g, String b ) {
		super(n,g);
		this.breed = b;
		this.emoState = "normal";
	}

	void describe() {
		println( this.name + " is a " + this.gender + " " + this.breed + " and is feeling " +    
           		                      this.emoState + " today.");
	}

	void bark() {
		println( "'Woof!' says", this.name );
	}
}
