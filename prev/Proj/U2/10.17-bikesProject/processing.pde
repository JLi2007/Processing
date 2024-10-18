// James Li
// October 17, 2024
// Parking Lot Simulation

// VARIABLES
// *the program can crash if there are too many bikes on the road.
int numBikes = 20;
int numMotorbikes = 10;
float bikeX, bikeX2, bikeX3;
int xReturn = 0;
ParkingLot ParkingLot;
ParkingSpace ParkingSpace;

ArrayList<Bike> bikes;
ArrayList<Motorbike> motorBikes;

// positions of lot numbers
ArrayList<PVector> numPositions = new ArrayList<PVector>();
// positions of the lot boundaries
ArrayList<PVector> lotPositions = new ArrayList<PVector>();
// arrayList PVectors for roadlines
ArrayList<PVector[]> horizontalLines = new ArrayList<PVector[]>();
ArrayList<PVector[]> verticalLines = new ArrayList<PVector[]>();
ArrayList<Integer> takenParkingSpots = new ArrayList<Integer>();

void setup() {
    size(1500, 800);
    println("Parking Lot Simulation");
    // initializa ParkingLot and ParkingSpace
    ParkingLot = new ParkingLot();
    ParkingSpace = new ParkingSpace(5);

    // initialize bikes and motorBikes
    bikes = new ArrayList<Bike>();
    motorBikes = new ArrayList<Motorbike>();
    
    // draw parking lot and parking spaces
    ParkingLot.drawParkingLot();
    ParkingSpace.drawParkingGrid();
    
    // populate bikes and motorbikes
    for (int bike = 0; bike < numBikes; bike++) {
        bikes.add(new Bike(color(random(0, 255), random(0, 255), random(0, 255)), randomX(), random(height), 50, 5, random(10)));
    }
    
    for (int motorbike = 0; motorbike < numMotorbikes; motorbike++) {
        motorBikes.add(new Motorbike(color(random(0,225)), randomX(), random(height), 50, 10, random(12)));
    }
}

void draw() {
    background(11, 173, 9);
    ParkingLot.drawParkingLot(); 
    ParkingSpace.drawParkingGrid();  
    
    // draw bikes and motorbikes
    for (Bike bike : bikes) {
        bike.drawBike(); 
        bike.animateBike();
    }
    for (Motorbike motorbike : motorBikes) {
        motorbike.drawMotorbike(); 
        motorbike.animateMotorbike();
    }
}

// return random x coordinate that are not on top of the parking grids
float randomX() {
    bikeX = random(width / 15, lotPositions.get(0).x - width / 15);
    bikeX2 = random(lotPositions.get(1).x + width / 15, lotPositions.get(4).x - width / 15);
    bikeX3 = random(lotPositions.get(5).x + width / 15, width);
    
    if (xReturn < 3) {xReturn += 1;} 
    else{
        xReturn = 1;
    }
    
    if (xReturn ==  1) {
        return bikeX;
    }
    else if (xReturn ==  2) {
        return bikeX2;
    }
    else{
        return bikeX3;
    }
}