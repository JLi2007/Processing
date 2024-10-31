int[] a = {5, 9, 3, 10};

//CAN YOU GUESS WHAT TRY-CATCH DOES?
//CAN YOU SEE HOW TO USE THIS TECHNIQUE TO SAFELY HANDLE COUNTING
//THE ALIVE NEIGHBOURS OF CELLS THAT ARE ON THE EDGE OF THE GOL GRID?
void printArrayAtIndexSAFE( int i ) {
  try { 
    println("The value at index " + i + " is " + a[i]);
  }
  
  catch( Exception e ) {
    println("Ignoring your stupid request");  //you can also just leave this empty 
  }
}


void setup() {
  printArrayAtIndexSAFE( 3 );  //Okay
  printArrayAtIndexSAFE( 0 );  //Okay
  printArrayAtIndexSAFE( -1 ); //Okay also!
  printArrayAtIndexSAFE( 10 ); //Okay also!
  
  exit();
}
