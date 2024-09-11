void mouseDragged() {
  clickCount = 0;
  fill(255); noStroke();
  points.add( new PVector(mouseX, mouseY) );
  square(mouseX, mouseY, 6);
}


void mouseReleased() {
  if( showCircleFromAlgo1 )
    rotatingTriangleAlgorithm();
    
  if( showCircleFromAlgo2 )
    centerOfMassAlgorithm();
  
  points.clear();
}


void mouseClicked() {
  redraw(); 
  fill(255); noStroke();
  square( mouseX, mouseY, 10);
  
  PVector clickedPoint = new PVector(mouseX, mouseY);
  
  //USER CLICKS THE 1ST POINT OF THE CIRCLE
  if( clickCount == 0 ) {
    a = clickedPoint;
    clickCount++;
  }
  
  //USER CLICKS THE 2ND POINT
  else if( clickCount == 1) {
    b = clickedPoint;
    clickCount++;
  }
  
  //USER CLICKS THE 3RD AND FINAL POINT
  else if( clickCount == 2 ) {
    c = clickedPoint;
    
    clickCount = 0;
    
    Circle k = new Circle(a, b, c, color(255, 255, 0)); //CREATES THE CIRCLE THAT PASSES THRU POINTS a, b, c
    k.drawMe(4);
  }
}


void keyPressed() {
  if(key == ' ') {     //SPACEBAR TO CLEAR THE SCREEN
    background(0);  
    printInstructions();
  }
}
