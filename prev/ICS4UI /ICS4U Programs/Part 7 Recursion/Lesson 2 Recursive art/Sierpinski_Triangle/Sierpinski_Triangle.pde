int maximumLevel = 8;
int padding = 50;
int currLevel = 1;

void setup() {
    size(600,600);
    noStroke();
    frameRate(0.5);
    fill(255,255,0);
}


void draw() {
  if( currLevel <= maximumLevel) {
      background(0);
      
      PVector a = new PVector( width/2, padding );              //top point
      PVector b = new PVector( padding, height-padding);        //lower left point
      PVector c = new PVector( width-padding, height-padding ); //lower right point
      
      drawSierpinskiTriangle(currLevel, a, b, c);  
      currLevel++;
  }
  
  else
    noLoop();
}


void drawSierpinskiTriangle(int level, PVector a, PVector b, PVector c) {
   //BASE CASE
   if (level == 1) 
        triangle( a.x, a.y,  b.x, b.y,  c.x, c.y );   //DRAWS A SINGLE SOLID TRIANGLE BETWEEN POINTS a, b, AND c 
   
    //RECURSIVE CASE
    else {
        //CALCULATE THE 3 MIDPOINTS 
        PVector mab = midpoint(a, b);
        PVector mbc = midpoint(b, c);
        PVector mca = midpoint(c, a);

        // 3 RECURSIVE CALLS
        fill(255,220,220);
        drawSierpinskiTriangle( level - 1,   a,   mab, mca );  //The top third
        
        fill(0,205,195);
        drawSierpinskiTriangle( level - 1,   mab, b,   mbc );  //The lower-left third
        
        fill(255,120,0);
        drawSierpinskiTriangle( level - 1,   mca, mbc, c );    //The lower-right third
    }
}

//CALCULATES THE MIDPOINT BETWEEN TWO GIVEN POINTS
PVector midpoint(PVector a, PVector b) {
    return new PVector( (a.x + b.x)/2, (a.y + b.y)/2 ); //ARITHMETIC MEAN
 }
