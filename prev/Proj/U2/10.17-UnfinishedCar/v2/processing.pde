// James Li
// October 18, 2024
// Parking Lot Simulation

int numCars = 1;
float carX, carX2, carX3;
float newX, newY;
int xReturn=0;
parkingLot parkingLot;
parkingSpaces parkingSpaces;
ArrayList<Car> cars;
ArrayList<PVector> existingCars = new ArrayList<PVector>();
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
        addCarWithoutOverlap();
    }
}

void addCarWithoutOverlap() {
    boolean validPosition = false;
    
    while (!validPosition) {
        newX = randomX();
        newY = random(height);
        validPosition = true;
        
        for (PVector existingCar : existingCars) {
            if (carsOverlap(newX, newY, existingCar.x, existingCar.y)) {
                validPosition = false;
                break;
            }
        }
    }
    existingCars.add(new PVector(newX, newY));
    cars.add(new Car(color(random(0, 255), random(0, 255), random(0, 255)), newX, newY));
}

boolean carsOverlap(float x1, float y1, float x2, float y2) {
    float minDistance = width/15;
    return dist(x1, y1, x2, y2) < minDistance;
}

void draw(){
    background(11, 173, 9);
    parkingLot.drawParkingLot(); 
    parkingSpaces.drawParkingGrid();  
    
    for (Car car : cars){
        if (car.status == 2){
            boolean collision = false;
            for (Car otherCar : cars){
                if (car != otherCar && car.isCollision(otherCar)){
                    collision = true;
                    break;
                }
            }
            if (!collision) {
                car.animateCar();
            }
        car.drawCar(); 
        }
    }
}

float randomX(){
    carX = random(lotPositions.get(0).x-width/15);
    carX2 = random(lotPositions.get(1).x+width/15, lotPositions.get(4).x-width/15);
    carX3 = random(lotPositions.get(5).x+width/15, width);

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