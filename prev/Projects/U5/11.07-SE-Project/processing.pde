// Import libraries
import g4p_controls.*;
import http.requests.*;
import processing.video.*;

// Variables
PImage img, piximaticLogo;
Pixel[][] imagePix, originalPix;
JSONObject response;
Capture cam;
boolean imageSelected;
boolean pixelsDrawn = false;
boolean cropped = false;
boolean showFilePage = false;
boolean showCameraPage = false;
boolean takePhoto = false;
boolean cameraInitialized = false;
int brushSize = 1;
int r,g,b,brightnessStrength, newWidth, newHeight, mouseVal;
float imgx = 0, imgy = 0;
RGBRotate hueWheel, satWheel;
color paint;
String filePath,postTitle, postDescription, imgurLink;

void setup() {
    size(800,800);

    // load the logo image and resize it
    piximaticLogo = loadImage("Piximatic.png");
    piximaticLogo.resize(400,400);

    // create home page GUI on start
    createGUI_Home();

    colorMode(RGB, 255,255,255);

    // create instances of RGB rotate class
    hueWheel = new RGBRotate();
    satWheel = new RGBRotate();
}

// File select function
void fileSelected(File selection) {

    // if no file was selected, close the window
    if (selection == null) {
        println("Window was closed or the user hit cancel.");
        
        // recreate the home screen and reset variables
        createGUI_Home();
        showCameraPage = false;
        showFilePage = false;
        toolbarWindow.setVisible(false);
        imgurWindow.setVisible(false);
    }   

    // a file was selected:
    else { 
        // get the absolute path of the file
        String file = selection.getAbsolutePath();  

        // take a substring of everything after the "data" keyword, for example "data/duck.jpg"  
        int fileIndex = file.indexOf("data");
        filePath = file.substring(fileIndex);

        // an image was selected, set the variable to true
        imageSelected = true;   
    } 
}

void draw() {

    // Create toolbar GUI and the file select popup when the "file" button is clicked on the home page
    if(showFilePage){
        showFilePage = false;
        
        // call the selectInput function to bring up the file selection window
        selectInput("Select a file to process:", "fileSelected");
        
        createGUI();
    }

    // Create toolbar GUI and open the webcam when "camera" button is clicked on the home page
    if(showCameraPage){
        
        // initialize the camera
        if(cameraInitialized == false){

            // list the available cameras on the user's device
            String[] cameras = Capture.list();

            // if the webcam on the user's computer is broken or they don't have one for some reason, redirect to file upload
            if (cameras.length == 0) {
                println("There are no cameras available for capture.");
                showFilePage = true;
            }
            
            // start the camera
            cam = new Capture(this, cameras[0]);
            cam.start();

            println("Camera started!");

            // set the variable to true to this only runs once and create the toolbar GUI
            cameraInitialized = true;
            createGUI();
        }

        if(imageSelected == false && cam.available()) {

            // read the camera and display it to the screen
            cam.read();
            image(cam, 0, 0);
            
            // resize the window accordingly
            surface.setSize(cam.width, cam.height);

            // if the takePhoto button is clicked
            if(takePhoto){

                // save the instance of the camera at the exact second the button is clicked
                img = cam.get();

                // change the variables accordingly, similar to if you selected this image from the data folder
                takePhoto = false;
                imageSelected = true; 
                showCameraPage = false; 

                // stops the camera
                cam.stop(); 
            }
        }
    }

    if (imageSelected) {

        // if the pixels are not drawn yet and NOT cropped
        if (pixelsDrawn == false && cropped == false) {
            
            // if a image does not exist from camera, load the filePath
            if(img==null){
                img = loadImage(filePath);
            }

            // resize the image proportionally if it's small with two general cases
            if (img.width < 200 && img.height < 200) {
                img.resize(img.width * 3, img.height * 3);
            }
            else if (img.width < 400 && img.height < 400) {
                img.resize(img.width * 2, img.height * 2);
            }

            // scale down the image proportionally if it's larger than the bounds of the screen with two cases
            if(img.width>displayWidth){
                img.resize(int(img.width * float(displayWidth)/float(img.width)), int(img.height * float(displayWidth)/float(img.width)));
            }
            if(img.height>displayHeight){
                img.resize(int(img.width * float(displayHeight)/float(img.height)), int(img.height * float(displayHeight)/float(img.height)));
            }

            // resize the window accordingly and draw the image, either from the camera or from select
            surface.setSize(img.width, img.height);
            image(img,0,0);

            // initialize the 2d arrays
            // we make Pix for changing color values and originalPix to store the original color values of the image   
            imagePix = new Pixel[width][height]; 
            originalPix = new Pixel[width][height];

            // iterates through every pixel and adds its position to the 2d aray
            for (int y = 0; y < height; y++) {  
                for (int x = 0; x < width; x++) {
                    PVector pos = new PVector(x, y);

                    // call the Pixel constructor with the position and get() method for the color
                    imagePix[x][y] = new Pixel(pos, get(x, y));  
                    originalPix[x][y] = new Pixel(pos, get(x,y));  
                } 
            }
            pixelsDrawn = true; 
        } 
      
        // if the pixels are not drawn yet and cropped
        if (pixelsDrawn == false && cropped == true) {
            
            // resize the image proportionally
            image(img,imgx,imgy);
            
            // initialize the 2d arrays
            // we make Pix for changing color values and originalPix to store the original color values of the image   
            imagePix = new Pixel[width][height]; 
            originalPix = new Pixel[width][height];  

            // iterates through every pixel and adds its position to the 2d aray
            for (int y = 0; y < height; y++) {  
                for (int x = 0; x < width; x++) {
                    PVector pos = new PVector(x, y);

                    // call the Pixel constructor with the position and get() method for the color
                    imagePix[x][y] = new Pixel(pos, get(x, y));  
                    originalPix[x][y] = new Pixel(pos, get(x,y));  
                } 
            }
            pixelsDrawn = true; 
        } 
        
        // if the pixels are already drawn, keep drawing the pixels to reflect the current state of editing
        if (pixelsDrawn == true) {
            loadPixels();

            // iterates through every pixel and sets the pixels[] processing array to the current instance of imagePix
            // the pixels[] processing array is what is drawn on the screen
            for (int y = 0; y < height; y++) { 
                for (int x = 0; x < width; x++) {
                    pixels[y * width + x] = imagePix[x][y].colour;
                } 
            }

            updatePixels();
        }
    } 
}
