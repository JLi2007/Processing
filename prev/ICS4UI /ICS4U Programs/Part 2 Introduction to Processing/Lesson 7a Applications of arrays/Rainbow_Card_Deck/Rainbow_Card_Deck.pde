import g4p_controls.*;

//USER CONTROLS
int n;  //number of shapes
int numColours;
float diameterDiff, diameterMin, diameterMax;
float colorDiff;
float omegaDiff, omegaMax;
float centreOffset;
int xC, yC;                  //the centre of the rotation
String shape = "squares";    //the default shape type when the program starts. 
boolean insideFaster = true; //whether the inside shapes rotate faster than the outside shapes

//ARRAYS THAT WILL STORE THE GEOMETRIC DATA OF THE SHAPES (angle, size, rotational speed, centre)
float[] theta, diameter, radius, omega, centreOfRotation;

//ARRAY THAT WILL STORE THE COLOURS OF THE SHAPES
color[] shapeColours;

//ARRAYS OF COLOURS, ONE FOR EACH CHOICE IN THE COLOUR MENU
color[] colourSet0 = {color(255), color(0)};  //black & white
color[] colourSet1 = {color(0,0,255), color(255,255,0)};  //blue & yellow
color[] colourSet2 = {color(0,0,255), color(255,255,0), color(255,0,0)};  //blue, yellow, red
color[] colourSet3 = {color(0,0,255), color(255,0,0), color(255,255,0), color(255)}; //blue, red, yellow, white

//ARRAY THAT WILL BE SET EQUAL TO ONE OF THE FOUR COLOUR ARRAYS ABOVE
color[] chosenColourSet;

float twoPI = 2*PI; //precalculated here, so that the CPU does not have to re-calculate 2*PI for every single shape in every single frame


//SETUP()
void setup() {
  size(900, 900);
  xC = width/2; 
  yC = height/2;
  createGUI();
  resetValues(); //reads in the default settings from the slider bars before the program starts
  noStroke();    //don't draw outlines around the shapes...saves CPU time and makes the optical effect more clear
}


//GETS THE CURRENT SETTINGS FROM THE SLIDER BARS.
//GETS CALLED WHENEVER THE USER DRAGS A SLIDER OR PUSHES A BUTTON.
void resetValues() {
  n = 12 * nSlider.getValueI(); 
  
  //clears all values from all geometric arrays and re-sets them
  theta = new float[n];
  diameter = new float[n];
  radius = new float[n];
  omega = new float[n];
  centreOfRotation = new float[n];
  shapeColours = new color[n];
  
  if( shape.equals("squares") )
    omegaDiff = .01 * speedSlider.getValueI()/((float) n);
    
  else
    omegaDiff = .02 * speedSlider.getValueI()/((float) n);
    
  //recalculates parameters based on the new slider settings
  omegaMax = n * omegaDiff;
  diameterDiff= 500.0/n;
  diameterMin = 10;
  diameterMax = 500+diameterDiff;
  
  //reads in which colour setting the user picked from the menu
  int colourChoiceIndex = colourList.getSelectedIndex();
  
  if(colourChoiceIndex == 0)       //if the user picked colour choice 1 (black & white)...
    chosenColourSet = colourSet0;
    
  else if(colourChoiceIndex == 1)  //if the user picked colour choice 2, etc...
    chosenColourSet = colourSet1;
    
  else if(colourChoiceIndex == 2)
    chosenColourSet = colourSet2;
    
  else if(colourChoiceIndex==3)
    chosenColourSet = colourSet3;
  
  //reads in the centre of rotation that the user chose
  centreOffset = offsetSlider.getValueI();
  println(centreOffset);

  //for each shape, resets its angle to 0 and resets its size. 
  //i = 0 corresponds to the largest, most distant shape
  //i = n-1 corresponds to the smallest, closest shape
  for (int i=0; i<n; i++) {
    theta[i] = 0;
    diameter[i] = diameterMax - i*diameterDiff;
    radius[i] = diameter[i]/2; 
    
    //sets the rotational speed of the shape based on its position in the stack (i).
    if(insideFaster)
      omega[i] = (i+1)*omegaDiff; //the closer to the middle the shape is, the faster it rotates
      
    else
      omega[i] = omegaMax - i*omegaDiff; 
    
    //sets the color of the shape using the color scheme the user picked
    shapeColours[i] = chosenColourSet[i % chosenColourSet.length ];
    
    if(shape.equals("squares"))
        centreOfRotation[i] = -radius[i]*(100-centreOffset)/100.0;
        
    else
        centreOfRotation[i] = -radius[i]*centreOffset/100.0;
  } 
}


//DRAW()
//GETS CALLED 30 TIMES PER SECOND.
void draw() {
  background(0); //black background

  if(shape.equals("squares")){  //for squares...
    for (int i=0; i < n; i++) {
      fill( shapeColours[i] ); //uses shape i's colour
      pushMatrix();
      translate(xC, yC);       //moves the centre of the shape to the centre of rotation
      rotate(theta[i]);        //rotates the shape to its current angle
      rect(centreOfRotation[i], centreOfRotation[i], diameter[i], diameter[i]); //draw the shape in its current location and size
      popMatrix();
      theta[i] = (theta[i]+omega[i]) % twoPI; //increases the angle of this shape using its current rotational speed
    }
  }
  
  else { //for ovals...
    for (int i=0; i < n; i++) {
      fill( shapeColours[i] );
      pushMatrix();
      translate(xC, yC);
      rotate(theta[i]);
      ellipse(centreOfRotation[i],centreOfRotation[i], diameter[i], 1.5*diameter[i]);
      popMatrix();
      theta[i] = (theta[i]+omega[i]) % twoPI;
    }
  }
}
