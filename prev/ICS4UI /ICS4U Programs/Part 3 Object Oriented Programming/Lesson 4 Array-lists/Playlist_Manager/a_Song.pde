class Song {
  //FIELDS
  String title;
  String artist;
  int starRating; 
  String duration; //"3:42"
  int numPlays; 


  //CONSTRUCTOR
  Song( String t, String a, int stars, String d ) {
    this.title = padTitle(t, 30);  //What does padTitle do?
    this.artist = padTitle(a, 25);
    this.starRating = stars;
    this.duration = d;
    this.numPlays = 0;  
  }


  //METHODS OF THE SONG CLASS
  void printInfo() {
    String starOutput = "";

    for (int i = 0; i < this.starRating; i++) 
      starOutput += "*";
      
    if( starOutput.equals("") )
      starOutput = "no stars";
    
    println( this.title + "\t" + " by " + this.artist + "\t" + this.duration + "\t" + starOutput + "\t played " + this.numPlays + " times");
  }


  void play() {
    this.numPlays++;
    //code for actually playing the song over the device's speakers would go here
  }
  
  
  String padTitle( String t, int maxLen ) {
    while( t.length() < maxLen ) {
      t += " ";
    }
    
    return t;
  }
}
