void setup() {
  size(1000,600);
  background(0);
  
  //THERE ARE 3 WAYS TO DECLARE AN ARRAY
  
  //WAY 1: LIST ALL THE VALUES IN ADVANCE USING A { } LIST
  int[] myMarks = {90, 83, 10, 70, 12, 6};
  
  //Printing the array
  println(myMarks);

  
  //Raising each mark in the array by 10
  for( int i=0 ; i < myMarks.length; i++ ) {
     myMarks[i] += 10;
  }
  
  //Reprinting
  println();
  println(myMarks);
  
  
  //YOUR TURN 2: FIND THE AVERAGE VALUE
  int sum = 0;
        
  for (int i = 0; i < myMarks.length; i++)           
     sum += myMarks[i];
        
  float avg = sum/myMarks.length;
  println("My average is " + avg);  
  
  
  //WAY 2: DECLARE THE SIZE IN ADVANCE BUT NOT THE VALUES...
  float[] xVals = new float[100]; //"new" TELLS PROCESSING TO ALLOCATE SPACE IN RAM FOR 10 DECIMAL NUMBERS
                                  //BUT DOES NOT ACTUALLY SET ANY VALUES YET
                                 
  float[] yVals = new float[100];
  
  //Now let's fill the arrays xVals and yVals with values
  for(int i = 0; i < xVals.length; i++ ) { //i++ means "i = i + 1"
    xVals[i] = i*width/100.0;  //xVals will equal
    yVals[i] = -(1/900.0)*pow(xVals[i] - 300, 2) + 100;         // y = (-1/900)(x-300)^2 - 100;
  }
  
  println(xVals);
  println();
  println(yVals);

  fill(255,255,0);
  noStroke();
  
  
  for(int i = 0; i < xVals.length; i++ ) { //i++ means "i = i + 1"
      square(xVals[i], yVals[i], 4);
  }

  
  
  //WAY 3: TELL PROCESSING JUST THE NAME OF THE ARRAY, BUT NOT EVEN THE SIZE!
  float[] bob;
  
  int n = int(random(10, 20));
  bob = new float[n];
  
  //Write a for loop that fills bob with n random numbers between -1 and 1.
  for(int i = 0; i < n; i++) {
    bob[i] = random(0, 500);
  }
  
  println();
  println(bob);
 
}
