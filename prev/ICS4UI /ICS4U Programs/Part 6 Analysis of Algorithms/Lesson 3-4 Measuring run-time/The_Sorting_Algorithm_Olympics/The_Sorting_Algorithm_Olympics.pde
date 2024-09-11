long numBubbleSortComparisons, numInsertionSortComparisons, numSelectionSortComparisons, numMergeSortComparisons;
long startTime, elapsedTime;

int n = 10;  //ARRAY SIZE
boolean printArrays = true;


void setup() {
  int[] a, aCopy1, aCopy2, aCopy3;

  if (n < 50) 
    printArrays = true;
    
  else
    printArrays = false;

  //MAKES A RANDOM ARRAY OF LENGTH n
  a = new int[ n ];
  
  for ( int i = 0; i < a.length; i++ )  
    a[ i ] = int(random( n*5 ));      

  //MAKES 3 COPIES OF THE ORIGINAL ARRAY
  aCopy1 = a.clone();
  aCopy2 = a.clone();
  aCopy3 = a.clone();

  //PRINTS THE ORIGINAL ARRAY
  if (printArrays) {
    println("The original array");
    printArrayInline( a ); 
    println("");
  }

  //SORTS THE ARRAY USING 3 DIFFERENT ALGORITHMS AND RECORDS THE # OF COMPARISONS AND THE CPU TIME EACH ALGORITHM TOOK
  testMergeSort( a );
  testInsertionSort( aCopy1 );      
  testBubbleSort( aCopy2 );
  //testSelectionSort( aCopy3 );
  
  exit();
}


void swap( int[] a, int x, int y ) {
  int temp = a[x];
  a[x] = a[y];
  a[y] = temp;
}


void printArrayInline(int[] a) {
  for (int i = 0; i < n; i++) 
    print(a[i] + " ");

  println("");
}
