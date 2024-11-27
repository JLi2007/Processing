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

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:controlsWindow:363976:
  appc.background(230);} //_CODE_:controlsWindow:363976:

public void pauseButtonClicked(GButton source, GEvent event) { //_CODE_:pauseButton:443939:
  paused =!paused;
  
  if(paused)
    pauseButton.setText("Resume");
    
  else
    pauseButton.setText("Pause");
    
} //_CODE_:pauseButton:443939:

public void clearButtonClicked(GButton source, GEvent event) { //_CODE_:clearButton:271273:
  clear();} //_CODE_:clearButton:271273:

public void motionTypeDropListChanged(GDropList source, GEvent event) { //_CODE_:motionTypeDropList:483852:
  generatorShape.type = motionTypeDropList.getSelectedText();
  
  if ( generatorShape.type.equals("mouse" ));
    strokeSizeSlider.setValue( 1 );
    
  clear();
} //_CODE_:motionTypeDropList:483852:

public void wheelSpeedSliderChanged(GSlider source, GEvent event) { //_CODE_:wheelSpeedSlider:583919:
  wheelRotationalFreq = wheelSpeedSlider.getValueF()/100;
  clear();
} //_CODE_:wheelSpeedSlider:583919:

public void markerFrequencySliderChanged(GSlider source, GEvent event) { //_CODE_:markerFrequencySlider:559546:
  getControllerValues();
  clear();
} //_CODE_:markerFrequencySlider:559546:

public void showGeneratorCheckBoxChanged(GCheckbox source, GEvent event) { //_CODE_:showGeneratorCheckBox:340036:
  showShape = !showShape;
} //_CODE_:showGeneratorCheckBox:340036:

public void xSliderChanged(GSlider source, GEvent event) { //_CODE_:xSlider:835759:
  getControllerValues();
  clear();
} //_CODE_:xSlider:835759:

public void ySliderChanged(GSlider source, GEvent event) { //_CODE_:ySlider:855293:
  getControllerValues();
  clear();
} //_CODE_:ySlider:855293:

public void ampSliderChanged(GSlider source, GEvent event) { //_CODE_:ampSlider:928422:
  getControllerValues();
  clear();
} //_CODE_:ampSlider:928422:

public void demoButton1Clicked(GButton source, GEvent event) { //_CODE_:demoButton1:829479:
  setControllerValues(0, 1, 12, 190, 50, 74, 2);
  getControllerValues();
  wheelDirection = 1;
  clear();
  
} //_CODE_:demoButton1:829479:

public void demoButton2Clicked(GButton source, GEvent event) { //_CODE_:demoButton2:581809:
  setControllerValues(0, 3, 5, 136, 63, 79, 3);
  getControllerValues();
  wheelDirection = 1;
  clear();
} //_CODE_:demoButton2:581809:

public void demoButton3Clicked(GButton source, GEvent event) { //_CODE_:demoButton3:796115:
  setControllerValues(2, 2, 5, 100, 50, 72, 3);
  getControllerValues();
  wheelDirection = 1;
  clear();
} //_CODE_:demoButton3:796115:

public void demoButton4Clicked(GButton source, GEvent event) { //_CODE_:demoButton4:619428:
  setControllerValues(1, 1, 7, 92, 50, 72, 2);
  getControllerValues();
  wheelDirection = 1;
  clear();
} //_CODE_:demoButton4:619428:

public void demoButton5Clicked(GButton source, GEvent event) { //_CODE_:demoButton5:668416:
  setControllerValues(1, 3, 16, 21, 50, 55, 1);
  getControllerValues();
  wheelDirection = 1;
  clear();
} //_CODE_:demoButton5:668416:

public void demoButton6Clicked(GButton source, GEvent event) { //_CODE_:demoButton6:668832:
  setControllerValues(1, 1, 3, 94, 71, 72, 6);
  getControllerValues();
  wheelDirection = -1;
  clear();
} //_CODE_:demoButton6:668832:

public void demoButton7Clicked(GButton source, GEvent event) { //_CODE_:demoButton7:696803:
  setControllerValues(2, 1, 8, 75, 72, 68, 2);
  getControllerValues();
  wheelDirection = 1;
  clear();
} //_CODE_:demoButton7:696803:

public void demoButton8Clicked(GButton source, GEvent event) { //_CODE_:demoButton8:898591:
  setControllerValues(2, 2, 13, 30, 59, 14, 2);
  getControllerValues();
  wheelDirection = 1;
  clear();
  
} //_CODE_:demoButton8:898591:

public void demoButton9Clicked(GButton source, GEvent event) { //_CODE_:demoButton9:944731:
  setControllerValues(2, 1, 5, 47, 89, 51, 4);
  getControllerValues();
  wheelDirection = 1;
  clear();
} //_CODE_:demoButton9:944731:

public void demoButton10Clicked(GButton source, GEvent event) { //_CODE_:demoButton10:476421:
  setControllerValues(4, 1, 13, 18, 57, 27, 1);
  getControllerValues();
  clear();
} //_CODE_:demoButton10:476421:

public void demoButton11Clicked(GButton source, GEvent event) { //_CODE_:demoButton11:220568:
  setControllerValues(4, 1, 3, 87, 58, 26, 2);
  getControllerValues();
  wheelDirection = -1;
  clear();
} //_CODE_:demoButton11:220568:

public void demoButton12Clicked(GButton source, GEvent event) { //_CODE_:demoButton12:593736:
  setControllerValues(4, 5, 4, 86, 50, 54, 1);
  getControllerValues();
  wheelDirection = 1;
  clear();
} //_CODE_:demoButton12:593736:

public void demoButton13Clicked(GButton source, GEvent event) { //_CODE_:demoButton13:286467:
  setControllerValues(3, 1, 5, 32, 67, 67, 2);
  getControllerValues();
  wheelDirection = 1;
  clear();
} //_CODE_:demoButton13:286467:

public void demoButton14Clicked(GButton source, GEvent event) { //_CODE_:demoButton14:954195:
  setControllerValues(3, 4, 1, 136, 50, 50, 3 );
  getControllerValues();
  wheelDirection = -1;
  clear();
} //_CODE_:demoButton14:954195:

public void demoButton15Clicked(GButton source, GEvent event) { //_CODE_:demoButton15:733090:
  setControllerValues(3, 1, 8, 53, 50, 87, 4);
  getControllerValues();
  wheelDirection = -1;
  clear();
} //_CODE_:demoButton15:733090:

public void reverseButtonClicked(GButton source, GEvent event) { //_CODE_:reverseButton:712050:
  wheelDirection *= -1;
  clear();
} //_CODE_:reverseButton:712050:

public void strokeSizeSliderChanged(GSlider source, GEvent event) { //_CODE_:strokeSizeSlider:823732:
  myMarker.strokeSize = strokeSizeSlider.getValueI();
} //_CODE_:strokeSizeSlider:823732:

public void demoButton16Clicked(GButton source, GEvent event) { //_CODE_:demoButton16:471753:
  setControllerValues(1, 1, 4, 26, 87, 72, 1);
  getControllerValues();
  wheelDirection = -1;
  clear();
} //_CODE_:demoButton16:471753:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  controlsWindow = GWindow.getWindow(this, "Controls", 0, 0, 540, 700, JAVA2D);
  controlsWindow.noLoop();
  controlsWindow.addDrawHandler(this, "win_draw1");
  pauseButton = new GButton(controlsWindow, 20, 20, 60, 30);
  pauseButton.setText("Pause");
  pauseButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  pauseButton.addEventHandler(this, "pauseButtonClicked");
  clearButton = new GButton(controlsWindow, 100, 20, 60, 30);
  clearButton.setText("Clear");
  clearButton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  clearButton.addEventHandler(this, "clearButtonClicked");
  motionTypeDropList = new GDropList(controlsWindow, 110, 70, 90, 180, 5);
  motionTypeDropList.setItems(loadStrings("list_483852"), 0);
  motionTypeDropList.addEventHandler(this, "motionTypeDropListChanged");
  togGroup1 = new GToggleGroup();
  label1 = new GLabel(controlsWindow, 20, 130, 80, 20);
  label1.setText("Wheel speed");
  label1.setOpaque(false);
  wheelSpeedSlider = new GSlider(controlsWindow, 100, 120, 290, 60, 10.0);
  wheelSpeedSlider.setShowValue(true);
  wheelSpeedSlider.setShowLimits(true);
  wheelSpeedSlider.setLimits(1, 0, 5);
  wheelSpeedSlider.setNbrTicks(6);
  wheelSpeedSlider.setStickToTicks(true);
  wheelSpeedSlider.setShowTicks(true);
  wheelSpeedSlider.setNumberFormat(G4P.INTEGER, 0);
  wheelSpeedSlider.setOpaque(false);
  wheelSpeedSlider.addEventHandler(this, "wheelSpeedSliderChanged");
  label2 = new GLabel(controlsWindow, 20, 200, 80, 40);
  label2.setText("Marker speed");
  label2.setOpaque(false);
  markerFrequencySlider = new GSlider(controlsWindow, 100, 200, 290, 60, 10.0);
  markerFrequencySlider.setShowValue(true);
  markerFrequencySlider.setShowLimits(true);
  markerFrequencySlider.setLimits(5, 0, 20);
  markerFrequencySlider.setNbrTicks(21);
  markerFrequencySlider.setStickToTicks(true);
  markerFrequencySlider.setNumberFormat(G4P.INTEGER, 0);
  markerFrequencySlider.setOpaque(false);
  markerFrequencySlider.addEventHandler(this, "markerFrequencySliderChanged");
  showGeneratorCheckBox = new GCheckbox(controlsWindow, 290, 20, 164, 20);
  showGeneratorCheckBox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  showGeneratorCheckBox.setText("Show generator shape");
  showGeneratorCheckBox.setOpaque(false);
  showGeneratorCheckBox.addEventHandler(this, "showGeneratorCheckBoxChanged");
  showGeneratorCheckBox.setSelected(true);
  label3 = new GLabel(controlsWindow, 20, 370, 80, 20);
  label3.setText("X Center");
  label3.setOpaque(false);
  xSlider = new GSlider(controlsWindow, 100, 370, 290, 50, 10.0);
  xSlider.setShowValue(true);
  xSlider.setShowLimits(true);
  xSlider.setLimits(50, 0, 100);
  xSlider.setNbrTicks(10);
  xSlider.setNumberFormat(G4P.INTEGER, 0);
  xSlider.setOpaque(false);
  xSlider.addEventHandler(this, "xSliderChanged");
  label4 = new GLabel(controlsWindow, 20, 450, 80, 20);
  label4.setText("Y Center");
  label4.setOpaque(false);
  ySlider = new GSlider(controlsWindow, 100, 450, 290, 50, 10.0);
  ySlider.setShowValue(true);
  ySlider.setShowLimits(true);
  ySlider.setLimits(67, 0, 100);
  ySlider.setNbrTicks(10);
  ySlider.setNumberFormat(G4P.INTEGER, 0);
  ySlider.setOpaque(false);
  ySlider.addEventHandler(this, "ySliderChanged");
  label5 = new GLabel(controlsWindow, 20, 290, 80, 20);
  label5.setText("Amplitude");
  label5.setOpaque(false);
  ampSlider = new GSlider(controlsWindow, 100, 290, 290, 50, 10.0);
  ampSlider.setShowValue(true);
  ampSlider.setShowLimits(true);
  ampSlider.setLimits(120, 0, 200);
  ampSlider.setNbrTicks(10);
  ampSlider.setNumberFormat(G4P.INTEGER, 0);
  ampSlider.setOpaque(false);
  ampSlider.addEventHandler(this, "ampSliderChanged");
  label6 = new GLabel(controlsWindow, 20, 70, 90, 20);
  label6.setTextAlign(GAlign.LEFT, GAlign.CENTER);
  label6.setText("Marker motion");
  label6.setOpaque(false);
  demoButton1 = new GButton(controlsWindow, 10, 530, 62, 30);
  demoButton1.setText("Demo 1");
  demoButton1.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton1.addEventHandler(this, "demoButton1Clicked");
  demoButton2 = new GButton(controlsWindow, 10, 570, 60, 30);
  demoButton2.setText("Demo 2");
  demoButton2.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton2.addEventHandler(this, "demoButton2Clicked");
  demoButton3 = new GButton(controlsWindow, 10, 610, 60, 30);
  demoButton3.setText("Demo 3");
  demoButton3.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton3.addEventHandler(this, "demoButton3Clicked");
  demoButton4 = new GButton(controlsWindow, 80, 530, 60, 30);
  demoButton4.setText("Demo 4");
  demoButton4.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton4.addEventHandler(this, "demoButton4Clicked");
  demoButton5 = new GButton(controlsWindow, 80, 570, 60, 30);
  demoButton5.setText("Demo 5");
  demoButton5.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton5.addEventHandler(this, "demoButton5Clicked");
  demoButton6 = new GButton(controlsWindow, 80, 610, 60, 30);
  demoButton6.setText("Demo 6");
  demoButton6.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton6.addEventHandler(this, "demoButton6Clicked");
  demoButton7 = new GButton(controlsWindow, 150, 530, 60, 30);
  demoButton7.setText("Demo 7");
  demoButton7.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton7.addEventHandler(this, "demoButton7Clicked");
  demoButton8 = new GButton(controlsWindow, 150, 570, 60, 30);
  demoButton8.setText("Demo 8");
  demoButton8.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton8.addEventHandler(this, "demoButton8Clicked");
  demoButton9 = new GButton(controlsWindow, 150, 610, 60, 30);
  demoButton9.setText("Demo 9");
  demoButton9.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton9.addEventHandler(this, "demoButton9Clicked");
  demoButton10 = new GButton(controlsWindow, 220, 530, 60, 30);
  demoButton10.setText("Demo 10");
  demoButton10.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton10.addEventHandler(this, "demoButton10Clicked");
  demoButton11 = new GButton(controlsWindow, 220, 570, 60, 30);
  demoButton11.setText("Demo 11");
  demoButton11.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton11.addEventHandler(this, "demoButton11Clicked");
  demoButton12 = new GButton(controlsWindow, 220, 610, 60, 30);
  demoButton12.setText("Demo 12");
  demoButton12.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton12.addEventHandler(this, "demoButton12Clicked");
  demoButton13 = new GButton(controlsWindow, 290, 530, 60, 30);
  demoButton13.setText("Demo 13");
  demoButton13.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton13.addEventHandler(this, "demoButton13Clicked");
  demoButton14 = new GButton(controlsWindow, 290, 570, 60, 30);
  demoButton14.setText("Demo 14");
  demoButton14.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton14.addEventHandler(this, "demoButton14Clicked");
  demoButton15 = new GButton(controlsWindow, 290, 610, 60, 30);
  demoButton15.setText("Demo 15");
  demoButton15.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton15.addEventHandler(this, "demoButton15Clicked");
  reverseButton = new GButton(controlsWindow, 180, 20, 80, 30);
  reverseButton.setText("Reverse wheel");
  reverseButton.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  reverseButton.addEventHandler(this, "reverseButtonClicked");
  label7 = new GLabel(controlsWindow, 254, 72, 80, 20);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("Marker size");
  label7.setOpaque(false);
  strokeSizeSlider = new GSlider(controlsWindow, 345, 64, 177, 40, 10.0);
  strokeSizeSlider.setShowValue(true);
  strokeSizeSlider.setLimits(3, 0, 6);
  strokeSizeSlider.setNbrTicks(7);
  strokeSizeSlider.setShowTicks(true);
  strokeSizeSlider.setNumberFormat(G4P.INTEGER, 0);
  strokeSizeSlider.setOpaque(false);
  strokeSizeSlider.addEventHandler(this, "strokeSizeSliderChanged");
  demoButton16 = new GButton(controlsWindow, 358, 530, 60, 30);
  demoButton16.setText("Demo 16");
  demoButton16.setLocalColorScheme(GCScheme.RED_SCHEME);
  demoButton16.addEventHandler(this, "demoButton16Clicked");
  controlsWindow.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow controlsWindow;
GButton pauseButton; 
GButton clearButton; 
GDropList motionTypeDropList; 
GToggleGroup togGroup1; 
GLabel label1; 
GSlider wheelSpeedSlider; 
GLabel label2; 
GSlider markerFrequencySlider; 
GCheckbox showGeneratorCheckBox; 
GLabel label3; 
GSlider xSlider; 
GLabel label4; 
GSlider ySlider; 
GLabel label5; 
GSlider ampSlider; 
GLabel label6; 
GButton demoButton1; 
GButton demoButton2; 
GButton demoButton3; 
GButton demoButton4; 
GButton demoButton5; 
GButton demoButton6; 
GButton demoButton7; 
GButton demoButton8; 
GButton demoButton9; 
GButton demoButton10; 
GButton demoButton11; 
GButton demoButton12; 
GButton demoButton13; 
GButton demoButton14; 
GButton demoButton15; 
GButton reverseButton; 
GLabel label7; 
GSlider strokeSizeSlider; 
GButton demoButton16; 
