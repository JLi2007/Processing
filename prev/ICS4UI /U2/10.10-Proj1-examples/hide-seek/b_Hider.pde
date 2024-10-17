class Hider{
 String hiderName;
 String country;
 int medalsWon;
 float hiderHeight; // in metres
 int hiderIntelligence; // scale of 1-5
 HidingSpot hidingSpot;
 boolean eliminated;

 
 Hider(String n, String c, int m, float h, int i, HidingSpot hs){
   this.hiderName = n;
   this.country = c;
   this.medalsWon = m;
   this.hiderHeight = h;
   this.hiderIntelligence = i;
   this.hidingSpot = hs;
   this.eliminated = false;
 }
 
 void describe(){
   println("From", this.country, "here's", this.hiderName +"! This", this.hiderHeight + "m tall hider has won", this.medalsWon, "medals so far in these games. Good luck,", this.hiderName +"!");
   println();
 }
 
 void hide(HidingSpot h){
   h.checkHiders(this);
 }
 
 void eliminated(){
   this.eliminated = true;
}
}
