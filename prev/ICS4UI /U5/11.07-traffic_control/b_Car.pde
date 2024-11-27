//Car Class//
class Car {
  //Variables of each class, most are pretty self explanatory
  float carSpeed; 
  float carAcceleration;
  float carDeceleration;
  float minSpeed;
  float maxSpeed;

  float carY;
  float carX;
  float carM; //Used to move the car along the curved ramp using curvePoint
  color carColor;

  float carWidth;
  float carHeight;
  float rotateFactor; //the rotation of the car along its centre

  int laneNumber; //lane the car is currently in

  Road highWay;

  boolean wantToPass; //if a car wants to pass
  boolean canPass; //if a car is able to pass
  float passFactor; //chance to pass
  int passLane; //Lane the car wants to pass into
  int passTime; //How long it has been since the last pass

  //if on the on ramp or off ramp
  boolean onRamp;
  boolean offRamp;

  float offRampFactor; //chance to use off ramp
  float ignoreFactor; //chance to ignore common sense

  boolean collision; //if collision has occured
  int collisionTime; //how long it has been since the collison
  float collisionRotation; 

  //Car constructor
  Car(float cS, float cA, float cD, float min, float max, float cY, float cX, Road hW, int lN, float pF, boolean onR, float offRF, float igFact) {
    this.carWidth = 50; //car height and car width are always the same
    this.carHeight = 25;
    this.rotateFactor = 0;

    this.carSpeed = cS;
    this.carAcceleration = cA;
    this.carDeceleration = cD;
    this.minSpeed = min;
    this.maxSpeed = max;

    this.carY = cY;
    this.carX = cX;
    this.carM = 0;
    this.rotateFactor = 0; //0 means straight

    this.highWay = hW;
    this.laneNumber = lN;

    this.wantToPass = false; //The car doesn't want to or can pass initially
    this.canPass = false;
    this.passTime = 0;

    this.passFactor = pF;
    this.passLane = this.laneNumber; //the pass lane is intially the same as the current lane

    this.onRamp = onR;
    this.offRampFactor = offRF;
    this.offRamp = false; //the car does not start at the off ramp

    this.ignoreFactor = igFact;
    this.collision = false; 
    this.collisionTime = 0;
    this.collisionRotation = random(0, TWO_PI); //When the car has collided, it has been rotated to a random value
  }

  //draws the car
  void drawCar() {

    if (!(this.collision)) { //if the car has not collided, its colour will depend on its speed
      this.carColor = lerpColor(red, blue, this.carSpeed/this.maxSpeed);
    } else { //otherwise, the car will be orange
      this.carColor = orange;
    }

    rectMode(CENTER); //transfomrs, rotates and draws the car
    pushMatrix(); //allows the transformation to only occur on one car
    translate(this.carX, this.carY); //moves origin to car x and y values
    rotate(this.rotateFactor);

    fill(carColor);
    stroke(carColor);
    rect(0, 0, this.carWidth, this.carHeight); //since origin is car x and y, the coords of the rect are 0
    popMatrix();
  }

  //Moves the car along the right of the screen
  void moveCarRight() {
    if (this.carSpeed > 0) {
      this.carX += this.carSpeed;
    }
  }

  //Accelerates the car 
  void accelerate() {
    float mxSpeed; 

    if (this.ignoreFactor < ignoreChance) { //Depending on the aggresion factor, the max speed of the car will be its max speed or the road speed limit
      mxSpeed = this.maxSpeed;
    } else {
      mxSpeed = highWaySpeedLimit;
    }

    if (!this.collision) { //if a collison hasn't occured dont accelerate

      if (this.carSpeed < mxSpeed ) { //accelerate the car until it reaches the max speed

        if (!(this.onRamp)) {
          this.carSpeed += this.carAcceleration;
        } else if (this.onRamp) { //accelerate slower on the on ramp
          this.carSpeed += this.carAcceleration/3.0;
        }
      }

      if (this.carSpeed > mxSpeed ) { //if the car is over the max speed set the speed to max
        this.carSpeed = mxSpeed;
      }
    }
  }


  //Decelerates/brakes the car
  void decelerate() {
    if (this.carSpeed > this.minSpeed) { //if the car is over its min speed, then decelerate
      this.carSpeed -= this.carDeceleration;
    } 

    if (this.carSpeed < this.minSpeed) { //if the car is below its min speed, then set the speed to min speed
      this.carSpeed = this.minSpeed;
    }
  }


  //finds the distance a car will travel given its initial speed, final speed, and deceleration rate
  float getBrakingDistance(float finalVelocity) {
    float distance =  ( pow(finalVelocity, 2) - pow(this.carSpeed, 2) ) / (2*(-1.0)*this.carDeceleration) ;
    return distance;
  }


  //Moves the cars between lanes
  void crossLane() {
    float laneMoveIncrement = 10; //how fast the car will move between lanes

    if (this.passLane < this.laneNumber) { //Moves the car to lane above it
      this.carY -= laneMoveIncrement;

      if (!(this.offRamp)) { //Since the car will move up to the off ramp, some values may need to be changed sometimes
        this.rotateFactor = radians(highWay.centreLines[this.passLane] - this.carY);
      } else {
        this.rotateFactor = radians(highWay.offRampY1+5 - this.carY);
      }
    } 

    if (this.passLane > this.laneNumber) { //Moves the car to the lane below it
      this.carY += laneMoveIncrement;  
      this.rotateFactor = radians(highWay.centreLines[this.passLane] - this.carY);
    }

    try { //If the car has reached the same y value as the lane it wants to pass to, the passing is complete 
      if (!(offRamp)) { 

        if ((abs(int(this.carY) - int(highWay.centreLines[this.passLane]))) <= 10) { //Resets the passing variables of the cars once the passing has been completed
          this.carY = highWay.centreLines[this.passLane];
          this.laneNumber = this.passLane;
          this.wantToPass = false;
          this.canPass = false; 
          this.rotateFactor = 0;
        }
        
      } else { //if passing to off ramp

        if ((abs(int(this.carY) - int(highWay.offRampY1+5))) <= 10) {
          this.carY = highWay.offRampY1 + 5;
          this.laneNumber = this.passLane;
          this.wantToPass = false;
          this.canPass = false; 
          this.rotateFactor = 0;
        }
      }
    }
    catch (IndexOutOfBoundsException E) {
    }
  }


  //Moves the car along the on ramp
  void moveOnRamp() {

    if (carM <= highWay.onRampX1+25) { //if the car is on the curve of the ramp
      float t = this.carM / highWay.onRampX1;
      this.carX = curvePoint(highWay.onRampX3, 0, highWay.onRampX1, highWay.onRampX2, t); //uses the points of the highway ramp to move the car
      this.carY = curvePoint(highWay.onRampY3, highWay.onRampY2, highWay.onRampY1, highWay.onRampY1, t);
      this.carM += this.carSpeed;

      if (this.carM < 100) { //rotates the car along the curve of the ramp
        this.rotateFactor = radians((highWay.onRampY1 - this.carY)/2.8);
      } else {
        this.rotateFactor = radians((highWay.onRampY1 - this.carY)/(1/t));
      }
      
    } else { //if the car is on the accleration lane
      this.rotateFactor = 0; 
      this.moveAccelerationLane();
    }
  }


  //Moves the car along the acceleration lane
  void moveAccelerationLane() {
    this.carY = highWay.onRampY1-5;
    
    if (carX > (highWay.onRampX1) + 100) { //Once car has driven far enough, it will want to pass
      this.wantToPass = true;
      this.passLane = this.laneNumber-1;
    }
    
    if (!(this.canPass)) { //if it cant pass yet, keep moving it to the right
      this.moveCarRight();
      
    } else if (this.canPass) { //if it can pass, reset some values, and move it to the lane above
      this.carSpeed = maxS/2;
      this.onRamp = false;
      this.carM = 0;
    }
  }


  //Moves the car along the off ramp
  void moveOffRamp() {
    
    if (this.carX <= highWay.offRampX2 - 25) { //If at a specific x value, move it accross the deceleration lane
      this.moveDecelerationLane();
    
    } else { //Otherwise, move it along the curve of the off ramp
    
      float t = this.carM / highWay.onRampX1;
      this.carX = curvePoint(highWay.offRampX1, highWay.offRampX2, width, width+50, t); //uses the variables of the road to move the car
      this.carY = curvePoint(highWay.offRampY1, highWay.offRampY1, highWay.offRampY2, highWay.offRampY3, t);
      this.carM += this.carSpeed;
    
      if (this.carM > 100) { //rotates the car along the curve
        this.rotateFactor = radians((this.carY - highWay.offRampY1)/2.8);
      } else {
        this.rotateFactor = radians((this.carY - highWay.offRampY1)/(1/t));
      }
    }
  }


  //moves the car along the deceleration lane
  void moveDecelerationLane() {
    
    if (this.laneNumber == 0) { //if the car is still on the main road, make sure it wants to pass to the decleration lane
      this.wantToPass = true;
      this.passLane = this.laneNumber - 1;
    }
    this.moveCarRight(); //move the car right, until it reaches the curved part of the ramp
  }


  //Moves the car once it has entered a collision
  void collisionMovement() {
   
    if (this.collisionTime <= 3) { //For a few seconds
      this.canPass = false;
      this.wantToPass = false;
      this.minSpeed = 0;
      this.decelerate();
      this.carDeceleration += 0.1;
    
    } else {
      this.carAcceleration = 0;
      this.carDeceleration = 0;
    
    }
    this.moveCarRight();
    this.rotateFactor = this.collisionRotation;
  }
}
