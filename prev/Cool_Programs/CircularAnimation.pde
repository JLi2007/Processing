float a1, a2, a3, a4, a5, a6, angle1, angle2, angle3;
float r1, r2, r3, i, steps, x1, y1, x2, y2, x3, y3, xo, yo;
int col, col1, col2; 
int framect = 0;

void setup() {
    size(512,512); 
    noFill();
    steps = 1000; 
    xo = width / 2; 
    yo = height / 2;
    a1 =TAU / 4; 
    a2 = a1 + TAU; 
    a3 = TAU / 8; 
    a4 = a3 + TAU * 3; 
    a5 = TAU / 16; 
    a6 = a5 + TAU * 6;
    r1 =width * 0.25; r2 = width * 0.41; r3 = width * 0.49;
    col1= color(100, 100, 200, 64); col2 = color(0, 140, 128, 64);
}

void draw() {
    background(0);
    
    for (i = 0; i < steps; i ++) {   
       angle1 =lerp(a1, a2, i / steps); 
       angle2 =lerp(a3, a4, i / steps); 
       angle3 =lerp(a5, a6, i / steps); 
       x1 = xo + (cos(angle1) * r1); y1 = yo + (sin(angle1) * r1);
       x2 = xo + (cos(angle2) * r2); y2 = yo + (sin(angle2) * r2);   
       x3 = xo + (cos(angle3) * r3); y3 = yo + (sin(angle3) * r3);   
       col = lerpColor(col1, col2, i / steps); 
       stroke(col); 
       triangle(x1, y1, x2, y2, x3, y3);

       a1 += TAU / 2000000; a2 -= TAU / 190000;
       a3 += TAU / 1000000; a4 += TAU / 900000;
       a5 += TAU / 2900000; a6 -= TAU / 270000;     
    }
        
    framect ++;     
    // saveFrame("triangles_on_circles-#####.png"); 
}