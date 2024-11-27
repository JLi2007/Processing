class Airline {
  
  // FIELDS
  String airline;
  String mealCost;
  int numStars;
  float price;
  float baggageCosts;
  
  // CONSTRUCTOR
  Airline (String name, int ns, float p, String mc, float bc) {
    this.airline = name;
    this.numStars = ns;
    this.price = p;
    this.mealCost = mc;
    this.baggageCosts = bc;    
   
  }
  
  // METHODS
  void describe() {
    
    // Number of stars are greater than 2
    if (numStars > 2) {
      text("This airline is rated " + this.numStars + " stars due to its devotion to cheese. It charges $" + nfc(this.price, 2) + " per km and extra baggage costs $" + nfc(this.baggageCosts, 2) + ". Ratatouille may be a potential passenger as well.", 50, 130, 720, 720);
    }
    
    else {
      text("This airline has a solid " + this.numStars + " stars due to its frugal spending, but it makes up for it by charging $" + nfc(this.price, 2) + " per km! Extra baggage costs $" + nfc(this.baggageCosts, 2) + ". Reroutes can be expected as our pilot wants to steal the moon." , 50, 280, 720, 720);
    }
  }

  void drawPass() {
    
    // Meal options
    String[] possibleMeals = {"French Omelette", "Butter Chicken", "Spicy Ramen", "Teriyaki Sub", "Vegetarian Burrito", "Cheese Taco"};
    int randomNum = int (random(0, 5));
    
    // Draw the main outline
    fill(255);
    strokeWeight(2);
    rect(50, 100, 700, 300);  
    
    // Draw the coloured border
    fill(173, 216, 230);
    rect(50, 100, 700, 50);
    
    // Draw QR code image
    image(scanner, 60, 290);
    
    // Text formatting
    textSize(30);
    fill(0);
    
    // Title
    text("Boarding Pass", 630, 140);
    text(selectedAirline, 135, 140);
    
    // Trip Information
    textSize(20);
    text("TRIP ROUTE: " + selectedRoute, 170, 200);
    text("DISTANCE: " + distance + "km", 153, 250);
    text("MEAL: " + possibleMeals[randomNum], 400, 330);
    text("PETS: " + pets.getSelectedText(), 400, 370);
    noLoop(); 
    
    // Costs
    text("EXTRA BAGGAGE COST: $" + nfc(baggageCost, 2), 600, 200);
    text("TICKET PER PERSON: $" + nfc(ticketCost, 2), 602, 250);
    
    // Create the correct company's logo
    createLogo();
    
    // For every passenger, save a boarding pass
    for (int i = 1; i < passengers + 1; i++) {
      
      // Creates the file and folder 
      String boardingPassDirectory = "Boarding Passes/";
      String boardingNumber = "Passenger " + i + ".jpg";
 
      // Saves it as a JPG file
      String fullPath = boardingPassDirectory + boardingNumber;
      save(fullPath);
    }
  }

  void warnUser() {
    
    // Meals are free
    if (this.mealCost.equals("free")) {
      text( "The selected airline offers " + this.mealCost + " meals. The total price comes to $" + nfc(ticketCost, 2) + " per person.", 400, 375);  
    }
    
    // Meals must be paid for
    else if (this.mealCost.equals("paid")) {
      text( "Additional meal charges will apply, please pay at the gate. The total price comes to $" + nfc(ticketCost, 2) + " per person.", 400, 375);        
    }
  }
}
