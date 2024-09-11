Wheel wheel, wheel2;
LinearSurface surface; //A LINEAR SURFACE IS A "TERRAIN" MADE OF 1 OR MORE RAMPS OF DIFFERENT SLOPES. THERE CAN BE DROP-OFFS OR "CLIFFS"
                       //BETWEEN RAMPS. YOU SPECIFY THE SURFACE BY LISTING THE (X,Y) POINTS WHERE EACH RAMP ENDS, AND THE SLOPES OF EACH RAMP.
PFont myFont; 

int radius = 40, radius2 = 30;       //Wheel size
float g = 0.08;        //Acceration of gravity
int frameDelay = 20, frameDelay2 = 80;   //How many frames to wait before rolling
float xStart1 = radius, xStart2 = 1*radius;
boolean showCycloidPath1 = true;
boolean showCycloidPath2 = true;
boolean showSpokePath = true;
color dotCol1 = color(255, 255, 0);
color dotCol2 = color(255, 255, 0);
color wheelCol1 = color(255, 0, 0), wheelCol2 = color(0, 255, 100);

int frame = 0;


void setup() {
  size(1200, 900);
  myFont = createFont("Georgia", 32);
  textFont(myFont);
  noStroke();
  frameRate(30);
  int w = width, h=height;

  //CHOOSE ONE OF THESE DEMOS TO RUN. COMMENT OUT THE OTHERS. OR BUILD YOUR OWN DEMO USING DIFFERENT BREAK POINTS AND SLOPES!
  
  //DEMO #1: PLAIN RAMP
  //float[] xPoints = {0, w};
  //float[] yPoints = {radius*5};
  //float[] slopes = {0.20};

  //DEMO #2: PLAIN RAMP WITH CLIFF
  //float[] xPoints = {0, w/3};
  //float[] yPoints = {radius*3};
  //float[] slopes = {0.20};

  //DEMO #3: MULTIPLE RAMPS WITH A DEAD CORNER AT THE BOTTOM
  //float[] xPoints = {0, 0.12*w, 0.65*w, 0.80*w, 0.95*w, w}; //IT'S CONVENIENT TO SPECIFY THE X- AND Y-BREAKPOINTS AS PERCENTAGES OF THE SCREEN WIDTH AND HEIGHT INSTEAD OF ABSOLUTE PIXEL VALUES
  //float[] yPoints = {radius*2, 0.35*h, 0.55*h, 0.99*h, 0.46*h}; 
  //float[] slopes = {0.20, 0.1, 0.0, -0.32, 0};  //NEGATIVE SLOPE MEANS THE RAMP GOES UPHILL TO THE RIGHT

  //DEMO #4: WILL IT FALL TO ITS DEATH?
  //float[] xPoints = {0, 0.25*w, 0.5*w, w};
  //float[] yPoints = {radius*2, 0.25*h, 0.98*h};
  //float[] slopes = {0.2, -0.23, 0};               // -0.23 or lower = survival.  -0.20 or higher = death

  //DEMO #5: A BUG IN MY CODE!
  //float[] xPoints = {0, 0.3*w, w};
  //float[] yPoints = {radius*2, radius*2 + 0.5*0.3*w};
  //float[] slopes = {0.5, 0.1};

  surface = new LinearSurface( xPoints, yPoints, slopes, color(#cc3300));  //CREATES THE SURFACE USING THE (X,Y) POINTS AND SLOPES LISTED IN THE DEMO YOUR'RE RUNNING
  wheel = new Wheel( surface, radius, xStart1, wheelCol1, dotCol1, dotCol2);
  //wheel2 = new Wheel( surface, radius2, xStart1, wheelCol2, dotCol2, dotCol2); //YOU CAN HAVE 2 WHEELS GOING AT ONCE!
}


void draw() {
  background(150);

  surface.drawMe();

  wheel.drawMe();
  //wheel2.drawMe();

  if (frame > frameDelay ) { //IF THE ANIMATION HAS STARTED...
    wheel.updateValues();
  }

  if (frame > 2*frameDelay) {
    //wheel2.updateValues();
  }

  frame++;

  if (wheel.xC + wheel.radius > width) //IF WE ROLL OFF SCREEN...
    stopAnimation();
}


void stopAnimation() {
  redraw();
  noLoop();
}
