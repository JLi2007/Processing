void setup(){
  int[] array = new int[10];
  for(int index=0; index<array.length; index++){
    array[index] = int(random(0,50));
  }

  // printArrayOnOneLine(array);
  int[] sortedArray = selectionSort(array);
  printArrayOnOneLine(sortedArray);

  exit();
}

void printArrayOnOneLine(int[] array){
  for(int index=0; index<array.length; index++){
    print(array[index] + " ");
  }
  println("");
}

int[] selectionSort(int[] array){
  for(int step=0; step<array.length-1; step++){
    int min_index = step;
    printArrayOnOneLine(array);
    // iterate through every number ahead of this one in the list
    for(int index = step+1; index<array.length; index++){
      if(array[index] < array[min_index]){
        min_index = index;
      }
    }

    // if the min index is itself then this would do nothing
    int placeholder = array[step];
    array[step] = array[min_index];
    array[min_index] = placeholder;
  }
  return array;
}