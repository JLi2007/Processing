class Section {
  String label;           //"Left", "Centre", "Right"
  String[] rowLabels;     //{"AAA", "BBB","CCC",...}
  int numRows;            //Includes the last row of blue plastic chairs
  int numSeatsPerRow;     //For all but the last row
  int numSeatsInLastRow;  //The number of blue plastic chairs in the section
  int numSeats;           //Total number of seats in the section
  
  
  Section(String l, int nr, int nspr, int nsilr) {
    this.label = l;
    this.numRows = nr;
    
    this.numSeatsPerRow = nspr;
    this.numSeatsInLastRow = nsilr;
    
    this.rowLabels = new String[ this.numRows ];
    this.setRowLabels();
    
    this.computeNumSeats();
  }
  
  
  void computeNumSeats() {
    this.numSeats = (this.numRows-1) * this.numSeatsPerRow + this.numSeatsInLastRow;  //SINCE THE LAST ROW HAS FEWER SEATS THAN THE OTHERS
  }
  
    
  void setRowLabels() {
    String rowLetter; 
    
    if( this.label.equals( "Left" ) ) {           //LEFT SECTION     
      for(int i = 0; i < rowLabels.length; i++) {
        rowLetter = possibleRowLetters[i];
        this.rowLabels[i] = rowLetter + rowLetter + rowLetter;   //USE TRIPLE LETTERS "AAA", "BBB", etc.
      }
    }
    
    else if( this.label.equals( "Centre" ) ) {     //CENTRE SECTION  
      for(int i = 0; i < rowLabels.length; i++) {
        rowLetter = possibleRowLetters[i+1];         //i+1 BECAUSE THE CENTRE SECTION SKIPS ROW "AA" (IT STARTS WITH "BB")
        this.rowLabels[i] = rowLetter + rowLetter;   //USE DOUBLE LETTERS "BB", "CC", etc.
      }     
    }
    
    else if( this.label.equals( "Right" ) ) {       //RIGHT SECTION  
      for(int i = 0; i < rowLabels.length; i++) {
        rowLetter = possibleRowLetters[i];
        this.rowLabels[i] = rowLetter;  //USE SINGLE LETTERS "A", "B", "C", etc.
      }      
    }
  }
}
