
//AUDITORIUM PARAMETERS - Change to suit whatever venue you're in
String[] possibleRowLetters = { "A","B","C","D","E","F","G","H","J","K","L","M","N"};  //THERE IS NO ROW "I". "N" IS THE ROW OF PLASTIC CHAIRS AT THE BACK
String[] sectionNames = { "Left", "Centre", "Right" };
int[] sectionNumRows = {13, 12, 13};     //NUMBER OF ROWS IN EACH SECTION
int[] sectionSeatsPerRow = {7, 13, 7};   //NUMBER OF SEATS PER ROW IN EACH SECTION
int[] sectionSeatsInLastRow = {7, 13, 8}; //NUMBER OF PLASTIC CHAIRS IN THE LAST ROW OF EACH SECTION

//PERFORMANCE PARAMETERS - Change to suit whatever showtimes you want
String[] performanceDays = { "THU DEC 1", "FRI DEC 2", "SAT DEC 3"};
String[] times = { "7:00 p.m.", "7:00 p.m.", "2:00 p.m."};
String[] timesDoorsOpen = { "6:30 p.m.", "6:30 p.m.", "1:30 p.m."};
color[] ticketColours = { color(255),  color(255), color(255) };
//color[] ticketColours = { color(230,230,255),  color(255,230,230), color(230,255,230) };

//TICKET PRINTING PARAMETERS - Change to suit any size style you want
int sheetWidth = 1650, sheetHeight = 1275;                      //THE SIZE OF AN 8 1/2 x 11 INCH SHEET OF PAPER
int numTicketsPerRow = 3, numTicketsPerColumn = 4;              //10 TICKETS PER SHEET (IN 5 ROWS OF 2)
int totalSeats, numTicketsPerSheet, ticketWidth, ticketHeight;  //WILL BE CALCULATED INSIDE setup()
String logoImageName = "Last Resort logo3.png";
PImage ticketGraphic;                                           //THE LOGO IMAGE
int graphicWidth, textWidth;                                    //WIDTH OF THE LOGO IMAGE & THE TEXT PRINTED ON THE TICKETS
PFont ticketFontTitle, ticketFontDate, ticketFontDoorsOpen, ticketFontSeat;

//ARRAYS
Section[] sections = new Section[ sectionNames.length ];
Performance[] performances = new Performance[ performanceDays.length ];


void setup() {
  size(1650, 1275); 
  
  int numPerformancesToPrint = performances.length;  //or 1 to just test Friday
  
  //SETS THE TICKET WIDTH & HEIGHT, AND RESIZES THE LOGO IMAGE SO IT FITS ON A TICKET
  setTicketLayout();
  
  //CREATES SECTION OBJECTS USING THE AUDITORIUM PARAMETERS ABOVE
  for(int i = 0; i < sectionNames.length; i++)  
    sections[i] = new Section( sectionNames[i], sectionNumRows[i], sectionSeatsPerRow[i], sectionSeatsInLastRow[i]);
    
  //COMPUTES THE TOTAL NUMBER OF SEATS IN THE AUD, INCL BLUE PLASTIC CHAIRS. SHOULD BE 338.
  for(int i = 0; i < sectionNames.length; i++)  
    totalSeats += sections[i].numSeats;
  
  //CREATES PERFORMANCE OBJECTS USING THE PERFORMANCE PARAMETERS ABOVE
  for(int i = 0; i < numPerformancesToPrint ; i++) //performances.length
    performances[i] = new Performance( performanceDays[i], times[i], timesDoorsOpen[i], ticketColours[i] );
  
  //CREATES AND PRINTS TICKET SHEETS AS .jpg FILES
  for(int i = 0; i < numPerformancesToPrint; i++) {
    performances[i].createTickets();
    performances[i].createTicketSheets();
  }
  
  exit();
}


//SETS THE TICKET WIDTH & HEIGHT, AND RESIZES THE LAST RESORT LOGO IMAGE SO IT FITS ON A TICKET
void setTicketLayout() {
  numTicketsPerSheet = numTicketsPerRow * numTicketsPerColumn;
  ticketWidth = sheetWidth / numTicketsPerRow; 
  ticketHeight = sheetHeight / numTicketsPerColumn;
  
  graphicWidth = int(0.75*ticketHeight);            //SINCE THE IMAGE IS SQUARE AND SHOULD BE AS TALL AS THE TICKET ITSELF
  textWidth = ticketWidth - graphicWidth; //THE SPACE AVAILABLE FOR PRINTING TEXT ON THE TICKET

  ticketGraphic = loadImage( logoImageName );
  ticketGraphic.resize( graphicWidth, graphicWidth );
  
  String coolTitleFont = PFont.list()[192]; 
  String coolInfoFont = PFont.list()[176]; 
  
  ticketFontTitle = createFont(coolTitleFont, 20);
  ticketFontDate = createFont(coolInfoFont, 24);
  ticketFontDoorsOpen = createFont(coolInfoFont, 18);
  ticketFontSeat = createFont(coolInfoFont, 22);
  
}
