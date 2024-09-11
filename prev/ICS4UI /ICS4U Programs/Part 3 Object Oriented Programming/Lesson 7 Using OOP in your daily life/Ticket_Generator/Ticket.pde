class Ticket {
  Performance performance;
  Section section;  //"Left", "Centre", "Right"
  String row;       //"AAA", "CC", etc.
  int seat;         //1-13
  
  
  Ticket( Performance p, Section sec, String r, int s ) {
    this.performance = p;
    this.section = sec;
    this.row = r;
    this.seat = s;
  }
  
  
  //DRAWS THIS TICKET WITH ITS UPPER LEFT CORNER AT (x1, y1)
  void drawMe( int x1, int y1 ) { 

    //FILLS IN THE BACKGROUND WITH THE TICKET COLOUR & A BLACK RECTANGULAR OUTLINE
    fill( this.performance.ticketColour );
    stroke(0);
    strokeWeight(2);
    rect(x1, y1, ticketWidth, ticketHeight);
    
    //DRAWS THE LOGO IMAGE ON THE LEFT SIDE OF THE TICKET
    int xImg1 = int(x1 + 0.03*ticketWidth);
    int xImg2 = xImg1 + graphicWidth;
    int yImg1 = int(y1 + 0.20*ticketHeight);
    image( ticketGraphic, xImg1, yImg1 ); 
    
    //"Laurel Heights presents..."
    int xLHSS = xImg1;
    int yLHSS = int(y1 + 0.10*ticketHeight);
    
    //DRAWS THE TEXT Above THE IMAGE
    fill(0);
    textAlign(LEFT, TOP);
    textFont( ticketFontTitle ); //FOR PRINTING EVERYTHING EXCEPT THE "Doors open at..."
    text( "Laurel Heights Secondary School presents", xLHSS, yLHSS );
    
    //MAIN TEXT
    textAlign( CENTER, TOP );
    textFont( ticketFontDate ); //FOR PRINTING EVERYTHING EXCEPT THE "Doors open at..."
   
    int xText1 = xImg2;  //WHERE THE TEXT WILL BEGIN
    int xText2 = x1 + ticketWidth;   //THE RIGHT EDGE OF THE TICKET
    int xTextMid = (xText1 + xText2)/2;
    
    int yDate = int(y1 + 0.30*ticketHeight);;
    text( this.performance.day + " @ " + this.performance.time, xTextMid, yDate );
    
    textFont( ticketFontDoorsOpen ); 
    int yDoorsOpenAt = int(y1 + 0.45*ticketHeight);
    text( "Doors open at " + this.performance.timeDoorsOpen, xTextMid, yDoorsOpenAt );
    
    textFont( ticketFontSeat ); 
    textAlign(LEFT, TOP);

    int xSection = int(xImg2 + 0.05*textWidth);
    int yHeaders = int(y1 + 0.75*ticketHeight);    
    int xRow = int(xImg2 + 0.45*textWidth);
    int xSeat = int(xImg2 + 0.70*textWidth);
    text( "SECTION", xSection, yHeaders );
    text( "ROW", xRow, yHeaders );
    text( "SEAT", xSeat, yHeaders );

    int ySeatInfo = int(y1 + 0.85*ticketHeight );
    text( this.section.label, xSection, ySeatInfo );  //PRINTING THE SEAT INFO 
    text( this.row, xRow, ySeatInfo );
    text( this.seat, xSeat, ySeatInfo );    
  }
  
  
  //USED ONLY FOR TESTING THAT THE TICKET WAS CREATED WITH THE CORRECT INFO
  void printSummary() { 
    Section s = this.section;
    println("SECTION: " + s.label + "\t" + this.row + "\t" + this.seat);
  }
  
  

}
