void setup(){
  int[] array = new int[10];
  for(int index=0; index<array.length; index++){
    array[index] = int(random(0,100));
  }

  printArrayOnOneLine(array);
  int[] sortedArray = bubbleSort(array);
  printArrayOnOneLine(sortedArray);

  exit();
}

void printArrayOnOneLine(int[] array){
  for(int index=0; index<array.length; index++){
    print(array[index] + " ");
  }
  println("");
}

int[] bubbleSort(int[] array){
  // if 5 numbers total in array
  // pass 1 = sort index 0-1,1-2,2-3,3-4
  // 5-1-1 = 3 (0-3)
  // pass 2 = sort index 0-1, 1-2, 2-3
  for(int pass=1; pass<array.length-1; pass++){
    for(int index=0; index<array.length-1-pass; index++){
      if(array[index]>array[index+1]){
        int placeholder = array[index];
        array[index] = array[index+1];
        array[index+1] = placeholder;
      }
    }
  }
  return array;
}