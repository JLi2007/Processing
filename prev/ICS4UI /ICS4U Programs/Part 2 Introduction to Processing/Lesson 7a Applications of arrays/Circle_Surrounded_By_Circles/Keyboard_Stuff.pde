void keyPressed() {    
  if ( keyCode == RIGHT ) {        
    n++;         
    reset();
  } 
  
  else if ( keyCode == LEFT ) {        
    n--;         
    reset();
  }
  
  else {        
    try {            
      n = int(str(key));            
      noLoop();            
      reset();            
      loop();
    }            
    catch(Exception e) {
    }
  }
}
