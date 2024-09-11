// Moving lines with if, else if, else statement
// September 10, 2024
float a,b,i;
int c;
int rect_height = 5;
// initialize intlist to store random line values
IntList lines;


void setup() {
   size(800,400);
   colorMode(HSB);
   c = int(random(255));
   a = height / 2;
   lines = new IntList();
}


void draw() {
   background(50);
   fill(c,255,255);


   // first rectangle/"line"
   rect(0,a,width,rect_height);
   // maps more rectangles ("lines")
   for (int j = 0; j < lines.size(); j++) {
       rect(0,lines.get(j) + a,width,rect_height);
   }
   // changing a value
   a = (a - 2);
   if (a < 0) {
       a = height;
   }
  
   // so color variable stays in range 0, 255
   if (c > 255) {c -= 255;} else if (c < 0) { c += 255;} 
  
   // random conditional color statements with a variable to add more lines with a random starting point
   // for the if/else if/else implementation
   if (a == height / 2) {
       i = int(random(height));
       lines.append(int(i));
   }  
   else if (a == height / 3) {
       i = int(random(height));
       lines.append(int(i));
   }
   else if (a == height / 4) {
       i = int(random(height));
       lines.append(int(i));
   }
   else {
       c ++;
   }
   c++; 
}