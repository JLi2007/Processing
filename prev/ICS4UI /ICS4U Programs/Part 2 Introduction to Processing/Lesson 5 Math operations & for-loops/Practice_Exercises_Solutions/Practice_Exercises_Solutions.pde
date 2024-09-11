void setup(){
  
  //EXERCISE 1
  float total = 0.0;
  
  for(float price = 0.0; price <= 193.50; price += 0.50)
    total += price;

  println("The total price is $" + total);
  println();
  
  
  //EXERCISE 2: TO SHOW, FOR EXAMPLE, THAT sin(2x) = 2sin(x)cos(x)
  for(int degAngle = 0; degAngle <= 30; degAngle++) {
    float radA = radians(degAngle);
    float lhs = sin(2*radA);
    float rhs = 2*sin(radA)*cos(radA);
    println("sin(2*" + degAngle + ") = " + lhs + "\t\t" + "2sin(" + degAngle + ")cos(" +  degAngle + ") = " + rhs);
  }

  println();

  //EXERCISE 3
  for(int row = 1; row <= 10; row++) {  //for every row from 1 to 10...
  
    for(int col = 1; col <= 10; col++) {   //...go through the columns 1 to 10 in the current row...
      int entry = row*col;  //calculates the table entry for the current row and column
      print(entry + "\t");  //prints the entry, followed by a tab to prepare the next column
    }
    
    //println(); //IMPORTANT! Prints a new line before moving to the next row
  }

  println();
  
  
  //TESTING EXERCISE 4
  println( roundAny(6.86927, 2) );
  println();
  
  exit();
}

//EXERCISE 4
float roundAny(float x, int d){  //suppose x = 6.86927 and d = 2
  float y = x * pow(10,d);       //y = 686.927
  float z = round(y);            //z = 687
  return z / pow(10,d);          //6.87
}
