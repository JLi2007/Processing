void setup() {
  for(int r = 0; r < 3; r++) {
    println("RED FISH");
    
    for(int b = 0; b < 5; b++) {
      print("Blue fish***");
    }
    println();
  }
  
  size(500,500);
}


void draw() {
  int y = 100;
  
  for(int row=0; row < 5; row++){
    int x = 200;
    for(int col=0; col < 10; col++) {
      square(x, y, 10);
      x += 10;
    }
    y += 10;
    
  }
}
