class Text {
  // Fields
  String text;
  int size;
  PVector position;
  int charge;
  
  
  // Constructor #1
  Text(String text, PVector position, int c) {
    this.text = text;
    this.position = position;
    this.charge = c;
    this.size = 14;
  }
  
  
  // Constructor #2
  Text(String text, PVector position, int c, int s) {
    this.text = text;
    this.position = position;
    this.charge = c;
    this.size = s;
  }
  
  
  // Methods
  // Draws the text onto the screen
  void drawText() {
    float offset = 0;
    
    // Setting the offset for the superscript charge drawing
    if(this.text.length() == 1) {
      offset = 7;
    }
    
    if(this.text.length() == 2) {
      offset = 13;
    }
    
    // Drawing the text on screen
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(this.size);
    text(this.text, this.position.x, this.position.y);
    
    // If the charge is not 0, draw the charge
    if(this.charge != 0) {
      String output = str(this.charge);
      
      // If the charge is positive add a positive sign to the text
      if(this.charge > 0) {
        output = "+" + output;
      }
      
      // If the charge is 1 or -1, remove the 1 
      if(abs(this.charge) == 1) {
        output = str(output.charAt(output.indexOf("1")-1));
      }
      
      // Draw the charge text onto the atom
      textAlign(CENTER, BOTTOM);
      textSize(10);
      text(output, this.position.x + offset, this.position.y);
    }
  }
}
