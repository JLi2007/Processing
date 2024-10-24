float alpha = PI/2;
int numRays = 200;
float dalpha = PI/numRays;
float r, diam;
float xC, yC;
boolean showJustCurrentBeam = false;
color lightRayColor = color(255, 255, 0);


void setup(){
  size(1000, 600);
  frameRate(10); 

  background(0);
  float yMid = height/2;
  
  xC = 400 + yMid; 
  yC = yMid;
  r = yMid * 0.95;
  diam = 2*r;
}


void draw() {
  float x0, y0, x1, y1, x2, y2;
  int weight;
  
  //ENTRY POINT
  x0 = xC + r*cos( PI-alpha );
  y0 = yC - r*sin( PI-alpha );
  
  //POINT OF IMPACT
  x1 = xC + r*cos( alpha );
  y1 = yC - r*sin( alpha );
  
  //REFLECTED POINT
  x2 = xC + r*cos( 3*alpha + PI ); 
  y2 = yC - r*sin( 3*alpha + PI ); 

  if ( showJustCurrentBeam ) {
    //DRAWS THE RED BISECTING LINE
    background(0);
    stroke(255, 0, 0);
    strokeWeight(3);
    line(xC, yC, x1, y1);
    
    //DRAWS THE CENTRE DOT
    noFill();
    stroke(255,0,0);
    circle(xC, yC, 5);
  }
  
  //DRAWS THE RIM OF THE COFFEE CUP
  noFill();
  stroke(0, 255, 0);
  circle(xC, yC, diam);
    
  //DRAWS THE INCOMING RAY
  if ( showJustCurrentBeam ) { //BRIGHTER IF WE'RE DRAWING JUST 1 BEAM
    weight = 2;
  }
  
  else { //DIMMER IF WE'RE DRAWING ALL THE BEAMS CUMULATIVELY
    weight = 1;    
  }
  
 // lightRayColor = color(random(0,255), random(0,255), random(0, 255));
 
  stroke( lightRayColor );
  strokeWeight( weight );
  line(x0, y1, x1, y1);
  
  //DRAWS THE REFLECTED RAY
  line(x1, y1, x2, y2);
  
  //IF THE INCOMING RAY HAS REACHED THE BOTTOM EDGE OF THE DISH, THEN STOP...
  if( alpha < -PI/2 ) 
    noLoop();
 
  //...OTHERWISE, DECREASE THE ANGLE BEFORE THE NEXT FRAME BEGINS
  else 
    alpha = alpha - dalpha;
    
  //saveFrame("cardioid-######.png");
}
