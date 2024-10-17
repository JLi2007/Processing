// James Li
// October 18, 2024
int numCars = 3;
parkingLot parkingLot;
ArrayList<Car> cars;

void setup(){
    size(1500, 800);
    println("Parking Lot Simulation");
    parkingLot = new parkingLot();
    cars = new ArrayList<Car>();

    for(int car=0; car<numCars; car++){
        cars.add(new Car(color(random(0, 255), random(0, 255), random(0, 255)), random(1,width), random(1,height)));
    }
}

void draw(){
    parkingLot.drawParkingLot();
    for (Car car : cars){
        car.drawCar();
    }
}