class BaseTen{
  float constant;
  int exponent;
  String number;
  
  //constructor 1
  BaseTen(String n){
    this.constant = getConstant(n);
    this.exponent = getExponent(n);
    this.simplify();
  }
  
  //constructor 2
  BaseTen(float cons, int exp){
    this.constant = cons;
    this.exponent = exp;
    this.simplify();
  }
  
  //gets constant value from string
  float getConstant(String n){
    float cons = parseFloat(split(n, " ")[0]);
    return cons;
  }
  
  //gets exponent value from string
  int getExponent(String n){
    int exp = parseInt(split(n, "^")[1]);
    return exp;
  }
  
  //multiples one BaseTen object by another
  BaseTen multiply(BaseTen other){
    float cons = this.constant * other.constant;
    int exp = this.exponent + other.exponent;
    return new BaseTen(cons, exp);
  }
  
  //divides one BaseTen object by another
  BaseTen divide(BaseTen other){
    float cons = this.constant / other.constant;
    int exp = this.exponent - other.exponent;
    return new BaseTen(cons, exp);
  }
  
  //gets the string equalivilent of the BaseTen object
  String string(float cons, int exp){
    String str = cons + " * 10^" + exp;
    return str;
  }
  
  //subtracts one BaseTen object by another
  BaseTen subtract(BaseTen other){
    float smallerCons;
    float cons;
    int exp;
    if (this.exponent > other.exponent){
      smallerCons = other.constant / pow(10, this.exponent - other.exponent);
      exp = this.exponent;
      cons = this.constant - smallerCons;
    }
    else{
      smallerCons = this.constant / pow(10, other.exponent - this.exponent);
      exp = other.exponent;
      cons = smallerCons - other.constant;
    }
    return new BaseTen(cons, exp);
  }
  
  //converts BaseTen type to float
  float convFloat(){
    return this.constant * pow(10, this.exponent);
  }
  
  //simplifies number to proper scientific notation
  void simplify(){
    String[] parts = split(str(this.constant), ".");
    if (parts[0].length() > 1){
      this.constant = this.constant / pow(10, parts[0].length() - 1);
      this.exponent = this.exponent + parts[0].length() - 1;
    }
    else if (parts[0].equals("0")){
      int zeros = 1;
      for (int i = 0; i < parts[1].length(); i++){
        if (str(parts[1].charAt(i)).equals("0")){
          zeros++;
        }
        else{
         break; 
        }
      }
      this.constant = this.constant * pow(10, zeros);
      this.exponent = this.exponent - zeros;
    }
    this.number = string(this.constant, this.exponent);
  }
  
  //prints out number
  void display(){
    println(this.number);
  }
  
}