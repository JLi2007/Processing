void drawCar(float x, float y, float angle){
  fill(255,0,0);
  
  pushMatrix();
  
  translate(x, y);
  rotate(angle);
  image(carImg, 0,0);
  
  popMatrix();
}


float getDerivative(float p1, float p2, float p3, float p4, float t) {
  float h = 0.1; 
  float f_of_t_plus_d = curvePoint(p1, p2, p3, p4, t + h );
  float f_of_t = curvePoint(p1, p2, p3, p4, t );
  
  return (f_of_t_plus_d - f_of_t) / h;
}


void resetCar() {
  dotNum = 0;
  t = 0.0;
}
