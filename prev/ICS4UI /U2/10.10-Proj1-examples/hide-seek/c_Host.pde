class Host{
 String hostName;
 Seeker seeker;
 ArrayList<Hider> hiders;
 ArrayList<Hider> winners;

 
 Host(String n, Seeker s){
   this.hostName = n;
   this.seeker = s;
   hiders = new ArrayList<Hider>();
   winners = new ArrayList<Hider>();

 }

void describe(){
  println("Welcome to the 2020 International Hide and Seek Games! My name's", this.hostName, "and I'll be your host for this evening. Let's start by meeting our contestants:");
  println("------------------------------------------------------------------------------------");
}

void introduce(Hider h){
  hiders.add(h);
  h.describe();
}

void startGame(){
  println("------------------------------------------------------------------------------------");
  println("Let the games begin!");
  println("------------------------------------------------------------------------------------");
}

void recap(){
 println();
 println("Let's do a quick recap of who's hiding where for all our viewers at home. "); 
 println("------------------------------------------------------------------------------------");
}

void update(){
  println("------------------------------------------------------------------------------------");
  println("So far,", this.seeker.seekerName, "has found:");
  for (int i=0; i < this.seeker.hidersFound.size(); i++){
    println(this.seeker.hidersFound.get(i).hiderName);
  }
}

void findWinner(){
  println();
  for (int i = 0; i < hiders.size(); i++){
    if (hiders.get(i).eliminated == false){
      println(hiders.get(i).hiderName, "has not been found.");
      hiders.get(i).medalsWon ++;
      winners.add(hiders.get(i));
    }
  }
  println();
    if (winners.size()==0){
      println(this.seeker.seekerName, "has found all the hiders and is our winner today! Congratulations", this.seeker.seekerName + "!");
      this.seeker.medalsWon ++;
      println(this.seeker.seekerName, "has now won", this.seeker.medalsWon, "medals.");
    }
    else if (winners.size()==1){
      println(winners.get(0).hiderName, "is the only hider who was not found and is our winner today! Congratulations", winners.get(0).hiderName + "!");
      winners.get(0).medalsWon ++;
      println(winners.get(0).hiderName, "has now won", winners.get(0).medalsWon, "medals.");
    }
    else{
      println("We have a tie! Congratulations to our winners!");
      for (int j=0; j<winners.size();j++){
        println(winners.get(j).hiderName, "has now won", winners.get(j).medalsWon, "medals.");
      }
  
  }
}

void end(){
 println();
 println("That's all for today! Thanks for tuning in, and we'll see you next year at the International Hide and Seek Games!");
 println("------------------------------------------------------------------------------------");
} 
}
