void mouseMoved() {
  if ( sourceMotionMode.equals("mouse") ) {
    xPos = mouseX; 
    yPos = mouseY;
  }
}


void mouseClicked()
{
  clearRings();
  xPos = mouseX;
  yPos = mouseY;
  xCentre = mouseX;
  yCentre = mouseY;
  xSpeed = xSpeedOrig;
  ySpeed = ySpeedOrig;
}
