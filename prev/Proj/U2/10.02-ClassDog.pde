class Dog{
    String name;
    String gender;
    float weight;
    String breed;
    String emoState;
    float aggression;
    
    Dog(String n, String g, String b,float w,int a) {
        this.name = n;
        this.gender = g;
        this.breed = b;
        this.weight = w;
        this.aggression = a;
        this.emoState = "normal";
    }
    
    void describe() {
        println("Hi my name is " + this.name + ", I'm a " + this.gender + ", I'm a  " +  this.breed +  ", I weigh " + this.weight + " Pounds, I feel " + this.emoState + ", My aggression is " + this.aggression);
    }
    
    void giveTreat(float treatWeight) {
        this.emoState = "happy";
        this.weight += treatWeight;
    }
    
    void takeToVet() {
        this.emoState = "nervous";
    }
    
    void bark() {
        println("Woof! said " + this.name);
        this.aggression *= 0.9;
    }
    
}

void setup() {
    Dog myPet = new Dog("Mandy", "female", "rottweiler", 80, int(random(5)));
    Dog yourPet = new Dog("Peanut", "male", "terrier", 35, int(random(5)));
    
    myPet.describe();
    yourPet.describe();
    println();
    
    // bark and describe to show the 10% decrease
    for (int n = 1; n <= 4; n++) {
        yourPet.bark();
        println(yourPet.aggression);
    }
    exit();
}
