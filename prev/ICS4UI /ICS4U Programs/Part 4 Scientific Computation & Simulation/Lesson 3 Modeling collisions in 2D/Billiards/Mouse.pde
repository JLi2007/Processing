void mouseClicked() {
  if (mode.equals("animating")){
    arrangeBalls(numRows);
    mode = "placing";
  }
}

void mousePressed() {
  if (!mode.equals("animating"))
    if ( dist(mouseX, mouseY, balls[0].pos.x, balls[0].pos.y) < r )
      cueballClicked = true;
}


void mouseDragged() {
  if ( cueballClicked ) {

    if ( mode.equals("placing" )) {
      balls[0].pos.x = mouseX;
      balls[0].pos.y = mouseY;
    } 
    else if ( mode.equals("aiming" )) {
      balls[0].vel.x = (mouseX-balls[0].pos.x)/10;
      balls[0].vel.y = (mouseY-balls[0].pos.y)/10;
    }
  }
}


void mouseReleased() {
  if ( cueballClicked ) {
    
    if ( mode.equals("placing" )) {
      mode = "aiming";
      cueballClicked = false;
    } 
    
    else if ( mode.equals("aiming" )) { 
      mode = "animating";
    }
  }
}
