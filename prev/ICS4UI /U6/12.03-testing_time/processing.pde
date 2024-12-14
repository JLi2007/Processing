// count time to merge sort and count most frequent item --> much faster than a dictionary...
void setup() {
  int[] list = {};
  
for (int i=0;i<200000;i++){
    list = append(list, int(random(0,10)));
  }
  
  long startTime = millis();

  int[] newList = mergeSort(list,0,list.length-1);
  
  println(findMostFrequentItem( newList ));

  long elapsedTime = millis() - startTime;
  println("Completed in", elapsedTime, "ms");  
  
  exit();
}

int findMostFrequentItem( int[] a ) {
  int maxIndex=0;
  int maxCount=0;
  int count=1;

  for(int index=1; index<a.length-1; index++){
    if(a[index]!=a[index-1]){
      if(count>maxCount){
        maxCount=count;
        maxIndex = a[index];
      }
      count=0;
    }else{
      count++;
    }
  }

  return maxCount;
}

int[] mergeSort(int[] a, int start, int end){
  if (start==end){
    int[] returnArray =  {a[start]};
    return returnArray;
  }
  else{
    int middle = (start+end)/2;
    int[] startArray = mergeSort(a,start,middle);
    int[] endArray = mergeSort(a,middle+1,end);
    return merge(startArray,endArray);
  }
}

int[] merge(int[] x, int[] y){
  int[] finalArray = new int[x.length+y.length];
  int a = 0;
  int b = 0;
  int c = 0;

  while(a<x.length && b<y.length){
    if(x[a]<y[b]){
      finalArray[c] = x[a];
      a++;
    }else{
      finalArray[c] = y[b];
      b++;
    }
    c++;
  }

  if(a == x.length){
    for(int d = b; d<y.length; d++){
      finalArray[c] = y[d];
      c++;
    }
  }
  
  else{
    for(int d = a; d<x.length; d++){
      finalArray[c] = x[d];
      c++;
    }
  }

  return finalArray;
}
