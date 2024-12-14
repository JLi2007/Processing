int maximumLevel = 18;
float deltaPhi = PI/1.618;
float branchDecayFactor = 0.70; // 1.0 --> no shrinking at all, 0.97 --> shrink by 3% each gen.
float startingLength = 250;
int currLevel;
boolean animateAllStages = true;
float animationSpeed = 6;

void setup() {
    background(255);
    size(1200,600);
    strokeWeight(3);
    
    if( !animateAllStages )
      noLoop();
      
    else
      frameRate(animationSpeed);
}


void draw() {
  background(0);
 
  if( animateAllStages ) {

    if( currLevel < maximumLevel) {
      float xBase = width/2;
      float yBase = height-20;
      float rootAngle = PI/2;
    
      drawFibTree( currLevel, xBase, yBase, rootAngle, deltaPhi, startingLength, 0 );   
      currLevel++;
    }
    
    else {
      frameRate(0.5);
      float xBase = width/2;
      float yBase = height-20;
      float rootAngle = PI/2;
    
      drawFibTree( currLevel, xBase, yBase, rootAngle, deltaPhi, startingLength, 0 );  
    }
  }
  
  else {
   // drawFibTree( maximumLevel, width/2, height/2, 0,      deltaPhi, startingLength, 0 ); 
    drawFibTree( maximumLevel, width/2, height, PI/2,   deltaPhi, startingLength, 0 );  
    //drawFibTree( maximumLevel, width/2, height/2, PI,     deltaPhi, startingLength, 0 ); 
    //drawFibTree( maximumLevel, width/2, height/2, 3*PI/2, deltaPhi, startingLength, 0 );  
  }
}


void drawFibTree( int n, float x1, float y1, float phi, float deltaPhi, float L, int age) {

   //BASE CASE
   float x2 = x1 + L*cos(phi);
   float y2 = y1 - L*sin(phi);
   setColour( age );
   line(x1, y1, x2, y2);
   
   
   //RECURSIVE CASE
   if (n > 1) {  
     L *= branchDecayFactor;
     
     if( age == 0 ) //We've just drawn a baby branch, now spawn a single kid branch at same angle
       drawFibTree( n-1, x2, y2, phi, deltaPhi, L, 1 );
       
     else { //We've just drawn a kid or adult branch, now spawn a new baby + new adult
       drawFibTree( n-1, x2, y2, phi + deltaPhi, deltaPhi, L, 2 );
       drawFibTree( n-1, x2, y2, phi - deltaPhi, deltaPhi, L, 0 );
     }
   }
}


void setColour(int age) {
  if( age == 0 )
    stroke(0,200,0);
    
  else if( age == 1 )
    stroke(0,0,200);
    
  else
    stroke(200,0,100);
}
