int maxLevel = 5; //xInit.length + 1;
float reductionFactor = 0.6;
float speedIncreaseFactor = 1.1;
float dt = 0.1;

float[] xInit = new float[maxLevel-1]; //{0.25, 0.25, 0.25, 0.25};
float[] yInit = new float[maxLevel-1];
float[] xSpeeds = new float[maxLevel-1];
float[] ySpeeds = new float[maxLevel-1];
float[] t = new float[maxLevel-1];
color[] colors = {color(100,0,155), color(255, 220, 220), color(0,0,20), color(255,255,0), color(140,0,0), 
color(255), color(0), color(120, 255, 40), color(255,140, 50)};


void setup() {
  size(700, 700);
  noStroke();
  
  setInitialValues();
}


void draw() {
  background(255,120,0);
  int level = min(maxLevel, 9);
  dsf( level, 50, 50, 600);
}


void dsf(int n, float x1, float y1, float s1) {
  fill( colors[maxLevel-n]);

  square(x1, y1, s1);

  if ( n > 1) {
    int i = maxLevel - n;
    float x2 = x1 + xInit[i]*s1 + xSpeeds[i]*t[i];
    float y2 = y1 + yInit[i]*s1 + ySpeeds[i]*t[i];
    float s2 = s1 * reductionFactor;
    boolean collision = false;

    if ( x2 + s2 > x1 + s1 ) {
      xSpeeds[i] *= -1;
      xInit[i] = (s1-s2)/s1;
      yInit[i] = (y2-y1)/s1;
      collision = true;
    }

    if ( x2 < x1  ) {
      xInit[i] = 0;
      yInit[i] = (y2-y1)/s1;
      xSpeeds[i] *= -1;
      collision = true;
    }

    if ( y2 +s2 > y1 + s1 ) {
      xInit[i] = (x2-x1)/s1;
      yInit[i] = (s1-s2)/s1;
      ySpeeds[i] *= -1;
      collision = true;
    }

    if ( y2 < y1  ) {
      xInit[i] = (x2-x1)/s1;
      yInit[i] = 0;
      ySpeeds[i] *= -1;
      collision = true;
    }

    if (collision) {
      t[i] = 0;
      dsf(n-1, x2, y2, s2);
    }
    else {
      t[i] += dt;
      dsf(n-1, x2, y2, s2);
    }

  }
}
