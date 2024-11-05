class Shark extends Fish{
    int numPrey;

    Shark(String n, String g, int np){
        super(n,g, "Shark", 5);
        this.numPrey = np;
    }

    void describe(){
        super.describe();
        println(this.name + " has taken down " + this.numPrey + " prey.");
    }

    void call() {
		println( "'GRRRRRRRRRRRRB', says", this.name );
	}

    void eatPrey(){
        println("ate a family of minnows");
        this.numPrey+=random(100);
    }
}