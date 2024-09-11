int[] insertionSort(int[] A) {
  for(int k=1; k < A.length; k++) {
    int c = k;
    while(c > 0 && A[c-1] > A[c]) {
      swap(A, c-1, c);
      c--;
    }
  }
  return A;
}


void swap( int[] a, int x, int y ) {
  int temp = a[x];
  a[x] = a[y];
  a[y] = temp;
}
