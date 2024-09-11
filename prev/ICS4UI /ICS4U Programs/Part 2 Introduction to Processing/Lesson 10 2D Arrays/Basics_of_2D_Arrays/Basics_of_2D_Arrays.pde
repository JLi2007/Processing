void setup() {
  int[][] myScores = new int[6][3];  //This allocates space in RAM for a
                                      //6 x 3 table of integers
 
  for(int i=0; i < 6; i++) {
    for(int j=0; j < 3; j++) {
      myScores[i][j] = round(random(0,100));
    }  
  }
  
  //Your challenge: Write a nested for-loop that will print the table in 6 rows
  //and 3 columns, like we did for red fish/blue fish 
  
  for(int i=0; i < 6; i++) {
    for(int j=0; j < 3; j++) {
      print( myScores[i][j] + "\t");  
    }  
    println(); //Makes a line-break after each row
  }
  
}
