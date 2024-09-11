void setup() {
  Fraction e = new Fraction( 1, 2 );  
  Fraction f = new Fraction( 5, 3, "f" );  
  Fraction g = new Fraction( 20, 80, "g" );

  //USING THE display() METHOD
  e.display();
  f.display();
  g.display();


  println();

  //USING THE reduce() METHOD
  //g.reduce();
  //g.display();

  //println();
         
 // USING THE toDecimal() METHOD
  //float fDecimal = f.toDecimal();
  //float gDecimal = g.toDecimal();
  //println( f.label + " is equivalent to " + fDecimal);
  //println( g.label + " is equivalent to " + gDecimal);






  //println();

  //USING METHODS THAT CREATE AND RETURN NEW FRACTION OBJECTS: reciprocal(), multiply(), add(), power()
  //Fraction oneOverF = f.reciprocal(); 
  //oneOverF.display();

  //Fraction oneOverG = g.reciprocal();
  //oneOverG.display();
  
  //println();

  //Fraction prodFG = f.multiply(g);
  //prodFG.display();
 
  
  
 // println();

  //YOUR TURN: CODE THE power() METHOD
  //Fraction fToTheFour = f.power(4);
  //fToTheFour.display();

  ////CODE THE add() METHOD
  //Fraction sumFG = f.add(g);
  //sumFG.display();


  //USING STATIC METHODS OF THE FRACTION CLASS: getGCD AND getLCM
  //STATIC MEANS THAT THE METHOD DOESN'T WORK WITH ANY PARTICULAR FRACTION OBJECT.
  //THAT IS, THE METHOD BELONGS TO THE CLASS AS A WHOLE, AND NOT TO ANY PARTICULAR OBJECT OF THAT CLASS.
  //STATIC METHODS ARE CALLED INSIDE setup() USING THE SYNTAX Fraction.staticMethodName() INSTEAD OF f.methodName() WHERE f IS SOME FRACTION OBJECT

  //int gcd = Fraction.getGCD(12, 15);
  //int lcm = Fraction.getLCM(12, 15); //CODE THE getLCM() METHOD
}
