
int[] bubbleSort( int[] a ) {
  int n = a.length;

  for ( int pass = 1; pass <= n-1; pass++ ) {
    numBubbleSortComparisons++;
    
    for ( int i = 0; i <= n-pass-1; i++ ) {

      if ( a[i] > a[i + 1] ) 
        swap( a, i, i+1 );

      numBubbleSortComparisons += 2;
    }
  }
  return a;
}
