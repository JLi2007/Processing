int n = 25; // Number of people
ArrayList<Pedestrian> pedestrians;
Weather weather;
Car car1;
Car car2;
Bus b;
BusStop busStop;

void setup() {
  size(800, 800);
  
  // Creating class objects 
  weather = new Weather(int(random(0, 3)));
  car1 = new Car(color(random(0, 255), random(0, 255), random(0, 255)), random(-250, -50), random(435, 465), random(5, 10), 1);
  car2 = new Car(color(random(0, 255), random(0, 255), random(0, 255)), random(-250, -50), random(305, 315), random(5, 10), -1);
  b = new Bus(5, color(50, 150, 50), 200, int(random(225, 250)), 5);
  busStop = new BusStop(0, 650);
  pedestrians = new ArrayList<Pedestrian>();
  
  // Creating pedestrians 
  for (int i=0; i<n; i++) {
    pedestrians.add(new Pedestrian(1.83, 0.35, color(random(200, 236), random(140, 190), random(160, 172)), false, random(100, 700), random(500, 750), random(1, 1.5)));
  }
}

void draw() {
  background(35,137,218);
  noStroke();
  
  // Road
  fill(150, 150, 150);
  rect(0, 200, width, 300);
  
  //Road Lines
  fill(219, 202, 44);
  rect(0, 350, width, 10); 
  rect(0, 335, width, 10);
  fill(255);
  rect(0, 480, width, 10);
  rect(0, 245, width, 8);
  
  // Pavement
  fill(112, 95, 80);
  rect(0, 500, width, 300); 
  
  // Sidewalk
  fill(175);
  rect(0, 550, width, 50); 
  rect(0, 200, width, 40);
  
  // Rails
  noFill();
  stroke(100);
  strokeWeight(8);
  for (int i=0; i<width; i+=50) { 
    rect(i, 150, 50, 50);
  }
  
  // Animate and display cars/buses
  car1.drawCar();
  car1.animateCar();
  car2.drawCar();
  car2.animateCar();
  
  b.drawBus();
  b.animateBus();
  
  // Animate pedestrians
  for (int i=0; i<n; i++) {
    if (!pedestrians.get(i).onBus) {
      pedestrians.get(i).drawPedestrian();
      pedestrians.get(i).animatePedestrian();
    }
    else {
      pedestrians.get(i).getOffBus();
    }
  }
  
  // Draw bus stop
  busStop.displayBusStop();
  // Draw weather patterns and bus stop
  weather.animateWeather();
}
