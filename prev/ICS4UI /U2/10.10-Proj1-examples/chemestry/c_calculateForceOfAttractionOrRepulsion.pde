// Calculates the forces of attraction or repulsion of all the atoms in the simulation based on coulomb's law
PVector calculateForceOfAttractionOrRepulsion(Atom a, Atom b) {
  
  // The distance between the two atoms (be careful about division by 0);
  r = dist(a.position.x, a.position.y, b.position.x, b.position.y);
  
  // The charge of the two atoms
  q1 = a.charge * oneElectronCoulomb;
  q2 = b.charge * oneElectronCoulomb;
  
  
  // The magnitude of the force
  forceMagnitude = k*q1*q2/(pow(r,2)) * pow(10, attractivenessScale);
  
  // To find the vector between the two atoms, subtract the position vectors of the atoms. 
  forceVector = PVector.sub(a.position, b.position);
  
  // Change it to a unit vector so that we can assign the new magnitude from the forceMagnitude calculated above
  forceVector = forceVector.normalize();
  
  // Assign the new force magnitude
  forceVector = forceVector.mult(forceMagnitude);
  
  return forceVector;
}


// Calculates the forces of attraction or repulsion of all the molecules in the simulation based on coulomb's law
PVector calculateForceOfAttractionOrRepulsionMolecule(Molecule a, Molecule b) {
  
  // The distance between the two atoms (be careful about division by 0);
  r = dist(a.position.x, a.position.y, b.position.x, b.position.y);
  
  // The charge of the two atoms
  q1 = a.charge * oneElectronCoulomb;
  q2 = b.charge * oneElectronCoulomb;
  
  
  // The magnitude of the force
  forceMagnitude = k*q1*q2/(pow(r,2)) * pow(10, attractivenessScale);
  
  // To find the vector between the two atoms, subtract the position vectors of the atoms. 
  forceVector = PVector.sub(a.position, b.position);
  
  // Change it to a unit vector so that we can assign the new magnitude from the forceMagnitude calculated above
  forceVector = forceVector.normalize();
  
  // Assign the new force magnitude
  forceVector = forceVector.mult(forceMagnitude);
  
  return forceVector;
}


// Calculates the forces of attraction or repulsion between all atoms and molecules in the simulation based on coulomb's law
PVector calculateForceOfAttractionOrRepulsionAtomAndMolecule(Atom a, Molecule b) {
  
  // The distance between the two atoms (be careful about division by 0);
  r = dist(a.position.x, a.position.y, b.position.x, b.position.y);
  
  // The charge of the two atoms
  q1 = a.charge * oneElectronCoulomb;
  q2 = b.charge * oneElectronCoulomb;
  
  
  // The magnitude of the force
  forceMagnitude = k*q1*q2/(pow(r,2)) * pow(10, attractivenessScale);
  
  // To find the vector between the two atoms, subtract the position vectors of the atoms. 
  forceVector = PVector.sub(a.position, b.position);
  
  // Change it to a unit vector so that we can assign the new magnitude from the forceMagnitude calculated above
  forceVector = forceVector.normalize();
  
  // Assign the new force magnitude
  forceVector = forceVector.mult(forceMagnitude);
  
  return forceVector;
}


// Calculates the forces of attraction or repulsion between all molecules and atoms in the simulation based on coulomb's law
PVector calculateForceOfAttractionOrRepulsionMoleculeAndAtom(Molecule a, Atom b) {
  
  // The distance between the two atoms (be careful about division by 0);
  r = dist(a.position.x, a.position.y, b.position.x, b.position.y);
  
  // The charge of the two atoms
  q1 = a.charge * oneElectronCoulomb;
  q2 = b.charge * oneElectronCoulomb;
  
  
  // The magnitude of the force
  forceMagnitude = k*q1*q2/(pow(r,2)) * pow(10, attractivenessScale);
  
  // To find the vector between the two atoms, subtract the position vectors of the atoms. 
  forceVector = PVector.sub(a.position, b.position);
  
  // Change it to a unit vector so that we can assign the new magnitude from the forceMagnitude calculated above
  forceVector = forceVector.normalize();
  
  // Assign the new force magnitude
  forceVector = forceVector.mult(forceMagnitude);
  
  return forceVector;
}
