class Car{
    PVector position;
    float speed;
    color colour;
    float parkingSize;
    // 0=east | 1=west | 2=north | 3=south
    float direction;
    // 0=Parked | 1=Leaving Parking | 2=Driving
    int status;
    boolean rightOfWay;
    
    Car(color colour, float x, float y){
        this.position = new PVector(x,y);
        this.speed = random(1,2);
        this.colour = colour;
        this.parkingSize = 1;
        this.direction = 0;
        this.status = 2;
        this.rightOfWay = false;
    }

    void drawCar(){
        fill(this.colour);
        stroke(this.colour);
        // determining direction of the car
        // ABOVE parking lots
        if(this.position.y < lotPositions.get(0).y){
            // IN BETWEEN TWO VERTICAL LINES
            if(this.position.y < horizontalLines.get(0)[0].y && this.position.x > verticalLines.get(0)[0].x && this.position.x < verticalLines.get(2)[0].x){
                this.direction=1;
            }else if(this.position.y > horizontalLines.get(0)[0].y && this.position.x > verticalLines.get(0)[0].x && this.position.x < verticalLines.get(2)[0].x){
                this.direction=0;
            }
        }
        // BELOW parking lots
        if(this.position.y > lotPositions.get(2).y){
            // IN BETWEEN TWO VERTICAL LINES
            if(this.position.y > horizontalLines.get(1)[0].y && this.position.x > verticalLines.get(0)[0].x && this.position.x < verticalLines.get(2)[0].x){
                this.direction=0;
            }else if(this.position.y < horizontalLines.get(1)[0].y && this.position.x > verticalLines.get(0)[0].x && this.position.x < verticalLines.get(2)[0].x){
                this.direction=1;
            }
        }

        // LEFT of left parking lot
        if(this.position.x < lotPositions.get(0).x){
            // LEFT of left vertical line
            if(this.position.x < verticalLines.get(0)[0].x){
                this.direction=3;
            // RIGHT of left vertical line
            }else if(this.position.x > verticalLines.get(0)[0].x){
                this.direction=2;
            }
        }

        // RIGHT of right parking lot
        if(this.position.x > lotPositions.get(7).x){
            // RIGHT of right vertical line
            if(this.position.x > verticalLines.get(2)[0].x){
                this.direction=2;
            // LEFT of right vertical line
            }else if(this.position.x < verticalLines.get(2)[0].x){
                this.direction=3;
            }
        }
        // BETWEEN left and right parking Lot
        if(this.position.x > lotPositions.get(1).x && this.position.x < lotPositions.get(4).x){
            // RIGHT of center vertical line
            if(this.position.x > verticalLines.get(1)[0].x){
                this.direction=2;
            }
            // LEFT of center vertical line
            else if (this.position.x<verticalLines.get(1)[0].x){
                this.direction=3;
            }
        }

        // direction of car
        if(this.direction==2){
            rect(this.position.x, this.position.y, height/20, width/15,10,10,2,2);
        }else if(this.direction==3){
            rect(this.position.x, this.position.y, height/20, width/15,2,2,10,10);
        }else if(this.direction==1){
            rect(this.position.x, this.position.y, width/15, height/20,10,2,2,10);
        }else{
            rect(this.position.x, this.position.y, width/15, height/20,2,10,10,2);
        }
    }
}