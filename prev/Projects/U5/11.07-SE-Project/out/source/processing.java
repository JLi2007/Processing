/* autogenerated by Processing revision 1293 on 2024-11-22 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import g4p_controls.*;
import http.requests.*;
import processing.video.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class processing extends PApplet {

// Import libraries




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
int paint;
String filePath,postTitle, postDescription, imgurLink;

public void setup() {
    /* size commented out by preprocessor */;

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
public void fileSelected(File selection) {

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

public void draw() {

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
                img.resize(PApplet.parseInt(img.width * PApplet.parseFloat(displayWidth)/PApplet.parseFloat(img.width)), PApplet.parseInt(img.height * PApplet.parseFloat(displayWidth)/PApplet.parseFloat(img.width)));
            }
            if(img.height>displayHeight){
                img.resize(PApplet.parseInt(img.width * PApplet.parseFloat(displayHeight)/PApplet.parseFloat(img.height)), PApplet.parseInt(img.height * PApplet.parseFloat(displayHeight)/PApplet.parseFloat(img.height)));
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
class Pixel{
  // Position and color fields
  PVector pos;
  int colour;
  
  // Constructor
  Pixel(PVector p, int c){
    this.pos = p;
    this.colour = c;
  }
}
// Changing the brightness
public void changeBrightness(int bright) {
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
public void changeHue(int degrees) {
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
public void resetToOriginal() {
    // resetting the brightness and hue to original(default) values
    changeBrightness(0);
    hueWheel.setHueRotation(0.0f);
    
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
public void checkIfInBox(PVector x, PVector y) {
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
public void cropImage(PVector x, PVector y) {
    try{
        loadPixels();
        
        // uses cropping technique - if first slection was made on the top left
        if(x.x < y.x & x.y < y.y) {  

            // moving the location of the image so that the top left selection is now at (0,0)
            imgx -= x.x;
            imgy -= x.y;

            // changing the width & height to the distances between the points 
            newWidth = PApplet.parseInt(y.x - x.x);
            newHeight = PApplet.parseInt(y.y - x.y);
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
// Download the current instance of the file to data/output/result.png
public void saveFile(){
    // save the new instance to data/output. The old instance is automatically deleted by processing.
    save("data/output/result.png");
}

// Using imgur api to generate a link to your image (data/output/result.png)
public void shareFile(){
    // the imgur image uploading endpoint
    String endpoint = "https://api.imgur.com/3/image";
    // imgur clientID API key - normally shouldn't be exposed... (if you aren't Mr Waters don't use this please 😂)
    String clientID = "5a40d6e685c2c70";
    
    try{
        // load image into a byte array
        byte[] imageBytes = loadBytes("data/output/result.png");
        // encode the bytes to a set a characters so we can send it to imgur api endpoint
        String encodedImage = java.util.Base64.getEncoder().encodeToString(imageBytes);
        
        // initialize the post request and add the required header for the api call to work
        PostRequest post = new PostRequest(endpoint);
        post.addHeader("Authorization", "Client-ID " + clientID);

        // add the image, along with a title and description to the imgur post request
        post.addData("image", encodedImage);
        if(postTitle != null){
            post.addData("title", postTitle);
        }else{
            post.addData("title", "Piximatic Result Image");
        }
        if(postDescription != null){
            post.addData("description", postDescription);
        }

        // send the request
        post.send();

        // parse the response into a JSON object
        response = parseJSONObject(post.getContent());
        // enters the data key and selects the link key
        imgurLink = response.getJSONObject("data").getString("link");
        // print it to the terminal for the user
        println("Here is your image: " + imgurLink);
    }
    catch(NullPointerException e){ //catch the error
        println("make sure you save an image first!");
    }
}

// Opens the link in search app
public void clickLink(String link){
    link(link);
}
/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:toolbarWindow:652321:
  appc.background(230);
  appc.fill(r,g,b);
  appc.stroke(r,g,b);
  appc.rect(10, 75, 380, 20);
  appc.circle(175,150,brushSize*2);
} //_CODE_:toolbarWindow:652321:

synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:window1:719241:
  appc.background(230);
  appc.textSize(16);
  appc.fill(0);
  if(imgurLink != null){
    appc.background(230);
    imgur_btn.setVisible(true);
    imgur_btn.setText(imgurLink);
  }else{
    appc.text("*Share feature does NOT work on school wifi",10,20);
    appc.text("Share an image to get access to a link!",10,60);
  }
} //_CODE_:window1:719241:

synchronized public void win_drawHome(PApplet appc, GWinData data) { //_CODE_:homePage:261049:
  appc.background(230);
  appc.image(piximaticLogo,0,0);
} //_CODE_:homePage:261049:

public void Camera_select(GButton source, GEvent event) { //_CODE_:cameraSelect:424562:
  homePage.close();
  homePage = null;
  showCameraPage = true;
} //_CODE_:cameraSelect:424562:

public void File_select(GButton source, GEvent event) { //_CODE_:fileSelect:698549:
  homePage.close();
  homePage = null;
  showFilePage = true;
} //_CODE_:fileSelect:698549:

public void handleButtonEvents(GButton button, GEvent event){}

public void Take_Photo(GButton source, GEvent event) { 
  takePhoto = true;
} 

public void Reset_Photo(GButton source, GEvent event){
  cameraInitialized = false;
  imageSelected = false; 
  showCameraPage = true; 
  pixelsDrawn = false; 
  img = null; 
}

public void Red_Change(GSlider source, GEvent event) { //_CODE_:Red:215448:
  r = Red.getValueI();
} //_CODE_:Red:215448:

public void Green_Change(GSlider source, GEvent event) { //_CODE_:Green:673080:
  g = Green.getValueI();
 } //_CODE_:Green:673080:

public void Blue_Change(GSlider source, GEvent event) { //_CODE_:Blue:859104:
  b = Blue.getValueI();
} //_CODE_:Blue:859104:

public void BrushChange(GSlider source, GEvent event) { //_CODE_:Brush_Size:736456:
  brushSize = Brush_Size.getValueI();
} //_CODE_:Brush_Size:736456:

public void Change_Brightness(GSlider source, GEvent event) { //_CODE_:brightness_:516721:
  changeBrightness(Bright.getValueI());
} //_CODE_:brightness_:516721:

public void Change_Hue(GKnob source, GEvent event) { //_CODE_:Huee:883956:
  changeHue(Hue.getValueI());
} //_CODE_:Huee:883956:

// BROKEN FEATURE (SATURATION)
// public void Change_Saturation(GSlider source, GEvent event) { //_CODE_:Huee:883956:
//   changeSaturation(Saturation.getValueF());
// } //_CODE_:Huee:883956:

public void Reset_image(GButton source, GEvent event) { //_CODE_:button1:863431:
  resetToOriginal();
  Bright.setLimits(0, -100, 100);
  Hue.setLimits(0.0f, -180.0f, 180.0f);
} //_CODE_:button1:863431:

public void Download_image(GButton source, GEvent event) { //_CODE_:button1:863431:
  saveFile();
} //_CODE_:button1:863431:

public void Share_image(GButton source, GEvent event) { //_CODE_:button1:863431:
  saveFile();
  shareFile();
} //_CODE_:button1:863431:

public void Mouse_function_change(GDropList source, GEvent event) { //_CODE_:mouse_dropdown:863813:
  mouseVal = mouse_dropdown.getSelectedIndex();
  if(mouseVal == 1){
    crop_btn.setVisible(true);
  }else{
    crop_btn.setVisible(false);
  }
} //_CODE_:mouse_dropdown:863813:

public void Crop_image(GButton source, GEvent event) { //_CODE_:Reset:435829:
  if (selectdata[1] == null){
    print("you have not made a selection. "); 
  }
  cropImage(selectdata[0], selectdata[1]);
} //_CODE_:crop_btn:435829:

public void Add_title(GTextField source, GEvent event) { //_CODE_:title:443414:
  postTitle = title_area.getText(); 
} //_CODE_:title:443414:

public void Add_description(GTextField source, GEvent event) { //_CODE_:title:443414:
  postDescription = description_area.getText(); 
} //_CODE_:title:443414:

public void Click_link(GButton source, GEvent event) { //_CODE_:title:443414:
  clickLink(imgurLink);
} //_CODE_:title:443414:

// Create all the GUI controls. 
// autogenerated do not edit
//Create the GUI for the home page
public void createGUI_Home(){
  homePage = GWindow.getWindow(this, "Home", displayWidth/3, displayHeight/4, 400, 400, JAVA2D);
  homePage.noLoop();
  homePage.setActionOnClose(G4P.CLOSE_WINDOW);
  homePage.addDrawHandler(this, "win_drawHome");
  cameraSelect = new GButton(homePage, 25, 25, 100, 50);
  cameraSelect.setText("Camera");
  cameraSelect.addEventHandler(this, "Camera_select");
  cameraSelect.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  fileSelect = new GButton(homePage, 275, 25, 100, 50);
  fileSelect.setText("File");
  fileSelect.addEventHandler(this, "File_select");
  fileSelect.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  homePage.loop();
}
//Create a second Gui for tool bar
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);

  surface.setTitle("Piximatic");
  toolbarWindow = GWindow.getWindow(this, "Piximatic Toolbar", 0, 0, 400, 400, JAVA2D);
  toolbarWindow.noLoop();
  toolbarWindow.setActionOnClose(G4P.KEEP_OPEN);
  toolbarWindow.addDrawHandler(this, "win_draw1");

  imgurWindow = GWindow.getWindow(this, "Imgur Link", 0, 500, 400, 100, JAVA2D);
  imgurWindow.noLoop();
  imgurWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  imgurWindow.addDrawHandler(this, "win_draw2");
  if(showCameraPage){
    Cap = new GButton(toolbarWindow, 300, 275, 80, 30);
    Cap.setText("Take Photo");
    Cap.setLocalColorScheme(GCScheme.RED_SCHEME);
    Cap.addEventHandler(this, "Take_Photo");
    Retake = new GButton(toolbarWindow, 300, 200, 80, 30);
    Retake.setText("Retake Photo");
    Retake.setLocalColorScheme(GCScheme.GOLD_SCHEME);
    Retake.addEventHandler(this, "Reset_Photo");
  }

  // color row
  Red = new GSlider(toolbarWindow, 25, 25, 100, 40, 10.0f);
  Red.setShowValue(true);
  Red.setLimits(0, 0, 255);
  Red.setNbrTicks(255);
  Red.setNumberFormat(G4P.INTEGER, 0);
  Red.setLocalColorScheme(GCScheme.RED_SCHEME);
  Red.setOpaque(false);
  Red.addEventHandler(this, "Red_Change");
  Green = new GSlider(toolbarWindow, 150, 25, 100, 40, 10.0f);
  Green.setShowValue(true);
  Green.setLimits(0, 0, 255);
  Green.setNbrTicks(255);
  Green.setNumberFormat(G4P.INTEGER, 0);
  Green.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  Green.setOpaque(false);
  Green.addEventHandler(this, "Green_Change");
  Blue = new GSlider(toolbarWindow, 275, 25, 100, 40, 10.0f);
  Blue.setShowValue(true);
  Blue.setLimits(0, 0, 255);
  Blue.setNbrTicks(255);
  Blue.setNumberFormat(G4P.INTEGER, 0);
  Blue.setOpaque(false);
  Blue.addEventHandler(this, "Blue_Change");
  red_label = new GLabel(toolbarWindow, 25, 50, 80, 20);
  red_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  red_label.setText("Red");
  red_label.setOpaque(false);
  red_label.setLocalColorScheme(GCScheme.RED_SCHEME);
  green_label = new GLabel(toolbarWindow, 150, 50, 80, 20);
  green_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  green_label.setText("Green");
  green_label.setOpaque(false);
  green_label.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  blue_label = new GLabel(toolbarWindow, 275, 50, 80, 20);
  blue_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  blue_label.setText("Blue");
  blue_label.setOpaque(false);
  blue_label.setLocalColorScheme(GCScheme.BLUE_SCHEME);

  // brush size / crop / dropdown row
  Brush_Size = new GSlider(toolbarWindow, 25, 125, 100, 40, 10.0f);
  Brush_Size.setShowValue(true);
  Brush_Size.setLimits(1, 1, 20);
  Brush_Size.setNbrTicks(20);
  Brush_Size.setNumberFormat(G4P.INTEGER, 0);
  Brush_Size.setOpaque(false);
  Brush_Size.addEventHandler(this, "BrushChange");
  brushSize_label = new GLabel(toolbarWindow, 50, 150, 80, 20);
  brushSize_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  brushSize_label.setText("Brush Size");
  brushSize_label.setOpaque(false);
  mouse_dropdown = new GDropList(toolbarWindow, 250, 125, 90, 60, 2, 10);
  mouse_dropdown.setItems(loadStrings("list_mouse_dropdown"), 0);
  mouse_dropdown.addEventHandler(this, "Mouse_function_change");
  crop_btn = new GButton(toolbarWindow, 250, 150, 80, 30);
  crop_btn.setText("Crop");
  crop_btn.setLocalColorScheme(GCScheme.RED_SCHEME);
  crop_btn.addEventHandler(this, "Crop_image");
  crop_btn.setVisible(false);

  // brightness/hue/saturation row
  Bright = new GSlider(toolbarWindow, 25, 200, 100, 40, 10.0f);
  Bright.setLimits(0, -100, 100);
  Bright.setNumberFormat(G4P.INTEGER, 0);
  Bright.setOpaque(false);
  Bright.addEventHandler(this, "Change_Brightness");
  Hue = new GKnob(toolbarWindow, 150, 200, 60, 60, 0.8f);
  Hue.setTurnRange(110, 70);
  Hue.setTurnMode(GKnob.CTRL_HORIZONTAL);
  Hue.setSensitivity(1);
  Hue.setShowArcOnly(false);
  Hue.setOverArcOnly(false);
  Hue.setIncludeOverBezel(false);
  Hue.setShowTrack(true);
  Hue.setLimits(0.0f, -180.0f, 180.0f);
  Hue.setShowTicks(true);
  Hue.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  Hue.setOpaque(false);
  Hue.addEventHandler(this, "Change_Hue");
  brightness_label = new GLabel(toolbarWindow, 25, 225, 80, 20);
  brightness_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  brightness_label.setText("Brightness");
  brightness_label.setOpaque(false);
  hue_label = new GLabel(toolbarWindow, 175, 200, 80, 20);
  hue_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  hue_label.setText("Hue");
  hue_label.setOpaque(false);

  // BROKEN FEATURE (SATURATION)
  // Saturation = new GSlider(toolbarWindow, 275, 200, 100, 40, 10.0);
  // Saturation.setLimits(1.0, 0.9, 1.1);
  // Saturation.setNumberFormat(G4P.INTEGER, 0);
  // Saturation.setOpaque(false);
  // Saturation.addEventHandler(this, "Change_Saturation");
  // saturation_label = new GLabel(toolbarWindow, 275, 225, 80, 20);
  // saturation_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  // saturation_label.setText("Saturation");
  // saturation_label.setOpaque(false);
  
  // reset/download row
  reset_btn = new GButton(toolbarWindow, 25, 275, 80, 30);
  reset_btn.setText("Reset");
  reset_btn.addEventHandler(this, "Reset_image");
  reset_btn.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  download_btn = new GButton(toolbarWindow, 150, 275, 80, 30);
  download_btn.setText("Download");
  download_btn.addEventHandler(this, "Download_image");

  // share row
  share_btn = new GButton(toolbarWindow, 300, 340, 80, 30);
  share_btn.setText("Share");
  share_btn.addEventHandler(this, "Share_image");
  title_area = new GTextField(toolbarWindow, 25, 325, 250, 30, G4P.SCROLLBARS_NONE);
  title_area.setText("");
  title_area.setPromptText("Add a title to your share");
  title_area.setOpaque(true);
  title_area.addEventHandler(this, "Add_title");
  description_area = new GTextField(toolbarWindow, 25, 360, 250, 30, G4P.SCROLLBARS_NONE);
  description_area.setText("");
  description_area.setPromptText("Add a description to your share");
  description_area.setOpaque(true);
  description_area.addEventHandler(this, "Add_description");

  // imgur link button
  imgur_btn = new GButton(imgurWindow, 10, 25, 380, 30);
  imgur_btn.setText("Link To Imgur");
  imgur_btn.addEventHandler(this, "Click_link");
  imgur_btn.setVisible(false);

  // loop windows
  toolbarWindow.loop();
  imgurWindow.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow toolbarWindow;
GWindow imgurWindow;
GWindow homePage;

// home page gui
GButton cameraSelect; 
GButton fileSelect; 

// piximatic gui
GButton Cap;
GButton Retake;
GSlider Red; 
GSlider Green; 
GSlider Blue; 
GSlider Brush_Size; 
GSlider Bright; 
GKnob Hue; 
GLabel red_label; 
GLabel green_label; 
GLabel blue_label; 
GLabel brushSize_label; 
GLabel brightness_label; 
GLabel hue_label; 
// BROKEN FEATURE (SATURATION)
// GLabel saturation_label;
// GSlider Saturation;

GDropList mouse_dropdown; 
GButton crop_btn;
GButton reset_btn; 
GButton download_btn; 
GButton share_btn; 
GTextField title_area;
GTextField description_area; 

// imgur window gui
GButton imgur_btn;
// Paint function
public void mouseDragged() {
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

public void mousePressed(){
  // if the mouse is on "mouseSelection" option and there an image exists
  if(pixelsDrawn){
    if(mouseVal == 1){
      // set the first location for cropping where the mouse is pressed
      selectdata[0] = new PVector(mouseX,mouseY); 
    }
  }
}

public void mouseReleased(){
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
class RGBRotate{
    // Matrix 2d array field
    float[][] valueMatrix;

    // Constructor to initialize the matrix
    RGBRotate() {
        valueMatrix = new float[3][3];
        valueMatrix[0][0] = 1; valueMatrix[0][1] = 0; valueMatrix[0][2] = 0;
        valueMatrix[1][0] = 0; valueMatrix[1][1] = 1; valueMatrix[1][2] = 0;
        valueMatrix[2][0] = 0; valueMatrix[2][1] = 0; valueMatrix[2][2] = 1;
    }

    // This function sets up a 3x3 matrix to perform a hue rotation on a color
    public void setHueRotation(float degrees) {
        // - A hue rotation redistributes red, green, and blue contributions to each channel in a way 
        //   that rotates their position around the "hue wheel." The effect preserves brightness and
        //   maintains a balance between the colors.
        // - One can search up the hue wheel for better understanding

        // convert the angle from degrees to radians for trigonometric calculations
        float cosA = cos(radians(degrees));  // cosine of rotation angle
        float sinA = sin(radians(degrees));  // sine of rotation angle
        float sqrt = sqrt(1.0f / 3.0f);        // scaling factor: sqrt(1/3) is used to normalize the rotation effect, used to uniformly distribute colors


        // Altering the matrix:
        // - The "diagonal terms" (e.g., valueMatrix[0][0]) are largely controlled by cosA,
        //   representing how much of each channel "stays" in itself after rotation.
        // - The "off-diagonal terms" includes sine (sinA) and normalization sqrt(1/3),
        //   which distribute the rotated hue across the other channels.

        // first row of the hue rotation matrix
        valueMatrix[0][0] = cosA + (1.0f - cosA) / 3.0f;
        valueMatrix[0][1] = 1.0f / 3.0f * (1.0f - cosA) - sqrt * sinA;
        valueMatrix[0][2] = 1.0f / 3.0f * (1.0f - cosA) + sqrt * sinA;

        // second row of the hue rotation matrix
        valueMatrix[1][0] = 1.0f / 3.0f * (1.0f - cosA) + sqrt * sinA;
        valueMatrix[1][1] = cosA + 1.0f / 3.0f * (1.0f - cosA);
        valueMatrix[1][2] = 1.0f / 3.0f * (1.0f - cosA) - sqrt * sinA;

        // third row of the hue rotation matrix
        valueMatrix[2][0] = 1.0f / 3.0f * (1.0f - cosA) - sqrt * sinA;
        valueMatrix[2][1] = 1.0f / 3.0f * (1.0f - cosA) + sqrt * sinA;
        valueMatrix[2][2] = cosA + 1.0f / 3.0f * (1.0f - cosA);
    }
    
    // Applies the filter by using the value matrix along with the r,g,b values specified
    public int[] applyFilter(float r, float g, float b){

        // creates the new values by multiplying by the matrix, which specifies how much of the original red, green, and blue
        // contribute to the new red/green/blue value. 
        float r_value = r*valueMatrix[0][0] + g*valueMatrix[0][1] + b*valueMatrix[0][2];
        float g_value = r*valueMatrix[1][0] + g*valueMatrix[1][1] + b*valueMatrix[1][2];
        float b_value = r*valueMatrix[2][0] + g*valueMatrix[2][1] + b*valueMatrix[2][2];

        // return the values in a integer array after constraining them to avoid going out of color bounds
        return new int [] {bounds(r_value), bounds(g_value), bounds(b_value)};
    }

    // Ensure that values are constrained to an integer from 0-255
    public int bounds(float value){
        if (value < 0){
            return 0;
        }
        if (value > 255){
            return 255;
        }

        // return value rounded to the nearest integer
        return PApplet.parseInt(value + 0.5f);
    }

    // BROKEN FEATURE (SATURATION)
    // void setSaturationRotation(float scale){
    //     float luminanceR = 0.2126f; 
    //     float luminanceG = 0.7152f; 
    //     float luminanceB = 0.0722f;
        
    //     valueMatrix[0][0] = luminanceR + (1.0 - luminanceR) * scale;
    //     valueMatrix[0][1] = luminanceG * (1.0 - scale);
    //     valueMatrix[0][2] = luminanceB * (1.0 - scale);

    //     valueMatrix[1][0] = luminanceR * (1.0 - scale);
    //     valueMatrix[1][1] = luminanceG + (1.0 - luminanceG) * scale;
    //     valueMatrix[1][2] = luminanceB * (1.0 - scale);

    //     valueMatrix[2][0] = luminanceR * (1.0 - scale);
    //     valueMatrix[2][1] = luminanceG * (1.0 - scale);
    //     valueMatrix[2][2] = luminanceB + (1.0 - luminanceB) * scale;
    // }
}

    


  public void settings() { size(800, 800); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
