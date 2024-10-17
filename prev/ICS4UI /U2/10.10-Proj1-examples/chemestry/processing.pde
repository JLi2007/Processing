// Programmer: Feng Zhang
// ICS 4UI, 2022-11-11

// Note: Clicking "r" resets the animation, clicking with your mouse moves to the next simulation


// TRY CHANGING THESE VALUES
float attractivenessScale = 5;     // How much the force from coulombs law is multiplied by in powers of 10
float atomScaleDown = 1.8;         // How much the atoms are scaled down by. Recommended values of 1.5 - 2


// DON'T CHANGE THESE VALUES 
float padding = 50;
PVector rectStart;
PVector rectEnd;
PVector legendTextPosition;
int simulationNumber = 0;
int numAtomsDrawn = 0;
PFont font;

float forceMagnitude;
PVector forceVector;
float k = pow(8.988,9);  // Coulomb's constant
float oneElectronCoulomb = pow(1.602, -19);   // How many coulombs are in one elementary charge
float q1, q2;  
float r;


ArrayList<Simulation> simulations = new ArrayList<Simulation>();


void setup() {
  size(1200,800);
  surface.setTitle("Totally Accurate Atom Simulation");
  frameRate(30);
  
  // Set global variables 
  rectStart = new PVector(padding, padding);
  rectEnd = new PVector(width-padding, height-padding);
  legendTextPosition = new PVector(width/2, padding + 125);
  
  // Setup the font
  font = createFont("myFont.ttf", 16);
  textFont(font);
  
  
  // MAKING THE ATOMS USED 
  // Name, Formula, Size (in pm), Color, Charge, Mass (amu)
  
  // Alkali Metals
  Atom na = new Atom("Sodium", "Na", 190, color(255, 255, 0), 1, 22.99);
  Atom k = new Atom("Potassium", "K", 243, color(144, 144, 198), 1, 39.1);
  
  PVector p = new PVector(2,4);
  
  // Alkali Earth Metals
  Atom ca = new Atom("Calcium", "Ca", 194, color(0, 255, 0), 2, 40.08);
  
  // Post Transition Metals
  Atom al = new Atom("Aluminium", "Al", 118, color(166), 3, 26.98);
  
  // Reactive Non Metals
  Atom o = new Atom("Oxygen", "O", 48, color(0, 0, 255), -2, 16);
  
  // Halogens
  Atom cl = new Atom("Chlorine", "Cl", 79, color(255, 0, 0), -1, 35.45);
  Atom i = new Atom("Iodine", "I", 115, color(255, 0, 255), -1,  126.9);
  
  // Noble Gases
  Atom xe = new Atom("Xenon", "Xe", 108, color(0, 255, 0), 0, 131.29);
  Atom kr = new Atom("Krypton", "Kr", 110, color(171, 51, 46), 0, 83.8);
  Atom rn = new Atom("Radon", "Rn", 145, color(242, 27, 206), 0, 145);
  
  // Fun Atoms
  Atom schattman = new Atom("Mr Schattman", "Sm", 200, color(87, 73, 75), 10, 132);
  Atom student = new Atom("Student", "St", 65, color(156, 152, 212), -1, 75);
  
  
  // MAKING THE SIMULATIONS
  Simulation sim1 = new Simulation("Sodium Chloride Bonding (Table Salt)");
  Simulation sim2 = new Simulation("Ion Repulsions");
  Simulation sim3 = new Simulation("Calcium Iodide Bonding");
  Simulation sim4 = new Simulation("Aluminium Chloride");
  Simulation sim5 = new Simulation("Unreactive Noble Gases");
  Simulation sim6 = new Simulation("Madness");
  Simulation sim7 = new Simulation("Mr Schattman and His CS Class");
  
  
  // ADDING ATOMS TO THE SIMULATIONS
  sim1.addAtom(na, 10);
  sim1.addAtom(cl, 11);
  
  sim2.addAtom(cl, 7);
  sim2.addAtom(i, 7);
  sim2.addAtom(o, 3);
  
  sim3.addAtom(ca, 5);
  sim3.addAtom(i, 9);
  
  sim4.addAtom(al, 6);
  sim4.addAtom(cl, 17);
  
  sim5.addAtom(xe, 5);
  sim5.addAtom(kr, 5);
  sim5.addAtom(rn, 5);
  
  sim6.addAtom(na, 2);
  sim6.addAtom(cl, 2);
  sim6.addAtom(i, 2);
  sim6.addAtom(ca, 2);
  sim6.addAtom(al, 2);
  sim6.addAtom(kr, 2);
  sim6.addAtom(rn, 2);
  sim6.addAtom(k, 2);
  
  sim7.addAtom(schattman, 1);
  sim7.addAtom(student, 10);
  
  
  // ADDING THE SIMULATIONS TO THE ARRAYLIST OF SIMULATIONS
  simulations.add(sim1);
  simulations.add(sim2);
  simulations.add(sim3);
  simulations.add(sim4);
  simulations.add(sim5);
  simulations.add(sim6);
  simulations.add(sim7);
}


// Drawing the simulations
void draw() {
  background(0);
  fill(242, 219, 218);
  rectMode(CORNERS);
  rect(rectStart.x, rectStart.y, rectEnd.x, rectEnd.y);
  
  // Draw the current simulation
  simulations.get(simulationNumber).drawSimulation();
}
