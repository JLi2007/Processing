//PARAMETERS
int n = 30;
int fpsLines = 5;
int fpsPolygons = 40;
String colourMode = "distance"; //"distance" or "random"
color[] colours = {color(255,0,0),  color(0,255,0),  color(0,0,255), color(255,255,0), color(0,255,255), color(255,0,255), color(255), 
                   color(190,0,0),  color(0,190,0),  color(0,0,190), 
                   color(128,255,0), color(0,128,255), color(128,0,255), 
                   color(255,128,0), color(0,255,128), color(255,0,128)};
int maxPerimeter = 30;

int lineNumber = 0;
Corner[][] corners;
float cellSize;
ArrayList<Ray> toExpand = new ArrayList<Ray>();
ArrayList<Ray> toExpandNextGen = new ArrayList<Ray>();
ArrayList<Corner> toFill = new ArrayList<Corner>();
boolean running = true;
String phase = "drawing"; //"drawing", "filling", "tracing"
int numColours = colours.length;
int polyCount = 0;
int buffer = 0;
int pad = 50;
int iMid, jMid;
Polygon tracedPoly;
int iTrace;


void setup() {
  size(700, 700);
  background(255);
  strokeWeight(2);
  frameRate(fpsLines);
  if ( n % 2 == 0) n++;
  corners = new Corner[n][n];
  cellSize = (width-2*pad)/n;
   
  initializeGrid();

  iMid = n/2;
  jMid = n/2;

  Ray east = new Ray(iMid, jMid, 0);
  Ray north = new Ray(iMid, jMid, 90);
  Ray west = new Ray(iMid, jMid, 180);
  Ray south  = new Ray(iMid, jMid, 270);
 
  toExpand.add( east );
  toExpand.add( north );
  toExpand.add( west );
  toExpand.add( south );
  
  fill(225);
  square(pad, pad, width-2*pad);
}


void draw() {
  println("Frame", frameCount);
  if( phase.equals( "drawing" )) 
    drawNextGenerationOfEdges();  
  
  else if( phase.equals( "filling" )) 
    fillNextPolygon();
    
  else if( phase.equals( "tracing" ))  {
    println("Tracing...");
    strokeWeight(10);
    Edge e = tracedPoly.edges.get(iTrace);
    stroke(random(0,255),random(0,255),random(0,255));
    line(e.start.x, e.start.y, e.end.x, e.end.y);
    iTrace++;
    if (iTrace >= tracedPoly.edges.size() )
      phase = "filling";
  }
}
