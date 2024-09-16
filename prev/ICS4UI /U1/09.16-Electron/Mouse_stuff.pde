void mousePressed() {
  for( int i = 0; i < n; i++ ) {  
    if( dist( mouseX, mouseY, positions[i].x, positions[i].y) < electronDiameter )  {
      isSomethingSelected = true;
      electronSelected = i;
      velocities[i].set(0, 0);    //So that the selected electron stops moving...
      accelerations[i].set(0, 0); //...and is magically unaffected by the other electrons while the 
                                  //user drags it
      redraw();
    }
  }
}

void mouseReleased() {
  isSomethingSelected = false;
}

void mouseDragged() {
  if( isSomethingSelected == true ) {
    positions[ electronSelected ].set( mouseX, mouseY );
    velocities[ electronSelected ].set(0, 0);
    accelerations[ electronSelected ].set(0, 0);
    redraw();
  }
}
