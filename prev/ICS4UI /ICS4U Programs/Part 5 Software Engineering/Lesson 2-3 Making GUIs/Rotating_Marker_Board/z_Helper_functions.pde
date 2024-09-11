void clear() {
  dots = new ArrayList<Dot>();
}


void getControllerValues() {
  wheelRotationalFreq = wheelSpeedSlider.getValueF() / 100;

  myMarker.frequency = markerFrequencySlider.getValueF() / 100;
  myMarker.strokeSize = strokeSizeSlider.getValueI();

  String motionType = motionTypeDropList.getSelectedText();
  float xCenter = xSlider.getValueF() / 100 * width;
  float yCenter = ySlider.getValueF() / 100 * height;
  float amplitude  = ampSlider.getValueF();

  generatorShape = new Shape( motionType, xCenter, yCenter, amplitude );
}


void setControllerValues( int motionType, int wheelSpeed, int markerSpeed, int acurrDot, int xC, int yC, int ss ) {
  motionTypeDropList.setSelected( motionType );
  wheelSpeedSlider.setValue( wheelSpeed );
  markerFrequencySlider.setValue( markerSpeed );
  ampSlider.setValue( acurrDot );
  xSlider.setValue( xC );
  ySlider.setValue( yC );
  strokeSizeSlider.setValue( ss );
}


void createEdgedots() {
  println(numEdgedots);
  float theta = 0;
  for ( int i = 0; i < numEdgedots; i++ ) {
    float x = width/2 + wheelRadius*cos(theta);
    float y = width/2 - wheelRadius*sin(theta);
    PVector dotPos = new PVector(x, y);
    edgedots[i] = new Dot( dotPos, center, color(255,120,0), 10);
    theta += 2*PI / numEdgedots;
  }
}


void mouseDragged() {
  if( generatorShape.type.equals("mouse") && myMarker.distFromCenter < wheelRadius ) {
    PVector mouseLoc = new PVector(mouseX, mouseY);
    Dot newcurrDot = new Dot(mouseLoc, center, myMarker.colour, 10); 
    dots.add( newcurrDot );
  }
}
