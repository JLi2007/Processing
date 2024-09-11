class Ball {
  PVector pos, vel;
  float r, diam;
  float left, right, top, bottom;
  color col;
  
  Ball(float x, float y, float vx, float vy, float r, color c) {
    this.pos = new PVector(x,y);
    this.vel = new PVector(vx,vy);
    this.r = r;
    this.diam = 2*this.r;
    this.left = this.pos.x - this.r;
    this.right = this.pos.x + this.r;
    this.top = this.pos.y - this.r;
    this.bottom = this.pos.y + this.r;
    this.col = c;
  }
  
  void updatePos(){
    if( this.left < 0 || this.right > width  )
      this.vel.x *= -1;
      
    if( this.top < 0 || this.bottom > height  )
      this.vel.y *= -1;
     
    this.pos.add(this.vel);
    this.vel.mult( friction );
    
    this.left = this.pos.x - this.r;
    this.right = this.pos.x + this.r;
    this.top = this.pos.y - this.r;
    this.bottom = this.pos.y + this.r;
    
  }
  
  void drawMe() {
    fill(this.col);
    circle(this.pos.x, this.pos.y, this.diam);
  }
  
  void checkCollision(Ball other) {
    PVector S = new PVector(other.pos.x-this.pos.x, other.pos.y-this.pos.y);
    float magSq = S.magSq();
    float twoR = this.r + other.r ;
    float twoRSq = pow(twoR, 2);
    
    if( magSq <= twoRSq) {
      S.normalize();
     
      //
      float k = this.vel.dot(S) - other.vel.dot(S);
      PVector kS = PVector.mult(S, k);
      other.vel.add( kS );
      this.vel.sub( kS );
      
      //Anti-clumping
      PVector Stimes2r = PVector.mult(S, twoR); 
      other.pos = PVector.add( this.pos, Stimes2r );
    }
  }
  
  void printMe() {
    println("<"+ this.pos.x + ", " + this.pos.y + ">");
  }
}
