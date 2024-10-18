class Motorbike {
    // FIELDS
    PVector position;
    PVector vel;
    PVector direction;
    int radius;
    float speed;
    color colour;
    int otherCarCount;

    // 0=Parked | 1=Moving | 2=Moving to parking spot
    int status;

    float timeToPark;
    int targetParkingSpot;
    float distanceToParkingSpot;
    boolean returningParker;
    
    // CONSTRUCTOR
    Motorbike(color colour, float x, float y, int r, float s, float pa) {
        this.position = new PVector(x,y);
        this.vel = new PVector(random(2.5,5), random(2.5,5));
        this.radius = r;
        this.speed = s;
        this.colour = colour;
        this.otherCarCount=0;
        this.timeToPark = pa;
        this.status = 1;
        this.returningParker=false;
    }
    
    // DRAWS BIKE
    void drawMotorbike() {
        fill(this.colour);
        stroke(this.colour);
        circle(this.position.x, this.position.y, this.radius);
    }
    
    // MOVES BIKE
    void animateMotorbike() {
        // increase speed as some gets lost over time
        if(this.returningParker){
            this.vel = new PVector(random(5,6), random(5,6));
            this.speed+=10;
            this.otherCarCount=0;
            this.returningParker=false;
        }
        // IF the motorbike is moving
        if (this.status == 1) {
            // If the timeToPark var is less than 5, the motorbike wants to park
            if (this.timeToPark < 5) {
                // motor parks don't care if the spot is already taken, parks wherever they want
                this.targetParkingSpot = int(random(1, 21));

                // sets status to "moving to parking spot"
                this.status = 2;

                // add the chosen parking spot to the arraylist
                takenParkingSpots.add(this.targetParkingSpot);
            } 

            // otherwise, decrease the variable
            else {
                this.timeToPark -= random(0.01, 0.03);
            }
            
            // reverse direction if there is a collision with parking lot
            if (parkingLotCollision()) {
                this.vel = this.vel.mult(-1);
            }

            // adds vel vector to position vector
            this.position.add(this.vel);

            // if the motorbike goes out of screen bounds, pick new direction
            if ((this.position.x > width - this.radius) || (this.position.x < this.radius) || (this.position.y < this.radius) || (this.position.y > height - this.radius)) {
                // Adjust position to be just inside the boundary
                this.position.x = constrain(this.position.x, this.radius, width - this.radius);
                this.position.y = constrain(this.position.y, this.radius, height - this.radius);
                this.pickNewDirection();
            }
        }

        // IF the motorbike is moving to a parking spot
        if (this.status == 2) {
            // finds target position (the position of the lot number) and calculates distance
            PVector targetPosition = numPositions.get(this.targetParkingSpot - 1);
            this.distanceToParkingSpot = PVector.dist(this.position, targetPosition);

            // substracts, normalizes, then multiplies with PVector
            PVector displacement = PVector.sub(targetPosition, this.position);
            this.direction = displacement.normalize();
            this.vel = PVector.mult(this.direction, this.speed);

            // difference in distance for odd/even parking spots (for visual enhancement)
            if(this.targetParkingSpot % 2 == 0){
                if (this.distanceToParkingSpot < 10) {
                    // sets status to "parked"
                    this.status = 0;
                    this.vel.set(0, 0);
                    // count the other bikes in the spot / planning to park at the spot
                    countOtherCarsInSpot();
                }
            } else{
                if (this.distanceToParkingSpot < 5) {
                    // sets status to "parked"
                    this.status = 0;
                    this.vel.set(0, 0);
                    // count the other bikes in the spot / planning to park at the spot
                    countOtherCarsInSpot();
                }
            }

            // adds vel vector to position vector 
            this.position.add(this.vel);
        }

        // IF the motorbike is parked
        if (this.status == 0) {
            // as soon as another vehicle is either on the parkingspot or planning to park there, motorbikes start complaining
            if(this.otherCarCount>1){
                parkingArgument();
                // reset so the argument stops when the other vehicle leaves
                this.otherCarCount=0;
                countOtherCarsInSpot();
            }
            // Increase the ambition and leave when it reaches 20
            this.timeToPark += random(0.04,0.07);
            if (this.timeToPark > 12) {
                // sets status back to "moving"
                this.status = 1;
                this.pickNewDirection();
                
                // Move the motorbike outside the parking lot
                do {
                    if(targetParkingSpot % 2 == 0){
                        this.position.x += 5;
                    } else{
                        this.position.x -= 5;
                    }
                } while (parkingLotCollision());

                // removes the chosen parking spot from the arraylist
                takenParkingSpots.remove(Integer.valueOf(this.targetParkingSpot));
                // reset 
                this.returningParker=true;
            }
        }
    }
    
    // picks a new direction
    void pickNewDirection() {
        // uses randangle to make a direction pvector and multiply the velocity
        float randAngle = random(0, TWO_PI);
        this.direction = new PVector(cos(randAngle), sin(randAngle)); 
        this.vel = PVector.mult(this.direction, this.speed);
    }
    
    // checks collisions with the parking lot
    boolean parkingLotCollision() {
        // uses the lotPositions PVector ArrayList for both lots
        if (this.position.y < lotPositions.get(3).y && this.position.y > lotPositions.get(0).y && this.position.x > lotPositions.get(0).x && this.position.x < lotPositions.get(3).x) {
            return true;
        }
        if (this.position.y < lotPositions.get(7).y && this.position.y > lotPositions.get(4).y && this.position.x > lotPositions.get(4).x && this.position.x < lotPositions.get(7).x) {
            return true;
        }
        return false;
    }

    // count the other bikes in the spot / planning to park at the spot
    void countOtherCarsInSpot(){
        // loops through takenParkingSpots arrayList
        for (Integer spot : takenParkingSpots) {
            if (spot.equals(this.targetParkingSpot)) {
                this.otherCarCount++;
            }
        }
    }

    // Motorbikes argue when their spot is being invaded
    void parkingArgument(){
        fill(random(190,225), random(0,20), random(0,10));
        String[] exclamations = {"^*@&*@#()!!!", "!!??&*@****", "#$%^&*!!", "@#$%^&*!!", "!Vidul!", "NONONO"};
        float yOffset = random(-this.radius, this.radius);
        float xOffset = random(-this.radius, this.radius);
        if(this.targetParkingSpot % 2 == 0){
            text(exclamations[int(random(exclamations.length))], 
                 this.position.x + xOffset,
                 this.position.y + yOffset);
        } else {
            text(exclamations[int(random(exclamations.length))], 
                 this.position.x + xOffset,
                 this.position.y + yOffset);
        }
    }
}