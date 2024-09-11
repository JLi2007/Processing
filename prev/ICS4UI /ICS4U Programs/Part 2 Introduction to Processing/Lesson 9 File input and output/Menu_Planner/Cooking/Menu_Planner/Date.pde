class Date {
  Month month;
  int day, year;
  String monthAndDay;
  String contents;

  //CONSTRUCTOR #1
  Date(String monthName, int d) {
    this.month = getMonthFromName(monthName);
    this.day = d;
    this.year = currYear; //the current year read from the Course Data file
    this.monthAndDay = monthName + " " + str(d);
    this.contents = "";
  }

  //CONSTRUCTOR #2
  Date(Month m, int d) {
    this.month = m;
    this.day = d;
    this.year = currYear; //the current year read from the Course Data file
    this.monthAndDay = m.name + " " + str(d);
    this.contents = "";
  }
  
  //CONSTRUCTOR #3
  Date(String whole) {
    String monthName = whole.substring(0,3);
    this.month = getMonthFromName( monthName );

    if( includesYear( whole ) ) {
      int commaIndex = whole.indexOf(",");
      this.day = int(whole.substring(4, commaIndex));
      this.year = int(whole.substring(commaIndex+2, whole.length()));
    }
    
    else {
      this.day = int(whole.substring(4, whole.length()));
      this.year = currYear;
    }
    
    this.monthAndDay = whole;
    this.contents = "";
  }
      
  
  Date getLaterDate(int numDaysAfter) {
    int newDayNumber = this.day + numDaysAfter;
    
    if( newDayNumber <= this.month.numDays )
      return new Date(this.month, newDayNumber);
      
    else {
      int dayOfNextMonth = newDayNumber - this.month.numDays;
      String nextMonthName = monthNames[ this.month.index + 1];
      return new Date(nextMonthName, dayOfNextMonth);
    }
  }
  

  Date getNextDay() {
    return getLaterDate( 1 );
  }
  
  
  String toString() {
    return this.monthAndDay;
  }
  
  
  boolean includesYear(String whole) {
    if( whole.indexOf(",") == -1 )
      return false;
      
    else
       return true;
  }
  
  
  boolean equals(Date other) {
    if (! this.month.name.equals(other.month.name))
      return false;
      
    if( this.day != other.day)
      return false; 
      
    if( this.year != other.year)
      return false;
      
    return true;
  }
}
