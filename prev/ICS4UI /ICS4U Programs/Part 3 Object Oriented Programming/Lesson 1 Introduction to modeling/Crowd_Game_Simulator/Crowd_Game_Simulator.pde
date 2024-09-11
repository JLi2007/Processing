//PARAMETERS. TRY CHANGING THESE
int n = 30;                             //Number of people
String gameMode = "brave";            //"cowardly", "brave", "stalker"
String initialPosition = "random";      //"random", "circle"

String targetPickingMode = "random";    //"random", "neighbour"
String friendPickingMode = "random";    //"random", "neighbour"
String enemyPickingMode = "random";     //"random", "neighbour"

boolean drawBalls = true;
int ballSize = 15;
float arrowLength = 50;
float k = 0.03;                       //Urgency level


//DON'T CHANGE THESE
PVector[] balls;
int[] targets, cowards, enemies, friends;
float xC, yC;
int xMin, yMin, xMax, yMax;


//MAIN PROGRAM
void setup() {
  size(800, 800);
  xMin = ballSize/2;
  yMin = xMin;
  xMax = width - xMin;
  yMax = height-yMin;
  
  background(0);
  fill(255);

  //ARRAYS
  balls = new PVector[n]; //POSITIONS OF THE BALLS
  targets = new int[n];  //INDICES OF THE PEOPLE EACH BALL CHOOSES
  enemies = new int[n];
  friends = new int[n];

  //SET BALL POSITIONS
  if ( initialPosition.equals("random") ) {
    for (int i=0; i<n; i++) {
      balls[i] = new PVector(random(0, width), random(0, height));
    }
  } 
  
  else if ( initialPosition.equals("circle") ) {
    float deltaTheta = 2*PI/n;
    float theta = 0;
    float xC = width/2, yC = height/2;
    float radius = 0.9*width/2;

    for (int i=0; i<n; i++) {
      balls[i] = new PVector(xC + radius*cos(theta), yC - radius*sin(theta));
      theta += deltaTheta;
    }
  }

  for (int i=0; i<n; i++) { //Ball i is the pursuer
    if ( gameMode.equals("stalker"))
      setTarget(i); //assigns a target ball to ball i

    else {  //assigns a friend and an enemy to ball i
      setFriend(i);
      setEnemy(i);
    }
  }
}


//USED ONLY IN STALKER MODE
void setTarget(int i) {
  int myTarget = 0;

  if (targetPickingMode.equals("random")) {
    myTarget = int( random(0, n-1) );
    while (myTarget == i) {
      myTarget = int( random(0, n-1) );
    }
  } 
  
  else if (targetPickingMode.equals("neighbour") ) {
    myTarget = (i+5) % n;
  }

  targets[i] = myTarget;
}


//USED ONLY IN BRAVE AND COWARDLY MODES
void setFriend(int i) {
  int myFriend = 0;
  
  if ( friendPickingMode.equals("random") ) {
    myFriend = int( random(0, n-1) );  //Picks a random index from 0...n-1
    
    while (myFriend == i) { //What is this while-loop doing?
      myFriend = int( random(0, n-1) );
    }
  } 
  
  else if (friendPickingMode.equals("neighbour")) {
    myFriend = max(n-1, i-1);
  }

  friends[i] = myFriend;
}


//USED ONLY IN BRAVE AND COWARDLY MODES
void setEnemy(int i) {
  int myenemy = 0;
  
  if ( enemyPickingMode.equals("random") ) {
    myenemy = (int) random(0, n-1);
    
    if ( gameMode.equals("brave") ) {
      while (myenemy == i) {
        myenemy = (int) random(0, n-1);
      }
    } 
  }
  
  else  if ( enemyPickingMode.equals("neighbour") ) {
    myenemy = (i+1)%n;
  }

  enemies[i] = myenemy;
}


void draw() {
  background(0);
  int t;
  float xGoal, yGoal, deltaX, deltaY;
  float dx, dy, ds, dxa, dya, scale;
  

  //DRAWS THE BALLS
  if(drawBalls) {
    for(int i = 0; i < n; i++) {
      stroke(255);
      circle(balls[i].x, balls[i].y, ballSize);
    }
  }

  if ( gameMode.equals("stalker") ) {  
    stroke(255, 0, 0);
    strokeWeight(3);
    for (int i = 0; i < n; i++) { //DRAWS THE ARROWS IN STALKER MODE
      t = targets[i];
      dx = balls[t].x - balls[i].x;
      dy = balls[t].y - balls[i].y;
      ds = dist(balls[i].x, balls[i].y, balls[t].x, balls[t].y);
      scale = min(1, arrowLength/ds);
      dxa = scale * dx;
      dya = scale * dy;
      
      line(balls[i].x, balls[i].y, balls[i].x + dxa, balls[i].y + dya);
    }
    strokeWeight(1);

    for(int i = 0; i < n; i++) { //CALCULATES THE NEW POSITIONS OF EACH BALL. CAN YOU SEE WHAT THESE FORMULAS ARE DOING? 
      t = targets[i];
      balls[i].x += (balls[ t ].x - balls[i].x)*k;
      balls[i].y += (balls[ t ].y - balls[i].y)*k;
    }
  } 
  
  else if ( gameMode.equals("brave")) {  //CALCULATES THE NEW POSITIONS OF EACH BALL.  CAN YOU SEE WHAT THESE FORMULAS ARE DOING? 
    for (int i = 0; i < n; i++) {
      int f = friends[i];
      int v = enemies[i];

      xGoal = (balls[f].x + balls[v].x) / 2;
      yGoal = (balls[f].y + balls[v].y) / 2;

      deltaX = (xGoal - balls[i].x) * k;
      deltaY = (yGoal - balls[i].y) * k;

      balls[i].x = max(xMin, min(xMax, balls[i].x + deltaX)); //What's the purpose of the max and min?
      balls[i].y = max(yMin, min(yMax, balls[i].y + deltaY));
    }
  } 
  
  else if ( gameMode.equals("cowardly") ) {
    for (int i = 0; i < n; i++) {
      int f = friends[i];
      int v = enemies[i];

      xGoal = 2*balls[f].x - balls[v].x;
      yGoal = 2*balls[f].y - balls[v].y;

      deltaX = (xGoal - balls[i].x)*k;
      deltaY = (yGoal - balls[i].y)*k;

      balls[i].x = max(xMin, min(xMax, balls[i].x + deltaX));
      balls[i].y = max(yMin, min(yMax, balls[i].y + deltaY));
    }
  }
}
