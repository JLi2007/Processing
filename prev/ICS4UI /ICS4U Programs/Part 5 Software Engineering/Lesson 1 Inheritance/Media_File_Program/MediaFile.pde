class MediaFile { //the superclass

  //These are the 4 fields that are common to both Songs and Movies 
  String title;  
  String genre;  
  String duration;
  int rating;

  MediaFile( String t, String g, String l, int r ) {
    this.title = t;
    this.genre = g;
    this.duration = l;
    this.rating = r;
  }

  void describe() {
    println("****************");
    println("Title: " + this.title);
    println("Genre: " + this.genre);
    println("Length: " + this.duration);
    println("Rating: " + this.rating + " stars");
  }
}
