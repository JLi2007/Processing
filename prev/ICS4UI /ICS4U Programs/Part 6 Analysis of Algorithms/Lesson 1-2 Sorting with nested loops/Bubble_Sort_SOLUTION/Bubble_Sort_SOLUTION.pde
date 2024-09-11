int[] a = {5, 8, -3, 20, 25, 17, 6, 12, 1, 60, 4};

void setup() {
  println("Original array:");
  printArrayInline( a );
  
  println("Sorted array:");
  printArrayInline( bubbleSort( a ) );
}


int[] bubbleSort( int[] a ) {
  int n = a.length;

  for ( int pass = 1; pass <= n-1; pass++ ) {
    for ( int i = 0; i <= n-pass-1; i++ ) {

      if ( a[i] > a[i + 1] ) {
        int temp = a[i];
        a[i] = a[i+1];
        a[i+1] = temp;
      }
    }
  }
  return a;
}


void printArrayInline(int[] a) {
  for (int i = 0; i < a.length; i++) 
    print(a[i] + " ");

  println("\n");
}
