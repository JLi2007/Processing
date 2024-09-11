
void setup() {
  BankAccount a1 = new BankAccount("Hamza", "314-159", 5.34);
  a1.printSummary();
  a1.withdraw( 300.00 ); 
  a1.printSummary();
  
  BankAccount a2 = new BankAccount("Azim", "271-818", 500.00);
  a2.printSummary();
  a2.deposit( 10000.00 );
  a2.printSummary();
  
 
  Bank TD = new Bank("Totally Dishonest Bank of Kanada");
  TD.addAccount(a1);
  TD.addAccount(a2);
  TD.printAllAccounts();
   
}
