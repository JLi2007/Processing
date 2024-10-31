float aMin, aMax, bMin, bMax;

float w = -0.5;
float h = -0.6;

// small value = more zoom
float f = 0.05;

void setup() {
  size(1000, 1000);
	background(0);
	noLoop();
}

void draw(){
  aMin= w;
  aMax = aMin + f + radians(sin(f*f));
  bMin = h;
  bMax = bMin + f + radians(cos(f*f));

// default mandelbrot set
  // aMin= -2;
  // aMax = 1;
  // bMin = -1.5;
  // bMax = 1.5;

  float aSlope = (aMax-aMin)/width;
  float bSlope = (bMin-bMax)/height;

  for(int x = 0; x<width; x++){
    float a = get_a(x, aMin, aSlope);

    for(int y = 0; y<height; y++){
      float b = get_b(y, bMax, bSlope);
      ComplexNum c = new ComplexNum(a,b);
      ComplexNum z = c;
      int row = 1;

      while(z.absoluteValue()<2 && row<200){
        z = z.multiply(z).add(c);
        row++;
      }

      if(row==200){
        float absRatio = x * z.absoluteValue()/c.absoluteValue();
        stroke( absRatio, absRatio/3, absRatio/10 );
      }else{
        float shade = 10*(float(row)/200)*255;
        stroke( shade, shade/3, shade/10 );
      }
      point(x,y);
    }
  }
}

float get_a(float x, float aMin, float aSlope) { 
    return(aSlope*x + aMin);
}

float get_b(float y, float bMax, float bSlope) { 
    return(bSlope*y + bMax);
}