void setup(){
    int[] array = {5,4,2,19,4,6,7};
    int[] newArray = selectionSort(array);

    printArray(newArray);

    exit();
}

int[] selectionSort(int[] a){
    int[] b = new int[a.length];

    for(int index=0; index<a.length; index++){
        int minIndex = index;

        for(int p = minIndex+1; p<a.length; p++){
            if(a[p]<a[minIndex]){
                minIndex = p;
            }
        }   
        b[index] = a[minIndex];

        int temp = a[minIndex];
        a[minIndex] = a[index];
        a[index] = a[minIndex];
    }

    return b;
}