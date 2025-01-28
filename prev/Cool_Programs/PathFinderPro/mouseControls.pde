Node tmpNode1 = null, tmpNode2 = null;

boolean update;
String alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHJIKLMNOPQRSTUVWXYZ";
int nodeLabel = 0;

void mousePressed(){
  if(mode.equals("node")){
    Node tmpNode = null;
    if(startChecked && startNode == null){ //only assign a node as the starting point if no other node has been assigned as such
       tmpNode = new Node(mouseX, mouseY,"Start");
       startNode = tmpNode;
    }
    else if(endChecked && endNode == null &&!startChecked){
       tmpNode = new Node(mouseX, mouseY, "End");
       endNode = tmpNode;
    }
    else {
      tmpNode = new Node(mouseX, mouseY, str(alpha.charAt(nodeLabel)));
      nodeLabel++;
      if(nodeLabel>51) nodeLabel = 0;
    }
    nodes.add(tmpNode);
  }
  
  if(mode.equals("edge")){
    for(Node n: nodes){
      if(n.isClicked() && tmpNode1 == null){
        tmpNode1 = n;
      }
      else if(n.isClicked() && tmpNode1!=null && n.x != tmpNode1.x && n.y != tmpNode1.y){
        tmpNode2 = n;
        
        edges.add(new Edge (tmpNode1, tmpNode2));
        tmpNode1 = null;
        tmpNode2 = null;
        
      }
    
    }
    for(Node n: nodes){
      if(!n.isClicked() && n.col!=chosenPath) n.col=og;
    }
    
  }
  if(mode.equals("block")){
    for(Edge e: edges){
      if(e.isClicked()){
        e.col = blocked;
        e.exists=false;
        blocks.add(new Block(e));
      }
    }
  }
  if(runStart){ //usually needs to recalculating after modifying edges, nodes or blocks
     setValues(); 
     findPath();
  }
}


void mouseDragged(){
  Node selectedNode = null;
  for(Node n:nodes){
    if(n.isClicked()){
      selectedNode = n;
      update = true;
      break;
    }
    
  }
  if(selectedNode!=null){
    selectedNode.x = mouseX;
    selectedNode.y = mouseY;
  }
  
  for(Edge e: edges){
    e.updateDist();
  }
  
}

void mouseReleased(){
  if(update && runStart){
      setValues();
      findPath();
      update = false;
  }
}
