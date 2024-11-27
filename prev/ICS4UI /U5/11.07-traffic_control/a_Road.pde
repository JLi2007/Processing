//Road Class//
class Road {
  //Road Variables
  String typeOfRoad;
  float laneWidth;
  int numLanes = 1; //minimun number of lanes is always one

  float shoulderWidth;
  float shoulderLineTop;
  float shoulderLineBottom;

  float[] centreLines;

  float roadWidth; 
  float laneSpacing; 

  float onRampY1;
  float onRampY2;
  float onRampY3;
  
  float onRampX1;
  float onRampX2;
  float onRampX3;

  float offRampY1;
  float offRampY2;
  float offRampY3;
  
  float offRampX1;
  float offRampX2;

  //Road contructor
  Road(String t, float l, int n) {
    this.typeOfRoad = t;
    this.laneWidth = l; 
    this.shoulderWidth = this.laneWidth/8;
    this.numLanes = n;
    this.calculateRoadStuff();
  }


  void calculateRoadStuff() { //calculates the location of the on ramp, off ramp, shoulder lines, lane spacing, shoulder width etc....
   
    this.shoulderLineTop = (height/2)-(this.laneWidth*this.numLanes/2)+this.shoulderWidth;
    this.shoulderLineBottom = (height/2)+(this.laneWidth*this.numLanes/2)-this.shoulderWidth;

    centreLines = new float[this.numLanes];

    this.roadWidth = this.shoulderLineBottom-this.shoulderLineTop;  
    this.laneSpacing = this.roadWidth/float(this.numLanes);

    this.onRampY1 = ((height/2) + this.numLanes*this.laneWidth/2) + (this.laneWidth/2.0 - 1);
    this.onRampY2 = this.onRampY1 + 86;
    this.onRampY3 = this.onRampY1 + 176;
    
    this.onRampX1 = 300;
    this.onRampX2 = width/2;
    this.onRampX3 = -50;

    this.offRampY1 = ((height/2) - this.numLanes*this.laneWidth/2) -  (this.laneWidth/2.0 - 1); 
    this.offRampY2 = this.offRampY1 - 86;
    this.offRampY3 = this.offRampY1 - 176;
    
    this.offRampX1 = width/2;
    this.offRampX2 = width - 300;

    this.createCentreLines();
  }


  void increaseLanes() { //Increases the number of lanes and recalculates various road stuff, also shifts the cars to correct position
    
    if (this.numLanes < 5) {
      this.numLanes++;
      this.calculateRoadStuff();
      shiftCars2();
    }
  }


  void decreaseLanes() { //Decreases the number of lanes and recalculates various road stuff, also shifts the cars to correct position
    
    if (this.numLanes > 1) {
      this.numLanes--;
      this.calculateRoadStuff();
      shiftCars1();
    }
  }


  void drawLane() { //Draws the actual road by calling all other methods that draw each part of the highway seperately
    stroke(200); //stroke 200 is gray
    
    if (this.numLanes == 1) { //Draws a single lane road
      strokeWeight(this.laneWidth);
      line(0, height/2, width, height/2);
      
    } else if (this.numLanes > 1) { //Draws a multi lane road
      strokeWeight(this.laneWidth*this.numLanes);  
      line(0, height/2, width, height/2);
      this.drawRoadStripes();
    }
    
    //Draws the shoulder lines, gets the centre lines, and draws the off and on ramps
    this.drawShoulderLines(); 
    this.createCentreLines();
    this.drawOnRamp();
    this.drawOffRamp();
  }


  void drawShoulderLines() { // draws the top and bottom shoulder line of the main road
    strokeWeight(2);
    stroke(255);

    line(0, this.shoulderLineTop, width, this.shoulderLineTop);
    line(0, this.shoulderLineBottom, width, this.shoulderLineBottom);
  }


  void drawRoadStripes() { // Draws the road stripes along a specific y-interval to seperate each lane
    strokeWeight(2);
    stroke(255);

    float xLine = 10; 
    float xInterval = 30;

    float yLine = this.shoulderLineTop+this.laneSpacing;

    for (int i = 0; i < (this.numLanes-1); i++) { //draws the road stripes using for loop
      for (int j = 0; j < width/xInterval; j++) {
        line(xLine, yLine, xLine+xInterval, yLine);
        xLine += (xInterval*2);
      }
      xLine = 10;
      yLine += this.laneSpacing;
    }
  }


  void createCentreLines() { //Stores the y values of the centres of each lane into a list (used as the y coordinates for the cars)
    strokeWeight(1);
    stroke(255, 0, 0);
    float centreLine = this.shoulderLineTop + this.laneSpacing/2.0;
    for (int i = 0; i < centreLines.length; i++) {
      //line(0, centreLine, width, centreLine);
      this.centreLines[i] = centreLine;
      centreLine += laneSpacing;
    }
  }


  void drawOnRamp() { //draws on ramp
    strokeWeight(this.laneWidth);
    stroke(200);

    //Draws the curved ramp and shoulder lines
    curve(this.onRampX3, this.onRampY3, 0, this.onRampY2, this.onRampX1, this.onRampY1, this.onRampX2, this.onRampY1);
    strokeWeight(this.laneWidth-this.shoulderWidth);
    stroke(255);
    curve(this.onRampX3, this.onRampY3, 0, this.onRampY2, this.onRampX1, this.onRampY1, this.onRampX2, this.onRampY1);
    strokeWeight(this.laneWidth-this.shoulderWidth - 4);
    stroke(200);
    curve(this.onRampX3, this.onRampY3, 0, this.onRampY2, this.onRampX1, this.onRampY1, this.onRampX2, this.onRampY1);

    //draws the acceleration lane
    strokeWeight(this.laneWidth);
    stroke(200);
    line(this.onRampX1, this.onRampY1, this.onRampX2, this.onRampY1);

    fill(200);
    strokeWeight(1);

    float laneEndY1 = this.onRampY1 - this.laneWidth/2.0;
    float laneEndY2 = this.onRampY1 + this.laneWidth/2.0 - 5;

    triangle(onRampX2+5, laneEndY1, onRampX2+100, laneEndY1, onRampX2+15, laneEndY2);

    //Draws the shoulder lines for the acceleration lane
    noFill();
    strokeWeight(2);
    stroke(255);

    float rampShoulderLineY = (this.onRampY1 + this.laneWidth/2.0) - this.shoulderWidth;
    line(this.onRampX1, rampShoulderLineY, this.onRampX2, rampShoulderLineY);      
    line((this.onRampX2+100) - (this.shoulderWidth+7), laneEndY1, (this.onRampX2+15) - (this.shoulderWidth+7), laneEndY2 - 2);
  }


  void drawOffRamp() { //draws off ramp
    strokeWeight(this.laneWidth);
    stroke(200);

    //Draws the curved ramp and shoulder lines
    curve(this.offRampX1, this.offRampY1, this.offRampX2, this.offRampY1, width, this.offRampY2, width+50, this.offRampY3);
    strokeWeight(this.laneWidth - this.shoulderWidth);
    stroke(255);
    curve(this.offRampX1, this.offRampY1, this.offRampX2, this.offRampY1, width, this.offRampY2, width+50, this.offRampY3);
    strokeWeight(this.laneWidth - this.shoulderWidth - 4);
    stroke(200);
    curve(this.offRampX1, this.offRampY1, this.offRampX2, this.offRampY1, width, this.offRampY2, width+50, this.offRampY3); 

    //Draws the deceleration lane
    strokeWeight(this.laneWidth);
    stroke(200);
    line(this.offRampX1, this.offRampY1, this.offRampX2, this.offRampY1);

    fill(200);
    strokeWeight(1);
    
    float laneEndY1 = this.offRampY1 - this.laneWidth/2.0 + 5;
    float laneEndY2 = this.offRampY1 + this.laneWidth/2.0;

    triangle(offRampX1, laneEndY2, offRampX1-100, laneEndY2, offRampX1-14, laneEndY1);
    
    //Draws the shoulder lines for the deceleration lane
    noFill();
    strokeWeight(2);
    stroke(255);

    float rampShoulderLineY = (this.offRampY1 - this.laneWidth/2.0) + this.shoulderWidth;
    line(this.offRampX1, rampShoulderLineY, this.offRampX2, rampShoulderLineY);
    line((this.offRampX1-100) + (this.shoulderWidth+7), laneEndY2, (this.offRampX1-14) + (this.shoulderWidth+7), laneEndY1 + 2);
  }
}
