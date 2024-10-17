class Weather {
  float weatherType;
  int n;
  PVector[] particles;
  
  Weather(float w) {
    this.weatherType = w;
    this.n = int(random(500, 1000));
    this.particles = createCoordinates();
  }
  
  PVector[] createCoordinates() {
    this.particles = new PVector[this.n];
    for (int i=0; i < n; i++) {
      if (this.weatherType == 2) {
        this.particles[i] = new PVector(random(0, 800), random(0, 100));

      }
      else {
        this.particles[i] = new PVector(random(0, 800), random(0, 800));
      }
    }
    return this.particles;
  }
  
  void animateWeather() {
    noStroke();
    
    if (this.weatherType == 0) {
      rain();
    }
    else if (this.weatherType == 1) { 
      snow();
    }
    else if (this.weatherType == 2) {
      star();
    }
    // If 3, it will continue to be sunny/normal
  }
  
  void star() {
    this.n = 100;
    for(int i=0; i<n; i++) {
      fill(255);
      circle(this.particles[i].x, this.particles[i].y, random(1, 5));
    }
  }
  
  void snow() {
    for(int i=0; i<n; i++) {
      fill(255);
      circle(this.particles[i].x, this.particles[i].y, 3);
      this.particles[i].add(random(1, 2), random(1, 3));
      
      if (this.particles[i].x >= 800) {
        this.particles[i].x = 0;
      }
      if (this.particles[i].y >= 800) {
        this.particles[i].y = 0;
      }
    }
  }
  
  void rain() {
    for(int i=0; i<n; i++) {
      float x = random(1, 2);
      float y = random(1, 20);
      
      fill(0, 0, 200);
      ellipse(this.particles[i].x, this.particles[i].y, x, y);
      this.particles[i].add(x, y);
      
      if (this.particles[i].x >= 800) {
        this.particles[i].x = 0;
      }
      if (this.particles[i].y >= 800) {
        this.particles[i].y = 0;
      }
    }
  }
}
