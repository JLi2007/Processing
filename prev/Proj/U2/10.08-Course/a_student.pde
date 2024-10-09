class Student{
    String name;
    int number;
    int grade;
    float average;
    String[] timetable;

    Student(String n, int num, int g, float a ){
        this.name = n;
        this.number = num;
        this.grade = g;
        this.average = a;
        this.timetable = new String[4];
    }

    void addCourse(String c){
        for(int slot=0; slot<timetable.length; slot++){
            if(timetable[slot]==null){
                timetable[slot] = c;
                return;
            }
        }
        println("no more slots in timetable! Cannot add " + c + ":");
        return;
    }

    void printTimetable(){
        println("Courses for " + this.name);
        printArray(timetable);
    }
}