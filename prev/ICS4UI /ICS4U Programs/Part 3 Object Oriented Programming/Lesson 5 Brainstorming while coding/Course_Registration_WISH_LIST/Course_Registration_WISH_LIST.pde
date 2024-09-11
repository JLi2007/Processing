void setup() {
  
  Student a = new Student("Ally", "888-999"); 
  Student m = new Student("Mark", "956-304"); 
  Student z = new Student("Ziad", "456-222");
  Student v = new Student("Vanessa", "911-052");
  Student d = new Student("Dylan", "831-052");
  
  Course yogMed = new Course("Yoga & Meditation", "YGM4U", "Mr. Schattman"); 
  Course scramEgg = new Course("Scrambled Egg Technology", "YGM4U", "Ms. Zorzitto");
  
  yogMed.addStudent(m); 
  yogMed.addStudent(d); 
  
  scramEgg.addStudent(a);
  scramEgg.addStudent(v);
  scramEgg.addStudent(d);
}
