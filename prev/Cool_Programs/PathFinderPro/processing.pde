import g4p_controls.*;
import processing.javafx.*;
import java.util.*;

//Arrays
ArrayList<Node> nodes = new ArrayList<Node>();
ArrayList<Edge> edges = new ArrayList<Edge>();
ArrayList<Block> blocks = new ArrayList<Block>();

//Default Colors
color og = color(120, 172, 194);
color clicked = color (101, 143, 156);
color chosenPath = color(77, 201, 91);
color blocked = color(199, 123, 56);

//Images
PImage cone, name;

PFont display, f; //f is the general font for nodes

String mode = ""; //"Node", "Edge", "Block"

boolean startChecked = false, endChecked = false, showDistance = false;
boolean runStart = false;
boolean instruction = false;

void setup(){
  createGUI();
  size(700,700);  
  noStroke();
  display = createFont("Cambria", 16);
  f = createFont("Cambria", 15);
  cone = loadImage("cone.png");
  name = loadImage("name.png");
  cone.resize(30,30);
  
}

void draw(){
  background(224, 205, 188);
  imageMode(CENTER);
  image(name, 350, 50);
  try{
    for(Edge e: edges){
      e.drawEdge();
    }
    for(Block b: blocks){
      b.showBlock();
    }
    for(Node n: nodes){
      n.showNode();
    }
    
    fill(0);
    textFont(display);
    textAlign(RIGHT);
    if(endNode == null || startNode == null){
      text("*Incomplete graph, make sure you have a start and end node*", 650,100);
    }
    else if(!runStart) text("Shortest Distance: N/A", 650,100);
    else if(!endNode.vis && runStart){
      text("No path found", 650,100);
    }
    else text("Shortest Distance (to the nearest unit): "+str(round(endNode.SD)), 650,100);
  }
  catch(Exception e){ //Sometimes the generateGraph is still adding nodes/edges when the draw function runs which creates an error
 
  }
}

void generateGraph(){
  int numNodes = round(random(3,10));
  int numEdges = round(random(3,20));
  nodeLabel = 0;

  startNode = new Node(round(random(110,600)), round(random(130,600)), "Start");
  endNode = new Node(round(random(110,600)), round(random(130,600)), "End");
  nodes.add(startNode); nodes.add(endNode);
  
  for(int i = 0; i < numNodes; i++){
    nodes.add(new Node(round(random(110,600)), round(random(130,600)), str(alpha.charAt(nodeLabel))));
    nodeLabel++;
  }
  for(int j = 0; j < numEdges; j++){
    int ind1 = int(random(0,numNodes)), ind2 =  int(random(0,numNodes)); //randomly gets two indices
    Node node1 = nodes.get(ind1);
    Node node2 = nodes.get(ind2);
    
    if(!(node1 == startNode && node2 == endNode) && !(node2 == startNode && node1 == endNode)){ //prevents a direct path from start to end (to make things more interesting)
      Edge newEdge = new Edge(node1,node2);
      if(!edges.contains(newEdge)){ //prevents duplicates
        edges.add(new Edge(node1,node2));
      }
    }
  }
}
