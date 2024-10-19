class Course {
    String courseCode;
    String teacher;
    ArrayList<Student> students;

    Course(String c, String t){
        this.courseCode = c;
        this.teacher = t;
        this.students = new ArrayList<Student>();
    }

    void addStudent(Student s){
        this.students.add(s);
        s.addCourse(this.courseCode);
    }

    void printStudentsList(){
        println("------------------------------------------------------------");
        println("Students currently enrolled in " + this.courseCode + " taught by ", this.teacher + ":");
        for(Student student: this.students){
            println(student.name);
        }
        println("------------------------------------------------------------");
    }
    
    void removeFailingStudents(){
        ArrayList<Student> failedStudents = new ArrayList<Student>();
        for(Student student: this.students){
            if(student.average<60){
                failedStudents.add(student);
            }
        }
        this.students.removeAll(failedStudents);
    }
}