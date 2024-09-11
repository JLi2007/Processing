
void testBubbleSort(int[] aCopy) {
  print( "Bubble sort made..." );
  startTime = millis();

  int[] aSorted = bubbleSort( aCopy );
  elapsedTime = millis() - startTime; //the time bubble sort took

  if( printArrays) 
    printArrayInline( aSorted ); 
    
  println( numBubbleSortComparisons + " comparisons and took " + elapsedTime + " milliseconds" + "\n");
}


void testInsertionSort( int[] aCopy ) {
  print( "Insertion sort made..." );
  startTime = millis();

  int[] aSorted = insertionSort( aCopy );
  elapsedTime = millis() - startTime; //the time insertion sort took

  if( printArrays) 
    printArrayInline( aSorted ); 
    
  println( numInsertionSortComparisons + " comparisons and took " + elapsedTime + " milliseconds" + "\n");
}


void testMergeSort(int[] aCopy) {
  print( "Merge sort made..." );
  startTime = millis();

  int[] aSorted = mergeSort( aCopy, 0, n-1 );
  elapsedTime = millis() - startTime; //the time bubblesort took

  if( printArrays) 
    printArrayInline( aSorted ); 
    
  println( numMergeSortComparisons + " comparisons and took " + elapsedTime + " milliseconds" + "\n");
}


void testSelectionSort(int[] aCopy) {
  startTime = millis();

  int[] aSorted = selectionSort( aCopy );
  elapsedTime = millis() - startTime; //the time bubblesort took

  if( printArrays) 
    printArrayInline( aSorted ); 
    
  println( "Selection sort made " + numSelectionSortComparisons + " comparisons and took " + elapsedTime + " milliseconds" + "\n");
}
