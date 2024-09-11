class Performance {
  String day;    //e.g. "FRIDAY, NOVEMBER 28TH"
  String time;   //e.g. "7:00 p.m."
  String timeDoorsOpen;   //e.g. "6:30 p.m."
  color ticketColour;
  Ticket[] tickets;  
  
  Performance(String d, String t, String tdo, color c) {
    this.day = d;
    this.time = t;
    this.timeDoorsOpen = tdo; 
    this.ticketColour = c;
  }
  
  
  //FILLS THE tickets[] ARRAY FOR THIS PERFORMANCE
  void createTickets() {
    int numTickets = 0;
    
    for(int i=0; i < sections.length; i++)  //CALCULATES THE NUMBER OF TICKETS NEEDED BY ADDING UP THE SECTION SIZES
      numTickets += sections[i].numSeats;
    
    tickets = new Ticket[ numTickets ];  //ALLOCATES SPACE IN RAM FOR THAT MANY TICKET OBJECTS
    
    int i = 0;        //INDEX OF THE TICKET OBJECT THAT'S ABOUT TO BE CREATED
    String rowLabel;  //"AAA", "BBB", etc.
    int seatNumber;   //1-13
    
    for(int secNum = 0; secNum < sections.length; secNum++) { //FOR EACH OF THE 3 SECTIONS IN THE AUD...
      Section sec = sections[ secNum ];
      
      //FOR ALL BUT THE LAST ROW IN THIS SECTION...
      for( int row = 0; row < sec.numRows - 1; row++ ) {
        for( int col = 0; col < sec.numSeatsPerRow; col++ ) {
          rowLabel = sec.rowLabels[row];  //"AAA", "BBB", etc.
          seatNumber = col + 1;           //SO THAT THE FIRST SEAT IN A ROW STARTS AT 1 AND NOT 0
          tickets[i] = new Ticket(this, sec, rowLabel, seatNumber);  //CREATES THE TICKET OBJECT FOR THIS SEAT
          i++;
        }          
      }
      
      //FOR THE LAST ROW IN THIS SECTION (THE ONE WITH PLASTIC CHAIRS)...
      for( int k = 0; k < sec.numSeatsInLastRow; k++ ) {
         rowLabel = sec.rowLabels[ sec.numRows-1 ]; //ONE OF "NNN", "NN" OR "N"
         seatNumber = k + 1;
         tickets[i] = new Ticket(this, sec, rowLabel, seatNumber);
         i++;
      }
    }    
  }
  
  
  void createTicketSheets() {
    int numSheets = ceil( this.tickets.length / float(numTicketsPerSheet) );   //ceil MEANS ROUND UP TO THE NEXT INTEGER   
    int i = 0; //TICKET INDEX AT WHICH THE CURRENT SHEET TO BE PRINTED STARTS
    
    for( int n = 0; n < numSheets; n++ ) {
      createSheet(n+1, i);
      i += numTicketsPerSheet;
    }
  }
  
  
  void createSheet(int sheetNum, int iStart) {
    int i = iStart;
 
    for(int col = 0; col < numTicketsPerRow; col++) {
      int x1 = col * ticketWidth;  //X-COORDINATE OF THE LEFT EDGE OF THE TICKET ABOUT TO BE DRAWN
      
      for(int row = 0; row < numTicketsPerColumn; row++) {
        int y1 = row * ticketHeight;    //Y-COORDINATE OF THE TOP EDGE OF THE TICKET ABOUT TO BE DRAWN
        
        try {
          this.tickets[i].drawMe(x1, y1); //DRAWS THE CURRENT TICKET IN ITS CORRECT PLACE ON THE SHEET
          i++;
        }
        catch(Exception e) {}
      }
    }
    
    //SETS THE FOLDER NAME & FILE NAME FOR THE SHEET THAT WAS JUST DRAWN. EXAMPLE: "sheets/FRI/FRI 7.jpg" 
    String sheetDirectory = "sheets/" + this.day.substring(0,3) + "/";  //SO THAT EACH DAY'S PERFORMANCE WILL HAVE ITS OWN SEPARATE FOLDER LABELED "THU", "FRI" OR "SAT"
    String sheetTitle = this.day.substring(0,3) + " " + sheetNum + ".jpg";
    String sheetFullPath = sheetDirectory + sheetTitle;
    
    save( sheetFullPath ); //SAVES THE .jpg FILE TO THE CORRECT DIRECTORY AND WITH THE CORRECT NAME 
  }
  
  
  void printTicketInfoToConsole() {  //USED ONLY FOR QUICKLY TESTING THAT THE ticket[] ARRAY WAS CREATED CORRECTLY
    for(int i=0; i < tickets.length; i++) 
      tickets[i].printSummary();
  }
}
