float aMin, aMax, bMin, bMax;

// // more negative = moves right
// float w = -2;
// // more negative = moves up
// float h = -0.5;
// // small value = more zoom
// float f = 0.7;

// more negative = moves right
float w = -2;
// more negative = moves up
float h = -1.5;
// small value = more zoom
float f = 3;

// // more negative = moves right
// float w = -0.87;
// // more negative = moves up
// float h = -0.27;
// // small value = more zoom
// float f = 0.05;

void setup() {
  size(800, 800);
	background(0);
	noLoop();
}

void draw(){
  aMin= w;
  aMax = aMin + f;
  bMin = h;
  bMax = bMin + f;

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
        if(y%4==0){
          float absRatio = y * z.absoluteValue() / c.absoluteValue();
          stroke(absRatio/1, absRatio/1, absRatio/10);
        }
        else if(y%3==0){
          float absRatio = y * z.absoluteValue() / c.absoluteValue();
          stroke(absRatio/1, absRatio/10, absRatio/10);
        }
        else{
          float absRatio = y * z.absoluteValue() / c.absoluteValue();
          stroke(absRatio/10, absRatio/1, absRatio/1);
        }

      }else{
        if(row%4 == 0){
          float shade = 20*(float(row)/200)*255;
          stroke( shade/2, shade/2, shade/20 );
        }
        else if(row%3 == 0){
          float shade = 20*(float(row)/200)*255;
          stroke( shade/2, shade/20, shade/2 );
        } 
        else{
          float shade = 20*(float(row)/200)*255;
          stroke( shade/20, shade/2, shade/2 );
        }
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