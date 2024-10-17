class Simulation {
  // Fields
  ArrayList<Atom> atoms;
  ArrayList<Molecule> molecules;
  ArrayList<Atom> atomsOnLegend;
  String name;
  
  
  // Constructor
  Simulation(String n) {
    this.atoms = new ArrayList<Atom>();
    this.atomsOnLegend = new ArrayList<Atom>();
    this.molecules = new ArrayList<Molecule>();
    this.name = n;
  }
  
  
  // Methods 
  // Adds an certain number of atoms to the simulation
  void addAtom(Atom a, int number) {
    for(int i = 0; i < number; i++) {
      Atom newAtom = new Atom(a.name, a.formula, a.size, a.atomColor, a.charge, a.mass);
      this.atoms.add(newAtom);
    }
    
    this.atomsOnLegend.add(a);
    numAtomsDrawn++;
  }
  
  
  // Adds an certain number of molecules to the simulation
  void addMolecule(Molecule a, int number) {
    for(int i = 0; i < number; i++) {
      Molecule newMolecule = new Molecule(a.a, a.b);
      this.molecules.add(newMolecule);
    }
  }
  
  
  // Draws all the atoms and molecules onto the screen and updates their positions
  void drawSimulation() {
    drawLegend();
    
    // Draw all atoms
    for(Atom a : this.atoms) {
      a.drawAtom();
    }
    
    // Draw all molecules 
    for(Molecule a : this.molecules) {
      a.drawMolecule();
    }
    
    updatePositionOfAtomsAndMolecules();
  }
  
  
  // Resets the simulation
  void resetSimulation() {
    ArrayList<Atom> temporaryAtoms = this.atoms; 
    
    // Add the atoms in the molecules to the temporary atoms array
    for(Molecule m : this.molecules) {
      for(Atom a : m.atomsAttachedToMolecule) {
        temporaryAtoms.add(a);
      }
    }
    
    // Clear the arraylists to reset the animation
    this.atoms = new ArrayList<Atom>();
    this.molecules.clear();
    
    // Goes through all the temporary atoms and adds them again to the simulation
    for(Atom atom : temporaryAtoms) {
      Atom newAtom = new Atom(atom.name, atom.formula, atom.size*atomScaleDown, atom.atomColor, atom.charge, atom.mass);
      this.atoms.add(newAtom);
    }
  }
  
  
  // Updates the position of all the atoms in the simulation
  private void updatePositionOfAtomsAndMolecules() {
    PVector force;
    PVector acceleration;
    
    // This for loop calculates the acceleration of each pair of atoms based on the force
    for(int i = 0; i < this.atoms.size(); i++) {
      for(int j = 0; j < this.atoms.size(); j++) {
        
        if(i != j) {
          force = calculateForceOfAttractionOrRepulsion(this.atoms.get(i), this.atoms.get(j));
          // Fnet = ma -> a = Fnet / m
          acceleration = force.div(this.atoms.get(i).mass); 
          this.atoms.get(i).acceleration.add(acceleration);
        }
      }
    }
    
    // This for loop calculates the acceleration of each pair of molecules based on the force
    for(int i = 0; i < this.molecules.size(); i++) {
      for(int j = 0; j < this.molecules.size(); j++) {
        
        if(i != j) {
          force = calculateForceOfAttractionOrRepulsionMolecule(this.molecules.get(i), this.molecules.get(j));
          
          // Fnet = ma -> a = Fnet / m
          acceleration = force.div(this.molecules.get(i).mass);
          this.molecules.get(i).acceleration.add(acceleration);
        }
      }
    }
    
    // This loop calculates the acceleration of each pair of atoms and molecules based on the force
    for(int i = 0; i < this.atoms.size(); i++) {
      for(int j = 0; j < this.molecules.size(); j++) {
        
        // Calculates the force on each atom to each molecule
        force = calculateForceOfAttractionOrRepulsionAtomAndMolecule(this.atoms.get(i), this.molecules.get(j));
        acceleration = force.div(this.atoms.get(i).mass);
        this.atoms.get(i).acceleration.add(acceleration);
        
        force = calculateForceOfAttractionOrRepulsionMoleculeAndAtom(this.molecules.get(j), this.atoms.get(i));
        acceleration = force.div(this.molecules.get(j).mass);
        this.molecules.get(j).acceleration.add(acceleration);
      }
    }
    
    // This method determines if two atoms are close enough in proximity to become a molecule
    createMolecule();
    
    // This method determines if an atom and molecule are close enough in proximity to become a new molecule
    createMoleculeFromAtomAndMolecule();
  }
  
  
  // Determines if two atoms are in close enough proximity to each other to become a molecule
  private void createMolecule () {
    
    // Goes through all the atoms on screen
    for(int i = 0; i < this.atoms.size(); i++) {
      for(int j = i+1; j < this.atoms.size(); j++) {
        Atom a = this.atoms.get(i);
        Atom b = this.atoms.get(j);
        
        // If they have opposite charges
        if((a.charge < 0 && b.charge > 0) || (a.charge > 0 && b.charge < 0)) {
          
          // If they are within proximity to bond, create a new molecule
          if(a.position.dist(b.position) < a.size/2 + b.size/2) {
            
            Molecule returnMolecule = new Molecule(a, b);
            this.molecules.add(returnMolecule);
            
            // Remove the original atoms making the molecule
            if(i > j){
              this.atoms.remove(i);
              this.atoms.remove(j); 
            }
            
            else {
              this.atoms.remove(j);
              this.atoms.remove(i);
            }
          }
        }
      }
    }
  }
  
  
  // Determines if a molecule and an atom are close enough proximately to create a new molecule
  private void createMoleculeFromAtomAndMolecule() {
    
    // Goes through all the atoms and molecules on screen
    for(int i = 0; i < this.atoms.size(); i++) {
      for(int j = 0; j < this.molecules.size(); j++) {
        if(this.atoms.size() > 0) {
          
          Atom a = this.atoms.get(i);
          Molecule b = this.molecules.get(j);
          
          // Only create a new molecule if they have opposite charges
          if((a.charge < 0 && b.charge > 0) || (a.charge > 0 && b.charge < 0)) {
            
            // If they are within proximity to bond, create a new molecule
            if(a.position.dist(b.position) < a.size/2 + b.size/2) {
              
              Molecule returnMolecule = new Molecule(b, a);
              this.molecules.add(returnMolecule);
              
              // Remove the original atom and molecule after making the molecule
              this.atoms.remove(i);
              this.molecules.remove(j); 
              if(i != 0) {
                i--;
              }
            }
          }
        }
      }
    }
  }
  
  
  // Draws the legend
  private void drawLegend() {
    int sHeight = 220;
    float sWidth = padding + 75;
    Text atomText;
    
    // Draws the title 
    Text title = new Text(this.name, new PVector(width/2, padding + 50), 0, 32);
    title.drawText();
    
    // Draws the text "legend"
    Text legendText = new Text("Legend", legendTextPosition, 0, 26);
    legendText.drawText();
    
    // Draws the hint at the bottom of the screen
    Text hint = new Text("Click to move to the next simulation, or press r to restart current simulation", new PVector(width/2, height-padding-25), 0, 16);
    hint.drawText();
    
    
    // Draws the atoms on the legend 
    for(Atom atom : this.atomsOnLegend) {
      
      // Draws the atom with its text
      fill(atom.atomColor);
      circle(sWidth, padding + sHeight, atom.size/atomScaleDown);
      atomText = new Text(atom.formula, new PVector(sWidth, padding + sHeight), atom.charge);
      atomText.drawText();
      
      // Draws the text descriptions of the atom
      String atomCharge;
      if(atom.charge > 0) {
        atomCharge = "+" + str(atom.charge);
      } 
      
      else {
        atomCharge = str(atom.charge);
      }
      
      // Draws each of the atom descriptions onto the screen
      String description = "Name: " + atom.name + "\nFormula: " + atom.formula + "\n" + "Charge: " + atomCharge + "\nMass: " + atom.mass + " amu\nAtomic Radius: " + int(atom.size*atomScaleDown) + " ppm";
      Text atomDescription = new Text(description, new PVector(sWidth + 170, padding + sHeight+10), 0, 18);
      atomDescription.drawText();
      
      // Increments 
      sHeight += 170;
      
      if(sHeight > height-padding-100) {
        sHeight = 220;
        sWidth += 325;
      }
    }
  }
}
