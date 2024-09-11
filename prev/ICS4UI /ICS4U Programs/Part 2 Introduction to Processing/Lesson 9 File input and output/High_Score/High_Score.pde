PrintWriter pw;
int yourMoney;
String gameInstructions = "Type r to roll, s to stop & keep your winnings, q to quit";

void setup() {
  size(900,400);
  background(0);
  PFont myFont = loadFont("Arial-Black-18.vlw");
  textFont( myFont );
  stroke(255);
  startGame();
}


void startGame() {
  text(gameInstructions, 50,100);
  yourMoney = 500;
}


void draw() {}


void keyPressed(){
  background(0);
  
  if (yourMoney > 0) {
    
    if( key == 'r' || key == 'R' ){
      int dieRoll = int( random(1,6) );
      
      if (dieRoll >= 4) {
        yourMoney *= 2;      
        text("You doubled your money! You have $" + yourMoney, 50, 200);
        text(gameInstructions, 50, 100);
      }
      
      else {
        yourMoney -= 100;
        text("You lost $100! You have $" + yourMoney, 50, 200);
        text(gameInstructions, 50, 100);
      }
    }
    
    else if( key == 'q' ) {
      text("Bye! Check the high score file to see if you set a new record", 50, 200);
      updateHighScore();
    }
  }
  
  else {
    text("You went bust!", 50,200);
  }
}


void updateHighScore() {
  String[] lines = loadStrings("high score.txt");
  int currentHighScore = int( lines[0] );
  
  if (yourMoney > currentHighScore) {
    println("New high score!");
    pw = createWriter("data/high score.txt");
    pw.print( yourMoney );
    pw.close();
  }
}
