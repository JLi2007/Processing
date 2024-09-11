/*
USER SETTINGS - TRY CHANGING THESE
*/

float speed = 0.004;

boolean t = true, f = false;

boolean showSin = t;
boolean showCos = t;
boolean showTan = t;
boolean showSec = t;
boolean showCot = f;
boolean showCsc = t;

boolean recordMovie = f;

boolean showUnitCircle = t;
boolean showRadius = t;
boolean showAxisOne = t;
boolean showTanDash = showTan;
boolean showThetaSymbol = t;

color sinCol = color(255, 0, 0);
color cosCol = color(0, 255, 0);
color tanCol = color(255, 255, 0);
color secCol = color(255, 0, 255);
color cotCol = color(255, 150, 0);
color cscCol = color(0, 255, 255);
color radiusCol = color(255);
color circleCol = color(255);

//LOCATIONS & SCALES
float centerPlacement = 0.3;   //Percentage of screen width
float unitCircleScale = 0.4;   //Percentage of screen width

//OTHER GLOBAL VARIABLES
color radiusOneCol = color(255);
color axisOneCol = color(255);
color angleCol = color(255,220,220,210);
color backgroundCol = color(30);
color arrowCol = color(255, 200, 200);
int sideWeight = 4;
int unitCircleWeight = 2;
int dotSize = 15;
float arcDiameter = 100, thetaRadius = arcDiameter/3;
float r, d, rHalf;
float xC, yC, xDot, yDot, yTan, yCsc;
float midSinY, midCosX, midTanY, midSecX, midSecY, midCotX, midCotY, midCscY;
float xThetaSymbol, yThetaSymbol;
float xOne, yOne, xOneText, xOneHalf, yCText, xCText, xRadiusOne, yRadiusOne;

PFont myFont;
PImage equation;

String thetaSymbol = "\u03b8"; //UNICODE, YAY!
String sinTheta = "sin " + thetaSymbol;
String cosTheta = "cos " + thetaSymbol;
String tanTheta = "tan " + thetaSymbol;
String secTheta = "sec " + thetaSymbol;
String cscTheta = "csc " + thetaSymbol;
String cotTheta = "cot " + thetaSymbol;

float theta = PI/10, thetaHalf = theta/2;


void setup() {
  size(700, 700);
 
  equation = loadImage("x^2+y^2=1.png");
 
  fill(255);
  myFont = createFont("Arial", 96);
  textFont(myFont);
 
  d = width/1.5;
  r = d/2;
  rHalf = r/2;
  xC = width/2;
  yC = height/2;
  xOne = xC + r;
  yOne = yC - r;
  xOneText = 1.01*xOne;
  yCText = 0.99 *yC;
  xOneHalf = (xC + xOne)/2;
  xCText = 1.01*xC;
}
