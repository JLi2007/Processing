//GLOBAL VARIABLES
float chainLength = 100;
float xC;   
float yC;
float kidSize = 50;
float maxAngleInDegrees = 80; //degrees
float maxAngle = radians( maxAngleInDegrees );  
float time = 0.0;


//MAIN PROCEDURE
void setup(){
  size(500,500);
  xC = width/2;
  yC = 0;
}


//DRAW PROCEDURE GETS CALLED REPEATEDLY (ABOUT 30 TIMES PER SEC) AFTER setup IS DONE
void draw() {
    background(0);
    
    float angle = 3*PI/2 + maxAngle * sin( time );
    float xKid = xC + chainLength*cos( angle ); 
    float yKid = yC - chainLength*sin( angle );
    
    stroke(255);
    line( xC, yC, xKid, yKid ); //Draws the white string
       
    fill(0,0,255);
    circle( xKid, yKid, kidSize ); //Draws the kid in its current position
    
    time = time + 0.05;
}
