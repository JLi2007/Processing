class Hawk extends Bird{
    int numPrey;

    Hawk(String n, String g, int np){
        super(n,g, "Hawk", 70);
        this.numPrey = np;
    }

    void describe(){
        super.describe();
        println(this.name + " has taken down " + this.numPrey + " prey.");
    }

    void call() {
		println( "'SCREECH', says", this.name );
	}

    void eatPrey(){
        println("ate a duck");
        this.numPrey+=1;
    }
}