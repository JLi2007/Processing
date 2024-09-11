
// Need G4P library
import g4p_controls.*;

//Create constants required for calculations
BaseTen c = new BaseTen("2.998 * 10^8");
BaseTen h = new BaseTen("6.626 * 10^-34");

//Adds the custom metal
Metal custom = new Metal("Custom", 2);
Metal currentMetal = custom;
ArrayList<Metal> m = new ArrayList<Metal>();

//max percentage of energy lost during photon energy transfer
float percentLostE = 0.8;

//Rest of objects
Laser l = new Laser(600, 1000);
Detector d = new Detector(0);
Battery b = new Battery(0.4);

//for the timer
long lastTimeCheck;
long currentTimeCheck;
long currentTime;
int es;

//arraylist of photons and electrons
ArrayList<Photons> p = new ArrayList<Photons>();
ArrayList<Electrons> e = new ArrayList<Electrons>();


//setup
void setup(){
  size(1200, 800);
  createGUI();
  textUpdate();
  
  //trackers
  lastTimeCheck = millis();
  currentTimeCheck = millis();
  currentTime = 0;
  es = 0;
  
  //adds all the different metals
  String[] metals = loadStrings("Elements.txt");
  m.add(custom);
  for (int i = 0; i < metals.length; i++){
    String[] tempM = split(metals[i], ",");
    m.add(new Metal(tempM[0], parseFloat(tempM[1])));
  }
}

//updates info panel of gui
void textUpdate(){
  Metal_Info.setText("\n Metal information \n \n Metal Name: " + currentMetal.name + "\n \u03D5 (workfunction): " + currentMetal.workFunction_eV + " eV \n \n Laser information \n \n \u03BB (wavelength): " + l.wavelength_nm + " nm \n intensity: " + l.intensity + " photons/min");
}

//draws everything on screen
void draw(){
  background(0);

  //ejects electron per unit time
  if (millis() > lastTimeCheck + l.timeIntervals){
    lastTimeCheck = millis();
    p.add(l.eject());
  }
  
  //adjusts current reading per unit time
  if (es == 1 && currentTime == 0){
    currentTime = millis();
  }

  if (millis() > currentTimeCheck + 500){
    if (es >= 2) {
      currentTimeCheck = millis();
      d.currentUpdate(es / ((millis() - currentTime) / 1000.0) * 60);
    }
  }
  
  //battery
  b.create();
  
  //wire connecting light and detector
  noFill();
  stroke(100);
  strokeWeight(20);
  beginShape();
  curveVertex(424, 134);
  curveVertex(424, 134);
  curveVertex(253, 51);
  curveVertex(225, 214);
  curveVertex(225, 214);
  endShape();
  
  //laser
  l.create();

  //photons
  for (int i = p.size() - 1; i >= 0; i--){
    if (p.get(i).destination.x > p.get(i).position.x){
      p.get(i).create();
      p.get(i).update();
    }
    else{
      BaseTen deltaEnergy = p.get(i).energy.subtract(currentMetal.workFunction_J);
      if (deltaEnergy.constant > 0){
        float cons = random(deltaEnergy.constant * (1 - percentLostE), deltaEnergy.constant);
        BaseTen energyTransfer = new BaseTen(cons, deltaEnergy.exponent);
        Electrons ele = new Electrons(energyTransfer, b, p.get(i).position);
        e.add(ele);
      }
      p.remove(i);
    }
  }
  
  //Light source
  stroke(0);
  strokeWeight(2);
  fill(255);
  quad(500, 50, 400, 250, 355, 150, 400, 60);
  
  //electrons
  for (int i = e.size() - 1; i >= 0; i--){
    if ((e.get(i).position.x < 1075 && e.get(i).position.x > 245) || e.get(i).deltaD == 0){
      e.get(i).create();
      e.get(i).update();
    }
    else{
      if (e.get(i).position.x <= 245){
        es++;
      e.remove(i);
      }
    }
  }
  
  //metal
  currentMetal.create();
  
  //detector
  d.create();
}

//converts wavelength to RGB (visible spectrum)
color wavelengthToRGB(float w){
  w = int(w);
  float R;
  float G;
  float B;
  float SSS;

  if (w >= 380 && w < 440){
      R = -1 * (w - 440) / (440 - 350);
      G = 0.0;
      B = 1.0;
  }
  else if (w >= 440 && w < 490){
      R = 0.0;
      G = (w - 440) / (490 - 440);
      B = 1.0;
  }
  else if (w >= 490 && w < 510){
      R = 0.0;
      G = 1.0;
      B = -(w - 510) / (510 - 490);
  }
  else if (w >= 510 && w < 580){
      R = (w - 510) / (580 - 510);
      G = 1.0;
      B = 0.0;
  }
  else if (w >= 580 && w < 645){
      R = 1.0;
      G = -1 * (w - 645) / (645 - 580);
      B = 0.0;
  }
  else if (w >= 645 && w <= 780){
      R = 1.0;
      G = 0.0;
      B = 0.0;
  }
  else{
      return color(100);
  }

  //intensity correction
  if (w >= 380 && w < 420){
      SSS = 0.3 + 0.7*(w - 350) / (420 - 350);
  }
  else if (w >= 420 && w <= 700){
      SSS = 1.0;
  }
  else if (w > 700 && w <= 780){
      SSS = 0.3 + 0.7*(780 - w) / (780 - 700);
  }
  else{
      SSS = 0.0;
  }
  SSS *= 255;
  
  return color(int(SSS * R), int(SSS * G), int(SSS * B), 95);
}
