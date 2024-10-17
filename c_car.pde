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

    // required to obtain lotPositions
    ArrayList<PVector> lotPositions;
    
    Car(color colour, float x, float y){
        this.position = new PVector(x,y);
        this.speed = random(1,2);
        this.colour = colour;
        this.parkingSize = 1;
        this.direction = 0;
        this.status = 2;
        this.rightOfWay = false;
        this.lotPositions = parkingSpaces.getLotPositions();
    }

    void drawCar(){
        fill(this.colour);
        stroke(this.colour);
        // println(this.position.x);
        // println(lotPositions.get(0)[0].x);
        // determining direction of the car
        // if above parking lots
        // if(this.position.x.sub(lotPositions[0].x)<0){
        //     println("he");
        // //     if(this.position.x < parkingLot.horizontalLines[0].x){
        // //         this.direction=1;
        // //     }else{
        // //         this.direction=0;
        // //     }
        // // }
        // // if(this.position.x > lotPositions[3].x){
        // //     if(this.position.x > parkingLot.horizontalLines[1].x){
        // //         this.direction=0;
        // //     }else{
        // //         this.direction=1;
        // //     }
        // }

        // PLACEHOLDER
        if(this.direction==0){
            rect(this.position.x, this.position.y, width/15, height/20);
        }else{
            rect(this.position.x, this.position.y, height/20, width/15);
        }
    }
}