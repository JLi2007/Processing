int fill;
int increment = 25;
void setup() {
    size(400,400);
    DrawGrid();
}

void DrawGrid(){
    for(int i=1; i<10*increment; i+=increment){
        fill+=10;
        for(int j=1; j<6*increment; j+=increment){
            fill(fill);
            square(i,j,increment);
        }
    }
    println("finished");
}
