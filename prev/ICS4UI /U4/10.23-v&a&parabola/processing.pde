PVector pos, v, a;
int rad = 50;
float windStrengh = 0.06;

void setup(){
    size(800,600);
    background(0);
    pos = new PVector(0,height/1.5 - rad/2);
    v = new PVector(10,-12);
    a = new PVector(-0.15,0.3);

    stroke(255,0,0);
    line(0, height/1.5, width, height/1.5);
}

void draw(){
    fill(0,0,225);
    stroke(0,0,255);
    circle(pos.x, pos.y,rad);

    if(pos.y <= height/1.5 - rad/2){
        pos.add(v);
        v.add(a);
    }
}