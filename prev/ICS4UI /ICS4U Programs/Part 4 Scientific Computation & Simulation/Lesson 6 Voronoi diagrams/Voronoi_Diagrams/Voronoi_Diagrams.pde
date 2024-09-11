int maxNumPoints = 150;
String pointPlacement = "grid"; //"mouse", "line", "circle", "wave", "grid"

PVector[] p;
int numPoints;
int numShades = maxNumPoints;
boolean drawSeeds = true;
int n = 0;
color[] colorSet;
color[][] pixelColors;


void setup() {
  size(500, 500);
  background(255);
  noLoop();
  p = new PVector[maxNumPoints];
  colorSet = new color[maxNumPoints];

  makeColorsRandom( numShades );
  //makeColorsBW( numShades );
  //makeColorsContinuous( numShades );

  pixelColors = new color[width][height];
  setInitialPixelColors();
  
  if( pointPlacement.equals( "line" ) )
    setPointsLine(0, 400, width, 400);
    
  else if( pointPlacement.equals( "circle" ) )
    setPointsCircle( width/2, width/2.5, 2);
    
  else if( pointPlacement.equals( "wave" ) )
    setPointsWave( width/4, 3, 1.00);  

  else if( pointPlacement.equals( "grid" ) ) 
    setPointsGrid(15, 10, 20);  


  calculatePixelColors();
}



void draw() {
  background(0);
  for (int i = 0; i < width; i++) {
    for (int j = 0; j< height; j++) {
      stroke(pixelColors[i][j]);        
      point(i, j);
    }
  }

  fill(0);
  noStroke();

  if ( drawSeeds ) {
    for (int k = 0; k < numPoints; k++) {
      circle(p[k].x, p[k].y, 5);
    }
  }
}


void calculatePixelColors() {
  for (int i=0; i< width; i++) {
    for (int j=0; j< height; j++) {

      float minDist = 2*width;
      int kBest = n;

      for (int k=0; k < numPoints; k++) {
        float d = dist(i, j, p[k].x, p[k].y);
        if (d < minDist) {
          kBest = k;
          minDist = d;
        }
      }

      pixelColors[i][j] = colorSet[kBest];
    }
  }
}


void mouseClicked() {
  p[n] = new PVector(mouseX, mouseY);
  n++;
  calculatePixelColors();
  redraw();
}
