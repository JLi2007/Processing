PImage imgOrig, imgNew;
color c;
float k = 0;

void setup() {
  size(1200,900);
  noLoop();  
  imgOrig = loadImage("Kids.png"); //An adorable pic of my kids when they were playing dress-up and generally being goofballs.
  imgOrig.resize(400,0);  //Make it smaller so it fits better on screen
  
  imgNew = createImage(imgOrig.width, imgOrig.height, RGB);  //Will eventually store the recoloured image
  imgOrig.loadPixels();
}

void draw() {
  background(255);
  
  image(imgOrig, 50, 0); //Draws the original image on the left half of the screen (50 pixels away)
  
  int w = imgOrig.width;  //w = the number of pixels contained in one row of the picture
  int h = imgOrig.height; //h = the number of pixels contained in one column of the picture
  
  for(int col = 1; col < w-1; col++) {  //For every pixel from left to right, except the very first (0) and the very last one (w)...
    for(int row = 1; row < h-1; row++) {   //For every row from top to bottom, except the very first (0) and the very last one (h)...
      
      int totalRed = 0, totalGreen = 0, totalBlue = 0; //Counters for how much red, green and blue we will detect in the 8 neighbouring pixels of the pixel at 
                                                       //coordinates (w, h)
      
      for(int a = -1; a <= 1; a++) { 
        for(int b = -1; b <= 1; b++) {
          int nearbyPixelIndex = w * (row + b) + col + a;
          color nearbyPixelCol = imgOrig.pixels[ nearbyPixelIndex ];
          
          totalRed   += red( nearbyPixelCol ) * a;
          totalGreen += green( nearbyPixelCol ) * a;
          totalBlue  += blue( nearbyPixelCol ) * a;
        }
      }
      
      int i = w * row + col;  //i = which pixel number we're on, as if we were numbering people in a rectangular auditorium
      imgNew.pixels[i] = color(totalRed, totalGreen, totalBlue);
    }
  }
  
  imgNew.updatePixels();  //Overwrites the pixels in imgNew with the ones now being stored in the array imgNew.pixels[].
  image(imgNew, width/2, 0);  //Draws the recoloured image on the right half of the screen
}
