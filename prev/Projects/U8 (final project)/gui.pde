/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Do not rename this tab!
 * =========================================================
 */
 
synchronized public void draw_toolbarWindow(PApplet appc, GWinData data) {
    appc.background(230);
    appc.fill(196, 196, 196);
    appc.stroke(196, 196, 196);
    appc.rect(0, 440, 400, 200);
    appc.fill(13, 1, 115);
    appc.stroke(13, 1, 115);
    appc.textSize(18);

    if(successStatus){
      appc.fill(23, 163, 2);
      appc.text("✓ STATUS ✓", 165, 460);
    } 
    else{
      appc.fill(199, 8, 21);
      appc.text("x STATUS x", 165, 460);
    }
    
    // show country flags and pexel fetched images on the gui
    if(startCountryFlag != null){
      appc.image(startCountryFlag, 100, 100);
      appc.image(endCountryFlag, 100, 300);
    }

    appc.image(startCountryImg, 200, 75, 175, 100);
    appc.image(endCountryImg, 200, 275, 175, 100);

    try{
      if(passingCountry != null){
        appc.image(passCountryFlag, 100, 200);
        appc.image(passCountryImg, 200, 175, 175, 100);
      }
    }catch(NullPointerException e){
      println(e);
    }

    // if statements to determine what to display on status   
    if(showDijkstra){
      statusDescription.setText(endingCity + " is " + dijkstraDistance + " units (" + normalizeDistance(dijkstraDistance) + "km) away from " + startingCity + " \n" + dijkstraRoute);
    }
    else if(addEdgeStatus.equals("F")){
      statusDescription.setText("CANNOT add edge, country name(s) spelled wrong or the country(s) do not exist on the map. Make sure to use the spelling on the UI");
    }
    else if(addEdgeStatus.equals("S")){
      statusDescription.setText("Added edge from " + addedEdge1.toUpperCase() + " to " + addedEdge2.toUpperCase());
    }  
    else{
      statusDescription.setText("Welcome to Euronodes!");
    }
} 

// UPDATE booleans on checkbox toggle
public void edgesChecked(GCheckbox source, GEvent event) { 
  showEdges = !showEdges;
} 

public void edgeDistChecked(GCheckbox source, GEvent event) { 
  showEdgeDist = !showEdgeDist;
} 

public void gridChecked(GCheckbox source, GEvent event) { 
  showGrid = !showGrid;
}

// UPDATE variables on country select
public void selectStartingCountry(GDropList source, GEvent event) {
  showDijkstra = false;
  startingCountry = returnCountry(startingSelect.getSelectedText());
  startingCity = returnCity(startingSelect.getSelectedText());
  String flag = requestHTTPFlag(startingCountry);
  startCountryFlag = loadImage(flag);
  String sImg = requestHTTPImage(startingCountry);
  startCountryImg = loadImageFromURL(sImg);
}

public void selectEndingCountry(GDropList source, GEvent event) {
  showDijkstra = false;
  endingCountry = returnCountry(endingSelect.getSelectedText());
  endingCity = returnCity(endingSelect.getSelectedText());
  String flag = requestHTTPFlag(endingCountry);
  endCountryFlag = loadImage(flag);
  String eImg = requestHTTPImage(endingCountry);
  endCountryImg = loadImageFromURL(eImg);
}

public void selectPassingCountry(GDropList source, GEvent event) {
  showDijkstra = false;

  // only runs if the user inputs a passing country
  if(passingSelect.getSelectedText().equals("N/A") == false){
    passingCountry = returnCountry(passingSelect.getSelectedText());
    passingCity = returnCity(passingSelect.getSelectedText());
    String flag = requestHTTPFlag(passingCountry);
    passCountryFlag = loadImage(flag);
    String pImg = requestHTTPImage(passingCountry);
    passCountryImg = loadImageFromURL(pImg);
  }

  else{
    passingCountry = null;
    passingCity = null;
  }
}

// OPEN the correct links on click 
public void openWiki(GButton source, GEvent event){
  link("https://en.wikipedia.org/wiki/" + selectedCountry);
}

public void openPexels(GButton source, GEvent event){
  link("https://www.pexels.com/search/"+selectedCountry+"%20famous/");
}

// SHOW/HIDE the wiki and pexels buttons on the sidebar
void showGUIButtons(){
  wiki_btn.setVisible(true);
  pexels_btn.setVisible(true);
}

void hideGUIButtons(){
  wiki_btn.setVisible(false);
  pexels_btn.setVisible(false);
}

// HANDLING edge inputs
public void inputEdge1(GTextField source, GEvent event) { 
  addedEdge1 = addEdge1.getText();
  addEdgeStatus = "N";
} 

public void inputEdge2(GTextField source, GEvent event) { 
  addedEdge2 = addEdge2.getText();
  addEdgeStatus = "N";
} 

// ADD the edge
public void addEdge(GButton source, GEvent event) {
  showDijkstra = false;

  // add the edge if the user inputs are correct
  if(returnNodeWithName(addedEdge1) != null && returnNodeWithName(addedEdge2) != null ){
    Node n1 = returnNodeWithName(addedEdge1);
    Node n2 = returnNodeWithName(addedEdge2);
    n1.borderingCountries.put(n2.country, n1.calculateDistance(n1,n2));
    n2.borderingCountries.put(n1.country, n2.calculateDistance(n2,n1));

    // recreate the edges to update the map UI
    n1.createEdges(false);
    n2.createEdges(false);
    
    // display success message in STATUS
    successStatus = true;
    addEdgeStatus = "S";
  }else{   // otherwise cannot create edge. Display the failure message in STATUS
    successStatus = false;
    addEdgeStatus = "F";
  }
} 

// CALLING Dijkstra
public void initDijkstra(GButton source, GEvent event) { 
  if(startingCountry != null && endingCountry != null ){
    if(passingCountry != null){
      String dijkstraRoute1, dijkstraRoute2;
      int dijkstraDistance1, dijkstraDistance2;
      if(startingCountry.equals(passingCountry) && startingCountry.equals(endingCountry)){
        dijkstraRoute1 = startingCountry + "->" + passingCountry + "->" + endingCountry;
        dijkstraRoute2 = "";
        dijkstraDistance1 = 0;
        dijkstraDistance2 = 0;
      }else{
        // DEALING WITH PASSING COUNTRIES: Dijkstra from starting --> passing and then passing --> ending, then combine the data
        // from starting country to the passing country
        dijkstraOutput = runDijkstra(returnNodeWithName(startingCountry), returnNodeWithName(passingCountry), false);
        dijkstraRoute1 = dijkstraOutput.split(",")[0];
        dijkstraDistance1 = int(dijkstraOutput.split(",")[1]);

        // from passing country to the ending country
        dijkstraOutput = runDijkstra(returnNodeWithName(passingCountry), returnNodeWithName(endingCountry), true);
        dijkstraRoute2 = "->" + dijkstraOutput.split(",")[0];
        dijkstraDistance2 = int(dijkstraOutput.split(",")[1]);
      }

      // combine 
      dijkstraRoute = dijkstraRoute1 + dijkstraRoute2;
      dijkstraDistance = dijkstraDistance1 + dijkstraDistance2;
    }

    else{
      // in the format "country1->country2->country3,distance" so must split it
      dijkstraOutput = runDijkstra(returnNodeWithName(startingCountry), returnNodeWithName(endingCountry), false);
      dijkstraRoute = dijkstraOutput.split(",")[0];
      dijkstraDistance = int(dijkstraOutput.split(",")[1]);
    }

    // PRINTLN MESSAGES 
    // println(dijkstraRoute, dijkstraDistance);
    // println("ran dijkstra and populated array var");
    // println(endingCountry + " is " + dijkstraDistance + " units away from " + startingCountry);

    successStatus = true;
    showDijkstra = true;
    addEdgeStatus = "N";
  }
} 

// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Euro•Nodes");

  toolbarWindow = GWindow.getWindow(this, "Toolbar", 1100, 0, 400, 600, JAVA2D);
  toolbarWindow.noLoop();
  toolbarWindow.setActionOnClose(G4P.KEEP_OPEN);

  edgesCheck = new GCheckbox(toolbarWindow, 20, 10, 200, 50);
  edgesCheck.setFont(new Font("SansSerif", Font.PLAIN, 18));
  edgesCheck.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  edgesCheck.setText(" Show Edges -->");
  edgesCheck.setOpaque(false);
  edgesCheck.addEventHandler(this, "edgesChecked");

  edgeDistCheck = new GCheckbox(toolbarWindow, 200, 10, 200, 50);
  edgeDistCheck.setFont(new Font("SansSerif", Font.PLAIN, 18));
  edgeDistCheck.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  edgeDistCheck.setText(" Show Edge Weights");
  edgeDistCheck.setOpaque(false);
  edgeDistCheck.addEventHandler(this, "edgeDistChecked");

  gridCheck = new GCheckbox(this, 900, 695, 200, 50);
  gridCheck.setFont(new Font("SansSerif", Font.PLAIN, 14));
  gridCheck.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  gridCheck.setText("Toggle gridlines");
  gridCheck.setOpaque(false);
  gridCheck.addEventHandler(this, "gridChecked");

  startingSelect = new GDropList(toolbarWindow, 20, 90, 150, 100, 6, 15);
  startingSelect.setItems(loadStrings("list_countries"), 0);
  startingSelect.addEventHandler(this, "selectStartingCountry");
  starting_label = new GLabel(toolbarWindow, 20, 70, 150, 20);
  starting_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  starting_label.setText("Where To Start");
  starting_label.setOpaque(false);
  starting_label.setFont(new Font("SansSerif", Font.PLAIN, 14));

  endingSelect = new GDropList(toolbarWindow, 20, 290, 150, 100, 6, 15);
  endingSelect.setItems(loadStrings("list_countries"), 0);
  endingSelect.addEventHandler(this, "selectEndingCountry");
  ending_label = new GLabel(toolbarWindow, 20, 270, 150, 20);
  ending_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  ending_label.setText("Where To End");
  ending_label.setOpaque(false);
  ending_label.setFont(new Font("SansSerif", Font.PLAIN, 14));

  passingSelect = new GDropList(toolbarWindow, 20, 190, 150, 100, 6, 15);
  passingSelect.setItems(loadStrings("list_countries2"), 0);
  passingSelect.addEventHandler(this, "selectPassingCountry");
  passing_label = new GLabel(toolbarWindow, 20, 170, 150, 20);
  passing_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  passing_label.setText("Where To Pass");
  passing_label.setOpaque(false);
  passing_label.setFont(new Font("SansSerif", Font.PLAIN, 14));

  dijkstra_btn = new GButton(toolbarWindow, 150, 400, 100, 30);
  dijkstra_btn.setText("Run Algo");
  dijkstra_btn.addEventHandler(this, "initDijkstra");

  adding_edge_label = new GLabel(this, 0, 600, 200, 50);
  adding_edge_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  adding_edge_label.setText("Add an edge between two countries");
  adding_edge_label.setOpaque(false);
  adding_edge_label.setFont(new Font("SansSerif", Font.PLAIN, 14));
  adding_edge_label.setLocalColorScheme(GCScheme.RED_SCHEME);
  addEdge1 = new GTextField(this, 10, 650, 120, 30, G4P.SCROLLBARS_NONE);
  addEdge1.setOpaque(true);
  addEdge1.addEventHandler(this, "inputEdge1");
  addEdge1.setLocalColorScheme(GCScheme.RED_SCHEME);
  addEdge1.setPromptText("Country 1");
  addEdge2 = new GTextField(this, 10, 700, 120, 30, G4P.SCROLLBARS_NONE);
  addEdge2.setOpaque(true);
  addEdge2.addEventHandler(this, "inputEdge2");
  addEdge2.setLocalColorScheme(GCScheme.RED_SCHEME);
  addEdge2.setPromptText("Country 2");
  add_edge_btn = new GButton(this, 140, 650, 50, 80);
  add_edge_btn.setText("Add Edge");
  add_edge_btn.addEventHandler(this, "addEdge");
  add_edge_btn.setLocalColorScheme(GCScheme.RED_SCHEME);

  info_label = new GLabel(this, 10, 210, 200, 20);
  info_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  info_label.setText("Country Info");
  info_label.setOpaque(false);
  info_label.setFont(new Font("SansSerif", Font.PLAIN, 18));

  wiki_btn = new GButton(this, 60, 450, 100, 30);
  wiki_btn.setText("Wiki Page");
  wiki_btn.addEventHandler(this, "openWiki");
  wiki_btn.setLocalColorScheme(GCScheme.BLUE_SCHEME);

  pexels_btn = new GButton(this, 60, 490, 100, 30);
  pexels_btn.setText("Images");
  pexels_btn.addEventHandler(this, "openPexels");
  pexels_btn.setLocalColorScheme(GCScheme.BLUE_SCHEME);

  statusDescription = new GTextArea(toolbarWindow, 10, 480, 380, 100, G4P.SCROLLBARS_NONE);
  statusDescription.setText("Welcome to Euronodes");
  statusDescription.setFont( new Font("SansSerif", Font.PLAIN, 12) );
  
  // initialize variables   
  startingCountry = returnCountry(startingSelect.getSelectedText());
  startingCity = returnCity(startingSelect.getSelectedText());
  endingCountry = returnCountry(endingSelect.getSelectedText());
  endingCity = returnCity(startingSelect.getSelectedText());
  passingCountry = null;
  passingCity = null;

  // fetch the initial flags and images and load them into variables
  httpSetup();
  String s = requestHTTPFlag(startingCountry);
  String e = requestHTTPFlag(endingCountry);
  if (s != null && e != null) {
    startCountryFlag = loadImage(s);
    endCountryFlag = loadImage(e);

    String sImg = requestHTTPImage(startingCountry);
    String eImg = requestHTTPImage(endingCountry);
    startCountryImg = loadImageFromURL(sImg);
    endCountryImg = loadImageFromURL(eImg);
  }

  toolbarWindow.addDrawHandler(this, "draw_toolbarWindow");
  toolbarWindow.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow toolbarWindow;
GCheckbox edgesCheck, edgeDistCheck, gridCheck; 
GDropList startingSelect, endingSelect, passingSelect; 
GLabel starting_label, ending_label, passing_label, adding_edge_label, info_label; 
GButton dijkstra_btn, add_edge_btn, wiki_btn, pexels_btn; 
GTextField addEdge1, addEdge2;
GTextArea statusDescription;