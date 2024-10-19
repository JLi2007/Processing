void setup() {
  ComplexNum z = new ComplexNum(6, 8);
  ComplexNum w = new ComplexNum(-2.5, -7.9);
  ComplexNum i = new ComplexNum(0, 1);
  
  z.printMe();  //would print 6 + 8i  
  w.printMe();   
  i.printMe();     
  
  float absZ = z.absoluteValue();
  float absI = i.absoluteValue();

  println( absZ );    //Should print 10.0
  println( absI );    //Should print 1.0
  
  ComplexNum zPlusW = z.add( w );
  zPlusW.printMe();    //Should print "3.5+0.1i"
  
  ComplexNum wPlusI = w.add( i );
  wPlusI.printMe();    //Does it print the right thing?

  exit();
}
