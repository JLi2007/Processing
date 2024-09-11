color cold = color(0,0,255);
color neutral = color(255);
color hot = color(255,0,0);

float minTemp = -40;
float maxTemp = 100;
float avgTemp  = (minTemp+maxTemp)/2;
float temp = minTemp;

void setup() {
  size(300,300);
}

void draw() {
  color c = getColor(temp);
  fill(c);
  square(100,100, 100);
  temp += 0.15;
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
