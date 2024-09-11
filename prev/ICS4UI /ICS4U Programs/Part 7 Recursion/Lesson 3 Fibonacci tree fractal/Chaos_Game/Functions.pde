
void drawSierpinskiTriangle(int level, PVector a, PVector b, PVector c) {
   //BASE CASE
   if (level == 1) 
        triangle( a.x, a.y,  b.x, b.y,  c.x, c.y );   //DRAWS A SINGLE SOLID TRIANGLE BETWEEN POINTS a, b, AND c 
   
    //RECURSIVE CASE
    else {
        //CALCULATE THE 3 MIDPOINTS 
        PVector mab = midpoint(a, b);
        PVector mbc = midpoint(b, c);
        PVector mca = midpoint(c, a);

        // 3 RECURSIVE CALLS
        fill(0);
        drawSierpinskiTriangle( level - 1,   a,   mab, mca );  //The top third
        
        fill(0);
        drawSierpinskiTriangle( level - 1,   mab, b,   mbc );  //The lower-left third
        
        fill(0);
        drawSierpinskiTriangle( level - 1,   mca, mbc, c );    //The lower-right third
    }
}


PVector midpoint(PVector a, PVector b) {
    return new PVector( (a.x + b.x)/2, (a.y + b.y)/2 ); //ARITHMETIC MEAN
}


PVector getBoundaryPoint(float p) {
  PVector m01 = midpoint(V[0], V[1]);
  PVector m12 = midpoint(V[2], V[1]);
  float xBP = p*m01.x + (1-p)*m12.x;
  float yBP = p*m01.y + (1-p)*m12.y;
  return new PVector(xBP, yBP);
}
