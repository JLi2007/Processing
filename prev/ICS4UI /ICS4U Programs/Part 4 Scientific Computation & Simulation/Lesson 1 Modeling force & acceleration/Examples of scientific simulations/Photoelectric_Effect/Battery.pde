class Battery{
  float voltage;
  
  //constructor
  Battery(float v){
   this.voltage = v; 
  }
  
  //increase voltage by one
  void voltIncrease(){
    this.voltage++;
  }
  
  //decrease voltage by one
  void voltDecrease(){
    this.voltage--;
  }
  
  //change voltage
  void voltAdjust(float v){
    this.voltage = v; 
  }
  
  //creates battery on screen
  void create(){
    
    //wire connecting detector and battery
    noFill();
    stroke(100);
    strokeWeight(20);
    beginShape();
    curveVertex(535, 710);
    curveVertex(535, 710);
    curveVertex(70, 646);
    curveVertex(172, 400);
    curveVertex(172, 400);
    endShape();
    
    //wire connecting metal and battery
    beginShape();
    curveVertex(695, 710);
    curveVertex(695, 710);
    curveVertex(1153, 646);
    curveVertex(1081, 400);
    curveVertex(1081, 400);
    endShape();
    
    //battery visuals
    fill(170);
    strokeWeight(2);
    rect(515, 660, 200, 100, 7);
    fill(255);
    rect(535, 680, 160, 60);
    
    //text on battery displaying voltage
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(30);
    text(this.voltage + "V", 615, 710);
  }
  
}