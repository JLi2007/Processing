
class Person{
    PVector pos;
    PVector vel;
    color colour;
    int status;
    int diameter;
    int iq;
    float iqGain;

    Person(float posX, float posY, float velX, float velY, color c, int s, int d, float iq){
        this.pos = new PVector(posX,posY);
        this.vel = new PVector(velX, velY);
        this.colour = c;
        // 0 = sick | 1 = normal | 2 = doctor
        this.status = s;
        this.diameter = d;
        this.iq = 50;
        this.iqGain=iq;
    }

    // draws the resident
    void drawMe(){
        fill(this.colour);
        circle(this.pos.x, this.pos.y, this.diameter);
    }
    
    void updatePos(){
        this.pos.add(this.vel);
        
        // constain the position so it doesn't go "out of bounds"
        this.pos.x = constrain(this.pos.x,0,width);
        this.pos.y = constrain(this.pos.y,0,height);

        // change the direction of the velocity if the position is close to bounds
        if(this.pos.x<this.diameter/2 || this.pos.x>width-this.diameter/2){
            this.vel.x*=-1;
        }
        if(this.pos.y<this.diameter/2 || this.pos.y>height-this.diameter/2){
            this.vel.y*=-1;
        }

        // check for collision
        this.checkCollision();

        // check for cure
        this.findCure();
        
        // adds a random value from -1 to the iqGain (adjustable)
        this.iq += random(-1,this.iqGain);
    }

    void checkCollision(){
        // for each other resident
        for(Person resident: residents){
            // find the distance between this and them
            PVector S = new PVector(this.pos.x - resident.pos.x, this.pos.y - resident.pos.y);
            
            // continue if the resident is itself
            if(S.mag()==0){
                continue;
            }

            // if the magnitude/distance is smaller than the diameter. apply correct collision logic
            if( S.mag() <= this.diameter){
                PVector sHat = S.normalize(null);

                // to avoid the problem of people getting stuck together
                this.pos = PVector.add(resident.pos, PVector.mult(sHat, this.diameter));
                
                // calculate the collision using Vector physics learned in class
                float k = this.vel.dot(sHat) - resident.vel.dot(sHat);
                PVector deltaThis = PVector.mult(sHat,k);
                PVector deltaResident = PVector.mult(sHat,k);
                this.vel.sub(deltaThis);
                resident.vel.add(deltaResident);
                
                // if this is a doctor, heal the sick person
                if(this.status == 2 && resident.status == 0){
                     resident.status = 1;
                     resident.colour = colours[1];
                }

                // if this is sick, doctor heals
                if(this.status == 0 && resident.status == 2){
                     this.status = 1;
                     this.colour = colours[1];
                }
                
                // sickness only spreads if there is no cure
                if(cure == false){
                    // if this is normal, the sick person spreads the disease
                    if(this.status == 1 && resident.status == 0){
                        this.status = 0;
                        this.colour = colours[0];
                    }

                    // if this is sick, it spreads the disease PLACEHOLDER
                    if(this.status == 0 && resident.status == 1){
                        resident.status = 0;
                        resident.colour = colours[0];
                    }
                }
            }
        }
    }

    // if a doctor has an iq of >120 then a cure is found
    void findCure(){
        if(this.status == 2 && this.iq > 120){
            cure = true;
        }
    }
}