class Plant{
    PVector position;
    float diameter=random(100,150);

    Plant(float x, float y){
        this.position = new PVector(x,y);
    }
    
    void drawMe(){
        fill(14, 158, 62);
        circle(this.position.x, this.position.y,diameter/2);
    }

    void removeMe(){
        // I don't know how to actually remove an instance yet (Instead, im moving them into outer space). I wonder how you do that, will probably find out soon
        this.position = new PVector(-600,-600);
    }

    PVector returnPos(){
        PVector pos = new PVector(this.position.x, this.position.y);
        return pos;
    }
}
