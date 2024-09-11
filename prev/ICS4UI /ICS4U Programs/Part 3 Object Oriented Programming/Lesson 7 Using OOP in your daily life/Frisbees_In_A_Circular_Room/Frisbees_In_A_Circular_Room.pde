boolean T = true, F = false;
float deltaT = 0.01;
float t = 0;
color frisbeeCol = color(255, 255, 0);
color circleCol = color(200, 200, 255);
float xC, yC;
ArrayList<Demo> demos = new ArrayList<Demo>();
int j = 0;  //demo number
int demoFrameCount = 0;
PFont f;
boolean paused = false;
color lineCol2 = color(0,255,100);
boolean save = false;

void setup() {
  size(700, 700);
  xC = width/2;
  yC = height/2;
  
                  /*   label   n  dots  circles  rotateSpd  size  phaseShift  outerRing  duration   speed  switch  altDir  showInner  greenLines  */
  demos.add( new Demo( "a",   3,  T,    T,       2.5,         0.25, 0,          T,         628,       3.0,   F,      1,      F,         0) );
  demos.add( new Demo( "b",   90,  T,    T,       0,         0.10, 5,          T,        628,       2.2,   F,      1,      F,         0) );
  demos.add( new Demo( "c",   8,  F,    F,       3,         0.29, 0,          F,         628,       1.5,   F,      1,      F,         1) );
  demos.add( new Demo( "e",  24,  F,    F,       2,         0.35, 0,          T,         628,       1.5,   F,      1,      F,         0) );
  demos.add( new Demo( "g",  32,  F,    T,       3,         0.3,  0,          F,         628,       1.5,   F,      1,      F,         0) );
  demos.add( new Demo( "h",  16,  T,    T,       4,         0.2,  0,          F,         628,       1.5,   F,      -1,     F,         1) );
  demos.add( new Demo( "i",  24,  T,    F,       2,         0.5,  0,          F,         628,       1.5,   F,      -1,     F,         0) );
  demos.add( new Demo( "j",  48,  F,    F,       2,         0.2,  0,          F,         628,       1.5,   F,      -1,     T,         0) );
  demos.add( new Demo( "k",  80,  F,    F,       5,         0.1,  0.5,        F,         628,       1.0,   F,      1,      F,         1) );
  demos.add( new Demo( "l",  60,  F,    T,      10,         0.05, 1,          T,         628,       1.5,   F,      1,      F,         0) );
  demos.add( new Demo( "m",  30,  F,    F,      10,         0.09, 1,          F,         628*2,     1.5,   T,      1,      F,         1) );
  demos.add( new Demo( "n", 180,  F,    F,       1,         0.1,  3,          F,         628,       1.5,   F,      1,      F,         0) );
  demos.add( new Demo( "o", 180,  F,    F,       2,         0.1,  3,          F,         628*2,     1.5,   T,      -1,     F,         0) );
  demos.add( new Demo( "p", 240,  F,    F,       2,         0.1,  2,          F,         628,       1.5,   T,       1,     F,         0) );
  demos.add( new Demo( "q", 480,  F,    F,       1,         0.2,  4.9,        F,         628,       3.0,   F,       1,     F,         0) );
  demos.add( new Demo( "r", 480,  F,    F,       1,         0.5,  5,          F,         628,       3.0,   T,       1,     F,         0) );
}


void draw() {
  background(0);
  //textFont(f);

  Demo d = demos.get(j);

  //fill(255);
  //text(d.label.toUpperCase(), 50, 80);
  noFill();

  if ( demoFrameCount <= d.numFrames ) {
    d.drawScene();
    if( frameCount > 20 ) {
      t += deltaT;
      demoFrameCount++;
      d.updatePositions();
    }
    
  } 
  
  else {
    if ( j < demos.size()-1 ) {
      j++;
      t = 0;
      demoFrameCount = 0;
    } 
    else
      exit();
  }
  
  if( save )
    saveFrame("frames/#####.jpeg");
}


void mouseClicked() {
  if ( paused ) 
    loop();

  else {
    noLoop();
    saveFrame("thumbnails/##.png");
  }

  paused = !paused;
}
