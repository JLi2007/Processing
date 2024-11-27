
int[] selectionSort( int[] a ) {
  int n = a.length;

  for (int i = 0; i < n; i++) {

    int indexOfMin = i;

    for ( int j = i+1; j < n; j++ ) {
      if ( a[ j ] < a[ indexOfMin ] ) 
        indexOfMin = j; 

      numSelectionSortComparisons++;
    }

    swap( a, i, indexOfMin );
  }
  
  return a;
}
