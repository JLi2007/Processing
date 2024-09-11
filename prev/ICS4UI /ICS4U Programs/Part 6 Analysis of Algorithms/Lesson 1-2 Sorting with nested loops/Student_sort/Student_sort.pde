void setup() {
  int[] A = {70, 200, 50, 40, 80, 120, 10, 60};
  
  int[] sortedA = studentSort( A );
  printArray( sortedA );
}


int[] studentSort(int[] A) {
  int[] B = new int[A.length]; //Will store the sorted array
  
  for(int startIndex = 0; startIndex < A.length; startIndex++) {  //For each pass, we'll find the smallest value between startIndex and the end of the array
    
    int minSoFar = A[startIndex];  //the value of the minimum found so far
    int iMin = startIndex;         //the index where that minimum value is
    
    for(int i = startIndex; i < A.length; i++) {  
      if( A[i] < minSoFar ) {
        minSoFar = A[i]; 
        iMin = i;
      }
    }
    
    B[ startIndex ] = minSoFar; //Putting the newly found min value into the new array at the next free spot.
    swap(A, startIndex, iMin); //Swapping the min value with the value at startIndex to get that min value "out of the way" so the next pass won't consider it 
  }
  
  return B;
}


void swap(int[] a, int x,int y) {
  int temp = a[x];
  a[x] = a[y];
  a[y] = temp;
}
    
    
  
