void setup() {
  float d = dist(0, 0, 90, 100);
  float x = random(45, 60);
  float j = sqrt(56.6456);
  
  float y1 = f(11);
  float y2 = f(-2);
  float y3 = f(-10);
  
  
  float myCatsEnergy = KE(5, 6);
  float garfieldsEnergy = KE(20, 0.01);
  
  println("Nathanial's cat has an energy of", myCatsEnergy, "joules");
  println("Garfield has an energy of", garfieldsEnergy, "joules");
  
  String a = "silence";
  String b = "deafening";
  
  String L = getLongerWord(a, b);
  println(L, "is the longer word");
  
}



 
