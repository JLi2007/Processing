class Teacher {
  String name;
  String subject; //or how about ArrayList<String> subject, since a teacher might have more than 1 area?
  boolean gender; //or float?
  float coolness;
  float danceAbility;
  float meannessLevel;
  Course[] courseLoad;
  int currIndex;
  int numRatings;
  
  Teacher(String n) {
    this.name = n;
    this.courseLoad = new Course[3];
    this.currIndex = 0;
    this.coolness = 0;
    this.numRatings = 0;
  }
  
  
  void printCourseLoad(){
    HelperMethods.printSmartHeader( this.name + "'s course load" );
    
    for(int i=0; i < currIndex; i++){
      println( courseLoad[i].courseCode + "\t" + courseLoad[i].courseTitle + "\t" + courseLoad[i].period);
    }  
    
    println();
  }
  
  
  void addCourseToCourseLoad( Course c ) {
    if (currIndex <= 2) {
      courseLoad[ currIndex ]  = c;
      currIndex++;
    }
    
    else
      println("Sorry, " + this.name + "'s course load is already full. Cannot add course " + c.courseCode);
  }
  
}
