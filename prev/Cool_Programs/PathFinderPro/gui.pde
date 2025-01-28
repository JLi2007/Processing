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

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:550632:
  appc.background(230);
} //_CODE_:window1:550632:

public void options_click1(GDropList source, GEvent event) { //_CODE_:options:216535:
  String choice = options.getSelectedText();
  //if(!runStart){
   if(choice.equals("Node")) mode = "node";
   else if(choice.equals("Edge")){
     mode = "edge";
   }
  else if(choice.equals("Road block")) mode = "block";
  else mode = "";
  
} //_CODE_:options:216535:

public void startCheckbox_clicked(GCheckbox source, GEvent event) { //_CODE_:startCheckbox:510514:
  if(!startChecked) startChecked = true;
  else startChecked = false;
} //_CODE_:startCheckbox:510514:

public void endCheckBox_clicked(GCheckbox source, GEvent event) { //_CODE_:endCheckBox:880380:
  if(!endChecked) endChecked = true;
  else endChecked = false;
} //_CODE_:endCheckBox:880380:

public void clearEdges_click(GButton source, GEvent event) { //_CODE_:clearEdgesButton:734808:
  edges = new ArrayList<Edge>();
  for(Node n: nodes) n.col = og;
  runStart = false;
  run.setText("Run");
} //_CODE_:clearEdgesButton:734808:

public void runButton_click(GButton source, GEvent event) { //_CODE_:run:301769:
  String runButtonText = run.getText();
  if(runButtonText.equals("Run")){
    if(startNode!=null && endNode != null){
      runStart = true;
      setValues();
      findPath();
      run.setText("Pause");
      options.setSelected(0);
      mode = "";
    }
  }
  else{
    run.setText("Run");
    for(Node n: nodes){
      n.col = og;
    }
    
    for(Edge e: edges){
      if(e.col!=blocked) e.col = og;
    }
    runStart = false;
  }
} //_CODE_:run:301769:

public void showDist_clicked(GCheckbox source, GEvent event) { //_CODE_:showDist:534802:
  if(!showDistance) showDistance = true;
  else showDistance = false;
} //_CODE_:showDist:534802:

public void clearNodes_click(GButton source, GEvent event) { //_CODE_:clearNodes:323710:
  nodes = new ArrayList<Node>();
  edges = new ArrayList<Edge>();
  blocks = new ArrayList<Block>();
  for(Edge e: edges){
    if(e.col == blocked){
      e.col = og;
      e.exists=true;
    }
  }
  runStart = false;
  run.setText("Run");
  startNode = null;
  endNode = null;
  nodeLabel = 0;
} //_CODE_:clearNodes:323710:

public void resetBlock_click(GButton source, GEvent event) { //_CODE_:resetBlocks:291964:
  blocks = new ArrayList<Block>();
  for(Edge e: edges){
    if(e.col == blocked){
      e.col = og;
      e.exists=true;
    }
  }
  if(runStart){
    setValues();
    findPath();
  }
} //_CODE_:resetBlocks:291964:

public void instructions_click1(GImageButton source, GEvent event) { //_CODE_:instructions:377120:
  if(!instruction){
    window2 = GWindow.getWindow(this, "Instructions", 0, 0, 310, 330, JAVA2D);
    window2.noLoop();
    window2.setActionOnClose(G4P.KEEP_OPEN);
    window2.addDrawHandler(this, "win_draw2");
    Title = new GLabel(window2, 19, 6, 267, 51);
    Title.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    Title.setText("Welcome to PathFinder Pro! \nYou make a graph, I solve it (if it's possible of course)");
    Title.setOpaque(false);
    nodeText = new GLabel(window2, 13, 58, 278, 57);
    nodeText.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    nodeText.setText("To add a point (node), set mode to \"Node\" and click to place a node. Indicate start/end nodes by checking the box before placing them");
    nodeText.setOpaque(false);
    edgeLabel = new GLabel(window2, 11, 120, 281, 49);
    edgeLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    edgeLabel.setText("To connect nodes, set mode to \"Edge\" and click on the two nodes you want to connect");
    edgeLabel.setOpaque(false);
    blockLabel = new GLabel(window2, 8, 174, 288, 63);
    blockLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    blockLabel.setText("To block a path (edge), set mode to \"Road block\" and click on the edge you wish to block (clicking on intersections will remove all edges involved)");
    blockLabel.setOpaque(false);
    note = new GLabel(window2, 5, 245, 294, 68);
    note.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    note.setText("*Notes: The default mode \"(Select)\"  allows you to drag nodes around. You can also edit edges, nodes and blocks while the program runs. Oh and also, you can only have one start and end node.");
    note.setOpaque(false);
    window2.loop();
    instruction = true;
  }
  else{
    instruction = false;
  }
} //_CODE_:instructions:377120:

public void generateGraph_click1(GButton source, GEvent event) { //_CODE_:generateGraph:638322:
  nodes = new ArrayList<Node>();
  edges = new ArrayList<Edge>();
  runStart = false;
  run.setText("Run");
  generateGraph();
} //_CODE_:generateGraph:638322:

synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:window2:229130:
  appc.background(230);
} //_CODE_:window2:229130:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "PathFinderPro GUI", 0, 0, 300, 300, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  options = new GDropList(window1, 24, 18, 110, 112, 3, 10);
  options.setItems(loadStrings("list_216535"), 0);
  options.addEventHandler(this, "options_click1");
  startCheckbox = new GCheckbox(window1, 152, 20, 79, 16);
  startCheckbox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  startCheckbox.setText("Start Node");
  startCheckbox.setOpaque(false);
  startCheckbox.addEventHandler(this, "startCheckbox_clicked");
  endCheckBox = new GCheckbox(window1, 151, 46, 81, 20);
  endCheckBox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  endCheckBox.setText("End Node");
  endCheckBox.setOpaque(false);
  endCheckBox.addEventHandler(this, "endCheckBox_clicked");
  clearEdgesButton = new GButton(window1, 107, 147, 67, 36);
  clearEdgesButton.setText("Clear Edges");
  clearEdgesButton.addEventHandler(this, "clearEdges_click");
  togGroup1 = new GToggleGroup();
  run = new GButton(window1, 96, 238, 80, 30);
  run.setText("Run");
  run.addEventHandler(this, "runButton_click");
  showDist = new GCheckbox(window1, 18, 203, 120, 20);
  showDist.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  showDist.setText("Display distances");
  showDist.setOpaque(false);
  showDist.addEventHandler(this, "showDist_clicked");
  clearNodes = new GButton(window1, 196, 148, 68, 36);
  clearNodes.setText("Clear Nodes");
  clearNodes.addEventHandler(this, "clearNodes_click");
  resetBlocks = new GButton(window1, 16, 147, 74, 34);
  resetBlocks.setText("Clear road blocks");
  resetBlocks.addEventHandler(this, "resetBlock_click");
  instructions = new GImageButton(window1, 252, 8, 25, 24, new String[] { "question.png", "question.png", "question.png" } );
  instructions.addEventHandler(this, "instructions_click1");
  generateGraph = new GButton(window1, 87, 95, 105, 32);
  generateGraph.setText("Generate Random Graph");
  generateGraph.addEventHandler(this, "generateGraph_click1");
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GDropList options; 
GCheckbox startCheckbox; 
GCheckbox endCheckBox; 
GButton clearEdgesButton; 
GToggleGroup togGroup1; 
GButton run; 
GCheckbox showDist; 
GButton clearNodes; 
GButton resetBlocks; 
GImageButton instructions; 
GButton generateGraph; 
GWindow window2;
GLabel Title; 
GLabel nodeText; 
GLabel edgeLabel; 
GLabel blockLabel; 
GLabel note; 
