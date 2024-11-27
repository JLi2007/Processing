// the orange dots on the wheel edge
class Dot {
  PVector location;
  PVector center, minusCenter;
  float r;
  color col;
  float size;
  float distFromCenter;
  boolean onScreen;
  
  //CONSTRUCTOR #1
  Dot(PVector p, PVector c) {    
   this.location = p;
   this.center = c;
   this.minusCenter = new PVector( -this.center.x, -this.center.y);
   this.distFromCenter = dist(c.x, c.y, p.x, p.y );
   
   if( this.distFromCenter < wheelRadius )
     this.onScreen = true;
   else
     this.onScreen = false;
     
   this.col = color(0,0,255);
  }
  
  
   //CONSTRUCTOR #2
  Dot(PVector loc, PVector c, color col, float size) {   
   this.location = loc;
   this.center = c;
   this.minusCenter = new PVector( -this.center.x, -this.center.y);
   this.distFromCenter = this.location.dist( center );
   
   if( this.distFromCenter <= 1.01*wheelRadius )
     this.onScreen = true;
   else
     this.onScreen = false;
     
   this.col = col;
   this.size = size;
  }
 
 
  void rotate( float w ) {
    float c = cos(w);  //STORING THESE VALUES SO THEY CAN BE USED MULTIPLE TIMES BELOW WITHOUT HAVING TO BE RE-COMPUTED EACH TIME
    float s = sin(w);
    
    PVector v = this.location.add( minusCenter ); //TRANSLATE THE CENTER OF THE WHEEL TO THE ORIGIN TO MAKE THE MATHEMATICS OF ROTATION SIMPLER
    PVector vRotated = new PVector( v.x*c + v.y*s, -v.x*s + v.y*c );  //ROTATE THE DOT ABOUT THE ORIGIN
    this.location = vRotated.add( this.center );  //TRANSLATE THE ROTATED DOT BACK TO ITS ORIGINAL CENTER
   }
   
   
   void drawMe() {
     if( this.onScreen ) {
       fill( this.col );
       noStroke();
       circle( this.location.x, this.location.y, this.size );
    }
   }
}
