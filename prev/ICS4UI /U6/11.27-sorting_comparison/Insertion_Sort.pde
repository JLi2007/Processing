
int[] insertionSort( int[] a ) {
  for ( int h = 1; h < a.length; h++ ) {
    int c = h; 
    numInsertionSortComparisons++;

    while ( c > 0 && a[c-1] > a[c] ) {
      swap( a, c, c-1 );
      c--;

      numInsertionSortComparisons += 2;
    }
  }
  
  return a;
}
