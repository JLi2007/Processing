class Bank {
  //FIELDS
  String name;
  ArrayList<BankAccount> allAccounts;
  
  //CONSTRUCTOR
  Bank(String n) {
    this.name = n;
    allAccounts = new ArrayList(); //this creates an empty list
  }
  
  
  void addAccount(BankAccount ba) {
    allAccounts.add( ba );
  }
  
  
  void printAllAccounts() {
    println(this.name);
    println("*********************");
    for(int i = 0; i < allAccounts.size(); i++ ) {
      allAccounts.get(i).printSummary();
    }
  }
  
  
}
