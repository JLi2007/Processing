class HidingSpot{
 String spotName;
 float spotHeight;
 int spotSize;
 ArrayList<Hider> peopleInSpot;
 int spotCleverness;
 
 HidingSpot(String n, float h, int s, int c){
   this.spotName = n;
   this.spotHeight = h;
   this.spotSize = s;
   this.spotCleverness = c;
   peopleInSpot = new ArrayList<Hider>();
 }
 
 void checkHiders( Hider h ){
   h.hidingSpot.peopleInSpot.add(h);
    if (peopleInSpot.size() < this.spotSize){
     if (h.hiderHeight <= this.spotHeight){
       if (h.hiderIntelligence >= this.spotCleverness){
         h.hidingSpot.peopleInSpot.remove(h);
         peopleInSpot.add(h); 
         h.hidingSpot = this;
         println(h.hiderName, "has hidden", this.spotName);
       }
       else{
         println(h.hiderName, "went to hide", this.spotName, "but was not clever enough to discover this great spot.");
       }
     }
     else{
       println(h.hiderName, "tried to hide", this.spotName, "but they were too tall and couldn't fit. Try another spot,", h.hiderName + "!");
     }
    }
   else{
      println(h.hiderName, "tried to hide", this.spotName, "but there was not enough space because too many people were already there. Try another spot,", h.hiderName);
    }
 }
 
 void printHiders(){
    if (this.spotCleverness == 0){
     for (int i = 0; i < peopleInSpot.size(); i++){
       if (peopleInSpot.get(i).hidingSpot.spotName == "none"){
         println(peopleInSpot.get(i).hiderName, "could not find a spot in time and was eliminated immediately.");
         peopleInSpot.get(i).eliminated = true;
         println();
         println("------------------------------------------------------------------------------------");

       }
     }     
   }
   else{
     if (peopleInSpot.size() == 0){
       println("There is no one hiding", this.spotName);
       println();
     }
     else{
       println("People hiding", this.spotName + ":");
       for (int i = 0; i < peopleInSpot.size(); i++){
         Hider h = peopleInSpot.get(i);
         println(h.hiderName);
       }
       println();
     }
   }
 }
}
