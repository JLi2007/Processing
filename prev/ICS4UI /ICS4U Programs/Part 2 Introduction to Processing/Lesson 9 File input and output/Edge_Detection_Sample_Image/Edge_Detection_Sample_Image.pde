int s=80;
void setup() {
  size(1000,500);
  background(0);
  noLoop();
  textAlign(CENTER);
  stroke(255);
}

void draw() {
  int v;
  for(int i=0; i<6; i++) {
    for(int j=0; j<6; j++) {
    if( i < 2 ) {
      fill(120);
      v=120;
    }
      
    else if( i < 3 ) {
      fill(250);
      v=250;
    }
      
    else if( i < 5 ) {
      fill(210); 
      v = 210;    
    }
      
    else {
      fill(210);
       v=210;
    }
      
     
      int x = 10 + s*i;
      int y = 10 + s*j;
      stroke(0);
      square(x, y, s);
      fill(0,0,250);
      text(v, x+s/2, y+s/2);
    }
  }
  
  
  for(int i=0; i<6; i++) {
    for(int j=0; j<6; j++) {
    if( i < 1 ) {
      fill(0);
      v=2;
    }
      
    else if( i < 2 ) {
      fill(255);
      v=360;
    }
      
    else if( i < 3 ) {
      fill(255); 
      v = 270;    
    }
      
    else if( i < 4 ) {
      fill(120); 
      v = 120;    
    }
      
    else {
      fill(0);
       v=0;
    }
      
     
      int x = 20 +6*s + s*i;
      int y = 10 + s*j;
      stroke(0);
      square(x, y, s);
      fill(0,0,250);
      text(v, x+s/2, y+s/2);
    }
  }
}
