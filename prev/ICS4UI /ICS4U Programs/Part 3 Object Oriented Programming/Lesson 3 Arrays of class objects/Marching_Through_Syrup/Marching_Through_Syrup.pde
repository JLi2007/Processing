int numRows = 10;                   //Number of rows of marchers
int rowLength = 60;                //Number of marchers per row
float speedOnPavement = 2;         //Initial x-speed of the marching line
float m = 1.2;                     //Initial slope of the rows
float separation = 8;             //Horizontal spacing between marchers
float separationBetweenRows = 15;  //Vertical spacing between rows
float speedReductionFactor = 0.45;  //The ratio of the marchers' speed in syrup over their speed on pavement
Marcher[][] theBand;
int yMapleSyrup;
float xPos = 20;


void setup() {
  frameRate(20);
  size(800,600);
  yMapleSyrup = 2*height/3;
 
  theBand = new Marcher[numRows][rowLength];
  
  for(int row = 0; row < numRows; row++){
    for(int person = 0; person < rowLength; person++) {
      float x = person*separation - row * speedOnPavement * separationBetweenRows;
      float y = 200 - person*m*separation - row * speedOnPavement/m * separationBetweenRows;
      theBand[row][person] = new Marcher( x, y, speedOnPavement, speedOnPavement/m );
    }
  }
}


void draw() {
  background(200,200,200);
  fill(#cc9900);
  rect(0, yMapleSyrup, width, height-yMapleSyrup);
  
  fill(0,0,255);
  noStroke();
  
  for(int row=0; row < numRows; row++){
    for(int person=0; person < rowLength; person++){
      
       Marcher m = theBand[row][person];
       m.drawMe();
       m.updatePosition();
       
       if ( m.yPos >= yMapleSyrup && !m.inMapleSyrup  ) {  //if m has just entered the syrup...
         
         m.slowDown( speedReductionFactor );
         m.inMapleSyrup = true;
         
       }
    }
  } 
}
