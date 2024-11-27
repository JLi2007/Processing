/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void cntrlWind_draw(PApplet appc, GWinData data) { //_CODE_:cntrlWind:641954:
  appc.background(230);
} //_CODE_:cntrlWind:641954:

public void pauseButtonClicked(GButton source, GEvent event) { //_CODE_:pauseButton:908536:
  paused = !paused;

  if (pauseButton.getText().equals("Pause")) {
    pauseButton.setText("Resume");
    pauseButton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  } else {
    pauseButton.setText("Pause"); 
    pauseButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  }
} //_CODE_:pauseButton:908536:

public void clearButtonClicked(GButton source, GEvent event) { //_CODE_:clearButton:541041:
  clearCars();

} //_CODE_:clearButton:541041:

public void inflowChanged(GSlider source, GEvent event) { //_CODE_:inflow:404157:
   carInflow = inflow.getValueI(); 
} //_CODE_:inflow:404157:

public void agrChanged(GSlider source, GEvent event) { //_CODE_:agr:320121:
   agrFac = agr.getValueI();
} //_CODE_:agr:320121:

public void speedChanged(GSlider source, GEvent event) { //_CODE_:speed:691064:
   constMaxS  = speed.getValueF(); 
} //_CODE_:speed:691064:

public void accChanged(GSlider source, GEvent event) { //_CODE_:acc:415984:
   constMaxAcc = acc.getValueF();
} //_CODE_:acc:415984:

public void decChanged(GSlider source, GEvent event) { //_CODE_:dec:561936:
   constMaxDec = dec.getValueF();
} //_CODE_:dec:561936:

public void passChanged(GSlider source, GEvent event) { //_CODE_:pass:213506:
   contantPass = pass.getValueF();
} //_CODE_:pass:213506:

public void offRChanged(GSlider source, GEvent event) { //_CODE_:offR:445234:
   offRampChance = offR.getValueF();
} //_CODE_:offR:445234:

public void onRChanged(GSlider source, GEvent event) { //_CODE_:onR:679771:
  onRampChance = onR.getValueF();
} //_CODE_:onR:679771:

public void speedLimitChanged(GSlider source, GEvent event) { //_CODE_:speedLimit:319867:
  highWaySpeedLimit = speedLimit.getValueF();
} //_CODE_:speedLimit:319867:

public void laneNumberChanged(GTextField source, GEvent event) { //_CODE_:laneNumber:895754:
  int currentLaneNumber = int(laneNumber.getText());
  if (currentLaneNumber == 0) {
    currentLaneNumber = 1;
    
  } else if (currentLaneNumber > 5) {
    currentLaneNumber = 5;  
  }
  
  if (currentLaneNumber < lastLaneNumber) {
    int count = lastLaneNumber - currentLaneNumber;
    
    for (int i = 0; i < count; i++) {
      currentRoad.decreaseLanes();  
    }
    
  } else if (currentLaneNumber > lastLaneNumber) {
    int count = currentLaneNumber - lastLaneNumber;
    
    for (int i = 0; i < count; i++) {
      currentRoad.increaseLanes();  
    }
    
  }
  lastLaneNumber = currentLaneNumber;
} //_CODE_:laneNumber:895754:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  cntrlWind = GWindow.getWindow(this, "Control Window", 0, 0, 550, 455, JAVA2D);
  cntrlWind.noLoop();
  cntrlWind.setActionOnClose(G4P.KEEP_OPEN);
  cntrlWind.addDrawHandler(this, "cntrlWind_draw");
  pauseButton = new GButton(cntrlWind, 15, 19, 80, 30);
  pauseButton.setText("Pause");
  pauseButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  pauseButton.addEventHandler(this, "pauseButtonClicked");
  clearButton = new GButton(cntrlWind, 114, 19, 80, 30);
  clearButton.setText("Clear");
  clearButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  clearButton.addEventHandler(this, "clearButtonClicked");
  inflow = new GSlider(cntrlWind, 23, 106, 100, 45, 10.0);
  inflow.setLimits(1, 1, 30);
  inflow.setNumberFormat(G4P.INTEGER, 0);
  inflow.setOpaque(false);
  inflow.addEventHandler(this, "inflowChanged");
  label1 = new GLabel(cntrlWind, 24, 83, 80, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.BOTTOM);
  label1.setText("Car Inflow");
  label1.setTextBold();
  label1.setOpaque(false);
  agr = new GSlider(cntrlWind, 22, 205, 100, 45, 10.0);
  agr.setShowValue(true);
  agr.setShowLimits(true);
  agr.setLimits(0, 0, 5);
  agr.setNbrTicks(5);
  agr.setStickToTicks(true);
  agr.setShowTicks(true);
  agr.setNumberFormat(G4P.INTEGER, 0);
  agr.setLocalColorScheme(GCScheme.RED_SCHEME);
  agr.setOpaque(false);
  agr.addEventHandler(this, "agrChanged");
  label2 = new GLabel(cntrlWind, 20, 183, 120, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Aggression Factor");
  label2.setTextBold();
  label2.setLocalColorScheme(GCScheme.RED_SCHEME);
  label2.setOpaque(false);
  speed = new GSlider(cntrlWind, 23, 306, 100, 45, 10.0);
  speed.setShowValue(true);
  speed.setShowLimits(true);
  speed.setLimits(30.0, 10.0, 120.0);
  speed.setShowTicks(true);
  speed.setNumberFormat(G4P.DECIMAL, 2);
  speed.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  speed.setOpaque(false);
  speed.addEventHandler(this, "speedChanged");
  label3 = new GLabel(cntrlWind, 24, 283, 80, 20);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("Max Speed");
  label3.setTextBold();
  label3.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  label3.setOpaque(false);
  acc = new GSlider(cntrlWind, 24, 406, 100, 45, 10.0);
  acc.setShowValue(true);
  acc.setShowLimits(true);
  acc.setLimits(1.5, 0.5, 6.0);
  acc.setShowTicks(true);
  acc.setNumberFormat(G4P.DECIMAL, 2);
  acc.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  acc.setOpaque(false);
  acc.addEventHandler(this, "accChanged");
  label4 = new GLabel(cntrlWind, 24, 383, 110, 20);
  label4.setTextAlign(GAlign.CENTER, GAlign.CENTER);
  label4.setText("Max Acceleration");
  label4.setTextBold();
  label4.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label4.setOpaque(false);
  dec = new GSlider(cntrlWind, 183, 105, 100, 45, 10.0);
  dec.setShowValue(true);
  dec.setShowLimits(true);
  dec.setLimits(2.0, 1.0, 8.0);
  dec.setShowTicks(true);
  dec.setNumberFormat(G4P.DECIMAL, 2);
  dec.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  dec.setOpaque(false);
  dec.addEventHandler(this, "decChanged");
  label5 = new GLabel(cntrlWind, 180, 83, 110, 20);
  label5.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label5.setText("Max Deceleration");
  label5.setTextBold();
  label5.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  label5.setOpaque(false);
  pass = new GSlider(cntrlWind, 183, 206, 100, 45, 10.0);
  pass.setShowValue(true);
  pass.setShowLimits(true);
  pass.setLimits(20.0, 0.0, 50.0);
  pass.setShowTicks(true);
  pass.setNumberFormat(G4P.DECIMAL, 2);
  pass.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  pass.setOpaque(false);
  pass.addEventHandler(this, "passChanged");
  label6 = new GLabel(cntrlWind, 182, 183, 110, 20);
  label6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label6.setText("Pass Lane Factor");
  label6.setTextBold();
  label6.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  label6.setOpaque(false);
  offR = new GSlider(cntrlWind, 183, 306, 100, 45, 10.0);
  offR.setShowValue(true);
  offR.setShowLimits(true);
  offR.setLimits(30.0, 0.0, 50.0);
  offR.setShowTicks(true);
  offR.setNumberFormat(G4P.DECIMAL, 2);
  offR.setOpaque(false);
  offR.addEventHandler(this, "offRChanged");
  label7 = new GLabel(cntrlWind, 183, 283, 110, 20);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("Off Ramp Factor");
  label7.setTextBold();
  label7.setOpaque(false);
  label8 = new GLabel(cntrlWind, 184, 383, 110, 20);
  label8.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label8.setText("On Ramp Factor");
  label8.setTextBold();
  label8.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  label8.setOpaque(false);
  onR = new GSlider(cntrlWind, 183, 403, 100, 45, 10.0);
  onR.setShowValue(true);
  onR.setShowLimits(true);
  onR.setLimits(5.0, 0.0, 50.0);
  onR.setShowTicks(true);
  onR.setNumberFormat(G4P.DECIMAL, 2);
  onR.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  onR.setOpaque(false);
  onR.addEventHandler(this, "onRChanged");
  label9 = new GLabel(cntrlWind, 336, 29, 150, 20);
  label9.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label9.setText("Highway Speed Limit");
  label9.setTextBold();
  label9.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  label9.setOpaque(false);
  speedLimit = new GSlider(cntrlWind, 362, 57, 100, 45, 10.0);
  speedLimit.setShowValue(true);
  speedLimit.setShowLimits(true);
  speedLimit.setLimits(25.0, 10.0, 100.0);
  speedLimit.setShowTicks(true);
  speedLimit.setNumberFormat(G4P.DECIMAL, 2);
  speedLimit.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  speedLimit.setOpaque(false);
  speedLimit.addEventHandler(this, "speedLimitChanged");
  laneNumber = new GTextField(cntrlWind, 353, 168, 131, 23, G4P.SCROLLBARS_NONE);
  laneNumber.setText("1");
  laneNumber.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  laneNumber.setOpaque(true);
  laneNumber.addEventHandler(this, "laneNumberChanged");
  label10 = new GLabel(cntrlWind, 356, 143, 125, 20);
  label10.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label10.setText("Number of Lanes");
  label10.setTextBold();
  label10.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  label10.setOpaque(false);
  cntrlWind.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow cntrlWind;
GButton pauseButton; 
GButton clearButton; 
GSlider inflow; 
GLabel label1; 
GSlider agr; 
GLabel label2; 
GSlider speed; 
GLabel label3; 
GSlider acc; 
GLabel label4; 
GSlider dec; 
GLabel label5; 
GSlider pass; 
GLabel label6; 
GSlider offR; 
GLabel label7; 
GLabel label8; 
GSlider onR; 
GLabel label9; 
GSlider speedLimit; 
GTextField laneNumber; 
GLabel label10; 
