class Point3D {
  float x, y, z;
    
  Point3D(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void drawBox() {
    pushMatrix();
    translate( this.x, this.y, this.z );
    box( boxSize ); 
    popMatrix();
  }
}
