/*
  THIS PROGRAM FITS A PERFECT CIRCLE TO A ROUGH, HAND-DRAWN CIRCLE MADE BY THE USER.
 THE USER CAN EITHER DRAG TO DRAW POINTS THAT THE CIRCLE SHOULD BE FITTED TO,
 OR CLICK 3 ISOLATED POINTS THAT THE FITTED CIRCLE WILL GO THROUGH.
 
 THE PROGRAM PROVIDES TWO ALGORITHMS FOR FITTING A CIRCLE:
 (1) THE ROTATED-TRIANGLE ALGORITHM
 (2) THE CENTER-OF-MASS ALGORITHM
 
 SEE THE Algorithms TAB FOR DETAILS
 */

//Try changing these
boolean showCircleFromAlgo1 = true;  //ROTATING-TRIANGLE ALGORITHM
boolean showCircleFromAlgo2 = true;  //CENTER-OF-MASS ALGORITHM
boolean showAveragedCircles = false;

//Other global variables
color RTcolor = color(0, 200, 200);
color CMcolor = color(255, 0, 0);
ArrayList<PVector> points = new ArrayList();  //THE USER'S DRAWN POINTS
int clickCount = 0;
PVector a, b, c;  //3 POINTS THE USER CLICKS TO DRAW A CIRCLE THROUGH


void setup() {
  noFill();
  size(800, 700);
  background(0);
  rectMode(CENTER);
  printInstructions();
}


void draw() {  //NOT NEEDED, AS NOTHING GETS DRAWN UNTIL THE USER DOES THINGS WITH THE MOUSE
}


void printInstructions() {
  textAlign(LEFT); fill(255); strokeWeight(1); textSize(18);
  text("Click 3 times anywhere to make a circle through the 3 points", 20, 20);
  text("Or draw with the mouse to see a circle of best fit", 20, 45);
  text("SPACEBAR to clear the screen", 20, 100);

  noFill(); strokeWeight(3); stroke(RTcolor);
  circle( 30, 70, 20);
  text( "Rotating-Triangle algorithm", 60, 75);

  strokeWeight(3); stroke(CMcolor);
  circle( 340, 70, 20);
  text("Center-of-Mass algorithm", 360, 75);
}
