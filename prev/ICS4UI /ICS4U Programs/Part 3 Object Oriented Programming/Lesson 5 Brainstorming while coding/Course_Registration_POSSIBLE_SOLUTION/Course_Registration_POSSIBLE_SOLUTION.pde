void setup() {
  
  Student s1 = new Student("Kaitlyn Pereira", 835);
  Student s2 = new Student("Adi Gill", 456);
  Student s3 = new Student("Malek Aborig", 789);
  Student s4 = new Student("Rania Jeong", 412);
  
  Teacher hurley = new Teacher( "Mrs. Hurley" ); 
  Teacher schattman = new Teacher( "Mr. Schattman" );
  Teacher johnson = new Teacher( "Mr. Johnson" );
  
  Course yoga = new Course( "YAM4UI", "Yoga & Meditation", hurley, "B" );
  Course compSci = new Course( "ICS4UI", "Computer Science", schattman, "A" );
  Course helicoptor = new Course( "HMR2OI", "Helicoptor Maintenance & Repair", johnson, "E" );
  Course japanese = new Course( "LJP3UI", "Japanese", hurley, "D" );
  Course ballroom = new Course( "ADB2OI", "Ballroom & Latin Dance", schattman, "B");
  
  yoga.addStudent(s1); 
  yoga.addStudent(s3); 
  
  compSci.addStudent(s1); 
  compSci.addStudent(s2);
  compSci.addStudent(s3);
  compSci.addStudent(s4);
  
  helicoptor.addStudent(s1);
  helicoptor.addStudent(s4);
  
  japanese.addStudent(s1);
  japanese.addStudent(s2);
  
  s1.printTimeTable();   
  s2.printTimeTable(); 
  s3.printTimeTable(); 
  s4.printTimeTable(); 
  
  //ballroom.addStudent(s1); //ILLEGAL. Why?
  
  yoga.printAllStudents();
  compSci.printAllStudents();
  helicoptor.printAllStudents();
  japanese.printAllStudents();
  
  //hurley.printCourseLoad();
  //schattman.printCourseLoad();
  
  String msg = " just rated " + schattman.name;

  s1.rateTeacher(schattman, 6);
  println(s1.name + msg + " a 6");
  println(schattman.name + " now has an average coolness rating of " + schattman.coolness);

  s2.rateTeacher(schattman, 10);
  println(s2.name + msg + " a 10");
  println(schattman.name + " now has an average coolness rating of " + schattman.coolness);

  s3.rateTeacher(schattman, 1);
  println(s3.name + msg + " a 1");
  println(schattman.name + " now has an average coolness rating of " + schattman.coolness);

  s4.rateTeacher(schattman, 3);
  println(s4.name + msg + " a 3");
  println(schattman.name + " now has an average coolness rating of " + schattman.coolness);
  println();
  
  s1.rateTeacher(hurley, 1);
  s2.rateTeacher(hurley, 3);
  s3.rateTeacher(hurley, 2);

  println(hurley.name + " has an average coolness rating of " + hurley.coolness + ". LOL.");
  
  exit();
}
