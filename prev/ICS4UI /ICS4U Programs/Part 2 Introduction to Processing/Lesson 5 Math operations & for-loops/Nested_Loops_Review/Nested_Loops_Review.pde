void setup() {
 size(700,500);
 fill(255, 210, 210);
}

void draw() {
  background(0, 80, 50);
  
  int y = 100;
  
  for(int row=0; row < 3; row++) { //OPENS THE OUTER LOOP
    int x = 150;
    
    for(int col=0; col < 5; col++) { //OPENS THE INNER LOOP
      square(x, y, 75);
      x += 75;
    }  //CLOSES THE INNER LOOP
    
    y += 75;
  } //CLOSES THE OUTER LOOP
}
