// James Li
// October 18, 2024
// Parking Lot Simulation

int numCars = 10;
float carX, carX2, carX3;
int xReturn=0;
parkingLot parkingLot;
parkingSpaces parkingSpaces;
ArrayList<Car> cars;
ArrayList<PVector> lotPositions = new ArrayList<PVector>();
// arrayList PVectors for roadlines
ArrayList<PVector[]> horizontalLines = new ArrayList<PVector[]>();
ArrayList<PVector[]> verticalLines = new ArrayList<PVector[]>();

void setup(){
    size(1500, 800);
    println("Parking Lot Simulation");
    parkingLot = new parkingLot();
    parkingSpaces = new parkingSpaces(5);
    cars = new ArrayList<Car>();

    parkingLot.drawParkingLot();
    parkingSpaces.drawParkingGrid();

    for(int car=0; car<numCars; car++){
        cars.add(new Car(color(random(0, 255), random(0, 255), random(0, 255)), randomX(), random(height)));
    }
}

void draw(){
    // parkingLot.drawParkingLot();
    // parkingSpaces.drawParkingGrid();
    for (Car car : cars){
        car.drawCar();
    }
}

float randomX(){
    carX = random(lotPositions.get(0).x-width/20);
    carX2 = random(lotPositions.get(1).x+width/20, lotPositions.get(4).x-width/20);
    carX3 = random(lotPositions.get(5).x+width/20, width);

    if (xReturn<3){xReturn+=1;} 
    else{
        xReturn=1;
    }
    
    if(xReturn==1){
        return carX;
    }
    else if(xReturn==2){
        return carX2;
    }
    else{
        return carX3;
    }
}