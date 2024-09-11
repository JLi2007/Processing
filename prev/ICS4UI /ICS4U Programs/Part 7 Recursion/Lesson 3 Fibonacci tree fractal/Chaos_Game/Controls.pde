void keyPressed() {
  if( key == 'p') {
    if (paused)
      loop();
    else
      noLoop();
     
    paused = !paused; 
  }
}
