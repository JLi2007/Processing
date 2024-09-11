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

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:221681:
  appc.background(230);
} //_CODE_:window1:221681:

public void Biomes_click1(GDropList source, GEvent event) { //_CODE_:Biomes:483153:
  option = Biomes.getSelectedText();
} //_CODE_:Biomes:483153:

public void MSize_change1(GSlider source, GEvent event) { //_CODE_:Mutation_Size:644673:
  MUTATION_SIZE = Mutation_Size.getValueI();
} //_CODE_:Mutation_Size:644673:

public void BSlide_change1(GSlider source, GEvent event) { //_CODE_:B_Color:665077:
  // Color sliders will only work if the option is custom not one of the set biomes
  if (option.equals("Custom")) {
    backgroundB = B_Color.getValueI();
  }
} //_CODE_:B_Color:665077:

public void GSlide_change2(GSlider source, GEvent event) { //_CODE_:G_Color:524529:
  if (option.equals("Custom")) {
    backgroundG = G_Color.getValueI();
  }
} //_CODE_:G_Color:524529:

public void RSlide_change2(GSlider source, GEvent event) { //_CODE_:R_Color:351668:
  if (option.equals("Custom")) {
    backgroundR = R_Color.getValueI();
  }
} //_CODE_:R_Color:351668:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 240, 150, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  Biomes = new GDropList(window1, 0, 0, 90, 80, 3, 10);
  Biomes.setItems(loadStrings("list_483153"), 0);
  Biomes.addEventHandler(this, "Biomes_click1");
  Mutation_Size = new GSlider(window1, 0, 110, 100, 40, 10.0);
  Mutation_Size.setShowValue(true);
  Mutation_Size.setLimits(5.0, 0.0, 20.0);
  Mutation_Size.setNumberFormat(G4P.DECIMAL, 2);
  Mutation_Size.setOpaque(false);
  Mutation_Size.addEventHandler(this, "MSize_change1");
  MSize_Label = new GLabel(window1, 10, 100, 80, 20);
  MSize_Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  MSize_Label.setText("Mutation Size");
  MSize_Label.setOpaque(false);
  Background_Label = new GLabel(window1, 120, 0, 110, 20);
  Background_Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Background_Label.setText("Background Color");
  Background_Label.setOpaque(false);
  B_Color = new GSlider(window1, 130, 110, 100, 40, 10.0);
  B_Color.setShowValue(true);
  B_Color.setLimits(0.0, 0.0, 255.0);
  B_Color.setNumberFormat(G4P.DECIMAL, 2);
  B_Color.setOpaque(false);
  B_Color.addEventHandler(this, "BSlide_change1");
  G_Color = new GSlider(window1, 130, 70, 100, 40, 10.0);
  G_Color.setShowValue(true);
  G_Color.setLimits(0.0, 0.0, 255.0);
  G_Color.setNumberFormat(G4P.DECIMAL, 2);
  G_Color.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  G_Color.setOpaque(false);
  G_Color.addEventHandler(this, "GSlide_change2");
  B_Text = new GLabel(window1, 140, 100, 80, 20);
  B_Text.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  B_Text.setText("B");
  B_Text.setOpaque(false);
  G_Text = new GLabel(window1, 140, 60, 80, 20);
  G_Text.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  G_Text.setText("G");
  G_Text.setOpaque(false);
  R_Color = new GSlider(window1, 130, 30, 100, 40, 10.0);
  R_Color.setShowValue(true);
  R_Color.setLimits(0.0, 0.0, 255.0);
  R_Color.setNumberFormat(G4P.DECIMAL, 2);
  R_Color.setLocalColorScheme(GCScheme.RED_SCHEME);
  R_Color.setOpaque(false);
  R_Color.addEventHandler(this, "RSlide_change2");
  R_Text = new GLabel(window1, 140, 20, 80, 20);
  R_Text.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  R_Text.setText("R");
  R_Text.setOpaque(false);
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GDropList Biomes; 
GSlider Mutation_Size; 
GLabel MSize_Label; 
GLabel Background_Label; 
GSlider B_Color; 
GSlider G_Color; 
GLabel B_Text; 
GLabel G_Text; 
GSlider R_Color; 
GLabel R_Text; 
