void setup() {
  //TESTING JUST THE MERGE STEP

  //int[] a = {4, 7, 10, 13, 16}; //already sorted left half
  //int[] b = {1, 2, 8, 11, 12};  //already sorted right half

  //int[] c = merge( a, b );

  //printArray( c ); //should print out 1, 2, 4, 4, 8, 10, 11, 12, 13, 16


  //TESTING MERGE SORT
  int[] d = {8, 13, 20, 5, 1, 9, 5, 7, 2, 4, 6, 12, 12, 15, 10, 25, 11}; //unsorted
  //printArray( a );

  int[] dSorted = mergeSort( d, 0, d.length-1 ); //sorts array a from index 0 to the end    
  //printArray( dSorted ); 
}


int[] mergeSort(int[] a, int start, int end ) {
  if ( start == end ) {  
    int[] arrayWithOneElement = { a[start] };
    return arrayWithOneElement;
  } 
  
  else {
    int middle = (end + start) / 2;  //finds the middle index between start and end

    int[] sortedLeftHalf  = mergeSort( a, start, middle );     // recursive function-call
    int[] sortedRightHalf = mergeSort( a, middle + 1, end );   // recursive function-call

    return merge( sortedLeftHalf, sortedRightHalf );  // merges the two sorted halves by calling the merge-step below
  }
}


//MERGES TWO SORTED LISTS INTO A SINGLE SORTED LIST
int[] merge( int[] a, int[] b ) {
  int[] c = new int[a.length + b.length];
  int i = 0;
  int j = 0;
  int k = 0;

  while ( i < a.length && j < b.length ) {  //FOR AS LONG AS BOTH a AND b STILL HAVE ITEMS LEFT...

    if ( a[i] < b[j] ) {   //if the current "top card" of a is less than the current "top card" of b...
      c[k] = a[i];  //...then add a[i] to the end of c
      i++;          //...and then move a's pointer to the next item in array a
    } 
    
    else {
      c[k] = b[j];  //...otherwise add b[i] to the end of c
      j++;          //...and then move b's pointer to the next item in array b
    }

    k++;  //increment c's index pointer, no matter what
  }

  //AS SOON AS a OR b IS EMPTY, TACK ON THE REMAINDER OF THE NON-EMPTY ARRAY ONTO c
  if ( i == a.length ) //if a was the array that emptied first...
    for ( int m = j; m < b.length; m++ ) {  //...then add all remaining items from b to c
      c[k] = b[m];
      k++;
    } 
    
  else 
    for (int m = i; m < a.length; m++) {  //...otherwise add all remaining items from a to c 
      c[k] = a[m];
      k++;
    }

  return c;  //Returns the final sorted array, c
}
