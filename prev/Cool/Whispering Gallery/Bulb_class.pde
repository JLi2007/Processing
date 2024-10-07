class Bulb {
  Ray[] rays;
  float xC, yC;
  float raySpeed;
  
  //A Bulb object keeps track of all the Ray objects that belong to it at all times
  Bulb(float x, float y, float rs, int numRays){
    this.xC=x;
    this.yC=y;
    this.raySpeed=rs;
    
    rays = new Ray[numRays];
    
    float dTheta = 2*PI/numRays;
    float theta=0;
    
    //Make all the rays point outwards in a circle from the starting point (xC, yC)
    for(int i=0; i<rays.length; i++){
      float xSpeed = raySpeed * cos(theta);
      float ySpeed = raySpeed * sin(theta);
      rays[i] = new Ray(xC, yC, xSpeed, ySpeed); 
      theta += dTheta;
    }
  }
    
    
  void drawMe() {
    fill(255,255,0);
    float xScreenCentre = getScreenX( xC );
    float yScreenCentre = getScreenY( yC );
  
    ellipse(xScreenCentre, yScreenCentre, 10, 10);
  }
  
  
  void updateObjects(){
    for(int i=0;i<this.rays.length;i++){
      rays[i].update();
    }
  }
  
  
  void rotateRays(float angle){
    for(int i=0; i<this.rays.length; i++){
      rays[i].rotateBy(angle);
    }
  }
  
  
  void drawObjects() {
    if (drawingMode.equals("particles")) {
      this.drawParticles();
    }
    
    else {
      this.drawRays();
    }
  }
  
  
  void drawRays(){
    stroke(255);
    for(int i=0; i<this.rays.length; i++){
      rays[i].drawRay();
    }
  }
  
  
 void drawParticles(){
    noStroke();
    for(int i=0; i<this.rays.length; i++){
      rays[i].drawParticle();
    }
  }
}
