class Week {
  Date startDay, endDay;
  String[] meals;
  int weekNum;
  
  Week(Date start, int num ) {
    this.startDay = start;
    this.endDay = start.getLaterDate(6);
    this.weekNum = num;
    this.meals = new String[7];
  }
  
  
  void pickMeals() {
    int numDaysToPlan;
    
    if( takeOutWeek ) 
      numDaysToPlan = 6;
      
    else
      numDaysToPlan = 7;
    
    for( int day = 0; day < numDaysToPlan; day++ ) {
      String candidate = getRandomMeal();
      
      int tries = 1;
      
      while( this.tooRecent( candidate, day ) ) {
        if( tries > 4 )
          refillCurrentMealSet();
          
        candidate = getRandomMeal();
        tries++;
      }
      
      
      this.meals[day] = candidate;
      mealSetCurrent.remove( candidate );
      
      totalDays++;
    }
    
    println();
    
    if( takeOutWeek ) 
      this.meals[6] = "Take out";   
  }
  
  
  void printMeals() {
    String header = this.startDay.toString() + "\u2014" + this.endDay.toString();
    pw.println(header);
    pw.println("*************");
    
    for( String meal : meals )
      pw.println( meal );
      
    pw.println();
  }
  
  
  boolean tooRecent( String candidateMeal, int upToDay ) {
    
    //CHECKS FOR REPETIIONS IN THE PREVIOUS WEEK
    if( this.weekNum > 0 ) {
      Week prevWeek = weeks[this.weekNum-1];
      
      for( int i = 0; i < 7; i++ )
          if ( candidateMeal.equals( prevWeek.meals[i]) ) {
            println("    Repetition found in PREV week", candidateMeal);
            return true;
          }
    }

    //CHECKS FOR REPETIIONS IN THE CURRENT WEEK
    for( int i = 0; i < upToDay; i++ )
      if (candidateMeal.equals( this.meals[i]) ) {
        println("    Repetition found in THIS week", candidateMeal);
        return true;
      }
        
    return false;
  }
}
