class Course {
  String courseCode, courseName, teacher;
  ArrayList<Student> regList;
  
  
  Course(String cc, String cn, String t) {
    this.courseCode = cc;
    this.courseName = cn;
    this.teacher = t;
    this.regList = new ArrayList(); //creates the empty list ready to receive data
  }
  
  
  void addStudent( Student x ) {
    this.regList.add( x );
    //also add this course to x's time tabl
  }
  
  
  void printClassList() { 
    //code later
  }
  
}
