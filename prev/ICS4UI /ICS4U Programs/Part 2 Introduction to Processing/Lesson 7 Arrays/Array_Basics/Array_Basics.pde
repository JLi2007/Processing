void setup() {
  size(600,600);
  background(0);
  
  //THERE ARE 3 WAYS TO DECLARE AN ARRAY
  
  //WAY 1: LIST ALL THE VALUES IN ADVANCE USING A { } LIST
  int[] andrewsMarks = {62, 98, 74, 99, 100, 6};
  String[] months = {"Jan", "Feb", "Mar"};
  
  
  //Printing the array
  
  //Printing its length
  int L = andrewsMarks.length;
  
  //Changing the values using a loop
  for(int i=0; i < andrewsMarks.length; i++) {
    andrewsMarks[i] += 5;
  }
  
  //Reprinting
  
  //YOUR TURN 1: USE A LOOP TO PRINT THE ARRAY IN REVERSE ORDER. HINT: MAKE i GO 4, 3, 2, 1, 0
  
  
  //YOUR TURN 2: FIND THE AVERAGE VALUE
   
  
  
  //WAY 2: DECLARE THE SIZE IN ADVANCE BUT NOT THE VALUES...
  int[] xPoints = new int[10];
  
  //...WITH THE INTENTION OF FILLING THE VALUES LATER IN THE PROGRAM
  for(int i = 0; i < xPoints.length; i++) {
    xPoints[i] = (int) random(0,50);
  }
  
  // printArray(xPoints);
  
    
  //WAY 3: DECLARE THE NAME BUT DON'T COMMIT TO THE SIZE YET
  float[] danielle;
  
  //Picking a random size;
  int n = (int) random(20);
  
  //Completing the array declaration
  danielle = new float[n];
  
  //Filling the values randomly
  for(int i = 0; i < danielle.length; i++) {
    danielle[i] = random(0,50);
  }
  
  printArray(danielle);
  
  exit();
}
