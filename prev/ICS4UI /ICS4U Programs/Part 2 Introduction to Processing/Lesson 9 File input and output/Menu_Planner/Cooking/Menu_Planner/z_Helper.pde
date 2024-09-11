String getRandomMeal() {
  if( mealSetCurrent.size() == 0 )
    refillCurrentMealSet();
    
  int randIndex = round( random(0, mealSetCurrent.size()-1) );
  String meal = mealSetCurrent.get( randIndex );
  
  return meal;
}


void buildMonthsArray() {
  months = new Month[12]; 

  //IF NOT A LEAP YEAR
  if ( currYear % 4 > 0 ) {
    for (int i=0; i<12; i++) {
      months[i] = new Month( monthNames[i], monthLengths[i], i);
    }
  }

  //LEAP YEAR
  else {
    for (int i=0; i<12; i++) {
      months[i] = new Month( monthNames[i], monthLengthsLeapYear[i], i);
    }
  }
}



Month getMonthFromName(String monthName) {
  for (int i=0; i < 12; i++) 
    if ( months[i].name.equals(monthName))
      return months[i];
  
  println("ERROR IN getMonthFromName", monthName);
  return null;
}


void refillCurrentMealSet() {
  for( String meal : mealSetOriginal ) {
    mealSetCurrent.add( meal );
  }
}
