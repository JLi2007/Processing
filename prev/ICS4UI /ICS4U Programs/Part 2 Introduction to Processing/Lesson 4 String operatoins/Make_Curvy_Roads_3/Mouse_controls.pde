
void mousePressed() {
  for ( PVector d : dots) {
    if ( dist(d.x, d.y, mouseX, mouseY) < r) {
      someDotHasBeenClicked = true;
      selectedDot = d;
    }
  }
}


void mouseReleased() {
  someDotHasBeenClicked = false;
  selectedDot = null; //no value
}


void mouseDragged() {
  if ( someDotHasBeenClicked == true ) {
    selectedDot.x = mouseX;
    selectedDot.y = mouseY;
    setCurveLengths();
    redraw();
  }
}


void keyPressed() {
  if ( key == 'r' || key == 'R') {
    mode = "drag";
    resetTrack();
    resetCar();
    noLoop();
    redraw(); 
  }
  
  else if ( key == 's' || key == 'S' ) {
    mode = "animate";
    resetCar();
    loop();
  }
}
