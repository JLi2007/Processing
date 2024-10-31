// used controlP5 library: http://www.sojamo.de/libraries/controlP5
import controlP5.*;
ControlP5 cp5;

// adjustable factors
int numPeople = 20;
int peopleSize = 30;
int Chaos = 30;

// how easy it is to find a cure (higher = easier)
float iqGain = 1.5;
// adjustable factors end

color[] colours;
ArrayList<Person> residents;
boolean cure = false;

void setup(){
  size(1000, 800);
  background(0);

  // initialize font (lags the setup for a split second)
  PFont font = createFont("Georgia", 80);
  textFont(font);

  // populate a colors array for better organization of colours
  colours = new color[3];
  colours[0] = color(225,10,10);
  colours[1] = color(32,252,3);
  colours[2] = color(10,10,225);

  // initialize the residents arraylist
  residents= new ArrayList<Person>();

  // ControlP5
  cp5 = new ControlP5(this);

  // buttons
  cp5.addButton("Add_Doctor")
     .setPosition(25, height/50)
     .setSize(200,height/25)
  ;

  cp5.addButton("Add_Resident")
     .setPosition(275, height/50)
     .setSize(200,height/25)
  ;
  cp5.addButton("Add_Sick")
     .setPosition(525, height/50)
     .setSize(200,height/25)
  ;

  // chaos slider
  cp5.addSlider("Chaos")
     .setPosition(775, height/50)
     .setSize(200,height/25)
     .setRange(1,60)
     .setValue(Chaos)
     .setSliderMode(Slider.FLEXIBLE)
  ;
  cp5.getController("Chaos")
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE)
  ;
  
  // populate residents arraylist
  for(int people=0; people<numPeople; people++){
    // picking a random status
    int randomStatus = int(random(0,2));

    try{
      if(randomStatus == 0){ //create sick resident
        createSickResident();
      }
      if(randomStatus == 1){ //create regular resident
        createNormalResident();
      }
      else{ //create healer/doctor
        createDoctorResident();
      }
    }
    catch(Exception e){
      println("Exception in creating people");
    }
  }
}

void draw(){
  background(0);

  // draw and update each resident
  for(Person resident: residents){
    resident.drawMe();
    resident.updatePos();
  }

  // IF a cure is found, then SICK people have no effect anymore
  if(cure){
    fill(10, 10, 225);
    textAlign(CENTER, CENTER);
    text("Cure Found!", width/2, height/2);
  }
}

// functions that create the different statuses of residents
void createSickResident(){
  residents.add(new Person(random(peopleSize,width-peopleSize), random(peopleSize,height-peopleSize), random(-2,-1), random(-2,-1), colours[0], 0, peopleSize, iqGain));
}

void createNormalResident(){
  residents.add(new Person(random(peopleSize,width-peopleSize), random(peopleSize,height-peopleSize), random(1,2), random(1,2), colours[1], 1, peopleSize, iqGain));
}

void createDoctorResident(){
  residents.add(new Person(random(peopleSize,width-peopleSize), random(peopleSize,height-peopleSize), random(1,2), random(1,2), colours[2], 2, peopleSize, iqGain));
} 

// event from addDoctorResident button
public void Add_Doctor() {
  createDoctorResident();
}
// event from addResident button
public void Add_Resident() {
  createNormalResident();
}
//event from addSickResident button
public void Add_Sick() {
  createSickResident();
}

// event handler from the Chaos slider
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom("Chaos")) {  // Only trigger if Chaos changes
    int doctorSpeed = (int) theEvent.getValue();  // Update the global variable
    setDoctorSpeed(doctorSpeed);                      // Apply wage effect
  }
}

// increasing/decreasing the chaos turns the whole scene more/less chaotic
void setDoctorSpeed(float wage){
  for(Person resident: residents){
    if(resident.status == 2){
      // increasing/decreasing the velocity
      if(resident.pos.x > width*4/5 || resident.pos.y > height*4/5){
        resident.vel = new PVector(-wage/15,-wage/15);
      }else{
        resident.vel = new PVector(wage/15,wage/15);
      }
    }
  }
}