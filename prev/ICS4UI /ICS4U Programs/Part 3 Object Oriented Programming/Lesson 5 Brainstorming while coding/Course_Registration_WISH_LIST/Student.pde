class Student {
  String name, studentNumber;
  Course[] timeTable;
  int numCourses; //how many courses the student has already signed up for
       
  Student(String n, String sn){
    this.name = n;
    this.studentNumber = sn;
    this.numCourses = 0;
    this.timeTable = new Course[4];  //creates an empty array of 4 student objects
  }
  
  
  void addCourse( Course p ) {
    this.timeTable[ this.numCourses  ] = p;
    this.numCourses++;
  }
  
  
  void glueChair( Teacher victim ) {
    victim.meanness++;
    victim.failStudent(this);
  }
   
   
  void printTimeTable(){
    //code later
  } 
}
