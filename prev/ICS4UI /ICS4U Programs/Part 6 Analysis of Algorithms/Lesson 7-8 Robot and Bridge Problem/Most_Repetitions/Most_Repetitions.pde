void setup() {
  int[] roundWinners = {5, 8, 5, 3, 5, 5, 5, 2, 1, 1, 10, 7, 5, 4, 1, 8, 1, 1, 3, 5};
  
  findMostFrequentItem( roundWinners );
  
  exit();
}


void findMostFrequentItem( int[] A ) {
  //SORT THE LIST FIRST SO THAT THE LIST LOOKS LIKE {1, 1, 1, 1, 1, 3, 3, 5, 5, 5, 5, 5, 5, 5, 7, 8, 8, 10}
  int[] B = insertionSort( A );
  
  //KEEP TRACK OF THE MOST FREQUENT NUMBER FOUND SO FAR
  int champSoFar = B[0];
  int maxCountSoFar = 0;
  int currCount = 1; //COUNTS HOW MANY REPTITIONS HAVE BEEN FOUND FOR THE CURRENT VALUE BEING LOOKED AT
  
  //GO THROUGH THE SORTED LIST AND COUNT REPETITIONS OF EACH NEW VALUE ENCOUNTERED
  for(int i = 1; i < B.length; i++ ){
    
    if( B[i] == B[i-1] )  //IF THE CURRENT VALUE IS THE SAME AS THE PREVIOUS, RAISE THE CURRENT COUNT
      currCount++;
      
    else //IF IT'S DIFFERENT, RESET THE COUNT BACK TO 1
      currCount = 1;
      
    //IF THE CURRENT COUNT BEATS THE CURRENT CHAMPION, UPDATE THE CURRENT CHAMPION AND THE MAX SCORE
    if( currCount > maxCountSoFar ) {
        maxCountSoFar = currCount;
        champSoFar = B[i];
     }
  }
  
  println("Champion:", champSoFar, "Best score:", maxCountSoFar); 
}
