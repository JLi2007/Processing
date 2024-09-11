void setInitialPixelColors() {
  for (int i=0; i<width; i++) {
    for (int j=0; j<width; j++) {
      pixelColors[i][j] = color(255);
    }
  }
}


void makeColorsBW(int numShades) {
  for (int i=0; i < numShades; i++) {
    if (i % 2 == 0 ) {
      colorSet[i] = color(0, 0, 0);
    } else {
      colorSet[i] = color(255, 255, 255);
    }
  }
}


void makeColorsContinuous(int numShades) {
  float r1 = 0; //255;
  float g1 = 0; //150;
  float b1 = 0; //50;

  float r2 = 255; //100;
  float g2 = 255; //0;
  float b2 = 255; //255;

  float dr = (r2-r1)/numShades;
  float dg = (g2-g1)/numShades;
  float db = (b2-b1)/numShades;

  float red = r1;
  float green = g1;
  float blue = b1;

  for (int i=0; i < numShades; i++) {
    red += dr; 
    green += dg;
    blue += db;
    colorSet[i] = color(red, green, blue);
  }
}


void makeColorsRandom(int numShades) {
  for (int i=0; i < numShades; i++) {
    int red = int(random(10, 254));
    int green = int(random(10, 254));
    int blue = int(random(10, 254));
    colorSet[i] = color(red, green, blue);
  }
}
