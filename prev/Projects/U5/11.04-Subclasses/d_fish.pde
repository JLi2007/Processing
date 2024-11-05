class Fish extends Pet {
	String type;
    int size;

	Fish( String n, String g, String t, int s ) {
		super(n,g);
		this.type = t;
		this.size = s;
	}

	void describe() {
		println( this.name + " is a " + this.gender + " " + this.type + " and has a size of " + this.size + "m.");
	}

	void call() {
		println( "'bubbles', says", this.name );
	}
}
