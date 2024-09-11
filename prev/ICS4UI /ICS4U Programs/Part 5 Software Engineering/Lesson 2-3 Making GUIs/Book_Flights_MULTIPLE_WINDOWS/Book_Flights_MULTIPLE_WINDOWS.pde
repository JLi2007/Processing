// TITLE: BOOK FLIGHTS
// DESCRIPTION: Users can select their preferred airline for travelling, and can choose from several countries. Then, their boarding passes are saved in a folder for ease of access.
// PROGRAMMER: Nadia Anwar
// DATE: June 23, 2023

import g4p_controls.*;

String windowName = "start"; // initial window state
String selectedOrigin, selectedArrival, selectedAirline;
String selectedRoute, destination;
String[] distanceFile;

float distance, ticketCost;
float baggageCost;

int passengers, numBaggage;

boolean originChosen = false;
boolean arrivalChosen = false;
boolean airlinePicked = false;
boolean passengerValue = false;
boolean baggageClaimed = false;

PImage main, airFromageLogo, vectorAirLogo;
PImage clouds, scanner, helpBackground;
PFont myFont;

Flight routeInfo;
Airline airFromage, vectorAir, chosenAirline;  

void setup(){
  size(800, 600);
  background(255);
  createGUI();
  
  // Create new airline objects
  airFromage = new Airline ("Air Fromage", 4, 0.70, "free", 19.99); // name, stars, price/km, meal option, extra baggage costs  
  vectorAir = new Airline ("Vector Air", 2, 1.05, "paid", 26.50);
  
  // Load and resize images
  scanner = loadImage("Images/qrCode.jpg");
  scanner.resize(100, 100);
  
  airFromageLogo = loadImage("Images/airFromage.jpg");
  airFromageLogo.resize(120, 70);
  
  vectorAirLogo = loadImage("Images/vectorAir.jpg");
  vectorAirLogo.resize(100, 100);
  
  clouds = loadImage("Images/clouds.jpg");
  clouds.resize(800, 600);
  
  helpBackground = loadImage("Images/helpBackground.jpg");
  helpBackground.resize(800, 600);
  
  main = loadImage("Images/main.jpg");
  main.resize(800, 600);
}

void draw(){
  
  displayScreen();
}
