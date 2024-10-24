//TOOLS WE'LL LEARN:  substring(), length(), indexOf(), int(), float()

void setup() {
  String cellNum = "(519) 823-9209";
  
  String areaCode = cellNum.substring(1, 4);
  println("Area code is", areaCode);
  
  int hyphenIndex = cellNum.indexOf("-");
  
  String lastDigits = cellNum.substring( hyphenIndex+1 );
  println("The last digits are", lastDigits);
  
  int indexOfSpace = cellNum.indexOf(" ");
  int indexOfDash = cellNum.indexOf("-");
  
  String middleStuff = cellNum.substring(indexOfSpace+1, indexOfDash);
  println("Middle is", middleStuff);
  
  float middleStuffNumber = float(middleStuff);
  
  if (middleStuffNumber %2 == 0) {
    println("Even");
  }
    
  else {
    println("Odd");
  }
  exit();
}
  
  
