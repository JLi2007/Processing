ArrayList<Pet> Zoo;

void setup () {   //Main program

    Zoo = new ArrayList<Pet>();

	Zoo.add(new Dog("Patrick", "male", "lab"));
    Zoo.add(new Chihuahua("Charlie", "female",10));
    Zoo.add(new Bird("Hawk", "male", "seagull", 30));
    Zoo.add(new Hawk("Vidul", "female", 100));
    Zoo.add(new Fish("Man", "male", "piranha", 2));
    Zoo.add(new Shark("Fishboy", "female", 500));
    
    
    for(Pet animal: Zoo){
        animal.describe();
    }

    exit();
}
