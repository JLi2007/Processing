class Playlist {

  //FIELDS OF THE PLAYLIST CLASS
  String title;
  ArrayList<Song> songs;
  String duration;
  

  //CONSTRUCTOR OF THE PLAYLIST CLASS
  Playlist( String t ) {
    this.title = t;
    this.songs = new ArrayList<Song>();
    this.duration = "0:00";
  }
  
  
  //METHODS OF THE PLAYLIST CLASS
  void printPlaylist() {      
    println("------------------------------------------------------------");
    println( this.title + ": " + this.songs.size() + " songs" + "\tTotal time: " + this.duration);
    println("------------------------------------------------------------");
    
    for ( Song s : this.songs ) 
      s.printInfo();         
    
    println();
  }
  
  
  void addSong( Song s ) {
    this.songs.add(s);
    this.duration = this.addTimes( this.duration, s.duration );
  } 
  
    
  String addTimes( String time1, String time2 ) {
    int colonIndex1 = time1.indexOf(":");
    int min1 = int( time1.substring( 0, colonIndex1 ) );
    int sec1 = int( time1.substring( colonIndex1 + 1 ) );
    
    int colonIndex2 = time2.indexOf(":");
    int min2 = int( time2.substring( 0, colonIndex2 ) );
    int sec2 = int( time2.substring( colonIndex2 + 1) );
    
    int totalMin = min1 + min2;
    int totalSec = sec1 + sec2;
    
    if( totalSec >= 60 ) {
      totalMin++;
      totalSec -= 60;
    }
    
    if( totalSec >= 10 )
      return totalMin + ":" + totalSec;
    
    else
      return totalMin + ":" + "0" + totalSec;
  }
}
