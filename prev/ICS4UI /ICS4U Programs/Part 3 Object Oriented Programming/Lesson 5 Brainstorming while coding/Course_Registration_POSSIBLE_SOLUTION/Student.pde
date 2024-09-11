class Student {
  String name;
  int studentNumber;
  Course[] timeTable;
  int currIndex;
       
  Student(String n, int sn){
    this.name = n;
    this.studentNumber = sn;
    timeTable = new Course[4];
    this.currIndex = 0;
  }
  
  
  //CHALLENGE: EXPLAIN HOW THIS METHOD WORKS
  void rateTeacher(Teacher t, float coolness ) {
    float previousCoolnessAverage = t.coolness;
    
    float totalCoolness = t.numRatings * previousCoolnessAverage;
    totalCoolness += coolness;
    
    t.coolness = totalCoolness/(t.numRatings + 1);
    t.numRatings++; 
  }
  
  
  void printTimeTable(){
    HelperMethods.printSmartHeader( this.name + " time table" );
    
    for(int i=0; i < currIndex; i++){
      timeTable[i].printCourseInfo();
    }  
    
    println();
  }
  
  
  //COULD WE ADD ANOTHER LOGIC CHECK TO MAKE SURE THAT ALL 4 COURSES HAVE DIFFERENT PERIODS?
  void addCourseToTimeTable( Course c ) {
    if (currIndex <= 3) {
      timeTable[ currIndex ]  = c;
      currIndex++;
    }
    
    else
      println("Sorry, " + this.name + "'s time table is already full. Cannot add course " + c.courseCode);
      println();
      
  }
}
