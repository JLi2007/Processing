//Global variables
float billAmt = random(10,100);  //can give a variable an initial value if desired...
float hst;              //or just leave it unspecified for now
float total;
String custName = "Big Bird";
String species = "avian";
int numCustomers = 7;
float birdDiscount = 0.10;

//setup
void setup() {
  if (numCustomers > 15) {
    println("Sorry, we can't accommodate that many people");
    println("Try Wendy's");
  } 
  
  else if (numCustomers <= 0) {
    println("You are clearly too dumb to eat here");
  } 
  
  else {
    if (species.equals("avian")) {
      billAmt *= 1 - birdDiscount;
    }
    
    hst = 0.13 * billAmt;
    total = (billAmt + hst) * numCustomers;
    String totalRounded = nf(total, 3, 2);
    println("Welcome", custName + "! Your total is $" + totalRounded);
    println("Come back soon!");
  }
}
