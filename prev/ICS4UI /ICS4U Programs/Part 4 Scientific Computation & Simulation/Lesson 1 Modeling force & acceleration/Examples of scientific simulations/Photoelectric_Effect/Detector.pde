class Detector{
  float current;
  
  //constructor
  Detector(float c){
    this.current = c;
  }
  
  //creates current detector on screen
  void create(){
    
    //double detector plates
    fill(255);
    strokeWeight(2);
    rect(200, 200, 50, 400);
    rect(150, 250, 50, 300);
    
    //current displayer
    fill(240);
    rect(65, 370, 160, 60);
    textSize(15);
    fill(0);
    text("Current:", 145, 390);
    text(round(this.current * 10) / 10.0 + "e's/min", 145, 410);
  }
  
  //updates current reading
  void currentUpdate(float c){
    this.current = c;
  }
  
}