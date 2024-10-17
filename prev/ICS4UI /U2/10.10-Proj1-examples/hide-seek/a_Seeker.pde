class Seeker{
 String seekerName;
 String country;
 int medalsWon;
 float seekerHeight; // in metres
 int seekerIntelligence; // scale of 1-5
 ArrayList<Hider> hidersFound;

 
 Seeker(String n, String c, int m, float h, int i){
   this.seekerName = n;
   this.country = c;
   this.medalsWon = m;
   this.seekerHeight = h;
   this.seekerIntelligence = i;
   hidersFound = new ArrayList<Hider>();
 }
 
 void describe(){
   println("From", this.country, "here's", this.seekerName +"! This", this.seekerHeight + "m tall seeker has won", this.medalsWon, "medals so far in these games. Good luck,", this.seekerName +"!");
   println();
 }
 
 void startCounting(){
   println(this.seekerName, "starts counting. 100... \t 99... \t 98...");
   println();
 }
 
 void finishCounting(){
   println(this.seekerName + ": 3... \t 2... \t 1... \t Ready or not, here I come!");
 }
 
 void search(HidingSpot hs){
   for (int i = 0; i < hs.peopleInSpot.size(); i++){
     if (hs.peopleInSpot.get(i).eliminated == true){
       println(hs.peopleInSpot.get(i).hiderName, "was found immediately!");
       hidersFound.add(hs.peopleInSpot.get(i));
       hs.peopleInSpot.get(i).eliminated = true;
     }
   }
   println(this.seekerName, "walks over to", hs.spotName + ".");
   if (this.seekerIntelligence >= hs.spotCleverness){
     if (hs.peopleInSpot.size() > 0){
       for (int i = 0; i < hs.peopleInSpot.size(); i++){
         println(hs.peopleInSpot.get(i).hiderName, "was found!");
         hidersFound.add(hs.peopleInSpot.get(i));
         hs.peopleInSpot.get(i).eliminated = true;
       }
     }
     else{
       println("There was no one hiding in this spot.");
     }
     }
     else{
       println("Unfortunately,", this.seekerName, "was not clever enough to find anyone in this spot.");
     }
     println();
   }
 }
