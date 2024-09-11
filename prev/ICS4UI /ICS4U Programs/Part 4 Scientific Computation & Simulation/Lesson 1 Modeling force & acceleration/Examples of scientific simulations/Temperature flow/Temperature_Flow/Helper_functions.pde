void plantFirstGen() {
  
  if( method.equals("random") )
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) { 
        temps[i][j] = random(minTemp, maxTemp);      
      }
    }
    
   else if( method.equals("ring") )
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) { 
        if( i < ringThickness || j < ringThickness || i >= n-ringThickness || j >= n-ringThickness )
          temps[i][j] = maxTemp; 
        else  
          temps[i][j] = minTemp;
      }
    }
}


color getColor(float temp) {
  float percentage;
  if( temp < avgTemp ) {
    percentage = map(temp, minTemp, avgTemp, 0, 1);
    return lerpColor(cold, neutral, percentage);
  }
  
  else {
    percentage = map(temp, avgTemp, maxTemp, 0, 1);
    return lerpColor(neutral, hot, percentage);
  }
}


float getTotalEnergy() {
  float total=0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) { 
      total += temps[i][j];
    }
  }
  
  return total;
  
}
