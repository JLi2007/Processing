class Flight {
  
  // FIELDS
  String details;
  String[] fileName;
  String[] optionsSplit;
  
  // CONSTRUCTOR
  Flight( String[] fileStrings) {
    
    // Loads the first line of the file
    this.details = fileStrings[0];
    this.optionsSplit = this.details.split(",");
    this.fileName = fileStrings;
  }
  
  // Determines the relevant distance, based on the user's selection
  float getDistance() {
    String flightPlan = this.optionsSplit[0];
    distance = float (this.optionsSplit[1]);  
    
    boolean foundMatch = false;
    int rowNum = 0;

    // Continue until the match is found and the row number is less than file's length
    while (!foundMatch && rowNum < fileName.length - 1) {  
      
      // Load and split the row
      this.details = this.fileName[rowNum];
      this.optionsSplit = this.details.split(",");
      flightPlan = this.optionsSplit[0];
      distance = int (this.optionsSplit[1]);
      
      // A match was found
      if (flightPlan.equals(selectedRoute)) {
        foundMatch = true;
      }
    
      // A match was not found, so increase the row number
      else {
        rowNum++;
      }
    }
      
  return distance;
  }
}
