void setup() {
  size(600,600);
  background(0);
  
  //THERE ARE 3 WAYS TO DECLARE AN ARRAY
  
  //WAY 1: LIST ALL THE VALUES IN ADVANCE USING A { } LIST
  int[] myMarks = {62, 98, 74, 99, 100, 6};
  String[] months = {"Jan", "Feb", "Mar"};
  
  //Printing the array
  println(myMarks);
  
  //Printing its length
  int L = myMarks.length;
  println(L);
  
  //Changing the values using a loop
  for(int i=0; i < myMarks.length; i++) {
    myMarks[i] += 5;
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
  int[] xPoints = new int[10];
  
  //...WITH THE INTENTION OF FILLING THE VALUES LATER IN THE PROGRAM
  for(int i = 0; i < xPoints.length; i++) {
    xPoints[i] = (int) random(0,50);
  }

  
  
  //WAY 3: DECLARE THE NAME BUT DON'T COMMIT TO THE SIZE YET
  float[] danielle;
  
  //Picking a random size;
  int n = (int) random(20);
  
  //Completing the array declaration
  danielle = new float[n];
  
  //Write a for loop that fills bob with n random numbers between -1 and 1.
  for(int i = 0; i < n; i++) {
    danielle[i] = random(-1,1);
  }
  
  println();
  println(danielle);
 
  exit();
}
