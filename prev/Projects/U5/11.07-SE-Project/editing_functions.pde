// Changing the brightness
void changeBrightness(int bright) {
    loadPixels();
    
    // iterate through each pixel to change the brightness depending on the slider value
    for (int y = 0; y < height; y++) { 
        for (int x = 0; x < width; x++) {
            // get the R,G,B values from image
            float r,g,b;
            r = red(originalPix[x][y].colour);
            g = green(originalPix[x][y].colour);
            b = blue(originalPix[x][y].colour);
            
            // alter each by the brightness, creating the brightness increase/decrease effect
            r += bright;
            g += bright;
            b += bright;
            
            // constrain the values within 0 and 255 so the color values don't go out of bounds
            r = constrain(r, 0, 255);
            g = constrain(g, 0, 255);
            b = constrain(b, 0, 255);
            
            // change each pixel to the new color after brightness effect
            imagePix[x][y].colour = color(r,g,b);
        } 
    }
    
    updatePixels();
}

// Changing the hue
void changeHue(int degrees) {
    loadPixels();

    // set the rotation degree from the knob input
    hueWheel.setHueRotation(degrees);

    // iterate through each pixel to change the hue depending on the rotation degree
    for (int y = 0; y < height; y++) { 
        for (int x = 0; x < width; x++) {

            // get the R,G,B values from image
            float r,g,b;
            r = red(imagePix[x][y].colour);
            g = green(imagePix[x][y].colour);
            b = blue(imagePix[x][y].colour);
            
            // apply the hueWheel filter from the class
            int[] rgb = hueWheel.applyFilter(r,g,b);

            // change each pixel to the new color after hue rotation
            imagePix[x][y].colour = color(rgb[0],rgb[1],rgb[2]);
        } 
    }
    
    updatePixels();
}

// Resetting the changes to the image
void resetToOriginal() {
    // resetting the brightness and hue to original(default) values
    changeBrightness(0);
    hueWheel.setHueRotation(0.0);
    
    loadPixels();

    // resetting the surface, pixelsDrawn, and cropped values to default
    surface.setSize(800,800);
    pixelsDrawn = false;
    cropped = false;     
    imgx = 0;
    imgy = 0;

    updatePixels();
}

// Indicating the bounds
void checkIfInBox(PVector x, PVector y) {
    // iterates through each pixel to check if its in the selected bounds
    for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
            // if its in the selected bounds, change the color of it to a darker shade
            if (x.y < imagePix[i][j].pos.y && y.y > imagePix[i][j].pos.y && x.x < imagePix[i][j].pos.x && y.x > imagePix[i][j].pos.x) {
                imagePix[i][j].colour = color(red(imagePix[i][j].colour) / 2, green(imagePix[i][j].colour) / 2, blue(imagePix[i][j].colour) / 2);
            } 
        }
    }
}

// Takes in two PVectors for the vertexes of the area
void cropImage(PVector x, PVector y) {
    try{
        loadPixels();
        
        // uses cropping technique - if first slection was made on the top left
        if(x.x < y.x & x.y < y.y) {  

            // moving the location of the image so that the top left selection is now at (0,0)
            imgx -= x.x;
            imgy -= x.y;

            // changing the width & height to the distances between the points 
            newWidth = int(y.x - x.x);
            newHeight = int(y.y - x.y);
            surface.setSize(newWidth, newHeight);

            // redraw the pixels by setting pixelsDrawn to false and set cropped to true
            pixelsDrawn = false;    
            cropped = true;
            
            updatePixels();
        }
    }catch(NullPointerException e){ //catch error if the user does not create a bounds before cropping
        println("You need make bounds with yout mouse first!");
    }
}
    
// BROKEN FEATURE (SATURATION)
// void changeSaturation(float strength) {
//     loadPixels();
//     satWheel.setSaturationRotation(strength);
    
//     for (int y = 0; y < height; y++) { 
//         for (int x = 0; x < width; x++) {
//             // Get the R,G,B values from image
//             float r,g,b;
            
//             r = red(imagePix.colour);
//             g = green(imagePix.colour);
//             b = blue(imagePix.colour);
            
//             int[] rgb = satWheel.applyFilter(r,g,b);
//             imagePix.colour = color(rgb[0],rgb[1],rgb[2]);
//         } 
//     }
//     updatePixels();
// }