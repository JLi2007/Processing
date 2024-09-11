class BankAccount {
  //FIELDS
  String client;
  String acctNum;
  float balance;
  
  //CONSTRUCTOR.  A CONSTRUCTOR IS A PROCEDURE WE CAN USE FOR BUILDING A NEW BankAccount OBJECT AND ASSIGNING ITS FIELD VALUES
  BankAccount(String c, String an, float initBal) {
    this.client = c;
    this.acctNum = an;
    this.balance = initBal;
  }
  
  //METHODS or BEHAVIOURS ARE PROCEDURES/FUNCTIONS INSIDE A CLASS
  void printSummary() {
    println("Client name: \t" + this.client);
    println("Acct number: \t" + this.acctNum);
    println("Balance: \t $" + this.balance);
    println();
  }
  
  void deposit(float amt) {
    this.balance += amt;
  }
  
  
  void withdraw(float amt) {
    if(this.balance >= amt)
      this.balance -= amt;
      
    else
      println("Insufficient funds lol :-p ");
  }
}
