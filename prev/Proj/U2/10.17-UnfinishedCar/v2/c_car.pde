class Car{
    PVector position;
    PVector vel;
    float carWidth;
    float carHeight;
    color colour;
    float parkingSize;
    // 0=east | 1=west | 2=north | 3=south
    float direction;
    // 0=Parked | 1=Leaving Parking | 2=Driving
    int status;
    boolean rightOfWay;
    boolean wantToPark;
    
    Car(color colour, float x, float y){
        this.position = new PVector(x,y);
        this.vel = new PVector(0,0);
        this.carWidth = width/15;
        this.carHeight = height/20;
        this.colour = colour;
        this.parkingSize = 1;
        this.direction = 0;
        this.status = 2;
        this.rightOfWay = false;
        this.wantToPark = false;
    }

    void drawCar(){
        fill(this.colour);
        stroke(this.colour);

        // determining direction of the car
        // RIGHT INNER LANES
        if ((this.position.x < verticalLines.get(1)[0].x && this.position.x > lotPositions.get(1).x) || (this.position.x < verticalLines.get(2)[0].x && this.position.x > lotPositions.get(4).x)) {
            this.direction = 3;
        }
        // LEFT INNER LANES
        else if ((this.position.x > verticalLines.get(0)[0].x && this.position.x < lotPositions.get(0).x) || (this.position.x > verticalLines.get(1)[0].x && this.position.x < lotPositions.get(4).x)) {
            this.direction = 3;
        }
        // TOP INNER LANES
        else if (this.position.y > lotPositions.get(0).y && this.position.y < horizontalLines.get(0)[0].y) {
            this.direction = 0;
        }
        // BOTTOM INNER LANES
        else if (this.position.y < lotPositions.get(2).y && this.position.y > horizontalLines.get(1)[0].y) {
            this.direction = 0;
        }

        // LEFT OUTER LANE
        if (this.position.x < verticalLines.get(0)[0].x && this.position.y >= horizontalLines.get(0)[0].y && this.position.y <= horizontalLines.get(1)[0].y) {
            this.direction = 3;
        }
        // RIGHT OUTER LANE
        else if (this.position.x > verticalLines.get(2)[0].x && this.position.y >= horizontalLines.get(0)[0].y && this.position.y <= horizontalLines.get(1)[0].y) {
            this.direction = 2;
        }
        // TOP OUTER LANE
        else if (this.position.y < horizontalLines.get(0)[0].y) {
            this.direction = 1;
        }
        // BOTTOM OUTER LANE
        else if (this.position.y > horizontalLines.get(1)[0].y) {
            this.direction = 0;
        }

        // drawing the car based on its direction
        if(this.direction==2){
            rect(this.position.x, this.position.y, this.carHeight, this.carWidth,10,10,2,2);
        }else if(this.direction==3){
            rect(this.position.x, this.position.y, this.carHeight, this.carWidth,2,2,10,10);
        }else if(this.direction==1){
            rect(this.position.x, this.position.y, this.carWidth, this.carHeight,10,2,2,10);
        }else{
            rect(this.position.x, this.position.y, this.carWidth, this.carHeight,2,10,10,2);
        }
    }

    void animateCar(){
        if(this.direction == 0){
            this.vel.x = -3;
            this.vel.y=0;
        } else if(this.direction == 1){
            this.vel.x = 3;
            this.vel.y=0;
        } else if(this.direction == 2){
            this.vel.y = 3;
            this.vel.x = 0;
        } else if(this.direction == 3){
            this.vel.y = -3;
            this.vel.x = 0;
        }
        this.position.add(this.vel);
    }

    boolean isCollision(Car otherCar){
        if((this.position.dist(otherCar.position) < width/15) && otherCar.status == 2){
            return true;
        }
        return false;
    }
}