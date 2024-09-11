
int[] mergeSort( int[] array, int start, int end ) {
  if (start == end) {  
    int[] arrayWithOneElement = { array[start] };
    numMergeSortComparisons++;
    return arrayWithOneElement;
  } 
  
  else {
    int middle = (end + start) / 2;
    numMergeSortComparisons++;

    int[] sortedLeftHalf = mergeSort(array, start, middle);         // recursive call
    int[] sortedRightHalf = mergeSort(array, middle + 1, end);      // recursive call

    return merge( sortedLeftHalf, sortedRightHalf );  // merge the two sorted halves
  }
}


int[] merge( int[] a, int[] b ) {
  int[] c = new int[a.length + b.length];
  int i = 0;
  int j = 0;
  int k = 0;

  int lenA = a.length, lenB = b.length;

  while ( i < lenA && j < lenB ) {

    if ( a[i] <= b[j] ) {
      c[k] = a[i];
      i++;
    } 
    else {
      c[k] = b[j];
      j++;
    }

    k++;
    numMergeSortComparisons += 3;
  }

  if ( i == lenA ) {
    for (int m = j; m < b.length; m++) {
      c[k] = b[m];
      k++;
    } 
    numMergeSortComparisons += 1 + b.length-j;
  }
    
  else {
    for (int m = i; m < a.length; m++) {
      c[k] = a[m];
      k++;
    }
    numMergeSortComparisons += a.length-i;
  }

  return c;
}
