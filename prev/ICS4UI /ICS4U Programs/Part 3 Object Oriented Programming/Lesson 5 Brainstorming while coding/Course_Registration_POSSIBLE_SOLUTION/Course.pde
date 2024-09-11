class Course {
  String courseCode;
  String courseTitle;
  int gradeLevel;
  Teacher teacher;
  int numStudents;
  ArrayList<Student> studentsRegistered;
  String period;
  
  Course(String cc, String title, Teacher t, String p) {
    this.courseCode = cc;
    this.courseTitle = title;
    this.teacher = t;
    this.period = p;
    studentsRegistered = new ArrayList<Student>();
    this.teacher.addCourseToCourseLoad( this );
  }
  
  
  void addStudent( Student s ) {
    studentsRegistered.add(s);
    s.addCourseToTimeTable( this );
  }
  
  
  void printCourseInfo() {
    println(this.courseCode + "\t" + this.teacher.name);
  }
  
  
  void printAllStudents() {
    String headerMsg =  "Students Registered for " + this.courseCode + " " + this.courseTitle;
    
    HelperMethods.printSmartHeader( headerMsg );
    
    for(int i = 0; i < studentsRegistered.size(); i++ ){
      Student s = studentsRegistered.get(i);
      println( s.name + "\t" + s.studentNumber );
    }
    
    println();
  }
  
  

  
}
