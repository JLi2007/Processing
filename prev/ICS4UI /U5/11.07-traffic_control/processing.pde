import g4p_controls.*;

//Global Variables//

Road currentRoad; //Initalizing the road, will create it setup as it uses the screen width and height as values

ArrayList<Car> allCars = new ArrayList<Car>(); //An ArrayList for the car class, all car data type are stored in here

boolean paused = false;
boolean cleared = false;

//Colours
color blue = color(0, 0, 255); 
color red = color(255, 0, 0);
color orange = color(255, 165, 0);

//Frame counter and frame rate
int framesPerSec = 30;
float currentFrame = 0;

int lastLaneNumber = 2;

//These are the values you can change in the GUI////
float agrFac;            //Aggresion factor: determines much faster cars are from there max speed, if they ignore speed limits, how often they pass, etc...
int carInflow;           //How many cars enter the screen every frame 

float constMaxS;         //The max speed of an individual car

float constMaxAcc;       //The max acceleration of an individual car
float constMaxDec;       //The max deceleration of an individual car

float contantPass;       //Random chance a car will pass to another lane (out of 100)
float offRampChance;     //The chance a car will use the off ramp (out of 100)
float onRampChance;      //The chance a car will come from the on ramp (out of 100)
float highWaySpeedLimit; //The speed limit of the highway

//These values are the final values the car recieves, and it takes into account the aggresion level 
float maxS; 
float minS;

float maxAcc; 
float minAcc; 

float maxDec;
float minDec; 

float followingDistance; 

float passChance; 
float ignoreChance; 

float safePass; 
float carStartX; 


void setup() {
  background(0);
  size(1400, 500); //The ideal screen width is 1800, however, if this doesn't fit the screen then you can bring it lower. The minimum it should be is 1200 otherwise there will be visual bugs
  createGUI();
  
  //Giving initial car values
  agrFac = agr.getValueF(); 
  carInflow = inflow.getValueI(); 
  constMaxS = speed.getValueF();
  constMaxAcc = acc.getValueF();
  constMaxDec = dec.getValueF();
  contantPass = pass.getValueF();
  offRampChance = offR.getValueF();
  onRampChance = onR.getValueF();
  highWaySpeedLimit = speedLimit.getValueF();
  
  currentRoad = new Road("Straight", 50, lastLaneNumber);

  addCar();

  frameRate(framesPerSec);
}


//Gets the values of the car in case the GUI values have been changed
void getCarValues() {

   maxS = constMaxS + 3*agrFac; //The max speed an individual car can reach
   minS = 2 + 1*agrFac; // The min speed an individual car can reach

   maxAcc = constMaxAcc + 0.1*agrFac; //The max acceleration of an individual car
   minAcc = 0.5 + 0.1*agrFac; //The min acceleration of an individual car

   maxDec = constMaxDec - 0.1*agrFac; //The max deceleration rate of an individual car
   minDec = 1; //The min deceleration rate of an individual car, always one 

   followingDistance = 150.0 - 5*agrFac; //How far apart the centre of the cars are from one another

   passChance = contantPass + 5*agrFac; //The chance a car will pass, if able to
   ignoreChance = 5*agrFac; //The chance a car will ignore traffic laws and common sense

   safePass = followingDistance*1.2; //How far apart the cars have to be for them to pass lanes safely
   carStartX = -100; //The spawning point of the car, always 100 pixels off screen
}


//When called, adds a car with various random values
void addCar() {
  getCarValues();
  int laneNumber; //What lane the car will spawn on

  //Depending on the set chance, the car can spawn on the main road, or the on rano
  if (random(0, 100) < (100-onRampChance)) {
    laneNumber = round(random(0, (currentRoad.numLanes)-1));
  } else {
    laneNumber = currentRoad.numLanes;
  }

  boolean spawnCar = checkIfSpawn(laneNumber); //Determines if its safe to spawn a car the given lane/on ramp

  //If it is safe to spawn car
  if (spawnCar) {

    //Gets the random maximum and minimum speeds, along with acceleration and deceleration, (note: the maximum speed is different from the speed limit)
    float mxSpeed = random(maxS - (maxS/3), maxS); 
    float mnSpeed = random(minS, minS +(minS/3));
    float acceleration = random(minAcc, maxAcc);
    float deceleration = random(minDec, maxDec);

    //Depending on if the car has spawned on the main road, or on ramp, it will have different starting values and speeds
    float carX = carStartX;
    float carY;
    boolean onRamp;
    float initialSpeed;

    if (laneNumber >= 0 && laneNumber < currentRoad.numLanes) { //If on main road, spawn at the centre of the given lane, and have a random speed
      carY = currentRoad.centreLines[laneNumber];
      initialSpeed = random(mnSpeed, highWaySpeedLimit/2);
      onRamp = false;
    } else { //Otherwise, start at half the speed limit, and spawns at the y coordiante of the ramp
      carY = currentRoad.onRampY2;
      initialSpeed = highWaySpeedLimit/2;
      onRamp = true;
    }

    //Gets the random pass, off ramp use, and ignore factor of each car 
    float passF = random(1, 100);
    float offRF = random(1, 100);
    float igF = random(1, 100);

    //Create a new car with the above values
    allCars.add(new Car(initialSpeed, acceleration, deceleration, mnSpeed, mxSpeed, carY, carX, currentRoad, laneNumber, passF, onRamp, offRF, igF));
  }
}


void draw() {
  if (!(paused)) {
    background(0);
    currentRoad.drawLane(); //Draws the road every frame

    for (int i = 0; i < allCars.size(); i++) { //For every car
      allCars.get(i).drawCar(); //Draw the car first
      checkCollision(i); //Check if collision has occured

      //Check if the car needs to break, or if is okay to accelerate
      boolean carBreak = checkIfCarBrake(i);
      if (carBreak) {
        allCars.get(i).decelerate();
      } else if (!(carBreak)) {
        allCars.get(i).accelerate();
      }

      //Depending on various factors, determine wheter a car will WANT to pass to another lane (ex. how long has it been since the car last made a pass?)
      if ( (currentRoad.numLanes > 1 && !(allCars.get(i).onRamp) && !(allCars.get(i).offRamp) && !(allCars.get(i).collision) && allCars.get(i).passTime > 1 && !(allCars.get(i).wantToPass) ) && 
        ( (allCars.get(i).passFactor < passChance) || (allCars.get(i).ignoreFactor < ignoreChance) || carBreak ) ) { //NOTE: A car will always want to pass if it below a certain speed, no matter what the pass factor is!

        allCars.get(i).wantToPass = true;
        allCars.get(i).passTime = 0;
        allCars.get(i).passLane = whatLaneToPass(allCars.get(i).laneNumber);
      } 

      //If the car does not want to pass, then increase the pass time, 
      if (!(allCars.get(i).offRamp) && !(allCars.get(i).onRamp) && !(allCars.get(i).collision) && !(allCars.get(i).wantToPass) && !(allCars.get(i).canPass) && (currentFrame % framesPerSec) == 0) {
        allCars.get(i).passTime++;
      }

      //If the car has had a collision, increase the collision timer, which determines when to delete the car
      if (allCars.get(i).collision && (currentFrame % framesPerSec == 0)) {
        allCars.get(i).collisionTime++;
      }

      //Determines if it is possible to move to the off ramp, if the car wants to
      if ( (!(allCars.get(i).offRamp) && !(allCars.get(i).wantToPass) && !(allCars.get(i).collision) && ((allCars.get(i).carX >= currentRoad.offRampX1)  && 
        allCars.get(i).carX <= currentRoad.offRampX1 + 100) && allCars.get(i).laneNumber == 0) && (allCars.get(i).offRampFactor < offRampChance) ) {

        allCars.get(i).offRamp = true;
      }

      //Determines if the car CAN pass if it WANTS to pass
      if (allCars.get(i).wantToPass && !(allCars.get(i).canPass)) {
        allCars.get(i).canPass = safeToPass(i, allCars.get(i).passLane);
      } else if (allCars.get(i).wantToPass && allCars.get(i).canPass) {
        allCars.get(i).crossLane();
      }

      //Moves the car accross the screen depending on if it is on the on ramp, off ramp, or the main road
      if (!(allCars.get(i).onRamp) && !(allCars.get(i).offRamp) && !(allCars.get(i).collision)) {
        allCars.get(i).moveCarRight();
      } else if (allCars.get(i).onRamp && !(allCars.get(i).collision)) {
        allCars.get(i).moveOnRamp();
      } else if (allCars.get(i).offRamp && !(allCars.get(i).collision)) {
        allCars.get(i).moveOffRamp();
      } else if (allCars.get(i).collision) {
        allCars.get(i).collisionMovement();
      }
    }
    
    if (currentFrame % (framesPerSec/carInflow) == 0) { //Adds a new car depending on the inflow variable
       addCar();   
    }

    //Deletes all cars once they have left the screen, or if they have had a collision for a set time
    for (int i = 0; i < allCars.size(); i++) {  
      if (allCars.get(i).carX > width+(allCars.get(i).carWidth/2) || allCars.get(i).collisionTime > 5) {
        allCars.remove(i);
      }
    }

    currentFrame++;

  }
}


void clearCars() {
  int i = 0;
  while (i < allCars.size()) {
    allCars.remove(i);  
    i = 0;
  }
}


//If a lane has been removed, shift cars accordingly 
void shiftCars1() {

  //First, deletes all the cars in the top most lanes (the lane that is removed)
  int j = 0;
  int deadLane = numCarsInLane(0);
  
  while (deadLane > 0) {
    try {
      if (allCars.get(j).laneNumber == 0) {
        allCars.remove(j);
        j = 0;
        deadLane--;
      }
    }

    catch (IndexOutOfBoundsException E) {
      j = 0;
      deadLane--;
    }

    j++;
  }

  //Then, shift down all the cars, there are a lot of factors to account for since the cars can be on ramps, can be in the middle of  passing etc...
  for (int i = 0; i < allCars.size(); i++) {
    try {
      if (!(allCars.get(i).onRamp) && !(allCars.get(i).offRamp)) {
        allCars.get(i).laneNumber--;

        if (allCars.get(i).laneNumber == currentRoad.numLanes) {
          allCars.get(i).carY = currentRoad.onRampY1-5;
        } else {
          allCars.get(i).carY = currentRoad.centreLines[allCars.get(i).laneNumber];
        }

        if (allCars.get(i).canPass && allCars.get(i).passLane != 0) {
          allCars.get(i).passLane--;
        } else {
          allCars.get(i).passLane = allCars.get(i).laneNumber;
        }
      } else {
        if (allCars.get(i).onRamp) {
          allCars.get(i).laneNumber = currentRoad.numLanes; 

          if (allCars.get(i).carX > currentRoad.onRampX1) {
            allCars.get(i).carY = currentRoad.onRampY1;
          }

          if (allCars.get(i).wantToPass) {
            allCars.get(i).passLane = allCars.get(i).laneNumber - 1;
          }
        } else if (allCars.get(i).offRamp) {

          if (allCars.get(i).laneNumber == 0) {
            allCars.get(i).carY = currentRoad.centreLines[allCars.get(i).laneNumber];
          } else {
            if (allCars.get(i).carM == 0) {
              allCars.get(i).carY = currentRoad.offRampY1 + 5;
            }
          }
        }
      }
    }
    catch (IndexOutOfBoundsException e) {
    }
  }
}


//Similar to the function above, except it doesn't delete any cars and just moves them up
void shiftCars2() {

  //Much like the last one, there are a lot of factors to take into account
  for (int i = 0; i < allCars.size(); i++) {
    if (!(allCars.get(i).onRamp) && !(allCars.get(i).offRamp)) {
      allCars.get(i).laneNumber++;

      if (allCars.get(i).laneNumber == currentRoad.numLanes) {
        allCars.get(i).carY = currentRoad.onRampY1-5;
      } else {
        allCars.get(i).carY = currentRoad.centreLines[allCars.get(i).laneNumber];
      }

      if (allCars.get(i).canPass) {
        allCars.get(i).passLane++;
      } else {
        allCars.get(i).passLane = allCars.get(i).laneNumber;
      }
    } else {
      if (allCars.get(i).onRamp) {
        allCars.get(i).laneNumber = currentRoad.numLanes; 

        if (allCars.get(i).carX > currentRoad.onRampX1) {
          allCars.get(i).carY = currentRoad.onRampY1;
        }

        if (allCars.get(i).wantToPass) {
          allCars.get(i).passLane = allCars.get(i).laneNumber - 1;
        }
      } else if (allCars.get(i).offRamp) {
        if (allCars.get(i).laneNumber == 0) {
          allCars.get(i).carY = currentRoad.centreLines[allCars.get(i).laneNumber];
        } else {
          if (allCars.get(i).carM == 0) {
            allCars.get(i).carY = currentRoad.offRampY1 + 5;
          }
        }
      }
    }
  }
}


//Checks whether a car should break/decelerate
boolean checkIfCarBrake(int i) {
  //Gets the values of the car the function is called for
  boolean carBrake = false;
  int currentLane = allCars.get(i).laneNumber;
  float currentX = allCars.get(i).carX;
  float currentY = allCars.get(i).carY;
  float currentSpeed = allCars.get(i).carSpeed;
  float distance;
  float brakingDist;

  //Looks at every car except the specified one
  for (int a = 0; a < allCars.size(); a++) {
    if (a != i) {

      //Depending on how close the car is to other car in its lane or cars wanting to pass to its lane it will break
      if ((currentLane == allCars.get(a).laneNumber || (currentLane == allCars.get(a).passLane && allCars.get(a).canPass)) && (currentX < allCars.get(a).carX)) {
        if (currentSpeed >= allCars.get(a).carSpeed) {
          distance = sqrt(pow(allCars.get(a).carX - currentX, 2) + pow(allCars.get(a).carY - currentY, 2)); //The distance between two cars

          if (distance >= followingDistance) { //If the distance is more than the following distance, find the braking distance
            distance -= followingDistance; 
            brakingDist = allCars.get(i).getBrakingDistance(allCars.get(a).carSpeed); //gets braking distance, (how far the car will travel once it brakes)

            if (distance <= brakingDist) { //If the distance between each car is less than or equal to the braking distance, then the car should brake to match the speed of the front car
              carBrake = true;
              allCars.get(i).minSpeed = allCars.get(a).carSpeed;
            }
          } else if (distance < followingDistance) { //If the distance is less than the following distance, the car should brake and its speed is set to match the front car
            carBrake = true;
            allCars.get(i).minSpeed = allCars.get(a).carSpeed;
            allCars.get(i).carSpeed = allCars.get(a).carSpeed;
          }
        }
      }
    }
  }

  //The car can sometimes ignore the above statements depedening on its ignore factor
  if ((allCars.get(i).ignoreFactor < ignoreChance)) {
    carBrake  = false;
  }

  //However, it can not ignore these statements, as they prevent the car from going off the highway

  if (allCars.get(i).onRamp) { //If the car hasn't left the on ramp after a certain interval, it should brake in order to avoid jumping off the acceleration lane
    distance = sqrt(pow(currentRoad.onRampX2 - currentX, 2) + pow(currentRoad.onRampY1 - currentY, 2));
    brakingDist = allCars.get(i).getBrakingDistance(0); 

    if (distance <= brakingDist || distance <= 300) {
      carBrake  = true;
      allCars.get(i).minSpeed = 0;
    } 
    if (distance <= 100) {
      carBrake = true;
      allCars.get(i).carSpeed = 0;
      allCars.get(i).minSpeed = 0;
    }

    //If the car is on the off ramp, it should brake untill it matches the speed of the normal roads, (in this case that it 10 pixels per frame)
  } else if (allCars.get(i).offRamp && !(carBrake)) { //Actually on the off ramp
    if (allCars.get(i).laneNumber == -1) {

      if (allCars.get(i).carSpeed < 3) {
        allCars.get(i).minSpeed = 10;
        carBrake = true;
      } else if (allCars.get(i).carSpeed > 10) {
        allCars.get(i).minSpeed = 10;
        carBrake = true;
      }

      //If the car is about to enter the off ramp, it should slow down
    } else if (allCars.get(i).offRamp && allCars.get(i).laneNumber == 0 && !(carBrake) && (allCars.get(i).offRampFactor < offRampChance)) {
      distance = sqrt(pow(currentX - currentRoad.offRampX1, 2) + pow(currentY - currentRoad.centreLines[0], 2));
      brakingDist = allCars.get(i).getBrakingDistance(10); 

      if (distance <= brakingDist || distance <= 100) {

        if (allCars.get(i).carSpeed < 3) {
          allCars.get(i).minSpeed = 10;
          carBrake  = true;
        } else if (allCars.get(i).carSpeed > 10) {
          allCars.get(i).minSpeed = 10;
          carBrake = true;
        }
      }
    }
  }
  return carBrake;
}


//Figures out if it is safe for a car to spawn on a given lane, or the on ramp
boolean checkIfSpawn(int lN) {
  boolean spawn = true; 

  for (int i = 0; i < allCars.size(); i++) {
    if (allCars.get(i).laneNumber == lN) {

      if (lN != currentRoad.numLanes) { //If the car is on the lane being checked
        if (( (allCars.get(i).carX - carStartX) <= followingDistance) && allCars.get(i).carX <= carStartX+followingDistance) { //Check if the car is too close to the spawn point, if it is, don't spawn it
          spawn = false;
        }
      } else {
        float distance = allCars.get(i).carM - carStartX; //If the car is on the on ramp

        if ((distance <= followingDistance*3) && allCars.get(i).carM <= carStartX+followingDistance*3) { //Similar to above, but since the lane is curved, the values need to be altered a little
          spawn = false;
        }
      }
    }
  }

  if (lN == currentRoad.numLanes) { //If the examined lane is the on ramp
    int numCars = numCarsInLane(currentRoad.numLanes); //If there are more than a specified number of cars on the on ramp, don't spawn

    if (numCars >= 15) {
      spawn = false;
    }
  }
  return spawn;
}


//Finds the number of cars in a given lane
int numCarsInLane(int lN) {
  int count = 0; 
  for (int i = 0; i < allCars.size(); i++) {
    if (allCars.get(i).laneNumber == lN) {
      count++;
    }
  }
  return count;
}

//Once a car wants to pass, this function is called to determine the ideal lane to pass
int whatLaneToPass(int lN) {
  int whatLane = lN;

  if (lN != 0 && lN != (currentRoad.numLanes-1)) { //If the current lane is one of the middle lane, pick the lane with the fewest cars
    int upLaneCars = numCarsInLane(lN-1);
    int downLaneCars = numCarsInLane(lN+1);
    int fewerCarLane = min(upLaneCars, downLaneCars);

    if (fewerCarLane == upLaneCars) {
      whatLane = lN-1;
    } else if (fewerCarLane == downLaneCars) {
      whatLane = lN+1;
    }
  } else if (lN == 0) { //If the current lane is the top lane, pick the lane below
    whatLane = lN+1;
  } else if (lN == currentRoad.numLanes-1) { //If the current lane is the bottom lame. pick the lane above
    whatLane = lN-1;
  }

  return whatLane;
}


//Once the car has picked what lane it wants to pass to, determine whether it is safe to pass or not
boolean safeToPass(int i, int passLaneNumber) {
  //Gets the values of the car being analyzed 
  boolean pass = true;
  float currentX = allCars.get(i).carX;
  float currentY = allCars.get(i).carY;
  int currentLane = allCars.get(i).laneNumber;

  //For every car except the one being checked
  for (int a = 0; a < allCars.size(); a++) {
    if (a != i) {

      if (passLaneNumber == allCars.get(a).laneNumber) { //If the car is in the pass lane
        float distance = sqrt(pow(allCars.get(a).carX - currentX, 2) + pow(allCars.get(a).carY - currentY, 2));

        if (distance <= safePass) { //If the distance between the current car, and the car in the pass lane is not safe, then dont pass
          pass = false;
        }
      } else if (passLaneNumber == allCars.get(a).passLane && (currentLane != allCars.get(a).laneNumber) && (allCars.get(a).wantToPass)) { //If another car wants to pass in the same lane
        float distance = sqrt(pow(allCars.get(a).carX - currentX, 2) + pow(allCars.get(a).carY - currentY, 2)); 

        if (distance <= safePass*2) { //If the distance between the two cars is not safe, dont pass
          pass = false;
        }
      }
    }
  }

  if (allCars.get(i).offRamp && allCars.get(i).carX >= currentRoad.offRampX1+100) { //If the car wants to go to the offRamp but it is too far from the lane, then it should not pass
    pass = false;  
    allCars.get(i).offRamp = false;
    allCars.get(i).wantToPass = false;
  }

  //Depending on the ignore factor, the car pass despite it being not safe to do so
  if (allCars.get(i).ignoreFactor < ignoreChance && !(allCars.get(i).offRamp)) { 
    pass = true;
  }

  return pass;
}


//Figures if a collision between two cars has occured
void checkCollision(int i) {
  //Values of the current car being analyzed
  float currentX = allCars.get(i).carX;
  float currentY = allCars.get(i).carY;

  for (int a = 0; a < allCars.size(); a++) { //For every car except the current one
    if (a != i) {

      if (allCars.get(i).carX > carStartX+followingDistance && !(allCars.get(i).offRamp) && !(allCars.get(i).offRamp)) {
        float distance = sqrt(pow(allCars.get(a).carX - currentX, 2) + pow(allCars.get(a).carY - currentY, 2));

        if (distance <= 40) { //If distance between the cars is less than 40 a collison has occured  
          allCars.get(i).collision = true;
          allCars.get(a).collision = true;
        }
      }
    }
  }
}
