float xOffSet = 40, yOffSet = 40;
float dotSize = 10;

PVector[] myPoints; //not committing to the size yet
PrintWriter pw;

void setup() {
  size(600,600);
  background(0);
  noStroke();
  pw = createWriter("Your points.txt");
}


//TO USE MOUSE DETECTION, YOU MUST INCLUDE A BLANK draw() PROCEDURE
void draw()
{}


void mouseDragged(){  //different from mouseMoved, which is only triggered when the mouse isn't down
     fill(255);
     circle( mouseX, mouseY, dotSize );
     pw.println( mouseX + "," + mouseY );
}


void mouseReleased(){
  pw.close();
  
  String[] lines = loadStrings("Your points.txt");
  int numPoints = lines.length;
  
  myPoints = new PVector[ numPoints ];
  
  for (int i=0; i < numPoints; i++ ) {
    String[] xyVals = lines[i].split(",");  //"435", "119"
    myPoints[i] = new PVector();
    myPoints[i].x = int(xyVals[0]);
    myPoints[i].y = int(xyVals[1]);
  }
  
  fill(255,0,0);
  
  for (int i=0; i < numPoints; i++ ) 
    circle( myPoints[i].x + xOffSet, myPoints[i].y + yOffSet, dotSize ); 
  
  pw = createWriter("Your points.txt");
}
