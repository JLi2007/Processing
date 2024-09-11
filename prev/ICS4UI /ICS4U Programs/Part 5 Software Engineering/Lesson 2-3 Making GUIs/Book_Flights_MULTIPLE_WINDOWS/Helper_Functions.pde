void loadDetails(Airline a) {
  
  // Once the user has selected the departuring and arrival city, get the route 
  if (originChosen && arrivalChosen) { 
    
    // Combine the two country codes
    selectedRoute = selectedOrigin + " to " + selectedArrival;
    
    // Open the distances file
    distanceFile = loadStrings("Distances.txt");
    routeInfo = new Flight(distanceFile);
    
    // If this route matches the one in file, then calculate the price
    routeInfo.getDistance();
     
    // Calculate the ticket and baggage cost
    ticketCost = (a.price * distance) / passengers; 
    baggageCost = a.baggageCosts * numBaggage;
  } 
}

void createLogo() {
  
  // Air Fromage was selected
  if (chosenAirline.equals(airFromage)) {
    image(airFromageLogo, 615, 315);
  }
  
  // Vector Air was picked
  else if (chosenAirline.equals(vectorAir)) {
    image(vectorAirLogo, 630, 300);
  }
}
