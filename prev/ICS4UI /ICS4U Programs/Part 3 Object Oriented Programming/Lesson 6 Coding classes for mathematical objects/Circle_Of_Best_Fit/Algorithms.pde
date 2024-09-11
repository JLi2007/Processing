/* 
DETERMINES THE CENTER & RADIUS OF A CIRCLE THAT GOES THRU POINTS A, B, C
BY FINDING THE P.O.I. OF THE PERPEDICULAR BISECTORS OF SEGMENTS AB AND BC.
RETURNS AN ARRAY CONTAINING {xCenter, yCenter, radius}
*/
float[] findCircleThruThreePoints( PVector A, PVector B, PVector C ) {
    //SLOPES OF LINE SEGMENTS AB AND BC
    float s1 = (B.y-A.y)/(B.x-A.x);
    float s2 = (C.y-B.y)/(C.x-B.x);
    
    //IF EITHER SLOPE IS ZERO, THEN USE SEGMENT AC INSTEAD
    if( s1 == 0 ) 
      s1 = (C.y-A.y)/(C.x-A.x);  
      
    if( s2 == 0 )
      s2 = (C.y-A.y)/(C.x-A.x);
    
    //SLOPES OF THE PERPENDICULAR BISECTORS OF AB AND BC
    float p1 = -1/s1;
    float p2 = -1/s2;
    
    //MIDPOINTS OF AB AND BC
    PVector midAB = midpoint(A, B);
    PVector midBC = midpoint(B, C);
    
    float x1 = midAB.x;
    float y1 = midAB.y;
    float x2 = midBC.x;
    float y2 = midBC.y;
   
    //DETERMINING THE CENTER OF THE CIRCLE BY COMPUTING THE POINT-OF-INTERSECTION OF THE TWO PERPENDICULAR BISECTORS
    float xCenter = (y2 - y1 + p1*x1 - p2*x2) / (p1 - p2);  //Solution to the 2x2 system y - y1 = p1(x-x1) and y - y2 = p2(x-x2) for (x, y)
    float yCenter = p1*(xCenter - x1) + y1;                 //Subbing the above x-value into the first equation y = y1 + p1(x-x1)
    
    //CALCULATING THE RADIUS OF THE CIRCLE AS THE DIST BETWEEN THE CENTER AND POINT A. (COULD USE B OR C AS WELL.)
    float radius = dist( xCenter, yCenter, A.x, A.y);
    
    float[] circleData = {xCenter, yCenter, radius};
    return circleData;
 }
 
 
 /*
 ROTATING TRIANGLE ALGORITHM
 -----------------------------
 ESTIMATES A CIRCLE FROM USER-DRAWN POINTS BY REPEATEDLY SELECTING 3 POINTS AT A TIME FROM THE USER'S POINTS,
 THEN DETERMINING THE CIRCLE THAT GOES THROUGH THOSE 3 POINTS. 
 THEN IT AVERAGES THE CENTERS AND RADII OF THOSE CIRCLES.
 IT SELECTS TRIPLETS OF POINTS BY ROTATING THROUGH THE ARRAY OF POINTS AND PICKING 3 THAT ARE EQUALLY SPACED IN THE ARRAY.
 EXAMPLE FOR AN ARRAY OF 12 POINTS, P[0]...P[11] 
 TRIPLET 1: {P[0], P[4], P[8]}
 TRIPLET 2: {P[1], P[5], P[9]}
 TRIPLET 3: {P[2], P[6], P[10]}
 TRIPLET 4: {P[3], P[7], P[11]}
 */
void rotatingTriangleAlgorithm() {  
  int oneThirdOfN = points.size() / 3;
  float totalX=0, totalY=0, totalRadius=0;
  
  //For every triplet of points that are equally spaced from one another in the array...
  for(int i = 0; i < oneThirdOfN; i++) {  //i = index of 1st point in the triplet
    int j = i + oneThirdOfN;              //j = index of 2nd point
    int k = i + 2 * oneThirdOfN;          //k = index of 3rd point
    
    Circle circThru3Points = new Circle( points.get(i), points.get(j), points.get(k), color(220, 220, 220, 200) );
    
    if( showAveragedCircles ) circThru3Points.drawMe(1); //usually turned off
    
    totalX += circThru3Points.xCenter;
    totalY += circThru3Points.yCenter;
    totalRadius += circThru3Points.radius;
  }
  
  //Finding the average center and radius among the circles found in the for-loop above
  float avgX = totalX / oneThirdOfN;
  float avgY = totalY / oneThirdOfN;
  float avgRadius = totalRadius / oneThirdOfN;
  
  Circle fittedCircle = new Circle( avgX, avgY, avgRadius, RTcolor );
  
  fittedCircle.drawMe(5);
}


/* 
CENTER-OF-MASS ALGORITHM
SIMPLY TAKES THE AVERAGE X- AND Y-VALUES OF ALL USER-DRAWN POINTS AND CALLS THAT THE "CENTER" OF THE CIRCLE.
THEN IT AVERAGES THE DISTANCES FROM THAT ESTIMATED CENTER TO ALL THE USER'S POINTS AND CALLS THAT THE "RADIUS"
*/
void centerOfMassAlgorithm() { 
  float totalX=0, totalY=0, totalRadius=0;
  int n = points.size();
  
  for(PVector p : points) { 
    totalX += p.x;
    totalY += p.y;
  }
  
  PVector centerOfMass = new PVector( totalX/n, totalY/n) ;
  
  for(PVector p : points)  
    totalRadius += centerOfMass.dist( p );
    
  float avgRadius = totalRadius / n;
    
  Circle fittedCircle = new Circle( centerOfMass.x, centerOfMass.y, avgRadius, CMcolor );
  fittedCircle.drawMe(5);
}


PVector midpoint(PVector a, PVector b) {
  return new PVector((a.x+b.x)/2, (a.y+b.y)/2);
}
