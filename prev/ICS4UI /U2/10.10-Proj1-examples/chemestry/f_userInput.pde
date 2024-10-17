// Go to the next simulation
void mousePressed() {
  if(simulationNumber < simulations.size() - 1) {
    simulationNumber++;
  }
  
  else {
    simulationNumber = 0;
  }
}


// Resets the animation
void keyPressed() {
  if(key == 'r') {
    simulations.get(simulationNumber).resetSimulation();
  }
}
