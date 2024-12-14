// https://drive.google.com/file/d/1YBdZC_qTmP1Qi4W3717axm6MFQ7mSRhf/view

void setup() {        
    int[] a = {4,3,2,1,10,9,8,7,6,60,40,233,21,32}; //NOT already sorted
    int[] c = mergeSort(a,0,a.length-1);

    //  int[] a = {4, 7, 10, 13, 16}; //already sorted
    //  int[] b = {1, 2,  8, 11, 12}; //already sorted
    //  int[] c = merge( a, b );  //should merge the arrays a and b into a single sorted array c
    
    printArray(c);
    
    exit();
}

int[] mergeSort(int[] a, int start, int end) { 
    // the return breaks THAT instance of mergeSort function, still have other recursions running
    // other instances of mergeSort "above" this do NOT finish until they get to this step and numbers are returned. 
    if (start ==  end) {
        int[] arrayWithOneElement = { a[start] };
        return arrayWithOneElement;
    }

    else{
        int mid = (start + end) / 2;

        // these hold values for each recursions becuase they all have a different scope --> all have seperate memory space
        int[] sortedLeft = mergeSort(a,start,mid);
        int[] sortedRight = mergeSort(a,mid + 1,end);

        // by the time it reaches this point, no new mergeSort calls are made anymore.
        // all recursive mergeSort calls were already completed, and their results are stored in sortedLeft and sortedRight.
        return merge(sortedLeft,sortedRight);
    }
}

int[] merge(int[] a, int[] b) {
    int[] c = new int[a.length + b.length]; //what size should c be?
    
    int i = 0;   //i is the current index for a
    int j = 0;   //j is the current index for b 
    int k = 0;
    
    while(i<a.length && j<b.length) {
        if (a[i] < b[j]) { 
            c[k] = a[i];  
            i++;  
        } 
        
        else {
            c[k] = b[j]; 
            j++;  
        }
        
        k++;
    }
    
    if (i == a.length) 
        for (int x = j; x < b.length; x++) {
            c[k] = b[x];
            k++;
    } 
    
    else 
        for (int x = i; x < a.length; x++) { 
            c[k] = a[x];
            k++;
    }
    
    return c;
}


