PFont f1, f2;

void setup() {
  size(600, 600);
  background(0);

  f1 = createFont("Cambria", 60);
  f2 = createFont("Garamond", 36);

  String msg1 = "5 x 7 = " + 5*7;
  String msg2 = "I think \u2234 I am";  //Using a Unicode code for the "therefore" symbol.
  
  fill(0, 140, 255);
  textFont( f1 );
  text( msg1, 100, 200 );
 
  fill(130, 200, 0);
  textFont( f2 );
  text( msg2, 300, 300 ); 
}
