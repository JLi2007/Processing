// Paint function
void mouseDragged() {
  if(pixelsDrawn){
    // create a PVector of the user's mouse position
    PVector mousePos = new PVector(mouseX, mouseY);

    loadPixels();

    // if the dropdown is on the "mousePaint" option, the paint will work
    if( mouseVal == 0) {    
      // stores where the user's mouse starts and ends 
      int startX = max(0, mouseX - brushSize);
      int endX = min(width, mouseX + brushSize);
      int startY = max(0, mouseY - brushSize);
      int endY = min(height, mouseY + brushSize);
      
      // iterates through every pixel from the start to the end of y and x respectively to draw on the paint changes
      for (int y = startY; y < endY; y++) {
          for (int x = startX; x < endX; x++) {  
            // calculate the distance between the pixel from the mouse position
            float dist = imagePix[x][y].pos.dist(mousePos);  

            // if the distance is within the brushSize, paint the color onto the canvas
            if (dist <= brushSize) {
              // change the color of the brush to the color specified by user
              paint = color(r, g, b);

              // update all the arrays with the new changes
              pixels[y * width + x] = paint;
              imagePix[x][y].colour = paint;
              originalPix[x][y].colour = paint; 
            }  
          }
      }
    }
    updatePixels();
  }
}

//Array with two slots for first selection position and second selection position for cropping
PVector[] selectdata = new PVector[2]; 

void mousePressed(){
  // if the mouse is on "mouseSelection" option and there an image exists
  if(pixelsDrawn){
    if(mouseVal == 1){
      // set the first location for cropping where the mouse is pressed
      selectdata[0] = new PVector(mouseX,mouseY); 
    }
  }
}

void mouseReleased(){
  // if the mouse is on "mouseSelection" option and there an image exists
  if(pixelsDrawn){
    if (mouseVal == 1){
      // set the second location for cropping where the mouse is released
      selectdata[1] = new PVector(mouseX,mouseY);
      // calls the checks in box function of two positions to draw the bounds
      checkIfInBox(selectdata[0], selectdata[1]);
    }
  }
}
