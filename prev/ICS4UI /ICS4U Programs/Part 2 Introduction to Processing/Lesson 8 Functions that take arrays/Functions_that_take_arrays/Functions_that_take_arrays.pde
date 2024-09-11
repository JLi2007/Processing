void setup() {
  //float avgPrice = getAverage(58.99, 16.99);
  //float avgCoolness = getAverage(10, 2);
  //float avgSleep = getAverage(1, 23);
  
  //println(avgPrice, avgCoolness, avgSleep);
  
  float[] sleepData = {6, 5, 1, 0, 15};
  float avgSleep2 = getArrayAverage( sleepData );
  //println("You got", avgSleep2, "hours of sleep each night on average");
  
  float[] hockeyScores = {4, 1, 0, 8, 2, 4, 9, 9};
  //println("The avg hockey score was", getArrayAverage(hockeyScores) );
  
  //I wish we could do this
  int[] randStuff = makeRandomEvenArray(12, 40);
  printArray(randStuff);
}

void draw() {
  
}


float getArrayAverage(float[] values ) {
  float total = 0;
  
  for(int i = 0; i < values.length; i++) {
    total += values[i];
  }
  
  return total/values.length;
}



int[] makeRandomEvenArray(int y, int m ) {
  //allocate space in RAM for an array that can store y decimal values
  int[] myArray = new int[y];  //booked the rooms in the hotel
  
  for(int i = 0; i < y; i++) {
    myArray[i] = 2 * int(random(0, m/2));  
  }
   
  return myArray;
}
