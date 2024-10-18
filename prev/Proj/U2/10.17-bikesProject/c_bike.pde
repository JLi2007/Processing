class Bike {
    // FIELDS
    PVector position;
    PVector vel;
    PVector direction;
    int radius;
    float speed;
    color colour;

    // 0=Parked | 1=Moving | 2=Moving to parking spot
    int status;

    float timeToPark;
    int targetParkingSpot;
    float distanceToParkingSpot;
    boolean returningParker;

    // CONSTRUCTOR
    Bike(color colour, float x, float y, int r, float s, float pa) {
        this.position = new PVector(x,y);
        this.vel = new PVector(random(1.5,3), random(1.5,3));
        this.radius = r;
        this.speed = s;
        this.colour = colour;
        this.timeToPark = pa;
        this.status = 1;
        this.returningParker=false;
    }
    
    // DRAWS BIKE
    void drawBike() {
        fill(this.colour);
        stroke(this.colour);
        circle(this.position.x, this.position.y, this.radius);
    }
    
    // MOVES BIKE
    void animateBike() {
        // increase speed as some gets lost over time
        if(this.returningParker){
            this.vel = new PVector(random(3,5), random(3,5));
            this.speed+=10;
            this.returningParker=false;
        }
        
        // IF the bike is moving
        if (this.status == 1) {
            // If the timeToPark var is less than 5, the bike wants to park
            if (this.timeToPark < 5) {
                // finds a targetParkingSpot that isn't already occupied, contradictory to motor bikes
                if (takenParkingSpots.size() < 21) {
                    do {
                        this.targetParkingSpot = int(random(1, 21));
                    } while (takenParkingSpots.contains(this.targetParkingSpot));

                    // sets status to "moving to parking spot"
                    this.status = 2;

                    // add the chosen parking spot to the arraylist
                    takenParkingSpots.add(this.targetParkingSpot);
                }else{
                    this.timeToPark+=random(1,5);
                }
            } 

            // otherwise, decrease the variable
            else {
                this.timeToPark -= random(0.01, 0.03);
            }
            
            // reverse direction if there is a collision with parking lot
            if (parkingLotCollision()) {
                // Reverse direction
                this.vel = this.vel.mult(-1);
            }

            // adds vel vector to position vector
            this.position.add(this.vel);

            // if the bike goes out of screen bounds, pick new direction
            if ((this.position.x > width - this.radius) || (this.position.x < this.radius) || (this.position.y < this.radius) || (this.position.y > height - this.radius)) {
                // Adjust position to be just inside the boundary
                this.position.x = constrain(this.position.x, this.radius, width - this.radius);
                this.position.y = constrain(this.position.y, this.radius, height - this.radius);
                this.pickNewDirection();
            }
        }

        // IF the bike is moving to a parking spot
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
                }
            } else{
                if (this.distanceToParkingSpot < 5) {
                    // sets status to "parked"
                    this.status = 0;
                    this.vel.set(0, 0);
                }
            }

            // adds vel vector to position vector 
            this.position.add(this.vel);
        }

        // IF the bike is parked
        if (this.status == 0) {            
            // Increase the ambition and leave when it reaches 20
            this.timeToPark += random(0.04,0.07);
            if (this.timeToPark > 10) {
                // sets status back to "moving"
                this.status = 1;
                this.pickNewDirection();

                // Move the bike outside the parking lot
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
}