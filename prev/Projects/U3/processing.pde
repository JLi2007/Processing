void setup() {
  size(1000, 1000);
	background(0);
	noLoop();
}

void draw(){
  for(int x = 0; x<width; x++){
    float a = get_a(x);
    for(int y = 0; y<height; y++){
      float b = get_b(y);
      ComplexNum c = new ComplexNum(a,b);
      ComplexNum z = c;
      int row = 1;

      while(z.absoluteValue()<2 && row<200){
        z = z.multiply(z).add(c);
        row++;
      }

      if(row==200){
        stroke(225);
        point(x,y);
      }else{
        stroke(0);
        point(x,y);
      }
    }
  }
}

float get_a(float x) { 
    return(3*x/1000 - 2);
}

float get_b(float y) { 
    return(-3*y/1000 + 1.5);
}