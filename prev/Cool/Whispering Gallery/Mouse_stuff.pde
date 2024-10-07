void mouseClicked() {
  xBulb = mouseX - width/2;
  yBulb = height/2 - mouseY;
  
  if (e.eval(xBulb, yBulb) < 0) 
    bulb = new Bulb( xBulb, yBulb, raySpeed, numRays);
}
