class Bird extends Pet {
	String species;
    int speed;

	Bird( String n, String g, String sp, int s ) {
		super(n,g);
		this.species = sp;
		this.speed = s;
	}

	void describe() {
		println( this.name + " is a " + this.gender + " " + this.species + " and has a speed of " + this.speed + " km/h.");
	}

	void call() {
		println( "'Chirp', says", this.name );
	}
}
