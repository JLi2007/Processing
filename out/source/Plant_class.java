/* autogenerated by Processing revision 1293 on 2024-11-05 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import g4p_controls.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class Plant_class extends PApplet {

class Plant{
    PVector position;
    float diameter=random(100,150);

    Plant(float x, float y){
        this.position = new PVector(x,y);
    }
    
    public void drawMe(){
        fill(14, 158, 62);
        circle(this.position.x, this.position.y,diameter/2);
    }

    public void removeMe(){
        // I don't know how to actually remove an instance yet (Instead, im moving them into outer space). I wonder how you do that, will probably find out soon
        this.position = new PVector(-600,-600);
    }

    public PVector returnPos(){
        PVector pos = new PVector(this.position.x, this.position.y);
        return pos;
    }
}
float distance;
PVector plant_pos;

class Rabbit {
  //FIELDS (attributes that every rabbit has)
  String name, gender;
  PVector pos, vel;
  float speed, sightRadius, nervousness;
  int furColour;
  
  
  //CONSTRUCTOR (code to build a new Rabbit)
  // new Rabbit("Carl", 100, 315, "male", 6, color(140, 20, 15 ));
  Rabbit(String n, float x, float y, String g, float sp, float sr, int fc, float nv) {
    this.name = n;
    this.pos = new PVector(x, y);
    this.vel = new PVector( random(-2, 2), random(-2, 2) );
    this.speed = sp;
    this.sightRadius = sr;
    this.furColour = fc;
    this.nervousness = nv;
  }
  
  
  //METHODS (things a Rabbit can do)
  public void drawMe() {
    fill( this.furColour );
    square(this.pos.x, this.pos.y, 40);
    
    noFill();
    circle(this.pos.x, this.pos.y, 2*this.sightRadius);
    
    fill(0);
    text(this.name, this.pos.x, this.pos.y);
  }
  
  
  public void move() {
    for (Plant plant : plants) {
      plant_pos=plant.returnPos();
      distance = this.pos.dist(plant_pos);
      
      if(distance < this.sightRadius*2){
        PVector sub = PVector.sub(this.pos, plant_pos);
        sub.normalize();
        this.vel.mult(sub,distance);
        plant.removeMe();
      } 
    }

    if( random(0,100) < this.nervousness ) {  //change the 8 to something more general
      this.pickNewDirection();
    }
    
    this.pos.add( this.vel );

    if(this.pos.x>(600-this.sightRadius) || this.pos.x<(0+this.sightRadius) || this.pos.y>(600-this.sightRadius) || this.pos.y<(0+this.sightRadius)){
      this.vel.mult(random(-1.5f,-1));
    }
  }
  
  
  public void pickNewDirection() {
    float randAngle = random(0, TWO_PI);
    PVector randDir = new PVector( cos(randAngle), sin(randAngle)); //unit vector in the direction we want to go
    this.vel = PVector.mult(randDir, this.speed );
  }
 
}
/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void changePlants(GCustomSlider source, GEvent event) { //_CODE_:plantSlider:575540:
  numPlants = plantSlider.getValueI();
  createPlants();
} //_CODE_:plantSlider:575540:

public void pauseResume(GButton source, GEvent event) { //_CODE_:pause:517437:
  paused = !paused;
  if(pause.getText() == "pause"){
    pause.setText("resume");
    pause.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  }else{
    pause.setText("pause");
    pause.setLocalColorScheme(GCScheme.RED_SCHEME);
  }
} //_CODE_:pause:517437:


// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  plantSlider = new GCustomSlider(this, 50, 0, 100, 40, "grey_blue");
  plantSlider.setLimits(20, 0, 50);
  plantSlider.setNbrTicks(50);
  plantSlider.setNumberFormat(G4P.INTEGER, 0);
  plantSlider.setOpaque(false);
  plantSlider.addEventHandler(this, "changePlants");
  plantLabel = new GLabel(this, 60, 30, 80, 20);
  plantLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  plantLabel.setText("plants");
  plantLabel.setOpaque(false);
  pause = new GButton(this, 475, 15, 100, 40);
  pause.setText("pause");
  pause.setLocalColorScheme(GCScheme.RED_SCHEME);
  pause.addEventHandler(this, "pauseResume");
}

// Variable declarations 
// autogenerated do not edit
GCustomSlider plantSlider; 
GLabel plantLabel; 
GButton pause;
// Need G4P library


int numPlants = 20;
Plant[] plants = new Plant[numPlants];
ArrayList<Rabbit> rabbits = new ArrayList<Rabbit>();
boolean paused = false;

public void setup(){
  /* size commented out by preprocessor */;
  createGUI();

  rectMode(CENTER);
  textAlign(CENTER);
  createPlants();

  rabbits.add(new Rabbit("Charlie", 400, 315, "male", 2, 75, color(160, 100, 100 ), 20));
  rabbits.add(new Rabbit("Vidul", 100, 420, "female", 3.5f, 35, color(255, 255, 0), 2));
}

public void createPlants(){
  plants = new Plant[numPlants];
  for (int i = 0; i < plants.length; i++) {
    plants[i] = new Plant(random(600),random(600));
  }
}

public void draw(){
  background(230);

  background(0, 255, 50);

  // iterate through plants and draw each plant
  for (Plant plant : plants) {
    plant.drawMe();
  }

  for (Rabbit rabbit : rabbits){
    rabbit.drawMe();

    if(!paused){
        rabbit.move();
    }
  }
  
}


  public void settings() { size(600, 600, JAVA2D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Plant_class" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}