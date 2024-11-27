void displayScreen() {
  fill(0);
  
  // Display initial screen
  if (windowName.equals("start")) {
    background(clouds);
    
    // Text formatting
    myFont = createFont("Snap ITC", 60);
    textFont(myFont);
    textAlign(CENTER);
    
    // Draw title
    text("Flight Finder", width/2, 225);
    
    // Display/hide the relevant buttons
    baggage.setVisible(false);
    confirmation.setVisible(false);
    numPassengers.setVisible(false);
    departure.setVisible(false);
    airline.setVisible(false);
    arrival.setVisible(false);
    back.setVisible(false);
    about.setVisible(true);
    browsing.setVisible(true);
    pets.setVisible(false);
  }
  
  
  // Display the "help" screen
  else if (windowName.equals("help")) {
    background(helpBackground);
    textAlign(LEFT);
    
    helpScreen();
    
    // Hide/show the relevant buttons
    baggage.setVisible(false);
    confirmation.setVisible(false);
    numPassengers.setVisible(false);
    departure.setVisible(false);
    airline.setVisible(false);
    arrival.setVisible(false);
    back.setVisible(true);
    about.setVisible(false);
    browsing.setVisible(false);
    pets.setVisible(false);
  }
  
  // User wants to start browsing for flights
  else if (windowName.equals("browse")) {
    background(main);
    
    // Formatting
    myFont = createFont("Constantia", 18);
    textFont(myFont);
    
    // Display labels
    text("Departure", 110, 115);
    text("Arrival", 98, 210);
    text("Pick an Airline", 400, 30);
    text("Passenger(s)", 606, 115);
    text("Check-in Baggage", 606, 210);
    
    // Hide/show the relevant buttons
    baggage.setVisible(true);
    numPassengers.setVisible(true);
    departure.setVisible(true);
    airline.setVisible(true);
    arrival.setVisible(true);
    about.setVisible(false);
    browsing.setVisible(false);
    back.setVisible(true);
    pets.setVisible(true);
    
    // Only show the confirmation button if all fields have been entered
     if (originChosen && arrivalChosen && passengerValue && baggageClaimed) { 
       
       // The user is flying to and from the same place
       if (selectedArrival.equals(selectedOrigin)) {
         fill(217, 33, 33);
         text("Please select another destination", 150, 300);   
       }
       
       // User entered more than 6 passengers
       if (passengers >= 7) {
         fill(217, 33, 33);
         text("ERROR 404: Passenger limit of 6 exceeded", 606, 175);
       }
       
       // Else, inform the user that they cannot change their selections
       else {
         text("Note: You cannot return to this page after", 400, 410);
         
         // Display confirmation button
         chosenAirline.warnUser();
         confirmation.setVisible(true);
       }
     }
  } 
  
  // User has confirmed their choices
  else if (windowName.equals("confirm")) {
    background(250, 218, 221);
    
    // Hide/show the relevant buttons
    baggage.setVisible(false);
    confirmation.setVisible(false);
    numPassengers.setVisible(false);
    departure.setVisible(false);
    airline.setVisible(false);
    arrival.setVisible(false);
    back.setVisible(false);
    about.setVisible(false);
    browsing.setVisible(false);
    pets.setVisible(false);
    
    chosenAirline.drawPass();
  } 
}

void helpScreen() {
  
  // Sets font and draws title 
  myFont = createFont("Constantia Bold", 25);
  textFont(myFont);
  text("About our Airlines", 310, 50);
  
  // Airline name and description
  myFont = createFont("Constantia", 20);
  textFont(myFont);
  text("Air Fromage", 50, 100);
  text("Vector Air", 50, 250);
  line(50, 102, 150, 102);
  line(50, 252, 130, 252);
  
  // Describe each airline
  airFromage.describe();
  vectorAir.describe();
}
