void draw() {
  background(0);
 
  fill(255,140,0);
  textAlign(LEFT);
 // text("Press r to run the animation. Press p to pause", 50, 50);
 
  xDot = xC + r*cos(theta);
  yDot = yC - r*sin(theta);
  
  //EQUATION
  image(equation, 500, 105);

  //CIRCLE & AXES
  noFill();
  stroke(255);
  strokeWeight(2);
  circle(xC, yC, d);
  line(0, yC, width, yC);
  line(xC, 0, xC, height);
 
  //RADIUS
  stroke(radiusCol);
  line(xC, yC, xDot, yDot);
  if( !showSec ) {
    textAlign(CENTER);
    float thetaPrintOne = theta + 0.15;
    xRadiusOne = xC + rHalf * cos(thetaPrintOne);
    yRadiusOne = yC - rHalf * sin(thetaPrintOne);
    //(xC + xDot)/2; yRadiusOne = (yC + yDot)/2;
    fill(255);
    text("1", xRadiusOne, yRadiusOne);
  }
  
  //THETA ARC
  xThetaSymbol = xC + thetaRadius * cos( thetaHalf );   //The location of the "theta" symbol as the angle grows
  yThetaSymbol = yC - thetaRadius * sin( thetaHalf );
  
  drawAngle();
 
  strokeWeight(4);
  textSize(28);
 
  //SINE
  if( showSin ) {
    stroke(sinCol);
    fill(sinCol);
    line(xDot, yC, xDot, yDot);
    midSinY = (yC + yDot)/2;
    textAlign(LEFT);
    text(sinTheta, 1.01*xDot, midSinY);
  }
 
  //COSINE
  if( showCos ) {
    stroke(cosCol);
    fill(cosCol);
    line(xC, yC, xDot, yC);
    midCosX = (xC + xDot)/2;
    textAlign(CENTER);
    text(cosTheta, midCosX, yCText);
  }
 
  //TANGENT
  if( showTan ) {
    stroke(tanCol);
    fill(tanCol);
    yTan = yC - r*tan(theta);
    line(xC, yC, xOne, yTan );
    line(xOne, yC, xOne, yTan );
    midTanY = (yC + yTan)/2;
    textAlign(LEFT);
    text(tanTheta, xOneText, midTanY);
  }
 
  //SECANT
  if( showSec ) {
    stroke(secCol);
    fill(secCol);
    line(xC, yC, xOne, yTan );
    textAlign(LEFT, CENTER);
    text(secTheta, xOneHalf, midTanY);
  }

  //COSECANT
  if( showCsc ) {
    stroke(cscCol);
    fill(cscCol);
    yCsc = yC - r/sin(theta);
    line(xC, yC, xC, yCsc );
    midCscY = (yC + yCsc)/2;
    textAlign(LEFT, CENTER);
    text(cscTheta, xCText, midCscY);
  }
 
  //COTANGENT
  if( showCot ) {
    stroke(cotCol);
    fill(cotCol);
    line(xDot, yDot, xC, yCsc );
    midCotX = 1.01*(xDot + xC)/2;
    midCotY = 0.99*(yDot + yCsc)/2;
    textAlign(LEFT, TOP);
    text(cotTheta, midCotX, midCotY);
  }
 
  //DOT
  fill(circleCol);
  noStroke();
  circle(xDot, yDot, dotSize);
 
  //UPDATES THE ANGLE
  theta = (theta + speed) % TWO_PI;
  thetaHalf = theta/2;  //Needed for drawing the theta symbol in the middle of the angle arc rather than at its edge
  
  if( recordMovie ) 
    saveFrame("Movies/sinCos/sin-cos-####.png");
}
