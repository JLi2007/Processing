void setup(){
   Student Charlie = new Student("Charlie", 8342234, 9, 95.6);
   Student Vidul = new Student("Vidul", 7344335, 11, 85.7);
   Student Tanujan = new Student("Tanujan", 6342234, 12, 90.5);
   Student Wang = new Student("Wang", 5342234, 9, 100);
   Student Ronaldo = new Student("Ronaldo", 4342234, 10, 57.8);
  
   Course programming = new Course("Y7U2NG2", "Jeffrey.Zang");


   Charlie.addCourse("K887GW3");
   Charlie.addCourse("877NWBD");
   Charlie.addCourse("PZA12D3");


   // print timetable #1 to show initial timetable
   Charlie.printTimetable();


   // add students to the course
   programming.addStudent(Charlie);
   programming.addStudent(Vidul);
   programming.addStudent(Tanujan);
   programming.addStudent(Wang);
   programming.addStudent(Ronaldo);


   programming.printStudentsList();
   // test the remove failing list method
   programming.removeFailingStudents();
   programming.printStudentsList();


   // print timetable #2 to check if programming code is added to the students timetable
   Charlie.printTimetable();


   exit();
}
